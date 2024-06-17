Если вы часто используете сервисы с AWS-совместимым API, например [{{ objstorage-full-name }}](../../storage/index.yaml), [{{ yds-full-name }}](../../data-streams/index.yaml) или [{{ message-queue-full-name }}](../../message-queue/index.yaml), вам приходится самостоятельно заботиться о безопасном хранении [статических ключей доступа](../../iam/concepts/authorization/access-key.md).

В данном руководстве рассматривается сценарий, при котором в качестве хранилища для статического ключа доступа используется [секрет](../../lockbox/concepts/secret.md) {{ lockbox-full-name }}. При этом значение ключа доступа не только не хранится локально на компьютере пользователя, но и не выводится на экран.

При обращении к ресурсу AWS-совместимого сервиса ({{ objstorage-name }}) статический ключ доступа и его идентификатор будут извлекаться из секрета {{ lockbox-name }} в специальные переменные окружения, которые будут использоваться для аутентификации запроса.

Такой подход позволит обеспечить безопасность хранения ключа и его использования при обращении к сервисам.

Чтобы использовать статический ключ доступа, сохраненный в секрете {{ lockbox-name }}:
1. [Подготовьте окружение](#prepare).
1. [Сохраните статический ключ доступа в секрет {{ lockbox-name }}](#store-key-into-secret).
1. [Используйте ключ из секрета {{ lockbox-name }} для работы с сервисом](#use-key).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

Будет взиматься плата за хранение одной версии секрета {{ lockbox-name }} (см. [тарифы {{ lockbox-name }}](../../lockbox/pricing.md#secrets)).

Плата за бакет {{ objstorage-name }} не будет взиматься, если в бакете не будут храниться данные (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md#rules)).


## Подготовьте окружение {#prepare}

1. {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. [Установите](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) утилиту командной строки AWS CLI.

    Настраивать утилиту не обязательно — все необходимые параметры будут передаваться в команде и переменных окружения.

1. Убедитесь, что утилита `grep` в вашей операционной системе поддерживает регулярные выражения, [совместимые с Perl (PCRE)](https://www.pcre.org/).


## Сохраните статический ключ доступа в секрет {{ lockbox-name }} {#store-key-into-secret}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  1. Создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), например `storage-bucket-sa`, от имени которого будут выполняться операции в {{ objstorage-name }}:

      ```bash
      yc iam service-account create storage-bucket-sa
      ```

      Результат:

      ```text
      done (1s)
      id: ajeplujf759j********
      folder_id: b1gt6g8ht345********
      created_at: "2024-05-07T19:18:37.244159066Z"
      name: storage-bucket-sa
      ```

      Сохраните идентификатор (`id`) созданного сервисного аккаунта, он понадобится при назначении сервисному аккаунту ролей.

      Подробнее о команде `yc iam service-account create` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/iam/service-account/create.md).

  1. Назначьте созданному сервисному аккаунту [роль](../../storage/security/index.md#storage-editor) `storage.editor` на каталог:

      ```bash
      yc resource-manager folder add-access-binding <имя_или_идентификатор_каталога> \
        --role storage.editor \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

      Где:
      * `<имя_или_идентификатор_каталога>` — имя или [идентификатор](../../resource-manager/operations/folder/get-id.md) каталога, в котором создан сервисный аккаунт.
      * `<идентификатор_сервисного_аккаунта>` — идентификатор сервисного аккаунта, сохраненный ранее.

      Результат:

      ```yml
      done (2s)
      effective_deltas:
        - action: ADD
          access_binding:
            role_id: storage.editor
            subject:
              id: ajeplujf759j********
              type: serviceAccount
      ```

      Подробнее о команде `yc resource-manager folder add-access-binding` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/resource-manager/folder/add-access-binding.md).

  1. Аналогичным способом назначьте сервисному аккаунту [роль](../../lockbox/security/index.md#lockbox-payloadViewer) `{{ roles-lockbox-payloadviewer }}` на каталог:

      ```bash
      yc resource-manager folder add-access-binding <имя_или_идентификатор_каталога> \
        --role {{ roles-lockbox-payloadviewer }} \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

  1. Создайте для сервисного аккаунта статический ключ доступа. Для того чтобы не выводить на экран значение ключа, он будет сохранен в переменную `STATIC_KEY`:

      ```bash
      STATIC_KEY=$(yc iam access-key create --service-account-name storage-bucket-sa)
      ```

      Подробнее о команде `yc iam access-key create` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/iam/access-key/create.md).

  1. Сохраните значения [идентификатора ключа](../../iam/concepts/authorization/access-key.md#key-id) и [секретного ключа](../../iam/concepts/authorization/access-key.md#private-key) в отдельные переменные `KEY_ID` и `KEY_VALUE`:

      ```bash
      KEY_ID=$(echo "$STATIC_KEY" | grep -Po "(?<=key_id: )([[:alnum:]_-]{25})") \
        && KEY_VALUE=$(echo "$STATIC_KEY" | grep -Po "(?<=secret: )([[:alnum:]_-]{40})")
      ```

  1. Создайте секрет {{ lockbox-name }} `static-key`, содержащий созданный статический ключ доступа:

      ```bash
      yc lockbox secret create \
        --name static-key \
        --payload "[{'key': $KEY_ID, 'text_value': $KEY_VALUE}]" \
        --cloud-id <идентификатор_облака> \
        --folder-id <идентификатор_каталога> \
        --deletion-protection
      ```

      Где:
      * `--cloud-id` — [идентификатор](../../resource-manager/operations/cloud/get-id.md) облака, в котором был создан сервисный аккаунт.
      * `--folder-id` — идентификатор каталога, в котором был создан сервисный аккаунт.
      * `--deletion-protection` — защита от удаления секрета. Пока опция включена, удалить секрет невозможно. Необязательный параметр.

      Результат:

      ```yml
      done (1s)
      id: e6qk0c62b4ep********
      folder_id: b1gt6g8ht345********
      created_at: "2024-05-07T20:05:51.569Z"
      name: static-key
      status: ACTIVE
      current_version:
        id: e6qrsj2hi8ug********
        secret_id: e6qk0c62b4ep********
        created_at: "2024-05-07T20:05:51.569Z"
        status: ACTIVE
        payload_entry_keys:
          - YCAJEO4w80Zf5DERM********
      deletion_protection: true
      ```

      Подробнее о команде `yc lockbox secret create` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/lockbox/secret/create.md).

{% endlist %}

Теперь статический ключ доступа сервисного аккаунта сохранен внутри секрета {{ lockbox-name }}.


## Используйте ключ из секрета {{ lockbox-name }} для работы с сервисом {#use-key}

1. Получите статический ключ доступа, сохраненный в секрете `static-key`. Для того чтобы не выводить на экран значение ключа, он будет сохранен в переменную `SECRET`:

    {% list tabs group=instructions %}

    - {{ yandex-cloud }} CLI {#cli}

      ```bash
      SECRET=$(yc lockbox payload get static-key)
      ```

      Подробнее о команде `yc lockbox payload get` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/lockbox/payload/get.md).

    {% endlist %}

1. Сохраните идентификатор ключа, секретный ключ и значение региона размещения в переменные окружения AWS CLI:

    ```bash
    export AWS_ACCESS_KEY_ID=$(echo "$SECRET" | grep -Po "(?<=key: )([[:alnum:]_-]{25})") \
      && export AWS_SECRET_ACCESS_KEY=$(echo "$SECRET" | grep -Po "(?<=text_value: )([[:alnum:]_-]{40})") \
      && export AWS_DEFAULT_REGION="{{ region-id }}"
    ```

    AWS CLI будет использовать созданные переменные окружения для аутентификации при выполнении операций с ресурсами сервиса.

1. Создайте бакет в {{ objstorage-name }}, указав в команде уникальное [имя бакета](../../storage/concepts/bucket.md#naming):

    {% list tabs group=instructions %}

    - AWS CLI {#aws-cli}

      ```bash
      aws --endpoint-url=https://storage.yandexcloud.net \
        s3 mb s3://<имя_бакета>
      ```

      Результат:
      
      ```bash
      make_bucket: my-first-bucket
      ```

    {% endlist %}

    В сервисе {{ objstorage-full-name }} был создан новый бакет. Для аутентификации при выполнении этой операции был использован статический ключ доступа, полученный из секрета {{ lockbox-name }} и сохраненный в переменные окружения.

    Вы также можете не создавать переменные окружения, а передавать значения идентификатора ключа, секретного ключа и региона размещения непосредственно в каждой команде AWS CLI:

    {% list tabs group=instructions %}

    - AWS CLI {#aws-cli}

      ```bash
      AWS_ACCESS_KEY_ID=$(echo "$SECRET" | grep -o -E "(\<)([[:alnum:]_-]{25})(\>)" --max-count=1) \
        AWS_SECRET_ACCESS_KEY=$(echo "$SECRET" | grep -o -E "([[:alnum:]_-]{40})") \
        AWS_DEFAULT_REGION="{{ region-id }}" \
        aws --endpoint-url=https://storage.yandexcloud.net \
        s3 mb s3://<имя_бакета>
      ```

      Результат:
      
      ```bash
      make_bucket: my-first-bucket
      ```

    {% endlist %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать использовать созданные ресурсы:
1. [Удалите секрет](../../lockbox/operations/secret-delete.md).
1. [Удалите бакет](../../storage/operations/buckets/delete.md).