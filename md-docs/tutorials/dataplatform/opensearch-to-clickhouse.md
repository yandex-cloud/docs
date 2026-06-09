# Копирование данных из {{ mos-name }} в {{ mch-name }} с помощью {{ data-transfer-full-name }}

# Копирование данных из {{ mos-name }} в {{ mch-name }} с помощью {{ data-transfer-full-name }}

С помощью сервиса {{ data-transfer-name }} вы можете перенести данные из кластера-источника {{ mos-name }} в {{ mch-name }}.

Чтобы перенести данные:

1. [Подготовьте инфраструктуру](#prepare-infrastructure).
1. [Подготовьте тестовые данные](#prepare-data).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

* Кластер {{ mos-name }}: использование вычислительных ресурсов, объем хранилища и резервных копий (см. [тарифы {{ mos-name }}](../../managed-opensearch/pricing.md)).
* Кластер {{ mch-name }}: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий (см. [тарифы {{ mch-name }}](../../managed-clickhouse/pricing.md)).
* Публичные IP-адреса, если для хостов кластеров включен публичный доступ (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).


## Подготовьте инфраструктуру {#prepare-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

    {% note info %}
    
    Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин {{ yandex-cloud }}, расположенных в той же облачной сети, что и кластер.
    
    {% endnote %}

    1. [Создайте кластер-источник {{ mos-name }}](../../managed-opensearch/operations/cluster-create.md#create-cluster) любой подходящей конфигурации с хостами в публичном доступе.
    1. В той же [зоне доступности](../../overview/concepts/geo-scope.md) [создайте кластер-приемник {{ mch-name }}](../../managed-clickhouse/operations/cluster-create.md#create-cluster) любой подходящей конфигурации с хостами в публичном доступе.

       Если вы планируете подключаться к кластеру через сервис {{ websql-full-name }}, включите в настройках кластера настройку **{{ ui-key.yacloud.mdb.cluster.overview.label_access-websql-service }}**.

    1. [Получите SSL-сертификат](../../managed-opensearch/operations/connect/index.md#ssl-certificate) для подключения к кластеру {{ mos-name }}.

    1. Убедитесь, что группы безопасности кластеров [{{ mos-name }}](../../managed-opensearch/operations/connect/index.md#security-groups) и [{{ mch-name }}](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups) разрешают подключение через интернет.

- {{ TF }} {#tf}

    1. Если у вас еще нет {{ TF }}, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [opensearch-to-clickhouse.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-opensearch-to-clickhouse/blob/main/opensearch-to-clickhouse.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к кластерам {{ mos-name }} и {{ mch-name }};
        * кластер-источник {{ mos-name }} с пользователем `admin`;
        * кластер-приемник {{ mch-name }} с пользователем и базой данных;
        * эндпоинт-приемник;
        * трансфер.

    1. Укажите в файле `opensearch-to-clickhouse.tf` значения параметров:

        * `source_admin_password` — пароль пользователя `admin` в кластере {{ mos-name }};
        * `mos_version` — версия {{ OS }};
        * `mch_db_name` — название базы данных в кластере {{ mch-name }};
        * `mch_username` — имя пользователя в кластере {{ mch-name }};
        * `mch_user_password` — пароль пользователя в кластере {{ mch-name }};
        * `source_endpoint_id` — идентификатор эндпоинта-источника;
        * `profile_name` — имя вашего профиля в CLI.

           Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        1. Выполните команду для просмотра планируемых изменений:
        
           ```bash
           terraform plan
           ```
        
           Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
        
        1. Если вас устраивают планируемые изменения, внесите их:
           1. Выполните команду:
        
              ```bash
              terraform apply
              ```
        
           1. Подтвердите изменение ресурсов.
           1. Дождитесь завершения операции.

        В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

{% endlist %}

## Подготовьте тестовые данные {#prepare-data}

1. В кластере-источнике создайте тестовый индекс `people` и задайте его схему:

    ```bash
    curl --cacert ~/.opensearch/root.crt \
         --user <имя_пользователя_в_кластере-источнике>:<пароль_пользователя_в_кластере-источнике> \
         --header 'Content-Type: application/json' \
         --request PUT 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:{{ port-mos }}/people' && \
    curl --cacert ~/.opensearch/root.crt \
         --user <имя_пользователя_в_кластере-источнике>:<пароль_пользователя_в_кластере-источнике> \
         --header 'Content-Type: application/json' \
         --request PUT 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:{{ port-mos }}/people/_mapping?pretty' \
         --data'
         {
               "properties": {
                  "name": {"type": "text"},
                  "age": {"type": "integer"}
               }
         }
         '
    ```

1. Наполните тестовый индекс данными:

    ```bash
    curl --cacert ~/.opensearch/root.crt \
         --user <имя_пользователя_в_кластере-источнике>:<пароль_пользователя_в_кластере-источнике> \
         --header 'Content-Type: application/json' \
         --request POST 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:{{ port-mos }}/people/_doc/?pretty' \
         --data'
         {
               "name": "Alice",
               "age": "30"
         }
         ' && \
    curl --cacert ~/.opensearch/root.crt \
         --user <имя_пользователя_в_кластере-источнике>:<пароль_пользователя_в_кластере-источнике> \
         --header 'Content-Type: application/json' \
         --request POST 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:{{ port-mos }}/people/_doc/?pretty' \
         --data'
         {
               "name": "Robert",
               "age": "32"
         }
         '
    ```

1. (Опционально) Проверьте данные в тестовом индексе:

    ```bash
    curl --cacert ~/.opensearch/root.crt \
         --user <имя_пользователя_в_кластере-приемнике>:<пароль_пользователя_в_кластере-приемнике> \
         --header 'Content-Type: application/json' \
         --request GET 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:{{ port-mos }}/people/_search?pretty'
    ```

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт-источник](../../data-transfer/operations/endpoint/index.md#create) для [созданного ранее](#before-you-begin) кластера {{ mos-name }} с настройками:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `OpenSearch`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchSource.connection.title }}**:
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnectionType.mdb_cluster_id.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnectionType.mdb_cluster_id.title }}** — выберите кластер {{ mos-name }} из списка.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.user.title }}** — `admin`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.password.title }}** — пароль пользователя `admin`.

1. Создайте эндпоинт-приемник и трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте эндпоинт-приемник](../../data-transfer/operations/endpoint/index.md#create):

            * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `ClickHouse`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.title }}**:
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.connection_type.title }}** — выберите `{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnectionType.managed.title }}`.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseManaged.mdb_cluster_id.title }}** — выберите кластер {{ mch-name }} из списка.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseCredentials.user.title }}** — введите имя пользователя в кластере {{ mch-name }}.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseCredentials.password.title }}** — введите пароль пользователя в кластере {{ mch-name }}.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.database.title }}** — введите название БД в кластере {{ mch-name }}.

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}**, использующий созданные эндпоинты.
        1. [Активируйте](../../data-transfer/operations/transfer.md#activate) трансфер.

    - {{ TF }} {#tf}

        1. Укажите в файле `opensearch-to-clickhouse.tf` значения параметра:

            * `source_endpoint_id` — значение идентификатора эндпоинта для источника;
            * `transfer_enabled` — значение `1` для создания эндпоинта-приемника и трансфера.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            1. Выполните команду для просмотра планируемых изменений:
            
               ```bash
               terraform plan
               ```
            
               Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
            
            1. Если вас устраивают планируемые изменения, внесите их:
               1. Выполните команду:
            
                  ```bash
                  terraform apply
                  ```
            
               1. Подтвердите изменение ресурсов.
               1. Дождитесь завершения операции.

            Трансфер активируется автоматически после создания.

    {% endlist %}

## Проверьте работоспособность трансфера {#verify-transfer}

1. Дождитесь перехода трансфера в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.
1. Убедитесь, что в базу данных {{ mch-name }} перенеслись данные из кластера-источника {{ mos-name }}:

    {% list tabs group=instructions %}

    - {{ websql-full-name }} {#websql}

      1. [Создайте подключение](../../websql/operations/create-connection.md#connect-cluster) к БД в кластере {{ mch-name }}.
      1. Проверьте, что БД содержит таблицу `people` с тестовыми данными. Для этого через созданное подключение [выполните запрос](../../websql/operations/query-executor.md#execute-query) к БД:

         ```sql
         SELECT * FROM people;
         ```

    - CLI {#cli}

      1. [Получите SSL-сертификат](../../managed-clickhouse/operations/connect/index.md#get-ssl-cert) для подключения к кластеру {{ mch-name }}.
      1. Если у вас нет `clickhouse-client`, [установите его](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client).
      1. [Подключитесь к БД](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) в кластере {{ mch-name }}.
      1. Проверьте, что БД содержит таблицу `people` с тестовыми данными:

         ```sql
         SELECT * FROM people;
         ```

    {% endlist %}

## Удалите созданные ресурсы {#clear-out}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. [Удалите эндпоинт](../../data-transfer/operations/endpoint/index.md#delete) для источника.
1. Удалите остальные ресурсы в зависимости от способа их создания:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).
        1. [Удалите эндпоинт](../../data-transfer/operations/endpoint/index.md#delete) для приемника.
        1. [Удалите кластер {{ mos-name }}](../../managed-opensearch/operations/cluster-delete.md).
        1. [Удалите кластер {{ mch-name }}](../../managed-clickhouse/operations/cluster-delete.md).

            В сервисе {{ websql-full-name }} подключение к БД в кластере {{ mch-name }} удалится автоматически.

        1. [Удалите подсеть](../../vpc/operations/subnet-delete.md).
        1. [Удалите сеть](../../vpc/operations/network-delete.md).

    - {{ TF }} {#tf}

        1. В терминале перейдите в директорию с планом инфраструктуры.
        
            {% note warning %}
        
            Убедитесь, что в директории нет {{ TF }}-манифестов с ресурсами, которые вы хотите сохранить. {{ TF }} удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
        
            {% endnote %}
        
        1. Удалите ресурсы:
        
            1. Выполните команду:
        
                ```bash
                terraform destroy
                ```
        
            1. Подтвердите удаление ресурсов и дождитесь завершения операции.
        
            Все ресурсы, которые были описаны в {{ TF }}-манифестах, будут удалены.

    {% endlist %}

_{{ CH }} является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._