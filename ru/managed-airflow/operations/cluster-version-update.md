---
title: Обновление версии {{ AF }} и Python
description: Следуя этой инструкции, вы сможете обновить кластер {{ maf-name }}.
---

# Обновление версии {{ AF }} и Python

Со списком поддерживаемых версий можно ознакомиться в разделе [Версионирование](../concepts/versions.md).

{% include [version-update-rules](../../_includes/managed-airflow/version-update-rules.md) %}

Об обновлениях в рамках одной версии и обслуживании хостов см. в разделе [Техническое обслуживание](../concepts/maintenance.md).

{% note alert %}

Перед обновлением убедитесь, что это не нарушит работу ваших приложений — изучите [историю изменений {{ AF }}](https://airflow.apache.org/docs/apache-airflow/stable/release_notes.html) и [Python](https://www.python.org/downloads/).

После обновления версии {{ AF }} вернуть кластер к предыдущей версии невозможно.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы обновить версию {{ AF }} или Python:

    1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
    1. В строке с нужным кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_version }}** выберите нужную версию {{ AF }} и Python.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы обновить версию {{ AF }} или Python:

    1. Получите список ваших кластеров {{ maf-name }}:

        ```bash
        {{ yc-mdb-af }} cluster list
        ```

    1. Получите информацию о нужном кластере и проверьте версии в свойствах `config.airflow_version` и `config.python_version`:

        ```bash
        {{ yc-mdb-af }} cluster get <имя_или_идентификатор_кластера>
        ```

    1. Чтобы обновить версию {{ AF }}, выполните команду:

        ```bash
        {{ yc-mdb-af }} cluster update <имя_или_идентификатор_кластера> \
          --airflow-version=<номер_новой_версии>
        ```

    1. Чтобы обновить версию Python, выполните команду:

        ```bash
        {{ yc-mdb-af }} cluster update <имя_или_идентификатор_кластера> \
          --python-version=<номер_новой_версии>
        ```

- {{ TF }} {#tf}

    Чтобы обновить версию {{ AF }} или Python:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Добавьте к описанию кластера параметр `airflow_version` или `python_version` или измените его значение, если он уже существует:

        ```hcl
        resource "yandex_airflow_cluster" "<имя_кластера>" {
          ...
          airflow_version = "<версия_Apache_Airflow™>"
          python_version  = "<версия_Python>"
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-maf }}).

- REST API {#api}

    Чтобы обновить версию {{ AF }} или Python:

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}.

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        * Чтобы обновить версию {{ AF }}, выполните запрос:

            ```bash
            curl \
                --request PATCH \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://{{ api-host-airflow }}/managed-airflow/v1/clusters/<идентификатор_кластера>' \
                --data '{
                          "updateMask": "airflowVersion",
                          "airflowVersion": "<версия_Apache_Airflow™>"
                        }'
            ```

           Где:

            * `updateMask` — перечень изменяемых параметров. Укажите только параметр `airflowVersion`.

            * `airflowVersion` — версия {{ AF }}, до которой нужно обновиться.

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

        * Чтобы обновить версию Python, выполните запрос:

            ```bash
            curl \
                --request PATCH \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://{{ api-host-airflow }}/managed-airflow/v1/clusters/<идентификатор_кластера>' \
                --data '{
                          "updateMask": "pythonVersion",
                          "pythonVersion": "<версия_Python>"
                        }'
            ```

            Где:

            * `updateMask` — перечень изменяемых параметров. Укажите только параметр `pythonVersion`.

            * `pythonVersion` — версия Python, до которой нужно обновиться.

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    Чтобы обновить версию {{ AF }} или Python:

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        * Чтобы обновить версию {{ AF }}, выполните запрос:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/airflow/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                      "cluster_id": "<идентификатор_кластера>",
                      "update_mask": {
                        "paths": [
                          "airflow_version"
                        ]
                      },
                      "airflow_version": "<версия_Apache_Airflow™>"
                    }' \
                {{ api-host-airflow }}:{{ port-https }} \
                yandex.cloud.airflow.v1.ClusterService.Update
            ```

            Где:

            * `update_mask` — перечень изменяемых параметров. Укажите только параметр `airflow_version`.

            * `airflow_version` — версия {{ AF }}, до которой нужно обновиться.

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

        * Чтобы обновить версию Python, выполните запрос:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/airflow/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                      "cluster_id": "<идентификатор_кластера>",
                      "update_mask": {
                        "paths": [
                          "python_version"
                        ]
                      },
                      "python_version": "<версия_Python>"
                    }' \
                {{ api-host-airflow }}:{{ port-https }} \
                yandex.cloud.airflow.v1.ClusterService.Update
            ```

            Где:

            * `update_mask` — перечень изменяемых параметров. Укажите только параметр `python_version`.

            * `python_version` — версия Python, до которой нужно обновиться.

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Примеры {#examples}

Допустим, нужно обновить версию {{ AF }} с `2.10` до `2.11`, а версию Python — с `3.10` до `3.12`.

{% list tabs group=instructions %}

- CLI {#cli}

    1. Чтобы получить список кластеров и узнать их идентификаторы и имена, выполните команду:

        ```bash
        {{ yc-mdb-af }} cluster list
        ```

        ```text
        +----------------------+------------+---------------------+--------+---------+
        |          ID          |    NAME    |     CREATED AT      | HEALTH | STATUS  |
        +----------------------+------------+---------------------+--------+---------+
        | c9qqhh2u3r20******** | airflow411 | 2026-02-26 15:39:33 | ALIVE  | RUNNING |
        +----------------------+------------+---------------------+--------+---------+
        ```

    1. Чтобы получить информацию о кластере с именем `airflow411`, выполните команду:

        ```bash
        {{ yc-mdb-af }} cluster get airflow411
        ```

        Результат:

        ```text
        id: c9qqhh2u3r20********
        ...
        config:
          ...
          airflow-version: "2.10"
          python-version: "3.10"
        ```

    1. Для обновления версии {{ AF }} до `2.11` выполните команду:

        ```bash
        {{ yc-mdb-af }} cluster update airflow411 \
          --airflow-version=2.11
        ```

        Дождитесь завершения операции.

    1. Для обновления версии Python до `3.12` выполните команду:

        ```bash
        {{ yc-mdb-af }} cluster update airflow411 \
          --python-version=3.12
        ```

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
    1. В описании кластера укажите в поле `airflow_version` значение `2.11`:

        ```hcl
        resource "yandex_airflow_cluster" "<имя_кластера>" {
          ...
          airflow_version = "2.11"
          ...
        }
        ```

    1. Примените изменения:

        ```bash
        terraform apply
        ```

    1. В поле `python_version` укажите значение `3.12`:

        ```hcl
        resource "yandex_airflow_cluster" "<имя_кластера>" {
          ...
          python_version = "3.12"
          ...
        }
        ```

    1. Примените изменения еще раз:

        ```bash
        terraform apply
        ```

{% endlist %}

#### См. также {#see-also}

* [Версионирование в {{ maf-name }}](../concepts/versions.md)
* [Политика работы с версиями {{ AF }}](../concepts/update-policy.md)
