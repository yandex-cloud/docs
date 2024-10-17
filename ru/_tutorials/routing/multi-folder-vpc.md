# Настройка сетевого взаимодействия ресурсов из разных каталогов


В {{ yandex-cloud }} сетевые ресурсы, например, облачные сети и подсети, обычно создаются в одном облачном каталоге ресурсов, а связь с ресурсами в других каталогах облака отсутствует. При развертывании ресурсов в {{ yandex-cloud }} часто возникает необходимость обеспечить сетевое взаимодействие между ресурсами из разных каталогов. Один из способов решения этой задачи – метод `Multi-folder VPC`, расширяющий область действия отдельно взятой сети {{ vpc-short-name }} с одного каталога на несколько.

В зависимости от выбранного интерфейса управления {{ yandex-cloud }} расширение области действия сети в другие каталоги достигается за счет:

* перемещения подсетей в другие каталоги облака — `консоль управления (UI)`, `YC CLI`;
* создания подсетей в целевых каталогах — `YC CLI`;
* создания подсетей в целевых каталогах — `Terraform`.

После этого к подсетям в целевых каталогах можно подключать виртуальные машины, кластеры {{ managed-k8s-name }}, хосты БД, балансировщики нагрузки, агенты нагрузочного тестирования или другие ресурсы, находящиеся в этих каталогах. Таким образом можно получить сеть, которая обеспечит связность между ресурсами из разных каталогов.

В данном руководстве описан пример создания инфраструктуры, состоящей из трех виртуальных машин, расположенных в трех разных каталогах и объединенных в одну общую внутреннюю сеть. Сетевое объединение облачных ресурсов в разных каталогах заключается в создании в одном из этих каталогов облачной сети с последующим расширением области ее действия в другие каталоги. Таким образом, сеть из одного каталога, как бы растягивается на несколько каталогов, давая возможность подключать к `«растянутым подсетям»` в этих каталогах нужные ресурсы.

{% note warning %}

Перемещение подсетей возможно только между каталогами одного облака.

{% endnote %}

Например, в составе среды разработки есть модуль CI/CD, компоненты которого размещаются в каталоге `net-folder`. Им необходимо обеспечить сетевое взаимодействие с компонентами **dev**-, **stage**- и **prod**-окружений, которые находятся в соответствующих каталогах.

Схема такого решения показана на рисунке ниже.

![Multi-folder VPC](../../_assets/tutorials/infrastructure-management/multi-folder-vpc/multi-folder-vpc.svg)

В результате будет настроена сетевая связность между виртуальными машинами в разных окружениях (каталогах), которые подключены к разным подсетям одной сети. Кроме того, все ВМ смогут общаться друг с другом не только по IP-адресам, но и через доменные имена FQDN службы DNS.

## Порядок действий {#order}

В зависимости от выбранного интерфейса управления порядок действий для создания `Multi-folder VPC` может отличаться.

Чтобы создать тестовую инфраструктуру и организовать связь ресурсов:

