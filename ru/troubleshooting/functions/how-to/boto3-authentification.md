# Как настроить аутентификацию для `boto3`


## Описание сценария {#case-description}

* Необходимо создать облачную функцию, которая будет записывать результат своей работы в AWS-совместимое хранилище данных;
* Необходимо понять, каким образом можно аутентифицироваться и авторизоваться в этих сервисах из кода облачной функции с использованием библиотек `boto3`.

## Решение {#case-resolution}

Для работы с AWS-совместимыми сервисами необходимо использовать [статические ключи доступа](../../../iam/concepts/authorization/access-key.md).

{% note info %}

К AWS-совместимым сервисам относятся:
* [{{  yds-full-name }}](https://yandex.cloud/ru/docs/data-streams/);
* [{{ objstorage-full-name }}](https://yandex.cloud/ru/docs/storage/); 
* [{{ message-queue-full-name }}](https://yandex.cloud/ru/docs/message-queue/); 
* [{{ ydb-full-name }}](https://yandex.cloud/ru/docs/ydb/).

{% endnote %}

В метаданных не хранятся AWS-ключи, только IAM-токен. Поэтому понадобится использовать либо [переменные окружения](../../../functions/operations/function/environment-variables-add.md), в которые явно заносить ключ и его секрет, либо предусмотреть [интеграцию с {{ lockbox-short-name }}](../../../lockbox/operations/serverless/functions.md).

Пример кода настройки boto3 для работы с S3 через переменные окружения:

```python
import os, boto3


s3 = boto3.client('s3',
    endpoint_url            = 'https://storage.yandexcloud.net',
    aws_access_key_id       = os.environ['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key   = os.environ['AWS_SECRET_ACCESS_KEY'],
    region_name             = os.environ['AWS_DEFAULT_REGION']
)

def handler(event, context):
    return s3.list_buckets()['Buckets']
```