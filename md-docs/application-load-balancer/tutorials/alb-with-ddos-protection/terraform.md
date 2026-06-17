# Создание L7-балансировщика с защитой от DDoS с помощью Terraform


Чтобы создать балансировщик с защитой от DDoS c помощью Terraform:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Проверьте работу балансировщика](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для балансировщика с защитой от DDoS входят:

* плата за постоянно запущенные [ВМ](../../../compute/concepts/vm.md) ([тарифы Yandex Compute Cloud](../../../compute/pricing.md));
* плата за использование [публичного статического IP-адреса](../../../vpc/concepts/address.md#public-addresses) ([тарифы Yandex Virtual Private Cloud](../../../vpc/pricing.md));
* плата за фильтрацию входящего трафика на публичный IP-адрес с [защитой от DDoS-атак](../../../vpc/ddos-protection/index.md) ([тарифы Yandex Virtual Private Cloud](../../../vpc/pricing.md#prices-ddos-protection));
* плата за использование вычислительных ресурсов [L7-балансировщика](../../concepts/index.md) ([тарифы Application Load Balancer](../../pricing.md)).


## Создайте инфраструктуру {#deploy}

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

Чтобы создать инфраструктуру с помощью Terraform:

1. [Установите Terraform](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера Yandex Cloud (раздел [Настройте провайдер](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файл с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовая конфигурация {#ready}

     1. Склонируйте репозиторий с конфигурационными файлами:

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-alb-ddos-protection.git
        ```

     1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
        * `alb-with-ddos-protection.tf` — конфигурация создаваемой инфраструктуры.
        * `alb-with-ddos-protection.auto.tfvars` — пользовательские данные.

   - Вручную {#manual}

     1. Создайте папку для файла с описанием инфраструктуры.
     1. Создайте в папке конфигурационный файл `alb-with-ddos-protection.tf`:

        {% cut "alb-with-ddos-protection.tf" %}

        ```hcl
        variable "folder_id" {
          type = string
        }
        
        variable "vm_user" {
          type = string
        }
        
        variable "ssh_key_path" {
          type = string
        }
        
        locals {
          network_name     = "ddos-network"
          subnet_name1     = "subnet-1"
          subnet_name2     = "subnet-2"
          sa_name          = "ig-sa"
          sg_balancer_name = "ddos-sg-balancer"
          sg_vm_name       = "ddos-sg-vms"
          vm_name          = "ddos-group"
          tg_name          = "tg-ddos"
          address_name     = "ddos-addr"
          abg_name         = "ddos-backend-group"
          backend_name     = "backend-1"
          router_name      = "ddos-router"
          vh_name          = "ddos-host"
          authority_domain = ["alb-with-ddos.com"]
          route_name       = "route-1"
          alb_name         = "ddos-protect-alb"
          listener_name    = "ddos-listener"
        }
        
        terraform {
          required_providers {
            yandex = {
              source  = "yandex-cloud/yandex"
              version = ">= 0.47.0"
            }
          }
        }
        
        provider "yandex" {
          folder_id = var.folder_id
        }
        
        resource "yandex_iam_service_account" "ig-sa" {
          name = local.sa_name
        }
        
        resource "yandex_resourcemanager_folder_iam_member" "editor" {
          folder_id = var.folder_id
          role      = "editor"
          member    = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
        }
        
        resource "yandex_vpc_network" "ddos-network" {
          name = local.network_name
        }
        
        resource "yandex_vpc_subnet" "subnet-1" {
          name           = local.subnet_name1
          zone           = "ru-central1-a"
          network_id     = yandex_vpc_network.ddos-network.id
          v4_cidr_blocks = ["192.168.1.0/24"]
        }
        
        resource "yandex_vpc_subnet" "subnet-2" {
          name           = local.subnet_name2
          zone           = "ru-central1-b"
          network_id     = yandex_vpc_network.ddos-network.id
          v4_cidr_blocks = ["192.168.2.0/24"]
        }
        
        resource "yandex_vpc_security_group" "ddos-sg-balancer" {
          name       = local.sg_balancer_name
          network_id = yandex_vpc_network.ddos-network.id
        
          egress {
            protocol       = "ANY"
            description    = "any"
            v4_cidr_blocks = ["0.0.0.0/0"]
          }
        
          ingress {
            protocol       = "TCP"
            description    = "ext-http"
            v4_cidr_blocks = ["0.0.0.0/0"]
            port           = 80
          }
        
          ingress {
            protocol       = "TCP"
            description    = "ext-https"
            v4_cidr_blocks = ["0.0.0.0/0"]
            port           = 443
          }
        
          ingress {
            protocol          = "TCP"
            description       = "healthchecks"
            predefined_target = "loadbalancer_healthchecks"
            port              = 30080
          }
        }
        
        resource "yandex_vpc_security_group" "ddos-sg-vms" {
          name       = local.sg_vm_name
          network_id = yandex_vpc_network.ddos-network.id
        
          ingress {
            protocol          = "TCP"
            description       = "balancer"
            security_group_id = yandex_vpc_security_group.ddos-sg-balancer.id
            port              = 80
          }
        
          ingress {
            protocol       = "TCP"
            description    = "ssh"
            v4_cidr_blocks = ["0.0.0.0/0"]
            port           = 22
          }
        }
        
        resource "yandex_compute_image" "lemp" {
          source_family = "lemp"
        }
        
        resource "yandex_compute_instance_group" "ddos-group" {
          name               = local.vm_name
          folder_id          = var.folder_id
          service_account_id = yandex_iam_service_account.ig-sa.id
          instance_template {
            platform_id        = "standard-v2"
            service_account_id = yandex_iam_service_account.ig-sa.id
            resources {
              core_fraction = 5
              memory        = 1
              cores         = 2
            }
        
            boot_disk {
              mode = "READ_WRITE"
              initialize_params {
                image_id = yandex_compute_image.lemp.id
                type     = "network-hdd"
                size     = 3
              }
            }
        
            network_interface {
              network_id         = yandex_vpc_network.ddos-network.id
              subnet_ids         = [yandex_vpc_subnet.subnet-1.id,yandex_vpc_subnet.subnet-2.id]
              nat                = true
              security_group_ids = [yandex_vpc_security_group.ddos-sg-vms.id]
            }
        
            metadata = {
              user-data = "#cloud-config\nusers:\n  - name: ${var.vm_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("${var.ssh_key_path}")}"
            }
          }
        
          scale_policy {
            fixed_scale {
              size = 2
            }
          }
        
          allocation_policy {
            zones = ["ru-central1-a", "ru-central1-b"]
          }
        
          deploy_policy {
            max_unavailable = 1
            max_expansion   = 0
          }
        
          application_load_balancer {
            target_group_name = local.tg_name
          }
        }
        
        resource "yandex_vpc_address" "ddos-addr" {
          name = local.address_name
        
          external_ipv4_address {
            zone_id                  = "ru-central1-a"
            ddos_protection_provider = "qrator"
          }
        }
        
        resource "yandex_alb_backend_group" "ddos-backend-group" {
          name = local.abg_name
        
          http_backend {
            name             = local.backend_name
            port             = 80
            target_group_ids = [yandex_compute_instance_group.ddos-group.application_load_balancer.0.target_group_id]
            healthcheck {
              timeout          = "10s"
              interval         = "2s"
              healthcheck_port = 80
              http_healthcheck {
                path = "/"
              }
            }
          }
        }
        
        resource "yandex_alb_http_router" "ddos-router" {
          name   = local.router_name
        }
        
        resource "yandex_alb_virtual_host" "ddos-host" {
          name           = local.vh_name
          http_router_id = yandex_alb_http_router.ddos-router.id
          authority      = local.authority_domain
          route {
            name = local.route_name
            http_route {
              http_route_action {
                backend_group_id = yandex_alb_backend_group.ddos-backend-group.id
              }
            }
          }
        }
        
        resource "yandex_alb_load_balancer" "ddos-protect-alb" {
          name               = local.alb_name
          network_id         = yandex_vpc_network.ddos-network.id
          security_group_ids = [yandex_vpc_security_group.ddos-sg-balancer.id]
        
          allocation_policy {
            location {
              zone_id   = "ru-central1-a"
              subnet_id = yandex_vpc_subnet.subnet-1.id
            }
        
            location {
              zone_id   = "ru-central1-b"
              subnet_id = yandex_vpc_subnet.subnet-2.id
            }
          }
        
          listener {
            name = local.listener_name
            endpoint {
              address {
                external_ipv4_address {
                  address = yandex_vpc_address.ddos-addr.external_ipv4_address[0].address
                }
              }
              ports = [ 80 ]
            }
            http {
              handler {
                http_router_id = yandex_alb_http_router.ddos-router.id
              }
            }
          }
        }
        ```

        {% endcut %}

     1. Создайте в папке файл с пользовательскими данными `alb-with-ddos-protection.auto.tfvars`:

        {% cut "alb-with-ddos-protection.auto.tfvars" %}

        ```hcl
        folder_id    = "<идентификатор_каталога>"
        vm_user      = "<имя_пользователя_ВМ>"
        ssh_key_path = "<путь_к_публичному_SSH-ключу>"
        ```

        {% endcut %}

   {% endlist %}

   Более подробную информацию о параметрах используемых ресурсов в Terraform см. в документации провайдера:

   * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account](../../../terraform/resources/iam_service_account.md)
   * [Роль](../../../iam/concepts/access-control/roles.md) — [yandex_resourcemanager_folder_iam_member](../../../terraform/resources/resourcemanager_folder_iam_member.md)
   * [Сеть](../../../vpc/concepts/network.md#network) — [yandex_vpc_network](../../../terraform/resources/vpc_network.md).
   * [Подсети](../../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet](../../../terraform/resources/vpc_subnet.md).
   * [Группы безопасности](../../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group](../../../terraform/resources/vpc_security_group.md).
   * [Образ](../../../compute/concepts/image.md) — [yandex_compute_image](../../../terraform/resources/compute_image.md).
   * [Группа ВМ](../../../compute/concepts/instance-groups/index.md) — [yandex_compute_instance_group](../../../terraform/resources/compute_instance_group.md).
   * [Статический публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses) — [yandex_vpc_address](../../../terraform/resources/vpc_address.md).
   * [Группа бэкендов](../../concepts/backend-group.md) — [yandex_alb_backend_group](../../../terraform/resources/alb_backend_group.md).
   * [HTTP-роутер](../../concepts/http-router.md) — [yandex_alb_http_router](../../../terraform/resources/alb_http_router.md).
   * [Виртуальный хост](../../concepts/http-router.md#virtual-host) — [yandex_alb_virtual_host](../../../terraform/resources/alb_virtual_host.md).
   * [L7-балансировщик](../../concepts/application-load-balancer.md) — [yandex_alb_load_balancer](../../../terraform/resources/alb_load_balancer.md).

1. В файле `alb-with-ddos-protection.auto.tfvars` задайте пользовательские параметры:

    * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
    * `vm_user` — имя пользователя ВМ.
    * `ssh_key_path` — путь к файлу с открытым SSH-ключом для аутентификации пользователя на ВМ. Подробнее см. [Создание пары ключей SSH](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

1. Создайте ресурсы:

   1. В терминале перейдите в директорию с конфигурационным файлом.
   1. Проверьте корректность конфигурации с помощью команды:
   
      ```bash
      terraform validate
      ```
   
      Если конфигурация является корректной, появится сообщение:
   
      ```bash
      Success! The configuration is valid.
      ```
   
   1. Выполните команду:
   
      ```bash
      terraform plan
      ```
   
      В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
   1. Примените изменения конфигурации:
   
      ```bash
      terraform apply
      ```
   
   1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

После создания инфраструктуры, [проверьте](#test) его работу.

## Проверьте работу балансировщика {#test}

Проверьте доступность сервиса на хосте `alb-with-ddos.com`. Для этого выполните команду:

```bash
curl \
  --header "Host: alb-with-ddos.com" \
  http://<IP-адрес_L7-балансировщика>
```

Результат:

```html
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
  body {
    width: 35em;
    margin: 0 auto;
    font-family: Tahoma, Verdana, Arial, sans-serif;
  }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `alb-with-ddos-protection.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    1. В терминале перейдите в директорию с конфигурационным файлом.
    1. Проверьте корректность конфигурации с помощью команды:
    
       ```bash
       terraform validate
       ```
    
       Если конфигурация является корректной, появится сообщение:
    
       ```bash
       Success! The configuration is valid.
       ```
    
    1. Выполните команду:
    
       ```bash
       terraform plan
       ```
    
       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
    1. Примените изменения конфигурации:
    
       ```bash
       terraform apply
       ```
    
    1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

#### Полезные ссылки {#see-also}

* [Создание L7-балансировщика с защитой от DDoS с помощью консоли управления или CLI](console.md)