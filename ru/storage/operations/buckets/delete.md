---
title: "Как удалить бакет"
description: "Следуя данной инструкции, вы сможете удалить бакет."
---

# Удаление бакета

{% note warning %}

Удалить можно только пустой бакет. В консоли управления информация о количестве объектов в бакете обновляется с задержкой в несколько минут.

{% endnote %}

Чтобы удалить бакет, в который [записываются логи](../../concepts/server-logs.md) другого бакета, в настройках исходного бакета [выключите механизм логирования](enable-logging.md#stop-logging) или выберите другой целевой бакет для хранения логов.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, из которого хотите удалить бакет.
  1. Выберите сервис **{{ objstorage-name }}**. Вы попадете на страницу со списком бакетов.
  1. Чтобы удалить один бакет, нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) слева от имени бакета и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.storage.file.popup-confirm_button_delete }}**.

  {% include [work-with-multiple-buckets](../../../_includes/storage/work-with-multiple-buckets.md) %}

- {{ yandex-cloud }} CLI {#cli}

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
      | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      ```
   
  1. Сохраните имя бакета (столбец `NAME`), который нужно удалить.
  1. Удалите бакет:

      ```bash
      yc storage bucket delete --name <имя_бакета>
      ```

      Где `--name` — имя бакета, который нужно удалить.

      {% include [work-with-multiple-buckets](../../../_includes/storage/work-with-multiple-buckets.md) %}

- AWS CLI {#aws-cli}

  Если у вас еще нет интерфейса командной строки AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).
    
  В терминале выполните команду `aws s3api delete-bucket`:

  ```bash
  aws s3api delete-bucket \
    --endpoint-url=https://{{ s3-storage-host }} \
    --bucket <имя_бакета>
  ```

  Где:
  * `--bucket` — имя бакета, который нужно удалить.
  * `--endpoint-url` — эндпоинт {{ objstorage-name }}.

  Также вы можете использовать команду `aws s3 rb`:
  
  ```bash
  aws --endpoint-url=https://{{ s3-storage-host }} \
    s3 rb s3://<имя_бакета>
  ```

  Чтобы одновременно удалить несколько бакетов, выполните команду:

  {% include [sa-acl-bucket-list-note.md](../../../_includes/storage/sa-acl-bucket-list-note.md) %}

  * **Bash:**

    ```bash
    aws s3api list-buckets \
      --endpoint-url=https://{{ s3-storage-host }} \
      --query '<запрос>' \
      --output text | xargs -I {} aws s3api delete-bucket --endpoint-url=https://{{ s3-storage-host }} --bucket {}
    ```

    Где `--query` — запрос в формате [JMESPath](https://jmespath.org/).

    Пример команды для удаления всех бакетов, имена которых начинаются на `samplebucket`:

    ```bash
    aws s3api list-buckets \
      --endpoint-url=https://{{ s3-storage-host }} \
      --query 'Buckets[?starts_with(Name, `samplebucket`) == `true`].[Name]' \
      --output text | xargs -I {} aws s3api delete-bucket --endpoint-url=https://{{ s3-storage-host }} --bucket {}
    ```

  * **PowerShell:**

    ```powershell
    Foreach($x in (aws s3api list-buckets `
      --endpoint-url=https://{{ s3-storage-host }} `
      --query '<запрос>' `
      --output text)) `
      {aws s3api delete-bucket `
      --endpoint-url=https://{{ s3-storage-host }} `
      --bucket $x}
    ```

    Где `--query` — запрос в формате [JMESPath](https://jmespath.org/).

    Пример команды для удаления всех бакетов, имена которых начинаются на `samplebucket`:

    ```powershell
    Foreach($x in (aws s3api list-buckets `
      --endpoint-url=https://{{ s3-storage-host }} `
      --query 'Buckets[?starts_with(Name, `samplebucket`) == `true`].[Name]' `
      --output text)) `
      {aws s3api delete-bucket `
      --endpoint-url=https://{{ s3-storage-host }} `
      --bucket $x}
    ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}


  Чтобы удалить бакет, созданный с помощью {{ TF }}:
  1. Откройте файл конфигураций {{ TF }} и удалите фрагмент с описанием бакета.

     {% cut "Пример описания бакета в конфигурации {{ TF }}" %}

     ```hcl
     ...
     resource "yandex_storage_bucket" "test" {
       access_key = "YCAJEX9Aw2ge********-w-lJ"
       secret_key = "YCONxG7rSdz********_NRy5VbKzKlqZ********"
       bucket     = "<имя_бакета>"
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

- API {#api}
  
  Чтобы удалить бакет, воспользуйтесь методом REST API [delete](../../api-ref/Bucket/delete.md) для ресурса [Bucket](../../api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Delete](../../api-ref/grpc/bucket_service.md#Delete) или методом S3 API [deleteBucket](../../s3/api-ref/bucket/delete.md).

  {% include [work-with-multiple-buckets](../../../_includes/storage/work-with-multiple-buckets.md) %}

{% endlist %}
