# Использование модулей Yandex Cloud в Terraform


Yandex Cloud предоставляет ![](../../_assets/overview/solution-library-icon.svg)[набор модулей для Terraform](https://github.com/terraform-yc-modules). Модули Terraform объединяют несколько облачных ресурсов, которые должны работать вместе. Благодаря модулям конфигурация облачной инфраструктуры упрощается, блоки легче переиспользовать, а все необходимые для создания ресурсов параметры можно указать в переменных. 

На этой странице рассказано, как подключить модули и использовать их для создания тестовой инфраструктуры: [облачной сети](../../vpc/concepts/network.md#network) с тремя [подсетями](../../vpc/concepts/network.md#subnet) [Yandex Virtual Private Cloud](../../vpc/index.md) и [кластера Yandex Managed Service for Kubernetes](../concepts/index.md#kubernetes-cluster).

Чтобы создать вашу первую инфраструктуру в Yandex Cloud с помощью Terraform:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Установите Terraform](#install-terraform).
1. [Получите данные для аутентификации](#get-credentials).
1. [Создайте файл конфигурации Terraform](#configure-terraform).
1. [Настройте провайдер](#configure-provider).

Если ресурсы больше вам не нужны, [удалите их](#delete-resources).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры, разворачиваемой через Terraform в этом руководстве, входят:
* Плата за [высокодоступный мастер Managed Service for Kubernetes](../concepts/index.md#master) ([тарифы Managed Service for Kubernetes](../pricing.md)).
* Плата за постоянно запущенные [виртуальные машины](../../compute/concepts/vm.md) в [группе узлов Managed Service for Kubernetes](../concepts/index.md#node-group) ([тарифы Yandex Compute Cloud](../../compute/pricing.md)).
* Плата за использование динамических [публичных IP-адресов](../../vpc/concepts/address.md#public-addresses) ([тарифы Virtual Private Cloud](../../vpc/pricing.md#prices-public-ip)).

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

Чтобы управлять инфраструктурой Yandex Cloud с помощью Terraform, используйте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md). Это позволит гибко настраивать права доступа к ресурсам.

Также вы можете использовать Terraform от имени [аккаунта на Яндексе](../../iam/concepts/users/accounts.md#passport), [федеративного](../../iam/concepts/users/accounts.md#saml-federation) или [локального пользователя](../../iam/concepts/users/accounts.md#local), однако этот способ является менее безопасным. Подробности смотрите в конце раздела.
1. Если у вас еще нет интерфейса командной строки Yandex Cloud, [установите](../../cli/quickstart.md#install) его.
1. Если у вас еще нет сервисного аккаунта, создайте его:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать сервисный аккаунт.
     1. Перейдите в сервис **Identity and Access Management**.
     1. Нажмите кнопку **Создать сервисный аккаунт**.
     1. Введите имя сервисного аккаунта.

        Требования к формату имени:

        * длина — от 3 до 63 символов;
        * может содержать строчные буквы латинского алфавита, цифры и дефисы;
        * первый символ — буква, последний — не дефис.

     1. Нажмите кнопку **Создать**.

   - CLI {#cli}

     По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

     Выполните команду для создания сервисного аккаунта:

     ```bash
     yc iam service-account create --name <имя_сервисного_аккаунта>
     ```

     Где `name` — имя сервисного аккаунта в формате:

     * длина — от 3 до 63 символов;
     * может содержать строчные буквы латинского алфавита, цифры и дефисы;
     * первый символ — буква, последний — не дефис.

     Результат:

     ```text
     id: ajehr0to1g8b********
     folder_id: b1gv87ssvu49********
     created_at: "2022-09-14T09:03:11.665153755Z"
     name: sa-terraform
     ```

   - API {#api}

     Чтобы создать сервисный аккаунт, воспользуйтесь вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) или методом [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса `ServiceAccount` REST API.

    {% endlist %}

1. Назначьте сервисному аккаунту [роли](../../iam/concepts/access-control/roles.md), необходимые для управления ресурсами Yandex Cloud:

   Сервисному аккаунту можно [назначать роли](../../iam/operations/sa/assign-role-for-sa.md#binding-role-resource) на любые ресурсы в любом облаке, если эти ресурсы относятся к той же организации, что и сервисный аккаунт. Также сервисному аккаунту можно [назначать роли](../../iam/operations/sa/assign-role-for-sa.md#binding-role-organization) на саму организацию.

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     Чтобы назначить сервисному аккаунту роль на каталог:

     1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
     1. Перейдите на вкладку **Права доступа**.
     1. Нажмите кнопку **Настроить доступ**.
     1. В открывшемся окне выберите раздел **Сервисные аккаунты**.
     1. Выберите сервисный аккаунт из списка или воспользуйтесь поиском.
     1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль в каталоге.
     1. Нажмите кнопку **Сохранить**.

   - CLI {#cli}

     1. Узнайте идентификатор сервисного аккаунта (столбец `ID`), которому нужно назначить роль:

        ```bash
        yc iam service-account list
        ```

        Результат:

        ```text
        +----------------------+--------------+--------+---------------------+-----------------------+
        |          ID          |     NAME     | LABELS |     CREATED AT      | LAST AUTHENTICATED AT |
        +----------------------+--------------+--------+---------------------+-----------------------+
        | ajeg2b2et02f******** | terraform-sa |        | 2024-09-08 18:59:45 | 2025-08-21 06:40:00   |
        | ajegtlf2q28a******** | default-sa   |        | 2023-06-27 16:18:18 | 2025-08-21 06:30:00   |
        +----------------------+--------------+--------+---------------------+-----------------------+
        ```

     1. Назначьте сервисному аккаунту роль на ресурс:

        ```bash
        yc <service-name> <resource> add-access-binding <resource-name>|<resource-id> \
          --role <role-id> \
          --subject serviceAccount:<service-account-id>
        ```

        Где:
        * `<service-name>` — название [сервиса](../../cli/cli-ref/index.md#service-manage), на чей ресурс назначается роль, например `resource-manager`.
        * `<resource>` — категория ресурса, например `cloud` — для назначения роли на все [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) или `folder` — для назначения роли на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
        * `<resource-name>` — имя ресурса. Вы можете указать ресурс по имени или идентификатору (имя облака или каталога).
        * `<resource-id>` — идентификатор ресурса (идентификатор облака или каталога).
        * `<role-id>` — назначаемая роль, например `resource-manager.clouds.owner`.
        * `<service-account-id>` — идентификатор сервисного аккаунта, которому назначается роль.

        >Пример:
        > 
        >```bash
        >yc resource-manager folder add-access-binding **********9n9hi2qu --role editor --subject serviceAccount:**********qhi2qu
        >```
        >
        >Результат:
        >
        >```text
        >done (1s)
        >```

   - API {#api}

     Чтобы назначить сервисному аккаунту роль на облако или каталог, воспользуйтесь методом REST API `updateAccessBindings` для ресурса [Cloud](../../resource-manager/api-ref/Cloud/index.md) или [Folder](../../resource-manager/api-ref/Folder/index.md):
     
     1. Выберите роль, которую хотите назначить сервисному аккаунту. Описание ролей можно найти в документации Yandex Identity and Access Management в [справочнике ролей Yandex Cloud](../../iam/roles-reference.md).
     1. [Узнайте](../../resource-manager/operations/folder/get-id.md) ID каталога с сервисными аккаунтами.
     1. [Получите](../../iam/operations/iam-token/create.md) IAM-токен для аутентификации в API Yandex Cloud.
     1. Получите список сервисных аккаунтов в каталоге, чтобы узнать их идентификаторы:
     
         ```bash
         export FOLDER_ID=b1gvmob95yys********
         export IAM_TOKEN=CggaATEVAgA...
         curl \
           --header "Authorization: Bearer ${IAM_TOKEN}" \
           "https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts?folderId=${FOLDER_ID}"
         ```
     
         Результат:
     
     
         ```json
         {
          "serviceAccounts": [
           {
            "id": "ajebqtreob2d********",
            "folderId": "b1gvmob95yys********",
            "createdAt": "2018-10-18T13:42:40Z",
            "name": "my-robot",
            "description": "my description"
           }
          ]
         }
         ```
     
     1. Сформируйте тело запроса, например в файле `body.json`. В свойстве `action` укажите `ADD`, в свойстве `roleId` — нужную роль, например `editor`, а в свойстве `subject` — тип `serviceAccount` и идентификатор сервисного аккаунта:
     
         **body.json:**
         ```json
         {
           "accessBindingDeltas": [{
             "action": "ADD",
             "accessBinding": {
               "roleId": "editor",
               "subject": {
                 "id": "ajebqtreob2d********",
                 "type": "serviceAccount"
               }
             }
           }]
         }
         ```
     1. Назначьте роль сервисному аккаунту. Например, на каталог с идентификатором `b1gvmob95yys********`:
        
        ```bash
        export FOLDER_ID=b1gvmob95yys********
        export IAM_TOKEN=CggaAT********
        curl \
          --request POST \
          --header "Content-Type: application/json" \
          --header "Authorization: Bearer ${IAM_TOKEN}" \
          --data '@body.json' \
          "https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders/${FOLDER_ID}:updateAccessBindings"
        ```

   {% endlist %}

1. Добавьте аутентификационные данные в переменные окружения. При создании [IAM-токен](../../iam/concepts/authorization/iam-token.md) используйте [имперсонацию](../../iam/concepts/access-control/impersonation.md) созданного ранее сервисного аккаунта, указав его идентификатор в параметре `--impersonate-service-account-id`:

    {% note info %}
    
    Для использования имперсонации пользователю должна быть назначена [роль](../../iam/security/index.md#iam-serviceAccounts-tokenCreator) `iam.serviceAccounts.tokenCreator` на соответствующий сервисный аккаунт.
    
    {% endnote %}

    {% list tabs group=programming_language %}

    - Bash {#bash}

      ```bash
      export YC_TOKEN=$(yc iam create-token --impersonate-service-account-id <идентификатор_сервисного_аккаунта>)
      export YC_CLOUD_ID=$(yc config get cloud-id)
      export YC_FOLDER_ID=$(yc config get folder-id)
      ```

      Где:
      * `YC_TOKEN` — [IAM-токен](../../iam/concepts/authorization/iam-token.md) сервисного аккаунта.
      * `YC_CLOUD_ID` — идентификатор облака.
      * `YC_FOLDER_ID` — идентификатор каталога.

    - PowerShell {#powershell}

      ```powershell
      $Env:YC_TOKEN=$(yc iam create-token --impersonate-service-account-id <идентификатор_сервисного_аккаунта>)
      $Env:YC_CLOUD_ID=$(yc config get cloud-id)
      $Env:YC_FOLDER_ID=$(yc config get folder-id)
      ```

      Где:
      * `YC_TOKEN` — [IAM-токен](../../iam/concepts/authorization/iam-token.md) сервисного аккаунта.
      * `YC_CLOUD_ID` — идентификатор облака.
      * `YC_FOLDER_ID` — идентификатор каталога.

    {% endlist %}

    {% note info %}

    [Время жизни](../../iam/concepts/authorization/iam-token.md#lifetime) IAM-токена — не больше 12 часов, но рекомендуется запрашивать его чаще, например каждый час.
    
    Для автоматического перевыпуска IAM-токена можно использовать скрипт `export IAM_TOKEN=$(yc iam create-token)`.

    {% endnote %}

{% cut "Управление ресурсами от имени аккаунта на Яндексе или федеративного аккаунта" %}

{% note warning %}

Управление ресурсами от имени [аккаунта на Яндексе](../../iam/concepts/users/accounts.md#passport), [локального](../../iam/concepts/users/accounts.md#local) или [федеративного аккаунта](../../iam/concepts/users/accounts.md#saml-federation) пользователя является менее безопасным, чем использование [сервисного аккаунта](../../iam/concepts/users/service-accounts.md).

{% endnote %}

Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

Если вы используете федеративный или локальный аккаунт, аутентифицируйтесь в [CLI](../../cli/index.md):

* [от имени федеративного пользователя](../../cli/operations/authentication/federated-user.md);
* [от имени локального пользователя](../../cli/operations/authentication/local-user.md).

Добавьте аутентификационные данные в переменные окружения:

{% list tabs group=programming_language %}

- Bash {#bash}

  ```bash
  export YC_TOKEN=$(yc iam create-token)
  export YC_CLOUD_ID=$(yc config get cloud-id)
  export YC_FOLDER_ID=$(yc config get folder-id)
  ```

  Где:
  * `YC_TOKEN` — [IAM-токен](../../iam/concepts/authorization/iam-token.md).
  * `YC_CLOUD_ID` — идентификатор облака.
  * `YC_FOLDER_ID` — идентификатор каталога.

- PowerShell {#powershell}

  ```powershell
  $Env:YC_TOKEN=$(yc iam create-token)
  $Env:YC_CLOUD_ID=$(yc config get cloud-id)
  $Env:YC_FOLDER_ID=$(yc config get folder-id)
  ```

  Где:
  * `YC_TOKEN` — [IAM-токен](../../iam/concepts/authorization/iam-token.md).
  * `YC_CLOUD_ID` — идентификатор облака.
  * `YC_FOLDER_ID` — идентификатор каталога.

{% endlist %}

{% note info %}

[Время жизни](../../iam/concepts/authorization/iam-token.md#lifetime) IAM-токена — не больше 12 часов, но рекомендуется запрашивать его чаще, например каждый час.

Для автоматического перевыпуска IAM-токена можно использовать скрипт `export IAM_TOKEN=$(yc iam create-token)`.

{% endnote %}

{% endcut %}

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
     mv $env:APPDATA/terraform.rc $env:APPDATA/terraform.rc.old
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
   * `source` — глобальный [адрес источника](https://www.terraform.io/docs/language/providers/requirements.html#source-addresses) провайдера.
   * `required_version` — минимальная версия Terraform, с которой совместим провайдер.
   * `provider` — название провайдера.
   * `zone` — [зона доступности](../../overview/concepts/geo-scope.md), в которой по умолчанию будут создаваться все облачные ресурсы.
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

Если вы использовали [модули Terraform](../../tutorials/infrastructure-management/terraform-modules.md), сначала выполните `terraform init`, затем удалите lock-файл, а затем выполните команду `terraform providers lock`.

Подробнее о команде `terraform providers lock` в [документации Terraform](https://developer.hashicorp.com/terraform/cli/commands/providers/lock).

## Подключите модуль управления виртуальными сетями {#vpc-module}

Добавьте в конфигурацию модуль `terraform-yc-vpc` — с его помощью можно управлять сетевой инфраструктурой вашего [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud): сетями, подсетями, [шлюзами](../../vpc/concepts/gateways.md) и другими объектами Virtual Private Cloud. Создайте тестовую сеть с тремя подсетями в разных [зонах доступности](../../overview/concepts/geo-scope.md):

```hcl
module "yc-vpc" {
  source              = "github.com/terraform-yc-modules/terraform-yc-vpc.git"
  network_name        = "test-module-network"
  network_description = "Test network created with module"
  private_subnets = [{
    name           = "subnet-1"
    zone           = "ru-central1-a"
    v4_cidr_blocks = ["10.10.0.0/24"]
  },
  {
    name           = "subnet-2"
    zone           = "ru-central1-b"
    v4_cidr_blocks = ["10.11.0.0/24"]
  },
  {
    name           = "subnet-3"
    zone           = "ru-central1-d"
    v4_cidr_blocks = ["10.12.0.0/24"]
  }
  ]
}
```

## Подключите модуль Managed Service for Kubernetes {#k8s-module}

Добавьте в конфигурацию модуль `terraform-yc-vpc` и конфигурацию кластера Managed Service for Kubernetes с высокодоступным мастером и двумя группами узлов:

```hcl
module "kube" {
  source     = "github.com/terraform-yc-modules/terraform-yc-kubernetes.git"
  network_id = "${module.yc-vpc.vpc_id}"

  master_locations  = [
    for s in module.yc-vpc.private_subnets:
      {
        zone      = s.zone,
        subnet_id = s.subnet_id
      }
    ]

  master_maintenance_windows = [
    {
      day        = "monday"
      start_time = "23:00"
      duration   = "3h"
    }
  ]

  node_groups = {
    "yc-k8s-ng-01"  = {
      description   = "Kubernetes nodes group 01"
      fixed_scale   = {
        size = 3
      }
      node_labels   = {
        role        = "worker-01"
        environment = "testing"
      }
    },

    "yc-k8s-ng-02"  = {
      description   = "Kubernetes nodes group 02"
      auto_scale    = {
        min         = 2
        max         = 4
        initial     = 2
      }
      node_labels   = {
        role        = "worker-02"
        environment = "dev"
      }

      max_expansion   = 1
      max_unavailable = 1
    }
  }
}
```

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

   Результат:

   ```text
   main.tf
   variables.tf
   ```

## Создайте ресурсы {#create-resources}

1. После проверки конфигурации выполните команду:

   ```bash
   terraform plan
   ```

   В терминале будет выведен список ресурсов с параметрами. Это проверочный этап: ресурсы не будут созданы. Если в конфигурации есть ошибки, Terraform на них укажет.

   {% note alert %}

   Все созданные с помощью Terraform ресурсы тарифицируются. Внимательно проверьте план.

   {% endnote %}

1. Чтобы создать ресурсы, выполните команду:

   ```bash
   terraform apply
   ```

1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

   Terraform создаст все требуемые ресурсы, а в терминале будут указаны [IP-адреса](../../vpc/concepts/address.md) созданных [виртуальных машин](../../compute/concepts/vm.md). Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

## Как удалить созданные ресурсы {#delete-resources}

Чтобы удалить ресурсы, созданные с помощью Terraform:
1. Выполните команду:

   ```bash
   terraform destroy
   ```

   {% note alert %}

   Terraform удалит все ресурсы, созданные в текущей конфигурации: кластеры, [сети](../../vpc/concepts/network.md#network), [подсети](../../vpc/concepts/network.md#subnet), [виртуальные машины](../../compute/concepts/vm.md) и т. д.

   {% endnote %}

   После выполнения команды в терминал будет выведен список удаляемых ресурсов.
1. Введите слово `yes` и нажмите **Enter**.

## Полезные ссылки {#see-also}

* [Начало работы с Terraform](../../tutorials/infrastructure-management/terraform-quickstart.md).
* [Загрузка состояний Terraform в Object Storage](../../tutorials/infrastructure-management/terraform-state-storage.md).
* [Блокировка состояний Terraform с помощью Managed Service for YDB](../../tutorials/infrastructure-management/terraform-state-lock.md).
* [Источники данных Terraform](../../tutorials/infrastructure-management/terraform-data-sources.md).