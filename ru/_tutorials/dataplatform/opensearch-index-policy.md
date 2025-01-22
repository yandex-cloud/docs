# Настройка политики индексов в {{ mos-full-name }}


С помощью [политик](../../managed-opensearch/concepts/index-policy.md) можно автоматически выполнять определенные операции с индексами. Например, чтобы повысить безопасность и доступность данных, вы можете установить политику, которая будет создавать новый индекс при выполнении хотя бы одного из условий:

* размер индекса превышает 50 ГБ;
* возраст индекса превышает 30 дней.

Чтобы настроить такую политику:

1. [Создайте политику](#create-policy).
1. [Прикрепите политику к индексу](#attach-policy).
1. [Проверьте работу политики](#check-policy).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

1. Подготовьте инфраструктуру:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте кластер {{ mos-name }}](../../managed-opensearch/operations/cluster-create.md#create-cluster) нужной вам конфигурации с публичным доступом к группе хостов с ролью `DATA`.

        1. Если вы используете группы безопасности в кластере, убедитесь, что они настроены правильно и допускают подключение к кластеру [{{ mos-name }}](../../managed-opensearch/operations/connect.md#configuring-security-groups).

    - С помощью {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

        1. Скачайте в ту же рабочую директорию файл конфигурации [opensearch-index-policy.tf](https://github.com/yandex-cloud-examples/yc-opensearch-index-policy/blob/main/opensearch-index-policy.tf). В файле описаны:

            * [сеть](../../vpc/concepts/network.md#network);
            * [подсеть](../../vpc/concepts/network.md#subnet);
            * [группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к кластеру {{ mos-name }};
            * кластер {{ mos-name }}.

        1. Укажите в файле `opensearch-index-policy.tf` переменные:

            * `version` — версия {{ OS }}.
            * `admin_password` — пароль администратора {{ OS }}.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

    {% endlist %}

1. [Установите SSL-сертификат](../../managed-opensearch/operations/connect.md#ssl-certificate).

1. Проверьте подключение к кластеру с помощью утилиты [cURL](https://curl.haxx.se/):

    {% include [default-connstring](../../_includes/mdb/mos/default-connstring.md) %}

    FQDN хоста можно получить со [списком хостов в кластере](../../managed-opensearch/operations/host-groups.md#list-hosts).

    При успешном подключении будет выведено похожее сообщение:

    ```bash
    {
      "name" : "....{{ dns-zone }}",
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
        --request PUT 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:9200/_plugins/_ism/policies/rollover_policy' \
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
        --request PUT 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:9200/_index_template/ism_rollover?pretty' \
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
        --request PUT 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:9200/log-000001?pretty' \
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
        --request GET 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:9200/_plugins/_ism/explain/log-000001?pretty'
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
        --request POST 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:9200/log/_doc?pretty' \
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
        --request GET '<адрес_хоста_{{ OS }}_с_ролью_DATA>:9200/_cat/indices?pretty'
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

    [Удалите кластер {{ mos-name }}](../../managed-opensearch/operations/cluster-delete.md).

- С помощью {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
