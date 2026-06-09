# Смонтировать бакеты в функцию

Вы можете монтировать в функцию [бакеты](../../../storage/concepts/bucket.md) {{ objstorage-full-name }}. При монтировании бакета создается новая [версия](../../concepts/function.md#version) функции.

Чтобы смонтировать бакеты в функцию:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Выберите функцию.
  1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}**.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}** выберите или создайте новый [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) с ролью:
     * [`storage.viewer`](../../../storage/security/index.md#storage-viewer), чтобы только читать данные из смонтированного [бакета](../../../storage/concepts/bucket.md).
     * [`storage.uploader`](../../../storage/security/index.md#storage-uploader), чтобы читать данные из смонтированного бакета и записывать их в него.
  1. Раскройте секцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-additional-parameters }}**.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.title_mount-files }}**:
  
      1. Нажмите **{{ ui-key.yacloud.serverless-functions.item.editor.label_add-folder }}**.
      1. Укажите в поле:

          * **{{ ui-key.yacloud.serverless-functions.item.editor.label_mount-point-name }}** — точку монтирования. Директория, к которой смонтируется бакет, будет доступна по пути `/function/storage/<точка_монтирования>`.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.label_bucket }}** — бакет, который вы хотите смонтировать. При необходимости [создайте](../../../storage/operations/buckets/create.md) новый бакет.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.label_bucket-prefix }}** — [папку](../../../storage/concepts/object.md#folder) в бакете, которая будет смонтирована в контейнер. Если поле пустое, смонтируется весь бакет.
      1. Чтобы запретить запись в бакет, включите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_readonly }}**. Если опция включена, данные из смонтированного бакета будут доступны только для чтения.

      Чтобы смонтировать в функцию дополнительный бакет, повторно нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.label_add-folder }}** и задайте необходимые параметры.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Выполните команду:

  ```bash
  yc serverless function version create \
    --function-name=<имя_функции> \
    --runtime <среда_выполнения> \
    --entrypoint <точка_входа> \
    --memory <объем_RAM> \
    --execution-timeout <максимальное_время_выполнения> \
    --source-path <путь_к_ZIP-архиву> \
    --service-account-id <идентификатор_сервисного_аккаунта> \
    --mount type=object-storage,mount-point=<точка_монтирования>,bucket=<имя_бакета>,prefix=<имя_папки>,mode=<режим_монтирования>
  ```

  Где:

  * `--function-name` — имя функции.
  * `--runtime` — [среда выполнения](../../concepts/runtime/index.md#runtimes) функции.
  * `--entrypoint` — точка входа, указывается в формате `<имя_файла_без_расширения>.<имя_обработчика>`. Например: `index.handler`.
  * `--memory` — объем RAM.
  * `--execution-timeout` — максимальное время выполнения функции до таймаута.
  * `--source-path` — путь к ZIP-архиву, содержащему код функции и необходимые зависимости.
  * `--service-account-id` — [идентификатор](../../../iam/operations/sa/get-id.md) сервисного аккаунта. Для чтения данных из бакета сервисному аккаунту необходима [роль](../../../storage/security/index.md#storage-viewer) `storage.viewer`, для чтения и записи — [роль](../../../storage/security/index.md#storage-uploader) `storage.uploader`.
  * `--mount` — параметры монтирования [бакета](../../../storage/concepts/bucket.md) {{ objstorage-name }}:
      * `type` — тип монтируемого хранилища. Для бакета значение всегда `object-storage`.
      * `mount-point` — точка монтирования. Директория, к которой смонтируется бакет, будет доступна по пути `/function/storage/<точка_монтирования>`.
      * `bucket` — [имя](../../../storage/concepts/bucket.md#naming) бакета.
      * `prefix` — [папка](../../../storage/concepts/object.md#folder) в бакете, которая будет смонтирована в функции. Если поле не задано или пустое, смонтируется весь бакет.
      * `mode` — режим монтирования бакета: `ro` — только чтение, `rw` — чтение и запись.

      Чтобы смонтировать в функцию одновременно несколько бакетов, задайте параметр `--mount` необходимое количество раз.

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Откройте файл конфигурации {{ TF }} и добавьте к описанию функции блок `mounts`:

      ```hcl
      resource "yandex_function" "bucketfunction" {
        ...

        mounts {
          name = "<точка_монтирования>"
          mode = "<режим_монтирования>"
          object_storage {
            bucket = "<имя_бакета>"
            prefix = "<имя_папки>"
          }
        }

      }
      ```

      Где:

      * `mounts` — параметры монтирования [бакета](../../../storage/concepts/bucket.md) {{ objstorage-name }}:
          * `name` — точка монтирования. Директория, к которой смонтируется [бакет](../../../storage/concepts/bucket.md), будет доступна по пути `/function/storage/<точка_монтирования>`.
          * `mode` — режим монтирования бакета: `ro` — только чтение, `rw` — чтение и запись.
          * `object_storage` — параметры бакета:
              * `bucket` — [имя](../../../storage/concepts/bucket.md#naming) бакета.
              * `prefix` — [папка](../../../storage/concepts/object.md#folder) в бакете, которая будет смонтирована в контейнер. Если поле пустое, смонтируется весь бакет.

          Чтобы смонтировать в функцию одновременно несколько бакетов, задайте блок `mounts` необходимое количество раз.

      Более подробную информацию о параметрах ресурса `yandex_function` см. в [документации провайдера]({{ tf-provider-resources-link }}/function).

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

  Проверить изменение версии функции и ее настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

  ```bash
  yc serverless function version get <идентификатор_версии_функции>
  ```

- API {#api}

  Воспользуйтесь методом REST API [createVersion](../../functions/api-ref/Function/createVersion.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/CreateVersion](../../functions/api-ref/grpc/Function/createVersion.md).

{% endlist %}

## См. также {#see-also}

* [{#T}](../../concepts/mounting.md)
* [{#T}](../../../serverless-containers/concepts/mounting.md)