{% include [cli-install](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. Посмотрите описание команды CLI для получения подписанной ссылки на объект:

    ```bash
    yc storage s3 presign --help
    ```

1. {% include [bucket-list-cli](../../_includes/storage/bucket-list-cli.md) %}
1. Посмотрите список объектов в бакете, указав его [имя](../concepts/bucket.md#naming):

    ```bash
    yc storage s3api list-objects \
      --bucket <имя_бакета>
    ```

    Результат:

    ```text
    contents:
      - key: sample.txt
        last_modified: "2025-09-04T06:02:16.884Z"
        etag: '"7bd56d2f6096d582420e8a01********"'
        size: "17"
        owner:
          id: ajeol2afu1js********
          display_name: ajeol2afu1js********
        storage_class: STANDARD
    name: first-bucket
    max_keys: "1000"
    key_count: "1"
    request_id: 338862e1********
    ```

1. Сгенерируйте подписанную ссылку. Вы можете сделать это либо с помощью API {{ yandex-cloud }} от имени [аккаунта](../../iam/concepts/users/accounts.md), аутентифицированного в текущий момент в профиле {{ yandex-cloud }} CLI, либо локально от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), передав в команде данные его [статического ключа доступа](../../iam/concepts/authorization/access-key.md).

    {% list tabs %}

    - С помощью API {{ yandex-cloud }}

      Чтобы сгенерировать подписанную ссылку на скачивание объекта от имени аккаунта, аутентифицированного в текущий момент в профиле {{ yandex-cloud }} CLI, выполните команду:

      ```bash
      yc storage s3 presign \
        s3://<имя_бакета>/<ключ_объекта> \
        --expires-in <срок_действия_ссылки> \
        --as-attachment
      ```

      Где:

      {% include [get-presigned-link-cli-legend-part1](../../_includes/storage/get-presigned-link-cli-legend-part1.md) %}

      Результат:

      ```text
      https://{{ s3-storage-host }}/first-bucket/sample.txt?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=YCAJEIUp_5V5nBFDgIgh-NLc2%2F20250904%2Fru-central1%2Fs3%2Faws4_request&X-Amz-Date=20250904T063033Z&X-Amz-Expires=36000&X-Amz-Signature=d661b64566753dba1ef66b467e56db0e7f7c69581b0ddd2c8a0a7b505bc3ff61&X-Amz-SignedHeaders=host&response-content-disposition=attachment
      ```

    - Локально

      Чтобы сгенерировать подписанную ссылку на скачивание объекта локально от имени сервисного аккаунта, выполните команду:

      ```bash
      yc storage s3 presign \
        s3://<имя_бакета>/<ключ_объекта> \
        --expires-in <срок_действия_ссылки> \
        --as-attachment \
        --local \
        --access-key <идентификатор_ключа> \
        --secret-key <секретный_ключ>
      ```

      Где:

      {% include [get-presigned-link-cli-legend-part1](../../_includes/storage/get-presigned-link-cli-legend-part1.md) %}

      * `--access-key` — идентификатор статического ключа доступа сервисного аккаунта.
      * `--secret-key` — секретный ключ статического ключа доступа сервисного аккаунта.

      Результат:

      ```text
      https://{{ s3-storage-host }}:443/first-bucket/sample.txt?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=YCAJE98uTrKJwAtqwrHJXNh5L%2F20250904%2Fdefault%2Fs3%2Faws4_request&X-Amz-Date=20250904T072650Z&X-Amz-Expires=36000&X-Amz-SignedHeaders=host&response-content-disposition=attachment&x-id=GetObject&X-Amz-Signature=e60562ef242588eec44916ad9e97d2864b250a73f4e5a70e29bb2bd8926249b0
      ```

    {% endlist %}