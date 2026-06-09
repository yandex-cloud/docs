# Интерактивная отладка функций Yandex Cloud Functions


В этом руководстве вы настроите систему интерактивной отладки [функций](../../functions/concepts/function.md) Yandex Cloud Functions с помощью перенаправления запросов на локальный сервер. Подробнее о схеме решения читайте в [репозитории yc-serverless-live-debug](https://github.com/yandex-cloud/yc-serverless-live-debug).

Чтобы настроить систему интерактивной отладки функций:

1. [Подготовьте облако к работе](#prepare-cloud).
1. [Установите необходимые утилиты](#install-utilities).
1. [Создайте сервисный аккаунт с правами администратора на облако](#create-account).
1. [Разверните ресурсы](#create-resources).
1. [Запустите сервис отладки](#run-client).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).
 
## Подготовьте облако к работе {#prepare-cloud}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за вызовы функций и вычислительные ресурсы, выделенные для выполнения функций (см. [тарифы Yandex Cloud Functions](../../functions/pricing.md));
* плата за количество запросов к API-шлюзу (см. [тарифы Yandex API Gateway](../pricing.md));
* плата за операции с YDB и хранение данных (см. [тарифы Yandex Managed Service for YDB](../../ydb/pricing/serverless.md));
* плата за запись и хранение логов (см. [тарифы Yandex Cloud Logging](../../logging/pricing.md));

## Установите необходимые утилиты {#install-utilities}

1. [Установите Terraform](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
1. Создайте папку `live-debug-test` и перейдите в нее:

    ```
    mkdir live-debug-test
    cd live-debug-test
    ```

1. Установите пакет `yc-serverless-live-debug`:

    ```
    npm i -D @yandex-cloud/serverless-live-debug
    ```

## Создайте сервисный аккаунт с правами администратора на облако {#create-account}

1. Создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md):
   
    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать сервисный аккаунт.
      1. Перейдите в сервис **Identity and Access Management**.
      1. Нажмите кнопку **Создать сервисный аккаунт**.
      1. Введите имя сервисного аккаунта, например `sa-live-debug`.

          Требования к формату имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      1. Нажмите кнопку **Создать**.

    - CLI {#cli}

      Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

      Чтобы создать сервисный аккаунт, выполните команду:

      ```bash
      yc iam service-account create --name sa-live-debug
      ```

      Где `--name` — имя сервисного аккаунта в формате:

      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

      Результат:

      ```text
      id: ajehr0to1g8b********
      folder_id: b1gv87ssvu49********
      created_at: "2023-03-04T09:03:11.665153755Z"
      name: sa-live-debug
      ```

    - Terraform {#tf}

      Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
      
      
      Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

      1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:
    
          ```hcl
          resource "yandex_iam_service_account" "sa" {
            name        = "sa-live-debug"
            description = "<описание_сервисного_аккаунта>"
            folder_id   = "<идентификатор_каталога>"
          }
          ```

          Где:

          * `name` — имя сервисного аккаунта. Обязательный параметр.
          * `description` — описание сервисного аккаунта. Необязательный параметр.
          * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md). Необязательный параметр. По умолчанию будет использовано значение, указанное в настройках провайдера.

          Более подробную информацию о параметрах ресурса `yandex_iam_service_account` в Terraform, см. в [документации провайдера](../../terraform/resources/iam_service_account.md).
    
      1. Проверьте корректность конфигурационных файлов.

          1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
          1. Выполните проверку с помощью команды:

              ```bash
              terraform plan
              ```

          Если конфигурация описана верно, в терминале отобразится информация о сервисном аккаунте. Если в конфигурации есть ошибки, Terraform на них укажет. 

      1. Разверните облачные ресурсы.

          1. Если в конфигурации нет ошибок, выполните команду:

              ```bash
              terraform apply
              ```

    - API {#api}

      Чтобы создать сервисный аккаунт, воспользуйтесь методом REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).

    {% endlist %}

1. Назначьте сервисному аккаунту [роль](../../iam/concepts/access-control/roles.md) `admin` на облако: 

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. На [стартовой странице](https://console.yandex.cloud) консоли управления выберите облако.
      1. Перейдите на вкладку ![image](../../_assets/console-icons/persons.svg) **Права доступа**.
      1. Найдите аккаунт `sa-live-debug` в списке и нажмите значок ![image](../../_assets/console-icons/ellipsis.svg).
      1. Выберите ![image](../../_assets/console-icons/pencil.svg) **Изменить роли**.
      1. В открывшемся окне нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль `admin`.
      1. Нажмите кнопку **Сохранить**.

    - CLI {#cli}

      Выполните команду:

      ```
      yc resource-manager cloud add-access-binding <идентификатор_облака> \
         --role admin \
         --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

      Результат:
      ```
      done (1s)
      ```

    - Terraform {#tf}

      1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

          ```
          resource "yandex_resourcemanager_cloud_iam_member" "admin" {
            cloud_id = "<идентификатор_облака>"
            role     = "admin"
            member   = "serviceAccount:<идентификатор_сервисного_аккаунта>"
          }
          ```

          Где:

          * `cloud_id` — [идентификатор облака](../../resource-manager/operations/cloud/get-id.md). Обязательный параметр.
          * `role` — назначаемая роль. Обязательный параметр.
          * `member` — пользователь или сервисный аккаунт, которому назначается роль. Указывается в виде `userAccount:<идентификатор_пользователя>` или `serviceAccount:<идентификатор_сервисного_аккаунта>`. Обязательный параметр.

          Более подробную информацию о параметрах ресурса `yandex_resourcemanager_folder_iam_member` см. в [документации провайдера](../../terraform/resources/iam_service_account_iam_member.md).

      1. Проверьте корректность конфигурационных файлов.

          1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
          1. Выполните проверку с помощью команды:

              ```
               terraform plan
              ```

              Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет.

      1. Разверните облачные ресурсы.

          1. Если в конфигурации нет ошибок, выполните команду:

              ```
              terraform apply
              ```

    - API {#api}

      Чтобы назначить сервисному аккаунту роль на облако, воспользуйтесь методом REST API [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md).

    {% endlist %}

## Разверните ресурсы {#create-resources}

1. Настройте профиль CLI для выполнения операций от имени сервисного аккаунта:

    {% list tabs group=instructions %}

    - CLI {#cli}

      1. Создайте [авторизованный ключ](../../iam/concepts/authorization/key.md) для сервисного аккаунта и запишите его в файл:

          ```
          yc iam key create \
            --service-account-id <идентификатор_сервисного_аккаунта> \
            --folder-id <идентификатор_каталога> \
            --output key.json
          ```

          Где:
          * `--service-account-id` — идентификатор сервисного аккаунта `sa-live-debug`.
          * `--folder-id` — идентификатор каталога, в котором создан сервисный аккаунт.
          * `--output` — имя файла с авторизованным ключом.

          Результат:

          ```
          id: aje8nn871qo4********
          service_account_id: ajehr0to1g8********
          created_at: "2023-03-04T09:16:43.479156798Z"
          key_algorithm: RSA_2048
          ```

      1. Создайте профиль CLI для выполнения операций от имени сервисного аккаунта:

          ```
          yc config profile create sa-live-debug
          ```

          Результат:

          ```
          Profile 'sa-live-debug' created and activated
          ```

      1. Задайте конфигурацию профиля:

          ```
          yc config set service-account-key key.json
          yc config set cloud-id <идентификатор_облака>
          ```

          Где:
          * `service-account-key` — файл с авторизованным ключом сервисного аккаунта.
          * `cloud-id` — [идентификатор облака](../../resource-manager/operations/cloud/get-id.md).

      1. Добавьте аутентификационные данные в переменные окружения:

          ```
          export YC_TOKEN=$(yc iam create-token)
          export YC_CLOUD_ID=$(yc config get cloud-id)
          ```

    {% endlist %}

1. Разверните ресурсы в облаке, выполнив команду:

    ```
    npx serverless-live-debug deploy
    ```

    Команда создаст в облаке каталог `live-debug` и развернет в нем все необходимые ресурсы.

## Запустите сервис отладки {#run-client}

1. В папке `live-debug-test` создайте файл `live-debug.config.ts`:

    ```
    nano live-debug.config.ts
    ```

1. Скопируйте в файл `live-debug.config.ts` код с конфигурацией:

    ```
    import { defineConfig } from '@yandex-cloud/serverless-live-debug';
    import { Handler } from '@yandex-cloud/function-types';

    export default defineConfig({
      handler: <Handler.Http>(event => {
        console.log('got request', event);
        return {
          statusCode: 200,
          body: `Hello from local code!`,
        };
      })
    });
    ```

1. Запустите отладочный сервис, выполнив команду:

    ```
    npx serverless-live-debug run
    ```

    Результат:

    ```
    Using config: live-debug.config.ts
    Running local client...
    Starting child...
    Child started
    Watching changes in: live-debug.config.ts
    WS connection opened
    Local client ready.
    Check url: https://d5dm1lba80md********.i9******.apigw.yandexcloud.net
    Waiting requests...
    ```

    Где `Check url` — публичный адрес [API-шлюза](../concepts/index.md) API Gateway.

1. Проверьте, что отладочный код работает. Для этого откройте еще один терминал и выполните команду:

    ```
    curl https://d5dm1lba80md********.i9******.apigw.yandexcloud.net
    ```

    Результат:

    ```
    Hello from local code!
    ```

Подробнее о примерах использования решения читайте в [репозитории yc-serverless-live-debug](https://github.com/yandex-cloud/yc-serverless-live-debug). 

## Как удалить созданные ресурсы {#clear-out}

Удалите каталог, в котором находятся ресурсы, необходимые для интерактивной отладки функций Cloud Functions:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud/cloud) выберите каталог `live-debug`. 
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) напротив каталога и выберите **Удалить**.
  1. В поле **Срок удаления каталога** выберите `Удалить сейчас`.
  1. Нажмите **Удалить**.

- API {#api}

  Чтобы удалить каталог, воспользуйтесь методом REST API [delete](../../resource-manager/api-ref/Folder/delete.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/Delete](../../resource-manager/api-ref/grpc/Folder/delete.md).

{% endlist %}