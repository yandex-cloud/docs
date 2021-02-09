# Настройка AWS CLI и AWS SDK

Для работы с базой через Document API в режиме совместимости с AWS DynamoDB вы можете использовать инструменты от AWS:
* [AWS CLI](https://aws.amazon.com/ru/cli/) — интерфейс командной строки AWS.
* [AWS SDK](https://aws.amazon.com/ru/tools/#sdk) — инструменты для разработки. 
 
Для корректной работы инструментов AWS необходимо настроить следующие параметры:
* [aws_access_key_id](https://docs.aws.amazon.com/credref/latest/refdocs/setting-global-aws_access_key_id.html);
* [aws_secret_access_key](https://docs.aws.amazon.com/credref/latest/refdocs/setting-global-aws_secret_access_key.html);
* [region](https://docs.aws.amazon.com/credref/latest/refdocs/setting-global-region.html).

## Настройка окружения {#setup}

1. Создайте сервисный аккаунт, от имени которого вы будете работать с базой.

    Сервисный аккаунт должен быть создан в том же каталоге, в котором располагается база данных.
    
    {% list tabs %}
    
    - Консоль управления
    
      {% include [create-sa-via-console](../../../_includes/iam/create-sa-via-console.md) %}
    
    - CLI
    
      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
      1. Посмотрите описание команды создания сервисного аккаунта:
    
          ```
          $ yc iam service-account create --help
          ```
    
      2. Создайте сервисный аккаунт с именем `my-robot`:
    
          ```
          $ yc iam service-account create --name my-robot
          ```
    
          {% include [name-format](../../../_includes/name-format.md) %}
    
    - API
    
      Чтобы создать сервисный аккаунт, воспользуйтесь методом [create](../../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../../iam/api-ref/ServiceAccount/index.md).
    
    {% endlist %}
    
1. Назначьте сервисному аккаунту роль `editor`.
    
    {% include [grant-role-for-sa](../../../_includes/iam/grant-role-for-sa.md) %}
    
1. Получите статические ключи доступа `aws_access_key_id` и `aws_secret_access_key`.

    {% list tabs %}
    
    - Консоль управления
    
      1. Перейдите в каталог, которому принадлежит сервисный аккаунт.
      1. Выберите вкладку **Сервисные аккаунты**.
      1. Выберите сервисный аккаунт и нажмите на строку с его именем.
      1. Нажмите кнопку **Создать новый ключ** на верхней панели.
      1. Выберите пункт **Создать ключ доступа**.
      1. Задайте описание ключа, чтобы потом было проще найти его в консоли управления.
      1. Сохраните идентификатор и секретный ключ.
    
          {% note alert %}
    
          После закрытия диалога значение ключа будет недоступно.
    
          {% endnote %}
    
    - CLI
    
      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
      1. Посмотрите описание команды создания статического ключа доступа:
    
          ```
          $ yc iam access-key create --help
          ```
    
      1. Выберите сервисный аккаунт, например `my-robot`:
    
          ```
          $ yc iam service-account list
          +----------------------+------------------+-------------------------------+
          |          ID          |       NAME       |          DESCRIPTION          |
          +----------------------+------------------+-------------------------------+
          | aje6o61dvog2h6g9a33s | my-robot         |                               |
          | aje9sda1ufvqcmfksd3f | blabla           | bla bla bla is my description |
          +----------------------+------------------+-------------------------------+
          ```
      1. Создайте ключ доступа для сервисного аккаунта `my-robot`:
    
          ```
          $ yc iam access-key create --service-account-name my-robot
    
          access_key:
            id: aje6t3vsbj8lp9r4vk2u
            service_account_id: ajepg0mjt06siuj65usm
            created_at: "2018-11-22T14:37:51Z"
            key_id: 0n8X6WY6S24N7OjXQ0YQ
          secret: JyTRFdqw8t1kh2-OJNz4JX5ZTz9Dj1rI9hxtzMP1
          ```
      1. Сохраните идентификатор `key_id` и секретный ключ `secret`. Получить значение ключа снова будет невозможно.
    
    - API
    
      Чтобы создать ключ доступа, воспользуйтесь методом [create](../../../iam/api-ref/AccessKey/create.md) для ресурса [AccessKey](../../../iam/api-ref/AccessKey/index.md).
    
    {% endlist %}
     
1. Установите [AWS CLI](https://aws.amazon.com/ru/cli/). 
1. Настройте [окружение](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html). Один из самых простых способов настройки — запуск `aws configure`. В качестве ключей используйте значения, полученные выше. Для региона используйте `ru-central1`:

    ```
    $ aws configure
    AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
    AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
    Default region name [None]: ru-central1
    Default output format [None]:
    ```
    
    В результате будут созданы файлы `~/.aws/credentials` и `~/.aws/config` (`C:\Users\USERNAME\.aws\credentials` и `C:\Users\USERNAME\.aws\config` в Windows). 
1. Проверьте корректность настройки, запустив команду листинга таблиц в базе. В качестве значения `--endpoint` укажите Document API эндпоинт, доступный на вкладке **Обзор** вашей базы данных в [консоли управления]({{ link-console-main }}).

    ```
    $ aws dynamodb list-tables --endpoint https://docapi.serverless.yandexcloud.net/ru-central1/b1g4ej5ju4rf5kelpk4b/etn03ubijq52j860kvgj
    {
        "TableNames": [
        ]
    }
    ```