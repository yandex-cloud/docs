# Настройка доступа к {{ objstorage-name }} из {{ ES }}-кластера

{{ mes-name }} поддерживает работу с {{ objstorage-full-name }} в качестве [репозитория снапшотов](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore.html) {{ ES }}. Это позволяет использовать {{ objstorage-name }}:

* для [переноса данных из стороннего кластера {{ ES }} в {{ mes-name }}](../tutorials/migration-via-snapshots.md);

* для добавления [пользовательских расширений](cluster-extensions.md#add);

* для [хранения резервных копий](./cluster-backups.md).

Для доступа к данным в бакете {{ objstorage-name }} из кластера:

1. [Подключите сервисный аккаунт к кластеру](#connect-service-account).
1. [Настройте права доступа](#configure-acl).
1. [Подключите репозиторий снапшотов](#register-snapshot-repository).

## Подключить сервисный аккаунт к кластеру {#connect-service-account}

{% if audience != "internal" %}

1. При [создании](./cluster-create.md) или [изменении](./cluster-update.md#change-additional-settings) кластера выберите существующий [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), либо [создайте новый](../../iam/operations/sa/create.md).

1. Убедитесь, что этому аккаунту [назначена роль](../../iam/operations/sa/assign-role-for-sa.md) `storage.editor`.

{% else %}

1. При [создании](./cluster-create.md) или [изменении](./cluster-update.md#change-additional-settings) кластера выберите существующий сервисный аккаунт, либо создайте новый.

1. Убедитесь, что этому аккаунту назначена роль `storage.editor`.

{% endif %}

## Настроить права доступа {#configure-acl}

{% list tabs %}

- Консоль управления

    {% if audience != "internal" %}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хранится нужный бакет. Если бакета не существует — [создайте](../../storage/operations/buckets/create.md) его.

    {% else %}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хранится нужный бакет. Если бакета не существует — создайте его.

    {% endif %}

    1. Выберите сервис **{{ objstorage-name }}**.
    1. Выберите вкладку **Бакеты**.
    1. {% if audience != "internal" %}Настройте [ACL бакета](../../storage/operations/buckets/edit-acl.md){% else %}Настройте ACL бакета{% endif %}:
        1. В выпадающем списке **Выберите пользователя** укажите сервисный аккаунт, [подключенный к кластеру](#connect-service-account).
        1. Задайте разрешения `READ и WRITE` для выбранного сервисного аккаунта.
        1. Нажмите кнопку **Добавить**.
        1. Нажмите кнопку **Сохранить**.

{% endlist %}

## Подключить репозиторий снапшотов {#register-snapshot-repository}

{% include [mes-objstorage-snapshot](../../_includes/mdb/mes/objstorage-snapshot.md) %}

1. [Подключитесь](./cluster-connect.md) к кластеру.
1. Установите плагин [repository-s3](cluster-plugins.md#elasticsearch):

    ```bash
    sudo bin/elasticsearch-plugin install repository-s3
    ```

1. Зарегистрируйте бакет как репозиторий снапшотов, используя публичный [API {{ ES }}](https://www.elastic.co/guide/en/elasticsearch/reference/current/put-snapshot-repo-api.html):

    ```http
    PUT --cacert ~/.elasticsearch/root.crt https://admin:<пароль>@<FQDN или IP-адрес хоста>:9200/_snapshot/<репозиторий>
    ```

    В параметрах запроса укажите бакет, связанный с сервисным аккаунтом кластера:

    ```bash
    curl --request PUT \
         "https://admin:<пароль>@<FQDN или IP-адрес хоста>:9200/_snapshot/<репозиторий>" \
         --cacert ~/.elasticsearch/root.crt \
         --header "Content-Type: application/json" \
         --data '{
           "type": "s3",
           "settings": {
             "endpoint": "{{ s3-storage-host }}",
             "bucket": "<имя бакета>"
           }
         }'
    ```

    Подробнее об управлении репозиториями см. в [документации {{ ES }}](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore-apis.html).
