---
title: Передача данных из эндпоинта-источника Microsoft SQL Server
description: Следуя данной инструкции, вы сможете настроить передачу данных из эндпоинта-источника Microsoft SQL Server.
---

# Передача данных из эндпоинта-источника Microsoft SQL Server

С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные из базы данных Microsoft SQL Server в управляемые базы данных {{ yandex-cloud }} и реализовывать различные сценарии обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Подготовьте базу данных Microsoft SQL Server](#prepare) к трансферу.
1. [Настройте эндпоинт-источник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Настройте один из поддерживаемых приемников данных](#supported-targets).
1. [Cоздайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. При возникновении проблем, [воспользуйтесь готовыми решениями](../../../../data-transfer/troubleshooting/index.md) по их устранению.

## Сценарии передачи данных из Microsoft SQL Server {#scenarios}

Вы можете реализовывать сценарии миграции и поставки данных из базы данных Microsoft SQL Server в управляемые базы данных для дальнейшего хранения в облаке, обработки и загрузки в витрины данных с целью последующей визуализации.

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} см. в разделе [Практические руководства](../../../tutorials/index.md).

## Подготовка базы данных Microsoft SQL Server {#prepare}

{% include [prepare ms sql server db](../../../../_includes/data-transfer/endpoints/sources/ms-sqlserver-prepare.md) %}

## Настройка эндпоинта-источника Microsoft SQL Server {#endpoint-settings}

При [создании](../index.md#create) эндпоинта выберите тип базы данных `MSSQL` и задайте настройки доступа к {{ MS }}. Вы можете [изменить](../index.md#update) настройки после создания эндпоинта.

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.mssql_source.endpoint.airbyte.mssql_source.MSSQLSource.host.title }}** — IP-адрес или [FQDN](../../../../glossary/fqdn.md) хоста, к которому необходимо подключиться.
  
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.mssql_source.endpoint.airbyte.mssql_source.MSSQLSource.port.title }}** — номер порта, который сервис {{ data-transfer-name }} будет использовать для подключения к хосту. 

    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.mssql_source.endpoint.airbyte.mssql_source.MSSQLSource.database.title }}** — имя БД для подключения.

    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.mssql_source.endpoint.airbyte.mssql_source.MSSQLSource.username.title }}**, **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.mssql_source.endpoint.airbyte.mssql_source.MSSQLSource.password.title }}** — имя и пароль пользователя БД.
  
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.mssql_source.endpoint.airbyte.mssql_source.MSSQLSource.replication_method.title }}** — способ репликации, используемый для извлечения данных из базы данных. Репликация типа `STANDARD` не требует настройки на стороне БД, но не сможет отображать изменения данных. Репликация типа `CDC` позволяет обнаруживать вставки, обновления и удаления.
  
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.mssql_source.endpoint.airbyte.mssql_source.MSSQLSource.ssl_method.title }}** — метод шифрования, который используется при обмене данными с базой данных:
      
        * `UNENCRYPTED` — сохранение пароля в открытом текстовом виде;
      
        * `ENCRYPTER (trust cert)` — использование сертификата из достоверного источника;

        * `ENCRYPTER (verify cert)` — использование самоподписанного сертификата.
    
{% endlist %}

Подробнее о настройках см. в [документации {{ AB }}](https://docs.airbyte.com/integrations/sources/mssql/).


## Настройка приемника данных {#supported-targets}

Настройте один из поддерживаемых приемников данных:

* [{{ MY }}](../target/mysql.md);
* [{{ MG }}](../target/mongodb.md);
* [{{ CH }}](../target/clickhouse.md);
* [{{ GP }}](../target/greenplum.md);
* [{{ ydb-full-name }}](../target/yandex-database.md);
* [{{ KF }}](../target/kafka.md);
* [{{ DS }}](../target/data-streams.md);
* [{{ PG }}](../target/postgresql.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} см. в разделе [Доступные трансферы](../../../transfer-matrix.md).

{% include [Internet access](../../../../_includes/data-transfer/notes/internet-access.md) %}

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).

{% include [airbyte-trademark](../../../../_includes/data-transfer/airbyte-trademark.md) %}

{% include [clickhouse-disclaimer](../../../../_includes/clickhouse-disclaimer.md) %}

{% include [greenplum-trademark](../../../../_includes/mdb/mgp/trademark.md) %}
