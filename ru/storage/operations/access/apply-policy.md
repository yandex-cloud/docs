# Применение политики доступа

Вы можете применить политику с помощью SDK или консольного клиента (например, [AWS CLI](../../tools/aws-cli.md)).

{% note info %}

Для применения политики с помощью AWS CLI сервисному аккаунту должна быть назначена роль `storage.admin`.

{% endnote %}

## Применить политику {#apply-policy}

Чтобы применить политику доступа к бакету:

{% list tabs %}

- AWS CLI

  1. Опишите конфигурацию политики доступа в виде [схемы данных](../../s3/api-ref/policy/scheme.md) формата JSON. Например:

     ```json
     {
       "Version": "2012-10-17",
       "Statement": {
         "Effect": "Allow",
         "Principal": "*",
         "Action": "s3:GetObject",
         "Resource": "arn:aws:s3:::<имя-бакета>/*",
         "Condition": {
           "Bool": {
             "aws:SecureTransport": "true"
           }
         }
       }
     }
     ```

     Сохраните готовую конфигурацию в файле `policy.json`.

  1. Выполните команду:

     ```bash
     aws --endpoint https://storage.yandexcloud.net s3api put-bucket-policy \
       --bucket <имя-бакета> \
       --policy file://policy.json
     ```

- API

  Воспользуйтесь методом [PutBucketPolicy](../../s3/api-ref/policy/put.md).

{% endlist %}

## Просмотреть политику {#get-policy}

Чтобы просмотреть примененную к бакету политику доступа:

{% list tabs %}

- AWS CLI

  Выполните команду:

  ```bash
  aws --endpoint https://storage.yandexcloud.net s3api get-bucket-policy \
    --bucket <имя-бакета> \
    --output text | jq .
  ```

  Результат выполнения команды:

  ```json
  {
    "Version": "2012-10-17",
    "Statement": {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::<имя-бакета>/*",
      "Condition": {
        "Bool": {
          "aws:SecureTransport": "true"
        }
      }
    }
  }
  ```

- API

  Воспользуйтесь методом [GetBucketPolicy](../../s3/api-ref/policy/get.md).

{% endlist %}

## Удалить политику {#delete-policy}

Чтобы удалить политику доступа:

{% list tabs %}

- AWS CLI

  Выполните команду:

  ```bash
  aws --endpoint https://storage.yandexcloud.net s3api delete-bucket-policy \
    --bucket <имя-бакета>
  ```

- API

  Воспользуйтесь методом [DeleteBucketPolicy](../../s3/api-ref/policy/delete.md).

{% endlist %}