# Копирование данных из Managed Service for OpenSearch в Yandex MPP Analytics for PostgreSQL с помощью Yandex Data Transfer

# Копирование данных из Yandex Managed Service for OpenSearch в Yandex MPP Analytics for PostgreSQL с помощью Yandex Data Transfer

С помощью сервиса Yandex Data Transfer вы можете перенести данные из кластера-источника Yandex Managed Service for OpenSearch в кластер-приемник Greenplum® в сервисе Yandex MPP Analytics for PostgreSQL.

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
* Кластер Yandex MPP Analytics for PostgreSQL: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий (см. [тарифы Yandex MPP Analytics for PostgreSQL](../../managed-greenplum/pricing/index.md)).
* Публичные IP-адреса, если для хостов кластеров включен публичный доступ (см. [тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).


## Подготовьте инфраструктуру {#prepare-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

    {% note info %}
    
    Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
    
    {% endnote %}

    1. [Создайте кластер-источник Managed Service for OpenSearch](../operations/cluster-create.md#create-cluster) любой подходящей конфигурации с хостами в публичном доступе.
    1. В той же [зоне доступности](../../overview/concepts/geo-scope.md) [создайте кластер-приемник Greenplum®](../../managed-greenplum/operations/cluster-create.md#create-cluster) любой подходящей конфигурации. При создании кластера:
        * Включите публичный доступ для хостов.
        * Включите опцию **Доступ из Data Transfer**.
    1. [Получите SSL-сертификат](../operations/connect/index.md#ssl-certificate) для подключения к кластеру Managed Service for OpenSearch.
    1. Убедитесь, что группы безопасности кластеров [Managed Service for OpenSearch](../operations/connect/index.md#security-groups) и [Greenplum®](../../managed-greenplum/operations/connect/index.md#configuring-security-groups) разрешают подключение через интернет.

- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [opensearch-to-greenplum.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-opensearch-to-greenplum/blob/main/opensearch-to-greenplum.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к кластерам OpenSearch и Greenplum®;
        * кластер-источник Managed Service for OpenSearch с пользователем `admin`;
        * кластер-приемник Greenplum® в сервисе Yandex MPP Analytics for PostgreSQL;
        * трансфер.

    1. Укажите в файле `opensearch-to-greenplum.tf` значения параметров:

        * `mos_cluster_name` — имя кластера Managed Service for OpenSearch;
        * `mos_version` — версия OpenSearch;
        * `mos_admin_password` — пароль пользователя `admin` в кластере Managed Service for OpenSearch;
        * `mgp_cluster_name` — имя кластера Greenplum®;
        * `mgp_username` — имя пользователя в кластере Greenplum®;
        * `mgp_user_password` — пароль пользователя в кластере Greenplum®;
        * `transfer_name` — имя трансфера Data Transfer;
        * `profile_name` — имя вашего профиля в YC CLI.

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
         --request PUT 'https://<адрес_хоста_OpenSearch_с_ролью_DATA>:9200/people/_mapping?pretty' -d'
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
         --request POST 'https://<адрес_хоста_OpenSearch_с_ролью_DATA>:9200/people/_doc/?pretty' -d'
         {
               "name": "Alice",
               "age": "30"
         }
         ' && \
    curl --cacert ~/.opensearch/root.crt \
         --user <имя_пользователя_в_кластере-источнике>:<пароль_пользователя_в_кластере-источнике> \
         --header 'Content-Type: application/json' \
         --request POST 'https://<адрес_хоста_OpenSearch_с_ролью_DATA>:9200/people/_doc/?pretty' -d'
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

1. [Создайте эндпоинт-приемник](../../data-transfer/operations/endpoint/index.md#create) для [созданного ранее](#before-you-begin) кластера Greenplum® с настройками:

    * **Тип базы данных** — `Greenplum`.
    * **Параметры эндпоинта**:
        * **Тип подключения** — выберите `Кластер`.
        * **Кластер** — выберите кластер Greenplum® из списка.
        * **База данных** — `postgres`.
        * **Пользователь** — введите имя пользователя в кластере Greenplum®.
        * **Пароль** — введите пароль пользователя в кластере Greenplum®.

1. Создайте трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **Копирование**, использующий созданные эндпоинты.
        1. [Активируйте](../../data-transfer/operations/transfer.md#activate) трансфер.

    - Terraform {#tf}

        1. Укажите в файле `opensearch-to-greenplum.tf` значения параметров:

            * `source_endpoint_id` — идентификатор эндпоинта-источника;
            * `target_endpoint_id` — идентификатор эндпоинта-приемника;
            * `transfer_enabled` — `1` для создания трансфера.

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
1. Убедитесь, что в Yandex MPP Analytics for PostgreSQL перенеслись данные из кластера-источника Managed Service for OpenSearch:

   1. [Получите SSL-сертификат](../../managed-greenplum/operations/connect/index.md#get-ssl-cert) для подключения к кластеру Greenplum®.
   1. Установите зависимости:

      ```bash
      sudo apt update && sudo apt install --yes postgresql-client
      ```

   1. Подключитесь к базе данных в кластере Greenplum®.
   1. Проверьте, что БД содержит таблицу `people` с тестовыми данными:

       ```sql
       SELECT * FROM people;
       ```

## Удалите созданные ресурсы {#clear-out}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

{% list tabs group=instructions %}

  - Вручную {#manual}

      1. [Удалите кластер Managed Service for OpenSearch](../operations/cluster-delete.md).
      1. [Удалите кластер Greenplum®](../../managed-greenplum/operations/cluster-delete.md).
      
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