---
title: Как изменить версию {{ SPRK }} в кластере {{ msp-full-name }}
description: Следуя данной инструкции, вы сможете изменить версию {{ SPRK }} в кластере {{ msp-full-name }}.
---

# Обновление версии {{ SPRK }}

Вы можете изменить версию {{ SPRK }} на любую из [поддерживаемых](#available-versions) в {{ msp-name }}.

Обновления и исправления внутри одной версии устанавливаются во время технического обслуживания автоматически.

## Получить список доступных версий {#available-versions}

{% note info %}

Если для работы с версиями вы используете окружения, то информация о версии указана в названии базового окружения.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог.
    1. [Перейдите]({{ link-console-main }}/link/managed-spark) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Выберите кластер и нажмите на панели сверху кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**. Откроется страница редактирования кластера.
      
        Список доступных версий можно посмотреть в поле **{{ ui-key.yacloud.mdb.forms.base_field_version }}**.

{% endlist %}

## Перед обновлением версии {#before-update}

Убедитесь, что обновление не нарушит работу ваших приложений:

1. Посмотрите в [истории изменений](https://spark.apache.org/news/) {{ SPRK }}, как обновления могут повлиять на работу ваших приложений.
1. Попробуйте обновить версию {{ SPRK }} на тестовом кластере.

## Обновить версию {#update}

Способ обновления версии {{ SPRK }} зависит от того, как в кластере заданы зависимости:

* Если в поле **{{ ui-key.yacloud.spark.ClusterForm.DependenciesSection.title_dependencies-type_wJq6n }}** выбрано значение **{{ ui-key.yacloud.spark.ClusterForm.DependenciesSection.title_software-configuration-type-packages_wJq6n }}**, [измените версию в настройках кластера](#update-with-packages).

  {% note warning %}
  
  Данный способ устарел и скоро будет недоступен. Рекомендуется использовать окружения для работы с различными версиями {{ SPRK }}.
  
  {% endnote %}
  
* Если в поле **{{ ui-key.yacloud.spark.ClusterForm.DependenciesSection.title_dependencies-type_wJq6n }}** выбрано значение **{{ ui-key.yacloud.spark.ClusterForm.DependenciesSection.title_software-configuration-type-environment_wJq6n }}**, выберите базовое окружение (версия {{ SPRK }} и Python) или [подключите к кластеру пользовательское окружение с нужной версией](#update-with-environment). Версия {{ SPRK }} фиксирована внутри окружения и отдельно в настройках кластера не задается.

### Кластер использует пакеты, добавленные вручную {#update-with-packages}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог.
    1. [Перейдите]({{ link-console-main }}/link/managed-spark) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Выберите кластер и нажмите на панели сверху кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_additional }}** перейдите к полю **{{ ui-key.yacloud.spark.ClusterForm.DependenciesSection.title_dependencies-type_wJq6n }}** → **{{ ui-key.yacloud.spark.ClusterForm.DependenciesSection.title_software-configuration-type-packages_wJq6n }}** выберите версию {{ SPRK }}.
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

        Инструкция по созданию файла описана в разделе [Создание кластера](cluster-create.md).
        
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

### Кластер использует окружение {#update-with-environment}

Кластер может использовать базовое или пользовательское окружение. 

Базовое окружение содержит только версию {{ SPRK }} и версию Python. Его можно выбрать во время [создания](cluster-create.md) или [изменения кластера](cluster-update.md#change-additional-settings).

Пользовательское окружение содержит базовое окружение и список необходимых pip- и deb-пакетов, которые позволяют установить в кластер дополнительные библиотеки и приложения. Список пакетов пользователь задает самостоятельно. Список пакетов и версию {{ SPRK }} нельзя изменить в уже созданном пользовательском окружении. Чтобы обновить версию {{ SPRK }}, подготовьте пользовательское окружение с нужной версией и подключите его к кластеру.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Подготовьте окружение с нужной версией {{ SPRK }} одним из способов:

        * [Создайте новое окружение](environment-create.md#create-env)
        * [Создайте новое окружение на основе существующего](environment-create.md#create-copy-env)

    1. В [консоли управления]({{ link-console-main }}) выберите каталог с нужным кластером.
    1. [Перейдите]({{ link-console-main }}/link/managed-spark) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Выберите кластер и нажмите на панели сверху кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_additional }}** в поле **{{ ui-key.yacloud.spark.ClusterForm.DependenciesSection.title_dependencies-type_wJq6n }}** → **{{ ui-key.yacloud.spark.ClusterForm.DependenciesSection.title_software-configuration-type-environment_wJq6n }}** выберите подготовленное окружение.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- gRPC API {#grpc-api}

    1. [Подготовьте окружение](environment-create.md#create-env) с нужной версией {{ SPRK }}.

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "cluster_id": "<идентификатор_кластера>",
          "update_mask": {
            "paths": [
              "config_spec.environment_id"
            ]
          },
          "config_spec": {
            "environment_id": "<идентификатор_окружения>"
          }
        }
        ```

        Где:

        * `cluster_id` — идентификатор кластера. Его можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге;
        * `environment_id` — идентификатор окружения с нужной версией {{ SPRK }}. Идентификатор пользовательского окружения можно получить с помощью вызова [EnvironmentService/List](../environment/api-ref/grpc/Environment/list.md), базового окружения — с помощью вызова [EnvironmentService/ListBase](../environment/api-ref/grpc/Environment/listBase.md).

    1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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
