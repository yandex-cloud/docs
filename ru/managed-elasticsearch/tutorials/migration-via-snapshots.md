# Миграция в {{ mes-name }} с помощью снапшотов

Кластер {{ mes-name }} поддерживает механизм [снапшотов](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore.html) (snapshots). Это позволяет мигрировать в него данные из другого кластера {{ ES }}.

Чтобы мигрировать данные из *кластера-источника* {{ ES }} в *кластер-приемник* {{ mes-name }}:

1. [{#T}](#create-snapshot).
1. [{#T}](#restore-from-snapshot).
1. [{#T}](#finish-migration).

## Перед началом работы {#before-you-begin}


1. [Создайте бакет {{ objstorage-name }}](../../storage/operations/buckets/create.md) с ограниченным доступом. Этот бакет будет использоваться в качестве репозитория снапшотов.
1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md). Он необходим для доступа к бакету из кластера-источника и кластера-приемника.

1. Перед созданием кластера-приемника [проверьте совместимость](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore.html#snapshot-restore-version-compatibility) кластера-источника и выбранной версии кластера-приемника.

    {% note warning %}

    Использовать снапшот невозможно, если версия {{ ES }} в кластере-источнике старше, чем в кластере-приемнике. Например, не получится восстановить снапшот кластера {{ ES }} 7.13 в кластере {{ mes-name }} 7.11.

    {% endnote %}

1. Убедитесь, что вы можете [подключиться к кластеру-приемнику](../operations/cluster-connect.md) {{ mes-name }} с помощью {{ ES }} API и Kibana.
1. Убедитесь, что у кластера-источника {{ ES }} есть доступ в интернет.

## Создайте снапшот на кластере-источнике {#create-snapshot}


1. [Назначьте роль](../../iam/operations/sa/assign-role-for-sa.md) `storage.editor` [созданному ранее](#before-you-begin) сервисному аккаунту.

1. [Создайте статический ключ доступа](../../iam/operations/sa/create-access-key.md) для этого сервисного аккаунта.


    {% note warning %}

    Сохраните **идентификатор ключа** и **секретный ключ**. Они понадобятся позднее.

    {% endnote %}
    
1. [Настройте ACL](../../storage/operations/buckets/edit-acl.md) для [созданного ранее](#before-you-begin) бакета:

    1. В выпадающем списке **Выберите пользователя** укажите сервисный аккаунт.
    1. Задайте разрешения `READ + WRITE` для выбранного сервисного аккаунта.
    1. Нажмите кнопку **Добавить**.
    1. Нажмите кнопку **Сохранить**.

1. [Установите расширение](https://www.elastic.co/guide/en/elasticsearch/plugins/7.16/repository-s3.html) `repository-s3` на кластере-источнике.

    Расширение должно быть установлено на **всех хостах** кластера-источника. После установки потребуется перезапуск сервисов {{ ES }} и Kibana на хостах.

    1. Подключите бакет в качестве репозитория снапшотов на кластере-источнике:
    1. Добавьте сведения о ключе статического доступа в [хранилище ключей](https://www.elastic.co/guide/en/elasticsearch/reference/current/elasticsearch-keystore.html) (keystore) {{ ES }}.

        Выполните процедуру на **всех хостах** кластера-источника.

        Добавьте:

        * **Идентификатор ключа**:

            ```bash
            $ES_PATH/bin/elasticsearch-keystore add s3.client.default.access_key
            ```

        * **Секретный ключ**:

            ```bash
            $ES_PATH/bin/elasticsearch-keystore add s3.client.default.secret_key
            ```

            {% note info %}

            Путь к {{ ES }} (`$ES_PATH`) зависит от выбранного способа установки. Найти путь к установленному {{ ES }} можно в [документации по установке](https://www.elastic.co/guide/en/elasticsearch/reference/current/install-elasticsearch.html) (например, для [DEB](https://www.elastic.co/guide/en/elasticsearch/reference/current/deb.html#deb-layout), [RPM](https://www.elastic.co/guide/en/elasticsearch/reference/current/rpm.html#rpm-layout)).

            {% endnote %}

    1. Загрузите данные из хранилища ключей:

        ```bash
        curl -X POST "http://<FQDN кластера-источника>:9200/_nodes/reload_secure_settings"
        ```

    1. Зарегистрируйте репозиторий:

        ```bash
        curl "http://<FQDN кластера-источника>:9200/_snapshot/<имя репозитория>" \
             -X PUT \
             -H 'Content-Type: application/json' -d '
               {
                 "type": "s3",
                 "settings": {
                   "bucket": "<имя бакета>",
                   "endpoint": "{{ s3-storage-host }}"
                 }
               }
        '
        ```

    Подробнее о подключении репозитория см. в [документации плагина](https://www.elastic.co/guide/en/elasticsearch/plugins/current/repository-s3.html).

    {% include [mes-objstorage-snapshot](../../_includes/mdb/mes/objstorage-snapshot.md) %}

1. Запустите создание снапшота на кластере-источнике. Можно создать снапшот всего кластера или части данных. Разместите снапшот в репозитории, созданном на предыдущем шаге. Подробнее см. в [документации {{ ES }}](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html).

    Пример создания снапшота всего кластера:

    ```bash
    curl --request PUT "http://<FQDN кластера-источника>:9200/_snapshot/<имя репозитория>/snapshot_1?wait_for_completion=true&pretty"
    ```

    Начнется создание снапшота. Этот процесс может занять длительное время. Отслеживайте ход выполнения операции [с помощью инструментов {{ ES }}](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html#monitor-snapshot), например:

    ```bash
    curl --request GET "http://<FQDN кластера-источника>:9200/_snapshot/_status?pretty"
    ```

## Запустите восстановление из снапшота на кластере-приемнике {#restore-from-snapshot}

1. [Настройте доступ к бакету со снапшотами](../operations/s3-access.md) для кластера-приемника. Используйте [созданный ранее](#before-you-begin) сервисный аккаунт.

1. Выберите способ восстановления индексов на кластере-приемнике.

    При настройках по умолчанию попытка восстановления индекса завершится неудачей, если в кластере уже открыт индекс с тем же именем. Даже если кластер {{ mes-name }} не содержит пользовательских данных, в нем есть открытые системные индексы (такие как `.apm-custom-link`, `.kibana_*` и другие), что может помешать восстановлению. Чтобы этого избежать, воспользуйтесь одной из политик восстановления:

    * [Delete and restore](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html#delete-restore) — существующие индексы закрываются и удаляются, вместо них создаются новые пустые с такими же именами, после чего наполняются данными из снапшота.

    * [Rename on restore](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html#rename-on-restore) — существующие индексы не затрагиваются, создаются новые с измененными именами. Данные из снапшота восстанавливаются в новые индексы.

    {% note warning %}

    Закрытие всех индексов приведет к временной неработоспособности Kibana. После того, как будут открыты системные индексы, Kibana вновь станет доступна.

    {% endnote %}

    Например, эта команда закроет все индексы в кластере-приемнике:

    ```bash
    curl --cacert ~/.elasticsearch/root.crt \
         --request POST \
         "https://admin:<пароль admin>@<FQDN кластера-приемника>:9200/_all/_close?pretty"
    ```

1. Запустите восстановление из снапшота на кластере-приемнике. Можно восстановить как весь снапшот, так и его часть. Подробнее см. в [документации {{ ES }}](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html).

    Пример восстановления снапшота целиком:

    ```bash
    curl --cacert ~/.elasticsearch/root.crt \
         --request POST \
         "https://admin:<пароль admin>@<FQDN кластера-приемника>:9200/_snapshot/<имя репозитория>/snapshot_1/_restore"
    ```

    Начнется восстановление из снапшота. Этот процесс может занять длительное время. Отслеживайте ход выполнения операции [с помощью инструментов {{ ES }}](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html#monitor-snapshot), например:

    ```bash
    curl --cacert ~/.elasticsearch/root.crt \
         --request GET \
         "https://admin:<пароль admin>@<FQDN кластера-приемника>:9200/_snapshot/_status?pretty"
    ```

1. При необходимости после завершения операции восстановления [откройте все закрытые индексы](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-open-close.html).

    Например, эта команда откроет все индексы в кластере-приемнике:

    ```bash
    curl --cacert ~/.elasticsearch/root.crt \
         --request POST \
         "https://admin:<пароль admin>@<FQDN кластера-приемника>:9200/_all/_open?pretty"
    ```

## Закончите миграцию {#finish-migration}

1. Убедитесь, что все нужные данные перенесены в кластер-приемник {{ mes-name }}.

    Это можно сделать, например, с [помощью Kibana](../operations/cluster-connect.md).

1. При необходимости [отключите репозиторий снапшотов](https://www.elastic.co/guide/en/elasticsearch/reference/current/delete-snapshot-repo-api.html) на стороне кластера-источника и кластера-приемника.

1. При необходимости удалите неиспользуемые ресурсы в {{ yandex-cloud }}:
    
    * [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md).
    * [Удалите снапшоты](../../storage/operations/objects/delete.md) из бакета и затем удалите [бакет целиком](../../storage/operations/buckets/delete.md).

