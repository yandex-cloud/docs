---
title: Как настроить доступ к {{ objstorage-name }} из кластера {{ ES }}
description: Следуя данной инструкции, вы сможете настроить доступ к {{ objstorage-name }} из кластера {{ ES }}.
---

# Настройка доступа к {{ objstorage-name }} из кластера {{ ES }}

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

{{ mes-name }} поддерживает работу с {{ objstorage-full-name }} в качестве репозитория [снапшотов](../../glossary/snapshot.md) {{ ES }}. Это позволяет использовать {{ objstorage-name }}:

* для [переноса данных из стороннего кластера {{ ES }} в {{ mes-name }}](../tutorials/migration-via-snapshots.md);

* для добавления [пользовательских расширений](cluster-extensions.md#add);

* для [хранения резервных копий](./cluster-backups.md).

Подробнее о механизме снапшотов см. в [документации {{ ES }}](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore.html).

Для доступа к данным в бакете {{ objstorage-name }} из кластера:

1. [Подключите сервисный аккаунт к кластеру](#connect-service-account).
1. [Настройте права доступа](#configure-acl).
1. [Подключите репозиторий снапшотов](#register-snapshot-repository).

## Подключить сервисный аккаунт к кластеру {#connect-service-account}

1. При [создании](./cluster-create.md) или [изменении](./cluster-update.md#change-service-account) кластера выберите существующий [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), либо [создайте новый](../../iam/operations/sa/create.md).

1. Убедитесь, что этому аккаунту [назначена роль](../../iam/operations/sa/assign-role-for-sa.md) `storage.editor` или выше.

## Настроить права доступа {#configure-acl}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хранится нужный бакет. Если бакета не существует — [создайте](../../storage/operations/buckets/create.md) его.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
    1. Выберите вкладку **{{ ui-key.yacloud.storage.switch_buckets }}**.
    1. Настройте [ACL бакета](../../storage/operations/buckets/edit-acl.md):
        1. В выпадающем списке **{{ ui-key.yacloud.component.acl-dialog.label_select-placeholder }}** укажите сервисный аккаунт, [подключенный к кластеру](#connect-service-account).
        1. Задайте разрешения `READ и WRITE` для выбранного сервисного аккаунта.
        1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
        1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

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
    PUT --cacert ~/.elasticsearch/root.crt https://admin:<пароль>@<FQDN_хоста>:9200/_snapshot/<репозиторий>
    ```

    В параметрах запроса укажите бакет, связанный с сервисным аккаунтом кластера:

    ```bash
    curl --request PUT \
         "https://admin:<пароль>@<FQDN_хоста>:9200/_snapshot/<репозиторий>" \
         --cacert ~/.elasticsearch/root.crt \
         --header "Content-Type: application/json" \
         --data '{
           "type": "s3",
           "settings": {
             "endpoint": "{{ s3-storage-host }}",
             "bucket": "<имя_бакета>",
             "base_path": "<путь_к_каталогу_для_снапшотов>",
             "canned_acl": "bucket-owner-full-control"
           }
         }'
    ```

    Подробнее об управлении репозиториями см. в [документации {{ ES }}](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore-apis.html).
