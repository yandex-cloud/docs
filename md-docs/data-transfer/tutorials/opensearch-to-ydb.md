# Миграция данных из Yandex Managed Service for OpenSearch в Yandex Managed Service for YDB с помощью Data Transfer

# Миграция данных из Yandex Managed Service for OpenSearch в Yandex Managed Service for YDB с помощью Yandex Data Transfer


С помощью сервиса Data Transfer вы можете перенести данные из кластера Managed Service for OpenSearch в базу данных Managed Service for YDB.

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

* Кластер Managed Service for OpenSearch: использование вычислительных ресурсов, объем хранилища и резервных копий (см. [тарифы Managed Service for OpenSearch](../../managed-opensearch/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ (см. [тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).
* База данных Managed Service for YDB (см. [тарифы Managed Service for YDB](../../ydb/pricing/index.md)). Стоимость зависит от режима использования:

    * Для бессерверного режима — оплачиваются операции с данными, объем хранимых данных и резервных копий.
    * Для режима с выделенными инстансами — оплачивается использование выделенных БД вычислительных ресурсов, объем хранилища и резервные копии.


## Подготовьте инфраструктуру {#prepare-infrastructure}

{% list tabs group=instructions %}

* Вручную {#manual}

    1. [Создайте кластер Managed Service for OpenSearch](../../managed-opensearch/operations/cluster-create.md) любой подходящей конфигурации с хостами в публичном доступе.

        {% note info %}
        
        Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
        
        {% endnote %}

    1. Если вы используете группы безопасности в кластере, убедитесь, что они настроены правильно и допускают подключение к кластеру [Managed Service for OpenSearch](../../managed-opensearch/operations/connect/index.md#configuring-security-groups).

    1. [Получите SSL-сертификат](../../managed-opensearch/operations/connect/index.md#ssl-certificate) для подключения к кластеру Managed Service for OpenSearch.

    1. [Создайте базу данных Managed Service for YDB](../../ydb/operations/manage-databases.md) `ydb1` любой подходящей конфигурации.

    
    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) с именем `ydb-account` и ролью `ydb.editor`. Трансфер будет использовать его для доступа к базе данных.


* С помощью Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [opensearch-to-ydb.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-opensearch-to-ydb/blob/main/opensearch-to-ydb.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к кластеру Managed Service for OpenSearch из интернета;
        * база данных Managed Service for YDB;
        * кластер-приемник Managed Service for OpenSearch;
        * эндпоинт для приемника;
        * трансфер.

    1. Укажите в файле `opensearch-to-ydb.tf` параметры:

        * `mos_version` — версия OpenSearch.
        * `mos_password` — пароль пользователя-владельца базы данных OpenSearch.
        * `profile_name` — имя вашего профиля в CLI. 

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

1. [Подключитесь к кластеру-источнику Managed Service for OpenSearch](../../managed-opensearch/operations/connect/index.md).

1. Создайте тестовый индекс `people` и задайте его схему:

    ```bash
    curl --user admin:<пароль> \
         --cacert ~/.opensearch/root.crt \
         --header 'Content-Type: application/json' \
         --request PUT 'https://<адрес_хоста_OpenSearch_с_ролью_DATA>:9200/people' && \
    curl --user admin:<пароль> \
         --cacert ~/.opensearch/root.crt \
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
    curl --user admin:<пароль> \
         --cacert ~/.opensearch/root.crt \
         --header 'Content-Type: application/json' \
         --request POST 'https://<адрес_хоста_OpenSearch_с_ролью_DATA>:9200/people/_doc/?pretty' \
         --data'
         {
               "name" : "Alice",
               "age" : "30"
         }
         ' && \
    curl --user admin:<пароль> \
         --cacert ~/.opensearch/root.crt \
         --header 'Content-Type: application/json' \
         --request POST 'https://<адрес_хоста_OpenSearch_с_ролью_DATA>:9200/people/_doc/?pretty' \
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
         --request GET 'https://<адрес_хоста_OpenSearch_с_ролью_DATA>:9200/people/_search?pretty'
    ```

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт-источник](../operations/endpoint/source/opensearch.md#endpoint-settings) типа `OpenSearch` со следующими настройками:

    * **Тип подключения** — `Кластер Managed Service for OpenSearch`.
    * **Кластер Managed Service for OpenSearch** — выберите кластер Managed Service for OpenSearch из списка.
    * **Пользователь** — `admin`.
    * **Пароль** — `<пароль_пользователя>`.

1. Создайте эндпоинт-приемник и трансфер:

    {% list tabs group=instructions %}

    * Вручную {#manual}

        1. [Создайте эндпоинт-приемник](../operations/endpoint/target/yandex-database.md#endpoint-settings) типа `YDB` со следующими настройками:

            * **База данных** — выберите базу данных `ydb1` из списка.

            
            * **Идентификатор сервисного аккаунта** — выберите сервисный аккаунт `ydb-account` из списка.


        1. [Создайте трансфер](../operations/transfer.md#create) типа **_Копирование_**, использующий созданные эндпоинты.

        1. [Активируйте трансфер](../operations/transfer.md#activate) и дождитесь его перехода в статус **Завершен**.

    * С помощью Terraform {#tf}

        1. Укажите в файле `opensearch-to-ydb.tf` значения параметров:

            * `source_endpoint_id` — идентификатор эндпоинта для источника.
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

        1. Трансфер активируется автоматически. Дождитесь его перехода в статус **Завершен**.

    {% endlist %}

## Проверьте работу трансфера {#verify-transfer}

1. [Подключитесь к базе данных Managed Service for YDB](../../ydb/operations/connection.md).

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

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../operations/transfer.md#deactivate).

{% endnote %}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. Удалите ресурсы в зависимости от способа их создания:

    {% list tabs group=instructions %}

    * Вручную {#manual}

        1. [Удалите трансфер](../operations/transfer.md#delete).
        1. [Удалите эндпоинт для приемника](../operations/endpoint/index.md#delete).
        1. [Удалите кластер Managed Service for OpenSearch](../../managed-opensearch/operations/cluster-delete.md).
        1. [Удалите базу данных Managed Service for YDB](../../ydb/operations/manage-databases.md#delete-db).

        
        1. [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md).


    * С помощью Terraform {#tf}

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

1. [Удалите эндпоинт для источника](../operations/endpoint/index.md#delete).