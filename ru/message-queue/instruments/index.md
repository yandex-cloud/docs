# Инструменты для работы с {{ message-queue-full-name }}

Для использования {% if lang == "ru" and audience != "internal" %}[API](../../glossary/rest-api.md){% else %}API{% endif %} подходят все инструменты, совместимые с Amazon SQS: AWS CLI, Boto3 и другие [поддерживаемые SDK]{% if lang == "ru" %}(https://aws.amazon.com/ru/tools/#sdk){% endif %}{% if lang == "en" %}(https://aws.amazon.com/tools/#sdk){% endif %}.

## Подготовка к работе {#preparations}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

При настройке инструментов используйте следующие параметры:

* в качестве `AWS_ACCESS_KEY_ID` используйте идентификатор статического ключа
* в качестве `AWS_SECRET_ACCESS_KEY` используйте секретный ключ
* в качестве региона используйте значение `{{ region-id }}`
* в качестве endpoint используйте `https://message-queue.{{ api-host }}`

