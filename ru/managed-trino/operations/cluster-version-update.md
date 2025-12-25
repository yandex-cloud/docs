---
title: Как изменить версию кластера {{ TR }} в {{ mtr-name }}
description: Следуя данной инструкции, вы сможете изменить версию кластера {{ TR }}.
---

# Обновление версии {{ TR }}

Вы можете изменить версию {{ TR }} на любую из [поддерживаемых](#available-versions) в {{ mtr-name }}. Версию можно как повысить, так и понизить.

Обновления и исправления внутри одной версии устанавливаются во время [технического обслуживания](../concepts/maintenance.md) автоматически.

## Получить список доступных версий {#available-versions}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}).
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Выберите кластер и нажмите на панели сверху кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**. Откроется страница редактирования кластера.
      
        Список доступных версий можно посмотреть в поле **{{ ui-key.yacloud.mdb.forms.base_field_version }}**.

{% endlist %}

## Перед обновлением версии {#before-update}

Убедитесь, что обновление не нарушит работу ваших приложений:

1. Посмотрите в [истории изменений](https://trino.io/docs/current/release.html) {{ TR }}, как обновления могут повлиять на работу ваших приложений.
1. Попробуйте обновить версию {{ TR }} на тестовом кластере.

## Обновить версию {#update}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}).
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Выберите кластер и нажмите на панели сверху кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}** выберите версию {{ TR }}.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить версию {{ TR }}:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-tr }} cluster update --help
        ```

    2. Измените версию, выполнив команду:

        ```bash
        {{ yc-mdb-tr }} cluster update <имя_или_идентификатор_кластера> \
          --version <версия_{{ TR }}>
        ```

        Имя и идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.   

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
        
    1. Измените в описании кластера значение параметра `version`:
      
        ```hcl
        resource "yandex_trino_cluster" "<имя_кластера>" {
          ...
          version = "<версия_{{ TR }}>"
          ...
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "updateMask": "trino.version",
          "trino": {
            "version": "<версия_{{ TR }}>"
          }
        }
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в строку через запятую.

            {% note warning %}

            При изменении кластера все параметры изменяемого объекта, которые не были явно переданы в запросе, будут переопределены на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask`.

            {% endnote %}

        * `trino.version` — версия {{ TR }}.

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<идентификатор_кластера>'
          --data '@body.json'
        ```

        Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "cluster_id": "<идентификатор_кластера>",
          "update_mask": {
            "paths": [
              "trino.version"
            ]
          },
          "trino": {
            "version": "<версия_{{ TR }}>"
          }
        }
        ```

        Где:

        * `cluster_id` — идентификатор кластера.
            
            Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            {% cut "Формат перечисления настроек" %}

            ```yaml
            "update_mask": {
              "paths": [
                "<настройка_1>",
                "<настройка_2>",
                ...
                "<настройка_N>"
              ]
            }
            ```

            {% endcut %}

            {% note warning %}

            При изменении кластера все параметры изменяемого объекта, которые не были явно переданы в запросе, будут переопределены на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask`.

            {% endnote %}

        * `version` — версия {{ TR }}.

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/trino/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          {{ api-host-trino }}:{{ port-https }} \
          yandex.cloud.trino.v1.ClusterService.Update \
          < body.json
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}