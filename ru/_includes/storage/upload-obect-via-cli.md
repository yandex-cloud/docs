1. Посмотрите описание команды CLI для загрузки файла в бакет:

    ```bash
    yc storage s3api put-object --help
    ```

1. {% include [bucket-list-cli](./bucket-list-cli.md) %}
1. Выполните команду:

    ```bash
    yc storage s3api put-object \
      --body <путь_к_локальному_файлу> \
      --bucket <имя_бакета> \
      --key <путь_к_объекту>
    ```

    Где:

    * `--body` — путь к файлу, который нужно загрузить в бакет.
    * `--bucket` — имя вашего бакета.
    * `--key` — [ключ](../../storage/concepts/object.md#key), по которому объект будет храниться в бакете.

    Результат:

    ```text
    etag: '"d41d8cd98f00b204e980099********"'
    request_id: 3f2705f********
    ```

    Альтернативная команда:

    ```bash
    yc storage s3 cp \
      <путь_к_локальному_файлу> \
      s3://<имя_бакета>/<путь_к_объекту>
    ```

    Результат:

    ```text
    upload: object.txt to s3://my-bucket/object.txt
    ```

    {% include [s3-cp-config](s3-cp-config.md) %}