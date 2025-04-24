---
title: Обновление версии {{ KF }}
description: Следуя этой инструкции, вы сможете обновить кластер {{ mkf-name }}.
---

# Обновление версии {{ KF }}


{% note info %}

С 1 марта 2025 года прекращена поддержка {{ KF }} версий 2.8, 3.0, 3.1, 3.2 и 3.3. Создать кластер с этими версиями невозможно. Рекомендуется обновить существующие кластеры до версии 3.5.

{% endnote %}


Вы можете обновить кластер {{ mkf-name }} до версии 3.5 или ниже. Обновление до версии 3.6 и выше не поддерживается, но можно [создать кластер](cluster-create.md#create-cluster) с одной из таких версий.

Рекомендуется обновлять версию {{ KF }} поэтапно, без пропуска версий. Например, обновление версии с 3.1 до 3.5 выполняется в такой последовательности: 3.1 → 3.2 → 3.3 → 3.4 → 3.5.

Об обновлениях в рамках одной версии и обслуживании хостов см. в разделе [Техническое обслуживание](../concepts/maintenance.md).

## Перед обновлением версии {#before-update}

Убедитесь, что это не нарушит работу ваших приложений — изучите [историю изменений](https://kafka.apache.org/downloads) {{ KF }}.

## Обновить кластер {#start-update}

{% note alert %}

После обновления версии {{ KF }} вернуть кластер к предыдущей версии невозможно.

{% endnote %}

Во время обновления топики могут быть недоступны, если их [фактор репликации](../concepts/settings-list.md#settings-topic-replication-factor) равен единице.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. В строке с нужным кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_version }}** выберите номер новой версии.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Получите список ваших кластеров {{ mkf-short-name }}:

        ```bash
        {{ yc-mdb-kf }} cluster list
        ```

    1. Получите информацию о нужном кластере и проверьте версию в свойстве `config.version`:

        ```bash
        {{ yc-mdb-kf }} cluster get <имя_или_идентификатор_кластера>
        ```

    1. Запустите обновление {{ KF }}:

        ```bash
        {{ yc-mdb-kf }} cluster update <имя_или_идентификатор_кластера> \
           --version=<номер_новой_версии>
        ```

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Добавьте в блок `config` нужного кластера {{ mkf-name }} поле `version` (версия {{ KF }}) или измените его значение, если оно уже существует:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
          ...
          config {
            version = "<версия>"
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mkf }}).

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            -url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "configSpec.version",
                      "configSpec": {
                        "version": "<версия>"
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

          В данном случае указан только один параметр: `configSpec.version`.

        * `configSpec.version` — версия {{ KF }}, до которой нужно обновиться: {{ versions.cli.str-without-latest }}.

       Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [
                      "config_spec.version"
                    ]
                  },
                  "config_spec": {
                    "version": "<версия>"
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.kafka.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

          В данном случае указан только один параметр: `config_spec.version`.

        * `config_spec.version` — версия {{ KF }}, до которой нужно обновиться: {{ versions.cli.str-without-latest }}.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Примеры {#examples}

Допустим, нужно обновить кластер с версии 2.8 до версии 3.0.

{% list tabs group=instructions %}

- CLI {#cli}

    1. Чтобы получить список кластеров и узнать их идентификаторы и имена, выполните команду:

        ```bash
        {{ yc-mdb-kf }} cluster list
        ```

        ```text
        +----------------------+---------------+---------------------+--------+---------+
        |          ID          |     NAME      |     CREATED AT      | HEALTH | STATUS  |
        +----------------------+---------------+---------------------+--------+---------+
        | c9q8p8j2gaih******** |    kafka35    | 2021-10-23 12:44:17 | ALIVE  | RUNNING |
        +----------------------+---------------+---------------------+--------+---------+
        ```

    1. Чтобы получить информацию о кластере с именем `kafka35`, выполните команду:

        ```bash
        {{ yc-mdb-kf }} cluster get kafka35
        ```

        ```text
          id: c9q8p8j2gaih********
          ...
          config:
            version: "2.8"
            ...
        ```

    1. Для обновления кластера `kafka35` до версии 3.0 выполните команду:

        ```bash
        {{ yc-mdb-kf }} cluster update kafka35 --version=3.0
        ```

{% endlist %}
