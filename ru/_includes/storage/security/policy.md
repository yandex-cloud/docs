# Политика доступа (bucket policy)

{% include [full-overview](./full-overview.md) %}

Политики доступа устанавливают права на действия с бакетами, объектами и группами объектов.

Политика срабатывает, когда пользователь делает запрос к какому-либо ресурсу. В результате срабатывания политики запрос либо выполняется, либо отклоняется.

[Открытие публичного доступа](../../../storage/operations/buckets/bucket-availability.md) к операциям с бакетом не отменяет ограничений, заданных в политиках доступа.

{% include [storage-note-empty-policy](../../../storage/_includes_service/storage-note-empty-policy.md) %}

Политику доступа можно настроить в консоли управления или описать в формате JSON по [специальной схеме](../../../storage/s3/api-ref/policy/scheme.md), чтобы передать через один из программных инструментов — {{ yandex-cloud }} CLI, AWS CLI, {{ TF }} или API. Подробнее об управлении политикой см. в [инструкции](../../../storage/operations/buckets/policy.md).


{% include [s3-with-policy-access](../s3-with-policy-access.md) %}


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

: Получатель запрошенного разрешения. Это может быть пользователь {{ iam-short-name }}, [федеративный пользователь](../../../iam/concepts/federations.md), [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), анонимный пользователь или [группа пользователей](../../../organization/concepts/groups.md).


Условие

