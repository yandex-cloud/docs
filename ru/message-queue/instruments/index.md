# Инструменты для работы с {{ message-queue-full-name }}

Для использования [API](../../glossary/rest-api.md) подходят все инструменты, совместимые с Amazon SQS: AWS CLI, Boto3 и другие [поддерживаемые SDK](https://aws.amazon.com/ru/tools/#sdk).

## Подготовка к работе {#preparations}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md).
1. [Назначьте сервисному аккаунту роли](../../iam/operations/sa/assign-role-for-sa.md), необходимые для вашего проекта. Подробнее о ролях см. в [документации {{ iam-name }}](../../iam/concepts/access-control/roles.md).
1. [Создайте статический ключ доступа](../../iam/operations/sa/create-access-key.md).


При настройке инструментов используйте следующие параметры:

* в качестве `AWS_ACCESS_KEY_ID` используйте идентификатор статического ключа
* в качестве `AWS_SECRET_ACCESS_KEY` используйте секретный ключ
* в качестве региона используйте значение `{{ region-id }}`
* в качестве endpoint используйте `https://message-queue.{{ api-host }}`

