# Создать образ из снимка диска

Чтобы создать образ из снимка диска:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать образ.
  1. Выберите сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/snapshots.svg) **Снимки дисков**.
  1. В строке с нужным снимком нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) и выберите в меню команду **Создать образ**.
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

- {{ TF }}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры ресурса `yandex_compute_image`.

     Пример структуры конфигурационного файла:

     ```
     resource "yandex_compute_image" "image-1" {
       name            = "<имя образа>"
       source_snapshot = "<идентификатор снимка>"
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

- API

  1. Получите список снимков с помощью метода [SnapshotService/List](../../api-ref/grpc/snapshot_service.md#List) gRPC API или метода [list](../../api-ref/Snapshot/list.md) ресурса `Snapshot` REST API.
  1. Создайте образ с помощью метода [ImageService/Create](../../api-ref/grpc/image_service.md#Create) gRPC API или метода [create](../../api-ref/Image/create.md) ресурса `Image` REST API. В запросе укажите идентификатор снимка.

{% endlist %}

После создания образ перейдет в статус `CREATING`. Дождитесь, когда образ перейдет в статус `READY`, прежде чем его использовать.
