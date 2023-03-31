# Удаление бакета

{% note warning %}

Удалить можно только пустой бакет. В консоли управления информация о количестве объектов в бакете обновляется с задержкой в несколько минут.

{% endnote %}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, из которого хотите удалить бакет.
  1. Выберите сервис **{{ objstorage-name }}**. Вы попадете на страницу со списком бакетов.
  1. Чтобы удалить один бакет, нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) слева от имени бакета и выберите **{{ ui-key.yacloud.storage.bucket.button_action-delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.storage.file.popup-confirm_button_delete }}**.

- {{ yandex-cloud }} CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления бакета:

      ```bash
      yc storage bucket delete --help
      ```

  1. Получите список бакетов в каталоге по умолчанию:

      ```bash
      yc storage bucket list
      ```

      Результат:

      ```text
      +------------------+----------------------+-------------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      | first-bucket     | b1gmit33ngp6cv2mhjmo | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      ```
   
   1. Сохраните имя бакета (столбец `NAME`), который нужно удалить.
   1. Удалите бакет:

       ```bash
       yc storage bucket delete --name <имя_бакета>
       ```

       Где `--name` — имя бакета, который нужно удалить.

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  
  Подробнее о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


  Чтобы удалить бакет, созданный с помощью {{ TF }}:
  1. Откройте файл конфигураций {{ TF }} и удалите фрагмент с описанием бакета.

     {% cut "Пример описания бакета в конфигурации {{ TF }}" %}

     ```hcl
     ...
     resource "yandex_storage_bucket" "test" {
       access_key = "YCAJEX9Aw2ge1VKjlYXf-w-lJ"
       secret_key = "YCONxG7rSdzVF9UMxLA_NRy5VbKzKlqZMcSJz2N0"
       bucket     = "tf-test-bucket"
     }
     ...
     ```

     {% endcut %}

  1. В командной строке перейдите в папку, где расположен файл конфигурации {{ TF }}.
  1. Проверьте конфигурацию командой:

     ```bash
     terraform validate
     ```

     Если конфигурация является корректной, появится сообщение:

     ```text
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

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменения можно в [консоли управления]({{ link-console-main }}).

- API
  
  Чтобы удалить бакет, воспользуйтесь методом REST API [delete](../../api-ref/Bucket/delete.md) для ресурса [Bucket](../../api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Delete](../../api-ref/grpc/bucket_service.md#Delete) или методом S3 API [deleteBucket](../../s3/api-ref/bucket/delete.md).

{% endlist %}