# Создание документных таблиц в базе данных

{% note warning %}

Функциональность создания документных таблиц поддерживается только в [бессерверном режиме](../concepts/serverless-and-dedicated.md#serverless) работы базы данных {{ ydb-full-name }}.

{% endnote %}

Документные таблицы {{ ydb-full-name }} содержат данные в виде набора элементов и совместимы с таблицами [Amazon DynamoDB](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.CoreComponents.html#HowItWorks.CoreComponents.TablesItemsAttributes). Поэтому для создания документных таблиц {{ ydb-full-name }} используется провайдер AWS для {{ TF }} и ресурс `aws_dynamodb_table`.

Для создания документной таблицы с помощью провайдера AWS потребуется:
* Сервисный аккаунт с [ролью](../security/index.md#ydb-editor) не ниже `ydb.editor`.
* [Статический ключ доступа](../../iam/concepts/authorization/access-key.md). 

Вначале необходимо настроить провайдер AWS в файле проекта:

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "aws" {
  region = "{{ region-id }}"
  endpoints {
    dynamodb = "{{ ydb.document-api-endpoint }}/{{ region-id }}/<cloud_id>/<ydb_database_id>"
  }
  profile = "<profile_name>"
  skip_credentials_validation = true
  skip_metadata_api_check = true
  skip_region_validation = true
  skip_requesting_account_id = true
}
```

Аргументы провайдера `aws`:
* `region` — регион размещения ресурса. Имеет неизменное значение `{{ region-id }}`.
* `endpoints.dynamodb` — Document API эндпоинт базы данных. Адрес эндпоинта указан в консоли управления: {{ ydb-full-name }} → раздел **Обзор** → секция **Соединение** → параметр **Document API эндпоинт**.
* `profile` — название секции в файле `~/.aws/credentials`, содержащей `aws_access_key_id` (идентификатор статического ключа доступа) и `aws_secret_access_key` (содержимое секретного ключа).
* `skip_credentials_validation` — пропуск проверки учетных данных через STS (Amazon Web Services Security Token Service) API. Будет пропущена проверка токенов.
* `skip_metadata_api_check` — пропуск проверки аутентификации {{ TF }} через API метаданных AWS.
* `skip_region_validation` — пропуск проверки указанного названия региона.
* `skip_requesting_account_id` — пропуск запроса идентификатора аккаунта.

Указанный набор параметров `skip_` обязателен, так как он обеспечивает совместимость API запросов провайдера AWS к {{ yandex-cloud }}.   

Затем можно указать ресурс `aws_dynamodb_table` для создания документной таблицы:

```hcl
resource "aws_dynamodb_table" "test" {
  name         = "<table_name>"
  billing_mode = "PAY_PER_REQUEST"

  hash_key  = "<attribute_name_1>"
  range_key = "<attribute_name_2>"

  attribute {
    name = "<attribute_name_1>"
    type = "<attribute_type>"
  }

  attribute {
    name = "<attribute_name_2>"
    type = "<attribute_type>"
  }
}
```

Аргументы ресурса `aws_dynamodb_table`:
* `name` — название таблицы. Таблица может быть размещена в иерархическом пространстве имен внутри {{ ydb-short-name }}. Например, чтобы поместить таблицу в директорию `my-test-doctable` относительно корня базы, нужно задать следующий путь: `my-test-doctable/table-name`. Если директория не существует, то она будет создана автоматически.
* `billing_mode` — модель расчета платы за операции чтения и записи. Поддерживается только модель `PAY_PER_REQUEST`.
* `hash_key` — атрибут, который будет использоваться как ключ хеширования. Определяется в блоке `attribute`.
* `range_key` — атрибут, который будет использоваться как ключ диапазона (сортировки). Определяется в блоке `attribute`.
* `attribute` — блок с набором вложенных определений атрибутов. Состоит из полей `name` (название атрибута) и `type` (тип данных атрибута): `S` — строка, `N` — число.

При первом запуске сценария необходимо выполнить команду `terraform init` для инициализации провайдера AWS. Далее можно выполнять команды `terraform plan` и `terraform apply`. В результате выполнения команд будет создана документная таблица с названием, указанным в параметре `name`.