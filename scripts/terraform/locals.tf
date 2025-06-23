locals {
  // you need to specify a unique name under a tenant according to the business, which will be used as part of the resource name
  app_id = format("%s-%s", "app", formatdate("hhmm", timestamp()))

  name_suffix = "mkp"

  // Tags of HUAWEI CLOUD resources. You can add tags to resources to classify resources.
  // for more details, please refer to https://support.huaweicloud.com/usermanual-tms/zh-cn_topic_0056266263.html
  tags = { Purpose = "MkpApplication" }



  # Configuration of the ECS memory size and number of cores
  # instance_flavor_cpu    = 4
  # instance_flavor_memory = 16
  #  通用计算增强型
  instance_performance_type = "kunpeng_computing"
  # 系统盘: 通用SSD
  ecs_volume_type = "GPSSD"

  # 规格：通用入门型
  #ecs_flavor = "kc1.xlarge.4"

  // Billing model for cloud resources, You need to modify it according to your actual situation.
  // In the development and testing phase, pay-per-use billing is recommended.
  // You can also set these three parameters as variables, allowing users to select at deployment time.
  charging_mode = var.charging_mode
  period_unit   = var.period_unit
  period        = var.period

  // The billing model for bandwidth, You need to modify it according to your actual situation.
  publicip_type         = "5_bgp"     # 全动态
  bandwidth_share_type  = "PER"       # 独享带宽
  bandwidth_charge_mode = "bandwidth" # 按带宽计费
  bandwidth_size        = 10          # 带宽大小

  # Image information in different regions, you need to enter your own image ID or add another region.
  # For Marketplace Image Id,you can log in to Seller Console, view the marketplace image id on Product Specifications section of My Products detail page.
  # 镜像版本：
  #NATS2.10.20-HCE2.0
  instance_image_id_maps_v1 = {
#     北京4
    cn-north-4     = "7b6c3b8a-5d90-4d97-81c5-392c152e0fc4"
#     广州
    cn-south-1     = "77de7bb5-6c71-4ae5-af8a-6a8f3183b72a"
#     上海一
    cn-east-3      = "a756d7f2-1f86-475c-ae1d-fac623d530c9"
#     乌兰察布一
    cn-north-9     = "e20796e2-86be-444e-bf6d-bc27ce9c4727"
#     贵阳一
    cn-southwest-2 = "6e97c63c-0dad-4471-9386-d923804cea31"

  }
  #NATS2.10.20-Ubuntu24.04
  instance_image_id_maps_v2 = {
#     北京4
    cn-north-4     = "8e98f8c6-98b2-4825-9426-8b51cd5bb868"
#     广州
    cn-south-1     = "74eeeada-8b24-447c-9e7c-2b51a91adefc"
#     上海一
    cn-east-3      = "8fba9abd-d2d6-4393-960e-d11d4c2bfbd3"
#     乌兰察布一
    cn-north-9     = "bfc5fd11-b538-4a18-b64e-adc73f2843a1"
#     贵阳一
    cn-southwest-2 = "ee32474e-cde4-4d27-9446-70ebe470d52e"

  }  
  # # 其他版本增加（注意修改var参数和镜像的版本的判断部分）
  #  instance_image_id_maps = {
  #   #     北京4
  #   cn-north-4 = ""
  #  }  

  # Specifies the DNS server address list of a subnet. For details about the private DNS address, see https://support.huaweicloud.com/dns_faq/dns_faq_002.html#?
  subnet_dns_list_maps = {
    cn-north-4     = ["100.125.1.250", "100.125.129.250"]
    cn-south-1     = ["100.125.1.250", "100.125.136.29"]
    cn-east-3      = ["100.125.1.250", "100.125.64.250"]
    cn-north-9     = ["100.125.1.250", "100.125.107.250"]
    cn-southwest-2 = ["100.125.1.250", "100.125.129.250"]
  }


}