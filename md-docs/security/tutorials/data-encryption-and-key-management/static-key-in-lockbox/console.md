[Документация Yandex Cloud](../../../../index.md) > [Безопасность в Yandex Cloud](../../../index.md) > [Практические руководства](../../index.md) > Шифрование данных и управление ключами > [Использование секрета Yandex Lockbox для хранения статического ключа доступа](index.md) > Использование секрета Yandex Lockbox для хранения статического ключа доступа с помощью CLI

# Использование секрета Yandex Lockbox для хранения статического ключа доступа с помощью CLI

Чтобы [использовать статический ключ доступа](index.md), сохраненный в секрете Yandex Lockbox, с помощью CLI:

1. [Подготовьте окружение](#prepare).
1. [Сохраните статический ключ доступа в секрет Yandex Lockbox](#store-key-into-secret).
1. [Используйте ключ из секрета Yandex Lockbox для работы с сервисом](#use-key).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../../billing/quickstart/index.md) и [привяжите](../../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за хранение одной версии секрета Yandex Lockbox ([тарифы Yandex Lockbox](../../../../lockbox/pricing.md#secrets));
* плата за хранение данных в Object Storage, операции с ними и исходящий трафик (плата не будет взиматься, если в бакете не будут храниться данные, [тарифы Object Storage](../../../../storage/pricing.md#rules)).


## Подготовьте окружение {#prepare}

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. [Установите](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) утилиту командной строки AWS CLI.
   
   Настраивать утилиту на этом этапе не обязательно. Необходимые параметры, такие как идентификаторы и ключи доступа, будут описаны и использованы в командах и переменных окружения далее в этом руководстве.


## Сохраните статический ключ доступа в секрет Yandex Lockbox {#store-key-into-secret}

{% list tabs group=instructions %}

- Yandex Cloud CLI {#cli}

  1. Создайте сервисный аккаунт, например `storage-bucket-sa`, от имени которого будут выполняться операции в Object Storage:

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

      Подробнее о команде `yc iam service-account create` читайте в [справочнике CLI](../../../../cli/cli-ref/iam/cli-ref/service-account/create.md).

  1. Назначьте созданному сервисному аккаунту [роль](../../../../storage/security/index.md#storage-editor) `storage.editor` на каталог:

      ```bash
      yc resource-manager folder add-access-binding <имя_или_идентификатор_каталога> \
        --role storage.editor \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

      Где:

      * `<имя_или_идентификатор_каталога>` — имя или [идентификатор](../../../../resource-manager/operations/folder/get-id.md) каталога, в котором создан сервисный аккаунт.
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

      Подробнее о команде `yc resource-manager folder add-access-binding` читайте в [справочнике CLI](../../../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md).

  1. Аналогичным способом назначьте сервисному аккаунту [роль](../../../../lockbox/security/index.md#lockbox-payloadViewer) `lockbox.payloadViewer` на каталог:

      ```bash
      yc resource-manager folder add-access-binding <имя_или_идентификатор_каталога> \
        --role lockbox.payloadViewer \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

  1. Создайте для сервисного аккаунта статический ключ доступа. Для того чтобы не выводить на экран значение ключа, он будет сохранен в переменную `STATIC_KEY`:

      ```bash
      STATIC_KEY=$(yc iam access-key create --service-account-name storage-bucket-sa)
      ```

      Подробнее о команде `yc iam access-key create` читайте в [справочнике CLI](../../../../cli/cli-ref/iam/cli-ref/access-key/create.md).

  1. Сохраните значения [идентификатора ключа](../../../../iam/concepts/authorization/access-key.md#key-id) и [секретного ключа](../../../../iam/concepts/authorization/access-key.md#private-key) в отдельные переменные `KEY_ID` и `KEY_VALUE`:

      ```bash
      KEY_ID=$(echo | awk '{if (match($0, "key_id: ")) {print substr($0, RSTART + 8, 25)}}' <<< "$STATIC_KEY") \
        && KEY_VALUE=$(echo | awk '{if (match($0, "secret: ")) {print substr($0, RSTART + 8, 40)}}' <<< "$STATIC_KEY")
      ```

  1. Создайте секрет Yandex Lockbox `static-key`, содержащий созданный статический ключ доступа:

      ```bash
      yc lockbox secret create \
        --name static-key \
        --payload "[{'key': $KEY_ID, 'text_value': $KEY_VALUE}]" \
        --cloud-id <идентификатор_облака> \
        --folder-id <идентификатор_каталога> \
        --deletion-protection
      ```

      Где:

      * `--cloud-id` — [идентификатор](../../../../resource-manager/operations/cloud/get-id.md) облака, в котором был создан сервисный аккаунт.
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

      Подробнее о команде `yc lockbox secret create` читайте в [справочнике CLI](../../../../cli/cli-ref/lockbox/cli-ref/secret/create.md).

{% endlist %}

Теперь статический ключ доступа сервисного аккаунта сохранен внутри секрета Yandex Lockbox.


## Используйте ключ из секрета Yandex Lockbox для работы с сервисом {#use-key}

Пример ниже разработан для выполнения в операционных системах MacOS и Linux. Чтобы выполнить его в системе Windows, [ознакомьтесь](../../../../overview/concepts/console-syntax-guide.md) с особенностями работы с Bash в Microsoft Windows.

1. Получите статический ключ доступа, сохраненный в секрете `static-key`. Для того чтобы не выводить на экран значение ключа, он будет сохранен в переменную `SECRET`:

    {% list tabs group=instructions %}

    - Yandex Cloud CLI {#cli}

      ```bash
      SECRET=$(yc lockbox payload get <имя_или_идентификатор_секрета>)
      ```
      Используйте либо параметр `--id`, либо параметр `--name`.

      Подробнее о команде `yc lockbox payload get` читайте в [справочнике CLI](../../../../cli/cli-ref/lockbox/cli-ref/payload/get.md).

    {% endlist %}

1. Сохраните идентификатор ключа, секретный ключ и значение региона размещения в переменные окружения AWS CLI:

    ```bash
    export AWS_ACCESS_KEY_ID=$(echo | awk '{if (match($0, "key: ")) {print substr($0, RSTART + 5, 25)}}' <<< "$SECRET") \
      && export AWS_SECRET_ACCESS_KEY=$(echo | awk '{if (match($0, "text_value: ")) {print substr($0, RSTART + 12, 40)}}' <<< "$SECRET") \
      && export AWS_DEFAULT_REGION="ru-central1"
    ```

    AWS CLI будет использовать созданные переменные окружения для аутентификации при выполнении операций с ресурсами сервиса.

1. Создайте бакет в Object Storage, указав в команде уникальное [имя бакета](../../../../storage/concepts/bucket.md#naming):

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
    
    В результате будет создан новый бакет в Object Storage. При создании бакета используется статический ключ доступа, полученный из секрета Yandex Lockbox и сохраненный в переменные окружения.
    
    Вы также передать значения идентификатора ключа, секретного ключа и региона размещения непосредственно в каждой команде AWS CLI:

    {% list tabs group=instructions %}

    - AWS CLI {#aws-cli}

      ```bash
      AWS_ACCESS_KEY_ID=$(echo | awk '{if (match($0, "key: ")) {print substr($0, RSTART + 5, 25)}}' <<< "$SECRET") \
        AWS_SECRET_ACCESS_KEY=$(echo | awk '{if (match($0, "text_value: ")) {print substr($0, RSTART + 12, 40)}}' <<< "$SECRET") \
        AWS_DEFAULT_REGION="ru-central1" \
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
1. [Удалите](../../../../lockbox/operations/secret-delete.md) секрет.
1. [Удалите](../../../../storage/operations/buckets/delete.md) бакет.

#### Полезные ссылки {#see-also}

* [Использование секрета Yandex Lockbox для хранения статического ключа доступа с помощью Terraform](terraform.md)