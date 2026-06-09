# Настройка доступа к Object Storage из кластера OpenSearch


Managed Service for OpenSearch поддерживает работу с Yandex Object Storage в качестве репозитория [снапшотов](../../glossary/snapshot.md) OpenSearch. Это позволяет использовать Object Storage для [хранения резервных копий](cluster-backups.md). Подробнее о репозитории снапшотов см. в [документации OpenSearch](https://opensearch.org/docs/latest/opensearch/snapshots/snapshot-restore/).


Для доступа к данным в бакете Object Storage из кластера:

1. [Подключите сервисный аккаунт к кластеру](#connect-service-account).
1. [Настройте права доступа](#configure-acl).
1. [Подключите репозиторий снапшотов](#register-snapshot-repository).


Перед началом работы [назначьте](../../iam/operations/roles/grant.md) вашему аккаунту в Yandex Cloud роль [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) или выше. Она нужна в следующих случаях:


* если вы создаете или изменяете кластер и привязываете к нему сервисный аккаунт;
* если вы восстанавливаете из резервной копии кластер с привязкой к сервисному аккаунту.

## Подключите сервисный аккаунт к кластеру {#connect-service-account}


1. При [создании](cluster-create.md) или [изменении](update.md) кластера выберите существующий [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) либо [создайте новый](../../iam/operations/sa/create.md).

1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) этому аккаунту роль `storage.editor`.


## Настройте права доступа {#configure-acl}

{% list tabs group=instructions %}

- Консоль управления {#console}

    
    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хранится нужный бакет. Если бакета не существует — [создайте](../../storage/operations/buckets/create.md) его.


    1. Перейдите в сервис **Object Storage**.
    1. Выберите вкладку **Бакеты**.
    1. Настройте [ACL бакета](../../storage/operations/buckets/edit-acl.md):
        1. В выпадающем списке **Выберите пользователя** укажите сервисный аккаунт, [подключенный к кластеру](#connect-service-account).
        1. Задайте разрешения `READ и WRITE` для выбранного сервисного аккаунта.
        1. Нажмите кнопки **Добавить** и **Сохранить**.

{% endlist %}

## Подключите репозиторий снапшотов {#register-snapshot-repository}

{% note alert %}

Если бакет зарегистрирован в кластере OpenSearch как репозиторий [снапшотов](../../glossary/snapshot.md), не изменяйте содержимое бакета вручную — это нарушит работу механизма снапшотов OpenSearch.

{% endnote %}

1. [Подключитесь](connect/index.md) к кластеру.
1. Зарегистрируйте бакет как репозиторий снапшотов, используя публичный [API OpenSearch](https://opensearch.org/docs/latest/opensearch/snapshot-restore/#register-repository):

    ```http
    PUT --cacert ~/.opensearch/root.crt https://admin:<пароль>@<идентификатор_хоста_OpenSearch_с_ролью_DATA>.mdb.yandexcloud.net:9200/_snapshot/<имя_репозитория>
    ```

    В параметрах запроса укажите бакет, связанный с сервисным аккаунтом кластера:

    ```bash
    curl --request PUT \
         "https://admin:<пароль>@<идентификатор_хоста_OpenSearch_с_ролью_DATA>.mdb.yandexcloud.net:9200/_snapshot/<имя_репозитория>" \
         --cacert ~/.opensearch/root.crt \
         --header "Content-Type: application/json" \
         --data '{
           "type": "s3",
           "settings": {
             "endpoint": "storage.yandexcloud.net",
             "bucket": "<имя_бакета>"
           }
         }'
    ```