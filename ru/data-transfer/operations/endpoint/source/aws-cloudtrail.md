# Настройка эндпоинта-источника AWS CloudTrail

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта задайте настройки доступа к AWS. Подробное описание см. в [документации Airbyte®](https://docs.airbyte.com/integrations/sources/aws-cloudtrail).

## Настройки {#settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.aws_cloud_trail_source.endpoint.airbyte.aws_cloud_trail_source.AWSCloudTrailSource.aws_key_id.title }}** и **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.aws_cloud_trail_source.endpoint.airbyte.aws_cloud_trail_source.AWSCloudTrailSource.aws_secret_key.title }}** — укажите [идентификатор и содержимое ключа AWS](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-appendix-sign-up.html).
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.aws_cloud_trail_source.endpoint.airbyte.aws_cloud_trail_source.AWSCloudTrailSource.aws_region_name.title }}** — укажите название [региона](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-installing-specifying-region.html) AWS.
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.aws_cloud_trail_source.endpoint.airbyte.aws_cloud_trail_source.AWSCloudTrailSource.start_date.title }}** — дата в формате `ГГГГ-ММ-ДД`. Записи журнала за эту дату и последующие будут перенесены на приемник. Если значение не указано, будут скопированы записи журнала за максимальный период в 90 дней.

{% endlist %}

{% include [airbyte-trademark](../../../../_includes/data-transfer/airbyte-trademark.md) %}
