---
title: Как смонтировать эфемерный диск в функцию {{ sf-full-name }}
description: Следуя данной инструкции, вы сможете смонтировать эфемерный диск в функцию {{ sf-name }}.
---

# Смонтировать эфемерный диск в функцию

{% include [preview-and-request](../../../_includes/note-preview-by-request.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Выберите функцию.
  1. В меню слева выберите ![image](../../../_assets/console-icons/pencil-to-square.svg)**{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}**.
  1. В блоке **Эфемерный диск** нажмите **Добавить эфемерный диск** и укажите в поле:
      * **Точка монтирования** — имя точки монтирования. Директория, к которой монтируется эфемерный диск, будет доступна по пути `/function/storage/<точка_монтирования>`.
      * **Размер диска** — размер памяти, который вы хотите выделить для монтируемого эфемерного диска.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Чтобы смонтировать эфемерный диск в функцию, выполните команду:

  ```bash
  yc serverless function version create \
    --function-name=<имя_функции> \
    --runtime <среда_выполнения> \
    --entrypoint <точка_входа> \
    --memory <объем_RAM> \
    --execution-timeout <максимальное_время_выполнения> \
    --source-path <путь_к_ZIP-архиву> \
    --service-account-id <идентификатор_сервисного_аккаунта> \
    --mount type=ephemeral-disk,mount-point=<точка_монтирования>,size=<размер_диска>
  ```

  Где:

  * `--function-name` — имя функции.
  * `--runtime` — среда выполнения.
  * `--entrypoint` — точка входа, указывается в формате `<имя_файла_без_расширения>.<имя_обработчика>`.
  * `--memory` — объем RAM.
  * `--execution-timeout` — максимальное время выполнения функции до таймаута.
  * `--source-path` — ZIP-архив c кодом функции и необходимыми зависимостями.
  * `--service-account-id` — идентификатор сервисного аккаунта.
  * `--mount` — параметры монтирования эфемерного диска:
    * `type=ephemeral-disk` — тип монтируемой файловой системы.
    * `mount-point` — имя точки монтирования. Директория, к которой смонтируется диск, будет доступна по пути `/function/storage/<точка_монтирования>`.
    * `size` — размер эфемерного диска в ГБ. Например: `size=5GB`.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы смонтировать эфемерный диск в функцию:

  1. Откройте файл конфигурации {{ TF }} и добавьте к описанию функции блок `mounts`:

      ```hcl
      resource "yandex_function" "ephemeral_storage_function" {
        name               = "<имя_функции>"
        user_hash          = "<хеш_функции>"
        runtime            = "<среда_выполнения>"
        entrypoint         = "<точка_входа>"
        memory             = "<объем_RAM>"
        execution_timeout  = "<максимальное_время_выполнения>"
        service_account_id = "<идентификатор_сервисного_аккаунта>"
        content {
          zip_filename = "<путь_к_ZIP-архиву>"
        }

        mounts {
          name = "<точка_монтирования>"
          ephemeral_disk {
            size_gb = <размер_диска>
          }
        }
      }
      ```

      Где:

      * `mounts` — параметры монтирования эфемерного диска:
        * `name` — имя точки монтирования. Директория, к которой смонтируется диск, будет доступна по пути `/function/storage/<точка_монтирования>`.
        * `size_gb` — размер эфемерного диска в ГБ. Например: `size=5GB`.

      Более подробную информацию о параметрах ресурса `yandex_function` см. в [документации провайдера]({{ tf-provider-resources-link }}/function).

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Проверить изменение функции и ее настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

  ```bash
  yc serverless function version get <идентификатор_версии_функции>
  ```

- API {#api}

  Чтобы смонтировать эфемерный диск в функцию, воспользуйтесь методом REST API [createVersion](../../functions/api-ref/Function/createVersion.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/CreateVersion](../../functions/api-ref/grpc/Function/createVersion.md).

{% endlist %}

## См. также {#see-also}

* [Монтирование файловых систем в функцию](../../concepts/mounting.md)
* [Монтирование файловых систем в контейнер](../../../serverless-containers/concepts/mounting.md)
