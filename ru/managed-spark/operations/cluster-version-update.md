---
title: Как изменить версию {{ SPRK }} в кластере {{ msp-full-name }}
description: Следуя данной инструкции, вы сможете изменить версию {{ SPRK }} в кластере {{ msp-full-name }}.
---

# Обновление версии {{ SPRK }}

Вы можете изменить версию {{ SPRK }} на любую из [поддерживаемых](#available-versions) в {{ msp-name }}. Версию можно только повысить.

Обновления и исправления внутри одной версии устанавливаются во время технического обслуживания автоматически.

## Получить список доступных версий {#available-versions}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}).
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Выберите кластер и нажмите на панели сверху кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**. Откроется страница редактирования кластера.
      
        Список доступных версий можно посмотреть в поле **{{ ui-key.yacloud.mdb.forms.base_field_version }}**.

{% endlist %}

## Перед обновлением версии {#before-update}

Убедитесь, что обновление не нарушит работу ваших приложений:

1. Посмотрите в [истории изменений](https://spark.apache.org/news/) {{ SPRK }}, как обновления могут повлиять на работу ваших приложений.
1. Попробуйте обновить версию {{ SPRK }} на тестовом кластере.

## Обновить версию {#update}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}).
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Выберите кластер и нажмите на панели сверху кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}** выберите версию {{ SPRK }}.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить версию {{ SPRK }}:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-sp }} cluster update --help
        ```

    2. Измените версию, выполнив команду:

        ```bash
        {{ yc-mdb-sp }} cluster update <имя_или_идентификатор_кластера> \
          --spark-version <версия_Apache_Spark>
        ```

        Имя и идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.   

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ SPRK }} с планом инфраструктуры.

        Как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
        
    1. Измените в описании кластера значение параметра `spark_version`:
      
        ```hcl
        resource "yandex_spark_cluster" "<имя_кластера>" {
          ...
          config = {
            ...
            spark_version = "<версия_Apache_Spark>"
            ...
          }
          ...
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

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
              "config_spec.spark_version"
            ]
          },
          "config_spec": {
            "spark_version": "<версия_Apache_Spark>"
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

        * `spark_version` — версия {{ SPRK }}.

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/spark/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          {{ api-host-spark }}:{{ port-https }} \
          yandex.cloud.spark.v1.ClusterService.Update \
          < body.json
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}