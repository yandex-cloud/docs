---
title: "Настройка доступа к {{ objstorage-full-name }} из кластера {{ OS }}"
description: "Из статьи вы узнаете, как настроить доступ к объектному хранилищу {{ objstorage-name }}, чтобы использовать его как репозиторий снапшотов {{ OS }}."
---

# Настройка доступа к {{ objstorage-name }} из кластера {{ OS }}


{{ mos-name }} поддерживает работу с {{ objstorage-full-name }} в качестве репозитория [снапшотов](https://cloud.yandex.ru/docs/glossary/snapshot) {{ OS }}. Это позволяет использовать {{ objstorage-name }} для [хранения резервных копий](cluster-backups.md). Подробнее о репозитории снапшотов см. в [документации {{ OS }}]({{ os.docs }}/opensearch/snapshots/snapshot-restore/).


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


    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
    1. Выберите вкладку **{{ ui-key.yacloud.storage.buckets.label_title }}**.
    1. Настройте [ACL бакета](../../storage/operations/buckets/edit-acl.md):
        1. В выпадающем списке **{{ ui-key.yacloud.component.acl-dialog.label_select-placeholder }}** укажите сервисный аккаунт, [подключенный к кластеру](#connect-service-account).
        1. Задайте разрешения `READ и WRITE` для выбранного сервисного аккаунта.
        1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
        1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Подключить репозиторий снапшотов {#register-snapshot-repository}

{% note alert %}

Если бакет зарегистрирован в кластере {{ OS }} как репозиторий [снапшотов](https://cloud.yandex.ru/docs/glossary/snapshot), не изменяйте содержимое бакета вручную — это нарушит работу механизма снапшотов {{ OS }}.

{% endnote %}

1. [Установите плагин](plugins.md#update) `repository-s3`.
1. [Подключитесь](connect.md) к кластеру.
1. Зарегистрируйте бакет как репозиторий снапшотов, используя публичный [API {{ OS }}]({{ os.docs }}/opensearch/snapshot-restore/#register-repository):

    ```http
    PUT --cacert ~/.opensearch/root.crt https://admin:<пароль>@<идентификатор_хоста_{{ OS }}_с_ролью_DATA>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<имя_репозитория>
    ```

    В параметрах запроса укажите бакет, связанный с сервисным аккаунтом кластера:

    ```bash
    curl --request PUT \
         "https://admin:<пароль>@<идентификатор_хоста_{{ OS }}_с_ролью_DATA>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<имя_репозитория>" \
         --cacert ~/.opensearch/root.crt \
         --header "Content-Type: application/json" \
         --data '{
           "type": "s3",
           "settings": {
             "endpoint": "{{ s3-storage-host }}",
             "bucket": "<имя_бакета>"
           }
         }'
    ```
