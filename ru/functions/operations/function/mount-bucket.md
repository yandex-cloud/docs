---
title: "Смонтировать бакеты в функцию"
description: "Следуя данной инструкции, вы сможете смонтировать бакеты в функцию."
---

# Смонтировать бакеты в функцию

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Выберите функцию.
  1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}**.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}** выберите или создайте новый [сервисный аккаунт](../../../iam/concepts/users/service-accounts) с ролью:
     * `storage.viewer`, чтобы только читать данные из смонтированного бакета.
     * `storage.uploader`, чтобы читать данные из смонтированного бакета и записывать их в него.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.title_mount-files }}** нажмите **{{ ui-key.yacloud.serverless-functions.item.editor.label_add-folder }}** и укажите:
      * **{{ ui-key.yacloud.serverless-functions.item.editor.label_mount-point-name }}** — имя точки монтирования. Директория, к которой смонтируется бакет, будет доступна по пути `/function/storage/<точка_монтирования>`.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.label_bucket }}** — имя бакета, который хотите смонтировать, или создайте новый.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.label_bucket-prefix }}** — [папку](../../../storage/concepts/object.md#folder) в бакете. Если поле пустое, смонтируется весь бакет.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.label_readonly }}** — запрет на запись в бакет. Если опция включена, данные из смонтированного бакета доступны только для чтения.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Чтобы смонтировать бакет в функцию, выполните команду:

  ```bash
  yc serverless function version create \
    --function-name=<имя_функции> \
    --runtime <среда_выполнения> \
    --entrypoint <точка_входа> \
    --memory <объем_RAM> \
    --execution-timeout <максимальное_время_выполнения> \
    --source-path <путь_к_ZIP-архиву> \
    --service-account-id <идентификатор_сервисного_аккаунта>
    --storage-mounts mount-point=<точка_монтирования>,bucket=<имя_бакета>,prefix=<имя_папки>,read-only=false
  ```

  Где:

  * `--function-name` — имя функции.
  * `--runtime` — среда выполнения.
  * `--entrypoint` — точка входа, указывается в формате `<имя_файла_без_расширения>.<имя_обработчика>`.
  * `--memory` — объем RAM.
  * `--execution-timeout` — максимальное время выполнения функции до таймаута.
  * `--source-path` — ZIP-архив c кодом функции и необходимыми зависимостями.
  * `--service-account-id` — идентификатор сервисного аккаунта. Для чтения данных из бакета аккаунту необходима роль `storage.viewer`, для записи — `storage.uploader`.
  * `--storage-mounts` — параметры монтирования [бакета](../../../storage/concepts/bucket.md) {{ objstorage-name }}:
    * `mount-point` — имя точки монтирования. Директория, к которой смонтируется бакет, будет доступна по пути `/function/storage/<точка_монтирования>`.
    * `bucket` — бакет.
    * `prefix` — [папка](../../../storage/concepts/object.md#folder) в бакете. Если поле пустое, смонтируется весь бакет.
    * `read-only` — запрет на запись в бакет. Если опция включена, данные из смонтированного бакета доступны только для чтения. Возможные значения: `true` и `false`.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы смонтировать бакет в функцию:

  1. Откройте файл конфигурации {{ TF }} и добавьте к описанию функции блок `storage_mounts`:

      ```hcl
      resource "yandex_function" "bucketfunction" {
        name               = "<имя_бакета>"
        user_hash          = "<хеш_функции>"
        runtime            = "<среда_выполнения>"
        entrypoint         = "<точка_входа>"
        memory             = "<объем_RAM>"
        execution_timeout  = "<максимальное время выполнения>"
        service_account_id = "<идентификатор_сервисного_аккаунта>"
        content {
          zip_filename = "<путь_к_ZIP-архиву>"
        }
        
        storage_mounts {
          mount_point_name = "<точка_монтирования>"
          bucket           = "<имя_бакета>"
          prefix           = "<имя_папки>"
          read_only        = <флаг_только_для_чтения>
        }
      }
      ```

      Где:

      * `storage_mounts` — параметры монтирования [бакета](../../../storage/concepts/bucket.md):
        * `mount_point_name` — имя точки монтирования. Директория, к которой смонтируется бакет, будет доступна по пути `/function/storage/<точка_монтирования>`.
        * `bucket` — бакет.
        * `prefix` — [папка](../../../storage/concepts/object.md#folder) в бакете. Если поле пустое, смонтируется весь бакет.
        * `read_only` — запрет на запись в бакет. Если опция включена, данные из смонтированного бакета доступны только для чтения. Возможные значения: `true` и `false`.

      Более подробную информацию о параметрах ресурса `yandex_function` см. в [документации провайдера]({{ tf-provider-resources-link }}/function).

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Проверить изменение функции и ее настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

  ```bash
  yc serverless function version get <идентификатор_версии_функции>
  ```

- API {#api}

  Чтобы смонтировать бакет в функцию, воспользуйтесь методом REST API [createVersion](../../functions/api-ref/Function/createVersion.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/CreateVersion](../../functions/api-ref/grpc/function_service.md#CreateVersion).

{% endlist %}

## См. также {#see-also}

* [Монтирование бакетов в функцию](../../concepts/mounting.md)
* [Монтирование бакетов в контейнер](../../../serverless-containers/concepts/mounting.md)
