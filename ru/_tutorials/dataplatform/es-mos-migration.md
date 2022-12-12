# Миграция данных из стороннего кластера {{ ES }} в {{ mos-full-name }}

Перенести данные из кластера-источника {{ ES }} в кластер-приемник {{ mos-full-name }} можно с помощью двух механизмов:

* [Снапшотов]({{ os.docs }}/opensearch/snapshots/index/) (snapshots).

    Этот способ подходит для кластеров {{ ES }} версии не выше 7.11.

* [Удаленной переиндексации]({{ os.docs }}/opensearch/reindex-data/) (reindex data).

    С ее помощью можно перенести существующие индексы, псевдонимы (aliases) или потоки данных. Этот способ подходит для всех кластеров {{ ES }} версии 7.

## Миграция с помощью снапшотов {#snapshot}

Чтобы мигрировать данные из кластера-источника {{ ES }} в кластер-приемник {{ mos-name }} с помощью снапшотов:

1. [Создайте снапшот на кластере-источнике](#create-snapshot).
1. [Восстановите снапшот в кластере-приемнике](#restore-snapshot).
1. [Закончите миграцию](#finish-migration-snapshot).

Если используемые ресурсы вам больше не нужны, [удалите их](#clear-out-snapshot).

### Перед началом работы {#before-you-begin-snapshot}

#### Подготовьте инфраструктуру {#deploy-infrastructure-snapshot}

1. [Создайте бакет {{ objstorage-name }}](../../storage/operations/buckets/create.md) с ограниченным доступом. Этот бакет будет использоваться в качестве репозитория снапшотов.
1. {% if audience != "internal" %}[Создайте сервисный аккаунт](../../iam/operations/sa/create.md){% else %}Создайте сервисный аккаунт{% endif %} и {% if audience != "internal" %}[назначьте ему роль](../../iam/operations/sa/assign-role-for-sa.md){% else %}назначьте ему роль{% endif %} `storage.editor`. Сервисный аккаунт необходим для доступа к бакету из кластера-источника и кластера-приемника.
1. {% if audience != "internal" %}[Создайте статический ключ доступа](../../iam/operations/sa/create-access-key.md){% else %}Создайте статический ключ доступа{% endif %} для этого сервисного аккаунта.

    {% note warning %}

    Сохраните **идентификатор ключа** и **секретный ключ**. Они понадобятся позднее.

    {% endnote %}

1. {% if audience != "internal" %}[Создайте кластер-приемник {{ mos-name }}](../../managed-opensearch/operations/cluster-create.md#create-cluster){% else %}Создайте кластер-приемник {{ mos-name }}{% endif %} нужной вам конфигурации с публичным доступом к группе хостов с ролью `DATA`.

1. {% if audience != "internal" %}[Установите плагин](../../managed-opensearch/operations/plugins.md#update){% else %}Установите плагин{% endif %} `repository-s3` в кластер-приемник.

#### Завершите настройку и проверьте доступ к ресурсам {#complete-setup-snapshot}

1. [Настройте ACL](../../storage/operations/buckets/edit-acl.md) для бакета:

    1. В выпадающем списке **Выберите пользователя** укажите созданный ранее сервисный аккаунт.
    1. Задайте разрешения `READ и WRITE` для выбранного сервисного аккаунта.
    1. Нажмите кнопку **Добавить**.
    1. Нажмите кнопку **Сохранить**.

1. [Установите плагин]({{ links.es.docs }}/elasticsearch/plugins/7.11/repository-s3.html) `repository-s3` на все хосты кластера-источника.

1. Чтобы плагин `repository-s3` заработал, перезапустите сервисы {{ ES }} и Kibana на всех хостах кластера-источника.

1. Убедитесь, что вы можете {% if audience != "internal" %}[подключиться к кластеру-приемнику](../../managed-opensearch/operations/connect.md){% else %}подключиться к кластеру-приемнику{% endif %} {{ mos-name }} с помощью {{ OS }} API и Dashboards.

1. Убедитесь, что у кластера-источника {{ ES }} есть доступ в интернет.

### Создайте снапшот на кластере-источнике {#create-snapshot}

1. Подключите бакет в качестве репозитория снапшотов на кластере-источнике:

    1. Добавьте сведения о ключе статического доступа в [хранилище ключей]({{ links.es.docs }}/elasticsearch/reference/current/elasticsearch-keystore.html) (keystore) {{ ES }}.

        {% note info %}

        Выполните процедуру на всех хостах кластера-источника.

        {% endnote %}

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

            Путь к {{ ES }} (`$ES_PATH`) зависит от выбранного способа установки. Найти путь к установленному {{ ES }} можно в [документации по установке]({{ links.es.docs }}/elasticsearch/reference/current/install-elasticsearch.html) (например, для [DEB]({{ links.es.docs }}/elasticsearch/reference/current/deb.html#deb-layout), [RPM]({{ links.es.docs }}/elasticsearch/reference/current/rpm.html#rpm-layout)).

            {% endnote %}

    1. Загрузите данные из хранилища ключей:

        ```bash
        curl --request POST "https://<IP адрес или FQDN хоста с ролью DATA в кластере-источнике>:{{ port-mes }}/_nodes/reload_secure_settings"
        ```

    1. Зарегистрируйте репозиторий:

        ```bash
        curl --request PUT \
             "https://<IP адрес или FQDN хоста с ролью DATA в кластере-источнике>:{{ port-mes }}/_snapshot/<имя репозитория>" \
             --header 'Content-Type: application/json'
             --data '{
               "type": "s3",
               "settings": {
                 "bucket": "<имя бакета>",
                 "endpoint": "{{ s3-storage-host }}"
               }
             }'
        ```

    Подробнее о подключении репозитория см. в [документации плагина]({{ links.es.docs }}/elasticsearch/plugins/7.11/repository-s3.html).

    {% include [mes-objstorage-snapshot](../../_includes/mdb/mes/objstorage-snapshot.md) %}

1. Запустите создание снапшота в репозитории, созданном на предыдущем шаге. Можно создать снапшот всего кластера или части данных. Подробнее см. в [документации {{ ES }}]({{ links.es.docs }}/elasticsearch/reference/current/snapshots-take-snapshot.html).

    Пример создания снапшота с именем `snapshot_1` для всего кластера:

    ```bash
    curl --request PUT \
         "https://<IP адрес или FQDN хоста с ролью DATA в кластере-источнике>:{{ port-mes }}/_snapshot/<имя репозитория>/snapshot_1?wait_for_completion=false&pretty"
    ```

    Процесс создания снапшота может занять длительное время. Отслеживайте ход выполнения операции [с помощью инструментов {{ ES }}]({{ links.es.docs }}/elasticsearch/reference/current/snapshots-take-snapshot.html#monitor-snapshot), например:

    ```bash
    curl --request GET \
         "https://<IP адрес или FQDN хоста с ролью DATA в кластере-источнике>:{{ port-mes }}/_snapshot/<имя репозитория>/snapshot_1/_status?pretty"
    ```

### Восстановите снапшот в кластере-приемнике {#restore-snapshot}

1. {% if audience != "internal" %}[Настройте доступ к бакету со снапшотами](../../managed-opensearch/operations/s3-access.md#configure-acl){% else %}Настройте доступ к бакету со снапшотами{% endif %} для кластера-приемника. Используйте [созданный ранее](#before-you-begin) сервисный аккаунт.

1. {% if audience != "internal" %}[Подключите к кластеру-приемнику бакет {{ objstorage-name }}](../../managed-opensearch/operations/s3-access.md#register-snapshot-repository){% else %}Подключите к кластеру-приемнику бакет {{ objstorage-name }}{% endif %} в качестве хранилища снапшотов в режиме только для чтения:

    ```bash
    curl --request PUT \
         "https://admin:<пароль пользователя admin>@<идентификатор хоста OpenSearch с ролью DATA>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<имя репозитория>" \
         --cacert ~/.opensearch/root.crt \
         --header 'Content-Type: application/json'
         --data '{
           "type": "s3",
           "settings": {
             "bucket": "<имя бакета>",
             "readonly" : "true",
             "endpoint": "{{ s3-storage-host }}"
           }
         }'
    ```

1. Выберите способ восстановления индексов на кластере-приемнике.

    При настройках по умолчанию попытка восстановления индекса завершится неудачей, если в кластере уже открыт индекс с тем же именем. Даже если кластер {{ mos-name }} не содержит пользовательских данных, в нем есть открытые системные индексы (такие как `.apm-custom-link`, `.kibana_*` и другие), что может помешать восстановлению. Чтобы этого избежать, воспользуйтесь одним из способов:

    * Переносите только пользовательские индексы. Существующие системные индексы не переносятся, в процессе импорта участвую только индексы, созданные на кластере-источнике пользователем.

    * Используйте параметры `rename_pattern` и `rename_replacement`. Индексы будут переименовываться по мере их восстановления. Подробнее см. в [документации {{ OS }}]({{ os.docs }}/opensearch/snapshots/snapshot-restore#conflicts-and-compatibility).

    Пример восстановления снапшота целиком:

    ```bash
    curl --request POST \
         "https://admin:<пароль пользователя admin>@<идентификатор хоста OpenSearch с ролью DATA>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<имя репозитория>/snapshot_1/_restore" \
         --cacert ~/.opensearch/root.crt
    ```

1. Запустите восстановление из снапшота на кластере-приемнике.

    Пример восстановления снапшота с указанием пользовательских индексов, которые нужно восстановить в кластере-приемнике:

    ```bash
    curl --request POST \
         "https://admin:<пароль пользователя admin>@<идентификатор хоста OpenSearch с ролью DATA>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<имя репозитория>/snapshot_1/_restore?wait_for_completion=false&pretty"
         --cacert ~/.opensearch/root.crt \
         --header 'Content-Type: application/json' \
         --data '{
           "indices": "<список индексов>"
         }'
    ```

    Где `список индексов` — список восстанавливаемых индексов через запятую, например `my_index*, my_index_2.*`.

    Процесс восстановления может занять длительное время. Чтобы проверить статус восстановления, выполните команду:

    ```bash
    curl --request GET \
         "https://admin:<пароль пользователя admin>@<идентификатор хоста OpenSearch с ролью DATA>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<имя репозитория>/snapshot_1/_status?pretty" \
         --cacert ~/.opensearch/root.crt
    ```

### Закончите миграцию {#finish-migration-snapshot}

1. Убедитесь, что все нужные данные перенесены в кластер-приемник {{ mos-name }}.

    Это можно сделать, например, с помощью {% if audience != "internal" %}[{{ OS }} Dashboards](../../managed-opensearch/operations/connect.md#dashboards){% else %}{{ OS }} Dashboards{% endif %}.

1. При необходимости [отключите репозиторий снапшотов]({{ links.es.docs }}/elasticsearch/reference/current/delete-snapshot-repo-api.html) на стороне кластера-источника и кластера-приемника.

### Удалите созданные ресурсы {#clear-out-snapshot}

* {% if audience != "internal" %}[Удалите сервисный аккаунт](../../iam/operations/sa/delete.md){% else %}Удалите сервисный аккаунт{% endif %}.
* [Удалите снапшоты](../../storage/operations/objects/delete.md) из бакета и затем удалите [бакет целиком](../../storage/operations/buckets/delete.md).
* {% if audience != "internal" %}[Удалите кластер {{ mos-name }}](../../managed-opensearch/operations/cluster-delete.md){% else %}Удалите кластер {{ mos-name }}{% endif %}.

## Миграция с помощью переиндексации {#reindex}

Чтобы мигрировать данные из кластера-источника {{ ES }} в кластер-приемник {{ mos-name }} с помощью переиндексации:

1. [Настройте кластер-приемник](#configure-target-reindex).
1. [Запустите переиндексацию](#start-reindex).
1. [Проверьте результат](#check-result-reindex).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out-reindex).

### Перед началом работы {#before-you-begin-reindex}

1. {% if audience != "internal" %}[Создайте кластер-приемник {{ mos-name }}](../../managed-opensearch/operations/cluster-create.md#create-cluster){% else %}Создайте кластер-приемник {{ mos-name }}{% endif %} нужной вам конфигурации с публичным доступом к группе хостов с ролью `DATA`.

1. Убедитесь, что вы можете {% if audience != "internal" %}[подключиться к кластеру-приемнику](../../managed-opensearch/operations/connect.md){% else %}подключиться к кластеру-приемнику{% endif %} {{ mos-name }} с помощью {{ OS }} API и Dashboards.

1. Убедитесь, что у кластера-источника {{ ES }} есть доступ в интернет.

1. Создайте в кластере-источнике [пользователя]({{ links.es.docs }}/kibana/current/xpack-security.html#_users_2) с [ролями]({{ links.es.docs }}/kibana/current/xpack-security.html#_roles_2) `monitoring_user` и `viewer`.

### Настройте кластер-приемник {#configure-target-reindex}

1. [Создайте роль]({{ os.docs }}/security-plugin/access-control/users-roles/#create-roles) с привилегиями `create_index` и `write` для всех индексов (`*`).

1. {% if audience != "internal" %}[Создайте пользователя](../../managed-opensearch/operations/cluster-users.md){% else %}Создайте пользователя{% endif %} и назначьте ему эту роль.

    {% note tip %}

    В кластерах {{ mos-name }} вы можете использовать переиндексацию от имени пользователя `admin`, имеющего роль `superuser`, но безопаснее для каждой задачи создавать отдельных пользователей с ограниченными привилегиями. {% if audience != "internal" %}Подробнее см. в разделе [{#T}](../../managed-opensearch/operations/cluster-users.md).{% endif %}

    {% endnote %}

### Запустите переиндексацию {#start-reindex}

1. {% if audience != "internal" %}[Получите список хостов](../../managed-opensearch/operations/host-groups.md#list-hosts){% else %}Получите список хостов{% endif %} кластера-приемника.

1. Для запуска переиндексации выполните запрос к хосту с ролью `DATA` в кластере-приемнике:

    ```bash
    curl --user <имя пользователя в кластере-приемнике>:<пароль пользователя в кластере-приемнике> \
         --cacert ~/.opensearch/root.crt \
         --request POST
         "https://<идентификатор хоста OpenSearch с ролью DATA>.{{ dns-zone }}:{{ port-mos }}/_reindex?wait_for_completion=false&pretty" \
         --header 'Content-Type: application/json' \
         --data '{
           "source": {
             "remote": {
               "host": "https://<IP адрес или FQDN хоста с ролью DATA в кластере-источнике>:{{ port-mes }}",
               "username": "<имя пользователя в кластере-источнике>",
               "password": "<пароль пользователя в кластере-источнике>"
             },
             "index": "<имя индекса, псевдонима или потока данных в кластере-источнике>"
           },
           "dest": {
             "index": "<имя индекса, псевдонима или потока данных в кластере-приемнике>"
           }
         }'
    ```

    Результат:

    ```text
    {
      "task" : "<идентификатор задачи переиндексации>"
    }
    ```

    Чтобы перенести несколько индексов, используйте цикл `for`:

    ```bash
    for index in <имена индексов, псевдонимов или потоков данных, разделенные пробелами>; do
      curl --user <имя пользователя в кластере-приемнике>:<пароль пользователя в кластере-приемнике> \
           --cacert ~/.opensearch/root.crt \
           --request POST
           "https://<идентификатор хоста OpenSearch с ролью DATA>.{{ dns-zone }}:{{ port-mos }}/_reindex?wait_for_completion=false&pretty" \
           --header 'Content-Type: application/json' \
           --data '{
             "source": {
               "remote": {
                 "host": "https://<IP адрес или FQDN хоста с ролью DATA в кластере-источнике>:{{ port-mes }}",
                 "username": "<имя пользователя в кластере-источнике>",
                 "password": "<пароль пользователя в кластере-источнике>"
               },
               "index": "'$index'"
             },
             "dest": {
               "index": "'$index'"
             }
           }'
    done
    ```

    Результат:

    ```text
    {
      "task" : "<идентификатор задачи переиндексации 1>"
    }
    {
      "task" : "<идентификатор задачи переиндексации 2>"
    }
    ...
    ```

    Подробнее о параметрах переиндексации см. в [документации {{ OS }}]({{ os.docs }}/opensearch/reindex-data/#source-index-options).

    Процесс переиндексации может занять длительное время. Чтобы проверить статус операции, выполните команду:

    ```bash
    curl --user <имя пользователя в кластере-приемнике>:<пароль пользователя в кластере-приемнике> \
         --cacert ~/.opensearch/root.crt \
         --request GET \
         "https://<идентификатор хоста OpenSearch с ролью DATA>.{{ dns-zone }}:{{ port-mos }}/_tasks/<идентификатор задачи переиндексации>"
    ```

1. Чтобы отменить операцию переиндексации, выполните команду:

    ```bash
    curl --user <имя пользователя в кластере-приемнике>:<пароль пользователя в кластере-приемнике> \
         --cacert ~/.opensearch/root.crt \
         --request POST \
         "https://admin:<пароль пользователя admin>@<идентификатор хоста OpenSearch с ролью DATA>.{{ dns-zone }}:{{ port-mos }}/_tasks/<идентификатор задачи переиндексации>/_cancel"
    ```

### Проверьте результат {#check-result-reindex}

Убедитесь, что все нужные данные перенесены в кластер-приемник {{ mos-name }}.

Это можно сделать, например, с помощью {% if audience != "internal" %}[{{ OS }} Dashboards](../../managed-opensearch/operations/connect.md#dashboards){% else %}{{ OS }} Dashboards{% endif %}.

### Удалите неиспользуемые ресурсы {#clear-out-reindex}

Если созданные ресурсы вам больше не нужны, удалите их:

* {% if audience != "internal" %}[Удалите кластер {{ mos-name }}](../../managed-opensearch/operations/cluster-delete.md){% else %}Удалите кластер {{ mos-name }}{% endif %}.
* Если вы зарезервировали для доступа к кластеру публичные статические IP-адреса, освободите и {% if audience != "internal" %}[удалите их](../../vpc/operations/address-delete.md){% else %}удалите их{% endif %}.
