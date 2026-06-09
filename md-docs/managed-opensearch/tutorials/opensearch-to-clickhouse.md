# Копирование данных из Managed Service for OpenSearch в Managed Service for ClickHouse® с помощью Yandex Data Transfer

# Копирование данных из Managed Service for OpenSearch в Managed Service for ClickHouse® с помощью Yandex Data Transfer

С помощью сервиса Data Transfer вы можете перенести данные из кластера-источника Managed Service for OpenSearch в Managed Service for ClickHouse®.

Чтобы перенести данные:

1. [Подготовьте инфраструктуру](#prepare-infrastructure).
1. [Подготовьте тестовые данные](#prepare-data).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for OpenSearch: использование вычислительных ресурсов, объем хранилища и резервных копий (см. [тарифы Managed Service for OpenSearch](../pricing.md)).
* Кластер Managed Service for ClickHouse®: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий (см. [тарифы Managed Service for ClickHouse®](../../managed-clickhouse/pricing.md)).
* Публичные IP-адреса, если для хостов кластеров включен публичный доступ (см. [тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).


## Подготовьте инфраструктуру {#prepare-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

    {% note info %}
    
    Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
    
    {% endnote %}

    1. [Создайте кластер-источник Managed Service for OpenSearch](../operations/cluster-create.md#create-cluster) любой подходящей конфигурации с хостами в публичном доступе.
    1. В той же [зоне доступности](../../overview/concepts/geo-scope.md) [создайте кластер-приемник Managed Service for ClickHouse®](../../managed-clickhouse/operations/cluster-create.md#create-cluster) любой подходящей конфигурации с хостами в публичном доступе.

       Если вы планируете подключаться к кластеру через сервис Yandex WebSQL, включите в настройках кластера настройку **Доступ из WebSQL**.

    1. [Получите SSL-сертификат](../operations/connect/index.md#ssl-certificate) для подключения к кластеру Managed Service for OpenSearch.

    1. Убедитесь, что группы безопасности кластеров [Managed Service for OpenSearch](../operations/connect/index.md#security-groups) и [Managed Service for ClickHouse®](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups) разрешают подключение через интернет.

- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [opensearch-to-clickhouse.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-opensearch-to-clickhouse/blob/main/opensearch-to-clickhouse.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к кластерам Managed Service for OpenSearch и Managed Service for ClickHouse®;
        * кластер-источник Managed Service for OpenSearch с пользователем `admin`;
        * кластер-приемник Managed Service for ClickHouse® с пользователем и базой данных;
        * эндпоинт-приемник;
        * трансфер.

    1. Укажите в файле `opensearch-to-clickhouse.tf` значения параметров:

        * `source_admin_password` — пароль пользователя `admin` в кластере Managed Service for OpenSearch;
        * `mos_version` — версия OpenSearch;
        * `mch_db_name` — название базы данных в кластере Managed Service for ClickHouse®;
        * `mch_username` — имя пользователя в кластере Managed Service for ClickHouse®;
        * `mch_user_password` — пароль пользователя в кластере Managed Service for ClickHouse®;
        * `source_endpoint_id` — идентификатор эндпоинта-источника;
        * `profile_name` — имя вашего профиля в CLI.

           Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

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

        В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

{% endlist %}

## Подготовьте тестовые данные {#prepare-data}

1. В кластере-источнике создайте тестовый индекс `people` и задайте его схему:

    ```bash
    curl --cacert ~/.opensearch/root.crt \
         --user <имя_пользователя_в_кластере-источнике>:<пароль_пользователя_в_кластере-источнике> \
         --header 'Content-Type: application/json' \
         --request PUT 'https://<адрес_хоста_OpenSearch_с_ролью_DATA>:9200/people' && \
    curl --cacert ~/.opensearch/root.crt \
         --user <имя_пользователя_в_кластере-источнике>:<пароль_пользователя_в_кластере-источнике> \
         --header 'Content-Type: application/json' \
         --request PUT 'https://<адрес_хоста_OpenSearch_с_ролью_DATA>:9200/people/_mapping?pretty' \
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
         --request POST 'https://<адрес_хоста_OpenSearch_с_ролью_DATA>:9200/people/_doc/?pretty' \
         --data'
         {
               "name": "Alice",
               "age": "30"
         }
         ' && \
    curl --cacert ~/.opensearch/root.crt \
         --user <имя_пользователя_в_кластере-источнике>:<пароль_пользователя_в_кластере-источнике> \
         --header 'Content-Type: application/json' \
         --request POST 'https://<адрес_хоста_OpenSearch_с_ролью_DATA>:9200/people/_doc/?pretty' \
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
         --request GET 'https://<адрес_хоста_OpenSearch_с_ролью_DATA>:9200/people/_search?pretty'
    ```

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт-источник](../../data-transfer/operations/endpoint/index.md#create) для [созданного ранее](#before-you-begin) кластера Managed Service for OpenSearch с настройками:

    * **Тип базы данных** — `OpenSearch`.
    * **Настройки подключения**:
        * **Тип подключения** — `Кластер Managed Service for OpenSearch`.
        * **Кластер Managed Service for OpenSearch** — выберите кластер Managed Service for OpenSearch из списка.
        * **Пользователь** — `admin`.
        * **Пароль** — пароль пользователя `admin`.

1. Создайте эндпоинт-приемник и трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте эндпоинт-приемник](../../data-transfer/operations/endpoint/index.md#create):

            * **Тип базы данных** — `ClickHouse`.
            * **Параметры эндпоинта**:
                * **Тип подключения** — выберите `Кластер Managed Service for ClickHouse`.
                * **Managed кластер** — выберите кластер Managed Service for ClickHouse® из списка.
                * **Пользователь** — введите имя пользователя в кластере Managed Service for ClickHouse®.
                * **Пароль** — введите пароль пользователя в кластере Managed Service for ClickHouse®.
                * **База данных** — введите название БД в кластере Managed Service for ClickHouse®.

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **Копирование**, использующий созданные эндпоинты.
        1. [Активируйте](../../data-transfer/operations/transfer.md#activate) трансфер.

    - Terraform {#tf}

        1. Укажите в файле `opensearch-to-clickhouse.tf` значения параметра:

            * `source_endpoint_id` — значение идентификатора эндпоинта для источника;
            * `transfer_enabled` — значение `1` для создания эндпоинта-приемника и трансфера.

        1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, Terraform на них укажет.

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

1. Дождитесь перехода трансфера в статус **Завершен**.
1. Убедитесь, что в базу данных Managed Service for ClickHouse® перенеслись данные из кластера-источника Managed Service for OpenSearch:

    {% list tabs group=instructions %}

    - Yandex WebSQL {#websql}

      1. [Создайте подключение](../../websql/operations/create-connection.md#connect-cluster) к БД в кластере Managed Service for ClickHouse®.
      1. Проверьте, что БД содержит таблицу `people` с тестовыми данными. Для этого через созданное подключение [выполните запрос](../../websql/operations/query-executor.md#execute-query) к БД:

         ```sql
         SELECT * FROM people;
         ```

    - CLI {#cli}

      1. [Получите SSL-сертификат](../../managed-clickhouse/operations/connect/index.md#get-ssl-cert) для подключения к кластеру Managed Service for ClickHouse®.
      1. Если у вас нет `clickhouse-client`, [установите его](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client).
      1. [Подключитесь к БД](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) в кластере Managed Service for ClickHouse®.
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
        1. [Удалите кластер Managed Service for OpenSearch](../operations/cluster-delete.md).
        1. [Удалите кластер Managed Service for ClickHouse®](../../managed-clickhouse/operations/cluster-delete.md).

            В сервисе Yandex WebSQL подключение к БД в кластере Managed Service for ClickHouse® удалится автоматически.

        1. [Удалите подсеть](../../vpc/operations/subnet-delete.md).
        1. [Удалите сеть](../../vpc/operations/network-delete.md).

    - Terraform {#tf}

        1. В терминале перейдите в директорию с планом инфраструктуры.
        
            {% note warning %}
        
            Убедитесь, что в директории нет Terraform-манифестов с ресурсами, которые вы хотите сохранить. Terraform удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
        
            {% endnote %}
        
        1. Удалите ресурсы:
        
            1. Выполните команду:
        
                ```bash
                terraform destroy
                ```
        
            1. Подтвердите удаление ресурсов и дождитесь завершения операции.
        
            Все ресурсы, которые были описаны в Terraform-манифестах, будут удалены.

    {% endlist %}

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._