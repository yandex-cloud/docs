---
title: "Как смонтировать эфемерный диск в контейнер {{ serverless-containers-full-name }}"
description: "Следуя данной инструкции, вы сможете смонтировать эфемерный диск в контейнер {{ serverless-containers-name }}."
---

# Смонтировать эфемерный диск в контейнер

{% include [preview](../../_includes/note-preview-by-request.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}
    
    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. Выберите контейнер.
    1. В меню слева выберите ![image](../../_assets/console-icons/pencil-to-square.svg)**{{ ui-key.yacloud.serverless-containers.label_editor }}**.
    1. В блоке **Эфемерный диск** нажмите **Добавить эфемерный диск** и укажите в поле:
       * **Точка монтирования** — имя точки монтирования. Директория, к которой смонтируется диск. По этому пути нельзя размещать ничего, кроме пустой директории, иначе при инициализации контейнера может возникнуть ошибка и смонтированные эфемерные диски будут недоступны. Чтобы эфемерный диск монтировался корректно, указывайте полный абсолютный путь к точке монтирования.
       * **Размер диска** — размер памяти, который вы хотите выделить для монтируемого эфемерного диска.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы смонтировать эфемерный диск в контейнер, выполните команду:

  ```bash
  yc serverless container revision deploy \
    --container-name=<имя_контейнера> \
    --environment <среда_выполнения> \
    --image <путь_к_образу_контейнера> \
    --memory <объем_RAM> \
    --execution-timeout <максимальное_время_выполнения> \
    --service-account-id <идентификатор_сервисного_аккаунта> \
    --mount type=ephemeral-disk,mount-point=<точка_монтирования>,size=<размер_диска>
  ```

  Где:

  * `--container-name` — имя контейнера.
  * `--environment` — среда выполнения.
  * `--image` — путь к образу контейнера.
  * `--memory` — объем RAM.
  * `--execution-timeout` — максимальное время выполнения контейнера до таймаута.
  * `--service-account-id` — идентификатор сервисного аккаунта.
  * `--mount` — параметры монтирования эфемерного диска:
    * `type=ephemeral-disk` — тип монтируемой файловой системы.
    * `mount-point` — имя точки монтирования. Директория, к которой смонтируется диск. По этому пути нельзя размещать ничего, кроме пустой директории, иначе при инициализации контейнера может возникнуть ошибка, и смонтированные эфемерные диски будут недоступны. Чтобы эфемерный диск монтировался корректно, указывайте полный абсолютный путь к точке монтирования.
    * `size` — размер эфемерного диска в ГБ. Например: `size=5GB`.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы смонтировать эфемерный диск в контейнер:

  1. Откройте файл конфигурации {{ TF }} и добавьте к описанию контейнера блок `mounts`:

      ```hcl
      resource "yandex_serverless_container" "ephemeral_storage_container" {
        name               = "<имя_контейнера>"
        memory             = "<объем_RAM>"
        execution_timeout  = "<максимальное_время_выполнения>"
        service_account_id = "<идентификатор_сервисного_аккаунта>"
        content {
          zip_filename = "<путь_к_ZIP-архиву>"
        }

        mounts {
          mount_point_path = <точка_монтирования>
          ephemeral_disk {
            size_gb = <размер_диска>
          }
        }

        image {
          url = <путь_к_образу_контейнера>
        }
      }
      ```

      Где:

      * `mounts` — параметры монтирования эфемерного диска:
        * `mount_point_path` — имя точки монтирования. Директория, к которой смонтируется диск. По этому пути нельзя размещать ничего, кроме пустой директории, иначе при инициализации контейнера может возникнуть ошибка, и смонтированные эфемерные диски будут недоступны. Чтобы эфемерный диск монтировался корректно, указывайте полный абсолютный путь к точке монтирования.
        * `size_gb` — размер эфемерного диска в ГБ. Например: `size=5GB`.

      Более подробную информацию о параметрах ресурса `yandex_serverless_container` см. в [документации провайдера]({{ tf-provider-resources-link }}/serverless_container).

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Проверить изменение контейнера и его настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

  ```bash
  yc serverless container version get <идентификатор_контейнера>
  ```

- API {#api}

  Чтобы смонтировать эфемерный диск, воспользуйтесь методом REST API [deployRevision](../containers/api-ref/Container/deployRevision.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/DeployRevision](../containers/api-ref/grpc/container_service.md#DeployRevision).

{% endlist %}

## См. также {#see-also}

* [Монтирование файловых систем в контейнер](../concepts/mounting.md)
* [Монтирование файловых систем в функцию](../../functions/concepts/mounting.md)
