# Настройка сетевого взаимодействия ресурсов из разных каталогов


В Yandex Cloud сетевые ресурсы, например, облачные сети и подсети, обычно создаются в одном облачном каталоге ресурсов, а связь с ресурсами в других каталогах облака отсутствует. При развертывании ресурсов в Yandex Cloud часто возникает необходимость обеспечить сетевое взаимодействие между ресурсами из разных каталогов. Один из способов решения этой задачи – метод `Multi-folder VPC`, расширяющий область действия отдельно взятой сети VPC с одного каталога на несколько.

В зависимости от выбранного интерфейса управления Yandex Cloud расширение области действия сети в другие каталоги достигается за счет:

* перемещения подсетей в другие каталоги облака — `консоль управления (UI)`, `CLI`;
* создания подсетей в целевых каталогах — `CLI`;
* создания подсетей в целевых каталогах — `Terraform`.

После этого к подсетям в целевых каталогах можно подключать виртуальные машины, кластеры Managed Service for Kubernetes, хосты БД, балансировщики нагрузки, агенты нагрузочного тестирования или другие ресурсы, находящиеся в этих каталогах. Таким образом можно получить сеть, которая обеспечит связность между ресурсами из разных каталогов.

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
1. [Создайте каталоги без сети VPC](#create-folders).
1. [Создайте облачную сеть VPC с подсетями](#create-vpc).
1. [Переместите подсети](#move-subnets).
1. [Создайте виртуальные машины](#create-vms).
1. [Проверьте сетевую связность ресурсов](#check-connectivity).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#prepare-cloud}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за постоянно работающие ВМ (см. [тарифы Yandex Compute Cloud](../../compute/pricing.md));
* плата за использование публичных IP-адресов и исходящий трафик (см. [тарифы Yandex Virtual Private Cloud](../pricing.md)).

### Настройте права доступа {#roles}

Настройте [права доступа к каталогу](../../resource-manager/operations/folder/set-access-bindings.md):

* Чтобы создавать сети и управлять подсетями, назначьте сервисному аккаунту или пользователю сервисную роль `vpc.admin` либо сервисные роли `vpc.privateAdmin`, `vpc.publicAdmin`, `vpc.securityGroups.admin`.
* Чтобы создавать и управлять ВМ в каталоге, назначьте сервисные роли `vpc.user` и `compute.admin`.

Разграничение сетевого доступа обеспечивается [группами безопасности](../concepts/security-groups.md).

## Создайте каталоги без сети VPC {#create-folders}

1. Создайте каталоги `net-folder`, `dev-folder` и `prod-folder`:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) и нажмите кнопку ![image](../../_assets/console-icons/ellipsis.svg) → ![Create icon](../../_assets/console-icons/plus.svg) **Создать каталог**.
     1. Введите имя [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) `net-folder`.
     1. Отключите опцию **Создать сеть по умолчанию**, чтобы создать сеть и подсети вручную.
     1. Нажмите кнопку **Создать**.

     Аналогично создайте еще два каталога без сети VPC с именами `dev-folder` и `prod-folder`.

   - CLI {#cli}

     Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

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

   - Terraform {#tf}

     1. Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
        
        
        Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

     1. Задайте параметры для Terraform-провайдера Yandex Cloud:

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

     Воспользуйтесь методом REST API [create](../../resource-manager/api-ref/Folder/create.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/Create](../../resource-manager/api-ref/grpc/Folder/create.md).

   {% endlist %}

## Создайте облачную сеть VPC с подсетями {#create-vpc}

В каталоге `net-folder` создайте сеть `shared-net` с тремя подсетями со следующими параметрами:

| Имя подсети | Префикс | Зона доступности | Целевой каталог |
| --- | --- | --- | --- |
| `subnet-a` | `10.1.11.0/24` | `ru-central1-a` | `net-folder` |
| `subnet-b` | `10.1.12.0/24` | `ru-central1-b` | `dev-folder` |
| `subnet-d` | `10.1.13.0/24` | `ru-central1-d` | `prod-folder` |

1. Создайте [облачную сеть](../concepts/network.md):

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог `net-folder`.
     1. Перейдите в сервис **Virtual Private Cloud**.
     1. Нажмите кнопку **Создать сеть**.
     1. Задайте имя сети `shared-net`.
     1. Отключите опцию [Создать подсети](../operations/subnet-create.md), чтобы создать подсети вручную.
     1. Нажмите кнопку **Создать сеть**.

   - CLI {#cli}

     1. Посмотрите описание команды CLI для создания облачной сети:

        ```bash
        yc vpc network create --help
        ```

     1. Создайте облачную сеть `shared-net` в каталоге `net-folder`:

        ```bash
        yc vpc network create --folder-name net-folder --name shared-net
        ```

   - Terraform {#tf}

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

     Воспользуйтесь методом REST API [create](../api-ref/Network/create.md) для ресурса [Network](../api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Create](../api-ref/grpc/Network/create.md).

   {% endlist %}

1. Создайте [подсети](../concepts/network.md#subnet) `subnet-a`, `subnet-b` и `subnet-d` в [зонах доступности](../../overview/concepts/geo-scope.md) `ru-central1-a`, `ru-central1-b` и `ru-central1-d` соответственно:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог `net-folder`.
     1. Перейдите в сервис **Virtual Private Cloud**.
     1. Нажмите на имя облачной сети `shared-net`.
     1. Нажмите кнопку ![image](../../_assets/console-icons/nodes-right.svg) **Создать подсеть**.
     1. Укажите название подсети `subnet-a`, `subnet-b` или `subnet-d` соответственно.
     1. Выберите зону доступности `ru-central1-a`, `ru-central1-b` или `ru-central1-d` соответственно из выпадающего списка.
     1. Введите CIDR подсети: IP-адрес `10.1.11.0` и маску подсети `24`. Подробнее про диапазоны IP-адресов в подсетях читайте в разделе [Облачные сети и подсети](../concepts/network.md).
     1. Нажмите кнопку **Создать подсеть**.

   - CLI {#cli}

     1. Посмотрите описание команды CLI для создания подсети:

        ```bash
        yc vpc subnet create --help
        ```

     1. Создайте подсети в целевых каталогах:

        ```bash
        yc vpc subnet create --folder-name net-folder --name subnet-a \
          --network-name shared-net --zone ru-central1-a --range 10.1.11.0/24

        yc vpc subnet create --folder-name dev-folder --name subnet-b \
          --network-name shared-net --zone ru-central1-b --range 10.1.12.0/24

        yc vpc subnet create --folder-name prod-folder --name subnet-d \
          --network-name shared-net --zone ru-central1-d --range 10.1.13.0/24
        ```

     1. Проверьте состояние созданных подсетей:

        ```bash
        yc vpc subnet list --folder-name net-folder
        yc vpc subnet list --folder-name dev-folder
        yc vpc subnet list --folder-name prod-folder
        ```

   - Terraform {#tf}

     1. Опишите целевые ресурсы — облачные подсети:

        ```hcl
        resource "yandex_vpc_subnet" "subnet_a" {
          folder_id      = yandex_resourcemanager_folder.net_folder.id
          name           = "subnet-a"
          description    = "NET folder subnet"
          v4_cidr_blocks = ["10.1.11.0/24"]
          zone           = "ru-central1-a"
          network_id     = yandex_vpc_network.shared_net.id
        }

        resource "yandex_vpc_subnet" "subnet_b" {
          folder_id      = yandex_resourcemanager_folder.dev_folder.id
          name           = "subnet-b"
          description    = "DEV folder subnet"
          v4_cidr_blocks = ["10.1.12.0/24"]
          zone           = "ru-central1-b"
          network_id     = yandex_vpc_network.shared_net.id
        }

        resource "yandex_vpc_subnet" "subnet_d" {
          folder_id      = yandex_resourcemanager_folder.prod_folder.id
          name           = "subnet-d"
          description    = "PROD folder subnet"
          v4_cidr_blocks = ["10.1.13.0/24"]
          zone           = "ru-central1-d"
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

     Воспользуйтесь методом REST API [create](../api-ref/Subnet/create.md) для ресурса [Subnet](../api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Create](../api-ref/grpc/Subnet/create.md).

   {% endlist %}

## Переместите подсети {#move-subnets}

[Переместите](../operations/subnet-move.md) подсеть `subnet-b` в каталог `dev-folder`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог `net-folder`.
  1. Перейдите в сервис **Virtual Private Cloud**.
  1. Нажмите на имя облачной сети `shared-net`.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке подсети `subnet-b`, и выберите **Переместить**.
  1. В выпадающем списке выберите каталог `dev-folder`.
  1. Нажмите кнопку **Переместить**.

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

  Воспользуйтесь методом REST API [move](../api-ref/Subnet/move.md) для ресурса [Subnet](../api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Move](../api-ref/grpc/Subnet/move.md).

{% endlist %}

Аналогично переместите подсеть `subnet-d` в каталог `prod-folder`.

## Создайте виртуальные машины {#create-vms}

Создайте [виртуальные машины](../../compute/concepts/vm.md) со следующими параметрами:

| Имя ВМ | Каталог | Зона доступности | Подсеть |
| --- | --- | --- | --- |
| `net-vm` | `net-folder` | `ru-central1-a` | `subnet-a` |
| `dev-vm` | `dev-folder` | `ru-central1-b` | `subnet-b` |
| `prod-vm` | `prod-folder` | `ru-central1-d` | `subnet-d` |

{% list tabs group=instructions %}

- Консоль управления {#console}

  Создайте ВМ `net-vm` с ОС Linux в каталоге `net-folder`:

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `net-folder`.
  1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **Создать ресурс** и выберите ![image](../../_assets/console-icons/cpu.svg) **Виртуальная машина**.
  1. В блоке **Образ загрузочного диска** в поле **Поиск продукта** введите `Ubuntu 22.04 LTS` и выберите публичный образ [Ubuntu 22.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-22-04-lts).
  1. В блоке **Расположение** выберите [зону доступности](../../overview/concepts/geo-scope.md) `ru-central1-a`.
  1. В блоке **Сетевые настройки**:

      * В поле **Подсеть** выберите подсеть `subnet-a`.
      * В поле **Публичный IP-адрес** оставьте значение `Автоматически`, чтобы назначить ВМ случайный внешний IP-адрес из пула Yandex Cloud, или выберите статический адрес из списка, если вы зарезервировали его заранее.

  1. В блоке **Доступ** выберите вариант **SSH-ключ** и укажите данные для доступа на ВМ:

      * В поле **Логин** введите имя пользователя: `ycuser`.
      * В поле **SSH-ключ** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../organization/concepts/membership.md).
        
        Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
        
        1. Нажмите кнопку **Добавить ключ**.
        1. Задайте имя SSH-ключа.
        1. Выберите вариант:
        
            * `Ввести вручную` — вставьте содержимое открытого [SSH](../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
            * `Загрузить из файла` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
            * `Сгенерировать ключ` — автоматическое создание пары SSH-ключей.
            
              При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
        
        1. Нажмите кнопку **Добавить**.
        
        SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.

  1. В блоке **Общая информация** задайте имя ВМ: `net-vm`.
  1. Остальные настройки оставьте без изменения и нажмите кнопку **Создать ВМ**.

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
       --zone=ru-central1-a \
       --platform=standard-v3 \
       --cores=2 --memory=4G --core-fraction=100 \
       --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2204-lts \
       --network-interface subnet-name=subnet-a,ipv4-address=auto,nat-ip-version=ipv4 \
       --metadata-from-file user-data=vm-config.txt

     yc compute instance create --name=dev-vm --hostname=dev-vm \
       --zone=ru-central1-b \
       --platform=standard-v3 \
       --cores=2 --memory=4G --core-fraction=100 \
       --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2204-lts \
       --network-interface subnet-name=subnet-b,ipv4-address=auto,nat-ip-version=ipv4 \
       --metadata-from-file user-data=vm-config.txt

     yc compute instance create --name=prod-vm --hostname=prod-vm \
       --zone=ru-central1-d \
       --platform=standard-v3 \
       --cores=2 --memory=4G --core-fraction=100 \
       --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2204-lts \
       --network-interface subnet-name=subnet-d,ipv4-address=auto,nat-ip-version=ipv4 \
       --metadata-from-file user-data=vm-config.txt
     ```

     {% note info %}
     
     Команды [`yc compute instance create`](../../cli/cli-ref/compute/cli-ref/instance/create.md) | [`create-with-container`](../../cli/cli-ref/compute/cli-ref/instance/create-with-container.md) | [`update`](../../cli/cli-ref/compute/cli-ref/instance/update.md) | [`add-metadata`](../../cli/cli-ref/compute/cli-ref/instance/add-metadata.md) поддерживают подстановку в метаданные ВМ значений переменных окружения. Эти значения, заданные в ключе `user-data` в формате `$<имя_переменной>`, в момент выполнения команды Yandex Cloud CLI будут подставлены в метаданные ВМ из переменных окружения среды, в которой выполняется команда. 
     
     Чтобы изменить такое поведение, не подставлять значение переменной из среды выполнения команды CLI и передать в метаданные ВМ имя переменной в формате `$<имя_переменной>`, используйте синтаксис с двумя символами доллара. Например: `$$<имя_переменной>`.
     
     Подробнее в разделе [Особенности передачи переменных окружения в метаданных через CLI](../../compute/concepts/metadata/sending-metadata.md#environment-variables).
     
     {% endnote %}

  1. Сохраните публичные IP-адреса ВМ для дальнейшего использования:

     ```bash
     NET_VM_IP=$(yc compute instance get net-vm --format=json | jq -r '.network_interfaces[0].primary_v4_address.one_to_one_nat.address')
     DEV_VM_IP=$(yc compute instance get dev-vm --format=json | jq -r '.network_interfaces[0].primary_v4_address.one_to_one_nat.address')
     PROD_VM_IP=$(yc compute instance get prod-vm --format=json | jq -r '.network_interfaces[0].primary_v4_address.one_to_one_nat.address')
     ```

- Terraform {#tf}

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
       zone     = "ru-central1-a"
       size     = "20"
       image_id = yandex_compute_image.vm_image.id
     }

     resource "yandex_compute_disk" "boot-disk-2" {
       name     = "boot-disk-2"
       type     = "network-hdd"
       zone     = "ru-central1-b"
       size     = "20"
       image_id = yandex_compute_image.vm_image.id
     }

     resource "yandex_compute_disk" "boot-disk-3" {
       name     = "boot-disk-3"
       type     = "network-hdd"
       zone     = "ru-central1-d"
       size     = "20"
       image_id = yandex_compute_image.vm_image.id
     }

     resource "yandex_compute_instance" "net_vm" {
       folder_id   = yandex_resourcemanager_folder.net_folder.id
       name        = "net-vm"
       hostname    = "net-vm"
       platform_id = "standard-v3"
       zone        = "ru-central1-a"
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
       zone        = "ru-central1-b"
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
       zone        = "ru-central1-d"
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

  Чтобы создать виртуальную машину, воспользуйтесь методом REST API [create](../../compute/api-ref/Instance/create.md) для ресурса [Compute Instance](../../compute/api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Create](../../compute/api-ref/grpc/Instance/create.md).

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