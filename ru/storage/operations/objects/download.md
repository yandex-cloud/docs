---
title: Скачивание объекта в {{ objstorage-full-name }}
description: Следуя данной инструкции, вы сможете скачать объект из бакета в {{ objstorage-name }}.
---

# Скачивание объекта


{% include [encryption-roles](../../../_includes/storage/encryption-roles.md) %}


{% note info %}

Чтобы скачать группу объектов с определенным префиксом ([папку](../../concepts/object.md#folder) с объектами) или все объекты из бакета, используйте AWS CLI или совместимые с Amazon S3 API файловые браузеры, например [CyberDuck](../../tools/cyberduck.md) и [WinSCP](../../tools/winscp.md).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** и перейдите в бакет, из которого вы хотите скачать объект.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}**, найдите в списке нужный объект.
  1. Напротив объекта, который вы хотите скачать, нажмите ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.storage.file.button_download }}** или откройте объект и на панели сверху нажмите ![image](../../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud.storage.file.button_download }}**.

  {% note info %}

  Также чтобы скачать или загрузить объекты с помощью графического интерфейса, вы можете использовать инструменты [CyberDuck](../../tools/cyberduck.md) или [WinSCP](../../tools/winscp.md).

  {% endnote %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для скачивания объекта из бакета:

      ```bash
      yc storage s3api get-object --help
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

  1. Выполните команду:

      ```bash
      yc storage s3api get-object \
        --bucket <имя_бакета> \
        --key <ключ_объекта> \
        <путь_для_скачивания>
      ```

      Где:

      * `--bucket` — имя вашего бакета.
      * `--key` — [ключ](../../concepts/object.md#key) объекта.
      * `<путь_для_скачивания>` — локальный путь для скачивания.

      Результат:

      ```bash
      etag: '"d41d8cd98f00b204e9800998********"'
      request_id: af194b83********
      accept_ranges: bytes
      content_type: application/octet-stream
      last_modified_at: "2024-10-08T12:36:36Z"
      server_side_encryption: aws:kms
      sse_kms_key_id: abj497vtg3h0********
      ```

- AWS CLI {#aws-cli}

  Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  **Скачать один объект**

  ```bash
  aws s3 cp \
    --endpoint-url=https://{{ s3-storage-host }} \
    s3://<имя_бакета>/<ключ_объекта> \
    <локальный_путь>
  ```

  Где:

  * `--endpoint-url` — эндпоинт {{ objstorage-name }}.
  * `<имя_бакета>` — имя бакета, из которого вы хотите скачать объект.
  * `<ключ_объекта>` — [ключ](../../concepts/object.md#key) объекта, который вы хотите скачать.
  * `<локальный_путь>` — путь к папке, в которую будет сохранен скачанный объект. Например, `~/downloads/`.

  **Скачать папку (все объекты с определенным префиксом)**

  Подробнее о папках в {{ objstorage-name }} см. в разделе [{#T}](../../concepts/object.md#folder).

  ```bash
  aws s3 cp \
    --endpoint-url=https://{{ s3-storage-host }} \
    --recursive \
    s3://<имя_бакета>/<префикс>/ \
    <локальный_путь>
  ```

  Где:

  * `--endpoint-url` — эндпоинт {{ objstorage-name }}.
  * `--recursive` — параметр для скачивания всех объектов с указанным префиксом.
  * `<имя_бакета>` — имя бакета, из которого вы хотите скачать объекты.
  * `<префикс>` — префикс (папка) объектов, которые вы хотите скачать, например `test/folder`.
  * `<локальный_путь>` — путь к папке, в которую будут сохранены скачанные объекты, например `~/downloads/`.

  **Скачать все объекты из бакета**

  ```bash
  aws s3 cp \
    --endpoint-url=https://{{ s3-storage-host }} \
    --recursive \
    s3://<имя_бакета> \
    <локальный_путь>
  ```

  Где:

  * `--endpoint-url` — эндпоинт {{ objstorage-name }}.
  * `--recursive` — параметр для скачивания всех объектов бакета в локальную папку.
  * `<имя_бакета>` — имя бакета, из которого вы хотите скачать объекты.
  * `<локальный_путь>` — путь к папке, в которую будут сохранены скачанные объекты. Например, `~/downloads/`.

  Команда `aws s3 cp` — высокоуровневая, ее функциональность ограничена. Подробнее см. в [справочнике AWS CLI](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/cp.html).

  Объекты из бакета можно скачать выборочно с помощью команды `aws s3api` и шаблона запроса в формате JMESPath. Для скачивания объектов по шаблону выполните команду:

  * **Bash**:

      ```bash
      aws s3api list-objects \
          --endpoint-url https://{{ s3-storage-host }} \
          --bucket <имя_бакета> \
          --query '<запрос>' \
          --output text | xargs -I {} aws s3api get-object --endpoint-url https://{{ s3-storage-host }} --bucket <имя_бакета> --key {} <локальный_путь>{}
      ```

      Где:

      * `--endpoint-url` — эндпоинт {{ objstorage-name }}.
      * `--bucket` — имя бакета, из которого вы хотите скачать объекты.
      * `--query` — запрос в формате [JMESPath](https://jmespath.org/).
      * `<локальный_путь>` — путь к папке, в которую будут сохранены скачанные объекты. Например, `~/downloads/`.

      Пример команды для скачивания из бакета `sample-bucket` в локальную папку `~/downloads/` всех объектов, имена файлов которых начинаются с `date-20231002`:

      ```bash
      aws s3api list-objects \
        --endpoint-url https://{{ s3-storage-host }} \
        --bucket sample-bucket \
        --query 'Contents[?starts_with(Key, `date-20231002`) == `true`].[Key]' \
        --output text | xargs -I {} aws s3api get-object --endpoint-url https://{{ s3-storage-host }} --bucket sample-bucket --key {} ~/downloads/{}
      ```

  * **PowerShell**:

      ```powershell
      Foreach($x in (aws s3api list-objects `
        --endpoint-url https://{{ s3-storage-host }} `
        --bucket <имя_бакета> `
        --query '<запрос>' `
        --output text)) `
        {aws s3api get-object --endpoint-url https://{{ s3-storage-host }} --bucket <имя_бакета> --key $x <локальный_путь>$x}
      ```

      Где:

      * `--endpoint-url` — эндпоинт {{ objstorage-name }}.
      * `--bucket` — имя бакета, из которого вы хотите скачать объекты.
      * `--query` — запрос в формате [JMESPath](https://jmespath.org/).
      * `<локальный_путь>` — путь к папке, в которую будут сохранены скачанные объекты. Например, `d:\downloads\`.

      Пример команды для скачивания из бакета `sample-bucket` в локальную папку `d:\downloads\` всех объектов, имена файлов которых начинаются с `date-20231002`:

      ```powershell
      Foreach($x in (aws s3api list-objects `
        --endpoint-url https://{{ s3-storage-host }} `
        --bucket sample-bucket `
        --query 'Contents[?starts_with(Key, `date-20231002`) == `true`].[Key]' `
        --output text)) `
        {aws s3api get-object --endpoint-url https://{{ s3-storage-host }} --bucket sample-bucket --key $x d:\downloads\$x}
      ```

- API {#api}

  Чтобы скачать объект, воспользуйтесь методом S3 API [get](../../s3/api-ref/object/get.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](link-for-download.md)
