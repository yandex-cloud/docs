# Настройка доступа к {{ objstorage-name }} из кластера {{ OS }}

{{ mos-name }} поддерживает работу с {{ objstorage-full-name }} в качестве [репозитория снапшотов]({{ os.docs }}/opensearch/snapshot-restore/) {{ OS }}. Это позволяет использовать {{ objstorage-name }}:

* для [переноса данных из кластера {{ ES }} в {{ mos-name }}](../tutorials/migration-to-opensearch.md#snapshot);


* для [хранения резервных копий](cluster-backups.md).

Для доступа к данным в бакете {{ objstorage-name }} из кластера:

1. [Подключите сервисный аккаунт к кластеру](#connect-service-account).
1. [Настройте права доступа](#configure-acl).
1. [Подключите репозиторий снапшотов](#register-snapshot-repository).

## Подключить сервисный аккаунт к кластеру {#connect-service-account}


1. При [создании](cluster-create.md) или [изменении](update.md) кластера выберите существующий [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), либо [создайте новый](../../iam/operations/sa/create.md).

1. Убедитесь, что этому аккаунту [назначена роль](../../iam/operations/sa/assign-role-for-sa.md) `storage.editor`.


## Настроить права доступа {#configure-acl}

{% list tabs %}

- Консоль управления

    
    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хранится нужный бакет. Если бакета не существует — [создайте](../../storage/operations/buckets/create.md) его.


    1. Выберите сервис **{{ objstorage-name }}**.
    1. Выберите вкладку **Бакеты**.
    1. Настройте [ACL бакета](../../storage/operations/buckets/edit-acl.md):
        1. В выпадающем списке **Выберите пользователя** укажите сервисный аккаунт, [подключенный к кластеру](#connect-service-account).
        1. Задайте разрешения `READ и WRITE` для выбранного сервисного аккаунта.
        1. Нажмите кнопку **Добавить**.
        1. Нажмите кнопку **Сохранить**.

{% endlist %}

## Подключить репозиторий снапшотов {#register-snapshot-repository}

{% note alert %}

Если бакет зарегистрирован в кластере {{ OS }} как репозиторий снапшотов, не изменяйте содержимое бакета вручную — это нарушит работу механизма снапшотов {{ OS }}.

{% endnote %}

1. [Установите плагин](plugins.md#update) `repository-s3`.
1. [Подключитесь](connect.md) к кластеру.
1. Зарегистрируйте бакет как репозиторий снапшотов, используя публичный [API {{ OS }}]({{ os.docs }}/opensearch/snapshot-restore/#register-repository):

    ```http
    PUT --cacert ~/.opensearch/root.crt https://admin:<пароль>@<идентификатор хоста {{ OS }} с ролью DATA>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<имя репозитория>
    ```

    В параметрах запроса укажите бакет, связанный с сервисным аккаунтом кластера:

    ```bash
    curl --cacert ~/.opensearch/root.crt https://admin:<пароль>@<идентификатор хоста {{ OS }} с ролью DATA>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<имя репозитория> \
         -X PUT \
         --header "Content-Type: application/json" \
         --data '{
           "type": "s3",
             "settings": {
             "endpoint": "{{ s3-storage-host }}",
             "bucket": "<имя бакета>"
           }
         }'
    ```
