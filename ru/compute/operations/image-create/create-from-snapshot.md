---
title: "Как создать образ из снимка диска в {{ compute-full-name }}"
description: "Следуя данной инструкции, вы сможете создать образ из снимка диска." 
---

# Создать образ из снимка диска

Чтобы создать образ из снимка диска:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать образ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.switch_snapshots }}**.
  1. В строке с нужным снимком нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.compute.snapshots.list.button_action-image }}**.
  1. Введите имя образа. Требования к имени:

      {% include [name-format](../../../_includes/name-format.md) %}

  1. При необходимости укажите произвольное текстовое описание образа.
  1. Чтобы создать [оптимизированный образ](../../concepts/image.md#images-optimized-for-deployment), включите опцию **{{ ui-key.yacloud.compute.images.popup-upload_field_pooled }}**.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания образа:
  
      ```
      yc compute image create --help
      ```
  
  1. Получите список снимков в каталоге по умолчанию:
  
      {% include [compute-snapshot-list](../../_includes_service/compute-snapshot-list.md) %}
  
  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного снимка.
  1. Создайте образ в каталоге по умолчанию:
  
      ```
      yc compute image create \
        --name first-image \
        --source-snapshot-name first-snapshot \
        --description "my first image via yc"
      ```
  
      Данная команда создаст образ с именем `first-image` и описанием `my first image via yc` из снимка `first-snapshot`.

      Чтобы создать [оптимизированный образ](../../concepts/image.md#images-optimized-for-deployment), используйте флаг `--pooled`:

      ```
      yc compute image create \
        --name first-image \
        --source-snapshot-name first-snapshot \
        --description "my first image via yc" \
        --pooled
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурса `yandex_compute_image`.

     Пример структуры конфигурационного файла:

     ```
     resource "yandex_compute_image" "image-1" {
       name            = "<имя_образа>"
       source_snapshot = "<идентификатор_снимка>"
     }
     ```

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

       Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Разверните облачные ресурсы.

     1. Выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  1. Получите список снимков с помощью метода REST API [list](../../api-ref/Snapshot/list.md) для ресурса [Snapshot](../../api-ref/Snapshot/index.md) или вызова gRPC API [SnapshotService/List](../../api-ref/grpc/snapshot_service.md#List).
  1. Создайте образ с помощью метода REST API [create](../../api-ref/Image/create.md) для ресурса [Image](../../api-ref/Snapshot/index.md) или вызова gRPC API [ImageService/Create](../../api-ref/grpc/image_service.md#Create). В запросе укажите идентификатор снимка.

{% endlist %}

После создания образ перейдет в статус `CREATING`. Дождитесь, когда образ перейдет в статус `READY`, прежде чем его использовать.
