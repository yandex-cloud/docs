# Использование AWS CLI и AWS SDK для работы с базой через Document API

В режиме совместимости с AWS DynamoDB возможно использовать инструменты от AWS такие, как:

* [AWS CLI](https://aws.amazon.com/ru/cli/) - интерфейс командной строки AWS;
* [AWS SDK](https://aws.amazon.com/ru/tools/#sdk) - инструменты для разработки.

## Подготовка к работе

Для корректной работы инструментов AWS необходимо настроить ряд параметров, таких как:
* [```aws_access_key_id```](https://docs.aws.amazon.com/credref/latest/refdocs/setting-global-aws_access_key_id.html);
* [```aws_secret_access_key```](https://docs.aws.amazon.com/credref/latest/refdocs/setting-global-aws_secret_access_key.html);
* [```region```](https://docs.aws.amazon.com/credref/latest/refdocs/setting-global-region.html).

В этом разделе приведена инструкция по получению и настройке этих параметров.

1. Для работы необходимо создать сервисный аккаунт, от имени которого будет вестись работа с базой. Сервисный аккаунт должен быть создан в том же каталоге, в котором располагается база данных. Следуйте [инструкции по созданию сервисного аккаунта](https://cloud.yandex.ru/docs/iam/operations/sa/create);
1. Cервисному аккаунту должна быть быть назначена роль ```editor```. Следуйте [инструкции по назначению роли сервисному аккаунту](https://cloud.yandex.ru/docs/iam/operations/sa/assign-role-for-sa);
1. Необходимо получить статические ключи доступа, а именно ```aws_access_key_id``` и ```aws_secret_access_key```. Надежно сохраните значения! Следуйте [инструкции создания статических ключей доступа](https://cloud.yandex.ru/docs/iam/operations/sa/create-access-key).

Установите [AWS CLI](https://aws.amazon.com/ru/cli/). Существует несколько способов настроить [окружение](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html). Одним из самых простых является является запуск ```aws configure``` (задайте в качестве ключей значения полученные выше, для региона используйте ```ru-central1```):
```
$ aws configure
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Default region name [None]: ru-central1
Default output format [None]:
```
В результате будут созданы файлы ```~/.aws/credentials``` и ```~/.aws/config``` (```C:\Users\USERNAME\.aws\credentials``` и ```C:\Users\USERNAME\.aws\config``` в Windows). Проверьте корректность настройки запустив команду листинга таблиц в базе. В качестве значения ```--endpoint``` укажите Document API эндпоинт, доступный на вкладке Обзор вашей базы данных в косоли.

```
$ aws dynamodb list-tables --endpoint https://docapi.serverless.yandexcloud.net/ru-central1/b1g4ej5ju4rf5kelpk4b/etn03ubijq52j860kvgj
{
    "TableNames": [
    ]
}
```
