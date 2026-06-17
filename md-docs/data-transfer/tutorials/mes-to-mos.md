# Миграция данных из Elasticsearch в Yandex Managed Service for OpenSearch

# Миграция данных из Elasticsearch в Yandex Managed Service for OpenSearch с помощью Yandex Data Transfer


Вы можете настроить перенос данных из индексов Elasticsearch в индексы Managed Service for OpenSearch с помощью сервиса Data Transfer. Для этого:

1. [Настройте кластер-источник](#configure-source).
1. [Подготовьте тестовые данные](#prepare-data).
1. [Настройте кластер-приемник](#configure-target).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работу трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for OpenSearch: использование вычислительных ресурсов, объем хранилища и резервных копий ([тарифы Managed Service for OpenSearch](../../managed-opensearch/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Virtual Private Cloud](../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}

1. [Создайте пользовательскую инсталляцию Elasticsearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started.html).
1. [Обеспечьте доступ к кластеру из Yandex Cloud](../concepts/network.md#source-external).
1. Создайте кластер-приемник Managed Service for OpenSearch:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        [Создайте кластер-приемник Managed Service for OpenSearch](../../managed-opensearch/operations/cluster-create.md) любой подходящей конфигурации с хостами в публичном доступе.

        {% note info %}
        
        Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
        
        {% endnote %}

    - Terraform {#tf}

        1. Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
           
           
           Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.
        1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf). Поместите его в отдельную рабочую директорию и укажите значения параметров.
        1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-es-mos.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-elasticsearch-to-opensearch/blob/main/data-transfer-es-mos.tf).

            В этом файле описаны:

            * [сеть](../../vpc/concepts/network.md#network);
            * [подсеть](../../vpc/concepts/network.md#subnet);
            * [группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к кластеру Managed Service for OpenSearch;
            * кластер-приемник Managed Service for OpenSearch;
            * трансфер.

        1. Укажите в файле `data-transfer-es-mos.tf` переменные:

            * `mos_version` — версия OpenSearch.
            * `mos_admin_password` — пароль пользователя-администратора Managed Service for OpenSearch.
            * `transfer_enabled` — значение `0`, чтобы не создавать трансфер до [создания эндпоинтов вручную](#prepare-transfer).

        1. Выполните команду `terraform init` в директории с конфигурационным файлом. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
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


Вы можете поставлять данные из кластера Elasticsearch от имени пользователя `admin`, имеющего роль `superuser`, но безопаснее для каждой задачи создавать отдельных пользователей с ограниченными привилегиями. Для этого создайте пользователя, от имени которого будет выполняться трансфер:

1. В кластере-источнике [создайте роль](https://www.elastic.co/guide/en/elasticsearch/reference/current/defining-roles.html) с [привилегиями](https://www.elastic.co/guide/en/elasticsearch/reference/current/security-privileges.html#privileges-list-indices) `create_index` и `write` для всех индексов (`*`).

1. В кластере-источнике создайте пользователя, от имени которого будет выполняться трансфер, и назначьте ему созданную роль.

## Подготовьте тестовые данные {#prepare-data}

1. В кластере-источнике создайте тестовый индекс `people` и задайте его схему:

    ```bash
    curl --user <имя_пользователя_в_кластере-источнике>:<пароль_пользователя_в_кластере-источнике> \
         --header 'Content-Type: application/json' \
         --request PUT 'https://<адрес_хоста_Elasticsearch_с_ролью_Data>:9200/people' && \
    curl --user <имя_пользователя_в_кластере-источнике>:<пароль_пользователя_в_кластере-источнике> \
         --header 'Content-Type: application/json' \
         --request PUT 'https://<адрес_хоста_Elasticsearch_с_ролью_Data>:9200/people/_mapping?pretty' \
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
         --header 'Content-Type: application/json' \
         --request POST 'https://<адрес_хоста_Elasticsearch_с_ролью_Data>:9200/people/_doc/?pretty' \
         --data'
         {
               "name" : "Alice",
               "age" : "30"
         }
         ' && \
    curl --user <имя_пользователя_в_кластере-источнике>:<пароль_пользователя_в_кластере-источнике> \
         --header 'Content-Type: application/json' \
         --request POST 'https://<адрес_хоста_Elasticsearch_с_ролью_Data>:9200/people/_doc/?pretty' \
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
         --header 'Content-Type: application/json' \
         --request GET 'https://<адрес_хоста_Elasticsearch_с_ролью_Data>:9200/people/_search?pretty'
    ```

## Настройте кластер-приемник {#configure-target}

1. [Получите SSL-сертификат](../../managed-opensearch/operations/connect/index.md#ssl-certificate) для подключения к кластеру Managed Service for OpenSearch.

1. (Опционально) Создайте пользователя, от имени которого будет выполняться трансфер.

    Вы можете поставлять данные в кластер Managed Service for OpenSearch от имени пользователя `admin`, имеющего роль `superuser`, но безопаснее для каждой задачи создавать отдельных пользователей с ограниченными привилегиями.

    1. [Создайте роль](https://opensearch.org/docs/latest/security-plugin/access-control/users-roles/#create-roles) с привилегиями `create_index` и `write` для всех индексов (`*`).

    1. [Создайте пользователя](../../managed-opensearch/operations/cluster-users.md) и назначьте ему эту роль.

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт](../operations/endpoint/index.md#create) для [источника Elasticsearch](../operations/endpoint/source/elasticsearch.md).

1. [Создайте эндпоинт](../operations/endpoint/index.md#create) для [приемника OpenSearch](../operations/endpoint/target/opensearch.md).

1. Создайте трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте трансфер](../operations/transfer.md#create) типа **_Копирование_**, использующий созданные эндпоинты.
        1. [Активируйте трансфер](../operations/transfer.md#activate) и дождитесь его перехода в статус **Завершен**.

    - Terraform {#tf}

        1. Укажите в файле `data-transfer-mes-mos.tf` переменные:

            * `source_endpoint_id` — значение идентификатора эндпоинта для источника;
            * `target_endpoint_id` — значение идентификатора эндпоинта для приемника;
            * `transfer_enabled` — значение `1` для создания трансфера.

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

        1. [Активируйте трансфер](../operations/transfer.md#activate) и дождитесь его перехода в статус **Завершен**.

    {% endlist %}

## Проверьте работу трансфера {#verify-transfer}

Проверьте, что индекс `people` кластера Managed Service for OpenSearch содержит отправленные данные:

{% list tabs group=programming_language %}

- Bash {#bash}

    Выполните команду:

    ```bash
    curl --user <имя_пользователя_в_кластере-приемнике>:<пароль_пользователя_в_кластере-приемнике> \
         --cacert ~/.opensearch/root.crt \
         --header 'Content-Type: application/json' \
         --request GET 'https://<адрес_хоста_OpenSearch_с_ролью_Data_Node>:9200/people/_search?pretty'
    ```

- OpenSearch Dashboards {#opensearch}

    1. [Подключитесь](../../managed-opensearch/operations/connect/clients.md#dashboards) к кластеру-приемнику с помощью OpenSearch Dashboards.
    1. Выберите общий тенант `Global`.
    1. Откройте панель управления, нажав на значок ![os-dashboards-sandwich](../../_assets/console-icons/bars.svg).
    1. В разделе **OpenSearch Dashboards** выберите **Discover**.
    1. В поле **CHANGE INDEX PATTERN** выберите индекс `people`.

{% endlist %}

## Удалите созданные ресурсы {#clear-out}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. [Удалите трансфер](../operations/transfer.md#delete).
1. [Удалите эндпоинты](../operations/endpoint/index.md#delete) для источника и приемника.
1. Остальные ресурсы удалите в зависимости от способа их создания:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        [Удалите кластер Managed Service for OpenSearch](../../managed-opensearch/operations/cluster-delete.md).

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