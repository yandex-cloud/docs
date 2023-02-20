# Миграция данных из {{ ES }} в {{ mos-full-name }}

{% if audience != "internal" %}

Перенести данные из кластера-источника {{ ES }} в кластер-приемник {{ mos-full-name }} можно с помощью двух механизмов:

* [Снапшотов]({{ os.docs }}/opensearch/snapshots/index/) (snapshots).

    Этот способ подходит для кластеров {{ ES }} версии не выше 7.11.

* Удаленной [переиндексации]({{ os.docs }}/opensearch/reindex-data/) (reindex data).

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
1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) и [назначьте ему роль](../../iam/operations/sa/assign-role-for-sa.md) `storage.editor`. Сервисный аккаунт необходим для доступа к бакету из кластера-источника и кластера-приемника.
1. Если вы переносите данные из стороннего кластера {{ ES }}, [создайте статический ключ доступа](../../iam/operations/sa/create-access-key.md) для этого сервисного аккаунта.

    {% note warning %}

    Сохраните **идентификатор ключа** и **секретный ключ**. Они понадобятся позднее.

    {% endnote %}

1. [Создайте кластер-приемник {{ mos-name }}](../../managed-opensearch/operations/cluster-create.md#create-cluster) нужной вам конфигурации со следующими настройками:

    * Плагин — `repository-s3`.
    * Публичный доступ к группе хостов с ролью `DATA`.

#### Завершите настройку и проверьте доступ к ресурсам {#complete-setup-snapshot}

1. [Настройте ACL](../../storage/operations/buckets/edit-acl.md) для бакета:

    1. В выпадающем списке **Выберите пользователя** укажите созданный ранее сервисный аккаунт.
    1. Задайте разрешения `READ и WRITE` для выбранного сервисного аккаунта.
    1. Нажмите кнопку **Добавить**.
    1. Нажмите кнопку **Сохранить**.

1. Настройте кластер-источник {{ ES }}:

    {% list tabs %}

    - Сторонний кластер {{ ES }}

        1. [Установите плагин]({{ links.es.docs }}/elasticsearch/plugins/7.11/repository-s3.html) `repository-s3` на все хосты кластера.

        1. Чтобы плагин `repository-s3` заработал, перезапустите сервисы {{ ES }} и Kibana на всех хостах кластера.

        1. Убедитесь, что у кластера-источника {{ ES }} есть доступ в интернет.

    - {{ mes-name }}

        1. [Установите плагин](../../managed-opensearch/operations/plugins.md#update) `repository-s3`.

        1. [Установите SSL-сертификат](../../managed-elasticsearch/operations/cluster-connect.md#get-ssl-cert).

        1. Убедитесь, что вы можете [подключиться к кластеру-источнику](../../managed-elasticsearch/operations/cluster-connect.md) с помощью {{ ES }} API и Kibana.

    {% endlist %}

1. [Установите SSL-сертификат](../../managed-opensearch/operations/connect.md#ssl-certificate).

1. Убедитесь, что вы можете [подключиться к кластеру-приемнику](../../managed-opensearch/operations/connect.md) {{ mos-name }} с помощью {{ OS }} API и Dashboards.

### Создайте снапшот на кластере-источнике {#create-snapshot}

1. Подключите бакет в качестве репозитория снапшотов на кластере-источнике:

    {% list tabs %}

    - Сторонний кластер {{ ES }}

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
                 --header 'Content-Type: application/json' \
                 --data '{
                   "type": "s3",
                   "settings": {
                     "bucket": "<имя бакета>",
                     "endpoint": "{{ s3-storage-host }}"
                   }
                 }'
            ```

    - {{ mes-name }}

        Выполните команду:

        ```bash
        curl --request PUT \
             "https://admin:<пароль пользователя admin>@<IP адрес или FQDN хоста с ролью DATA в кластере-источнике>:{{ port-mes }}/_snapshot/<имя репозитория>" \
             --cacert ~/.elasticsearch/root.crt \
             --header 'Content-Type: application/json' \
             --data '{
               "type": "s3",
               "settings": {
                 "bucket": "<имя бакета>",
                 "endpoint": "{{ s3-storage-host }}"
               }
             }'
        ```

    {% endlist %}

    Подробнее о подключении репозитория см. в [документации плагина]({{ links.es.docs }}/elasticsearch/plugins/7.11/repository-s3.html).

    {% include [mes-objstorage-snapshot](../../_includes/mdb/mes/objstorage-snapshot.md) %}

1. Запустите создание снапшота в репозитории, созданном на предыдущем шаге. Можно создать снапшот всего кластера или части данных. Подробнее см. в [документации {{ ES }}]({{ links.es.docs }}/elasticsearch/reference/current/snapshots-take-snapshot.html).

    Пример создания снапшота с именем `snapshot_1` для всего кластера:

    {% list tabs %}

    - Сторонний кластер {{ ES }}

        ```bash
        curl --request PUT \
             "https://<IP адрес или FQDN хоста с ролью DATA в кластере-источнике>:{{ port-mes }}/_snapshot/<имя репозитория>/snapshot_1?wait_for_completion=false&pretty"
        ```

    - {{ mes-name }}

        ```bash
        curl --request PUT \
             "https://admin:<пароль пользователя admin>@<IP адрес или FQDN хоста с ролью DATA в кластере-источнике>:{{ port-mes }}/_snapshot/<имя репозитория>/snapshot_1?wait_for_completion=false&pretty" \
             --cacert ~/.elasticsearch/root.crt
        ```

    {% endlist %}

    Процесс создания снапшота может занять длительное время. Отслеживайте ход выполнения операции [с помощью инструментов {{ ES }}]({{ links.es.docs }}/elasticsearch/reference/current/snapshots-take-snapshot.html#monitor-snapshot), например:

    {% list tabs %}

    - Сторонний кластер {{ ES }}

        ```bash
        curl --request GET \
             "https://<IP адрес или FQDN хоста с ролью DATA в кластере-источнике>:{{ port-mes }}/_snapshot/<имя репозитория>/snapshot_1/_status?pretty"
        ```

    - {{ mes-name }}

        ```bash
        curl --request GET \
             "https://admin:<пароль пользователя admin>@<IP адрес или FQDN хоста с ролью DATA в кластере-источнике>:{{ port-mes }}/_snapshot/<имя репозитория>/snapshot_1/_status?pretty" \
             --cacert ~/.elasticsearch/root.crt
        ```

    {% endlist %}

### Восстановите снапшот в кластере-приемнике {#restore-snapshot}

1. [Настройте доступ к бакету со снапшотами](../../managed-opensearch/operations/s3-access.md#configure-acl) для кластера-приемника. Используйте [созданный ранее](#before-you-begin) сервисный аккаунт.

1. [Подключите к кластеру-приемнику бакет {{ objstorage-name }}](../../managed-opensearch/operations/s3-access.md#register-snapshot-repository) в качестве хранилища снапшотов в режиме только для чтения:

    ```bash
    curl --request PUT \
         "https://admin:<пароль пользователя admin>@<идентификатор хоста OpenSearch с ролью DATA>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<имя репозитория>" \
         --cacert ~/.opensearch/root.crt \
         --header 'Content-Type: application/json' \
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
         "https://admin:<пароль пользователя admin>@<идентификатор хоста OpenSearch с ролью DATA>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<имя репозитория>/snapshot_1/_restore?wait_for_completion=false&pretty" \
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

Убедитесь, что все нужные индексы перенесены в кластер-приемник {{ mos-name }}, а количество документов в них такое же как и в кластере-источнике:

{% list tabs %}

- Bash

  Выполните команду:

  ```bash
  curl \
      --user <имя пользователя в кластере-приемнике>:<пароль пользователя в кластере-приемнике> \
      --cacert ~/.opensearch/root.crt \
      --request GET 'https://<идентификатор хоста OpenSearch с ролью DATA>.{{ dns-zone }}:{{ port-mos }}/_cat/indices?v'
  ```

  В списке должны быть перенесенные индексы из {{ ES }} с количеством документов в столбце `docs.count`.

- {{ OS }} Dashboards

  1. Подключитесь к кластеру-приемнику с помощью [{{ OS }} Dashboards](../../managed-opensearch/operations/connect.md#dashboards).
  1. Выберите общий тенант `Global`.
  1. Откройте панель управления, нажав на значок ![os-dashboards-sandwich](../../_assets/os-dashboards-sandwich.svg).
  1. В разделе **OpenSearch Plugins** выберите **Index Management**.
  1. Перейдите в раздел **Indices**.

  В списке должны быть перенесенные индексы из {{ ES }} с количеством документов в столбце **Total documents**.

{% endlist %}

1. При необходимости [отключите репозиторий снапшотов]({{ links.es.docs }}/elasticsearch/reference/current/delete-snapshot-repo-api.html) на стороне кластера-источника и кластера-приемника.

### Удалите созданные ресурсы {#clear-out-snapshot}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, во избежание списания средств за них:

* [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md).
* [Удалите снапшоты](../../storage/operations/objects/delete.md) из бакета и затем удалите [бакет целиком](../../storage/operations/buckets/delete.md).
* [Удалите кластер {{ mos-name }}](../../managed-opensearch/operations/cluster-delete.md).

## Миграция с помощью переиндексации {#reindex}

{% else %}

Перенести данные из кластера-источника {{ ES }} в кластер-приемник {{ mos-full-name }} можно с помощью удаленной [переиндексации]({{ os.docs }}/opensearch/reindex-data/) (reindex data). С ее помощью можно перенести существующие индексы, псевдонимы (aliases) или потоки данных. Этот способ подходит для всех кластеров {{ ES }} версии 7.

{% endif %}

Чтобы мигрировать данные из кластера-источника {{ ES }} в кластер-приемник {{ mos-name }} с помощью переиндексации:

1. [Настройте кластер-приемник](#configure-target-reindex).
1. [Запустите переиндексацию](#start-reindex).
1. [Проверьте результат](#check-result-reindex).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out-reindex).

{% if audience != "internal" %}

### Перед началом работы {#before-you-begin-reindex}

{% else %}

## Перед началом работы {#before-you-begin-reindex}

{% endif %}

1. [Создайте кластер-приемник {{ mos-name }}](../../managed-opensearch/operations/cluster-create.md#create-cluster) нужной вам конфигурации{% if audience != "internal" %} с публичным доступом к группе хостов с ролью `DATA`{% endif %}.

1. Установите SSL-сертификат:

    {% list tabs %}

    - Linux (Bash)

        {% include [install-certificate](../../_includes/mdb/mos/install-certificate.md) %}

        Сертификат будет сохранен в каталоге `$HOME/.opensearch/root.crt`.

    - Windows (PowerShell)

        ```powershell
        mkdir $HOME\.opensearch; curl -o $HOME\.opensearch\root.crt {{ crt-web-path }}
        ```

        Сертификат будет сохранен в каталоге `$HOME\.opensearch\root.crt`.

    {% endlist %}

1. Убедитесь, что вы можете [подключиться к кластеру-приемнику](../../managed-opensearch/operations/connect.md) {{ mos-name }} с помощью {{ OS }} API и Dashboards.

{% if audience != "internal" %}

1. Убедитесь, что у кластера-источника {{ ES }} есть доступ в интернет.

{% endif %}

1. Создайте в кластере-источнике [пользователя]({{ links.es.docs }}/kibana/current/xpack-security.html#_users_2) с [ролями]({{ links.es.docs }}/kibana/current/xpack-security.html#_roles_2) `monitoring_user` и `viewer`.

{% if audience != "internal" %}

### Настройте кластер-приемник {#configure-target-reindex}

{% else %}

## Настройте кластер-приемник {#configure-target-reindex}

{% endif %}

1. [Создайте роль]({{ os.docs }}/security-plugin/access-control/users-roles/#create-roles) с привилегиями `create_index` и `write` для всех индексов (`*`).

1. [Создайте пользователя](../../managed-opensearch/operations/cluster-users.md) и назначьте ему эту роль.

    {% note tip %}

    В кластерах {{ mos-name }} вы можете использовать переиндексацию от имени пользователя `admin`, имеющего роль `superuser`, но безопаснее для каждой задачи создавать отдельных пользователей с ограниченными привилегиями. Подробнее см. в разделе [{#T}](../../managed-opensearch/operations/cluster-users.md).

    {% endnote %}

{% if audience != "internal" %}

### Запустите переиндексацию {#start-reindex}

{% else %}

## Запустите переиндексацию {#start-reindex}

{% endif %}

1. [Получите список хостов](../../managed-opensearch/operations/host-groups.md#list-hosts) кластера-приемника.

1. Для запуска переиндексации выполните запрос к хосту с ролью `DATA` в кластере-приемнике:

    ```bash
    curl --user <имя пользователя в кластере-приемнике>:<пароль пользователя в кластере-приемнике> \
         --cacert ~/.opensearch/root.crt \
         --request POST \
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
           --request POST \
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
         "https://<идентификатор хоста OpenSearch с ролью DATA>.{{ dns-zone }}:{{ port-mos }}/_tasks/<идентификатор задачи переиндексации>/_cancel"
    ```

{% if audience != "internal" %}

### Проверьте результат {#check-result-reindex}

{% else %}

## Проверьте результат {#check-result-reindex}

{% endif %}

Убедитесь, что все нужные индексы перенесены в кластер-приемник {{ mos-name }}, а количество документов в них такое же как и в кластере-источнике:

{% list tabs %}

- Bash

  Выполните команду:

  ```bash
  curl \
      --user <имя пользователя в кластере-приемнике>:<пароль пользователя в кластере-приемнике> \
      --cacert ~/.opensearch/root.crt \
      --request GET 'https://<идентификатор хоста OpenSearch с ролью DATA>.{{ dns-zone }}:{{ port-mos }}/_cat/indices?v'
  ```

  В списке должны быть перенесенные индексы из {{ ES }} с количеством документов в столбце `docs.count`.

- {{ OS }} Dashboards

  1. Подключитесь к кластеру-приемнику с помощью [{{ OS }} Dashboards](../../managed-opensearch/operations/connect.md#dashboards).
  1. Выберите общий тенант `Global`.
  1. Откройте панель управления, нажав на значок ![os-dashboards-sandwich](../../_assets/os-dashboards-sandwich.svg).
  1. В разделе **OpenSearch Plugins** выберите **Index Management**.
  1. Перейдите в раздел **Indices**.

  В списке должны быть перенесенные индексы из {{ ES }} с количеством документов в столбце **Total documents**.

{% endlist %}

{% if audience != "internal" %}

### Удалите созданные ресурсы {#clear-out-reindex}

{% else %}

## Удалите созданные ресурсы {#clear-out-reindex}

{% endif %}

{% if audience != "internal" %}

Удалите ресурсы, которые вы больше не будете использовать, во избежание списания средств за них:

* [Удалите кластер {{ mos-name }}](../../managed-opensearch/operations/cluster-delete.md).
* Если вы зарезервировали для доступа к кластеру публичные статические IP-адреса, освободите и [удалите их](../../vpc/operations/address-delete.md).

{% else %}

Если созданный кластер {{ mos-name }} вам больше не нужен, [удалите его](../../managed-opensearch/operations/cluster-delete.md).

{% endif %}
