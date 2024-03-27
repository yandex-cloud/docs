# Инструменты для работы с {{ message-queue-full-name }}

{% note warning %}

В данный момент отсутствует поддержка новых версий `AWS CLI` и `AWS SDK` с протоколом JSON. Используйте [AWS CLI и AWS SDK](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-json-faqs.html#json-protocol-getting-started) до введения поддержки протокола JSON.

{% endnote %}

Для использования [API](../../glossary/rest-api.md)  подходят все инструменты, совместимые с Amazon SQS: AWS CLI, Boto3 (до версии 1.28.0) и другие [поддерживаемые SDK](https://aws.amazon.com/ru/tools/#sdk).

## Подготовка к работе {#preparations}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

При настройке инструментов используйте следующие параметры:

* в качестве `AWS_ACCESS_KEY_ID` используйте идентификатор статического ключа
* в качестве `AWS_SECRET_ACCESS_KEY` используйте секретный ключ
* в качестве региона используйте значение `{{ region-id }}`
* в качестве endpoint используйте `https://message-queue.{{ api-host }}`

