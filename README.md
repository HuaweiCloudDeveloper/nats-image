<p align="center">
  <h1 align="center">NATS Cloud-native messaging system</h1>
  <p align="center">
    <a href="README.md"><strong>English</strong></a> | <strong>简体中文</strong>
  </p>
</p>

## Table of Contents

- [Repository Introduction](#repository-introduction)
- [Prerequisites](#prerequisites)
- [Image Specifications](#image-specifications)
- [Getting Help](#getting-help)
- [How to Contribute](#how-to-contribute)

## Repository Introduction
‌[NATS‌](https://github.com/nats-io/nats-server) NATS is an open source, lightweight, high performance cloud-native messaging system developed and maintained by Synadia. It is designed for modern distributed systems, providing a simple API and extremely low latency, suitable for microservices, IoT, edge computing, and real-time messaging scenarios. NATS is also an incubation project of the CNCF (Cloud Native Computing Foundation).

**Core Features:**
1. High-performance messaging: NATS uses a pure text protocol (or an optimized binary protocol version), supporting millions of messages per second with latency as low as microseconds. A single server can handle 12-15MB/s message traffic, with linear performance scaling in cluster mode.
2. Lightweight architecture: No external dependencies, runs with a single binary file, and has extremely low memory usage (typically <20MB). Supports containerized deployment, suitable for edge computing and resource-constrained environments.
3. Multiple communication modes: Publish/Subscribe (Pub-Sub): one-to-many broadcasting, supports subject hierarchy (e.g., orders.>``orders.europe.*). Request/Reply: synchronous communication based on temporary subjects, similar to RPC. Queue Groups: multiple subscribers share load, automatic message distribution (competitive consumer mode).
4. Persistence and streaming (JetStream): provides message persistence, at least once/precise once delivery, streaming (Stream), and consumer (Consumer) management. Supports message replay, TTL, storage quota policies (memory/disk).
5. Dynamic scaling and clustering: supports automatic mesh clustering (Gossip protocol), nodes can dynamically join/leave. Data sharding through subject routing, no central bottleneck, suitable for horizontal scaling.
6. Security control: transport encryption based on TLS/SSL. Multi-tenancy support (account isolation). Fine-grained permission control (defining user/role permissions through NKEY or JWT).
7. Multi-language and protocol compatibility: provides over 30 official clients including Go, Java, Python, supports WebSocket, HTTP/2 protocols. Compatible with cloud-native ecosystems (e.g., Kubernetes, Prometheus monitoring integration).
8. Agentless architecture (NATS 2.0+): achieves cross-region communication through a supercluster, no additional proxy gateway required, supports hybrid cloud deployment.
9. Simple and flexible subject routing: wildcard subjects (* matches single level, > matches multiple levels) for flexible message routing, no need to pre-configure exchanges or queues.
10. Real-time monitoring and management: built-in nats-server --monitoring provides Prometheus metrics endpoints, supports visual monitoring (e.g., NATS Surveyor tool).

This project offers pre-configured [**`NATS-Cloud-native messaging system`**]()，images with NATS and its runtime environment pre-installed, along with deployment templates. Follow the guide to enjoy an "out-of-the-box" experience.

**Architecture Design:**

![](./images/img.png)

> **System Requirements:**
> - CPU: 4vCPUs or higher
> - RAM: 16GB or more
> - Disk: At least 50GB

## Prerequisites
[Register a Huawei account and activate Huawei Cloud](https://support.huaweicloud.com/usermanual-account/account_id_001.html)

## Image Specifications

| Image Version          | Description | Notes |
|------------------------| --- | --- |
| [NATS2.10.20-arm-v1.0]() | Deployed on Kunpeng servers with Huawei Cloud EulerOS 2.0 64bit |  |

## Getting Help
- Submit an [issue](https://github.com/HuaweiCloudDeveloper/nats-image/issues)
- Contact Huawei Cloud Marketplace product support

## How to Contribute
- Fork this repository and submit a merge request.
- Update README.md synchronously based on your open-source mirror information.