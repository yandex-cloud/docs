[Документация Yandex Cloud](../../index.md) > [Yandex Message Queue](../index.md) > Начало работы > Поддерживаемые инструменты

# Инструменты для работы с Yandex Message Queue

Для использования [API](../../glossary/rest-api.md) подходят все инструменты, совместимые с Amazon SQS: AWS CLI, Boto3 и другие [поддерживаемые SDK](https://aws.amazon.com/ru/tools/#sdk).

## Прочие SDK {#sdk}

* [Клиент ЯндексMQ для 1С:Предприятие 8](https://github.com/leemuar/yandexmq-sdk-1c). Поддерживается сторонними разработчиками.

## Подготовка к работе {#preparations}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md).
1. [Назначьте сервисному аккаунту роли](../../iam/operations/sa/assign-role-for-sa.md), необходимые для вашего проекта. Подробнее о ролях читайте в [документации Identity and Access Management](../../iam/concepts/access-control/roles.md).
1. [Создайте статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key).


При настройке инструментов используйте следующие параметры:

* в качестве `AWS_ACCESS_KEY_ID` используйте идентификатор статического ключа
* в качестве `AWS_SECRET_ACCESS_KEY` используйте секретный ключ
* в качестве региона используйте значение `ru-central1`
* в качестве endpoint используйте `https://message-queue.api.cloud.yandex.net`