1. [Подготовьте облако к работе](#prepare-cloud).
1. [Создайте каталоги без сети {{ vpc-short-name }}](#create-folders).
1. [Создайте облачную сеть {{ vpc-short-name }} с подсетями](#create-vpc).
1. [Переместите подсети](#move-subnets).
1. [Создайте виртуальные машины](#create-vms).
1. [Проверьте сетевую связность ресурсов](#check-connectivity).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за постоянно работающие ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование публичных IP-адресов и исходящий трафик (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).


### Настройте права доступа {#roles}

Настройте [права доступа к каталогу](../../resource-manager/operations/folder/set-access-bindings.md):

* Чтобы создавать сети и управлять подсетями, назначьте сервисному аккаунту или пользователю сервисную роль `vpc.admin` либо сервисные роли `vpc.privateAdmin`, `vpc.publicAdmin`, `vpc.securityGroups.admin`.
* Чтобы создавать и управлять ВМ в каталоге, назначьте сервисные роли `vpc.user` и `compute.admin`.

Разграничение сетевого доступа обеспечивается [группами безопасности](../../vpc/concepts/security-groups.md).

## Создайте каталоги без сети {{ vpc-short-name }} {#create-folders}

1. Создайте каталоги `net-folder`, `dev-folder` и `prod-folder`:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) и нажмите кнопку ![Create icon](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
     1. Введите имя [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) `net-folder`.
     1. Отключите опцию **{{ ui-key.yacloud.iam.cloud.folders-create.field_default-net }}**, чтобы создать сеть и подсети вручную.
     1. Нажмите кнопку **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

     Аналогично создайте еще два каталога без сети {{ vpc-short-name }} с именами `dev-folder` и `prod-folder`.

   - CLI {#cli}

     {% include [cli-install](../../_includes/cli-install.md) %}

     {% note info %}

     Для создания ресурсов с помощью CLI необходимо [аутентифицироваться](../../cli/operations/authentication/service-account.md#auth-as-sa) от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) с [ролью](../../iam/concepts/access-control/roles.md) `admin` на [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud).

     {% endnote %}

     1. Посмотрите описание команды создания каталога:

        ```bash
        yc resource-manager folder create --help
        ```

     1. Создайте облачные каталоги `net-folder`, `dev-folder` и `prod-folder`:

        ```bash
        yc resource-manager folder create --name net-folder
        yc resource-manager folder create --name dev-folder
        yc resource-manager folder create --name prod-folder
        ```

   - {{ TF }} {#tf}

     1. {% include [terraform-install](../../_includes/terraform-install.md) %}

     1. Задайте параметры для Terraform-провайдера {{ yandex-cloud }}:

         ```hcl
        # ==================================
        # Terraform & Provider Configuration
        # ==================================
        terraform {
          required_providers {
              yandex = {
                source  = "yandex-cloud/yandex"
                version = "~> 0.92.0"
              }
          }
        }
        ```

     1. Опишите входные переменные:

        ```hcl
        variable "cloud_id" {
          description = "YC cloud-id. Taken from environment variable."
        }
        ```

     1. Опишите целевые ресурсы — облачные каталоги:

        ```hcl
        # ========
        # Folders
        # ========
        resource "yandex_resourcemanager_folder" "net_folder" {
          cloud_id = var.cloud_id
          name     = "net-folder"
        }

        resource "yandex_resourcemanager_folder" "dev_folder" {
          cloud_id = var.cloud_id
          name     = "dev-folder"
        }

        resource "yandex_resourcemanager_folder" "prod_folder" {
          cloud_id = var.cloud_id
          name     = "prod-folder"
        }
        ```

     1. Создайте необходимую инфраструктуру:

        1. Выполните команды:

           ```bash
           export TF_VAR_cloud_id=$(yc config get cloud-id)
           export YC_TOKEN=$(yc iam create-token)
           terraform apply
           ```

        1. Подтвердите изменение ресурсов и дождитесь завершения операции.

   - API {#api}

     Воспользуйтесь методом REST API [create](../../resource-manager/api-ref/Folder/create.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/) или вызовом gRPC API [FolderService/Create](../../resource-manager/api-ref/grpc/Folder/create.md).

   {% endlist %}

## Создайте облачную сеть {{ vpc-short-name }} с подсетями {#create-vpc}

В каталоге `net-folder` создайте сеть `shared-net` с тремя подсетями со следующими параметрами:

| Имя подсети | Префикс | Зона доступности | Целевой каталог |
| --- | --- | --- | --- |
| `subnet-a` | `10.1.11.0/24` | `{{ region-id }}-a` | `net-folder` |
| `subnet-b` | `10.1.12.0/24` | `{{ region-id }}-b` | `dev-folder` |
| `subnet-d` | `10.1.13.0/24` | `{{ region-id }}-d` | `prod-folder` |

1. Создайте [облачную сеть](../../vpc/concepts/network.md):

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) перейдите в каталог `net-folder`.
     1. В списке сервисов выберите **{{ vpc-name }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.vpc.networks.button_create }}**.
     1. Задайте имя сети `shared-net`.
     1. Отключите опцию [Создать подсети](../../vpc/operations/subnet-create.md), чтобы создать подсети вручную.
     1. Нажмите кнопку **{{ ui-key.yacloud.vpc.networks.button_create }}**.

   - CLI {#cli}

     1. Посмотрите описание команды CLI для создания облачной сети:

        ```bash
        yc vpc network create --help
        ```

     1. Создайте облачную сеть `shared-net` в каталоге `net-folder`:

        ```bash
        yc vpc network create --folder-name net-folder --name shared-net
        ```

   - {{ TF }} {#tf}

     1. Опишите целевой ресурс — облачную сеть:

        ```hcl
        # =============
        # VPC Resources
        # =============
        resource "yandex_vpc_network" "shared_net" {
          folder_id = yandex_resourcemanager_folder.net_folder.id
          name      = "shared-net"
        }
        ```

     1. Выполните команды

        ```bash
        export TF_VAR_cloud_id=$(yc config get cloud-id)
        export YC_TOKEN=$(yc iam create-token)
        terraform apply
        ```

     1. Подтвердите изменение ресурсов.

     1. Дождитесь завершения операции.

   - API {#api}

     Воспользуйтесь методом REST API [create](../../vpc/api-ref/Network/create.md) для ресурса [Network](../../vpc/api-ref/Network/) или вызовом gRPC API [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md).

   {% endlist %}

1. Создайте [подсеть](../../vpc/concepts/network.md#subnet) `subnet-a` в [зоне доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-a`:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) перейдите в каталог `net-folder`.
     1. В списке сервисов выберите **{{ vpc-name }}**.
     1. Нажмите на имя облачной сети `shared-net`.
     1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.overview.button_create_subnetwork }}**.
     1. Укажите название подсети `subnet-a`.
     1. Выберите зону доступности `{{ region-id }}-a` из выпадающего списка.
     1. Введите CIDR подсети: IP-адрес `10.1.11.0` и маску подсети `24`. Подробнее про диапазоны IP-адресов в подсетях читайте в разделе [Облачные сети и подсети](../../vpc/concepts/network.md).
     1. Нажмите кнопку **{{ ui-key.yacloud.vpc.subnetworks.create.button_create }}**.

     Аналогично создайте подсети `subnet-b` и `subnet-d` в зонах доступности `{{ region-id }}-b` и `{{ region-id }}-d` в каталоге **net-folder**.

   - CLI {#cli}

     1. Посмотрите описание команды CLI для создания подсети:

        ```bash
        yc vpc subnet create --help
        ```

     1. Создайте подсети в целевых каталогах:

        ```bash
        yc vpc subnet create --folder-name net-folder --name subnet-a \
          --network-name shared-net --zone {{ region-id }}-a --range 10.1.11.0/24

        yc vpc subnet create --folder-name dev-folder --name subnet-b \
          --network-name shared-net --zone {{ region-id }}-b --range 10.1.12.0/24

        yc vpc subnet create --folder-name prod-folder --name subnet-d \
          --network-name shared-net --zone {{ region-id }}-d --range 10.1.13.0/24
        ```

     1. Проверьте состояние созданных подсетей:

        ```bash
        yc vpc subnet list --folder-name net-folder
        yc vpc subnet list --folder-name dev-folder
        yc vpc subnet list --folder-name prod-folder
        ```

   - {{ TF }} {#tf}

     1. Опишите целевые ресурсы — облачные подсети:

        ```hcl
        resource "yandex_vpc_subnet" "subnet_a" {
          folder_id      = yandex_resourcemanager_folder.net_folder.id
          name           = "subnet-a"
          description    = "NET folder subnet"
          v4_cidr_blocks = ["10.1.11.0/24"]
          zone           = "{{ region-id }}-a"
          network_id     = yandex_vpc_network.shared_net.id
        }

        resource "yandex_vpc_subnet" "subnet_b" {
          folder_id      = yandex_resourcemanager_folder.dev_folder.id
          name           = "subnet-b"
          description    = "DEV folder subnet"
          v4_cidr_blocks = ["10.1.12.0/24"]
          zone           = "{{ region-id }}-b"
          network_id     = yandex_vpc_network.shared_net.id
        }

        resource "yandex_vpc_subnet" "subnet_d" {
          folder_id      = yandex_resourcemanager_folder.prod_folder.id
          name           = "subnet-d"
          description    = "PROD folder subnet"
          v4_cidr_blocks = ["10.1.13.0/24"]
          zone           = "{{ region-id }}-d"
          network_id     = yandex_vpc_network.shared_net.id
        }
        ```

     1. Выполните команды:

        ```bash
        export TF_VAR_cloud_id=$(yc config get cloud-id)
        export YC_TOKEN=$(yc iam create-token)
        terraform apply
        ```

     1. Подтвердите изменение ресурсов и дождитесь завершения операции.

   - API {#api}

     Воспользуйтесь методом REST API [create](../../vpc/api-ref/Subnet/create.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/) или вызовом gRPC API [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md).

   {% endlist %}

## Переместите подсети {#move-subnets}

[Переместите](../../vpc/operations/subnet-move.md) подсеть `subnet-b` в каталог `dev-folder`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог `net-folder`.
  1. В списке сервисов выберите **{{ vpc-name }}**.
  1. Нажмите на имя облачной сети `shared-net`.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке подсети `subnet-b`, и выберите **{{ ui-key.yacloud.vpc.button_move-vpc-object }}**.
  1. В выпадающем списке выберите каталог `dev-folder`.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.button_move-vpc-object }}**.

- CLI {#cli}

  1. Посмотрите описание команды CLI для перемещения подсети:

     ```bash
     yc vpc subnet move --help
     ```

  1. Переместите подсеть:

     ```bash
     yc vpc subnet move subnet-b \
       --destination-folder-name dev-folder
     ```

- API {#api}

  Воспользуйтесь методом REST API [move](../../vpc/api-ref/Subnet/move.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/) или вызовом gRPC API [SubnetService/Move](../../vpc/api-ref/grpc/Subnet/move.md).

{% endlist %}

Аналогично переместите подсеть `subnet-d` в каталог `prod-folder`.

## Создайте виртуальные машины {#create-vms}

Создайте [виртуальные машины](../../compute/concepts/vm.md) со следующими параметрами:

| Имя ВМ | Каталог | Зона доступности | Подсеть |
| --- | --- | --- | --- |
| `net-vm` | `net-folder` | `{{ region-id }}-a` | `subnet-a` |
| `dev-vm` | `dev-folder` | `{{ region-id }}-b` | `subnet-b` |
| `prod-vm` | `prod-folder` | `{{ region-id }}-d` | `subnet-d` |

{% list tabs group=instructions %}

- Консоль управления {#console}

  Создайте ВМ `net-vm` с ОС Linux в каталоге `net-folder`:

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `net-folder`.
  1. В списке сервисов выберите **{{ compute-name }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
     * Введите имя `net-vm`.
     * Выберите зону доступности `{{ region-id }}-a`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts).
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}** выберите подсеть `subnet-a`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа на ВМ:
     * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя `ycuser`.
     * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла [открытого ключа](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys). Пару ключей для подключения по [SSH](../../glossary/ssh-keygen.md) необходимо [создать](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
  1. Остальные настройки оставьте без изменения и нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  Аналогично создайте ВМ `dev-vm` и `prod-vm` в соответствующих каталогах.

  {% note info %}

  При создании ВМ назначаются публичный и внутренний IP-адреса. Запишите их — они понадобятся для доступа к ВМ и проверки сетевого взаимодействия с другими ВМ.

  {% endnote %}

- CLI {#cli}

  1. Опишите шаблон для метаданных ВМ в отдельном файле `vm-init.tpl`:

     ```bash
     #cloud-config

     datasource:
       Ec2:
         strict_id: false
     ssh_pwauth: yes
     users:
       - name: "${USER_NAME}"
         sudo: ALL=(ALL) NOPASSWD:ALL
         shell: /bin/bash
         ssh_authorized_keys:
           - "${USER_SSH_KEY}"
     ```

  1. Сгенерируйте файл с метаданными для развертывания ВМ:

     ```bash
     export USER_NAME=ycuser
     export USER_SSH_KEY=$(cat ~/.ssh/id_rsa.pub)
 
     envsubst < vm-init.tpl > vm-config.txt
     ```

  1. Создайте виртуальные машины:

     ```bash
     yc compute instance create --name=net-vm --hostname=net-vm \
       --zone={{ region-id }}-a \
       --platform=standard-v3 \
       --cores=2 --memory=4G --core-fraction=100 \
       --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2204-lts \
       --network-interface subnet-name=subnet-a,ipv4-address=auto,nat-ip-version=ipv4 \
       --metadata-from-file user-data=vm-config.txt
 
     yc compute instance create --name=dev-vm --hostname=dev-vm \
       --zone={{ region-id }}-b \
       --platform=standard-v3 \
       --cores=2 --memory=4G --core-fraction=100 \
       --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2204-lts \
       --network-interface subnet-name=default-{{ region-id }}-b,ipv4-address=auto,nat-ip-version=ipv4 \
       --metadata-from-file user-data=vm-config.txt
 
     yc compute instance create --name=prod-vm --hostname=prod-vm \
       --zone={{ region-id }}-d \
       --platform=standard-v3 \
       --cores=2 --memory=4G --core-fraction=100 \
       --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2204-lts \
       --network-interface subnet-name=default-{{ region-id }}-d,ipv4-address=auto,nat-ip-version=ipv4 \
       --metadata-from-file user-data=vm-config.txt
     ```

  1. Сохраните публичные IP-адреса ВМ для дальнейшего использования:

     ```bash
     NET_VM_IP=$(yc compute instance get net-vm --format=json | jq -r '.network_interfaces[0].primary_v4_address.one_to_one_nat.address')
     DEV_VM_IP=$(yc compute instance get dev-vm --format=json | jq -r '.network_interfaces[0].primary_v4_address.one_to_one_nat.address')
     PROD_VM_IP=$(yc compute instance get prod-vm --format=json | jq -r '.network_interfaces[0].primary_v4_address.one_to_one_nat.address')
     ```

- {{ TF }} {#tf}

  1. Опишите входные переменные:

     ```hcl
     variable "user_name" {
       description = "VM User Name"
       default     = "ycuser"
     }
   
     variable "user_ssh_key_path" {
       description = "User's SSH public key file"
       default     = "~/.ssh/id_rsa.pub"
     }
     ```

  1. Опишите шаблон для метаданных ВМ в отдельном файле `vm-init.tpl`:

     ```hcl
     #cloud-config
   
     datasource:
       Ec2:
         strict_id: false
     ssh_pwauth: yes
     users:
       - name: "${USER_NAME}"
         sudo: ALL=(ALL) NOPASSWD:ALL
         shell: /bin/bash
         ssh_authorized_keys:
           - "${USER_SSH_KEY}"
     ```

  1. Опишите целевые ресурсы — виртуальные машины:

     ```hcl
     # =================
     # Compute Resources
     # =================
     data "yandex_compute_image" "vm_image" {
       family = "ubuntu-2204-lts"
     }

     resource "yandex_compute_disk" "boot-disk-1" {
       name     = "boot-disk-1"
       type     = "network-hdd"
       zone     = "{{ region-id }}-a"
       size     = "20"
       image_id = yandex_compute_image.vm_image.id
     }

     resource "yandex_compute_disk" "boot-disk-2" {
       name     = "boot-disk-2"
       type     = "network-hdd"
       zone     = "{{ region-id }}-b"
       size     = "20"
       image_id = yandex_compute_image.vm_image.id
     }

     resource "yandex_compute_disk" "boot-disk-3" {
       name     = "boot-disk-3"
       type     = "network-hdd"
       zone     = "{{ region-id }}-d"
       size     = "20"
       image_id = yandex_compute_image.vm_image.id
     }

     resource "yandex_compute_instance" "net_vm" {
       folder_id   = yandex_resourcemanager_folder.net_folder.id
       name        = "net-vm"
       hostname    = "net-vm"
       platform_id = "standard-v3"
       zone        = "{{ region-id }}-a"
       resources {
         cores  = 2
         memory = 4
       }

       boot_disk {
         disk_id = yandex_compute_disk.boot-disk-1.id
       }

       network_interface {
         subnet_id = yandex_vpc_subnet.subnet_a.id
         nat       = true
       }

       metadata = {
         user-data = templatefile("vm-init.tpl", {
           USER_NAME    = var.user_name
           USER_SSH_KEY = file(var.user_ssh_key_path)
         })
       }
     }

     resource "yandex_compute_instance" "dev_vm" {
       folder_id   = yandex_resourcemanager_folder.dev_folder.id
       name        = "dev-vm"
       hostname    = "dev-vm"
       platform_id = "standard-v3"
       zone        = "{{ region-id }}-b"
       resources {
         cores  = 2
         memory = 4
       }

       boot_disk {
         disk_id = yandex_compute_disk.boot-disk-2.id
       }

       network_interface {
         subnet_id = yandex_vpc_subnet.subnet_b.id
         nat       = true
       }

       metadata = {
         user-data = templatefile("vm-init.tpl", {
           USER_NAME    = var.user_name
           USER_SSH_KEY = file(var.user_ssh_key_path)
         })
       }
     }

     resource "yandex_compute_instance" "prod_vm" {
       folder_id   = yandex_resourcemanager_folder.prod_folder.id
       name        = "prod-vm"
       hostname    = "prod-vm"
       platform_id = "standard-v3"
       zone        = "{{ region-id }}-d"
       resources {
         cores  = 2
         memory = 4
       }

       boot_disk {
         disk_id = yandex_compute_disk.boot-disk-3.id
       }

       network_interface {
         subnet_id = yandex_vpc_subnet.subnet_d.id
         nat       = true
       }

       metadata = {
         user-data = templatefile("vm-init.tpl", {
           USER_NAME    = var.user_name
           USER_SSH_KEY = file(var.user_ssh_key_path)
         })
       }
     }

     # =======
     # Outputs
     # =======
     output "NET-vm" {
       value = yandex_compute_instance.network_vm.network_interface.0.nat_ip_address
     }

     output "DEV-vm" {
       value = yandex_compute_instance.dev_vm.network_interface.0.nat_ip_address
     }

     output "PROD-vm" {
       value = yandex_compute_instance.prod_vm.network_interface.0.nat_ip_address
     }
     ```

  1. Выполните команды

     ```bash
     export TF_VAR_cloud_id=$(yc config get cloud-id)
     export YC_TOKEN=$(yc iam create-token)
     terraform apply
     ```

  1. Подтвердите изменение ресурсов и дождитесь завершения операции.

- API {#api}

  Чтобы создать виртуальную машину, воспользуйтесь методом REST API [create](../../compute/api-ref/Instance/create.md) для ресурса [Compute Instance](../../compute/api-ref/Instance/) или вызовом gRPC API [InstanceService/Create](../../compute/api-ref/grpc/Instance/create.md).

{% endlist %}

## Проверьте сетевую связность ресурсов {#check-connectivity}

1. Подключитесь к ВМ `net-vm` по SSH:

   ```bash
   ssh ycuser@<публичный_IP-адрес_ВМ_net-vm>
   ```

1. Проверьте IP-связность с ВМ `dev-vm` внутри VPC:

   ```bash
   ping -c3 <внутренний_IP-адрес_ВМ_dev-vm>
   ```

   Результат:

   ```text
   PING 10.127.20.4 (10.127.20.4) 56(84) bytes of data.
   64 bytes from 10.127.20.4: icmp_seq=1 ttl=61 time=7.45 ms
   64 bytes from 10.127.20.4: icmp_seq=2 ttl=61 time=5.61 ms
   64 bytes from 10.127.20.4: icmp_seq=3 ttl=61 time=5.65 ms
   --- 10.127.20.4 ping statistics ---
   3 packets transmitted, 3 received, 0% packet loss, time 2003ms
   rtt min/avg/max/mdev = 5.613/6.235/7.446/0.855 ms
   ```

1. Аналогично проверьте IP-связность с ВМ `prod-vm` внутри VPC.

1. Подключитесь к ВМ `dev-vm` по SSH и проверьте IP-связность с ВМ `net-vm` и ВМ `prod-vm` с помощью команды **ping**.

1. Подключитесь к ВМ `prod-vm` по SSH и проверьте IP-связность с ВМ `net-vm` и ВМ `dev-vm` с помощью команды **ping**.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы, [удалите ВМ](../../compute/operations/vm-control/vm-delete.md) `net-vm`, `dev-vm` и `prod-vm`.
