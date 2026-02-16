{% include [cli-install](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. Посмотрите описание команды CLI для получения подписанной ссылки на объект:

    ```bash
    yc storage s3 presign --help
    ```

1. {% include [bucket-list-cli](../../_includes/storage/bucket-list-cli.md) %}

1. Сгенерируйте подписанную ссылку. Вы можете сделать это либо с помощью API {{ yandex-cloud }} от имени [аккаунта](../../iam/concepts/users/accounts.md), аутентифицированного в текущий момент в профиле {{ yandex-cloud }} CLI, либо локально от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), передав в команде данные его [статического ключа доступа](../../iam/concepts/authorization/access-key.md).

    {% list tabs %}

    - С помощью API {{ yandex-cloud }}

      Чтобы сгенерировать подписанную ссылку на загрузку объекта от имени аккаунта, аутентифицированного в текущий момент в профиле {{ yandex-cloud }} CLI, выполните команду:

      ```bash
      yc storage s3 presign \
        s3://<имя_бакета>/<ключ_объекта> \
        --expires-in <срок_действия_ссылки> \
        --http-method PUT
      ```

      Где:

      {% include [get-presigned-upload-link-cli-legend-part1](../../_includes/storage/get-presigned-upload-link-cli-legend-part1.md) %}

      Результат:

      ```text
      https://{{ s3-storage-host }}/first-bucket/sample.txt?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=YCAJEwkbVN5BKvE2wqYiZCzlQ%2F20260205%2Fru-central1%2Fs3%2Faws4_request&X-Amz-Date=20260205T131200Z&X-Amz-Expires=3600&X-Amz-Signature=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX&X-Amz-SignedHeaders=host
      ```

    - Локально

      Чтобы сгенерировать подписанную ссылку на загрузку объекта локально от имени сервисного аккаунта, выполните команду:

      ```bash
      yc storage s3 presign \
        s3://<имя_бакета>/<ключ_объекта> \
        --expires-in <срок_действия_ссылки> \
        --http-method PUT \
        --local \
        --access-key <идентификатор_ключа> \
        --secret-key <секретный_ключ>
      ```

      Где:

      {% include [get-presigned-upload-link-cli-legend-part1](../../_includes/storage/get-presigned-upload-link-cli-legend-part1.md) %}

      * `--access-key` — идентификатор статического ключа доступа сервисного аккаунта.
      * `--secret-key` — секретный ключ статического ключа доступа сервисного аккаунта.

      Результат:

      ```text
      https://{{ s3-storage-host }}/first-bucket/sample.txt?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=YCAJE98uTrKJwAtqwrHJXNh5L%2F20250904%2Fdefault%2Fs3%2Faws4_request&X-Amz-Date=20250904T072650Z&X-Amz-Expires=36000&X-Amz-SignedHeaders=host&x-id=PutObject&X-Amz-Signature=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      ```

    {% endlist %}

1. Чтобы загрузить файл по полученной подписанной ссылке, выполните команду:

   ```bash
   curl --request PUT \
     --upload-file <путь_к_файлу> \
     "<полученная_подписанная_ссылка>"
   ```

   Где:
   * `<путь_к_файлу>` — путь к файлу на локальном компьютере, который нужно загрузить в бакет. Например: `~/sample.txt` или `./sample.txt`.
   * `<полученная_подписанная_ссылка>` — URL, полученный на предыдущем шаге.

   Пример:

   ```bash
   curl --request PUT \
     --upload-file ~/sample.txt \
     "https://{{ s3-storage-host }}/first-bucket/sample.txt?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=YCAJEwkbVN5BKvE2wqYiZCzlQ%2F20260205%2Fru-central1%2Fs3%2Faws4_request&X-Amz-Date=20260205T131200Z&X-Amz-Expires=3600&X-Amz-Signature=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX&X-Amz-SignedHeaders=host"
   ```

   Если файл успешно загружен, команда не выведет никакого сообщения. Чтобы увидеть детали запроса, добавьте флаг `--verbose`.