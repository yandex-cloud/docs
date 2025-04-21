# Загрузка данных из {{ mos-full-name }} в {{ objstorage-full-name }} с помощью {{ data-transfer-full-name }}

С помощью сервиса {{ data-transfer-name }} вы можете перенести данные из кластера {{ mos-name }} в объектное хранилище {{ objstorage-name }}.

Чтобы перенести данные:

1. [Подготовьте тестовые данные](#prepare-data).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер {{ mos-name }}: использование вычислительных ресурсов, выделенных хостам (в том числе хостам с ролью `MANAGER`), и дискового пространства (см. [тарифы {{ mos-name }}](../../../managed-opensearch/pricing.md)).
* Плата за использование публичных IP-адресов для хостов кластера (см. [тарифы {{ vpc-name }}](../../../vpc/pricing.md)).
* Плата за бакет {{ objstorage-name }}: хранение данных и выполнение операций с ними (см. [тарифы {{ objstorage-name }}](../../../storage/pricing.md)).
* Плата за каждый трансфер: использование вычислительных ресурсов и количество переданных строк данных (см. [тарифы {{ data-transfer-name }}](../../../data-transfer/pricing.md)).


## Перед началом работы {#before-you-begin}


Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте кластер {{ mos-name }}](../../../managed-opensearch/operations/cluster-create.md) любой подходящей конфигурации с хостами в публичном доступе.

    1. Если вы используете группы безопасности в кластере, убедитесь, что они настроены правильно и допускают подключение к кластеру [{{ mos-name }}](../../../managed-opensearch/operations/connect#configuring-security-groups).

    1. [Получите SSL-сертификат](../../../managed-opensearch/operations/connect.md#ssl-certificate) для подключения к кластеру {{ mos-name }}.

    1. [Создайте бакет {{ objstorage-name }}](../../../storage/operations/buckets/create.md).

    1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md#create-sa) с ролью `storage.editor`. Трансфер будет использовать его для доступа к бакету.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации [opensearch-to-object-storage.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-opensearch-to-object-storage/blob/main/opensearch-to-object-storage.tf).

        В этом файле описаны:

        * [сеть](../../../vpc/concepts/network.md#network);
        * [подсеть](../../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../../vpc/concepts/security-groups.md) для подключения к кластеру {{ mos-name }};
        * сервисный аккаунт с ролью `storage.editor`;
        * кластер {{ mos-name }};
        * бакет-приемник {{ objstorage-name }};
        * эндпоинты;
        * трансфер.

    1. Укажите в файле `opensearch-to-object-storage.tf` параметры:

        * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md);
        * `mos_version` — версия {{ OS }};
        * `mos_password` — пароль пользователя-владельца кластера {{ OS }};
        * `bucket_name`— имя бакета в соответствии с [правилами именования](../../../storage/concepts/bucket.md#naming).
        * `profile_name` — имя вашего профиля в CLI.

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

1. [Создайте эндпоинт для приемника](../../../data-transfer/operations/endpoint/target/object-storage.md) типа `{{ objstorage-name }}` со следующими настройками:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.bucket.title }}** — `<имя_созданного_ранее_бакета>`
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.service_account_id.title }}** — `<имя_созданного_ранее_сервисного_аккаунта>`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_format.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_JSON.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_encoding.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageCodecUI.UNCOMPRESSED }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageAdvancedSettings.bucket_layout.title }}** — `from_MOS`.

1. [Создайте эндпоинт для источника](../../../data-transfer/operations/endpoint/source/opensearch.md#endpoint-settings) типа `{{ OS }}` со следующими настройками:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnectionType.mdb_cluster_id.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnectionType.mdb_cluster_id.title }}** — выберите кластер {{ mos-name }} из списка.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.user.title }}** — `admin`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.password.title }}** — `<пароль_пользователя>`.

1. Создайте трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

      1. [Создайте трансфер](../../../data-transfer/operations/transfer.md#create) типа **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}**, использующий созданные эндпоинты.

      1. [Активируйте трансфер](../../../data-transfer/operations/transfer.md#activate).

    - {{ TF }} {#tf}

      1. Укажите в файле `opensearch-to-object-storage.tf` значения переменных:

          * `target_endpoint_id` — значение идентификатора эндпоинта для приемника;
          * `source_endpoint_id` — значение идентификатора эндпоинта для источника;
          * `transfer_enabled` — значение `1` для создания трансфера.

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

Убедитесь, что данные перенеслись из кластера {{ mos-name }} в бакет {{ objstorage-name }}:

1. Дождитесь перехода трансфера в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.
1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится нужный бакет.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
1. Выберите бакет из списка.
1. Перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
1. Проверьте, что бакет {{ objstorage-name }} содержит папку `from_MOS` с файлом JSON с тестовыми данными.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите трансфер](../../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинты](../../../data-transfer/operations/endpoint/index.md#delete).
1. [Удалите](../../../storage/operations/objects/delete.md) из созданного бакета папку `from_MOS`.

Остальные ресурсы удалите в зависимости от способа их создания:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Удалите бакет {{ objstorage-name }}](../../../storage/operations/buckets/delete.md).
    1. [Удалите кластер {{ mos-name }}](../../../managed-opensearch/operations/cluster-delete.md).
    1. [Удалите сервисный аккаунт](../../../iam/operations/sa/delete.md).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
