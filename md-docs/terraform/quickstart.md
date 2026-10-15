[Документация Yandex Cloud](../index.md) > [Terraform в Yandex Cloud](index.md) > Начало работы

# Начало работы с Terraform


[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](index.md).

Чтобы создать первую инфраструктуру в Yandex Cloud с помощью Terraform:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Установите Terraform](#install-terraform).
1. [Получите данные для аутентификации](#get-credentials).
1. [Создайте файл конфигурации Terraform](#configure-terraform).
1. [Настройте провайдер](#configure-provider).
1. [Подготовьте план инфраструктуры](#prepare-plan).
1. [Проверьте и отформатируйте файлы конфигураций](#check-resources).
1. [Создайте ресурсы](#create-resources).

Если ресурсы больше вам не нужны, [удалите их](#delete-resources).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md) и [привяжите](../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры, которую вы создадите с помощью Terraform, входят:

* плата за постоянно запущенные [виртуальные машины](../compute/concepts/vm.md) ([тарифы Yandex Compute Cloud](../compute/pricing.md));
* плата за использование динамических [публичных IP-адресов](../vpc/concepts/address.md#public-addresses) ([тарифы Yandex Virtual Private Cloud](../vpc/pricing.md)).

## Установите Terraform {#install-terraform}

### Из зеркала {#from-yc-mirror}

{% note alert %}

Зеркало может быть недоступно.

{% endnote %}

Вы можете скачать дистрибутив Terraform для вашей платформы из [зеркала](https://hashicorp-releases.yandexcloud.net/terraform/). После загрузки добавьте путь к папке, в которой находится исполняемый файл, в переменную `PATH`:

```bash
export PATH=$PATH:/path/to/terraform
```

### С сайта HashiCorp {#from-hashicorp-site}

{% list tabs group=operating_system %}

- Windows {#windows}

  Используйте один из способов:
  * [Скачайте дистрибутив Terraform](https://www.terraform.io/downloads.html) и установите его согласно [инструкции](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started).
  * Установите Terraform с помощью пакетного менеджера [Chocolatey](https://chocolatey.org/install), используя команду:

    ```bash
    choco install terraform
    ```

- Linux {#linux}

  [Скачайте дистрибутив Terraform](https://www.terraform.io/downloads.html) и установите его согласно [инструкции](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started).

- macOS {#macos}

  Используйте один из способов:
  * [Скачайте дистрибутив Terraform](https://www.terraform.io/downloads.html) и установите его согласно [инструкции](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started).
  * Установите Terraform с помощью пакетного менеджера [Homebrew](https://brew.sh), используя команду:

    ```bash
    brew install terraform
    ```

{% endlist %}

## Получите данные для аутентификации {#get-credentials}

Для аутентификации в Yandex Cloud и управления инфраструктурой используйте Terraform от имени [сервисного аккаунта](../iam/concepts/users/service-accounts.md) или пользователя: [аккаунта на Яндексе](../iam/concepts/users/accounts.md#passport), [федеративного аккаунта](../iam/concepts/users/accounts.md#saml-federation) или [локального пользователя](../iam/concepts/users/accounts.md#local).

{% list tabs group=authentication %}

- Сервисный аккаунт {#service-account}

  Использование сервисного аккаунта с помощью [имперсонации](../iam/concepts/access-control/impersonation.md) является рекомендованным и наиболее безопасным способом аутентификации.
  
  При создании IAM-токена используйте имперсонацию для созданного сервисного аккаунта, указав его идентификатор в параметре `--impersonate-service-account-id`. В результате Terraform будет от имени сервисного аккаунта управлять ресурсами в каталоге и использовать IAM-токен сервисного аккаунта.
  
  {% note info %}
  
  Для использования имперсонации пользователю должна быть назначена [роль](../iam/security/index.md#iam-serviceAccounts-tokenCreator) `iam.serviceAccounts.tokenCreator` на соответствующий сервисный аккаунт.
  
  {% endnote %}
  
  Для аутентификации от имени сервисного аккаунта:
  
  1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите](../cli/operations/install-cli.md).
  
  1. В Yandex Cloud CLI [создайте](../cli/operations/profile/profile-create.md) новый профиль или [активируйте](../cli/operations/profile/profile-activate.md) созданный ранее.
  
  1. Аутентифицируйтесь от имени [аккаунта на Яндексе](../cli/operations/authentication/user.md), [федеративного](../cli/operations/authentication/federated-user.md) или [локального](../cli/operations/authentication/local-user.md) пользователя.
  
  1. Если у вас еще нет сервисного аккаунта, [создайте](../iam/operations/sa/create.md) его.
  
  1. [Назначьте](../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роли, необходимые для управления ресурсами Yandex Cloud.
  
  1. Запишите аутентификационные данные в переменные окружения, используя имперсонацию:
  
      {% list tabs group=programming_language %}
  
      - Bash {#bash}
  
        ```bash
        export YC_TOKEN=$(yc iam create-token --impersonate-service-account-id <идентификатор_сервисного_аккаунта>)
        export YC_CLOUD_ID=$(yc config get cloud-id)
        export YC_FOLDER_ID=$(yc config get folder-id)
        ```
  
      - PowerShell {#powershell}
  
        ```powershell
        $Env:YC_TOKEN=$(yc iam create-token --impersonate-service-account-id <идентификатор_сервисного_аккаунта>)
        $Env:YC_CLOUD_ID=$(yc config get cloud-id)
        $Env:YC_FOLDER_ID=$(yc config get folder-id)
        ```
  
      {% endlist %}
  
      Где `<идентификатор_сервисного_аккаунта>` — идентификатор сервисного аккаунта.
  
  В результате в переменных окружения сохранятся IAM-токен сервисного аккаунта, а также идентификатор облака и идентификатор каталога.
  
  {% note info %}
  
  При каждой операции аутентификация будет происходить с помощью этого IAM-токена, пока не истечет [время его жизни](../iam/concepts/authorization/iam-token.md) (не более 12 часов). После этого снова потребуется пройти аутентификацию. Для автоматического перевыпуска IAM-токена можно использовать скрипт или другие способы автоматизации. 
  
  Чтобы продлить срок, в течение которого не нужно аутентифицироваться в браузере, используйте [refresh-токены](../iam/concepts/authorization/refresh-token.md), позволяющие перевыпускать IAM-токены без перехода в браузер. Для этого разрешите использовать refresh-токены [на уровне организации](../iam/concepts/authorization/refresh-token.md#token-enabling) и [инициализируйте DPoP-защиту](../iam/concepts/authorization/refresh-token.md#enabling-dpop) в CLI.
  
  {% endnote %}
  
  Настройки провайдера в конфигурационном файле Terraform без указания чувствительных параметров указываются следующим образом:
  
  
  ```hcl
  provider "yandex" {
    # Параметры cloud_id, folder_id и token не указываются, так как
    # провайдер автоматически подхватит их из переменных окружения
  
    zone = "<зона_доступности>"
  }
  ```
  
  
  
  Где `zone` — [зона доступности](../overview/concepts/geo-scope.md), в которой по умолчанию будут создаваться все облачные ресурсы.
  
  С такой конфигурацией используйте Terraform без дополнительных флагов, так как провайдер автоматически подхватит их из переменных окружения.

- Аккаунт на Яндексе, федеративный или локальный пользователь {#yandex-account}

  {% note warning %}
  
  Управление ресурсами от имени пользовательского аккаунта является менее безопасным, чем использование сервисного аккаунта.
  
  {% endnote %}
  
  Для аутентификации от имени пользовательского аккаунта:
  
  1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите](../cli/operations/install-cli.md).
  
  1. В Yandex Cloud CLI [создайте](../cli/operations/profile/profile-create.md) новый профиль или [активируйте](../cli/operations/profile/profile-activate.md) созданный ранее.
  
  1. Аутентифицируйтесь в зависимости от типа используемого аккаунта: [аккаунта на Яндексе](../cli/operations/authentication/user.md), [федеративного](../cli/operations/authentication/federated-user.md) или [локального](../cli/operations/authentication/local-user.md) пользователя.
  
  1. Запишите чувствительные данные профиля: IAM-токен, идентификатор облака и каталога в переменные окружения:
     
     {% list tabs group=programming_language %}
     
     - Bash {#bash}
     
       ```bash
       export YC_TOKEN=$(yc iam create-token)
       export YC_CLOUD_ID=$(yc config get cloud-id)
       export YC_FOLDER_ID=$(yc config get folder-id)
       ```
     
     - PowerShell {#powershell}
     
       ```powershell
       $Env:YC_TOKEN=$(yc iam create-token)
       $Env:YC_CLOUD_ID=$(yc config get cloud-id)
       $Env:YC_FOLDER_ID=$(yc config get folder-id)
       ```
     
     {% endlist %}
     
     Где:
     
     `yc iam create-token` — получение IAM-токена для текущей сессии.
     `yc config get cloud-id` — получение идентификатора облака из текущего профиля CLI.
     `yc config get folder-id` — получение идентификатора каталога из текущего профиля CLI.
     
     
     В результате в переменных окружения сохранятся IAM-токен, а также идентификатор облака и идентификатор каталога.
  
  {% note info %}
  
  При каждой операции аутентификация будет происходить с помощью этого IAM-токена, пока не истечет [время его жизни](../iam/concepts/authorization/iam-token.md) (не более 12 часов). После этого снова потребуется пройти аутентификацию. Для автоматического перевыпуска IAM-токена можно использовать скрипт или другие способы автоматизации. 
  
  Чтобы продлить срок, в течение которого не нужно аутентифицироваться в браузере, используйте [refresh-токены](../iam/concepts/authorization/refresh-token.md), позволяющие перевыпускать IAM-токены без перехода в браузер. Для этого разрешите использовать refresh-токены [на уровне организации](../iam/concepts/authorization/refresh-token.md#token-enabling) и [инициализируйте DPoP-защиту](../iam/concepts/authorization/refresh-token.md#enabling-dpop) в CLI.
  
  {% endnote %}
  
  Настройки провайдера в конфигурационном файле Terraform без указания чувствительных параметров указываются следующим образом:
  
  
  ```hcl
  provider "yandex" {
    # Параметры cloud_id, folder_id и token не указываются, так как
    # провайдер автоматически подхватит их из переменных окружения
  
    zone = "<зона_доступности>"
  }
  ```
  
  
  
  Где `zone` — [зона доступности](../overview/concepts/geo-scope.md), в которой по умолчанию будут создаваться все облачные ресурсы.
  
  С такой конфигурацией используйте Terraform без дополнительных флагов, так как провайдер автоматически подхватит их из переменных окружения.

{% endlist %}

## Создайте файл конфигурации Terraform {#configure-terraform}

1. Создайте новую директорию с произвольным названием, например `cloud-terraform`. В ней будут храниться конфигурационные файлы и сохраненные состояния Terraform и инфраструктуры.

   {% note warning %}

   Каждая конфигурация должна находиться в отдельной директории.

   {% endnote %}

1. Создайте в новой директории конфигурационный файл с расширением `.tf`, например `main.tf`.

## Настройте провайдер {#configure-provider}

{% note info %}

Настройки применимы для Terraform `0.13` и более поздних версий. Рекомендуется использовать последнюю стабильную версию Terraform.

{% endnote %}

1. Если раньше у вас был настроен провайдер из реестра HashiCorp, сохраните его настройки:

   {% list tabs group=operating_system %}

   - Linux/macOS {#linux-macos}

     ```bash
     mv ~/.terraformrc ~/.terraformrc.old
     ```

   - Windows {#windows}

     ```powershell
     Move-Item $env:APPDATA\terraform.rc $env:APPDATA\terraform.rc.old
     ```

   {% endlist %}

1. Укажите источник, из которого будет устанавливаться провайдер.

   {% list tabs group=operating_system %}

   - Linux/macOS {#linux-macos}

     Откройте файл конфигурации Terraform CLI:

     ```bash
     nano ~/.terraformrc
     ```

     {% note info %}
     
     Файл `.terraformrc` должен располагаться в корне домашней папки пользователя, например, `/home/user/` или `/User/user/`.
     
     {% endnote %}

   - Windows {#windows}

     Откройте файл конфигурации Terraform CLI `terraform.rc` в папке `%APPDATA%` вашего пользователя.

     Чтобы узнать абсолютный путь к папке `%APPDATA%`, выполните команду `echo %APPDATA%` для cmd или `$env:APPDATA` для PowerShell.

   {% endlist %}

   Добавьте в него следующий блок:

   ```hcl
   provider_installation {
     network_mirror {
       url = "https://terraform-mirror.yandexcloud.net/"
       include = ["registry.terraform.io/*/*"]
     }
     direct {
       exclude = ["registry.terraform.io/*/*"]
     }
   }
   ```

   Подробнее о настройках зеркал в [документации](https://www.terraform.io/cli/config/config-file#explicit-installation-method-configuration).
1. В начале конфигурационного файла `.tf` добавьте следующие блоки:

   
   ```hcl
   terraform {
     required_providers {
       yandex = {
         source = "yandex-cloud/yandex"
       }
     }
     required_version = ">= 0.13"
   }

   provider "yandex" {
     zone = "<зона_доступности_по_умолчанию>"
   }
   ```



   Где:
   
   * `source` — глобальный [адрес источника](https://developer.hashicorp.com/terraform/language/providers/requirements#source-addresses) провайдера.
   * `required_version` — минимальная версия Terraform, с которой совместим провайдер.
   * `provider` — название провайдера.
   * `zone` — [зона доступности](../overview/concepts/geo-scope.md), в которой по умолчанию будут создаваться все облачные ресурсы.
1. Выполните команду `terraform init` в папке с конфигурационным файлом `.tf`. Эта команда инициализирует провайдеров, указанных в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.

Если провайдер не установился, создайте обращение в [поддержку](https://center.yandex.cloud/support) с именем и версией провайдера.

Если вы использовали файл `.terraform.lock.hcl`, перед инициализацией выполните команду `terraform providers lock`, указав адрес зеркала, откуда будет загружаться провайдер, и платформы, на которых будет использоваться конфигурация:

```bash
terraform providers lock -net-mirror=https://terraform-mirror.yandexcloud.net -platform=<название_платформы_1> -platform=<название_платформы_2> yandex-cloud/yandex
```

Где:

* `-net-mirror` — адрес зеркала, откуда будет загружаться провайдер.
* `-platform` — платформы, на которых будет использоваться конфигурация. Возможные значения:
  
  * `windows_amd64` — 64-bit Windows.
  * `linux_amd64` — 64-bit Linux.
  * `darwin_arm64` — 64-bit macOS.

Если вы использовали [модули Terraform](../tutorials/infrastructure-management/terraform-modules.md), сначала выполните `terraform init`, затем удалите lock-файл, а затем выполните команду `terraform providers lock`.

Подробнее о команде `terraform providers lock` в [документации Terraform](https://developer.hashicorp.com/terraform/cli/commands/providers/lock).

## Подготовьте план инфраструктуры {#prepare-plan}

С помощью Terraform в Yandex Cloud можно создавать облачные ресурсы разных типов, например ВМ, [диски](../compute/concepts/disk.md) и [образы](../compute/concepts/image.md). Полный список ресурсов приведен в [документации провайдера](index.md).

Для каждого ресурса укажите обязательные и необязательные параметры, которые определяют его свойства. Описания ресурсов составляют план инфраструктуры.

План включает две ВМ (`terraform1` и `terraform2`), [облачную сеть](../vpc/concepts/network.md#network) `network1` и [подсеть](../vpc/concepts/network.md#subnet) `subnet1`.

Имена ресурсов должны соответствовать следующим требованиям:

* длина — от 3 до 63 символов;
* может содержать строчные буквы латинского алфавита, цифры и дефисы;
* первый символ — буква, последний — не дефис.

ВМ будут различаться количеством ядер и объемом памяти: у `terraform1` будет два ядра и 2 ГБ оперативной памяти, а у `terraform2` — четыре ядра и 4 ГБ оперативной памяти. Обе ВМ автоматически получат публичные и [внутренние IP-адреса](../vpc/concepts/address.md#internal-addresses) из диапазона `192.168.10.0/24`. Подсеть `subnet1` находится в [зоне доступности](../overview/concepts/geo-scope.md) `ru-central1-d` и принадлежит сети `network1`. Для ВМ используйте образ Ubuntu.

В конфигурации ВМ укажите идентификатор образа загрузочного диска. Получите список доступных публичных образов с помощью команды [CLI](../cli/quickstart.md):

```bash
yc compute image list --folder-id standard-images
```

Для доступа к ВМ по SSH [сгенерируйте пару SSH-ключей](../compute/operations/vm-connect/ssh.md#creating-ssh-keys) и укажите путь к публичной части ключа в параметре `ssh-keys` блока `metadata`.

Ниже приведены фрагменты конфигурации провайдера и одной ВМ для разных регионов. Полные конфигурации ресурсов приведены во вкладках Linux и Windows ниже.


```hcl
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  zone = "<зона_доступности_по_умолчанию>"
}

resource "yandex_compute_instance" "vm-1" {
  name = "terraform1"
}
```



{% list tabs group=operating_system %}

- Создание ВМ Linux {#linux}

  По плану будут созданы следующие ресурсы:
  * [Облачная сеть](../vpc/concepts/network.md#network) `network1` с [подсетью](../vpc/concepts/network.md#subnet) `subnet1` в [зоне доступности](../overview/concepts/geo-scope.md) `ru-central1-d`.
  * Две [виртуальные машины](../compute/concepts/vm.md) Linux: `terraform1` (2 ядра и 2 ГБ оперативной памяти) и `terraform2` (4 ядра и 4 ГБ оперативной памяти). Они автоматически получат [публичные и внутренние IP-адреса](../vpc/concepts/address.md#internal-addresses) из диапазона `192.168.10.0/24` в подсети `subnet-1`.
  1. Выберите [образ](../compute/concepts/image.md) загрузочного диска в Yandex Cloud Marketplace, например [Ubuntu 22.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-22-04-lts). Получите список доступных публичных образов с помощью команды [CLI](../cli/index.md):
  
     ```bash
     yc compute image list --folder-id standard-images
     ```
  
  1. Сгенерируйте [пару SSH-ключей](../compute/operations/vm-connect/ssh.md#creating-ssh-keys) для доступа к ВМ по [SSH](../glossary/ssh-keygen.md).
  1. Опишите параметры ресурсов в файле `main.tf`:
     * В параметре `ssh-keys` блока `metadata` укажите путь к публичной части SSH-ключа.
     * В `image_id` задайте идентификатор образа загрузочного диска.
  
     {% cut "Файл main.tf " %}
  
     ```hcl
     <настройки провайдера>
  
     resource "yandex_compute_disk" "boot-disk-1" {
       name     = "boot-disk-1"
       type     = "network-hdd"
       zone     = "ru-central1-d"
       size     = "20"
       image_id = "fd806c8slu9j********"
     }
  
     resource "yandex_compute_disk" "boot-disk-2" {
       name     = "boot-disk-2"
       type     = "network-hdd"
       zone     = "ru-central1-d"
       size     = "20"
       image_id = "fd806c8slu9j********"
     }
  
     resource "yandex_compute_instance" "vm-1" {
       name        = "terraform1"
       platform_id = "standard-v3"
  
       resources {
         cores  = 2
         memory = 2
       }
  
       boot_disk {
         disk_id = yandex_compute_disk.boot-disk-1.id
       }
  
       network_interface {
         subnet_id = yandex_vpc_subnet.subnet-1.id
         nat       = true
       }
  
       metadata = {
         ssh-keys = "ubuntu:${file("<путь_к_публичной_части_SSH-ключа>")}"
       }
     }
  
     resource "yandex_compute_instance" "vm-2" {
       name        = "terraform2"
       platform_id = "standard-v3"
  
       resources {
         cores  = 4
         memory = 4
       }
  
       boot_disk {
         disk_id = yandex_compute_disk.boot-disk-2.id
       }
  
       network_interface {
         subnet_id = yandex_vpc_subnet.subnet-1.id
         nat       = true
       }
  
       metadata = {
         ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
       }
     }
  
     resource "yandex_vpc_network" "network-1" {
       name = "network1"
     }
  
     resource "yandex_vpc_subnet" "subnet-1" {
       name           = "subnet1"
       zone           = "ru-central1-d"
       network_id     = yandex_vpc_network.network-1.id
       v4_cidr_blocks = ["192.168.10.0/24"]
     }
  
     output "internal_ip_address_vm_1" {
       value = yandex_compute_instance.vm-1.network_interface.0.ip_address
     }
  
     output "internal_ip_address_vm_2" {
       value = yandex_compute_instance.vm-2.network_interface.0.ip_address
     }
  
     output "external_ip_address_vm_1" {
       value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
     }
  
     output "external_ip_address_vm_2" {
       value = yandex_compute_instance.vm-2.network_interface.0.nat_ip_address
     }
     ```
  
     {% endcut %}

- Создание ВМ Windows {#windows}

  По плану будут созданы следующие ресурсы:
  * [Облачная сеть](../vpc/concepts/network.md#network) `ya-network` с [подсетью](../vpc/concepts/network.md#subnet) `ya-network` в [зоне доступности](../overview/concepts/geo-scope.md), указанной по умолчанию.
  * Две [виртуальные машины](../compute/concepts/vm.md) Windows: `terraform1` (2 ядра и 4 ГБ оперативной памяти) и `terraform2` (4 ядра и 4 ГБ оперативной памяти). Они автоматически получат публичные и [внутренние IP-адреса](../vpc/concepts/address.md#internal-addresses) из диапазона `192.168.10.0/16` в подсети `ya-network`.
  
  Создайте следующие файлы:
  1. `main.tf` — основной файл с описанием инфраструктуры.
  
      {% cut "Содержимое файла main.tf" %}
  
      ```hcl
      terraform {
        required_providers {
          yandex = {
            source = "yandex-cloud/yandex"
          }
        }
      }
  
      provider "yandex" {
        zone = var.zone
      }
  
      resource "yandex_vpc_network" "default" {
        name = var.network
      }
  
      resource "yandex_vpc_subnet" "default" {
        network_id     = yandex_vpc_network.default.id
        name           = var.subnet
        v4_cidr_blocks = var.subnet_v4_cidr_blocks
        zone           = var.zone
      }
  
      data "yandex_compute_image" "default" {
        family = var.image_family
      }
  
      data "template_file" "default" {
        template = file("${path.module}/init.ps1")
        vars = {
          user_name  = var.user_name
          user_pass  = var.user_pass
          admin_pass = var.admin_pass
        }
      }
  
      resource "yandex_compute_instance" "vm-1" {
        name        = "terraform1"
        hostname    = "terraform1"
        zone        = var.zone
        platform_id = "standard-v3"
  
        resources {
          cores = 2
          memory = 4
        }
  
        boot_disk {
          initialize_params {
            image_id = data.yandex_compute_image.default.id
            size     = var.disk_size
            type     = var.disk_type
          }
        }
  
        network_interface {
          subnet_id = yandex_vpc_subnet.default.id
          nat       = var.nat
        }
  
        metadata = {
          user-data = data.template_file.default.rendered
        }
  
        timeouts {
          create = var.timeout_create
          delete = var.timeout_delete
        }
      }
  
      resource "yandex_compute_instance" "vm-2" {
        name        = "terraform2"
        hostname    = "terraform2"
        zone        = var.zone
        platform_id = "standard-v3"
  
        resources {
          cores = 4
          memory = 4
        }
  
        boot_disk {
          initialize_params {
            image_id = data.yandex_compute_image.default.id
            size = var.disk_size
            type     = var.disk_type
          }
        }
  
        network_interface {
          subnet_id = yandex_vpc_subnet.default.id
          nat       = var.nat
        }
  
        metadata = {
          user-data = data.template_file.default.rendered
        }
  
        timeouts {
          create = var.timeout_create
          delete = var.timeout_delete
        }
      }
  
      output "internal_ip_address_vm_1" {
        value = yandex_compute_instance.vm-1.network_interface.0.ip_address
      }
  
      output "internal_ip_address_vm_2" {
        value = yandex_compute_instance.vm-2.network_interface.0.ip_address
      }
  
      output "external_ip_address_vm_1" {
        value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
      }
  
      output "external_ip_address_vm_2" {
        value = yandex_compute_instance.vm-2.network_interface.0.nat_ip_address
      }
      ```
  
      {% endcut %}
  
  1. `variables.tf` — файл с описанием переменных для создаваемых ресурсов.
  
      {% cut "Файл variables.tf" %}
  
      ```hcl
      variable "zone" {
        type    = string
        default = "ru-central1-d"
      }
  
      variable "network" {
        type    = string
        default = "ya-network"
      }
  
      variable "subnet" {
        type    = string
        default = "ya-network"
      }
  
      variable "subnet_v4_cidr_blocks" {
        type    = list(string)
        default = ["192.168.10.0/16"]
      }
  
      variable "nat" {
        type    = bool
        default = true
      }
  
      variable "image_family" {
        type    = string
        default = "windows-2019-dc-gvlk"
      }
  
      variable "disk_size" {
        type    = number
        default = 50
      }
  
      variable "disk_type" {
        type    = string
        default = "network-nvme"
      }
  
      variable "user_name" {
        type    = string
        default = ""
      }
  
      variable "user_pass" {
        type    = string
        default = ""
      }
  
      variable "admin_pass" {
        type    = string
        default = ""
      }
  
      variable "timeout_create" {
        default = "10m"
      }
  
      variable "timeout_delete" {
        default = "10m"
      }
      ```
  
      {% endcut %}
  
  1. `terraform.tfvars` — файл, где хранятся значения переменных для создаваемых внутри ВМ учетных записей.
  
      {% cut "Файл terraform.tfvars" %}
  
      ```hcl
      user_name  = "<my_user>"
      user_pass  = "<my_password>"
      admin_pass = "<my_password>"
      ```
  
      {% endcut %}

{% endlist %}

### Создайте пользователей {#users}

{% list tabs group=operating_system %}

- Linux {#linux}

  Для добавления пользователей, как и для изменения многих других параметров ОС создаваемой [виртуальной машины](../compute/concepts/vm.md), в Yandex Cloud используется механизм [cloud-init](https://cloud-init.io). Для этого необходимо передать текст конфигурации `cloud-init` в параметре `user-data` в блоке `metadata`. В нашем случае это будут системные пользователи:
  1. Создайте текстовый файл с метаданными в кодировке UTF-8, например:
  
     ```bash
        #cloud-config
        users:
          - name: <имя_пользователя>
            groups: sudo
            shell: /bin/bash
            sudo: 'ALL=(ALL) NOPASSWD:ALL'
            ssh_authorized_keys:
              - <публичный_SSH-ключ_1>
              - <публичный_SSH-ключ_2>
              - ...
        ```
     
        Где:
     
        * `name` — имя пользователя ВМ.
        * `ssh_authorized_keys` — список публичных SSH-ключей для доступа к ВМ.
           
          Пример ключа: `ssh-ed25519 AAAAB3Nza...Pu00jRN`.
  
  1. В файле `main.tf` вместо `ssh-keys` задайте параметр `user-data` и укажите путь к файлу с метаданными:
  
     ```hcl
     metadata = {
       user-data = "${file("<путь_к_файлу>/meta.txt")}"
     }
     ```
  
  Подробнее о работе с метаданными читайте в разделе [Метаданные виртуальной машины](../compute/concepts/vm-metadata.md).

- Windows {#windows}

  Чтобы создать пользователя и установить пароль учетной записи Administrator на [виртуальную машину](../compute/concepts/vm.md) в Yandex Cloud можно использовать агент [cloudbase-init](https://cloudbase-init.readthedocs.io/en/latest/). Для этого создайте скрипт `init.ps1`, который будет выполняться агентом при первой загрузке системы. В качестве учетных сведений будут использоваться переменные из файла `variables.tf`.
  
  {% cut "Файл init.ps1" %}
  
  ```cloudinit
  #ps1
  # ^^^ 'ps1' is only for cloudbase-init, some sort of sha-bang in linux
  
  # logging
  Start-Transcript -Path "$ENV:SystemDrive\provision.txt" -IncludeInvocationHeader -Force
  "Bootstrap script started" | Write-Host
  
  # inserting value's from terraform
  $MyUserName = "${ user_name }"
  $MyPlainTextPassword = "${ user_pass }"
  if (-not [string]::IsNullOrEmpty($MyUserName) -and -not [string]::IsNullOrEmpty($MyPlainTextPassword)) {
      "Create user" | Write-Host
      $MyPassword = $MyPlainTextPassword | ConvertTo-SecureString -AsPlainText -Force
      $MyUser = New-LocalUser -Name $MyUserName -Password $MyPassword -PasswordNeverExpires -AccountNeverExpires
      $MyUser | Add-LocalGroupMember -Group 'Administrators'
      $MyUser | Add-LocalGroupMember -Group 'Remote Management Users'
  }
  
  # inserting value's from terraform
  $MyAdministratorPlainTextPassword = "${ admin_pass }"
  if (-not [string]::IsNullOrEmpty($MyAdministratorPlainTextPassword)) {
      "Set local administrator password" | Write-Host
      $MyAdministratorPassword = $MyAdministratorPlainTextPassword | ConvertTo-SecureString -AsPlainText -Force
      # S-1-5-21domain-500 is a well-known SID for Administrator
      # https://docs.microsoft.com/en-us/troubleshoot/windows-server/identity/security-identifiers-in-windows
      $MyAdministrator = Get-LocalUser | Where-Object -Property "SID" -like "S-1-5-21-*-500"
      $MyAdministrator | Set-LocalUser -Password $MyAdministratorPassword
  }
  
  "Bootstrap script ended" | Write-Host
  ```
  
  {% endcut %}

{% endlist %}

## Проверьте и отформатируйте файлы конфигураций {#check-resources}

1. Проверьте конфигурацию командой:

   ```bash
   terraform validate
   ```

   Если конфигурация является допустимой, появится сообщение:

   ```text
   Success! The configuration is valid.
   ```

1. Отформатируйте файлы конфигураций в текущем каталоге и подкаталогах:

   ```bash
   terraform fmt
   ```

   Команда выводит список отформатированных файлов, например:

   ```text
   main.tf
   ```

## Создайте ресурсы {#create-resources}

1. После проверки конфигурации выполните команду:

   ```bash
   terraform plan
   ```

   Терминал выведет список ресурсов и их параметров. На этом этапе ресурсы не создаются. Если конфигурация содержит ошибки, Terraform укажет на них.

   {% note alert %}

   Все созданные с помощью Terraform ресурсы тарифицируются. Внимательно проверьте план.

   {% endnote %}

1. Чтобы создать ресурсы, выполните команду:

   ```bash
   terraform apply
   ```

1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

   Terraform создаст ресурсы и выведет в терминале [IP-адреса](../vpc/concepts/address.md) созданных [виртуальных машин](../compute/concepts/vm.md). Проверьте наличие ресурсов и их настройки в [консоли управления](https://console.yandex.cloud).

## Удалите созданные ресурсы {#delete-resources}

Чтобы удалить ресурсы, созданные с помощью Terraform:

1. Удалите из конфигурации блоки `resource` и `module`, относящиеся к этой инфраструктуре, а также источники данных и выходные значения `output`, которые на них ссылаются. Сохраните блоки `terraform` и `provider`.

1. Проверьте план удаления:

   ```bash
   terraform plan
   ```

   {% note alert %}

   Terraform удалит ресурсы, для которых вы убрали описания из конфигурации: кластеры, [сети](../vpc/concepts/network.md#network), [подсети](../vpc/concepts/network.md#subnet), [виртуальные машины](../compute/concepts/vm.md) и другие ресурсы.

   {% endnote %}

   Проверьте список ресурсов, которые Terraform собирается удалить.

1. Примените изменения:

   ```bash
   terraform apply
   ```

1. Подтвердите удаление: введите `yes` и нажмите **Enter**.

Проверить удаление ресурсов можно в [консоли управления](https://console.yandex.cloud).

#### Полезные ссылки {#see-also}

* [Загрузка состояний Terraform в Object Storage](../tutorials/infrastructure-management/terraform-state-storage.md).
* [Блокировка состояний Terraform с помощью Managed Service for YDB](../tutorials/infrastructure-management/terraform-state-lock.md).
* [Использование модулей Yandex Cloud в Terraform](../tutorials/infrastructure-management/terraform-modules.md).
* [Источники данных Terraform](../tutorials/infrastructure-management/terraform-data-sources.md).
* [IaC: Terraform](https://yandex.cloud/ru/training/terraform?utm_source=inhouse&utm_medium=telegram&utm_campaign=announcement) — обучающий курс по управлению инфраструктурой в облаке с помощью Terraform.