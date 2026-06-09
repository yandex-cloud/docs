# Маршрутизация через NAT-инстанс с помощью {{ TF }}


Чтобы настроить [маршрутизацию через NAT-инстанс](index.md) с помощью {{ TF }}:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Проверьте работу NAT-инстанса](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки NAT-инстанса входят:

* плата за постоянно запущенные ВМ (см. [тарифы {{ compute-full-name }}](../../../compute/pricing.md));
* плата за использование динамического или статического внешнего IP-адреса (см. [тарифы {{ vpc-full-name }}](../../../vpc/pricing.md)).


## Создайте инфраструктуру {#deploy}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

{{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

Чтобы создать инфраструктуру с помощью {{ TF }}:

1. [Установите {{ TF }}](../../infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файл с описанием инфраструктуры:

    {% list tabs group=infrastructure_description %}

    - Готовая конфигурация {#ready}

      1. Склонируйте репозиторий с конфигурационными файлами:

         ```bash
         git clone https://github.com/yandex-cloud-examples/yc-compute-nat-instance.git
         ```

      1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
         * `nat-instance.tf` — конфигурация создаваемой инфраструктуры.
         * `nat-instance.auto.tfvars` — пользовательские данные.

    - Вручную {#manual}

      1. Создайте папку для файла с описанием инфраструктуры.
      1. Создайте в папке конфигурационный файл `nat-instance.tf`:

          {% cut "nat-instance.tf" %}

          ```hcl
          # Объявление переменных для пользовательских параметров
          
          variable "folder_id" {
            type = string
          }
          
          variable "vm_user" {
            type = string
          }
          
          variable "vm_user_nat" {
            type = string
          }
          
          variable "ssh_key_path" {
            type = string
          }
          
          # Добавление прочих переменных
          
          locals {
            network_name     = "my-vpc"
            subnet_name1     = "public-subnet"
            subnet_name2     = "private-subnet"
            sg_nat_name      = "nat-instance-sg"
            vm_test_name     = "test-vm"
            vm_nat_name      = "nat-instance"
            route_table_name = "nat-instance-route"
          }
          
          # Настройка провайдера
          
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
          
          # Создание облачной сети
          
          resource "yandex_vpc_network" "my-vpc" {
            name = local.network_name
          }
          
          # Создание подсетей
          
          resource "yandex_vpc_subnet" "public-subnet" {
            name           = local.subnet_name1
            zone           = "{{ region-id }}-a"
            network_id     = yandex_vpc_network.my-vpc.id
            v4_cidr_blocks = ["192.168.1.0/24"]
          }
          
          resource "yandex_vpc_subnet" "private-subnet" {
            name           = local.subnet_name2
            zone           = "{{ region-id }}-a"
            network_id     = yandex_vpc_network.my-vpc.id
            v4_cidr_blocks = ["192.168.2.0/24"]
            route_table_id = yandex_vpc_route_table.nat-instance-route.id
          }
          
          # Создание группы безопасности
          
          resource "yandex_vpc_security_group" "nat-instance-sg" {
            name       = local.sg_nat_name
            network_id = yandex_vpc_network.my-vpc.id
          
            egress {
              protocol       = "ANY"
              description    = "any"
              v4_cidr_blocks = ["0.0.0.0/0"]
              from_port      = 0
              to_port        = 65535
            }
          
            ingress {
              protocol       = "TCP"
              description    = "ssh"
              v4_cidr_blocks = ["0.0.0.0/0"]
              port           = 22
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
          }
          
          # Добавление готового образа ВМ
          
          resource "yandex_compute_image" "ubuntu-1804-lts" {
            source_family = "ubuntu-1804-lts"
          }
          
          resource "yandex_compute_image" "nat-instance-ubuntu" {
            source_family = "nat-instance-ubuntu"
          }
          
          # Создание загрузочных дисков
          
          resource "yandex_compute_disk" "boot-disk-ubuntu" {
            name     = "boot-disk-ubuntu"
            type     = "network-hdd"
            zone     = "{{ region-id }}-a"
            size     = "20"
            image_id = yandex_compute_image.ubuntu-1804-lts.id
          }
          
          resource "yandex_compute_disk" "boot-disk-nat" {
            name     = "boot-disk-nat"
            type     = "network-hdd"
            zone     = "{{ region-id }}-a"
            size     = "20"
            image_id = yandex_compute_image.nat-instance-ubuntu.id
          }
          
          # Создание ВМ
          
          resource "yandex_compute_instance" "test-vm" {
            name        = local.vm_test_name
            platform_id = "standard-v3"
            zone        = "{{ region-id }}-a"
          
            resources {
              core_fraction = 20
              cores         = 2
              memory        = 2
            }
          
            boot_disk {
              disk_id = yandex_compute_disk.boot-disk-ubuntu.id
            }
          
            network_interface {
              subnet_id          = yandex_vpc_subnet.private-subnet.id
              security_group_ids = [yandex_vpc_security_group.nat-instance-sg.id]
            }
          
            metadata = {
              user-data = "#cloud-config\nusers:\n  - name: ${var.vm_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("${var.ssh_key_path}")}"
            }
          }
          
          # Создание ВМ NAT
          
          resource "yandex_compute_instance" "nat-instance" {
            name        = local.vm_nat_name
            platform_id = "standard-v3"
            zone        = "{{ region-id }}-a"
          
            resources {
              core_fraction = 20
              cores         = 2
              memory        = 2
            }
          
            boot_disk {
              disk_id = yandex_compute_disk.boot-disk-nat.id
            }
          
            network_interface {
              subnet_id          = yandex_vpc_subnet.public-subnet.id
              security_group_ids = [yandex_vpc_security_group.nat-instance-sg.id]
              nat                = true
            }
          
            metadata = {
              user-data = "#cloud-config\nusers:\n  - name: ${var.vm_user_nat}\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("${var.ssh_key_path}")}"
            }
          }
          
          # Создание таблицы маршрутизации и статического маршрута
          
          resource "yandex_vpc_route_table" "nat-instance-route" {
            name       = "nat-instance-route"
            network_id = yandex_vpc_network.my-vpc.id
            static_route {
              destination_prefix = "0.0.0.0/0"
              next_hop_address   = yandex_compute_instance.nat-instance.network_interface.0.ip_address
            }
          }
          ```

          {% endcut %}

      1. Создайте в папке файл с пользовательскими данными `nat-instance.auto.tfvars`:

          {% cut "nat-instance.auto.tfvars" %}

          ```hcl
          folder_id    = "<идентификатор_каталога>"
          vm_user      = "<имя_пользователя_ВМ>"
          vm_user_nat  = "<имя_пользователя_ВМ_NAT>"
          ssh_key_path = "<путь_к_публичному_SSH-ключу>"
          ```

          {% endcut %}

    {% endlist %}

    Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:

    * [Сеть](../../../vpc/concepts/network.md#network) — [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
    * [Подсети](../../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
    * [Группы безопасности](../../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group).
    * [Образ](../../../compute/concepts/image.md) — [yandex_compute_image]({{ tf-provider-resources-link }}/compute_image).
    * [Диск](../../../compute/concepts/disk.md) — [yandex_compute_disk]({{ tf-provider-resources-link }}/compute_disk).
    * [Виртуальная машина](../../../compute/concepts/vm.md) — [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance).
    * [Таблица маршрутизации](../../../vpc/concepts/routing.md#rt-vpc) — [yandex_vpc_route_table]({{ tf-provider-resources-link }}/vpc_route_table)

1. В файле `nat-instance.auto.tfvars` задайте пользовательские параметры:

    * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
    * `vm_user` — имя пользователя ВМ.
    * `vm_user_nat` — имя пользователя ВМ с NAT.
    * `ssh_key_path` — путь к файлу с открытым SSH-ключом для аутентификации пользователя на ВМ. Подробнее см. [{#T}](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

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
    
       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
    1. Примените изменения конфигурации:
    
       ```bash
       terraform apply
       ```
    
    1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

После создания инфраструктуры проверьте работу NAT-инстанса (#test).

## Проверьте работу NAT-инстанса {#test}

1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md#vm-connect) к тестовой ВМ через внутренний IP-адрес, используя NAT-инстанс в роли джамп-хоста:

    ```bash
    ssh -J <имя_пользователя_NAT-инстанса>@<публичный_IP-адрес_NAT-инстанса> \
      <имя_пользователя_ВМ>@<внутренний_IP-адрес_ВМ>
    ```

    Также подключиться к тестовой ВМ можно с помощью перенаправления стандартного ввода-вывода (флаг `-W`) для «проброса» соединения через NAT-инстанс:

    ```bash
    ssh -o ProxyCommand="ssh -i <путь/имя_файла_ключа_NAT> -W %h:%p <имя_пользователя_NAT>@<публичный_IP-адрес_NAT>" \
      -i <путь/имя_файла_ключа_ВМ> <имя_пользователя_ВМ>@<внутренний_IP-адрес_ВМ>
    ```

    Используйте эту команду для подключения в следующих случаях:

    * на ВМ используется версия OpenSSH ниже 7.3;
    * ваши SSH-ключи хранятся в отличном от директории по умолчанию месте или имеют нестандартные имена.

1. Введите **yes** для подключения к NAT-инстансу и повторно введите **yes** для подключения к тестовой ВМ.

    {% note info %}

    При вводе **yes** команда может не отображаться в терминале, но сработает.

    {% endnote %}

1. Убедитесь, что тестовая ВМ получает доступ в интернет через публичный IP-адрес NAT-инстанса. Выполните команду:

    ```bash
    curl ifconfig.co
    ```

    Если команда вернет публичный IP-адрес NAT-инстанса, все настроено правильно.


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `nat-instance.tf` и удалите описание создаваемой инфраструктуры из файла.
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
    
       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
    1. Примените изменения конфигурации:
    
       ```bash
       terraform apply
       ```
    
    1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

#### См. также {#see-also}

* [{#T}](console.md)