[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Registry](../../index.md) > [Практические руководства](../index.md) > [Подключение к Cloud Registry из сети Virtual Private Cloud без доступа в интернет](index.md) > Terraform

# Подключение к Yandex Cloud Registry из сети Yandex Virtual Private Cloud без доступа в интернет с помощью Terraform


Чтобы организовать подключение к Cloud Registry из сети Virtual Private Cloud без доступа в интернет:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Убедитесь в работоспособности решения](#validate).

При развертывании решения в продуктивных средах ознакомьтесь с [рекомендациями](#recommendations).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки создаваемой инфраструктуры входят:

* плата за вычислительные ресурсы и диски [виртуальных машин](../../../compute/concepts/vm.md) ([тарифы Yandex Compute Cloud](../../../compute/pricing.md));
* плата за использование [публичного IP-адреса](../../../vpc/concepts/address.md#public-addresses), [сервисных подключений](../../../vpc/concepts/private-endpoint.md) и обработку сервисными подключениями входящего и исходящего трафика ([тарифы Yandex Virtual Private Cloud](../../../vpc/pricing.md));
* плата за использование хранилища Cloud Registry, входящий и исходящий трафик ([тарифы Yandex Cloud Registry](../../pricing.md)).

## Создайте инфраструктуру {#deploy}

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

Для создания инфраструктуры с помощью Terraform:

1. [Установите Terraform](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера Yandex Cloud (раздел [Настройте провайдер](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

    {% list tabs group=infrastructure_description %}

    - Готовая конфигурация {#ready}

      1. Клонируйте репозиторий с конфигурационными файлами.

          ```bash
          git clone https://github.com/yandex-cloud-examples/yc-cloud-registry-private-endpoints
          ```

      1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:

          * `cloud-registry-via-pe.tf` — конфигурация создаваемой инфраструктуры.
          * `cloud-registry-via-pe.auto.tfvars` — файл с пользовательскими данными.

    - Вручную {#manual}

      1. Создайте директорию `cloud-registry-via-pe` для конфигурационных файлов.
      1. Создайте в директории:

          1. Конфигурационный файл `cloud-registry-via-pe.tf`:

              {% cut "cloud-registry-via-pe.tf" %}

              ```hcl
              # Объявление переменных
              
              variable "folder_id" {
                type = string
              }
              
              variable "ssh_key_path" {
                type = string
              }
              
              locals {
                network_name    = "cr-private-net"
                subnet_name     = "cr-private-subnet"
                subnet_cidr     = "192.168.10.0/24"
                storage_pe_addr = "storage-pe-address"
                storage_pe_ip   = "192.168.10.10"
                cr_pe_addr      = "cr-pe-address"
                cr_pe_ip        = "192.168.10.11"
                vm_addr         = "private-vm-address"
                vm_ip           = "192.168.10.20"
                registry_name   = "cr-private-demo"
                sa_name         = "cr-pusher"
                storage_pe_name = "storage-pe"
                cr_pe_name      = "cloud-registry-pe"
                private_vm_name = "cr-private-vm"
                jump_vm_name    = "jump-vm"
                zone            = "ru-central1-a"
              }
              
              # Настройка провайдера
              
              terraform {
                required_providers {
                  yandex = {
                    source = "yandex-cloud/yandex"
                  }
                }
                required_version = ">= 0.13"
              }
              
              provider "yandex" {
                folder_id = var.folder_id
              }
              
              # Получение образа Container Optimized Image
              
              data "yandex_compute_image" "coi" {
                family    = "container-optimized-image"
                folder_id = "standard-images"
              }
              
              # Получение образа Ubuntu 24.04
              
              data "yandex_compute_image" "ubuntu" {
                family    = "ubuntu-2404-lts-oslogin"
                folder_id = "standard-images"
              }
              
              # Создание облачной сети
              
              resource "yandex_vpc_network" "cr_private_net" {
                name = local.network_name
              }
              
              # Создание подсети
              
              resource "yandex_vpc_subnet" "cr_private_subnet" {
                name           = local.subnet_name
                zone           = local.zone
                network_id     = yandex_vpc_network.cr_private_net.id
                v4_cidr_blocks = [local.subnet_cidr]
              }
              
              # Резервирование IP-адреса для сервисного подключения Object Storage
              
              resource "yandex_vpc_address" "storage_pe_address" {
                name = local.storage_pe_addr
              
                internal_ipv4_address {
                  subnet_id = yandex_vpc_subnet.cr_private_subnet.id
                  address   = local.storage_pe_ip
                }
              }
              
              # Резервирование IP-адреса для сервисного подключения Cloud Registry
              
              resource "yandex_vpc_address" "cr_pe_address" {
                name = local.cr_pe_addr
              
                internal_ipv4_address {
                  subnet_id = yandex_vpc_subnet.cr_private_subnet.id
                  address   = local.cr_pe_ip
                }
              }
              
              # Резервирование IP-адреса для тестовой виртуальной машины
              
              resource "yandex_vpc_address" "private_vm_address" {
                name = local.vm_addr
              
                internal_ipv4_address {
                  subnet_id = yandex_vpc_subnet.cr_private_subnet.id
                  address   = local.vm_ip
                }
              }
              
              # Создание реестра Cloud Registry
              
              resource "yandex_cloudregistry_registry" "cr_private_demo" {
                name      = local.registry_name
                folder_id = var.folder_id
                kind      = "DOCKER"
                type      = "LOCAL"
              }
              
              # Создание сервисного аккаунта
              
              resource "yandex_iam_service_account" "cr_pusher" {
                name = local.sa_name
              }
              
              # Назначение роли сервисному аккаунту
              
              resource "yandex_resourcemanager_folder_iam_member" "cr_pusher_role" {
                folder_id = var.folder_id
                role      = "cloud-registry.artifacts.pusher"
                member    = "serviceAccount:${yandex_iam_service_account.cr_pusher.id}"
              }
              
              # Создание сервисного подключения Object Storage
              
              resource "yandex_vpc_private_endpoint" "storage_pe" {
                name         = local.storage_pe_name
                network_id   = yandex_vpc_network.cr_private_net.id
                service_name = "yandex.cloud.storage"
              
                dns_options {
                  private_dns_records_enabled = true
                }
              
                endpoint_address {
                  address_id = yandex_vpc_address.storage_pe_address.id
                }
              }
              
              # Создание сервисного подключения Cloud Registry
              
              resource "yandex_vpc_private_endpoint" "cloud_registry_pe" {
                name         = local.cr_pe_name
                network_id   = yandex_vpc_network.cr_private_net.id
                service_name = "yandex.cloud.registry"
              
                dns_options {
                  private_dns_records_enabled = true
                }
              
                endpoint_address {
                  address_id = yandex_vpc_address.cr_pe_address.id
                }
              
                depends_on = [yandex_vpc_private_endpoint.storage_pe]
              }
              
              # Создание тестовой виртуальной машины
              
              resource "yandex_compute_instance" "cr_private_vm" {
                name               = local.private_vm_name
                hostname           = local.private_vm_name
                platform_id        = "standard-v2"
                zone               = local.zone
                service_account_id = yandex_iam_service_account.cr_pusher.id
              
                resources {
                  cores  = 2
                  memory = 2
                }
              
                boot_disk {
                  initialize_params {
                    image_id = data.yandex_compute_image.coi.id
                  }
                }
              
                network_interface {
                  subnet_id  = yandex_vpc_subnet.cr_private_subnet.id
                  ip_address = yandex_vpc_address.private_vm_address.internal_ipv4_address[0].address
                  nat        = false
                }
              
                metadata = {
                  user-data = "#cloud-config\nusers:\n  - name: yc-user\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("${var.ssh_key_path}")}"
                }
              }
              
              # Создание промежуточной виртуальной машины
              
              resource "yandex_compute_instance" "jump_vm" {
                name        = local.jump_vm_name
                hostname    = local.jump_vm_name
                platform_id = "standard-v2"
                zone        = local.zone
              
                resources {
                  cores  = 2
                  memory = 2
                }
              
                boot_disk {
                  initialize_params {
                    image_id = data.yandex_compute_image.ubuntu.id
                  }
                }
              
                network_interface {
                  subnet_id = yandex_vpc_subnet.cr_private_subnet.id
                  nat       = true
                }
              
                metadata = {
                  user-data = "#cloud-config\nusers:\n  - name: yc-user\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("${var.ssh_key_path}")}"
                }
              }
              
              # Вывод идентификатора реестра Cloud Registry
              
              output "registry_id" {
                description = "Cloud Registry ID"
                value       = yandex_cloudregistry_registry.cr_private_demo.id
              }
              
              # Вывод публичного IP-адреса промежуточной виртуальной машины
              
              output "jump_vm_public_ip" {
                description = "Public IP address of jump VM"
                value       = yandex_compute_instance.jump_vm.network_interface[0].nat_ip_address
              }
              ```

              {% endcut %}

          1. Файл с пользовательскими данными `cloud-registry-via-pe.auto.tfvars`:

              {% cut "cloud-registry-via-pe.auto.tfvars" %}

              ```hcl
              folder_id         = "<идентификатор_каталога>"
              ssh_key_path      = "<путь_к_файлу_с_публичным_SSH-ключом>"
              ```

              {% endcut %}

    {% endlist %}

    Подробнее о параметрах используемых ресурсов в Terraform смотрите в документации провайдера:

    * [Сеть](../../../vpc/concepts/network.md#network) — [yandex_vpc_network](../../../terraform/resources/vpc_network.md).
    * [Подсеть](../../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet](../../../terraform/resources/vpc_subnet.md).
    * [Зарезервированный IP-адрес](../../../vpc/concepts/address.md) — [yandex_vpc_address](../../../terraform/resources/vpc_address.md).
    * [Реестр Cloud Registry](../../concepts/registry.md) — [yandex_cloudregistry_registry](../../../terraform/resources/cloudregistry_registry.md).
    * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account](../../../terraform/resources/iam_service_account.md).
    * [Роль](../../../iam/concepts/access-control/roles.md) сервисному аккаунту — [yandex_resourcemanager_folder_iam_member](../../../terraform/resources/resourcemanager_folder_iam_member.md).
    * [Сервисное подключение](../../../vpc/concepts/private-endpoint.md) — [yandex_vpc_private_endpoint](../../../terraform/resources/vpc_private_endpoint.md).
    * [Виртуальная машина](../../../compute/concepts/vm.md) — [yandex_compute_instance](../../../terraform/resources/compute_instance.md).

1. В файле `cloud-registry-via-pe.auto.tfvars` задайте пользовательские параметры:

    * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
    * `ssh_key_path` — путь к файлу с открытым [SSH-ключом](../../../glossary/ssh-keygen.md) для аутентификации пользователя на ВМ. Подробнее в разделе [Создание пары ключей SSH](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

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
    
       В терминале будет выведен список планируемых изменений: ресурсы и/или выходные переменные. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
    1. Примените изменения конфигурации:
    
       ```bash
       terraform apply
       ```
    
    1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

    Результат:

    ```text
    Outputs:

    jump_vm_public_ip = "84.201.***.***"
    registry_id = "cn1h07frefbc********"
    ```

    Используйте полученные IP-адрес и идентификатор реестра при проверке работоспособности созданной инфраструктуры.


## Убедитесь в работоспособности решения {#validate}

{% note warning %}

При создании инфраструктуры с помощью Terraform метрики сервисных подключений начинают поставляться в Yandex Monium приблизительно через 30 минут после создания этих сервисных подключений. Чтобы отследить метрики в Monium, подождите полчаса, прежде чем выполнять операции с реестром.

{% endnote %}


### Настройте безопасное SSH-подключение к тестовой ВМ через промежуточную ВМ {#setup-ssh-connection}

1. На вашем локальном компьютере в любом текстовом редакторе откройте файл `~/.ssh/config`. Если такого файла не существует, создайте его.

    Тильда (`~`) в пути означает домашний каталог пользователя (например, `/home/user` в Linux или `C:\Users\user` в Windows).
1. Добавьте в файл `~/.ssh/config` следующие правила подключения:

    {% note info %}

    Если текущий файл `~/.ssh/config` содержит раздел `Host *` с общими правилами подключения, новые правила необходимо добавить перед этим разделом.

    {% endnote %}

    ```text
    Host jump-vm
        HostName <публичный_IP-адрес_промежуточной_ВМ>
        User yc-user
        IdentityFile <локальный_путь_к_закрытому_SSH-ключу>
        IdentitiesOnly yes
        ForwardAgent no

    Host cr-private-vm
        HostName 192.168.10.20
        User yc-user
        IdentityFile <локальный_путь_к_закрытому_SSH-ключу>
        IdentitiesOnly yes
        ProxyJump jump-vm
        ForwardAgent no
    ```

    Где:

    * `<публичный_IP-адрес_промежуточной_ВМ>` — публичный IP-адрес ВМ `jump-vm`, который можно узнать в поле **Публичный IPv4-адрес** сетевого интерфейса в блоке **Сеть** на странице ВМ в [консоли управления](https://console.yandex.cloud/link/compute) или с помощью команды [Yandex Cloud CLI](../../../cli/cli-ref/compute/cli-ref/instance/get.md) `yc compute instance get jump-vm`.
    * `<локальный_путь_к_закрытому_SSH-ключу>` — локальный путь к закрытой части SSH-ключа, который вы указали при создании виртуальных машин. Например: `~/.ssh/id_ed25519`.
1. Настройте необходимые права доступа к созданному файлу конфигурации. Способ настройки зависит от операционной системы вашего компьютера:

    {% list tabs group=operating_system %}

    - Linux/macOS {#linux}

      В терминале выполните команду:

      ```bash
      chmod 600 ~/.ssh/config
      ```

    - Windows (PowerShell) {#windows}

      В терминале PowerShell выполните команды:

      ```powershell
      icacls "$env:USERPROFILE\.ssh\config" /inheritance:r
      icacls "$env:USERPROFILE\.ssh\config" /grant:r "$($env:USERNAME):(R,W)"
      ```

    {% endlist %}

### Подключитесь к тестовой виртуальной машине {#connect-to-test-vm}

1. Чтобы подключиться к тестовой виртуальной машине через промежуточную ВМ, в терминале вашего локального компьютера выполните команду:

    ```bash
    ssh cr-private-vm
    ```

    Результат:

    ```text
    The authenticity of host '51.250.***.*** (51.250.***.***)' can't be established.
    ED25519 key fingerprint is: SHA256:C/+mc/qPAhH6ls2NhwSNyYZoRziZ8GOd3z5********
    This key is not known by any other names.
    Are you sure you want to continue connecting (yes/no/[fingerprint])?
    ```

1. Дважды разрешите подключение (введите `yes` и нажмите `ENTER`).

    Результат:

    ```bash
    yc-user@cr-private-vm:~$
    ```

### Проверьте работу DNS и убедитесь, что на тестовой ВМ нет доступа в интернет {#check-internet-connection}

В терминале тестовой виртуальной машины выполните действия:

1. Проверьте разрешение DNS-имен во [внутренней DNS-зоне](../../../dns/concepts/dns-zone.md#private-zones):

    ```bash
    getent ahostsv4 registry.yandexcloud.net | awk '{print $1}' | sort -u
    getent ahostsv4 storage.yandexcloud.net | awk '{print $1}' | sort -u
    ```

    Результат:

    ```text
    192.168.10.11
    192.168.10.10
    ```
1. Убедитесь, что публичные сайты недоступны:

    ```bash
    curl --connect-timeout 5 --max-time 10 https://yandex.ru
    ```

    Если все настроено правильно, команда должна завершиться ошибкой:

    ```text
    curl: (28) Failed to connect to yandex.ru port 443 after 4427 ms: Connection timed out
    ```

### Аутентифицируйтесь в Cloud Registry {#authenticate-in-cr}

В терминале тестовой виртуальной машины выполните действия:

1. Через [сервис метаданных](../../../compute/concepts/vm-metadata.md#metadata-formats) ВМ получите [IAM-токен](../../../iam/concepts/authorization/iam-token.md) сервисного аккаунта `cr-pusher`, который привязан к ВМ:

    ```bash
    IAM_TOKEN="$(
      curl --silent --fail \
        --header Metadata-Flavor:Google \
        http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token \
      | sed -n 's/.*"access_token"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'
    )"
    ```
1. Убедитесь, что IAM-токен успешно получен и сохранен в переменную:

    ```bash
    if test -n "$IAM_TOKEN"; then
      echo "IAM-токен получен"
    else
      echo "Не удалось получить IAM-токен из метаданных" >&2
      exit 1
    fi
    ```

    Результат:

    ```text
    IAM-токен получен
    ```
1. Аутентифицируйтесь в Cloud Registry с помощью полученного IAM-токена:

    ```bash
    printf '%s' "$IAM_TOKEN" | docker login \
      --username iam \
      --password-stdin \
      registry.yandexcloud.net
    ```

    Результат:

    ```text
    ...
    Login Succeeded
    ```
1. Удалите переменную с IAM-токеном:

    ```bash
    unset IAM_TOKEN
    ```

### Соберите локальный Docker-образ {#compile-image}

На тестовой виртуальной машине отсутствует доступ в интернет, поэтому скачать классический пример тестового образа `hello-world` из [Docker Hub](https://hub.docker.com/) не получится.

Вместо этого в целях тестирования вы соберете локальный Docker-образ с использованием статического исполняемого файла [busybox](https://www.busybox.net/) с набором утилит для Linux. Этот файл доступен в образе Container Optimized Image, из которого создана тестовая виртуальная машина.

В терминале тестовой виртуальной машины выполните действия:

1. Создайте локальный Docker-образ:

    ```bash
    mkdir -p /tmp/img/bin && cd /tmp/img
    cp $(which busybox) bin/busybox
    tar -cf rootfs.tar bin/busybox
    docker import rootfs.tar my-busybox:latest
    ```

    Результат:

    ```text
    sha256:137a8aff429ba2f8445450f8d063c2db394496d7a0e683555a573ab8********
    ```
1. Запустите локальный Docker-образ, чтобы убедиться в его работоспособности:

    ```bash
    docker run --rm my-busybox:latest /bin/busybox echo "Hello offline"
    ```

    Результат:

    ```text
    Hello offline
    ```

### Загрузите Docker-образ в реестр {#push-image}

В терминале тестовой виртуальной машины выполните действия:

1. Получите список доступных Docker-образов:

    ```bash
    docker images
    ```

    Результат:

    ```text
    REPOSITORY    TAG       IMAGE ID       CREATED          SIZE
    my-busybox    latest    137a********   18 minutes ago   2.19MB
    ```
1. Присвойте Docker-образу URL вида, в котором его можно загрузить в реестр Cloud Registry:

    ```bash
    docker tag my-busybox:latest \
      registry.yandexcloud.net/<идентификатор_реестра>/my-busybox:latest
    ```

    Где `<идентификатор_реестра>` — идентификатор реестра Cloud Registry, который вы создали ранее. Получить идентификатор реестра вы можете в [консоли управления](https://console.yandex.cloud/link/cloud-registry) или с помощью команды [Yandex Cloud CLI](../../../cli/cli-ref/cloud-registry/cli-ref/registry/list.md) `yc cloud-registry registry list`.
1. Загрузите собранный образ `my-busybox` в ваш реестр Cloud Registry:

    ```bash
    docker push \
      registry.yandexcloud.net/<идентификатор_реестра>/my-busybox:latest
    ```

    Результат:

    ```text
    The push refers to repository [registry.yandexcloud.net/cn1tsdfufbue********/my-busybox]
    a7c1********: Pushed 
    latest: digest: sha256:2ab6804ba443d3621bf4be33f19c576775c59eef7e059da5735a0fcb******** size: 527
    ```

### Скачайте Docker-образ из реестра {#pull-image}

В терминале тестовой виртуальной машины выполните действия:

1. Получите список доступных Docker-образов:

    ```bash
    docker images
    ```

    Результат:

    ```text
    REPOSITORY                                                 TAG       IMAGE ID       CREATED          SIZE
    my-busybox                                                 latest    137a********   25 minutes ago   2.19MB
    registry.yandexcloud.net/cn1tsdfufbue********/my-busybox   latest    137a********   25 minutes ago   2.19MB
    ```
1. Перед скачиванием удалите все имеющиеся локальные образы:

    ```bash
    docker rmi -f $(docker images -q)
    ```
1. Убедитесь, что локальных образов больше нет:

    ```bash
    docker images
    ```

    Результат:

    ```text
    REPOSITORY   TAG       IMAGE ID   CREATED   SIZE
    ```
1. Скачайте образ из реестра Cloud Registry:

    ```bash
    docker pull \
      registry.yandexcloud.net/<идентификатор_реестра>/my-busybox:latest
    ```

    Результат:

    ```text
    latest: Pulling from cn1tsdfufbue********/my-busybox
    1391********: Pull complete 
    Digest: sha256:2ab6804ba443d3621bf4be33f19c576775c59eef7e059da5735a0fcb********
    Status: Downloaded newer image for registry.yandexcloud.net/cn1tsdfufbue********/my-busybox:latest
    registry.yandexcloud.net/cn1tsdfufbue********/my-busybox:latest
    ```
1. Убедитесь, что скачанный образ появился в локальном списке:

    ```bash
    docker images
    ```

    Результат:

    ```text
    REPOSITORY                                                 TAG       IMAGE ID       CREATED          SIZE
    registry.yandexcloud.net/cn1tsdfufbue********/my-busybox   latest    137a********   33 minutes ago   2.19MB
    ```
1. Запустите скачанный Docker-образ, чтобы убедиться в его работоспособности:

    ```bash
    docker run --rm \
      registry.yandexcloud.net/<идентификатор_реестра>/my-busybox:latest /bin/busybox echo "Hello offline"
    ```

    Результат:

    ```text
    Hello offline
    ```

### Убедитесь в прохождении трафика через сервисные подключения {#check-traffic}

С помощью [метрик](../../../monium/metrics/quickstart-app.md) Yandex Monium убедитесь, что через сервисные подключения `storage-pe` и `cloud-registry-pe` при загрузке и скачивании Docker-образа проходил сетевой трафик:

{% list tabs group=instructions %}

- Интерфейс Monium {#console}

  1. Откройте [Monium](https://monium.yandex.cloud) и на панели сверху выберите [проект каталога](*monium-folder-project), в котором находится ваша инфраструктура.
  
      Имя и идентификатор проекта Monium, в который выгружается телеметрия ресурсов в вашем каталоге, соответствуют имени и идентификатору этого каталога.
  1. На панели слева выберите ![compass](../../../_assets/console-icons/compass.svg) **Обзор**, затем ![rectangle-pulse](../../../_assets/console-icons/rectangle-pulse.svg) **Метрики**.
  1. В строке формирования запроса включите режим кода, нажав ![image](../../../_assets/console-icons/code.svg), и введите следующий запрос:

      ```json
      {project = "folder__<идентификатор_каталога>", cluster = "default", service = "__private-endpoint__", name = "processed_bytes"}
      ```
  1. Нажмите кнопку **Добавить запрос**, переключите его в режим кода и введите еще один запрос:

      ```json
      {project = "folder__<идентификатор_каталога>", cluster = "default", service = "__private-endpoint__", name = "processed_packets"}
      ```
  1. Включите опцию **Один график на запрос**.
  1. Нажмите кнопку **Выполнить запрос**.
  1. Убедитесь, что на графиках отображается прохождение входящего и исходящего трафика через сервисные подключения в моменты времени, когда вы загружали Docker-образ в реестр и скачивали его из реестра.

      {% note tip %}

      Используйте шкалу времени в верхней части экрана, чтобы изменить или сместить в нужном направлении анализируемое окно времени.

      {% endnote %}

{% endlist %}

[*monium-folder-project]: Проект Monium с идентификатором `folder__<идентификатор_каталога>` создается автоматически для каждого каталога и содержит телеметрию его ресурсов.


## Рекомендации для использования в продуктивной среде {#recommendations}

* Используйте существующие сервисные подключения повторно: они действуют для всех ресурсов в выбранной облачной сети.
* Резервируйте статические внутренние IP-адреса для сервисных подключений и документируйте каждый случай такого резервирования.
* Выдавайте рабочим нагрузкам только минимально необходимые [роли](../../security/index.md#service-roles):

    * `cloud-registry.artifacts.puller` для скачивания артефактов.
    * `cloud-registry.artifacts.pusher` для загрузки артефактов. Выдавайте эту роль только тем субъектам, которым действительно нужна возможность загружать артефакты.
* Получайте короткоживущие IAM-токены для субъекта рабочей нагрузки. Не размещайте статические ключи в образах ВМ и контейнеров.
* При использовании корпоративного или пользовательского DNS заранее убедитесь, что в нем корректно разрешаются оба стандартных FQDN и wildcard-имена Object Storage и Cloud Registry.
* Помните, что у Cloud Registry есть публичный эндпоинт. Использование сервисного подключения не запрещает доступ к реестру из других сетей и не отменяет необходимости управлять доступом к реестрам при помощи ресурсов Identity and Access Management.
* Для [удаленных](../../concepts/registry.md#remote-registry) и [виртуальных](../../concepts/registry.md#virtual-registry) реестров отдельно оценивайте зависимость от внешних репозиториев: сервисные подключения обеспечивают путь от рабочей нагрузки до сервиса Cloud Registry, но не гарантируют доступность сторонних репозиториев.
* Вместо группы безопасности по умолчанию вы можете [создать](../../../vpc/operations/security-group-create.md) и привязать к ВМ собственную группу безопасности, которая разрешает только минимально необходимый трафик ВМ:

    * Исходящий TCP-трафик на порт `443` к IP-адресам обоих сервисных подключений.
    * Исходящие DNS-запросы к DNS-серверу в подсети. Под DNS-сервер в подсети выделяется второй по счету IP-адрес диапазона. Подробнее читайте в разделе [Подсети](../../../vpc/concepts/network.md#subnet).
    * Входящий трафик, который обеспечивает административный доступ только из вашей доверенной сети, если такой доступ нужен.


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../operations/artifacts/delete.md) все артефакты из реестра `cr-private-demo`, который был создан в этом руководстве.
1. Откройте конфигурационный файл `cloud-registry-via-pe.tf` и удалите описание создаваемой инфраструктуры из файла.
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
    
       В терминале будет выведен список планируемых изменений: ресурсы и/или выходные переменные. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
    1. Примените изменения конфигурации:
    
       ```bash
       terraform apply
       ```
    
    1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

#### Полезные ссылки {#see-also}

* [Подключение к Yandex Cloud Registry из сети Yandex Virtual Private Cloud без доступа в интернет с помощью консоли управления, CLI или API](console.md)