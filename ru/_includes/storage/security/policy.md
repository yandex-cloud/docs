# Политика доступа (bucket policy)

{% include [full-overview](./full-overview.md) %}

Политики доступа устанавливают права на действия с бакетами, объектами и группами объектов.

Политика срабатывает, когда пользователь делает запрос к какому-либо ресурсу. В результате срабатывания политики запрос либо выполняется, либо отклоняется.

[Открытие публичного доступа](../../../storage/operations/buckets/bucket-availability.md) к операциям с бакетом не отменяет ограничений, заданных в политиках доступа.

{% include [storage-note-empty-policy](../../../storage/_includes_service/storage-note-empty-policy.md) %}

Политику доступа можно настроить в консоли управления или описать в формате JSON по [специальной схеме](../../../storage/s3/api-ref/policy/scheme.md), чтобы передать через один из программных инструментов — {{ yandex-cloud }} CLI, AWS CLI, {{ TF }} или API. Подробнее об управлении политикой см. в [инструкции](../../../storage/operations/buckets/policy.md).

## Из чего состоит политика {#elements}

Политика доступа состоит из правил, а правило — из следующих базовых элементов:

Ресурс

: Бакет, объект в бакете (`<имя_бакета>/some/key`) или префикс (`<имя_бакета>/some/path/*`), в том числе пустой префикс для обозначения всех объектов в бакете (`<имя_бакета>/*`). В правиле можно указать несколько ресурсов.

  {% note info %}
  
  {% include [policy-bucket-objects](../policy-bucket-objects.md) %} 

  {% endnote %}

  Если вы описываете политику в формате JSON, у ресурса должен быть префикс `arn:aws:s3:::`, например `arn:aws:s3:::<имя_бакета>`.

  Если имя ресурса содержит символ `?`, `*` или `$`, поставьте перед таким символом знак `$`, а сам символ заключите в фигурные скобки `{}`. Например, имени бакета `my?bucket` будет соответствовать запись `my${?}bucket`.

Действие

: Набор операций над ресурсом, который будет запрещен или разрешен правилом. Подробнее читайте в разделе [Действия](../../../storage/s3/api-ref/policy/actions.md).

Результат

: Запрет или разрешение запрошенного действия. Сначала проверяется попадание запроса в фильтр с действием `Deny`, при совпадении запрос отклоняется и дальнейшие проверки не проводятся. При попадании в фильтр с действием `Allow` запрос разрешается. Если запрос не попал ни в один из фильтров, то запрос отклоняется.

Принципал

: Получатель запрошенного разрешения. Это может быть пользователь {{ iam-short-name }}, [федеративный пользователь](../../../iam/concepts/federations.md), [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) или анонимный пользователь.


Условие

: Определение случаев, когда действует правило.

  Если для правила задано одновременно несколько условий или внутри одного условия задано одновременно несколько ключей, то такие условия и ключи применяются с логикой `И`.
  
  Если для одного ключа условия задано одновременно несколько значений, то такие значения применяются с логикой `ИЛИ`.
  
  Подробнее читайте в разделе [Условия](../../../storage/s3/api-ref/policy/conditions.md).

## Доступ к бакету через консоль управления {#console-access}

Если для бакета настроена политика доступа, то по умолчанию доступ к бакету через консоль управления {{ yandex-cloud }} запрещен. Чтобы разрешить доступ к бакету, нужно добавить в секцию `Statement` политики доступа правило, разрешающее любые запросы к ресурсам `<имя_бакета>/*` и `<имя_бакета>` через консоль управления.

Пример правила для конкретного пользователя {{ yandex-cloud }}:

```json
{
  "Effect": "Allow",
  "Principal": {
    "CanonicalUser": "<идентификатор_пользователя>"
  },
  "Action": "*",
  "Resource": [
    "arn:aws:s3:::<имя_бакета>/*",
    "arn:aws:s3:::<имя_бакета>"
  ],
  "Condition": {
    "StringLike": {
      "aws:referer": "{{ link-console-main }}/folders/*/storage/buckets/your-bucket-name*"
    }
  }
}
```


