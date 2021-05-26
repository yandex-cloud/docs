# Настройка доступа к {{ objstorage-name }}

{{ mes-name }} поддерживает работу с {{ objstorage-full-name }} в качестве [репозитория снапшотов](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore.html) {{ ES }}. Это позволяет использовать {{ objstorage-name }} для хранения [резервных копий](./cluster-backups.md).

Для доступа к данным в бакете {{ objstorage-name }} из кластера:

1. [Подключите сервисный аккаунт к кластеру](#connect-service-account).
1. [Настройте права доступа](#configure-acl).
1. [Подключите репозиторий снапшотов](#register-snapshot-repository).


## Подключить сервисный аккаунт к кластеру {#connect-service-account}

1. При [создании](./cluster-create.md) или [изменении](./cluster-update.md#update-additional-settings) кластера выберите существующий [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), либо [создайте новый](../../iam/operations/sa/create.md).
1. Убедитесь, что этому аккаунту [назначена роль](../../iam/operations/sa/assign-role-for-sa.md) `storage.editor`.


## Настроить права доступа {#configure-acl}

1. В консоли управления выберите каталог, в котором хранится нужный бакет. Если бакета не существует — [создайте](../../storage/operations/buckets/create.md) его.
1. Выберите сервис **{{ objstorage-name }}**.
1. Выберите вкладку **Бакеты**.
1. Настройте [ACL бакета](../../storage/operations/buckets/edit-acl.md):
    1. В выпадающем списке **Выберите пользователя** укажите сервисный аккаунт, [подключенный к кластеру](#connect-service-account).
    1. Задайте разрешения `READ + WRITE` для сервисного аккаунта из выпадающего списка.
    1. Нажмите кнопку **Добавить**.
    1. Нажмите кнопку **Сохранить**.


## Подключить репозиторий снапшотов {#register-snapshot-repository}

{% note alert %}

Если бакет зарегистрирован в кластере {{ ES }} как репозиторий снапшотов, не вносите никаких изменений в содержимое бакета вручную — это нарушит работу механизма снапшотов {{ ES }}!

{% endnote %}

1. При [создании](./cluster-create.md) или [изменении](./cluster-update.md#update-additional-settings) кластера подключите расширение [repository-s3](../concepts/plugins.md).
1. Зарегистрируйте бакет как репозиторий снапшотов, используя публичный [API {{ ES }}](https://www.elastic.co/guide/en/elasticsearch/reference/current/put-snapshot-repo-api.html):

    ```http
    PUT https://admin:<пароль>@<FQDN или IP-адрес хоста>:9200/<репозиторий>
    ```

    В параметрах запроса укажите бакет, связанный с сервисным аккаунтом кластера:

    ```bash
    curl https://admin:<пароль>@<FQDN или IP-адрес хоста>:9200/<репозиторий> \
         -X POST \
         --header "Content-Type: application/json" \
         --data '{
           "type": "s3",
             "settings": {
             "endpoint": "storage.yandexcloud.net",
             "bucket": "<имя бакета>"
           }
         }'
    ```

    Подробнее об управлении репозиториями см. в [документации {{ ES }}](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore-apis.html).
