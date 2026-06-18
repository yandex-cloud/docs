# Автоматическое сканирование Docker-образа при загрузке с помощью Terraform


{% note info %}

Автоматическое [сканирование](../../concepts/vulnerability-scanner.md) [Docker-образов](../../concepts/docker-image.md) на наличие уязвимостей при загрузке в [Yandex Container Registry](../../index.md) можно включить в [настройках сканера уязвимостей](../../operations/scanning-docker-image.md#automatically) без создания [функций](../../../functions/concepts/function.md) и [триггеров](../../../functions/concepts/trigger/index.md) [Yandex Cloud Functions](../../../functions/index.md).

{% endnote %}

Чтобы настроить автоматическое [сканирование](../../concepts/vulnerability-scanner.md) [Docker-образов](index.md) на наличие уязвимостей при загрузке в [Yandex Container Registry](../../index.md) с помощью Terraform:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Подготовьте окружение](#prepare).
1. [Создайте инфраструктуру](#deploy).
1. [Загрузите Docker-образ](#download-image).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:
* плата за хранение Docker-образа в [реестре](../../concepts/registry.md), сканер уязвимостей и исходящий трафик ([тарифы Yandex Container Registry](../../pricing.md));
* плата за вызовы [функций](../../../functions/concepts/function.md) ([тарифы Yandex Cloud Functions](../../../functions/pricing.md)).

## Подготовьте окружение {#prepare}

1. [Установите и настройте](../../operations/configure-docker.md) Docker.

## Создайте инфраструктуру {#deploy}

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

Чтобы создать инфраструктуру для автоматического сканирования Docker-образа при загрузке с помощью Terraform:
1. [Установите Terraform](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) и [получите данные для аутентификации](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials).
1. Укажите источник для установки провайдера Yandex Cloud (раздел [Настройте провайдер](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовая конфигурация {#ready}

     1. Клонируйте репозиторий с конфигурационными файлами.

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-cr-image-scanning
        ```

     1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
        * `image-auto-scan.tf` — конфигурация создаваемой инфраструктуры.
        * `image-auto-scan.auto.tfvars` — файл с пользовательскими данными.
        * `function.zip` — zip-архив с кодом функции.

   - Вручную {#manual}

     1. Создайте папку для конфигурационных файлов.
     1. Создайте в папке конфигурационный файл `image-auto-scan.tf`:

        {% cut "image-auto-scan.tf" %}

        ```hcl
        # Объявление переменных для пользовательских параметров
        
        variable "zone" {
          type = string
        }
        
        variable "folder_id" {
          type = string
        }
        
        # Добавление прочих переменных
        
        locals {
          sa_scanner_name    = "scanner"
          sa_invoker_name    = "invoker"
          registry_name      = "my-registry"
          function_name      = "scan-on-push"
          trigger_name       = "trigger-for-reg"
        }
        
        # Настройка провайдера
        
        terraform {
          required_providers {
            yandex    = {
              source  = "yandex-cloud/yandex"
              version = ">= 0.47.0"
            }
          }
        }
        
        provider "yandex" {
          folder_id = var.folder_id
        }
        
        # Создание сервисных аккаунтов
        
        resource "yandex_iam_service_account" "scanner" {
          name        = local.sa_scanner_name
          description = "SA for Container Registry"
          folder_id   = var.folder_id
        }
        
        resource "yandex_iam_service_account" "invoker" {
          name        = local.sa_invoker_name
          description = "SA for Cloud Functions"
          folder_id   = var.folder_id
        }
        
        # Назначение ролей сервисным аккаунтам
        
        resource "yandex_resourcemanager_folder_iam_member" "sa-role-scanner" {
          folder_id   = var.folder_id
          role        = "container-registry.images.scanner"
          member      = "serviceAccount:${yandex_iam_service_account.scanner.id}"
        }
        
        resource "yandex_resourcemanager_folder_iam_member" "sa-role-invoker" {
          folder_id   = var.folder_id
          role        = "functions.functionInvoker"
          member      = "serviceAccount:${yandex_iam_service_account.invoker.id}"
        }
        
        # Создание реестра Container Registry
        
        resource "yandex_container_registry" "my-reg" {
          name      = local.registry_name
          folder_id = var.folder_id
        }
        
        # Создание функции
        
        resource "yandex_function" "test-function" {
          name               = local.function_name
          user_hash          = "my-first-function"
          runtime            = "bash"
          entrypoint         = "handler.sh"
          memory             = "128"
          execution_timeout  = "60"
          service_account_id = yandex_iam_service_account.scanner.id
          content {
            zip_filename   = "function.zip"
          }
        }
        
        # Создание триггера
        
        resource "yandex_function_trigger" "my-trigger" {
        
          name = local.trigger_name
          function {
            id                 = yandex_function.test-function.id
            service_account_id = yandex_iam_service_account.invoker.id
          }
          container_registry {
            registry_id      = yandex_container_registry.my-reg.id
            create_image_tag = true
            batch_cutoff     = "10"
            batch_size       = "1"
          }
        }
        ```

        {% endcut %}

     1. Создайте файл с пользовательскими данными `image-auto-scan.auto.tfvars`:

        {% cut "image-auto-scan.auto.tfvars" %}

        ```hcl
        zone      = "<зона_доступности>"
        folder_id = "<идентификатор_каталога>"
        ```

        {% endcut %}

     1. Подготовьте zip-архив с кодом функции.
        1. Создайте файл `handler.sh` и скопируйте в него следующий код:

           {% cut "handler.sh" %}

           {% note warning %}
           
           Если вы создаете файл в Windows, убедитесь, что переносы строк имеют формат Unix: `\n`, а не `\r\n`. Заменить переносы можно в текстовом редакторе, например [Notepad++](https://notepad-plus-plus.org/), или с помощью утилиты [dos2unix](https://waterlan.home.xs4all.nl/dos2unix.html) или [Tofrodos](https://www.thefreecountry.com/tofrodos/).
           
           {% endnote %}

           ```bash
           DATA=$(cat | jq -sr '.[0].messages[0].details')
           ID=$(echo $DATA | jq -r '.image_id')
           NAME=$(echo $DATA | jq -r '.repository_name')
           TAG=$(echo $DATA | jq -r '.tag')
           yc container image scan --id ${ID} --async 1>&2
           ```

           {% endcut %}

        1. Создайте zip-архив `function.zip` с файлом `handler.sh`.

   {% endlist %}

   Подробнее о параметрах используемых ресурсов в документации провайдера Terraform:
   * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account](../../../terraform/resources/iam_service_account.md).
   * [Назначение прав доступа к каталогу](../../../iam/concepts/access-control/index.md#access-bindings) — [yandex_resourcemanager_folder_iam_member](../../../terraform/resources/resourcemanager_folder_iam_member.md).
   * [Реестр](../../concepts/registry.md) — [yandex_container_registry](../../../terraform/resources/container_registry.md).
   * [Функция](../../../functions/concepts/function.md) — [yandex_function](../../../terraform/resources/function.md).
   * [Триггер](../../../functions/concepts/trigger/index.md) — [yandex_function_trigger](../../../terraform/resources/function_trigger.md).

1. В файле `image-auto-scan.auto.tfvars` задайте пользовательские параметры:
   * `zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой будет создана инфраструктура.
   * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором будет создана инфраструктура.

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

## Загрузите Docker-образ {#download-image}

1. Запустите Docker Desktop.
1. Аутентифицируйтесь в реестре от своего имени с помощью:

   {% list tabs group=registry_auth %}

   - Docker Credential helper {#docker}

     1. Сконфигурируйте Docker для использования `docker-credential-yc`:

        ```bash
        yc container registry configure-docker
        ```

        Результат:

        ```text
        Credential helper is configured in '/home/<user>/.docker/config.json'
        ```

        Настройки сохраняются в профиле текущего пользователя.

        {% note warning %}

        Credential helper работает только при использовании Docker без `sudo`. О том, как настроить запуск Docker от имени текущего пользователя без использования `sudo` читайте в [официальной документации Docker](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user).

        {% endnote %}

     1. Проверьте, что Docker сконфигурирован.

        В конфигурационном файле `/home/<user>/.docker/config.json` должна появиться строка:

        ```json
        "cr.yandex": "yc"
        ```

     1. Docker готов к использованию, например, для [загрузки Docker-образов](../../operations/docker-image/docker-image-push.md). При этом выполнять команду `docker login` не надо.

   - OAuth-токена {#oauth-token}

     {% note info "Аутентификация по OAuth-токенам устарела" %}
     
     В будущем этот способ аутентификации перестанет поддерживаться. Рассмотрите использование [IAM-токенов](../../../iam/concepts/authorization/iam-token.md) или [API-ключей](../../../iam/concepts/authorization/api-key.md).
     
     {% endnote %}

     1. Если у вас еще нет [OAuth-токена](../../../iam/concepts/authorization/oauth-token.md), получите его по [ссылке](https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb).
     1. Выполните команду:

        ```bash
        echo <OAuth-токен> | docker login --username oauth --password-stdin cr.yandex
        ```
 
        Результат:

        ```text
        Login Succeeded
        ```

   - IAM-токена {#iam-token}

     {% note info %}

     У IAM-токена короткое [время жизни](../../../iam/concepts/authorization/iam-token.md#lifetime) — не более  12 часов. Поэтому такой способ подойдет для приложений, которые будут запрашивать IAM-токен автоматически.

     {% endnote %}

     1. [Получите](../../../iam/operations/iam-token/create.md) [IAM-токен](../../../iam/concepts/authorization/iam-token.md).
     1. Выполните команду:

        ```bash
        yc iam create-token | docker login --username iam --password-stdin cr.yandex
        ```

        Результат:

        ```text
        Login Succeeded
        ```

   {% endlist %}

1. Скачайте Docker-образ с [Docker Hub](https://hub.docker.com/):

   ```bash
   docker pull ubuntu:20.04
   ```

   Результат:

   ```text
   20.04: Pulling from library/ubuntu
   Digest: sha256:cf31af331f38d1d7158470e095b132acd126a7180a54f263d386da88********
   Status: Image is up to date for ubuntu:20.04
   docker.io/library/ubuntu:20.04
   ```

1. Присвойте тег Docker-образу:

   ```bash
   docker tag ubuntu:20.04 cr.yandex/<идентификатор_реестра>/ubuntu:20.04
   ```

1. Загрузите Docker-образ в Container Registry:

   ```bash
   docker push cr.yandex/<идентификатор_реестра>/ubuntu:20.04
   ```

   Результат:

   ```text
   The push refers to repository [cr.yandex/crpu20rpdc2f********/ubuntu]
   2f140462f3bc: Layer already exists
   63c99163f472: Layer already exists
   ccdbb80308cc: Layer already exists
   20.04: digest: sha256:86ac87f73641c920fb42cc9612d4fb57b5626b56ea2a19b894d0673f******** size: 943
   ```

## Проверьте результат {#check-result}

1. Просмотрите логи функции `scan-on-push` и убедитесь, что она выполнилась.

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите сервис **Cloud Functions**.
     1. Перейдите в раздел **Функции** и выберите функцию `scan-on-push`.
     1. В открывшемся окне перейдите в раздел **Логи** и укажите период. По умолчанию задан период за 1 час.

   - CLI {#cli}

     Чтобы узнать имя или уникальный идентификатор функции, [получите](../../../functions/operations/function/function-list.md) список функций в каталоге.

     Посмотрите журнал выполнения функции:

     ```bash
     yc serverless function logs scan-on-push
     ```

     Результат:

     ```text
     2021-05-18 09:27:43  START RequestID: 34dc9533-ed6e-4468-b9f2-2aa0******** Version: b09i2s85a0c1********
     2021-05-18 09:27:43  END RequestID: 34dc9533-ed6e-4468-b9f2-2aa0********
     2021-05-18 09:27:43  REPORT RequestID: 34dc9533-ed6e-4468-b9f2-2aa0******** Duration: 538.610 ms Billed Duration: 538.700 ms Memory Size: 128 MB Max Memory Used: 13 MB
     2021-05-18 09:29:25  START RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f******** Version: b09i2s85a0c1********
     2021-05-18 09:29:26  END RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f********
     2021-05-18 09:29:26  REPORT RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f******** Duration: 554.904 ms Billed Duration: 555.000 ms Memory Size: 128 MB Max Memory Used: 13 MB
     ...
     ```

   {% endlist %}

1. Проверьте, что при загрузке Docker-образа запустилось новое сканирование.

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит реестр, содержащий Docker-образ.
     1. Выберите сервис **Container Registry**.
     1. Выберите реестр, в который загрузили Docker-образ.
     1. Откройте репозиторий, в котором находится Docker-образ.
     1. Выберите нужный Docker-образ и проверьте значение параметра **Дата последнего сканирования**.

   - CLI {#cli}

     Чтобы посмотреть запуски сканирования по Docker-образу, выполните команду:

     ```bash
     yc container image list-scan-results --repository-name=<идентификатор_реестра>/<имя_Docker-образа>
     ```

     Результат:

     ```text
     +----------------------+----------------------+---------------------+--------+--------------------------------+
     |          ID          |        IMAGE         |     SCANNED AT      | STATUS |        VULNERABILITIES         |
     +----------------------+----------------------+---------------------+--------+--------------------------------+
     | crpu20rpdc2f******** | crpqmsqp5mtb******** | 2021-05-18 14:34:02 | READY  | medium:6, low:13, negligible:3 |
     +----------------------+----------------------+---------------------+--------+--------------------------------+
     ```

   {% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `image-auto-scan.tf` и удалите описание создаваемой инфраструктуры из файла.
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

* [Автоматическое сканирование Docker-образа при загрузке с помощью консоли управления, CLI и API](console.md)