# Настройка эндпоинта-источника AWS CloudTrail

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта задайте настройки доступа к AWS. Подробное описание см. в [документации Airbyte®](https://docs.airbyte.com/integrations/sources/aws-cloudtrail).

## Настройки {#settings}

{% list tabs %}

- Консоль управления

    * **Key ID** и **Secret Key** — укажите [идентификатор и содержимое ключа AWS](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-appendix-sign-up.html).
    * **Region Name** — укажите название [региона](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-installing-specifying-region.html) AWS.

{% endlist %}

## Дополнительные настройки {#additional-settings}

{% list tabs %}

- Консоль управления

    * **Start Date** — дата в формате `YYYY-MM-DD`. Записи журнала за эту дату и последующие будут перенесены на приемник. Если значение не указано, будут скопированы записи журнала за максимальный период в 90 дней.

{% endlist %}

{% include [airbyte-trademark](../../../../_includes/data-transfer/airbyte-trademark.md) %}
