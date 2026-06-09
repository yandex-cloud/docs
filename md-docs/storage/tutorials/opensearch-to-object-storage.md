# Загрузка данных из {{ mos-full-name }} в {{ objstorage-full-name }} с помощью {{ data-transfer-full-name }}

# Загрузка данных из {{ mos-full-name }} в {{ objstorage-full-name }} с помощью {{ data-transfer-full-name }}

С помощью сервиса {{ data-transfer-name }} вы можете перенести данные из кластера {{ mos-name }} в объектное хранилище {{ objstorage-name }}.

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
* Публичные IP-адреса, если для хостов кластера включен публичный доступ (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).
* Бакет {{ objstorage-name }}: использование хранилища и выполнение операций с данными (см. [тарифы {{ objstorage-name }}](../pricing.md)).


## Подготовьте инфраструктуру {#prepare-infrastructure}


{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте кластер {{ mos-name }}](../../managed-opensearch/operations/cluster-create.md) любой подходящей конфигурации с хостами в публичном доступе.

        {% note info %}
        
        Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин {{ yandex-cloud }}, расположенных в той же облачной сети, что и кластер.
        
        {% endnote %}

    1. Если вы используете группы безопасности в кластере, убедитесь, что они настроены правильно и допускают подключение к кластеру [{{ mos-name }}](../../managed-opensearch/operations/connect/index.md#configuring-security-groups).

    1. [Получите SSL-сертификат](../../managed-opensearch/operations/connect/index.md#ssl-certificate) для подключения к кластеру {{ mos-name }}.

    1. [Создайте бакет {{ objstorage-name }}](../operations/buckets/create.md).

    
    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) с ролью `storage.editor`. Трансфер будет использовать его для доступа к бакету.


- {{ TF }} {#tf}

    1. Если у вас еще нет {{ TF }}, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [opensearch-to-object-storage.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-opensearch-to-object-storage/blob/main/opensearch-to-object-storage.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) для подключения к кластеру {{ mos-name }};
        * сервисный аккаунт с ролью `storage.editor`;
        * кластер {{ mos-name }};
        * бакет-приемник {{ objstorage-name }};
        * эндпоинты;
        * трансфер.

    1. Укажите в файле `opensearch-to-object-storage.tf` параметры:

        * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md);
        * `mos_version` — версия {{ OS }};
        * `mos_password` — пароль пользователя-владельца кластера {{ OS }};
        * `bucket_name`— имя бакета в соответствии с [правилами именования](../concepts/bucket.md#naming).
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

1. [Подключитесь к кластеру-источнику {{ mos-name }}](../../managed-opensearch/operations/connect/index.md).

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

1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/target/object-storage.md) типа `{{ objstorage-name }}` со следующими настройками:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.bucket.title }}** — `<имя_созданного_ранее_бакета>`

    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.service_account_id.title }}** — `<имя_созданного_ранее_сервисного_аккаунта>`.


    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_format.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_JSON.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_encoding.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageCodecUI.UNCOMPRESSED.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageAdvancedSettings.bucket_layout.title }}** — `from_MOS`.

1. [Создайте эндпоинт для источника](../../data-transfer/operations/endpoint/source/opensearch.md#endpoint-settings) типа `{{ OS }}` со следующими настройками:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnectionType.mdb_cluster_id.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnectionType.mdb_cluster_id.title }}** — выберите кластер {{ mos-name }} из списка.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.user.title }}** — `admin`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.password.title }}** — `<пароль_пользователя>`.

1. Создайте трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

      1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}**, использующий созданные эндпоинты.

      1. [Активируйте трансфер](../../data-transfer/operations/transfer.md#activate).

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

Убедитесь, что данные перенеслись из кластера {{ mos-name }} в бакет {{ objstorage-name }}:

1. Дождитесь перехода трансфера в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.
1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится нужный бакет.
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
1. Выберите бакет из списка.
1. Перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
1. Проверьте, что бакет {{ objstorage-name }} содержит папку `from_MOS` с файлом JSON с тестовыми данными.

## Удалите созданные ресурсы {#clear-out}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete).
1. [Удалите](../operations/objects/delete.md) из созданного бакета папку `from_MOS`.
1. Остальные ресурсы удалите в зависимости от способа их создания:

   {% list tabs group=instructions %}

   - Вручную {#manual}

       1. [Удалите бакет {{ objstorage-name }}](../operations/buckets/delete.md).
       1. [Удалите кластер {{ mos-name }}](../../managed-opensearch/operations/cluster-delete.md).

       
       1. [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md).


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