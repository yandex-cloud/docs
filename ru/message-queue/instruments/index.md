---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Инструменты для работы с Yandex Message Queue

Для использования API подходят все инструменты, совместимые с Amazon SQS: AWS CLI, Boto3 и другие [поддерживаемые SDK](https://aws.amazon.com/ru/tools/#sdk).

## Подготовка к работе {#preparations}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

При настройке инструментов используйте следующие параметры:

* в качестве `AWS_ACCESS_KEY_ID` используйте идентификатор статического ключа
* в качестве `AWS_SECRET_ACCESS_KEY` используйте секретный ключ
* в качестве региона используйте значение `ru-central1`
* в качестве endpoint используйте `https://message-queue.api.cloud.yandex.net`

