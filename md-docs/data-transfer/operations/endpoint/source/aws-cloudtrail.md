[Документация Yandex Cloud](../../../../index.md) > [Yandex Data Transfer](../../../index.md) > [Пошаговые инструкции](../../index.md) > [Настройка эндпоинтов](../index.md) > AWS CloudTrail > Источник

# Передача данных из эндпоинта-источника AWS CloudTrail

С помощью сервиса Yandex Data Transfer вы можете выгружать аудитные логи из базы AWS CloudTrail в управляемые базы данных Yandex Cloud и реализовывать различные сценарии обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Подготовьте базу данных AWS CloudTrail](#prepare) к трансферу.
1. [Настройте эндпоинт-источник](#endpoint-settings) в Yandex Data Transfer.
1. [Настройте один из поддерживаемых приемников данных](#supported-targets).
1. [Cоздайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. При возникновении проблем, [воспользуйтесь готовыми решениями](../../../troubleshooting/index.md) по их устранению.

## Сценарии передачи данных из AWS CloudTrail {#scenarios}

Вы можете выгружать логи в различные базы данных для дальнейшего хранения в облаке, обработки и загрузки в витрины данных с целью последующей визуализации.

Подробное описание возможных сценариев передачи данных в Yandex Data Transfer читайте в разделе [Практические руководства](../../../tutorials/index.md).

## Подготовка базы данных AWS CloudTrail {#prepare}

Получите идентификатор ключа и секретный ключ доступа AWS, следуя [инструкции AWS](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-appendix-sign-up.html).

Подробнее в [документации Airbyte®](https://docs.airbyte.com/integrations/sources/aws-cloudtrail/).

## Настройка эндпоинта-источника AWS CloudTrail {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта задайте настройки доступа к AWS. Подробное описание в [документации Airbyte®](https://docs.airbyte.com/integrations/sources/aws-cloudtrail).

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **Идентификатор ключа** и **Ключ секрета** — укажите [идентификатор и содержимое ключа AWS](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-appendix-sign-up.html).
    * **Имя региона** — укажите название [региона](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-installing-specifying-region.html) AWS.
    * **Начальная дата** — дата в формате `ГГГГ-ММ-ДД`. Записи журнала за эту дату и последующие будут перенесены на приемник. Если значение не указано, будут скопированы записи журнала за максимальный период в 90 дней.

{% endlist %}

## Настройка приемника данных {#supported-targets}

Настройте один из поддерживаемых приемников данных:

* [MySQL®](../target/mysql.md);
* [MongoDB](../target/mongodb.md);
* [ClickHouse®](../target/clickhouse.md);
* [Greenplum®](../target/greenplum.md);
* [Yandex Managed Service for YDB](../target/yandex-database.md);
* [Apache Kafka®](../target/kafka.md);
* [YDS](../target/data-streams.md);
* [PostgreSQL](../target/postgresql.md).

Полный список поддерживаемых источников и приемников в Yandex Data Transfer читайте в разделе [Доступные трансферы](../../../transfer-matrix.md).

Убедитесь, что настройки сети, в которой размещен кластер-приемник, разрешают подключение к интернету. Чтобы открыть доступ в интернет, [настройте маршрутизацию](../../../../vpc/tutorials/nat-instance/index.md).

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).

_Airbyte® является зарегистрированным товарным знаком Airbyte, Inc в США и/или других странах._