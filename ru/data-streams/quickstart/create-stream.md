# Создание потока данных

В этом разделе вы узнаете, как создать [поток данных](../concepts/glossary.md#stream-concepts).

## Создайте поток

{% list tabs %}

- Консоль управления

  {% include [create-stream-via-console](../../_includes/data-streams/create-stream-via-console.md) %}

{% endlist %}

## Получите идентификатор потока и эндпоинт для протокола AWS Kinesis Data Streams {#kinesis}

{{yds-full-name}} поддерживает протокол AWS Kinesis Data Streams. Для поставки данных по этому протоколу из внешних систем необходимо указать идентификатор потока и эндпоинт.

Чтобы получить идентификатор потока и эндпоинт для протокола AWS Kinesis Data Streams:

{% include [aws-stream](../../_includes/data-streams/aws-stream.md) %}

Сохраните скопированные значения, они понадобятся на следующих шагах.