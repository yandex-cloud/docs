
# Создать образ из диска

Чтобы создать образ из диска:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать образ.
  1. Выберите сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/disks-pic.svg) **Диски**.
  1. В строке с нужным диском нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) и выберите в меню команду **Создать образ**.
  1. Введите имя образа.

     * Длина — от 2 до 63 символов.
     * Может содержать строчные буквы латинского алфавита, цифры и дефисы.
     * Первый символ — буква. Последний символ — не дефис.

  1. Если требуется, укажите произвольное текстовое описание образа.
  1. Чтобы создать [оптимизированный образ](../../concepts/image.md#images-optimized-for-deployment), включите опцию **Оптимизировать для развертывания**.
  1. Нажмите **Создать**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания образа:
  
      ```
      yc compute image create --help
      ```
  
  1. Получите список дисков в каталоге по умолчанию:
  
      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}
  
  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного диска.
  1. Создайте образ в каталоге по умолчанию:
  
      ```
      yc compute image create \
        --name first-image \
        --source-disk-name first-disk \
        --description "my first image via yc"
      ```
  
      Данная команда создаст образ с именем `first-image` и описанием `my first image via yc` из диска `first-disk`.

      Чтобы создать [оптимизированный образ](../../concepts/image.md#images-optimized-for-deployment), используйте флаг `--pooled`:

      ```
      yc compute image create \
        --name first-image \
        --source-disk-name first-disk \
        --description "my first image via yc" \
        --pooled
      ```

- API

  1. Получите список дисков с помощью метода REST API [list](../../api-ref/Disk/list.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызова gRPC API [DiskService/List](../../api-ref/grpc/disk_service.md#List).
  1. Создайте образ с помощью метода REST API [create](../../api-ref/Image/create.md) для ресурса [Image](../../api-ref/Image/index.md) или вызова gRPC API [ImageService/Create](../../api-ref/grpc/image_service.md#Create). В запросе укажите идентификатор диска.

- {{ TF }}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры ресурса `yandex_compute_image`.

     Пример структуры конфигурационного файла:

     ```
     resource "yandex_compute_image" "image-1" {
       name        = "<имя образа>"
       source_disk = "<идентификатор диска>"
     }
     ```

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/).

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

{% endlist %}

После создания образ перейдет в статус `CREATING`. Дождитесь, когда образ перейдет в статус `READY`, прежде чем его использовать.
