# Управление эндпоинтами

[Эндпоинт](../../concepts/index.md#endpoint)-источник описывает настройки базы данных, из которой будет передаваться информация с помощью Data Transfer, а эндпоинт-приемник — БД, в которую будет производиться перенос. Вы можете [создать](#create), [изменить](#update), [клонировать](#clone) или [удалить](#delete) такие эндпоинты.

## Получить список эндпоинтов {#list}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога](https://console.yandex.cloud).
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Data Transfer**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/aperture.svg) **Эндпоинты**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить список [трансферов](../../concepts/index.md#transfer) в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), выполните команду:

  ```bash
  yc datatransfer endpoint list
  ```


- API {#api}

  Воспользуйтесь методом API [list](../../api-ref/Endpoint/list.md).


{% endlist %}

## Получить детальную информацию об эндпоинте {#get}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога](https://console.yandex.cloud).
    1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Data Transfer**.
    1. На панели слева выберите ![image](../../../_assets/console-icons/aperture.svg) **Эндпоинты**.
    1. Нажмите на имя нужного эндпоинта.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы получить информацию об эндпоинте, выполните команду:

    ```bash
    yc datatransfer endpoint get <идентификатор_эндпоинта>
    ```

    Идентификатор эндпоинта можно получить со [списком эндпоинтов в каталоге](#list).


- API {#api}

    Воспользуйтесь методом API [get](../../api-ref/Endpoint/get.md) и передайте значение идентификатора эндпоинта в параметре `endpointId` запроса.

    Чтобы узнать идентификатор эндпоинта, [получите список эндпоинтов в каталоге](#list).


{% endlist %}

## Создать эндпоинт {#create}


{% note warning %}

Для создания или редактирования эндпоинта управляемой базы данных вам потребуется сервисная или примитивная [роль `viewer`](../../../iam/roles-reference.md#viewer), выданная на каталог кластера этой управляемой базы данных.  

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога](https://console.yandex.cloud).
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Data Transfer**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/aperture.svg) **Эндпоинты**.
  1. Нажмите кнопку **Создать эндпоинт**.
  1. В поле **Направление** выберите **Источник** или **Приёмник**.
  1. Укажите имя эндпоинта. Используйте строчные латинские буквы и цифры.
  1. (Опционально) Укажите описание эндпоинта.
  1. Выберите нужное значение в поле **Тип базы данных**. Будет создан эндпоинт соответствующего типа.
  1. Задайте параметры эндпоинта:

     * Источники:
      
         * Airbyte®:
             * [AWS CloudTrail](source/aws-cloudtrail.md)
             * [BigQuery](source/bigquery.md)
             * [MS SQL Server](source/mssql.md)
             * [S3](source/s3.md)
         * [Apache Kafka®](source/kafka.md)
         * [ClickHouse®](source/clickhouse.md)
         * [Greenplum®](source/greenplum.md)
         * [Яндекс Метрика](source/metrika.md)
         * [MongoDB](source/mongodb.md)
         * [MySQL®](source/mysql.md)
         * [Object Storage](source/object-storage.md)
         * [Oracle](source/oracle.md)
         * [PostgreSQL](source/postgresql.md)
         * [Yandex Data Streams](source/data-streams.md)
         * [Yandex Managed Service for YDB](source/ydb.md)
         * [YTsaurus](target/yt.md)
     * Приемники:
         * [Apache Kafka®](target/kafka.md)
         * [ClickHouse®](target/clickhouse.md)
         * [Greenplum®](target/greenplum.md)
         * [MongoDB](target/mongodb.md)
         * [MySQL®](target/mysql.md)
         * [Object Storage](target/object-storage.md)
         * [OpenSearch](target/opensearch.md)
         * [PostgreSQL](target/postgresql.md)
         * [Yandex Data Streams](target/data-streams.md)
         * [Yandex Managed Service for YDB](target/yandex-database.md)
         * YTsaurus:
             * [YTSaurus Dynamic](target/yt.md)
             * [YTSaurus Static](target/yt.md)

  1. Нажмите кнопку **Создать эндпоинт**.

- CLI {#cli}

  {% note info %}

  Создание эндпоинта с помощью команд [CLI](../../../cli/index.md) поддерживается только для источников и приемников типа ClickHouse®, MongoDB, MySQL® и PostgreSQL.

  {% endnote %}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для создания эндпоинта:

     ```bash
     yc datatransfer endpoint create --help
     ```

  1. Укажите параметры эндпоинта в команде создания (в примере приведены не все параметры):

     ```bash
     yc datatransfer endpoint create <тип_эндпоинта> \
       --name <имя_эндпоинта> \
       --description <описание_эндпоинта> \
       <параметры_эндпоинта>
     ```

     Тип эндпоинта и его параметры см. в разделе настроек для нужного источника или приемника данных.

- Terraform {#tf}

  
  {% note info %}

  Создание эндпоинта с помощью Terraform поддерживается только для источников и приемников типа ClickHouse®, MongoDB, MySQL® и PostgreSQL.

  {% endnote %}


  
  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


  1. Создайте конфигурационный файл с описанием эндпоинта.

     Пример структуры конфигурационного файла:

     ```hcl
     resource "ycp_datatransfer_endpoint" "<имя_эндпоинта_в_Terraform>" {
       name = "<имя_эндпоинта>"
       settings {
         <тип_эндпоинта> {
           <параметры_эндпоинта>
         }
       }
     }
     ```

  Полную схему ресурсов можно получить, запустив `terraform providers schema`.
  1. Тип эндпоинта и его параметры см. в разделе настроек для нужного источника или приемника данных.
  1. Проверьте корректность настроек.

     1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
     1. Выполните команду:
     
        ```bash
        terraform validate
        ```
     
        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Подтвердите изменение ресурсов.

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

  
  1. Подробнее см. в [документации провайдера Terraform](../../../terraform/resources/datatransfer_endpoint.md).


- API {#api}

  {% note info %}

  Создание эндпоинта с помощью [API](../../../glossary/rest-api.md) поддерживается только для источников и приемников типа ClickHouse®, Apache Kafka®, MongoDB, MySQL® и PostgreSQL.

  {% endnote %}

  Воспользуйтесь методом API [create](../../api-ref/Endpoint/create.md) и передайте в запросе:
  * Идентификатор [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором должен быть размещен эндпоинт, в параметре `folderId`.
  * Имя эндпоинта в параметре `name`.
  * Описание эндпоинта в параметре `description`.
  * Параметры эндпоинта в параметре `settings`.

   Параметры эндпоинта см. в разделе настроек для нужного источника или приемника данных.

{% endlist %}

## Изменить эндпоинт {#update}


{% note warning %}

Для создания или редактирования эндпоинта управляемой базы данных вам потребуется сервисная или примитивная [роль `viewer`](../../../iam/roles-reference.md#viewer), выданная на каталог кластера этой управляемой базы данных.  

{% endnote %}


{% note info %}

Тип эндпоинта и тип БД нельзя изменить. Для ряда эндпоинтов невозможно также изменить тип подключения.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога](https://console.yandex.cloud).
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Data Transfer**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/aperture.svg) **Эндпоинты**.
  1. Выберите эндпоинт и нажмите кнопку ![pencil](../../../_assets/console-icons/pencil.svg) **Редактировать** на панели сверху.
  1. Отредактируйте параметры эндпоинта:

     * Источники:
      
         * Airbyte®:
             * [AWS CloudTrail](source/aws-cloudtrail.md)
             * [BigQuery](source/bigquery.md)
             * [MS SQL Server](source/mssql.md)
             * [S3](source/s3.md)
         * [Apache Kafka®](source/kafka.md)
         * [ClickHouse®](source/clickhouse.md)
         * [Greenplum®](source/greenplum.md)
         * [Яндекс Метрика](source/metrika.md)
         * [MongoDB](source/mongodb.md)
         * [MySQL®](source/mysql.md)
         * [Object Storage](source/object-storage.md)
         * [Oracle](source/oracle.md)
         * [PostgreSQL](source/postgresql.md)
         * [Yandex Data Streams](source/data-streams.md)
         * [Yandex Managed Service for YDB](source/ydb.md)
         * [YTsaurus](target/yt.md)
     * Приемники:
         * [Apache Kafka®](target/kafka.md)
         * [ClickHouse®](target/clickhouse.md)
         * [Greenplum®](target/greenplum.md)
         * [MongoDB](target/mongodb.md)
         * [MySQL®](target/mysql.md)
         * [Object Storage](target/object-storage.md)
         * [OpenSearch](target/opensearch.md)
         * [PostgreSQL](target/postgresql.md)
         * [Yandex Data Streams](target/data-streams.md)
         * [Yandex Managed Service for YDB](target/yandex-database.md)
         * YTsaurus:
             * [YTSaurus Dynamic](target/yt.md)
             * [YTSaurus Static](target/yt.md)

  1. Нажмите кнопку **Применить**.

- CLI {#cli}

  {% note info %}

  Изменение эндпоинта с помощью команд CLI поддерживается только для источников и приемников типа ClickHouse®, MongoDB, MySQL® и PostgreSQL.

  {% endnote %}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить настройки эндпоинта:
  1. Посмотрите описание команды CLI для изменения трансфера:

     ```bash
     yc datatransfer endpoint update --help
     ```

  1. Выполните команду, передав список настроек, которые хотите изменить (в примере приведены не все параметры):

     ```bash
     yc datatransfer transfer update <тип_эндпоинта> <идентификатор_эндпоинта> \
       --name <имя_эндпоинта> \
       --description <описание_эндпоинта> \
       <параметры_эндпоинта>
     ```

     Тип эндпоинта и его параметры см. в разделе настроек для нужного источника или приемника данных. Идентификатор эндпоинта можно получить со [списком эндпоинтов в каталоге](#list).

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с описанием эндпоинта.

     О том, как создать такой файл, см. в подразделе [Создать эндпоинт](#create).
  1. Измените значение поля `name` (имя эндпоинта) и параметры эндпоинта в блоке `settings`.
  1. Проверьте корректность настроек.

     1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
     1. Выполните команду:
     
        ```bash
        terraform validate
        ```
     
        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Подтвердите изменение ресурсов.

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

    Подробнее см. в [документации провайдера Terraform](../../../terraform/resources/datatransfer_endpoint.md).

- API {#api}

  {% note info %}

  Изменение эндпоинта с помощью API поддерживается только для источников и приемников типа ClickHouse®, Apache Kafka®, MongoDB, MySQL® и PostgreSQL.

  {% endnote %}

  Воспользуйтесь методом API [update](../../api-ref/Endpoint/update.md) и передайте в запросе:
  * Идентификатор эндпоинта в параметре `endpointId`
  * Имя эндпоинта в параметре `name`.
  * Описание эндпоинта в параметре `description`.
  * Параметры эндпоинта в параметре `settings`.

  Идентификатор эндпоинта можно получить со [списком эндпоинтов в каталоге](#list).

{% endlist %}

Изменение настроек эндпоинта для трансфера с типом **Репликация** в статусе **Реплицируется** приведет к перезапуску трансфера.

## Клонировать эндпоинт {#clone}

{% note info %}

При клонировании нельзя изменить тип эндпоинта и тип БД.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога](https://console.yandex.cloud).
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Data Transfer**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/aperture.svg) **Эндпоинты**.
  1. Выберите эндпоинт, который нужно клонировать.
  1. Нажмите кнопку **Клонировать** на панели сверху.
  1. Задайте имя нового эндпоинта и при необходимости отредактируйте остальные параметры:

     * Источники:
      
         * Airbyte®:
             * [AWS CloudTrail](source/aws-cloudtrail.md)
             * [BigQuery](source/bigquery.md)
             * [MS SQL Server](source/mssql.md)
             * [S3](source/s3.md)
         * [Apache Kafka®](source/kafka.md)
         * [ClickHouse®](source/clickhouse.md)
         * [Greenplum®](source/greenplum.md)
         * [Яндекс Метрика](source/metrika.md)
         * [MongoDB](source/mongodb.md)
         * [MySQL®](source/mysql.md)
         * [Object Storage](source/object-storage.md)
         * [Oracle](source/oracle.md)
         * [PostgreSQL](source/postgresql.md)
         * [Yandex Data Streams](source/data-streams.md)
         * [Yandex Managed Service for YDB](source/ydb.md)
         * [YTsaurus](target/yt.md)
     * Приемники:
         * [Apache Kafka®](target/kafka.md)
         * [ClickHouse®](target/clickhouse.md)
         * [Greenplum®](target/greenplum.md)
         * [MongoDB](target/mongodb.md)
         * [MySQL®](target/mysql.md)
         * [Object Storage](target/object-storage.md)
         * [OpenSearch](target/opensearch.md)
         * [PostgreSQL](target/postgresql.md)
         * [Yandex Data Streams](target/data-streams.md)
         * [Yandex Managed Service for YDB](target/yandex-database.md)
         * YTsaurus:
             * [YTSaurus Dynamic](target/yt.md)
             * [YTSaurus Static](target/yt.md)

  1. Нажмите кнопку **Создать эндпоинт**.

{% endlist %}

## Удалить эндпоинт {#delete}

{% note warning %}

Перед удалением эндпоинта [удалите](../transfer.md#delete) все трансферы, в которые он входит.

{% endnote %}

Чтобы удалить эндпоинт:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога](https://console.yandex.cloud).
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Data Transfer**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/aperture.svg) **Эндпоинты**.
  1. Выберите эндпоинт, который нужно удалить.
  1. Нажмите кнопку **Удалить** на панели сверху.
  1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы удалить эндпоинт, выполните команду:

  ```bash
  yc datatransfer endpoint delete <идентификатор_эндпоинта>
  ```

  Идентификатор эндпоинта можно получить со [списком эндпоинтов в каталоге](#list).

- Terraform {#tf}

  Чтобы удалить эндпоинт, созданный с помощью Terraform:
  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.
  
     О том, как создать такой файл, см. в разделе [Создать эндпоинт](index.md#create).
  1. Убедитесь, что удаляемый эндпоинт не привязан ни к какому трансферу.
  1. Удалите описание эндпоинта.
  1. Проверьте корректность настроек.
  
     1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
     1. Выполните команду:
     
        ```bash
        terraform validate
        ```
     
        Если в файлах конфигурации есть ошибки, Terraform на них укажет.
  
  1. Введите слово `yes` и нажмите **Enter**.
  
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
  
  Подробнее см. в [документации провайдера Terraform](../../../terraform/resources/datatransfer_endpoint.md).

- API {#api}

  Воспользуйтесь методом API [delete](../../api-ref/Endpoint/delete.md) и передайте идентификатор нужного эндпоинта в параметре `endpointId` запроса.

  Идентификатор эндпоинта можно получить со [списком эндпоинтов в каталоге](#list).

{% endlist %}

_Greenplum® и Greenplum Database® являются зарегистрированными товарными знаками или товарными знаками Broadcom Inc в США и/или других странах._

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._