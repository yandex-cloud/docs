# Как ограничить доступ к бакету {{ objstorage-name }} диапазоном IP-адресов, принадлежащих {{ cdn-name }}


## Описание задачи {#case-description}

Необходимо, чтобы контент статического сайта или SPA, размещенного в {{ objstorage-full-name }}, был доступен только для {{ cdn-full-name }}.

## Решение {#case-resolution}

Логика размещения статических сайтов в {{ objstorage-name }} предусматривает, что содержимое бакета должно быть доступно для всех IP-адресов и подсетей, которые запрашивают контент с сайта.

Инфраструктура {{ cdn-name }} кеширует содержимое бакета с сайтом на своих серверах, однако в консоли управления пока отсутствует возможность настроить доступ к бакету исключительно из сетей CDN.

Для реализации этого сценария необходимо ограничить публичный доступ к бакету по IP-адресам, вручную разрешив подключения только из подсетей {{ cdn-full-name }}, запрещая доступ к содержимому бакета для всех остальных IP-адресов. В этом случае необходимо настроить [политику доступа для бакета](../../../storage/concepts/policy.md), в которой будут указаны диапазоны IP-адресов, которые используются сервисом {{ cdn-name }}.

Список подсетей провайдера {{ cdn-full-name }} доступен в [документации](../../../security/ip-list.md#cloud-cdn). 

{% note info "Примечание" %}

Список адресов периодечски меняется: в него могут быть включены новые или удалены более незадействованные IP-адреса или подсети.

Рекомендуем время от времени сверять список подсетей в созданной вами политике доступа для бакета с актуальным списком адресов.

{% endnote %}

Примените политику из указанного ниже примера [по этой инструкции](../../../storage/operations/buckets/policy.md#apply-policy). Перед применением политики на основе приложенного примера сперва измените `<имя бакета>` на наименование вашего бакета в {{ objstorage-name }}.

```
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
          "aws:sourceip": "188.72.103.0/24"
        }
      }
    },
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::<имя бакета>/*",
      "Condition": {
        "IpAddress": {
          "aws:sourceip": "188.72.104.0/24"
        }
      }
    },
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::<имя бакета>/*",
      "Condition": {
        "IpAddress": {
          "aws:sourceip": "188.72.105.0/24"
        }
      }
    },
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::<имя бакета>/*",
      "Condition": {
        "IpAddress": {
          "aws:sourceip": "188.72.110.0/24"
        }
      }
    },
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::<имя бакета>/*",
      "Condition": {
        "IpAddress": {
          "aws:sourceip": "188.72.111.0/24"
        }
      }
    },
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::<имя бакета>/*",
      "Condition": {
        "IpAddress": {
          "aws:sourceip": "188.72.112.0/24"
        }
      }
    },
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::<имя бакета>/*",
      "Condition": {
        "IpAddress": {
          "aws:sourceip": "188.72.113.0/24"
        }
      }
    },
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::<имя бакета>/*",
      "Condition": {
        "IpAddress": {
          "aws:sourceip": "89.223.9.0/24"
        }
      }
    }
  ]
}
```
