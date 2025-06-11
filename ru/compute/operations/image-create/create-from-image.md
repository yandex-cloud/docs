---
title: Как создать образ из другого пользовательского образа в {{ compute-full-name }}
description: Следуя данной инструкции, вы сможете создать образ из другого пользовательского образа.
---

# Создать образ из другого пользовательского образа

Чтобы создать образ из другого пользовательского образа:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать образ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.compute.images_e7RdQ }}**.
  1. В строке с нужным снимком нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.compute.images.button_action-image }}**.
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
  
  1. Получите список образов в каталоге по умолчанию:
  
      {% include [compute-image-list](../../../_includes/compute/image-list.md) %}
  
  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного снимка.
  1. Создайте образ в каталоге по умолчанию:
  
      ```
      yc compute image create \
        --name new-image \
        --source-image-name first-image \
        --description "new image via yc"
      ```
  
      Данная команда создаст образ с именем `new-image` и описанием `new image via yc` из образа `first-image`.

      Чтобы создать [оптимизированный образ](../../concepts/image.md#images-optimized-for-deployment), используйте флаг `--pooled`:

      ```
      yc compute image create \
        --name new-image \
        --source-image-name first-image \
        --description "new image via yc" \
        --pooled
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурса `yandex_compute_image`.

     Пример структуры конфигурационного файла:

     ```
     resource "yandex_compute_image" "image-1" {
       name         = "<имя_образа>"
       source_image = "<идентификатор_образа-источника>"
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

  1. Получите список образов с помощью метода REST API [list](../../api-ref/Image/list.md) для ресурса [Image](../../api-ref/Image/index.md) или вызова gRPC API [ImageService/List](../../api-ref/grpc/Image/list.md).
  1. Создайте новый образ с помощью метода REST API [create](../../api-ref/Image/create.md) для ресурса [Image](../../api-ref/Image/index.md) или вызова gRPC API [ImageService/Create](../../api-ref/grpc/Image/create.md). В запросе укажите идентификатор образа-источника.

{% endlist %}

После создания образ перейдет в статус `CREATING`. Дождитесь, когда образ перейдет в статус `READY`, прежде чем его использовать.
