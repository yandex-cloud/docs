# Monitoring Terraform

[Terraform](https://www.terraform.io/) позволяет создавать ресурсы {{ monitoring-short-name }} и управлять ими с помощью файлов конфигураций. В файлах конфигураций хранится описание ресурсов на языке HCL (HashiCorp Configuration Language).

Подробную информацию о ресурсах провайдера смотрите в [документации](https://storage.cloud-preprod.yandex.net/terraform/docs/index.html) или [исходном коде](https://bb.yandexcloud.net/projects/CLOUD/repos/cloud-go/browse/devtools/terraform-provider-ycp/docs/resources) документации.

Когда применяются файлы конфигураций, Terraform автоматически определяет, какая часть конфигурации уже развернута, что следует добавить, изменить или удалить.

Ресурсы {{ monitoring-short-name }} входят в состав провайдера [Terraform YCP](https://bb.yandexcloud.net/projects/CLOUD/repos/cloud-go/browse/devtools/terraform-provider-ycp).

## Концепции {#concepts}

* Ресурсы {{ monitoring-short-name }} могут управляться конфигурацией Terraform.
* Для ресурсов {{ monitoring-short-name }}, которые управляются Terraform, первоисточником являются конфигурации Terraform. Все изменения, которые делаются с помощью API, CLI или пользовательского интерфейса, теряются, когда применяется конфигурация Terraform, если этих изменений в ней нет.
* В одном проекте {{ monitoring-short-name }} могут быть ресурсы под управлением Terraform и нет. Например, если создать алерт с помощью пользовательского интерфейса, он не будет изменяться, когда применяются конфигурации Terraform.
* У ресурсов {{ monitoring-short-name }} нет признака `managed-by-iac`, поэтому их можно изменять не только с помощью конфигурации Terraform. При этом все изменения, которых нет в конфигурации Terraform, теряются.
* Для data-plane ресурсы не предоставляются. Например, нельзя перенести метрики из одного шарда в другой.

## Как начать использовать {#use}

1. [Установите Terraform](https://cloud.yandex.ru/docs/tutorials/infrastructure-management/terraform-quickstart#install-terraform)
1. [Настройте зеркало Terraform](https://clubs.at.yandex-team.ru/ycp/4790/4792).
  
    Пример конфигурации:

    ```bash
    alextrushkin$ cat ~/.terraformrc
    provider_installation {
      network_mirror {
        url = "https://terraform-mirror.yandexcloud.net/"
        include = ["registry.terraform.io/*/*"]
      }
      direct {
        exclude = ["registry.terraform.io/*/*"]
      }
    }
    ```

1. Добавьте файл конфигурации `version.tf`, который описывает наш Terraform-провайдер:
    ```
    terraform {
      required_providers {
        ycp = {
          source = "terraform.storage.cloud-preprod.yandex.net/yandex-cloud/ycp"
          # version = "0.20.0" # optional
        }
      }
      required_version = ">= 0.13"
    }
    ```
1. Инициализируйте провайдер. Для этого выполните команду в каталоге, где лежит наша конфигурация:
    ```terraform init```

1. Настройте провайдер, указав эндпоинт для {{ monitoring-short-name }}:
    ```
    provider ycp {
      monitoring {
        endpoint     = "https://solomon-pre.yandex-team.ru"
        grpc_address = "solomon.yandex.net:443"
      }
    }
    ```

    Эндпоинты для разных инсталяций можно найти [здесь](../overview/clusters.md).
   
1. Напишите нужную конфигурацию и примените ее, выполнив команду:
    ```
    terraform apply
    ```

## Как использовать локальный билд {#use-developer-version}

Так как релиз провайдера занимает время и не всегда в последнем релизе есть нужные фиксы и ресурсы, можно использовать локальный билд. Для этого:
1. Клонируйте [репозиторий](https://bb.yandexcloud.net/projects/CLOUD/repos/cloud-go/browse).
1. [Настройте репозиторий](https://bb.yandexcloud.net/projects/CLOUD/repos/cloud-go/browse/README.md).
1. Запустите сборку [провайдера](https://bb.yandexcloud.net/projects/CLOUD/repos/cloud-go/browse/devtools/terraform-provider-ycp):
    ```
    make local-build
    ```
1. Добавьте в файл `~/.terraformrc`, в начало секции ```provider_installation```:
    ```
      filesystem_mirror {
        path    = "/Users/not_var{{LOGIN_HERE}}/.terraform.d/plugins"
        include = ["terraform.storage.cloud-preprod.yandex.net/*/*"]
      }
    ```

Подробнее про [локальную сборку](https://wiki.yandex-team.ru/cloud/devel/terraform-ycp/#sborkaizisxodnyxkodov).

После сборки провайдера [настройте terraform](#use) и напишите конфигурацию.

Если нужно заменить локальный билд, удалите файл `.terraform.lock.hcl` и выполните команду ```terraform init -upgrade```.

## Аутентификация и авторизация {#auth}

Terraform-конфигурация выполняется от имени пользователя, который выполняет команду ```terraform apply```. Подробнее о [механизмах аутентификации](../api-ref/authentication.md).

### В {{ yandex-cloud }} {#cloud}

Укажите IAM-токен в переменной среды `YC_TOKEN` или в конфигурации:
```
provider ycp {
 token = "TOKEN HERE"
}
```

Также можно настроить `ycp`:
1. Установите [ycp](https://wiki.yandex-team.ru/cloud/devel/platform-team/dev/ycp/#install).
1. Выполните команду ```ycp components update && ycp init```.
1. В конфигурации Terraform укажите ycp-профиль для получения токена:
    ```
    provider ycp {
     ycp_profile = "prod"
    }
    ```

### В «большом» Яндексе {#yandex}

Укажите OAuth-токен в переменной среды `YC_TOKEN` или в конфигурации:
```
provider ycp {
 token = "TOKEN HERE"
}
```

## Хранение состояния {#s3-store}

Terraform хранит состояние примененной конфигурации рядом с конфигурацией в файлах `terraform.tfstate`. Можно отредактировать или удалить файл `terraform.tfstate`. Тогда Terraform будет считать, что под его управлением нет ресурсов.

Можно хранить состояния примененных конфигураций в S3. Пример для `solomon-cloud`:
1. Проверьте, есь ли у вас роль `S3 writer` в ABC-сервисе [YC Solomon](https://abc.yandex-team.ru/services/solomon-cloud?scope=manage_store_systems). Если нет, получите ее.
1. Создайте бакет, в котором будут храниться состояния. [Подробнее](https://wiki.yandex-team.ru/mds/s3-api/authorization/). 
1. Получите ключ для доступа к бакету в [S3](https://s3-idm.mds.yandex.net/stats/buckets/yc-solomon):
    1. Получите [OAuth-токен](https://oauth.yandex-team.ru/authorize?response_type=token&client_id=6797456f343042aabba07f49b478c49b).
    1. Создайте новый ключ для доступа:
       ```bash
       curl -qs -X POST -H "Authorization: OAuth $S3_OAUTH_TOKEN" "https://s3-idm.mds.yandex.net/credentials/create-access-key" --data "service_id=3047" --data "role=writer"
       ```

       Посмотреть текущие ключи для доступа:
       ```bash
       curl -qs -X POST -H "Authorization: OAuth $S3_OAUTH_TOKEN" "https://s3-idm.mds.yandex.net/credentials/list-access-keys" --data "service_id=3047" | json_pp
       ```
       Удалить ключа для доступа:
       ```bash
       curl -qs -X POST -H "Authorization: OAuth $S3_OAUTH_TOKEN" "https://s3-idm.mds.yandex.net/credentials/delete-access-key" --data "service_id=3047" --data "access_key_id=$ACCESS_KEY_ID"
       ```
1. Настройте провайдер на бакет:
    ```
    terraform {
        backend "s3" {
            endpoint = "s3.mds.yandex.net"
            bucket = "yc-solomon"
            key = "terraform/israel/solomon.tfstate"
            region = "us-east-1"
            access_key = "XXX"
            secret_key = "XXX"
            skip_credentials_validation = true
            skip_metadata_api_check = true
        }
    }
    ```

## Ресурсы {#resources}

С помощью конфигурации Terraform можно управлять следующими ресурсами {{ monitoring-short-name }}:

Ресурс|Описание
------|--------
[Проекты](./project.md) |Управление проектами.
[Роли в проекте](./project-roles.md) |Управление ролями проекта.
[Алерты Threshold](./alert-threshold.md) |Управление threshold-алертами.
[Алерты Expression](./alert-expression.md) |Управление expression-алертами.
[Алерты From template](./alert-from-template.md) |Управление алертами из шаблона.
[Алерты сервис-провайдера](./service-provider-alerts.md) |Управление алертами сервис-провайдера.
[Ресурсы сервис-провайдера](./service-provider-resources.md) |Управление ресурсами сервис-провайдера.
[Каналы Email](./channel-email.md) |Управление Email-каналами.
[Каналы Juggler](./channel-juggler.md) |Управление Juggler-каналами.
[Каналы Phone](./channel-phone.md) |Управление Phone-каналами.
[Каналы Sms](./channel-sms.md) |Управление Sms-каналами.
[Каналы Telegram](./channel-telegram.md) |Управление Telegram-каналами.
[Каналы Webhook](./channel-webhook.md) |Управление Webhook-каналами.
[Каналы YaChat](./channel-yachat.md) |Управление YaChat-каналами.
[Эскалации](./escalations.md) |Управление эскалациями.
[Дашборды](./dashboards.md) |Управление дашбордами.
[Кластеры](./clusters.md) |Управление кластерами.
[Сервисы Pull](./services-pull.md) |Управление Pull-сервисами.
[Сервисы Push](./services-push.md) |Управление Push-сервисами.
[Шарды](./shards.md) |Управление шардами.
[Быстрые ссылки](./quick-links.md) |Управление быстрыми ссылками в проекте.
