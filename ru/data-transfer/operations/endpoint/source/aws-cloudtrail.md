# Передача данных из эндпоинта-источника AWS CloudTrail

С помощью сервиса {{ data-transfer-full-name }} вы можете выгружать аудитные логи из базы AWS CloudTrail в управляемые базы данных {{ yandex-cloud }} и реализовывать различные сценарии обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Подготовьте базу данных AWS CloudTrail](#prepare) к трансферу.
1. [Настройте эндпоинт-источник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Настройте один из поддерживаемых приемников данных](#supported-targets).
1. [Cоздайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. При возникновении проблем, [воспользуйтесь готовыми решениями](../../../../data-transfer/troubleshooting/index.md) по их устранению.

## Сценарии передачи данных из AWS CloudTrail {#scenarios}

Вы можете выгружать логи в различные базы данных для дальнейшего хранения в облаке, обработки и загрузки в витрины данных с целью последующей визуализации.

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} см. в разделе [Практические руководства](../../../tutorials/index.md).

## Подготовка базы данных AWS CloudTrail {#prepare}

{% include [prepare aws cloud trail db](../../../../_includes/data-transfer/endpoints/sources/aws-cloudtrail-prepare.md) %}

## Настройка эндпоинта-источника AWS CloudTrail {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта задайте настройки доступа к AWS. Подробное описание см. в [документации Airbyte®](https://docs.airbyte.com/integrations/sources/aws-cloudtrail).

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.aws_cloud_trail_source.endpoint.airbyte.aws_cloud_trail_source.AWSCloudTrailSource.aws_key_id.title }}** и **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.aws_cloud_trail_source.endpoint.airbyte.aws_cloud_trail_source.AWSCloudTrailSource.aws_secret_key.title }}** — укажите [идентификатор и содержимое ключа AWS](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-appendix-sign-up.html).
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.aws_cloud_trail_source.endpoint.airbyte.aws_cloud_trail_source.AWSCloudTrailSource.aws_region_name.title }}** — укажите название [региона](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-installing-specifying-region.html) AWS.
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.aws_cloud_trail_source.endpoint.airbyte.aws_cloud_trail_source.AWSCloudTrailSource.start_date.title }}** — дата в формате `ГГГГ-ММ-ДД`. Записи журнала за эту дату и последующие будут перенесены на приемник. Если значение не указано, будут скопированы записи журнала за максимальный период в 90 дней.

{% endlist %}

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

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).

{% include [airbyte-trademark](../../../../_includes/data-transfer/airbyte-trademark.md) %}