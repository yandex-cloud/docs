# Политика доступа (bucket policy)

Политики доступа устанавливают права на действия с бакетами, объектами и группами объектов.

Политика срабатывает, когда пользователь делает запрос к какому-либо ресурсу. В результате срабатывания политики запрос либо выполняется, либо отклоняется.

Проверка доступа происходит на трех уровнях: проверки сервиса {{ iam-full-name }}, политика доступа и список разрешений ACL.

1. Если запрос прошел проверку IAM, к нему применяется проверка политики доступа.
1. Проверка правил политики доступа происходит в следующем порядке:
   1. Если запрос подошел хотя бы под одно из правил `Deny`, то доступ будет запрещен.
   1. Если запрос подошел хотя бы под одно из правил `Allow`, то доступ будет разрешен.
   1. Если запрос не подошел ни под одно из правил, то доступ будет запрещен.
1. Если запрос не прошел проверку IAM или политики доступа, то применяется проверка доступа через ACL объекта.

Политика доступа состоит из базовых элементов:
* Ресурс – бакет (`arn:aws:s3:::samplebucket`), объект в бакете (`arn:aws:s3:::samplebucket/some/key`), или префикс (`arn:aws:s3:::samplebucket/some/path/*`).
* Действие – набор операций над ресурсом, который будет запрещен или разрешен политикой. Подробнее читайте в разделе [Действия](../s3/api-ref/policy/actions.md).
* Результат – запрет или разрешение запрошенного действия. Сначала проверяется попадание запроса в фильтр с действием `Deny`, при совпадении запрос отклоняется и дальнейшие проверки не проводятся. При попадании в фильтр с действием `Allow` запрос разрешается. Если запрос не попал ни в один из фильтров, то запрос отклоняется.
* Принципал – получатель запрошенного разрешения политики. Это может быть пользователь {{ iam-short-name }}, федеративный пользователь, сервисный аккаунт или анонимный пользователь.
* Условие – определение случаев, когда действует политика. Подробнее читайте в разделе [Условия](../s3/api-ref/policy/conditions.md).

Для описания правил политик используется JSON-подобный язык.

Чтобы применить политику к бакету, см. [инструкцию](../operations/buckets/policy.md).

## Доступ к бакету через консоль управления {#console-access}

Если для бакета настроена политика доступа, то по умолчанию доступ к бакету через консоль управления {{ yandex-cloud }} запрещен. Чтобы разрешить доступ к бакету, нужно добавить в секцию `Statement` политики доступа правило, разрешающее любые запросы к ресурсам `<имя бакета>/*` и `<имя бакета>` через консоль управления.

Пример правила для конкретного пользователя {{ yandex-cloud }}:

{% if product == "yandex-cloud" %}

```json
{
  "Effect": "Allow",
  "Principal": {
    "CanonicalUser": "<идентификатор пользователя>"
  },
  "Action": "*",
  "Resource": [
    "arn:aws:s3:::<имя бакета>/*",
    "arn:aws:s3:::<имя бакета>"
  ],
  "Condition": {
    "StringLike": {
      "aws:referer": "https://console.cloud.yandex.*/folders/*/storage/buckets/your-bucket-name*"
    }
  }
}
```

{% endif %}

{% if product == "cloud-il" %}

```json
{
  "Effect": "Allow",
  "Principal": {
    "CanonicalUser": "<идентификатор пользователя>"
  },
  "Action": "*",
  "Resource": [
    "arn:aws:s3:::<имя бакета>/*",
    "arn:aws:s3:::<имя бакета>"
  ],
  "Condition": {
    "StringLike": {
      "aws:referer": "https://console.cloudil.co.il/folders/*/storage/buckets/your-bucket-name*"
    }
  }
}
```

{% endif %}

{% if audience != "internal" %}

Идентификатор пользователя можно получить по [инструкции](../../iam/operations/users/get.md) в документации {{ iam-full-name }}.

{% endif %}

## Примеры конфигурации {#config-examples}

* Политика, которая разрешает анонимному пользователю чтение объектов бакета `samplebucket` по зашифрованному подключению:

  ```json
  {
    "Id": "epd4limdp3dgec7enpq5",
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "f1qqoehl1q53l06kqurs",
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::<имя бакета>/*",
        "Condition": {
          "Bool": {
            "aws:SecureTransport": "true"
          }
        }
      }
    ]
  }
  ```

* Политика, которая разрешает скачивать объекты только из указанного диапазона IP-адресов:

  ```json
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::<имя бакета>/*",
        "Condition": {
          "IpAddress": {
            "aws:SourceIp": "100.101.102.128/30"
          }
        }
      }
    ]
  }
  ```

* Политика, которая запрещает скачивать объекты с указанного IP-адреса:

  ```json
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": "*",
        "Action": "*",
        "Resource": "arn:aws:s3:::<имя бакета>/*"
      },
      {
        "Effect": "Deny",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::<имя бакета>/*",
        "Condition": {
          "IpAddress": {
            "aws:SourceIp": "100.101.102.103"
          }
        }
      }
    ]
  }
  ```

* Политика дает разным пользователям полный доступ только к определенным папкам, каждому пользователю — к своей:

  ```json
  {
    "Version":"2012-10-17",
    "Statement":[
      {
        "Sid":"User1PermissionsResource",
        "Effect":"Allow",
        "Principal": {
          "CanonicalUser": "<идентификатор пользователя>"
        },
        "Action": "*",
        "Resource":["arn:aws:s3:::<имя бакета>/user1path/*"]
      },
      {
        "Sid":"User1PermissionsPrefix",
        "Effect":"Allow",
        "Principal": {
            "CanonicalUser": "<идентификатор пользователя>"
        },
        "Action": "s3:ListBucket",
        "Resource":["arn:aws:s3:::<имя бакета>"],
        "Condition": {
          "StringLike": {
            "s3:prefix": "user1path/*"
          }
        }
      },
      {
        "Sid":"User2PermissionsResource",
        "Effect":"Allow",
        "Principal": {
          "CanonicalUser": "<идентификатор пользователя>"
        },
        "Action": "*",
        "Resource":["arn:aws:s3:::<имя бакета>/user2path/*"]
      },
      {
        "Sid":"User2PermissionsPrefix",
        "Effect":"Allow",
        "Principal": {
          "CanonicalUser": "<идентификатор пользователя>"
        },
        "Action": "s3:ListBucket",
        "Resource":["arn:aws:s3:::<имя бакета>"],
        "Condition": {
          "StringLike": {
            "s3:prefix": "user2path/*"
          }
        }
      }
    ]
  }
  ```

* Политика дает каждому пользователю и сервисному аккаунту полный доступ к папке с названием, равным [идентификатору пользователя](../../iam/operations/users/get.md) или [сервисного аккаунта](../../iam/operations/sa/get-id.md):

  ```json
  {
    "Version":"2012-10-17",
    "Statement":[
      {
        "Sid": "OwnDirPermissions",
        "Effect": "Allow",
        "Principal": "*",
        "Action": "*",
        "Resource": ["arn:aws:s3:::<имя бакета>/${aws:userid}/*"]
      }
    ]
  }
  ```
