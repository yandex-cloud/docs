# Как ограничить доступ к бакету {{ objstorage-name }} диапазоном IP-адресов, принадлежащих {{ cdn-name }}


## Описание задачи {#case-description}

Необходимо, чтобы контент статического сайта или SPA, размещенного в {{ objstorage-full-name }}, был доступен только для {{ cdn-full-name }}.

## Решение {#case-resolution}

Логика размещения статических сайтов в {{ objstorage-name }} предусматривает, что содержимое бакета должно быть доступно для всех IP-адресов и подсетей, которые запрашивают контент с сайта.

Инфраструктура {{ cdn-name }} кеширует содержимое бакета с сайтом на своих серверах, однако в консоли управления пока отсутствует возможность настроить доступ к бакету исключительно из сетей CDN.

Для реализации этого сценария необходимо ограничить публичный доступ к бакету по IP-адресам, вручную разрешив подключения только из подсетей {{ cdn-full-name }}, запрещая доступ к содержимому бакета для всех остальных IP-адресов. В этом случае необходимо настроить [политику доступа для бакета](../../../storage/concepts/policy.md), в которой будут указаны диапазоны IP-адресов, которые используются сервисом {{ cdn-name }}.

{% list tabs group=instructions %}

- {{ cdn-full-name }}

  Список подсетей провайдера {{ cdn-full-name }} доступен в [документации](../../../security/ip-list.md#cloud-cdn). 
  

- EdgeCDN

  Список задействованных сервисом IP-адресов и подсетей расположен по  ссылкам:
  
  * [Список публичных IP-адресов провайдера EdgeЦентр](https://api.edgecenter.ru/cdn/public_ips_list);
  * [Список подсетей провайдера EdgeЦентр c указанием CIDR](https://api.edgecenter.ru/cdn/public_net_list);
  

{% endlist %}

{% note info "Примечание" %}

Список адресов периодечски меняется: в него могут быть включены новые или удалены более незадействованные IP-адреса или подсети.

Рекомендуем время от времени сверять список подсетей в созданной вами политике доступа для бакета с актуальным списком адресов.

{% endnote %}

Примените политику из указанного ниже примера [по этой инструкции](../../../storage/operations/buckets/policy.md#apply-policy).
Перед применением политики на основе приложенного примера следует изменить `<имя бакета>` на наименование вашего бакета в {{ objstorage-name }}.

{% list tabs group=instructions %}

- {{ cdn-full-name }}

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

- EdgeCDN

  Список IP-адресов для CDN-провайдера EdgeCenter предоставлен по [ссылке](https://api.edgecenter.ru/cdn/public_ips_list). Поскольку список очень большой, лучше автоматически сформировать ACL, а затем загрузить его в конфигурацию бакета.
  В этом руководстве предоставлен пример скрипта на Python. Сохраните скрипт в файл `acl_generator.py` и запустите его с помощью команды `python3 acl_generator.py https://api.edgecenter.ru/cdn/public_ips_list my-bucket -o policy.json`, где `my-bucket` – наименование бакета в {{ objstorage-name }}.

  {% cut "Пример Python-скрипта" %}

   ```python
    import json
    import requests
    import argparse

    def main():
      parser = argparse.ArgumentParser(description='Generate S3 Bucket ACL from IP list')
      parser.add_argument('url', help='URL of JSON file with IP addresses')
      parser.add_argument('bucket', help='S3 bucket name')
      parser.add_argument('-o', '--output', default='acl.json', help='Output filename (default: acl.json)')
      args = parser.parse_args()

      try:
          response = requests.get(args.url, timeout=10)
          response.raise_for_status()
          data = response.json()

          if 'addresses' not in data or not isinstance(data['addresses'], list):
              raise ValueError("Invalid JSON structure: 'addresses' array not found")
          
          acl = {
              "Version": "2012-10-17",
              "Statement": [
                  {
                      "Effect": "Allow",
                      "Principal": "*",
                      "Action": "s3:GetObject",
                      "Resource": f"arn:aws:s3:::{args.bucket}/*",
                      "Condition": {
                          "IpAddress": {
                              "aws:sourceip": address
                          }
                      }
                  }
                  for address in data['addresses']
              ]
          }

          with open(args.output, 'w') as f:
              json.dump(acl, f, indent=4)
          
          print(f"ACL successfully generated for {len(data['addresses'])} IPs. Saved to {args.output}")

      except requests.exceptions.RequestException as e:
          print(f"Network error: {e}")
      except json.JSONDecodeError:
          print("Error: Invalid JSON format in response")
      except ValueError as e:
          print(e)

   if __name__ == "__main__":
      main()
  ```

  {% endcut %}


{% endlist %}


