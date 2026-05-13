# Начало работы с Terraform


[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

Чтобы создать вашу первую инфраструктуру в Yandex Cloud с помощью Terraform:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Установите Terraform](#install-terraform).
1. [Получите данные для аутентификации](#get-credentials).
1. [Создайте файл конфигурации Terraform](#configure-terraform).
1. [Настройте провайдер](#configure-provider).
1. [Подготовьте план инфраструктуры](#prepare-plan).
1. [Проверьте и отформатируйте файлы конфигурации](#check-resources).
1. [Создайте ресурсы](#create-resources).

Если ресурсы больше вам не нужны, [удалите их](#delete-resources).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры, разворачиваемой через Terraform в этом руководстве, входят:
* плата за постоянно запущенные [виртуальные машины](../../compute/concepts/vm.md) (см. [тарифы Yandex Compute Cloud](../../compute/pricing.md));
* плата за использование динамических [публичных IP-адресов](../../vpc/concepts/address.md#public-addresses) (см. [тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).

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

Также вы можете использовать Terraform от имени [аккаунта на Яндексе](../../iam/concepts/users/accounts.md#passport), [федеративного](../../iam/concepts/users/accounts.md#saml-federation) или [локального пользователя](../../iam/concepts/users/accounts.md#local), однако этот способ является менее безопасным. Подробности см. в конце раздела.
1. Если у вас еще нет интерфейса командной строки Yandex Cloud, [установите](../../cli/quickstart.md#install) его.
1. Если у вас еще нет сервисного аккаунта, создайте его:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать сервисный аккаунт.
     1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Identity and Access Management**.
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

   Подробнее о настройках зеркал см. в [документации](https://www.terraform.io/cli/config/config-file#explicit-installation-method-configuration).
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

Если вы использовали [модули Terraform](terraform-modules.md), сначала выполните `terraform init`, затем удалите lock-файл, а затем выполните команду `terraform providers lock`.

Более подробную информацию о команде `terraform providers lock` см. в [документации Terraform](https://developer.hashicorp.com/terraform/cli/commands/providers/lock).

## Подготовьте план инфраструктуры {#prepare-plan}

С помощью Terraform в Yandex Cloud можно создавать облачные ресурсы всех типов: ВМ, [диски](../../compute/concepts/disk.md), [образы](../../compute/concepts/image.md) и т. д. Подробную информацию о ресурсах, создающихся с помощью Terraform, см. в [документации провайдера](../../terraform/index.md).

Для создания ресурса необходимо указать набор обязательных и опциональных параметров, определяющих свойства ресурса. Такие описания ресурсов составляют план инфраструктуры.

По плану будут созданы две ВМ: `terraform1` и `terraform2`, а также [облачная сеть](../../vpc/concepts/network.md#network) `network-1` с [подсетью](../../vpc/concepts/network.md#subnet) `subnet-1`.

Имена ресурсов должны соответствовать следующим требованиям:

* длина — от 3 до 63 символов;
* может содержать строчные буквы латинского алфавита, цифры и дефисы;
* первый символ — буква, последний — не дефис.

У ВМ будут разные [количества ядер и объемы памяти](../../compute/concepts/vm.md#types): 2 ядра и 2 ГБ оперативной памяти у `terraform1` и 4 ядра и 4 ГБ оперативной памяти у `terraform2`. ВМ автоматически получат публичные и [приватные IP-адреса](../../vpc/concepts/address.md#internal-addresses) из диапазона `192.168.10.0/24` в подсети `subnet-1`, находящейся в [зоне доступности](../../overview/concepts/geo-scope.md) `ru-central1-d` и принадлежащей облачной сети `network-1`. На ВМ будет установлена операционная система Ubuntu и размещена публичная часть ключа для доступа к ВМ по [SSH](../../glossary/ssh-keygen.md).

В конфигурации ВМ вам потребуется указать идентификатор образа загрузочного диска. Список доступных публичных образов можно получить командой [CLI](../../cli/quickstart.md):

```bash
yc compute image list --folder-id standard-images
```

Для доступа к ВМ через SSH [сгенерируйте пару SSH-ключей](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) и передайте публичную часть ключа на ВМ в параметре `ssh-keys` блока `metadata`.

Конфигурации ресурсов задаются сразу после конфигурации провайдера:


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
  * [Облачная сеть](../../vpc/concepts/network.md#network) `network-1` с [подсетью](../../vpc/concepts/network.md#subnet) `subnet-1` в [зоне доступности](../../overview/concepts/geo-scope.md) `ru-central1-d`.
  * Две [виртуальные машины](../../compute/concepts/vm.md) Linux: `terraform1` (2 ядра и 2 ГБ оперативной памяти) и `terraform2` (4 ядра и 4 ГБ оперативной памяти). Они автоматически получат [публичные и внутренние IP-адреса](../../vpc/concepts/address.md#internal-addresses) из диапазона `192.168.10.0/24` в подсети `subnet-1`.
  1. Получите идентификатор [образа](../../compute/concepts/image.md) загрузочного диска из Yandex Cloud Marketplace, например [Ubuntu 16.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-16-04-lts), который будет установлен на ВМ. Получите список доступных публичных образов, выполнив следующую команду [CLI](../../cli/index.md):
  
     ```bash
     yc compute image list --folder-id standard-images
     ```
  
  1. Сгенерируйте [пару SSH-ключей](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) для доступа к ВМ по [SSH](../../glossary/ssh-keygen.md).
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
       image_id = "fd87va5cc00gaq2f5qfb"
     }
  
     resource "yandex_compute_disk" "boot-disk-2" {
       name     = "boot-disk-2"
       type     = "network-hdd"
       zone     = "ru-central1-d"
       size     = "20"
       image_id = "fd87va5cc00gaq2f5qfb"
     }
  
     resource "yandex_compute_instance" "vm-1" {
       name = "terraform1"
  
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
       name = "terraform2"
  
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
  * [Облачная сеть](../../vpc/concepts/network.md#network) `ya-network` с [подсетью](../../vpc/concepts/network.md#subnet) `ya-network` в [зоне доступности](../../overview/concepts/geo-scope.md), указанной по умолчанию.
  * [Виртуальная машина](../../compute/concepts/vm.md) Windows: `terraform1` (2 ядра и 4 Гб оперативной памяти) и `terraform2` (4 ядра и 4 Гб оперативной памяти). Она автоматически получит публичные и [внутренние IP-адреса](../../vpc/concepts/address.md#internal-addresses) из диапазона `192.168.10.0/24` в подсети `ya-network`.
  
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
        zone      = var.zone
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
  
      resource "yandex_compute_instance" "default" {
        name     = var.name
        hostname = var.name
        zone     = var.zone
  
        resources {
          cores  = var.cores
          memory = var.memory
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
  
      output "name" {
        value = yandex_compute_instance.default.name
      }
  
      output "address" {
        value = yandex_compute_instance.default.network_interface.0.nat_ip_address
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
  
      variable "name" {
        type    = string
      }
  
      variable "cores" {
        type    = number
        default = 2
      }
  
      variable "memory" {
        type    = number
        default = 4
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
        default = ""
        type    = string
      }
  
      variable "user_pass" {
        default = ""
        type    = string
      }
  
      variable "admin_pass" {
        default = ""
        type    = string
      }
  
      variable "timeout_create" {
        default = "10m"
      }
  
      variable "timeout_delete" {
        default = "10m"
      }
      ```
  
     {% endcut %}
  
  1. `terraform.tfvars` — файл, где хранятся значения переменных для создаваемых внутри ВМ учетных записей и токены доступа.
  
      {% cut "Файл terraform.tfvars" %}
  
      ```hcl
      name       = "<my_server_name>"
      user_name  = "<my_user>"
      user_pass  = "<my_password>"
      admin_pass = "<my_password>"
      ```
  
     {% endcut %}

{% endlist %}

### Создайте пользователей {#users}

{% list tabs group=operating_system %}

- Linux {#linux}

  Для добавления пользователей, как и для изменения многих других параметров ОС создаваемой [виртуальной машины](../../compute/concepts/vm.md), в Yandex Cloud используется механизм [cloud-init](https://cloud-init.io). Для этого необходимо передать текст конфигурации `cloud-init` в параметре `user-data` в блоке `metadata`. В нашем случае это будут системные пользователи:
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
  
  Подробнее о работе с метаданными читайте в разделе [Метаданные виртуальной машины](../../compute/concepts/vm-metadata.md).

- Windows {#windows}

  Чтобы создать пользователя и установить пароль учетной записи Administrator на [виртуальную машину](../../compute/concepts/vm.md) в Yandex Cloud можно использовать агент [cloudbase-init](https://cloudbase-init.readthedocs.io/en/latest/). Для этого создайте скрипт `init.ps1`, который будет выполняться агентом при первой загрузке системы. В качестве учетных сведений будут использоваться переменные из файла `variables.tf`.
  
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

Проверить удаление ресурсов можно в [консоли управления](https://console.yandex.cloud).

#### См. также {#see-also}

* [Загрузка состояний Terraform в Object Storage](terraform-state-storage.md).
* [Блокировка состояний Terraform с помощью Managed Service for YDB](terraform-state-lock.md).
* [Использование модулей Yandex Cloud в Terraform](terraform-modules.md).
* [Источники данных Terraform](terraform-data-sources.md).
* [IaC: Terraform](https://yandex.cloud/ru/training/terraform?utm_source=inhouse&utm_medium=telegram&utm_campaign=announcement) — обучающий курс по управлению инфраструктурой в облаке с помощью Terraform.