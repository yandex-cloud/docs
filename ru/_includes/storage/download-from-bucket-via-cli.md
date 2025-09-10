1. Посмотрите описание команды CLI для скачивания объекта из бакета:

    ```bash
    yc storage s3api get-object --help
    ```

1. {% include [bucket-list-cli](./bucket-list-cli.md) %}
1. Выполните команду:

    ```bash
    yc storage s3api get-object \
      --bucket <имя_бакета> \
      --key <ключ_объекта> \
      <путь_для_скачивания>
    ```

    Где:

    * `--bucket` — имя вашего бакета.
    * `--key` — [ключ](../../storage/concepts/object.md#key) объекта.
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

    Альтернативная команда:

    ```bash
    yc storage s3 cp \
      s3://<имя_бакета>/<ключ_объекта> \
      <путь_для_скачивания>
    ```

    Результат:

    ```text
    download: s3://my-bucket/object.txt to object.txt
    ```

    {% include [s3-cp-config](s3-cp-config.md) %}