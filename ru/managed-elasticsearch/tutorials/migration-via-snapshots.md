# Миграция в {{ mes-name }} с помощью снапшотов

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

Кластер {{ mes-name }} поддерживает механизм [снапшотов](https://cloud.yandex.ru/docs/glossary/snapshot). Это позволяет мигрировать в него данные из другого кластера {{ ES }}. Подробнее о механизме снапшотов см. в [документации {{ ES }}](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore.html).

Чтобы мигрировать данные из *кластера-источника* {{ ES }} в *кластер-приемник* {{ mes-name }}:

1. [{#T}](#before-you-begin).
1. [{#T}](#create-snapshot).
1. [{#T}](#restore-snapshot).
1. [{#T}](#finish-migration).

Если используемые ресурсы вам больше не нужны, [удалите их](#clear-out).

{% note warning %}

Использовать снапшот невозможно, если версия {{ ES }} в кластере-источнике выше, чем в кластере-приемнике. Например, не получится восстановить снапшот кластера {{ ES }} 7.13 в кластере {{ mes-name }} 7.11.

{% endnote %}

## Подготовьте рабочее окружение {#before-you-begin}

### Создайте необходимые ресурсы {#create-resources}

{% list tabs %}

- Вручную

    1. [Создайте бакет {{ objstorage-name }}](../../storage/operations/buckets/create.md) с ограниченным доступом. Этот бакет будет использоваться в качестве репозитория снапшотов.
    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) и [назначьте ему роль](../../iam/operations/sa/assign-role-for-sa.md) `storage.editor`. Сервисный аккаунт необходим для доступа к бакету из кластера-источника и кластера-приемника.
    1. [Создайте статический ключ доступа](../../iam/operations/sa/create-access-key.md) для этого сервисного аккаунта.

        {% note warning %}

        Сохраните **идентификатор ключа** и **секретный ключ**. Они понадобятся позднее.

        {% endnote %}

    1. [Создайте кластер-приемник](../operations/cluster-create.md#create-cluster) {{ mes-name }} нужной вам конфигурации со следующими настройками:

        * публичный доступ к хостам;
        * версия {{ ES }} не ниже чем на кластере-источнике.

        Перед созданием кластера-приемника [проверьте совместимость](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore.html#snapshot-restore-version-compatibility) кластера-источника и выбранной версии кластера-приемника.

    1. [Установите плагин](../operations/cluster-plugins.md#update) `repository-s3` в кластер-приемник.

- С помощью {{ TF }}

    1. Если у вас еще нет {{ TF }}, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
    1. Скачайте в ту же рабочую директорию файл конфигурации [mes-migration.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/mes-migration.tf). В файле описаны:

       * сеть;
       * подсеть;
       * группа безопасности и правила, необходимые для доступа к кластеру-приемнику {{ mes-name }};
       * сервисный аккаунт `sa-mes-cluster`, необходимый для создания кластера {{ mes-name }};
       * сервисный аккаунт `sa-bucket` для работы с бакетом {{ objstorage-name }}.
       * кластер-приемник с установленным плагином [repository-s3](https://www.elastic.co/guide/en/elasticsearch/plugins/7.16/repository-s3.html);

    1. Укажите в файле конфигурации `mes-migration.tf` в блоке `locals`:
        * [идентификатор каталога](../../resource-manager/operations/folder/get-id.md);
        * [пароль для пользователя `admin`](../operations/cluster-update.md#change-admin-password);
        * [редакцию кластера-приемника](../concepts/es-editions.md);
        * версию кластера-приемника;
        * имя бакета {{ objstorage-name }}.

    1. Выполните команду `terraform init` в директории с конфигурационными файлами. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

       {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

    1. [Создайте статический ключ доступа](../../iam/operations/sa/create-access-key.md) для сервисного аккаунта `sa-bucket`.

        {% note warning %}

        Сохраните **идентификатор ключа** и **секретный ключ**. Они понадобятся позднее.

        {% endnote %}

{% endlist %}

### Завершите настройку и проверьте доступ к ресурсам {#complete-setup}

1. [Настройте ACL](../../storage/operations/buckets/edit-acl.md) для бакета:

    1. В выпадающем списке **{{ ui-key.yacloud.component.acl-dialog.label_select-placeholder }}** укажите созданный ранее сервисный аккаунт.
    1. Задайте разрешения `READ и WRITE` для выбранного сервисного аккаунта.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

1. [Установите плагин](https://www.elastic.co/guide/en/elasticsearch/plugins/7.16/repository-s3.html) `repository-s3` на все хосты кластера-источника.

1. Чтобы плагин `repository-s3` заработал, перезапустите сервисы {{ ES }} и Kibana на всех хостах кластера-источника.

1. Убедитесь, что вы можете [подключиться к кластеру-приемнику](../operations/cluster-connect.md) {{ mes-name }} с помощью {{ ES }} API и Kibana.
1. Убедитесь, что у кластера-источника {{ ES }} есть доступ в интернет.

## Создайте снапшот на кластере-источнике {#create-snapshot}

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
        curl -X POST "https://<FQDN кластера-источника>:9200/_nodes/reload_secure_settings"
        ```

    1. Зарегистрируйте репозиторий:

        ```bash
        curl "https://<FQDN кластера-источника>:9200/_snapshot/<имя репозитория>" \
             -X PUT \
             -H 'Content-Type: application/json' -d '
               {
                 "type": "s3",
                 "settings": {
                   "bucket": "<имя бакета>",
                   "endpoint": "{{ s3-storage-host }}"
                 }
               }'
        ```

    Подробнее о подключении репозитория см. в [документации плагина](https://www.elastic.co/guide/en/elasticsearch/plugins/current/repository-s3.html).

    {% include [mes-objstorage-snapshot](../../_includes/mdb/mes/objstorage-snapshot.md) %}

1. Запустите создание снапшота на кластере-источнике. Можно создать снапшот всего кластера или части данных. Разместите снапшот в репозитории, созданном на предыдущем шаге. Подробнее см. в [документации {{ ES }}](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html).

    Пример создания снапшота с именем `snapshot_1` для всего кластера:

    ```bash
    curl -X PUT \
         "https://<FQDN кластера-источника>:9200/_snapshot/<имя репозитория>/snapshot_1?wait_for_completion=true&pretty"
    ```

    Процесс создания снапшота может занять длительное время. Отслеживайте ход выполнения операции [с помощью инструментов {{ ES }}](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html#monitor-snapshot), например:

    ```bash
    curl -X GET \
         "https://<FQDN кластера-источника>:9200/_snapshot/<имя репозитория>/snapshot_1/_status?pretty"
    ```

## Восстановите снапшот в кластере-приемнике {#restore-snapshot}

1. [Настройте доступ к бакету со снапшотами](../operations/s3-access.md) для кластера-приемника. Используйте [созданный ранее](#before-you-begin) сервисный аккаунт.

1. Подключите к кластеру-приемнику бакет {{ objstorage-name }} в качестве хранилища снапшотов:

    ```bash
    curl "https://admin:<пароль пользователя admin>@<FQDN кластера-приемника>:9200/_snapshot/<имя репозитория>" \
         -X PUT \
         -H 'Content-Type: application/json' -d '
           {
             "type": "s3",
             "settings": {
               "bucket": "<имя бакета>",
               "endpoint": "{{ s3-storage-host }}"
             }
           }'
    ```

1. Выберите способ восстановления индексов на кластере-приемнике:

    При настройках по умолчанию попытка восстановления индекса завершится неудачей, если в кластере уже открыт индекс с тем же именем. Даже если кластер {{ mes-name }} не содержит пользовательских данных, в нем есть открытые системные индексы (такие как `.apm-custom-link`, `.kibana_*` и другие), что может помешать восстановлению. Чтобы этого избежать, воспользуйтесь одной из политик восстановления:

    * Только пользовательские индексы — существующие системные индексы не переносятся, в процессе импорта участвую только индексы, созданные на кластере-источнике пользователем.

    * [Delete and restore](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html#delete-restore) — существующие индексы закрываются и удаляются, вместо них создаются новые пустые с такими же именами, после чего наполняются данными из снапшота.

    * [Rename on restore](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html#rename-on-restore) — существующие индексы не затрагиваются, создаются новые с измененными именами. Данные из снапшота восстанавливаются в новые индексы.

    {% note warning %}

    Закрытие всех индексов приведет к временной неработоспособности Kibana. После того как будут открыты системные индексы, Kibana вновь станет доступна.

    {% endnote %}

    Например, эта команда закроет все индексы в кластере-приемнике:

    ```bash
    curl -X POST \
         "https://admin:<пароль пользователя admin>@<FQDN кластера-приемника>:9200/_all/_close?pretty"
    ```

    Пример восстановления снапшота целиком:

    ```bash
    curl -X POST \
         "https://admin:<пароль пользователя admin>@<FQDN кластера-приемника>:9200/_snapshot/<имя репозитория>/snapshot_1/_restore"
    ```

1. Запустите восстановление из снапшота на кластере-приемнике. Можно восстановить весь снапшот или отдельные индексы. Подробнее см. в [документации {{ ES }}](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html).

    Пример восстановления снапшота с указанием пользовательских индексов, которые нужно восстановить в кластере-приемнике:

    ```bash
    curl -X POST \
         -H 'Content-Type: application/json' 'https://admin:<пароль пользователя admin>@<FQDN кластера-приемника>:9200/_snapshot/<имя репозитория>/snapshot_1/_restore' -d '
         {
           "indices": "<список индексов>"
         }'
    ```

    Где `список индексов` — список восстанавливаемых индексов через запятую, например `my_index*, my_index_2.*`. Перенос только пользовательских индексов позволит избежать ошибок при восстановлении снапшота — системные индексы не затрагиваются.

    Процесс восстановления может занять длительное время. Отслеживайте ход выполнения операции [с помощью инструментов {{ ES }}](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html#monitor-snapshot), например:

    ```bash
    curl -X GET \
         "https://admin:<пароль пользователя admin>@<FQDN кластера-приемника>:9200/_snapshot/<имя репозитория>/snapshot_1/_status?pretty"
    ```

1. При необходимости после завершения операции восстановления [откройте все закрытые индексы](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-open-close.html).

    Например, эта команда откроет все индексы в кластере-приемнике:

    ```bash
    curl -X POST \
         "https://admin:<пароль пользователя admin>@<FQDN кластера-приемника>:9200/_all/_open?pretty"
    ```

## Закончите миграцию {#finish-migration}

1. Убедитесь, что все нужные данные перенесены в кластер-приемник {{ mes-name }}.

    Это можно сделать, например, с [помощью Kibana](../operations/cluster-connect.md).

1. При необходимости [отключите репозиторий снапшотов](https://www.elastic.co/guide/en/elasticsearch/reference/current/delete-snapshot-repo-api.html) на стороне кластера-источника и кластера-приемника.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs %}

- Вручную

    * [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md)
    * [Удалите снапшоты](../../storage/operations/objects/delete.md) из бакета и затем удалите [бакет целиком](../../storage/operations/buckets/delete.md).
    * [Удалите кластер {{ mes-name }}](../operations/cluster-delete.md).

- С помощью {{ TF }}

    Чтобы удалить инфраструктуру, созданную с помощью {{ TF }}:

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл `mes-migration.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `mes-migration.tf`, будут удалены.

{% endlist %}
