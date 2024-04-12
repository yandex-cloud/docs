# Миграция данных из {{ ES }} в {{ mos-full-name }}


{% note info %}

Сервис {{ mes-full-name }} недоступен с 11 апреля 2024 года.

{% endnote %}


Перенести данные из кластера-источника {{ ES }} в кластер-приемник {{ mos-full-name }} можно с помощью трех механизмов:

* [Сервиса {{ data-transfer-full-name }}](../../data-transfer/index.yaml).

    Этот способ подходит для любых кластеров {{ ES }}.

    Пример такого переноса см. в практическом руководстве [Миграция данных в {{ OS }} с помощью {{ data-transfer-full-name }}](../../data-transfer/tutorials/mes-to-mos.md).

* [Снапшотов](../../glossary/snapshot.md) (snapshots).

    Этот способ подходит для кластеров {{ ES }} версии не выше 7.11.

    Подробнее о механизме снапшотов см. в [документации {{ OS }}]({{ os.docs }}/opensearch/snapshots/index/).

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

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте бакет {{ objstorage-name }}](../../storage/operations/buckets/create.md) с ограниченным доступом. Этот бакет будет использоваться в качестве репозитория снапшотов.
    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) и [назначьте ему роль](../../iam/operations/sa/assign-role-for-sa.md) `storage.editor`. Сервисный аккаунт необходим для доступа к бакету из кластера-источника и кластера-приемника.

        1. Если вы переносите данные из стороннего кластера {{ ES }}, [создайте статический ключ доступа](../../iam/operations/sa/create-access-key.md) для этого сервисного аккаунта.


        {% note warning %}

        Сохраните **идентификатор ключа** и **секретный ключ**. Они понадобятся позднее.

        {% endnote %}

    1. [Создайте кластер-приемник {{ mos-name }}](../../managed-opensearch/operations/cluster-create.md#create-cluster) нужной вам конфигурации со следующими настройками:

        * Плагин — `repository-s3`.
        * Публичный доступ к группе хостов с ролью `DATA`.

- С помощью {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации [es-mos-migration-snapshot.tf](https://github.com/yandex-cloud-examples/yc-elasticsearch-migration-to-managed-opensearch/blob/main/es-mos-migration-snapshot.tf). В файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к кластеру {{ mos-name }};
        * сервисный аккаунт для работы с бакетом {{ objstorage-name }};
        * бакет {{ objstorage-name }};
        * кластер-приемник {{ mos-name }}.

    1. Укажите в файле `es-mos-migration-snapshot.tf` переменные:

        * `folder_id` — идентификатор облачного каталога, такой же, как в настройках провайдера.
        * `bucket_name` — имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).
        * `os_admin_password` — пароль администратора {{ OS }}.
        * `os_version` — версия {{ OS }}.

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

       {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

#### Завершите настройку и проверьте доступ к ресурсам {#complete-setup-snapshot}

1. [Настройте ACL](../../storage/operations/buckets/edit-acl.md) для бакета:

    1. В выпадающем списке **{{ ui-key.yacloud.component.acl-dialog.label_select-placeholder }}** укажите созданный ранее сервисный аккаунт.
    1. Задайте разрешения `READ и WRITE` для выбранного сервисного аккаунта.
    1. Нажмите кнопку **{{ ui-key.yacloud.storage.permissions-dialog.button_add }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.storage.permissions-dialog.button_save }}**.

1. Настройте кластер-источник {{ ES }}:

    
    {% include [source-3p](es-mos-migration/source-3p.md) %}


1. [Установите SSL-сертификат](../../managed-opensearch/operations/connect.md#ssl-certificate).

1. Убедитесь, что вы можете [подключиться к кластеру-приемнику](../../managed-opensearch/operations/connect.md) {{ mos-name }} с помощью {{ OS }} API и Dashboards.

### Создайте снапшот на кластере-источнике {#create-snapshot}

1. Подключите бакет в качестве репозитория снапшотов на кластере-источнике:

    
    {% include [connect-bucket-3p](es-mos-migration/connect-bucket-3p.md) %}


    Подробнее о подключении репозитория см. в [документации плагина]({{ links.es.docs }}/elasticsearch/plugins/7.11/repository-s3.html).

    {% include [mes-objstorage-snapshot](../../_includes/mdb/mes/objstorage-snapshot.md) %}

1. Запустите создание снапшота в репозитории, созданном на предыдущем шаге. Можно создать снапшот всего кластера или части данных. Подробнее см. в [документации {{ ES }}]({{ links.es.docs }}/elasticsearch/reference/current/snapshots-take-snapshot.html).

    Пример создания снапшота с именем `snapshot_1` для всего кластера:

    
    {% include [create-snapshot-3p](es-mos-migration/create-snapshot-3p.md) %}


    Процесс создания снапшота может занять длительное время. Отслеживайте ход выполнения операции [с помощью инструментов {{ ES }}]({{ links.es.docs }}/elasticsearch/reference/current/snapshots-take-snapshot.html#monitor-snapshot), например:

    
    {% include [track-snapshot-creation-3p](es-mos-migration/track-snapshot-creation-3p.md) %}


### Восстановите снапшот в кластере-приемнике {#restore-snapshot}

1. [Настройте доступ к бакету со снапшотами](../../managed-opensearch/operations/s3-access.md#configure-acl) для кластера-приемника. Используйте [созданный ранее](#before-you-begin) сервисный аккаунт.

1. [Подключите к кластеру-приемнику бакет {{ objstorage-name }}](../../managed-opensearch/operations/s3-access.md#register-snapshot-repository) в качестве хранилища снапшотов в режиме только для чтения:

    ```bash
    curl --request PUT \
         "https://admin:<пароль_пользователя_admin>@<идентификатор_хоста_{{ OS }}_с_ролью_DATA>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<имя_репозитория>" \
         --cacert ~/.opensearch/root.crt \
         --header 'Content-Type: application/json' \
         --data '{
           "type": "s3",
           "settings": {
             "bucket": "<имя_бакета>",
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
         "https://admin:<пароль_пользователя_admin>@<идентификатор_хоста_{{ OS }}_с_ролью_DATA>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<имя_репозитория>/snapshot_1/_restore" \
         --cacert ~/.opensearch/root.crt
    ```

1. Запустите восстановление из снапшота на кластере-приемнике.

    Пример восстановления снапшота с указанием пользовательских индексов, которые нужно восстановить в кластере-приемнике:

    ```bash
    curl --request POST \
         "https://admin:<пароль_пользователя_admin>@<идентификатор_хоста_{{ OS }}_с_ролью_DATA>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<имя_репозитория>/snapshot_1/_restore?wait_for_completion=false&pretty" \
         --cacert ~/.opensearch/root.crt \
         --header 'Content-Type: application/json' \
         --data '{
           "indices": "<список_индексов>"
         }'
    ```

    Где `indices` — список восстанавливаемых индексов через запятую, например `my_index*, my_index_2.*`.

    Процесс восстановления может занять длительное время. Чтобы проверить статус восстановления, выполните команду:

    ```bash
    curl --request GET \
         "https://admin:<пароль_пользователя_admin>@<идентификатор_хоста_{{ OS }}_с_ролью_DATA>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<имя_репозитория>/snapshot_1/_status?pretty" \
         --cacert ~/.opensearch/root.crt
    ```

### Закончите миграцию {#finish-migration-snapshot}

1. Убедитесь, что все нужные индексы перенесены в кластер-приемник {{ mos-name }}, а количество документов в них такое же, как и в кластере-источнике:

    {% list tabs group=programming_language %}

    - Bash {#bash}

      Выполните команду:

      ```bash
      curl \
          --user <имя_пользователя_в_кластере-приемнике>:<пароль_пользователя_в_кластере-приемнике> \
          --cacert ~/.opensearch/root.crt \
          --request GET 'https://<идентификатор_хоста_{{ OS }}_с_ролью_DATA>.{{ dns-zone }}:{{ port-mos }}/_cat/indices?v'
      ```

      В списке должны быть перенесенные индексы из {{ ES }} с количеством документов в столбце `docs.count`.

    - {{ OS }} Dashboards {#opensearch}
    
      1. [Подключитесь](../../managed-opensearch/operations/connect.md#dashboards) к кластеру-приемнику с помощью {{ OS }} Dashboards.
      1. Выберите общий тенант `Global`.
      1. Откройте панель управления, нажав на значок ![os-dashboards-sandwich](../../_assets/console-icons/bars.svg).
      1. В разделе **{{ OS }} Plugins** выберите **Index Management**.
      1. Перейдите в раздел **Indices**.

      В списке должны быть перенесенные индексы из {{ ES }} с количеством документов в столбце **Total documents**.

    {% endlist %}

1. При необходимости [отключите репозиторий снапшотов]({{ links.es.docs }}/elasticsearch/reference/current/delete-snapshot-repo-api.html) на стороне кластера-источника и кластера-приемника.

### Удалите созданные ресурсы {#clear-out-snapshot}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

    * [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md).
    * [Удалите снапшоты](../../storage/operations/objects/delete.md) из бакета и затем удалите [бакет целиком](../../storage/operations/buckets/delete.md).
    * [Удалите кластер {{ mos-name }}](../../managed-opensearch/operations/cluster-delete.md).

- С помощью {{ TF }} {#tf}

    1. Удалите все объекты из бакета.
    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл `es-mos-migration-snapshot.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `es-mos-migration-snapshot.tf`, будут удалены.

{% endlist %}

## Миграция с помощью переиндексации {#reindex}


Чтобы мигрировать данные из кластера-источника {{ ES }} в кластер-приемник {{ mos-name }} с помощью переиндексации:

1. [Настройте кластер-приемник](#configure-target-reindex).
1. [Запустите переиндексацию](#start-reindex).
1. [Проверьте результат](#check-result-reindex).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out-reindex).


### Перед началом работы {#before-you-begin-reindex}


1. Подготовьте инфраструктуру:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        [Создайте кластер-приемник {{ mos-name }}](../../managed-opensearch/operations/cluster-create.md#create-cluster) нужной вам конфигурации с публичным доступом к группе хостов с ролью `DATA`.

    - С помощью {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

        1. Скачайте в ту же рабочую директорию файл конфигурации [es-mos-migration-reindex.tf](https://github.com/yandex-cloud-examples/yc-elasticsearch-migration-to-managed-opensearch/blob/main/es-mos-migration-reindex.tf). В файле описаны:

            * [сеть](../../vpc/concepts/network.md#network);
            * [подсеть](../../vpc/concepts/network.md#subnet);
            * [группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к кластеру {{ mos-name }};
            * кластер-приемник {{ mos-name }}.

        1. Укажите в файле `es-mos-migration-reindex.tf` переменные:

            * `os_admin_password` — пароль администратора {{ OS }}.
            * `os_version` — версия {{ OS }}.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

           {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

           {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

    {% endlist %}

1. Установите SSL-сертификат:

    {% include [install-certificate](../../_includes/mdb/mos/install-certificate.md) %}

1. Убедитесь, что вы можете [подключиться к кластеру-приемнику](../../managed-opensearch/operations/connect.md) {{ mos-name }} с помощью {{ OS }} API и Dashboards.


1. Убедитесь, что у кластера-источника {{ ES }} есть доступ в интернет.


1. Создайте в кластере-источнике [пользователя]({{ links.es.docs }}/kibana/current/xpack-security.html#_users_2) с [ролями]({{ links.es.docs }}/kibana/current/xpack-security.html#_roles_2) `monitoring_user` и `viewer`.


### Настройте кластер-приемник {#configure-target-reindex}


1. [Создайте роль]({{ os.docs }}/security-plugin/access-control/users-roles/#create-roles) с привилегиями `create_index` и `write` для всех индексов (`*`).

1. [Создайте пользователя](../../managed-opensearch/operations/cluster-users.md) и назначьте ему эту роль.

    {% note tip %}

    В кластерах {{ mos-name }} вы можете использовать переиндексацию от имени пользователя `admin`, имеющего роль `superuser`, но безопаснее для каждой задачи создавать отдельных пользователей с ограниченными привилегиями. Подробнее см. в разделе [{#T}](../../managed-opensearch/operations/cluster-users.md).

    {% endnote %}


### Запустите переиндексацию {#start-reindex}


1. [Получите список хостов](../../managed-opensearch/operations/host-groups.md#list-hosts) кластера-приемника.

1. Для запуска переиндексации выполните запрос к хосту с ролью `DATA` в кластере-приемнике:

    ```bash
    curl --user <имя_пользователя_в_кластере-приемнике>:<пароль_пользователя_в_кластере-приемнике> \
         --cacert ~/.opensearch/root.crt \
         --request POST \
         "https://<идентификатор_хоста_{{ OS }}_с_ролью_DATA>.{{ dns-zone }}:{{ port-mos }}/_reindex?wait_for_completion=false&pretty" \
         --header 'Content-Type: application/json' \
         --data '{
           "source": {
             "remote": {
               "host": "https://<IP-адрес_или_FQDN_хоста_с_ролью_DATA_в_кластере-источнике>:{{ port-mes }}",
               "username": "<имя_пользователя_в_кластере-источнике>",
               "password": "<пароль_пользователя_в_кластере-источнике>"
             },
             "index": "<имя_индекса_псевдонима_или_потока_данных_в_кластере-источнике>"
           },
           "dest": {
             "index": "<имя_индекса_псевдонима_или_потока_данных_в_кластере-приемнике>"
           }
         }'
    ```

    Результат:

    ```text
    {
      "task" : "<идентификатор_задачи_переиндексации>"
    }
    ```

    Чтобы перенести несколько индексов, используйте цикл `for`:

    ```bash
    for index in <имена_индексов_псевдонимов_или_потоков_данных_разделенные_пробелами>; do
      curl --user <имя_пользователя_в_кластере-приемнике>:<пароль_пользователя_в_кластере-приемнике> \
           --cacert ~/.opensearch/root.crt \
           --request POST \
           "https://<идентификатор_хоста_{{ OS }}_с_ролью_DATA>.{{ dns-zone }}:{{ port-mos }}/_reindex?wait_for_completion=false&pretty" \
           --header 'Content-Type: application/json' \
           --data '{
             "source": {
               "remote": {
                 "host": "https://<IP-адрес_или_FQDN_хоста_с_ролью_DATA_в_кластере-источнике>:{{ port-mes }}",
                 "username": "<имя_пользователя_в_кластере-источнике>",
                 "password": "<пароль_пользователя_в_кластере-источнике>"
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
      "task" : "<идентификатор_задачи_переиндексации_1>"
    }
    {
      "task" : "<идентификатор_задачи_переиндексации_2>"
    }
    ...
    ```

    Подробнее о параметрах переиндексации см. в [документации {{ OS }}]({{ os.docs }}/opensearch/reindex-data/#source-index-options).

    Процесс переиндексации может занять длительное время. Чтобы проверить статус операции, выполните команду:

    ```bash
    curl --user <имя_пользователя_в_кластере-приемнике>:<пароль_пользователя_в_кластере-приемнике> \
         --cacert ~/.opensearch/root.crt \
         --request GET \
         "https://<идентификатор_хоста_{{ OS }}_с_ролью_DATA>.{{ dns-zone }}:{{ port-mos }}/_tasks/<идентификатор_задачи_переиндексации>"
    ```

1. Чтобы отменить операцию переиндексации, выполните команду:

    ```bash
    curl --user <имя_пользователя_в_кластере-приемнике>:<пароль_пользователя_в_кластере-приемнике> \
         --cacert ~/.opensearch/root.crt \
         --request POST \
         "https://<идентификатор_хоста_{{ OS }}_с_ролью_DATA>.{{ dns-zone }}:{{ port-mos }}/_tasks/<идентификатор_задачи_переиндексации>/_cancel"
    ```


### Проверьте результат {#check-result-reindex}


Убедитесь, что все нужные индексы перенесены в кластер-приемник {{ mos-name }}, а количество документов в них такое же как и в кластере-источнике:

{% list tabs group=programming_language %}

- Bash {#bash}

  Выполните команду:

  ```bash
  curl \
      --user <имя_пользователя_в_кластере-приемнике>:<пароль_пользователя_в_кластере-приемнике> \
      --cacert ~/.opensearch/root.crt \
      --request GET 'https://<идентификатор_хоста_{{ OS }}_с_ролью_DATA>.{{ dns-zone }}:{{ port-mos }}/_cat/indices?v'
  ```

  В списке должны быть перенесенные индексы из {{ ES }} с количеством документов в столбце `docs.count`.

- {{ OS }} Dashboards {#opensearch}

  1. [Подключитесь](../../managed-opensearch/operations/connect.md#dashboards) к кластеру-приемнику с помощью {{ OS }} Dashboards.
  1. Выберите общий тенант `Global`.
  1. Откройте панель управления, нажав на значок ![os-dashboards-sandwich](../../_assets/console-icons/bars.svg).
  1. В разделе **{{ OS }} Plugins** выберите **Index Management**.
  1. Перейдите в раздел **Indices**.

  В списке должны быть перенесенные индексы из {{ ES }} с количеством документов в столбце **Total documents**.

{% endlist %}


### Удалите созданные ресурсы {#clear-out-reindex}



Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

* Удалите ресурсы в зависимости от способа их создания:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        [Удалите кластер {{ mos-name }}](../../managed-opensearch/operations/cluster-delete.md).

    - С помощью {{ TF }} {#tf}

        1. В терминале перейдите в директорию с планом инфраструктуры.
        1. Удалите конфигурационный файл `es-mos-migration-reindex.tf`.
        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Подтвердите изменение ресурсов.

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            Все ресурсы, которые были описаны в конфигурационном файле `es-mos-migration-reindex.tf`, будут удалены.

    {% endlist %}

* Если вы зарезервировали для доступа к кластеру публичные статические IP-адреса, освободите и [удалите их](../../vpc/operations/address-delete.md).

