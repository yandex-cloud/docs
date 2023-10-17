---
sourcePath: overlay/quickstart/document-api/aws-setup.md
---
# Настройка инструментов AWS

Для работы с БД через Document API в режиме совместимости с AWS DynamoDB вы можете использовать инструменты AWS:

* [AWS CLI](https://aws.amazon.com/ru/cli/) — интерфейс командной строки AWS.
* [AWS SDK](https://aws.amazon.com/ru/tools/#sdk) — инструменты для разработки.

{% include [doc-tables-only.md](../../_includes/doc-tables-only.md) %}

Для работы инструментов AWS выполните следующие настройки:

1. Создайте сервисный аккаунт, от имени которого вы будете работать с базой.

    Сервисный аккаунт должен быть создан в том же каталоге, в котором располагается база данных.

    {% list tabs %}

    - Консоль управления

      {% include [create-sa-via-console](../../../_includes/iam/create-sa-via-console.md) %}

    - CLI

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      1. Посмотрите описание команды создания сервисного аккаунта:

          ```bash
          yc iam service-account create --help
          ```

      1. Создайте сервисный аккаунт с именем `my-robot`:

          ```bash
          yc iam service-account create --name my-robot
          ```

          Требования к имени сервисного аккаунта:

          {% include [name-format](../../../_includes/name-format.md) %}

    - API

      Чтобы создать сервисный аккаунт, воспользуйтесь методом [create](../../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../../iam/api-ref/ServiceAccount/index.md).

    {% endlist %}

1. Назначьте сервисному аккаунту роль `editor`.

    {% include [grant-role-for-sa](../../../_includes/iam/grant-role-for-sa.md) %}

1. Получите идентификатор ключа и ключ доступа созданного сервисного аккаунта:

    {% list tabs %}

    - Консоль управления

      1. Перейдите в каталог, которому принадлежит сервисный аккаунт.
      1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
      1. Выберите сервисный аккаунт и нажмите на строку с его именем.
      1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** на верхней панели.
      1. Выберите пункт **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
      1. Задайте описание ключа, чтобы потом было проще найти его в консоли управления.
      1. Сохраните идентификатор и секретный ключ.

          {% note alert %}

          После закрытия диалога значение ключа будет недоступно.

          {% endnote %}

    - CLI

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      1. Посмотрите описание команды создания статического ключа доступа:

          ```bash
          yc iam access-key create --help
          ```

      1. Выберите сервисный аккаунт, например `my-robot`:

          ```bash
          yc iam service-account list
          +----------------------+------------------+-------------------------------+
          |          ID          |       NAME       |          DESCRIPTION          |
          +----------------------+------------------+-------------------------------+
          | aje6o61dvog2******** | my-robot         |                               |
          ...
          ```

      1. Создайте ключ доступа для сервисного аккаунта `my-robot`:

          ```bash
          yc iam access-key create --service-account-name my-robot
    
          access_key:
            id: aje6t3vsbj8l********
            service_account_id: ajepg0mjt06s********
            created_at: "2018-11-22T14:37:51Z"
            key_id: 0n8X6WY6S24N********
          secret: JyTRFdqw8t1kh2-OJNz4JX5ZTz9Dj1rI********
          ```

      1. Сохраните идентификатор `key_id` и секретный ключ `secret`. Получить значение ключа снова будет невозможно.

    - API

      Чтобы создать ключ доступа, воспользуйтесь методом [create](../../../iam/api-ref/AccessKey/create.md) для ресурса [AccessKey](../../../iam/api-ref/AccessKey/index.md).

    {% endlist %}

1. Установите [AWS CLI](https://aws.amazon.com/ru/cli/).
1. Настройте окружение AWS CLI: Запустите команду `aws configure` и последовательно введите сохраненные ранее идентификатор ключа и секретный ключ. Для значения региона используйте `{{ region-id }}`:

    ```bash
    aws configure
    AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
    AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
    Default region name [None]: {{ region-id }}
    Default output format [None]:
    ```

    В результате будут созданы файлы `~/.aws/credentials` и `~/.aws/config` (`C:\Users\USERNAME\.aws\credentials` и `C:\Users\USERNAME\.aws\config` в Windows).
1. Проверьте корректность настройки, запустив команду листинга таблиц в [созданной](../../operations/manage-databases.md) ранее БД. В качестве значения `--endpoint` укажите Document API эндпоинт, доступный на вкладке **{{ ui-key.yacloud.ydb.database.switch_overview }}** вашей базы данных в [консоли управления]({{ link-console-main }}).

    ```bash
    aws dynamodb list-tables \
    --endpoint {{ ydb.aws-ep }}
    ```

    Результат:

    ```text
    {
        "TableNames": [
        ]
    }
    ```
