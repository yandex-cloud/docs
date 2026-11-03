[Документация Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > [Построение Data Platform](index.md) > OpenSearch > Настройка политики индексов в Managed Service for OpenSearch

# Настройка политики индексов в Yandex Managed Service for OpenSearch

# Настройка политики индексов в Yandex Managed Service for OpenSearch


С помощью [политик](../../managed-opensearch/concepts/index-policy.md) можно автоматически выполнять определенные операции с индексами. Например, чтобы повысить безопасность и доступность данных, вы можете установить политику, которая будет создавать новый индекс при выполнении хотя бы одного из условий:

* размер индекса превышает 50 ГБ;
* возраст индекса превышает 30 дней.

Чтобы настроить такую политику:

1. [Подготовьте инфраструктуру](#prepare-infrastructure).
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


## Подготовьте инфраструктуру {#prepare-infrastructure}

1. Подготовьте кластер Managed Service for OpenSearch:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте кластер Managed Service for OpenSearch](../../managed-opensearch/operations/cluster-create.md#create-cluster) нужной вам конфигурации с публичным доступом к любой группе хостов.

            {% note info %}
            
            Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
            
            {% endnote %}

        1. Если вы используете группы безопасности в кластере, убедитесь, что они настроены правильно и допускают подключение к кластеру [Managed Service for OpenSearch](../../managed-opensearch/operations/connect/index.md#security-groups).

    - С помощью Terraform {#tf}

        1. Если у вас еще нет Terraform, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
        1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
        1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
        1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

        1. Скачайте в ту же рабочую директорию файл конфигурации [opensearch-index-policy.tf](https://github.com/yandex-cloud-examples/yc-opensearch-index-policy/blob/main/opensearch-index-policy.tf).

            Более подробную информацию о параметрах используемых ресурсов в Terraform смотрите в документации провайдера:

            * [сеть](../../vpc/concepts/network.md#network) — [yandex_vpc_network](../../terraform/resources/vpc_network.md);
            * [подсеть](../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet](../../terraform/resources/vpc_subnet.md);
            * [группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к кластеру Managed Service for OpenSearch, — [yandex_vpc_security_group](../../terraform/resources/vpc_security_group.md);
            * [кластер Managed Service for OpenSearch](../../managed-opensearch/concepts/index.md) — [mdb_opensearch_cluster](../../terraform/resources/mdb_opensearch_cluster.md).

        1. Укажите в файле `opensearch-index-policy.tf` переменные:

            * `version` — версия OpenSearch.
            * `admin_password` — пароль администратора OpenSearch.

        1. Создайте ресурсы:

            1. В терминале перейдите в директорию с конфигурационным файлом.
            1. Проверьте корректность конфигурации с помощью команды:
            
               ```bash
               terraform validate
               ```
            
               Если конфигурация является корректной, появится сообщение:
            
               ```bash
               Success! The configuration is valid.
               ```
            
            1. Выполните команду:
            
               ```bash
               terraform plan
               ```
            
               В терминале будет выведен список планируемых изменений: ресурсы и/или выходные переменные. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
            1. Примените изменения конфигурации:
            
               ```bash
               terraform apply
               ```
            
            1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

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

1. Создайте политику, которая переносит псевдоним в новый индекс (rollover):

    ```bash
    curl \
        --user admin:<пароль> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request PUT 'https://<адрес_хоста_OpenSearch_с_публичным_доступом>:9200/_plugins/_ism/policies/rollover_policy' \
        --data '
            {
                "policy": {
                    "description": "Example rollover policy",
                    "default_state": "rollover",
                    "schema_version": 1,
                    "states": [
                        {
                            "name": "rollover",
                            "actions": [
                                {
                                    "rollover": {
                                        "min_index_age": "1h",
                                        "min_primary_shard_size": "500b"
                                    }
                                }
                            ],
                            "transitions": []
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
    * `min_primary_shard_size` — размер одного из основных сегментов в индексе. По достижении этого размера будет создан новый индекс. Рекомендуемое значение — 50 ГБ (`50gb`).
    * `index_patterns` — шаблон имени для нового индекса.

    Чтобы быстро проверить работу политики, в примере запроса рекомендуемые значения уменьшены до 1 часа и 500 байт.

1. Настройте шаблон индекса, в котором назначьте политике псевдоним `log`:

    ```bash
    curl \
        --user admin:<пароль> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request PUT 'https://<адрес_хоста_OpenSearch_с_публичным_доступом>:9200/_index_template/ism_rollover?pretty' \
        --data '
            {
                "index_patterns": ["log*"],
                "template": {
                    "settings": {
                        "plugins.index_state_management.rollover_alias": "log"
                    }
                }
            }'
    ```

## Прикрепите политику к индексу {#attach-policy}

1. Создайте индекс `log-000001` с псевдонимом `log`:

    ```bash
    curl \
        --user admin:<пароль> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request PUT 'https://<адрес_хоста_OpenSearch_с_публичным_доступом>:9200/log-000001?pretty' \
        --data '
            {
                "aliases": {
                    "log": {
                        "is_write_index": true
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

    В результатах будет выведено похожее сообщение:

    ```bash
    {
      "log-000001" : {
        "index.plugins.index_state_management.policy_id" : "rollover_policy",
        "index.opendistro.index_state_management.policy_id" : "rollover_policy",
        "index" : "log-000001",
        "index_uuid" : "...",
        "policy_id" : "rollover_policy",
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
        --request POST 'https://<адрес_хоста_OpenSearch_с_публичным_доступом>:9200/log/_doc?pretty' \
        --data '
            {
                "num": "101",
                "name": "Valya",
                "age": "25"
            }'
    ```

1. Через 5 минут после создания документа получите список индексов:

    ```bash
    curl \
        --user admin:<пароль> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request GET 'https://<адрес_хоста_OpenSearch_с_публичным_доступом>:9200/_cat/indices?pretty'
    ```

    5 минут — это время по умолчанию, через которое повторяется проверка условий политики.

    В результатах вывода должны отображаться индексы `log-000001` и `log-000002`:

    ```bash
    yellow open log-000001 ... 1 1 0 0 5.1kb 5.1kb
    yellow open log-000002 ... 1 1 0 0  208b  208b
    ```

1. (Опционально) Через час после [создания индекса](#attach-policy) снова получите список индексов.

    В результатах вывода должны отображаться индексы `log-000001`, `log-000002`, `log-000003`:

    ```bash
    yellow open log-000001 ... 1 1 0 0 5.1kb 5.1kb
    yellow open log-000002 ... 1 1 0 0  208b  208b
    yellow open log-000003 ... 1 1 0 0    0b    0b
    ```

    1 час — это условие политики для создания нового индекса.

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