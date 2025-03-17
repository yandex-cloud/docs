# Миграция данных из {{ ES }} в {{ mos-full-name }} с помощью {{ data-transfer-full-name }}


Вы можете настроить перенос данных из индексов {{ ES }} в индексы {{ mos-name }} с помощью сервиса {{ data-transfer-name }}. Для этого:

1. [Настройте кластер-источник](#configure-source).
1. [Подготовьте тестовые данные](#prepare-data).
1. [Настройте кластер-приемник](#configure-target).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работу трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входит:

* Плата за кластер {{ mos-name }}: использование вычислительных ресурсов, выделенных хостам (в том числе хостам с ролью `MANAGER`), и дискового пространства (см. [тарифы {{ mos-name }}](../../../managed-opensearch/pricing.md)).
* Плата за использование публичных IP-адресов для хостов кластера (см. [тарифы {{ vpc-name }}](../../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}

1. Подготовьте инфраструктуру:

    
    1. [Создайте пользовательскую инсталляцию {{ ES }}]({{ links.es.docs }}/elasticsearch/reference/current/getting-started.html).

    1. [Обеспечьте доступ к кластеру из {{ yandex-cloud }}](../../../data-transfer/concepts/network.md#source-external).

    1. [Создайте кластер-приемник {{ mos-name }}](../../../managed-opensearch/operations/cluster-create.md) любой подходящей конфигурации с хостами в публичном доступе.


1. Установите утилиты:

    * [curl](https://curl.se/) — для запросов к кластерам.

        ```bash
        sudo apt update && sudo apt install --yes curl
        ```

    * [jq](https://stedolan.github.io/jq/) — для потоковой обработки JSON-файлов.

        ```bash
        sudo apt update && sudo apt install --yes jq
        ```

## Настройте кластер-источник {#configure-source}


1. (Опционально) Создайте пользователя, от имени которого будет выполняться трансфер.

    Вы можете поставлять данные из кластера {{ ES }} от имени пользователя `admin`, имеющего роль `superuser`, но безопаснее для каждой задачи создавать отдельных пользователей с ограниченными привилегиями.

    1. В кластере-источнике [создайте роль]({{ links.es.docs }}/elasticsearch/reference/current/defining-roles.html) с [привилегиями]({{ links.es.docs }}/elasticsearch/reference/current/security-privileges.html#privileges-list-indices) `create_index` и `write` для всех индексов (`*`).

    1. В кластере источнике [создайте пользователя](../../../managed-elasticsearch/operations/cluster-users.md), от имени которого будет выполняться трансфер, и назначьте ему созданную роль.

## Подготовьте тестовые данные {#prepare-data}

1. В кластере-источнике создайте тестовый индекс `people` и задайте его схему:

    ```bash
    curl --user <имя_пользователя_в_кластере-источнике>:<пароль_пользователя_в_кластере-источнике> \
         --cacert ~/.elasticsearch/root.crt \
         --header 'Content-Type: application/json' \
         --request PUT 'https://<адрес_хоста_{{ ES }}_с_ролью_Data_Node>:{{ port-mes }}/people' && \
    curl --user <имя_пользователя_в_кластере-источнике>:<пароль_пользователя_в_кластере-источнике> \
         --cacert ~/.elasticsearch/root.crt \
         --header 'Content-Type: application/json' \
         --request PUT 'https://<адрес_хоста_{{ ES }}_с_ролью_Data_Node>:{{ port-mes }}/people/_mapping?pretty' \
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
    curl --user <имя_пользователя_в_кластере-источнике>:<пароль_пользователя_в_кластере-источнике> \
         --cacert ~/.elasticsearch/root.crt \
         --header 'Content-Type: application/json' \
         --request POST 'https://<адрес_хоста_{{ ES }}_с_ролью_Data_Node>:{{ port-mes }}/people/_doc/?pretty' \
         --data'
         {
               "name" : "Alice",
               "age" : "30"
         }
         ' && \
    curl --user <имя_пользователя_в_кластере-источнике>:<пароль_пользователя_в_кластере-источнике> \
         --cacert ~/.elasticsearch/root.crt \
         --header 'Content-Type: application/json' \
         --request POST 'https://<адрес_хоста_{{ ES }}_с_ролью_Data_Node>:{{ port-mes }}/people/_doc/?pretty' \
         --data'
         {
               "name" : "Robert",
               "age" : "32"
         }
         '
    ```

1. (Опционально) Проверьте данные в тестовом индексе:

    ```bash
    curl --user <имя_пользователя_в_кластере-приемнике>:<пароль_пользователя_в_кластере-приемнике> \
         --cacert ~/.elasticsearch/root.crt \
         --header 'Content-Type: application/json' \
         --request GET 'https://<адрес_хоста_{{ ES }}_с_ролью_Data_Node>:{{ port-mes }}/people/_search?pretty'
    ```

## Настройте кластер-приемник {#configure-target}

1. [Получите SSL-сертификат](../../../managed-opensearch/operations/connect.md#ssl-certificate) для подключения к кластеру {{ mos-name }}.

1. (Опционально) Создайте пользователя, от имени которого будет выполняться трансфер.

    Вы можете поставлять данные в кластер {{ mos-name }} от имени пользователя `admin`, имеющего роль `superuser`, но безопаснее для каждой задачи создавать отдельных пользователей с ограниченными привилегиями.

    1. [Создайте роль]({{ os.docs }}/security-plugin/access-control/users-roles/#create-roles) с привилегиями `create_index` и `write` для всех индексов (`*`).

    1. [Создайте пользователя](../../../managed-opensearch/operations/cluster-users.md) и назначьте ему эту роль.

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт](../../../data-transfer/operations/endpoint/index.md#create) для [источника {{ ES }}](../../../data-transfer/operations/endpoint/source/elasticsearch.md).

1. [Создайте эндпоинт](../../../data-transfer/operations/endpoint/index.md#create) для [приемника {{ OS }}](../../../data-transfer/operations/endpoint/target/opensearch.md).

1. Создайте трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте трансфер](../../../data-transfer/operations/transfer.md#create) типа **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}_**, использующий созданные эндпоинты.
        1. [Активируйте трансфер](../../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.

    - {{ TF }} {#tf}

        1. Укажите в файле `data-transfer-mes-mos.tf` переменные:

            * `source_endpoint_id` — значение идентификатора эндпоинта для источника;
            * `target_endpoint_id` — значение идентификатора эндпоинта для приемника;
            * `transfer_enabled` — значение `1` для создания трансфера.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        1. [Активируйте трансфер](../../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.

    {% endlist %}

## Проверьте работу трансфера {#verify-transfer}

Проверьте, что индекс `people` кластера {{ mos-name }} содержит отправленные данные:

{% list tabs group=programming_language %}

- Bash {#bash}

    Выполните команду:

    ```bash
    curl --user <имя_пользователя_в_кластере-приемнике>:<пароль_пользователя_в_кластере-приемнике> \
         --cacert ~/.opensearch/root.crt \
         --header 'Content-Type: application/json' \
         --request GET 'https://<адрес_хоста_{{ OS }}_с_ролью_Data_Node>:{{ port-mos }}/people/_search?pretty'
    ```

- {{ OS }} Dashboards {#opensearch}

    1. [Подключитесь](../../../managed-opensearch/operations/connect.md#dashboards) к кластеру-приемнику с помощью {{ OS }} Dashboards.
    1. Выберите общий тенант `Global`.
    1. Откройте панель управления, нажав на значок ![os-dashboards-sandwich](../../../_assets/console-icons/bars.svg).
    1. В разделе **OpenSearch Dashboards** выберите **Discover**.
    1. В поле **CHANGE INDEX PATTERN** выберите индекс `people`.

{% endlist %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите трансфер](../../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинты](../../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.


1. [Удалите кластер {{ mos-name }}](../../../managed-opensearch/operations/cluster-delete.md).
1. [Удалите подсеть](../../../vpc/operations/subnet-delete.md) и [сеть](../../../vpc/operations/network-delete.md).

