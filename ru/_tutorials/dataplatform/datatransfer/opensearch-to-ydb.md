# Миграция данных из {{ mos-full-name }} в {{ ydb-full-name }} с помощью {{ data-transfer-full-name }}


С помощью сервиса {{ data-transfer-name }} вы можете перенести данные из кластера {{ mos-name }} в базу данных {{ ydb-name }}.

Чтобы перенести данные:

1. [Подготовьте тестовые данные](#prepare-data).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер {{ mos-name }}: использование вычислительных ресурсов, выделенных хостам (в том числе хостам с ролью `MANAGER`), и дискового пространства (см. [тарифы {{ mos-name }}](../../../managed-opensearch/pricing.md)).

* Плата за каждый трансфер: использование вычислительных ресурсов и количество переданных строк данных (см. [тарифы {{ data-transfer-name }}](../../../data-transfer/pricing.md)).

* Плата за использование публичных IP-адресов для хостов кластера (см. [тарифы {{ vpc-name }}](../../../vpc/pricing.md)).

* Плата за базу данных {{ ydb-name }}. Тарификация зависит от режима использования:

	* Для бессерверного режима — оплачиваются операции с данными и объем хранимых данных.
	* Для режима с выделенными инстансами — оплачивается использование вычислительных ресурсов, выделенных БД, и дискового пространства.
    
    [Подробнее о тарифах {{ ydb-name }}](../../../ydb/pricing/index.md).


## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

* Вручную {#manual}

    1. [Создайте кластер {{ mos-name }}](../../../managed-opensearch/operations/cluster-create.md) любой подходящей конфигурации с хостами в публичном доступе.

    1. Если вы используете группы безопасности в кластере, убедитесь, что они настроены правильно и допускают подключение к кластеру [{{ mos-name }}](../../../managed-opensearch/operations/connect#configuring-security-groups).

    1. [Получите SSL-сертификат](../../../managed-opensearch/operations/connect.md#ssl-certificate) для подключения к кластеру {{ mos-name }}.

    1. [Создайте базу данных {{ ydb-name }}](../../../ydb/operations/manage-databases.md) `ydb1` любой подходящей конфигурации.

    
    1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md#create-sa) с именем `ydb-account` и ролью `ydb.editor`. Трансфер будет использовать его для доступа к базе данных.


* С помощью {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации [opensearch-to-ydb.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-opensearch-to-ydb/blob/main/opensearch-to-ydb.tf).

        В этом файле описаны:

        * [сеть](../../../vpc/concepts/network.md#network);
        * [подсеть](../../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к кластеру {{ mos-name }} из интернета;
        * база данных {{ ydb-name }};
        * кластер-приемник {{ mos-name }};
        * эндпоинт для приемника;
        * трансфер.

    1. Укажите в файле `opensearch-to-ydb.tf` параметры:

        * `mos_version` — версия {{ OS }}.
        * `mos_password` — пароль пользователя-владельца базы данных {{ OS }}.
        * `profile_name` — имя вашего профиля в CLI. 

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Подготовьте тестовые данные {#prepare-data}

1. [Подключитесь к кластеру-источнику {{ mos-name }}](../../../managed-opensearch/operations/connect.md).

1. Создайте тестовый индекс `people` и задайте его схему:

    ```bash
    curl --user admin:<пароль> \
         --cacert ~/.opensearch/root.crt \
         --header 'Content-Type: application/json' \
         --request PUT 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:{{ port-mos }}/people' && \
    curl --user admin:<пароль> \
         --cacert ~/.opensearch/root.crt \
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
    curl --user admin:<пароль> \
         --cacert ~/.opensearch/root.crt \
         --header 'Content-Type: application/json' \
         --request POST 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:{{ port-mos }}/people/_doc/?pretty' \
         --data'
         {
               "name" : "Alice",
               "age" : "30"
         }
         ' && \
    curl --user admin:<пароль> \
         --cacert ~/.opensearch/root.crt \
         --header 'Content-Type: application/json' \
         --request POST 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:{{ port-mos }}/people/_doc/?pretty' \
         --data'
         {
               "name" : "Robert",
               "age" : "32"
         }
         '
    ```

1. (Опционально) Проверьте данные в тестовом индексе:

    ```bash
    curl --user admin:<пароль> \
         --cacert ~/.opensearch/root.crt \
         --header 'Content-Type: application/json' \
         --request GET 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:{{ port-mos }}/people/_search?pretty'
    ```

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт-источник](../../../data-transfer/operations/endpoint/source/opensearch.md#endpoint-settings) типа `{{ OS }}` со следующими настройками:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnectionType.mdb_cluster_id.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnectionType.mdb_cluster_id.title }}** — выберите кластер {{ mos-name }} из списка.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.user.title }}** — `admin`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.password.title }}** — `<пароль_пользователя>`.

1. Создайте эндпоинт-приемник и трансфер:

    {% list tabs group=instructions %}

    * Вручную {#manual}

        1. [Создайте эндпоинт-приемник](../../../data-transfer/operations/endpoint/target/yandex-database.md#endpoint-settings) типа `{{ ydb-short-name }}` со следующими настройками:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.database.title }}** — выберите базу данных `ydb1` из списка.

            
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.service_account_id.title }}** — выберите сервисный аккаунт `ydb-account` из списка.


        1. [Создайте трансфер](../../../data-transfer/operations/transfer.md#create) типа **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}_**, использующий созданные эндпоинты.

        1. [Активируйте трансфер](../../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.

    * С помощью {{ TF }} {#tf}

        1. Укажите в файле `opensearch-to-ydb.tf` значения параметров:

            * `source_endpoint_id` — идентификатор эндпоинта для источника.
            * `transfer_enabled` — значение `1` для создания эндпоинта-приемника и трансфера.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        1. Трансфер активируется автоматически. Дождитесь его перехода в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.

    {% endlist %}

## Проверьте работу трансфера {#verify-transfer}

1. [Подключитесь к базе данных {{ ydb-name }}](../../../ydb/operations/connection.md).

1. Выполните запрос:

    ```sql
    SELECT * FROM people;
    ```

    {% cut "Пример ответа" %}

    ```text
    # |          _id           | age | name
    --+------------------------+-----+---------
    0 | "5wn5BJEBRVOYnL8d13sP" | 30  | "Alice"
    1 | "6An5BJEBRVOYnL8d13uy" | 32  | "Robert"
    ```

    {% endcut %}

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. Удалите ресурсы в зависимости от способа их создания:

    {% list tabs group=instructions %}

    * Вручную {#manual}

        1. [Удалите трансфер](../../../data-transfer/operations/transfer.md#delete).
        1. [Удалите эндпоинт для приемника](../../../data-transfer/operations/endpoint/index.md#delete).
        1. [Удалите кластер {{ mos-name }}](../../../managed-opensearch/operations/cluster-delete.md).
        1. [Удалите базу данных {{ ydb-name }}](../../../ydb/operations/manage-databases.md#delete-db).

        
        1. [Удалите сервисный аккаунт](../../../iam/operations/sa/delete.md).


    * С помощью {{ TF }} {#tf}

        {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}

1. [Удалите эндпоинт для источника](../../../data-transfer/operations/endpoint/index.md#delete).