: Определение случаев, когда действует правило.

  {% note info %}

  Для условия `aws:sourceip` поддержан особый порядок [проверки IP-адресов обратных прокси-серверов](#access-via-reverse-proxy).

  {% endnote %}

  Если для правила задано одновременно несколько условий или внутри одного условия задано одновременно несколько ключей, то такие условия и ключи применяются с логикой `И`.
  
  Если для одного ключа условия задано одновременно несколько значений, то такие значения применяются с логикой `ИЛИ`.
  
  Подробнее читайте в разделе [Условия](../../../storage/s3/api-ref/policy/conditions.md).

## Доступ к бакету через консоль управления {#console-access}

Если для бакета настроена политика доступа, то по умолчанию доступ к бакету через консоль управления {{ yandex-cloud }} запрещен. Чтобы разрешить доступ к бакету, нужно добавить в секцию `Statement` политики доступа правило, разрешающее любые запросы к ресурсам `<имя_бакета>/*` и `<имя_бакета>` через консоль управления.

Пример правила для конкретного пользователя {{ yandex-cloud }}:

```json
{
  "Sid": "AllowAWSServices",
  "Effect": "Allow",
  "Principal": "*",
  "Action": "s3:*",
  "Resource": [
    "arn:aws:s3:::<имя_бакета>/*",
    "arn:aws:s3:::<имя_бакета>"
   ],
  "Condition": {
    "Bool": {
      "aws:PrincipalIsAWSService": "true"
    }
  }
}
```


Идентификатор пользователя можно получить по [инструкции](../../../organization/operations/users-get.md) в документации {{ iam-full-name }}.


## Доступ к бакету через цепочку обратных прокси-серверов {#access-via-reverse-proxy}

Чтобы обеспечить работу {{ objstorage-short-name }} с запросами, переданными через цепочку [обратных прокси-серверов](https://ru.wikipedia.org/wiki/Обратный_прокси), в [условии](../../../storage/s3/api-ref/policy/conditions.md) `aws:sourceip` проверяется не только IP-адрес, с которого пришел запрос, но и IP-адреса обратных прокси-серверов, например переданных в заголовке [X-Forwarded-For](https://en.wikipedia.org/wiki/X-Forwarded-For).

Сначала запрос проверятся на соответствие правилам `Deny` политики доступа. Если хотя бы один из IP-адресов попадает под правило `Deny`, запрос отклоняется. Дальнейшие проверки не проводятся.

Далее запрос проверятся на соответствие правилам `Allow`. Если хотя бы один из IP-адресов попадает под правило `Allow`, запрос разрешается.

{% cut "Пример настройки политики доступа к бакету через цепочку обратных прокси-серверов" %}

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "the-allowing-rule",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "*",
      "Resource": "arn:aws:s3:::sample-bucket/*",
      "Condition": {
        "IpAddress": {
          "aws:sourceip": [
            "192.168.1.1",
            "192.168.1.2"
          ]
        }
      }
    },
    {
      "Sid": "the-denying-rule",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "*",
      "Resource": "arn:aws:s3:::sample-bucket/*",
      "Condition": {
        "IpAddress": {
          "aws:sourceip": [
            "192.168.1.11",
            "192.168.1.12"
          ]
        }
      }
    }
  ]
}
```

Если к бакету поступит запрос, содержащий заголовок `X-Forwarded-For: 192.168.1.1, 192.168.1.2, 192.168.1.12`, то такой запрос будет отклонен, поскольку в заголовке содержится IP-адрес, указанный в правиле с действием `Deny`.

Если к бакету поступит запрос, содержащий заголовок `X-Forwarded-For: 192.168.2.100, 192.168.2.1, 192.168.1.2`, то такой запрос будет разрешен, поскольку в заголовке нет IP-адресов, указанных в правиле с действием `Deny`, но есть IP-адрес, указанный в правиле с действием `Allow`.

{% endcut %}

## Обязательная условная запись объектов с помощью политики доступа {#conditional-writes-policy}

[Условная запись объектов](../../../storage/concepts/object.md#conditional-writes) позволяет избежать случайной перезаписи и конфликтов при одновременных загрузках. По умолчанию использование условий записи является необязательным — клиент может передавать заголовки `If-Match` и `If-None-Match` по своему усмотрению.

С помощью [политики доступа](../../../storage/concepts/policy.md) можно сделать проверку условий обязательной. В этом случае все запросы на запись объектов без соответствующих заголовков будут отклоняться.

Чтобы проверять наличие заголовка `If-None-Match` или `If-Match` при создании новых объектов, используйте условия `s3:if-match` и `s3:if-none-match` с [оператором](../../../storage/s3/api-ref/policy/conditions.md#null) `Null`. Вы можете применить их к методам [upload](../../../storage/s3/api-ref/object/upload.md) и [completeUpload](../../../storage/s3/api-ref/multipart/completeupload.md).

Условия можно распространить:

* на весь бакет:

    ```json
    "Resource": ["arn:aws:s3:::<имя_бакета>/*"],
    ```

* на конкретный префикс:

    ```json
    "Resource": ["arn:aws:s3:::<имя_бакета>/<префикс>/*"],
    ```

Если условие не выполнено, сервис возвращает ошибку `403 Access Denied`.

См. [примеры конфигураций](#conditional-writes-rules) для условной записи объектов через политику доступа.

## Примеры конфигурации {#config-examples}

* [Разрешить анонимному пользователю чтение объектов бакета по зашифрованному подключению](#anonymous-user-read-encrypted)
* [Разрешить скачивать объекты только из указанного диапазона IP-адресов](#download-specific-ip-range)
* [Запретить скачивать объекты с указанного IP-адреса](#block-download-specific-ip)
* [Предоставить разным пользователям полный доступ к определенным папкам](#user-specific-full-folder-access)
* [Предоставить каждому пользователю или сервисному аккаунту полный доступ к папке](#full-access-user-service-account-folder)
* [Запретить использовать любые инструменты, кроме консоли управления](#allow-only-console)
* [Разрешить запись объектов только с обязательным использованием условий записи](#conditional-writes-rules)

#### Правило, которое разрешает анонимному пользователю чтение объектов бакета по зашифрованному подключению: {#anonymous-user-read-encrypted}

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

#### Правило, которое разрешает скачивать объекты только из указанного диапазона IP-адресов: {#download-specific-ip-range}

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

#### Правило, которое запрещает скачивать объекты с указанного IP-адреса: {#block-download-specific-ip}

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

#### Правило, которое дает разным пользователям полный доступ только к определенным папкам, каждому пользователю — к своей: {#user-specific-full-folder-access}

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

#### Правило, которое дает каждому пользователю и сервисному аккаунту полный доступ к папке с названием, равным [идентификатору пользователя](../../../organization/operations/users-get.md) или [сервисного аккаунта](../../../iam/operations/sa/get-id.md): {#full-access-user-service-account-folder}

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

#### Правило, которое запрещает использование любых инструментов, кроме консоли управления: {#allow-only-console}

  ```json
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "DenyAllExceptAWSServices",
        "Effect": "Deny",
        "Principal": "*",
        "Action": "s3:*",
        "Resource": [
          "arn:aws:s3:::thatsroman-policy2"
        ],
        "Condition": {
          "Bool": {
            "aws:PrincipalIsAWSService": "false"
          }
        }
      }, 
      {
        "Sid": "AllowAWSServices",
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:*",
        "Resource": [
          "arn:aws:s3:::thatsroman-policy2"
        ],
        "Condition": {
          "Bool": {
            "aws:PrincipalIsAWSService": "true"
          }
        }
      } 
    ]
  }
  ```

#### Правила для обязательного использования условной записи объектов {#conditional-writes-rules}

##### Правило, которое разрешает доступ всем пользователям ко всем объектам в бакете только при наличии заголовка If-None-Match в запросе {#force-if-none-match}

```json
{
  "Version":"2025-12-24",
  "Statement": [
    {
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:PutObject",
      "Resource": [
      "arn:aws:s3:::<имя_бакета>/*"
      ],
      "Condition": {
        "Null": {
          "s3:if-none-match": "true"
        }
      }
    },
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "*",
      "Resource": [
        "arn:aws:s3:::<имя_бакета>/*",
        "arn:aws:s3:::<имя_бакета>"
      ]
    }
  ]
}
```

##### Правило, которое разрешает доступ всем пользователям ко всем объектам в бакете только при наличии заголовка If-Match в запросе {#force-if-match}

```json
{
  "Version":"2025-12-25",
  "Statement": [
    {
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:PutObject",
      "Resource": [
      "arn:aws:s3:::<имя_бакета>/*"
      ],
      "Condition": {
        "Null": {
          "s3:if-match": "true"
        }
      }
    },
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "*",
      "Resource": [
        "arn:aws:s3:::<имя_бакета>/*",
        "arn:aws:s3:::<имя_бакета>"
      ]
    }
  ]
}
```

### См. также {#see-also}

* [{#T}](../../../storage/operations/buckets/policy.md)