{% cut "Пример для совместного использования доменов console.cloud.yandex.* и console.yandex.cloud" %}

Если вы используете старый домен `console.cloud.yandex.*` совместно с новым доменом `console.yandex.cloud`, задайте следующие правила политики:

```json
{
  "Effect": "Allow",
  "Principal": {
    "CanonicalUser": "<идентификатор_пользователя>"
  },
  "Action": "*",
  "Resource": [
    "arn:aws:s3:::<имя_бакета>/*",
    "arn:aws:s3:::<имя_бакета>"
  ],
  "Condition": {
    "StringLike": {
      "aws:referer": [
        "https://console.cloud.yandex.*/folders/*/storage/buckets/your-bucket-name*",
        "{{ link-console-main }}/folders/*/storage/buckets/your-bucket-name*"
      ]
    }
  }
}
```

{% endcut %}



Идентификатор пользователя можно получить по [инструкции](../../../iam/operations/users/get.md) в документации {{ iam-full-name }}.


## Примеры конфигурации {#config-examples}

* Правило, которое разрешает анонимному пользователю чтение объектов бакета по зашифрованному подключению:

  ```json
  {
    "Id": "epd4limdp3dg********",
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "f1qqoehl1q53********",
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::<имя_бакета>/*",
        "Condition": {
          "Bool": {
            "aws:SecureTransport": "true"
          }
        }
      }
    ]
  }
  ```

* Правило, которое разрешает скачивать объекты только из указанного диапазона IP-адресов:

  ```json
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::<имя_бакета>/*",
        "Condition": {
          "IpAddress": {
            "aws:SourceIp": "100.101.102.128/30"
          }
        }
      }
    ]
  }
  ```

* Правило, которое запрещает скачивать объекты с указанного IP-адреса:

  ```json
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": "*",
        "Action": "*",
        "Resource": "arn:aws:s3:::<имя_бакета>/*"
      },
      {
        "Effect": "Deny",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::<имя_бакета>/*",
        "Condition": {
          "IpAddress": {
            "aws:SourceIp": "100.101.102.103"
          }
        }
      }
    ]
  }
  ```

* Правило, которое дает разным пользователям полный доступ только к определенным папкам, каждому пользователю — к своей:

  ```json
  {
    "Version":"2012-10-17",
    "Statement":[
      {
        "Sid":"User1PermissionsResource",
        "Effect":"Allow",
        "Principal": {
          "CanonicalUser": "<идентификатор_пользователя>"
        },
        "Action": "*",
        "Resource":["arn:aws:s3:::<имя_бакета>/user1path/*"]
      },
      {
        "Sid":"User1PermissionsPrefix",
        "Effect":"Allow",
        "Principal": {
            "CanonicalUser": "<идентификатор_пользователя>"
        },
        "Action": "s3:ListBucket",
        "Resource":["arn:aws:s3:::<имя_бакета>"],
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
          "CanonicalUser": "<идентификатор_пользователя>"
        },
        "Action": "*",
        "Resource":["arn:aws:s3:::<имя_бакета>/user2path/*"]
      },
      {
        "Sid":"User2PermissionsPrefix",
        "Effect":"Allow",
        "Principal": {
          "CanonicalUser": "<идентификатор_пользователя>"
        },
        "Action": "s3:ListBucket",
        "Resource":["arn:aws:s3:::<имя_бакета>"],
        "Condition": {
          "StringLike": {
            "s3:prefix": "user2path/*"
          }
        }
      }
    ]
  }
  ```

* Правило, которое дает каждому пользователю и сервисному аккаунту полный доступ к папке с названием, равным [идентификатору пользователя](../../../iam/operations/users/get.md) или [сервисного аккаунта](../../../iam/operations/sa/get-id.md):

  ```json
  {
    "Version":"2012-10-17",
    "Statement":[
      {
        "Sid": "OwnDirPermissions",
        "Effect": "Allow",
        "Principal": "*",
        "Action": "*",
        "Resource": ["arn:aws:s3:::<имя_бакета>/${aws:userid}/*"]
      }
    ]
  }
  ```

### См. также {#see-also}

* [{#T}](../../../storage/operations/buckets/policy.md)
