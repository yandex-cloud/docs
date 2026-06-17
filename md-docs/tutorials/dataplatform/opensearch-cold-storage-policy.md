# Настройка политики холодного хранилища в Yandex Managed Service for OpenSearch

# Настройка политики холодного хранилища в Yandex Managed Service for OpenSearch


С помощью [политик](../../managed-opensearch/concepts/index-policy.md) можно автоматически выполнять некоторые операции с индексами. Например, чтобы оптимизировать использование хранилища, вы можете установить политику, которая будет перемещать в определенную группу хостов «холодные» данные, а затем перепаковывать эти данные с помощью [кодека](../../managed-opensearch/concepts/indexing.md#codecs), который обеспечивает большую степень сжатия.

Чтобы настроить такую политику:

1. [Подготовьте инфраструктуру](#infrastructure-prepare).
1. [Создайте политику](#create-policy).
1. [Прикрепите политику к индексу](#attach-policy).
1. [Проверьте работу политики](#check-policy).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for OpenSearch: использование вычислительных ресурсов, объем хранилища и резервных копий ([тарифы Managed Service for OpenSearch](../../managed-opensearch/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).


## Подготовьте инфраструктуру {#infrastructure-prepare}

1. Подготовьте кластер Managed Service for OpenSearch:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте кластер Managed Service for OpenSearch](../../managed-opensearch/operations/cluster-create.md#create-cluster) любой подходящей конфигурации со следующими настройками:

            * Две или более группы хостов с ролью `DATA`. Двум группам присвойте имена `hot` и `cold`.
            * Публичный доступ к любой группе хостов.

        1. Если вы используете группы безопасности в кластере, убедитесь, что они допускают подключение к кластеру [Managed Service for OpenSearch](../../managed-opensearch/operations/connect/index.md#configuring-security-groups).

    - С помощью Terraform {#tf}

        1. Если у вас еще нет Terraform, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
        1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
        1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
        1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

        1. Скачайте в ту же рабочую директорию файл конфигурации [opensearch-cold-storage-policy.tf](https://github.com/yandex-cloud-examples/yc-opensearch-cold-storage-policy/blob/main/opensearch-cold-storage-policy.tf). В файле описаны:

            * [сеть](../../vpc/concepts/network.md#network);
            * [подсети](../../vpc/concepts/network.md#subnet);
            * [группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к кластеру Managed Service for OpenSearch;
            * кластер Managed Service for OpenSearch.

        1. Укажите в файле `opensearch-cold-storage-policy.tf` переменные:

            * `version` — версия OpenSearch.
            * `admin_password` — пароль администратора OpenSearch.

        1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, Terraform на них укажет.

        1. Создайте необходимую инфраструктуру:

            1. Выполните команду для просмотра планируемых изменений:
            
               ```bash
               terraform plan
               ```
            
               Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
            
            1. Если вас устраивают планируемые изменения, внесите их:
               1. Выполните команду:
            
                  ```bash
                  terraform apply
                  ```
            
               1. Подтвердите изменение ресурсов.
               1. Дождитесь завершения операции.

            В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

    {% endlist %}

1. [Установите SSL-сертификат](../../managed-opensearch/operations/connect/index.md#ssl-certificate).

1. Проверьте подключение к кластеру с помощью утилиты [cURL](https://curl.haxx.se/):

    ```bash
    curl \
        --user admin:<пароль> \
        --cacert ~/.opensearch/root.crt \
        --request GET 'https://<FQDN_хоста_OpenSearch_с_публичным_доступом>:9200/'
    ```
    
    FQDN хоста можно получить со [списком хостов в кластере](../../managed-opensearch/operations/host-groups.md#list-hosts).
    
    При успешном подключении будет выведено сообщение вида:
    
    ```bash
    {
      "name" : "....mdb.yandexcloud.net",
      "cluster_name" : "...",
      "cluster_uuid" : "...",
      "version" : {
      "distribution" : "opensearch",
      ...
      },
      "tagline" : "The OpenSearch Project: https://opensearch.org/"
    }
    ```

## Создайте политику {#create-policy}

Создайте политику, которая переводит «горячие» данные в «холодные», а затем в архив:

```bash
curl \
    --user admin:<пароль> \
    --cacert ~/.opensearch/root.crt \
    --header 'Content-Type: application/json' \
    --request PUT 'https://<адрес_хоста_OpenSearch_с_публичным_доступом>:9200/_plugins/_ism/policies/archive_policy' \
    --data '
        {
            "policy": {
                "description": "Example archive policy",
                "default_state": "hot",
                "schema_version": 1,
                "states": [
                    {
                        "name": "hot",
                        "actions": [
                            {
                                "allocation": {
                                    "require": { "groupname": "hot" }
                                }
                            }
                        ],
                        "transitions": [
                            {
                                "state_name": "cold",
                                "conditions": {
                                    "min_index_age": "1h"
                                }
                            }
                        ]
                    },
                    {
                        "name": "cold",
                        "actions": [
                            {
                                "allocation": {
                                    "require": { "groupname": "cold" }
                                }
                            }
                        ],
                        "transitions": [
                            {
                                "state_name": "archive",
                                "conditions": {
                                    "min_index_age": "2h"
                                }
                            }
                        ]
                    },
                    {
                        "name": "archive",
                        "actions": [
                            {
                                "repack": {
                                    "new_codec": "lzma"
                                }
                            }
                        ]
                    }
                ],
                "ism_template": {
                    "index_patterns": ["log*"],
                    "priority": 100
                }
            }
        }'
```

Где:

* `min_index_age` — возраст индекса, по достижении которого будет создан новый индекс. Рекомендуемое значение — 30 дней (`30d`).
* `index_patterns` — шаблон имени для нового индекса.
* `new_codec` — название кодека, которым будут переупакованы данные.

Чтобы быстро проверить работу политики, в примере запроса установлены значения `min_index_age`:
* Для состояния `hot` — 1 час. По истечении этого времени данные будут переведены в «холодные».
* Для состояния `cold` — 2 часа. По истечении этого времени данные будут переупакованы кодеком `lzma` (перевод в архив).

Вы можете указать меньшие значения, но не менее 5 минут — это время по умолчанию, через которое повторяется проверка условий политики.

## Прикрепите политику к индексу {#attach-policy}

1. Создайте индекс `log-000001`:

    ```bash
    curl \
        --user admin:<пароль> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request PUT 'https://<адрес_хоста_OpenSearch_с_публичным_доступом>:9200/log-000001?pretty' \
        --data '
            {
                "settings": {
                    "index" : {
                        "routing" : {
                            "allocation" : {
                                "require" : {
                                    "groupname" : "hot"
                                }
                            }
                        }
                    }
                }
            }'
    ```

1. Проверьте, прикреплена ли политика к индексу:

    ```bash
    curl \
        --user admin:<пароль> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request GET 'https://<адрес_хоста_OpenSearch_с_публичным_доступом>:9200/_plugins/_ism/explain/log-000001?pretty'
    ```

    В результатах будет выведено сообщение вида:

    ```bash
    {
      "log-000001" : {
        "index.plugins.index_state_management.policy_id" : "archive_policy",
        "index.opendistro.index_state_management.policy_id" : "archive_policy",
        "index" : "log-000001",
        "index_uuid" : "...",
        "policy_id" : "archive_policy",
        "enabled" : true
      },
      "total_managed_indices" : 1
    }
    ```

## Проверьте работу политики {#check-policy}

1. Добавьте в индекс документ:

    ```bash
    curl \
        --user admin:<пароль> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request POST 'https://<адрес_хоста_OpenSearch_с_публичным_доступом>:9200/log-000001/_doc?pretty' \
        --data '
            {
                "num": "101",
                "name": "Valya",
                "age": "25"
            }'
    ```

1. Через 5 минут после создания документа получите список шардов индекса:

    ```bash
    curl \
        --user admin:<пароль> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request GET 'https://<адрес_хоста_OpenSearch_с_публичным_доступом>:9200/_cat/shards/log-000001?pretty'
    ```

    В результатах будут выведены шарды индекса `log-000001` и адреса хостов, на которых располагаются шарды:

    ```bash
    log-000001 0 r STARTED 1 5.2kb 10.2.0.35 rc1b-lgio8pjp********.mdb.yandexcloud.net
    log-000001 0 p STARTED 1 5.2kb 10.1.0.4  rc1a-g36ksm4q********.mdb.yandexcloud.net 
    ```

1. Убедитесь, что шард расположен в группе хостов `hot`. Для этого получите список хостов с атрибутами:

    ```bash
    curl \
        --user admin:<пароль> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request GET 'https://<адрес_хоста_OpenSearch_с_публичным_доступом>:9200/_cat/nodeattrs/?v&h=node,attr,value&pretty'
    ```

    В результатах будут содержаться строки:

    ```bash
    node                                       attr       value
    rc1b-lgio8pjp********.mdb.yandexcloud.net  groupname  hot
    rc1a-g36ksm4q********.mdb.yandexcloud.net  groupname  hot
    ...
    ```

1. Через час после [создания индекса](#attach-policy) снова получите список шардов для индекса `log-000001`:

    ```bash
    curl \
        --user admin:<пароль> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request GET 'https://<адрес_хоста_OpenSearch_с_публичным_доступом>:9200/_cat/shards/log-000001?pretty'
    ```

    1 час — это условие политики для перемещения индекса в группу хостов с именем `cold`.

    В результатах будут выведены шарды индекса `log-000001` и новые адреса хостов, на которых располагаются шарды:

    ```bash
    log-000001 0 r STARTED 1 5.2kb 10.2.0.22 rc1b-is77nbdv********.mdb.yandexcloud.net
    log-000001 0 p STARTED 1 5.2kb 10.1.0.25 rc1a-qocaisq1********.mdb.yandexcloud.net
    ```

1. Снова запросите список хостов с атрибутами:

    ```bash
    curl \
        --user admin:<пароль> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request GET 'https://<адрес_хоста_OpenSearch_с_публичным_доступом>:9200/_cat/nodeattrs/?v&h=node,attr,value&pretty'
    ```

    В результатах будут содержаться строки:

    ```bash
    node                                       attr       value
    rc1b-is77nbdv********.mdb.yandexcloud.net  groupname  cold
    rc1a-qocaisq1********.mdb.yandexcloud.net  groupname  cold
    ...
    ```

1. Еще через час снова получите список шардов для индекса `log-000001`:

    ```bash
    curl \
        --user admin:<пароль> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request GET 'https://<адрес_хоста_OpenSearch_с_публичным_доступом>:9200/_cat/shards/log-000001?pretty'
    ```

    2 часа — это условие политики для применения нового кодека (перевод в архив).

    В результатах будут выведены шарды индекса `log-000001` и адреса хостов, на которых располагаются шарды:

    ```bash
    log-000001 0 r STARTED 1 4.8kb 10.2.0.22 rc1b-is77nbdv********.mdb.yandexcloud.net
    log-000001 0 p STARTED 1 4.8kb 10.1.0.25 rc1a-qocaisq1********.mdb.yandexcloud.net 
    ```

    При этом размер шардов будет меньшим, так как данные были переупакованы новым кодеком с большей степенью сжатия.

1. Получите настройки индекса и убедитесь, что в них указан кодек `lzma`:

    ```bash
    curl \
        --user admin:<пароль> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request GET 'https://<адрес_хоста_OpenSearch_с_публичным_доступом>:9200/log-000001/_settings?pretty'
    ```

    Результат:

    ```bash
    {
      "log-000001" : {
        "settings" : {
          "index" : {
            ...
            "codec" : "lzma",
            "routing" : {
              "allocation" : {
                "require" : {
                  "groupname" : "cold"
                }
              }
            },
            ...
          }
        }
      }
    }
   ```

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

    [Удалите кластер Managed Service for OpenSearch](../../managed-opensearch/operations/cluster-delete.md).

- С помощью Terraform {#tf}

    1. В терминале перейдите в директорию с планом инфраструктуры.
    
        {% note warning %}
    
        Убедитесь, что в директории нет Terraform-манифестов с ресурсами, которые вы хотите сохранить. Terraform удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
    
        {% endnote %}
    
    1. Удалите ресурсы:
    
        1. Выполните команду:
    
            ```bash
            terraform destroy
            ```
    
        1. Подтвердите удаление ресурсов и дождитесь завершения операции.
    
        Все ресурсы, которые были описаны в Terraform-манифестах, будут удалены.

{% endlist %}