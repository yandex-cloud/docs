1. [Подготовьте окружение](#prepare).
1. [Сохраните статический ключ доступа в секрет {{ lockbox-name }}](#store-key-into-secret).
1. [Используйте ключ из секрета {{ lockbox-name }} для работы с сервисом](#use-key).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/static-key-in-lockbox/paid-resources.md) %}


## Подготовьте окружение {#prepare}

1. {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. {% include [prepare](../_tutorials_includes/static-key-in-lockbox/prepare.md) %}


## Сохраните статический ключ доступа в секрет {{ lockbox-name }} {#store-key-into-secret}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  1. Создайте сервисный аккаунт, например `storage-bucket-sa`, от имени которого будут выполняться операции в {{ objstorage-name }}:

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

      Подробнее о команде `yc iam service-account create` читайте в [справочнике CLI](../../cli/cli-ref/iam/cli-ref/service-account/create.md).

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

      Подробнее о команде `yc resource-manager folder add-access-binding` читайте в [справочнике CLI](../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md).

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

      Подробнее о команде `yc iam access-key create` читайте в [справочнике CLI](../../cli/cli-ref/iam/cli-ref/access-key/create.md).

  1. Сохраните значения [идентификатора ключа](../../iam/concepts/authorization/access-key.md#key-id) и [секретного ключа](../../iam/concepts/authorization/access-key.md#private-key) в отдельные переменные `KEY_ID` и `KEY_VALUE`:

      ```bash
      KEY_ID=$(echo | awk '{if (match($0, "key_id: ")) {print substr($0, RSTART + 8, 25)}}' <<< "$STATIC_KEY") \
        && KEY_VALUE=$(echo | awk '{if (match($0, "secret: ")) {print substr($0, RSTART + 8, 40)}}' <<< "$STATIC_KEY")
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

      Подробнее о команде `yc lockbox secret create` читайте в [справочнике CLI](../../cli/cli-ref/lockbox/cli-ref/secret/create.md).

{% endlist %}

Теперь статический ключ доступа сервисного аккаунта сохранен внутри секрета {{ lockbox-name }}.


## Используйте ключ из секрета {{ lockbox-name }} для работы с сервисом {#use-key}

{% include [bash-windows-note-single](../../_includes/translate/bash-windows-note-single.md) %}

1. Получите статический ключ доступа, сохраненный в секрете `static-key`. Для того чтобы не выводить на экран значение ключа, он будет сохранен в переменную `SECRET`:

    {% list tabs group=instructions %}

    - {{ yandex-cloud }} CLI {#cli}

      ```bash
      SECRET=$(yc lockbox payload get static-key)
      ```

      Подробнее о команде `yc lockbox payload get` читайте в [справочнике CLI](../../cli/cli-ref/lockbox/cli-ref/payload/get.md).

    {% endlist %}

1. Сохраните идентификатор ключа, секретный ключ и значение региона размещения в переменные окружения AWS CLI:

    ```bash
    export AWS_ACCESS_KEY_ID=$(echo | awk '{if (match($0, "key: ")) {print substr($0, RSTART + 5, 25)}}' <<< "$SECRET") \
      && export AWS_SECRET_ACCESS_KEY=$(echo | awk '{if (match($0, "text_value: ")) {print substr($0, RSTART + 12, 40)}}' <<< "$SECRET") \
      && export AWS_DEFAULT_REGION="{{ region-id }}"
    ```

    AWS CLI будет использовать созданные переменные окружения для аутентификации при выполнении операций с ресурсами сервиса.

1. Создайте бакет в {{ objstorage-name }}, указав в команде уникальное [имя бакета](../../storage/concepts/bucket.md#naming):

    {% include [create-bucket](../_tutorials_includes/static-key-in-lockbox/create-bucket.md) %}

    {% list tabs group=instructions %}

    - AWS CLI {#aws-cli}

      ```bash
      AWS_ACCESS_KEY_ID=$(echo | awk '{if (match($0, "key: ")) {print substr($0, RSTART + 5, 25)}}' <<< "$SECRET") \
        AWS_SECRET_ACCESS_KEY=$(echo | awk '{if (match($0, "text_value: ")) {print substr($0, RSTART + 12, 40)}}' <<< "$SECRET") \
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
1. [Удалите](../../lockbox/operations/secret-delete.md) секрет.
1. [Удалите](../../storage/operations/buckets/delete.md) бакет.