# Интерактивная отладка функций {{ sf-name }}

В этом руководстве вы настроите систему интерактивной отладки [функций](../../functions/concepts/function.md) {{ sf-full-name }} с помощью перенаправления запросов на локальный сервер. Подробнее о схеме решения читайте в [репозитории yc-serverless-live-debug](https://github.com/yandex-cloud/yc-serverless-live-debug).

Чтобы настроить систему интерактивной отладки функций:

1. [Подготовьте облако к работе](#prepare-cloud).
1. [Установите необходимые утилиты](#install-utilities).
1. [Создайте сервисный аккаунт с правами администратора на облако](#create-account).
1. [Разверните ресурсы](#create-resources).
1. [Запустите сервис отладки](#run-client).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).
 
## Подготовьте облако к работе {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за вызовы функций и вычислительные ресурсы, выделенные для выполнения функций (см. [тарифы {{ sf-full-name }}](../../functions/pricing.md));
* плата за количество запросов к API-шлюзу (см. [тарифы {{ api-gw-full-name }}](../../api-gateway/pricing.md));
* плата за операции с {{ ydb-short-name }} и хранение данных (см. [тарифы {{ ydb-full-name }}](../../ydb/pricing/serverless.md));
* плата за запись и хранение логов (см. [тарифы {{ cloud-logging-full-name }}](../../logging/pricing.md));


## Установите необходимые утилиты {#install-utilities}

1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
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
   
    {% list tabs %}

    - Консоль управления

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать сервисный аккаунт.
      1. На вкладке **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. Введите имя сервисного аккаунта, например `sa-live-debug`.

          Требования к формату имени:

          {% include [name-format](../../_includes/name-format.md) %}

      1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

    - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      Чтобы создать сервисный аккаунт, выполните команду:

      ```bash
      yc iam service-account create --name sa-live-debug
      ```

      Где `--name` — имя сервисного аккаунта в формате:

      {% include [name-format](../../_includes/name-format.md) %}

      Результат:

      ```yaml
      id: ajehr0to1g8b********
      folder_id: b1gv87ssvu49********
      created_at: "2023-03-04T09:03:11.665153755Z"
      name: sa-live-debug
      ```

    - API

      Чтобы создать сервисный аккаунт, воспользуйтесь методом REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/service_account_service.md#Create).

    - {{ TF }}

      {% include [terraform-install](../../_includes/terraform-install.md) %}

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

          Более подробную информацию о параметрах ресурса `yandex_iam_service_account` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/iam_service_account).
    
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

    {% endlist %}

1. Назначьте сервисному аккаунту [роль](../../iam/concepts/access-control/roles.md) `{{ roles-admin }}` на облако: 

    {% list tabs %}

    - Консоль управления

      1. На [стартовой странице]({{ link-console-main }}) консоли управления выберите облако.
      1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
      1. Найдите аккаунт `sa-live-debug` в списке и нажмите значок ![image](../../_assets/console-icons/ellipsis.svg).
      1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
      1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud_components.acl.action.add-role }}** и выберите роль `{{ roles-admin }}`.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

    - CLI

      Выполните команду:

      ```
      yc resource-manager cloud add-access-binding <идентификатор_облака> \
         --role {{ roles-admin }} \
         --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

      Результат:
      ```
      done (1s)
      ```

    - API

      Чтобы назначить сервисному аккаунту роль на облако, воспользуйтесь методом REST API [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/service_account_service.md#SetAccessBindings).

    - {{ TF }}

      1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

          ```
          resource "yandex_resourcemanager_cloud_iam_member" "{{ roles-admin }}" {
            cloud_id = "<идентификатор_облака>"
            role     = "{{ roles-admin }}"
            member   = "serviceAccount:<идентификатор_сервисного_аккаунта>"
          }
          ```

          Где:

          * `cloud_id` — [идентификатор облака](../../resource-manager/operations/cloud/get-id.md). Обязательный параметр.
          * `role` — назначаемая роль. Обязательный параметр.
          * `member` — пользователь или сервисный аккаунт, которому назначается роль. Указывается в виде `userAccount:<идентификатор_пользователя>` или `serviceAccount:<идентификатор_сервисного_аккаунта>`. Обязательный параметр.

          Более подробную информацию о параметрах ресурса `yandex_resourcemanager_folder_iam_member` см. в [документации провайдера]({{ tf-provider-resources-link }}/iam_service_account_iam_member).

      1. Проверьте корректность конфигурационных файлов.

          1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
          1. Выполните проверку с помощью команды:

              ```
               terraform plan
              ```

              Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

      1. Разверните облачные ресурсы.

          1. Если в конфигурации нет ошибок, выполните команду:

              ```
              terraform apply
              ```

    {% endlist %}

## Разверните ресурсы {#create-resources}

1. Настройте профиль CLI для выполнения операций от имени сервисного аккаунта:

    {% list tabs %}

    - CLI

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
    Check url: https://d5ddt4ltdvh7********.apigw.yandexcloud.net
    Waiting requests...
    ```

    Где `Check url` — публичный адрес [API-шлюза](../../api-gateway/concepts/index.md) {{ api-gw-name }}.

1. Проверьте, что отладочный код работает. Для этого откройте еще один терминал и выполните команду:

    ```
    curl https://d5ddt4ltdvh7********.apigw.yandexcloud.net
    ```

    Результат:

    ```
    Hello from local code!
    ```

Подробнее о примерах использования решения читайте в [репозитории yc-serverless-live-debug](https://github.com/yandex-cloud/yc-serverless-live-debug). 

## Как удалить созданные ресурсы {#clear-out}

Удалите каталог, в котором находятся ресурсы, необходимые для интерактивной отладки функций {{ sf-name }}:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-cloud }}) выберите каталог `live-debug`. 
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) напротив каталога и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. В поле **{{ ui-key.yacloud.component.iam-delete-folder-or-cloud-dialog.field_folder-delete-after }}** выберите `{{ ui-key.yacloud.component.iam-delete-folder-or-cloud-dialog.label_delete-now }}`.
  1. Нажмите **{{ ui-key.yacloud.common.delete }}**.

- API

  Чтобы удалить каталог, воспользуйтесь методом REST API [delete](../../resource-manager/api-ref/Folder/delete.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/Delete](../../resource-manager/api-ref/grpc/folder_service.md#Delete).

{% endlist %}