# Копирование данных из {{ mos-full-name }} в {{ mgp-full-name }} с помощью {{ data-transfer-full-name }}

С помощью сервиса {{ data-transfer-name }} вы можете перенести данные из кластера-источника {{ mos-name }} в кластер-приемник {{ mgp-name }}.

Чтобы перенести данные:

1. [Подготовьте облако к работе](#prepare-cloud).
1. [Подготовьте инфраструктуру](#prepare-infrastructure).
1. [Подготовьте тестовые данные](#prepare-data).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#prepare-cloud}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* Плата за вычислительные ресурсы и объем хранилища кластера {{ mos-name }} (см. [тарифы {{ mos-name }}](../../../managed-opensearch/pricing.md)).
* Плата за вычислительные ресурсы, объем хранилища и резервных копий кластера {{ mgp-name }} (см. [тарифы {{ mgp-name }}](../../../managed-greenplum/pricing/index.md)).


## Подготовьте инфраструктуру {#prepare-infrastructure}

{% list tabs group=instructions %}


- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации [opensearch-to-greenplum.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-opensearch-to-greenplum/blob/main/opensearch-to-greenplum.tf).

        В этом файле описаны:

        * [сеть](../../../vpc/concepts/network.md#network);
        * [подсеть](../../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к кластерам {{ mos-name }} и {{ mgp-name }};
        * кластер-источник {{ mos-name }} с пользователем `admin`;
        * кластер-приемник {{ mgp-name }};
        * трансфер.

    1. Укажите в файле `opensearch-to-greenplum.tf` значения параметров:

        * `mos_cluster_name` — имя кластера {{ mos-name }};
        * `source_admin_password` — пароль пользователя `admin` в кластере {{ mos-name }};
        * `mgp_cluster_name` — имя кластера {{ mgp-name }};
        * `mgp_username` — имя пользователя в кластере {{ mgp-name }};
        * `mgp_user_password` — пароль пользователя в кластере {{ mgp-name }};
        * `transfer_name` — имя трансфера {{ data-transfer-name }};
        * `profile_name` — имя вашего профиля в YC CLI.

           {% include [cli-install](../../../_includes/cli-install.md) %}             

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

1. В кластере-источнике создайте тестовый индекс `people` и задайте его схему:

    ```bash
    curl --cacert ~/.opensearch/root.crt \
         --user <имя_пользователя_в_кластере-источнике>:<пароль_пользователя_в_кластере-источнике> \
         --header 'Content-Type: application/json' \
         --request PUT 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:{{ port-mos }}/people' && \
    curl --cacert ~/.opensearch/root.crt \
         --user <имя_пользователя_в_кластере-источнике>:<пароль_пользователя_в_кластере-источнике> \
         --header 'Content-Type: application/json' \
         --request PUT 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:{{ port-mos }}/people/_mapping?pretty' -d'
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
         --request POST 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:{{ port-mos }}/people/_doc/?pretty' -d'
         {
               "name": "Alice",
               "age": "30"
         }
         ' && \
    curl --cacert ~/.opensearch/root.crt \
         --user <имя_пользователя_в_кластере-источнике>:<пароль_пользователя_в_кластере-источнике> \
         --header 'Content-Type: application/json' \
         --request POST 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:{{ port-mos }}/people/_doc/?pretty' -d'
         {
               "name": "Robert",
               "age": "32"
         }
         '
    ```

1. Проверьте, что данные сохранились в тестовом индексе:

    ```bash
    curl --cacert ~/.opensearch/root.crt \
         --user <имя_пользователя_в_кластере-приемнике>:<пароль_пользователя_в_кластере-приемнике> \
         --header 'Content-Type: application/json' \
         --request GET 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:{{ port-mos }}/people/_search?pretty'
    ```
## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт-источник](../../../data-transfer/operations/endpoint/index.md#create) для [созданного ранее](#before-you-begin) кластера {{ mos-name }} с настройками:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `OpenSearch`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchSource.connection.title }}**:
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnectionType.mdb_cluster_id.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnectionType.mdb_cluster_id.title }}** — выберите кластер {{ mos-name }} из списка.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.user.title }}** — `admin`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.password.title }}** — пароль пользователя `admin`.

1. [Создайте эндпоинт-приемник](../../../data-transfer/operations/endpoint/index.md#create) для [созданного ранее](#before-you-begin) кластера {{ mgp-name }} с настройками:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `Greenplum`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumTarget.title }}**:
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.connection_type.title }}** — выберите `{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.mdb_cluster_id.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.mdb_cluster_id.title }}** — выберите кластер {{ mgp-name }} из списка.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.database.title }}** — `postgres`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.user.title }}** — введите имя пользователя в кластере {{ mgp-name }}.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.password.title }}** — введите пароль пользователя в кластере {{ mgp-name }}.

1. Создайте трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте трансфер](../../../data-transfer/operations/transfer.md#create) типа **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}**, использующий созданные эндпоинты.
        1. [Активируйте](../../../data-transfer/operations/transfer.md#activate) трансфер.

    - {{ TF }} {#tf}

        1. Укажите в файле `opensearch-to-greenplum.tf` значения параметров:

            * `source_endpoint_id` — идентификатор эндпоинта-источника;
            * `target_endpoint_id` — идентификатор эндпоинта-приемника;
            * `transfer_enabled` — `1` для создания трансфера.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

            Трансфер активируется автоматически после создания.

    {% endlist %}

## Проверьте работоспособность трансфера {#verify-transfer}

1. Дождитесь перехода трансфера в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.
1. Убедитесь, что в {{ mgp-name }} перенеслись данные из кластера-источника {{ mos-name }}:

   1. [Получите SSL-сертификат](../../../managed-greenplum/operations/connect.md#get-ssl-cert) для подключения к кластеру {{ mgp-name }}.
   1. Установите зависимости:

      ```bash
      sudo apt update && sudo apt install --yes postgresql-client
      ```

   1. Подключитесь к базе данных в кластере {{ mgp-name }}.
   1. Проверьте, что БД содержит таблицу `people` с тестовыми данными:

       ```sql
       SELECT * FROM people;
       ```

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

  - Вручную {#manual}

      1. [Удалите кластер {{ mos-name }}](../../../managed-opensearch/operations/cluster-delete.md).
      1. [Удалите кластер {{ mgp-name }}](../../../managed-greenplum/operations/cluster-delete.md).
      
  - {{ TF }} {#tf}

      {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
