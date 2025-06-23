#!/bin/bash

# NATS安装脚本 (使用官方curl | sh方式)
# 适用于ARM架构的EulerOS 2.0和Ubuntu 24.04
# 版本: 1.2
# 作者: DeepSeek Chat

# 检查root权限
if [ "$(id -u)" -ne 0 ]; then
    echo "请使用root用户或通过sudo运行此脚本"
    exit 1
fi

# 设置NATS版本
NATS_VERSION="v2.10.20"

# 安装函数
install_nats() {
    echo "正在安装NATS服务器 ${NATS_VERSION}..."
    
    # 创建nats用户和组
    if ! id -u nats >/dev/null 2>&1; then
        echo "创建nats用户和组..."
        if ! groupadd --system nats; then
            echo "创建nats组失败"
            exit 1
        fi
        if ! useradd --system -g nats -s /bin/false -d /var/lib/nats nats; then
            echo "创建nats用户失败"
            exit 1
        fi
    fi

    # 使用官方推荐方式安装
    echo "下载并安装NATS服务器..."
    if ! curl -sf https://binaries.nats.dev/nats-io/nats-server/v2@${NATS_VERSION} | sh; then
        echo "NATS安装失败"
        exit 1
    fi
    
    # 移动二进制文件到标准位置
    echo "设置NATS二进制文件位置..."
    if ! mv nats-server /usr/sbin/; then
        echo "移动nats-server二进制文件失败"
        exit 1
    fi
    chmod 755 /usr/sbin/nats-server
    chown nats:nats /usr/sbin/nats-server
    
    # 创建配置目录和文件
    echo "创建配置目录..."
    mkdir -p /etc/nats-server
    chown -R nats:nats /etc/nats-server
    
    # 获取当前主机名
    CURRENT_HOSTNAME=$(hostname)
    
    # 创建默认配置文件
    echo "创建配置文件..."
    cat > /etc/nats-server.conf <<EOF
# NATS服务器默认配置
port: 4222
http_port: 8222

server_name: "$CURRENT_HOSTNAME"

# 日志选项
debug: false
trace: false
logtime: true

# 授权选项 (根据需要取消注释)
# authorization {
#   users = [
#     {user: "admin", password: "password"}
#   ]
# }

# JetStream配置 (根据需要取消注释)
# jetstream {
#   store_dir: "/var/lib/nats/jetstream"
#   # max_memory: 1G
#   # max_storage: 10G
# }
EOF
    
    # 创建数据目录
    echo "创建数据目录..."
    mkdir -p /var/lib/nats
    chown -R nats:nats /var/lib/nats
    
    # 创建systemd服务文件
    echo "创建systemd服务..."
    cat > /usr/lib/systemd/system/nats-server.service <<EOF
[Unit]
Description=NATS Server
After=network-online.target ntp.service
Wants=network-online.target

[Service]
PrivateTmp=true
Type=simple
ExecStart=/usr/sbin/nats-server -c /etc/nats-server.conf
ExecReload=/bin/kill -s HUP \$MAINPID
ExecStop=/bin/kill -s SIGUSR2 \$MAINPID
TimeoutStopSec=150
Restart=on-failure
RestartSec=5s
User=nats
Group=nats

# 安全加固
NoNewPrivileges=true
PrivateDevices=true
ProtectSystem=full
ProtectHome=true
ProtectKernelTunables=true
ProtectKernelModules=true
ProtectControlGroups=true
RestrictAddressFamilies=AF_UNIX AF_INET AF_INET6
RestrictNamespaces=true
RestrictRealtime=true
SystemCallFilter=@system-service
SystemCallArchitectures=native
MemoryDenyWriteExecute=true
LockPersonality=true

[Install]
WantedBy=multi-user.target
EOF
    
    # 安装NATS CLI工具
    echo "下载并安装NATS CLI工具..."
    
    # 使用tar.gz格式
    NATS_CLI_URL="https://github.com/nats-io/natscli/releases/download/v0.1.1/nats-0.1.1-linux-arm64.zip"
    
    echo "下载CLI工具..."
    if ! curl -L ${NATS_CLI_URL} -o ./nats.zip; then
        echo "下载NATS CLI工具失败"
        rm -rf ./nats-cli.tar.gz
        exit 1
    fi
    
    echo "解压CLI工具..."
    if ! unzip ./nats.zip -d /usr/local/bin/; then
        echo "解压NATS CLI工具失败"
        rm -rf ./nats.zip
        exit 1
    fi
    
    echo "安装CLI工具..."
    if [ ! -f "/usr/local/bin/nats-0.1.1-linux-arm64/nats" ]; then
        echo "找不到nats可执行文件"
        exit 1
    fi
    
    if ! mv /usr/local/bin/nats-0.1.1-linux-arm64/nats /usr/local/bin/; then
        echo "移动nats CLI工具失败"
        exit 1
    fi
    chmod 755 /usr/local/bin/nats
	
	# 启用并启动服务
    echo "启用并启动服务..."
    systemctl daemon-reload
    if ! systemctl enable nats-server; then
        echo "启用nats-server服务失败"
        exit 1
    fi
    
    if ! systemctl start nats-server; then
        echo "启动nats-server服务失败"
        journalctl -u nats-server -xe --no-pager | tail -n 50
        exit 1
    fi
    
    echo "NATS服务器安装完成!"
    echo "服务状态: systemctl status nats-server"
    echo "服务日志: journalctl -u nats-server -f"
    echo "配置文件: /etc/nats-server.conf"
    echo "数据目录: /var/lib/nats"
	
	echo "NATS CLI: nats --version"
	echo "连接 NATS：nats --server nats://localhost:4222"

}

# 执行安装
install_nats

exit 0