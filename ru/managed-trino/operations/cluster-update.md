---
title: Изменение кластера {{ TR }}
description: После создания кластера {{ TR }} вы можете изменить его основные и дополнительные настройки.
keywords:
  - изменение кластера {{ TR }}
  - кластер {{ TR }}
  - '{{ TR }}'
---

# Изменение кластера {{ TR }}

После создания кластера вы можете изменить его настройки:

* [имя и описание кластера](#change-basic-settings);
* [сервисный аккаунт](#change-sa);
* [группы безопасности](#change-sg);
* [параметры отказоустойчивого выполнения запросов](#change-retry-policy);
* [конфигурацию координатора и воркеров](#change-configuration);
* [дополнительные настройки кластера](#change-additional-settings).

## Изменить имя и описание кластера {#change-basic-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}** измените имя и описание кластера.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить имя и описание кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-tr }} cluster update --help
        ```

    2. Измените имя и описание кластера, выполнив команду:

        ```bash
        {{ yc-mdb-tr }} cluster update <имя_или_идентификатор_кластера> \
          --new-name <имя_кластера> \
          --description <описание_кластера> 
        ```

        Где:

        * `--new-name` — уникальное имя кластера в рамках облака.
        * `--description` — описание кластера.

        Имя и идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.   

- {{ TF }} {#tf}

    {% note alert %}

    Не изменяйте имя кластера с помощью {{ TF }}. Это приведет к удалению существующего кластера и созданию нового.

    {% endnote %}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
        
    1. Измените в описании кластера значение параметра `description`:
      
        ```hcl
        resource "yandex_trino_cluster" "<имя_кластера>" {
          ...
          description = "<описание_кластера>"
          ...
        }
        ```

        Где `description` — описание кластера.

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
          "updateMask": "<список_изменяемых_параметров>",
          "name": "<имя_кластера>",
          "description": "<описание_кластера>"
        }
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в строку через запятую.

            {% note warning %}

            При изменении кластера будут переопределены все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask`.

            {% endnote %}

        * `name` — уникальное имя кластера в рамках облака.
        * `description` — описание кластера.

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

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
              <список_изменяемых_параметров>
            ]
          },
          "name": "<имя_кластера>",
          "description": "<описание_кластера>"
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

            При изменении кластера будут переопределены все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask`.

            {% endnote %}

        * `name` — уникальное имя кластера в рамках облака.
        * `description` — описание кластера.

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить сервисный аккаунт {#change-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}** выберите сервисный аккаунт или [создайте новый](../../iam/operations/sa/create.md#create-sa) с ролями `managed-trino.integrationProvider` и `storage.editor`. Это даст кластеру нужные права для работы с пользовательскими ресурсами. Подробнее см. в разделе [Имперсонация](../concepts/impersonation.md).

        Для изменения сервисного аккаунта в кластере {{ mtr-name }} [убедитесь](../../iam/operations/roles/get-assigned-roles.md), что вашему аккаунту в {{ yandex-cloud }} назначена роль [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) или выше.

        {% include [mdb-service-account-update](../../_includes/mdb/service-account-update.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить сервисный аккаунт:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-tr }} cluster update --help
        ```

    2. Измените сервисный аккаунт, выполнив команду:

        ```bash
        {{ yc-mdb-tr }} cluster update <имя_или_идентификатор_кластера> \
          --service-account-id <идентификатор_сервисного_аккаунта>
        ```

        Где `--service-account-id` — идентификатор сервисного аккаунта.

        Имя и идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.   

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените в описании кластера значение параметра `service_account_id`:
      
        ```hcl
        resource "yandex_trino_cluster" "<имя_кластера>" {
          ...
          service_account_id  = "<идентификатор_сервисного_аккаунта>"
          ...
        }
        ```

        Где `service_account_id` — идентификатор сервисного аккаунта.

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
          "updateMask": "serviceAccountId",
          "serviceAccountId": "<идентификатор_сервисного_аккаунта>"
        }
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в строку через запятую.

            {% note warning %}

            При изменении кластера будут переопределены все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask`.

            {% endnote %}

        * `serviceAccountId` — идентификатор сервисного аккаунта.

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

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
              "service_account_id"
            ]
          },
          "service_account_id": "<идентификатор_сервисного_аккаунта>"
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

            При изменении кластера будут переопределены все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask`.

            {% endnote %}

        * `service_account_id` — идентификатор сервисного аккаунта.

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить группы безопасности {#change-sg}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите группы безопасности для кластера.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить группы безопасности:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-tr }} cluster update --help
        ```

    2. Измените группы безопасности, выполнив команду:

        ```bash
        {{ yc-mdb-tr }} cluster update <имя_или_идентификатор_кластера> \
          --security-group-ids <список_идентификаторов_групп_безопасности>
        ```

        Где `--security-group-ids` — список идентификаторов групп безопасности.

        Имя и идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.   

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените в описании кластера значение параметра `security_group_ids`:
      
        ```hcl
        resource "yandex_trino_cluster" "<имя_кластера>" {
          ...
          security_group_ids  = [<список_идентификаторов_групп_безопасности>]
          ...
        }
        ```

        Где `security_group_ids` — список идентификаторов групп безопасности.

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
          "updateMask": "networkSpec.securityGroupIds",
          "networkSpec": {
            "securityGroupIds": [
              <список_идентификаторов_групп_безопасности>
            ]
          }
        }
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в строку через запятую.

            {% note warning %}

            При изменении кластера будут переопределены все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask`.

            {% endnote %}

        * `networkSpec` — сетевые настройки:
          
            * `securityGroupIds` — список идентификаторов групп безопасности.

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

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
              "network_spec.security_group_ids"
            ]
          },
          "network_spec": {
            "security_group_ids": [ <список_идентификаторов_групп_безопасности> ]
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

            При изменении кластера будут переопределены все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask`.

            {% endnote %}

        * `network_spec` — сетевые настройки:

            * `security_group_ids` — список идентификаторов групп безопасности.

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить параметры отказоустойчивого выполнения запросов {#change-retry-policy}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
    1. В блоке **Политика перезапросов** измените параметры [отказоустойчивого выполнения запросов](../concepts/retry-policy.md):
        
        * Измените **Тип объекта для перезапроса**.
        
        * Добавьте или удалите в поле **Параметры перезапросов** дополнительные параметры в формате `ключ: значение`. Подробнее о параметрах см. в [документации {{ TR }}](https://trino.io/docs/current/admin/fault-tolerant-execution.html#advanced-configuration).
        
        * Добавьте или удалите в поле **Параметры хранилища** дополнительные параметры хранилища Exchange Manager в формате `ключ: значение`. Подробнее о параметрах см. в [документации {{ TR }}](https://trino.io/docs/current/admin/fault-tolerant-execution.html#id1).

    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить параметры [отказоустойчивого выполнения запросов](../concepts/retry-policy.md):

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-tr }} cluster update --help
        ```

    2. Измените параметры [отказоустойчивого выполнения запросов](../concepts/retry-policy.md), выполнив команду:

        ```bash
        {{ yc-mdb-tr }} cluster update <имя_или_идентификатор_кластера> \
          --retry-policy-enabled \ 
          --retry-policy <тип_объекта_для_перезапроса> \
          --retry-policy-additional-properties <список_дополнительных_параметров> \
          --retry-policy-exchange-manager-service-s3 \
          --retry-policy-exchange-manager-additional-properties <список_дополнительных_параметров>
        ```

        Где:

        * `--retry-policy-enabled` — включает политику перезапросов.
          
        * `--retry-policy` — способ повторного выполнения запросов. Возможные значения:

            * `query` — повторно выполняются все [этапы запроса](../concepts/index.md#query-execution), в котором произошел сбой воркера.
            * `task` — в рамках запроса повторно выполняется промежуточное задание, вызвавшее сбой воркера.

        * `--retry-policy-additional-properties` — дополнительные параметры перезапросов в формате `<ключ>=<значение>`. [Подробнее о параметрах в документации {{ TR }}]({{ tr.docs }}/admin/fault-tolerant-execution.html#advanced-configuration).
          
        * `--retry-policy-exchange-manager-service-s3` — включает использование служебного бакета Object Storage в качестве хранилища Exchange Manager для промежуточных данных.
          
        * `--retry-policy-exchange-manager-additional-properties` — дополнительные параметры хранилища Exchange Manager в формате `<ключ>=<значение>`. [Подробнее о параметрах в документации {{ TR }}]({{ tr.docs }}/admin/fault-tolerant-execution.html#id1).

        Имя и идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.   

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Чтобы включить политику [отказоустойчивого выполнения запросов](../concepts/retry-policy.md), добавьте к описанию кластера блок `retry_policy`:
      
        {% include [Terraform retry policy parameters description](../../_includes/managed-trino/terraform/retry-policy-parameters.md) %}

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
          "updateMask": "<список_изменяемых_параметров>",
          "trino": {
            "retryPolicy": {
              "policy": "<тип_объекта_для_перезапроса>",
              "exchangeManager": {
                "storage": {
                  "serviceS3": {}
                },
                "additionalProperties": {<дополнительные_параметры_хранилища>}
              },
              "additionalProperties": {<дополнительные_параметры_перезапросов>}
            }
          }
        }
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в строку через запятую.

            {% note warning %}

            При изменении кластера будут переопределены все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask`.

            {% endnote %}

        * `trino.retryPolicy` — параметры [отказоустойчивого выполнения запросов](../concepts/retry-policy.md).

            * `policy` – способ повторного выполнения запросов. Возможные значения:

                * `TASK` — в рамках запроса повторно выполняется промежуточное задание, вызвавшее сбой воркера.
                * `QUERY` – повторно выполняются все [этапы запроса](../concepts/index.md#query-execution), в котором произошел сбой воркера.

            * `exchangeManager.additionalProperties` – дополнительные параметры хранилища Exchange Manager в формате `ключ: значение`. Подробнее о параметрах см. в [документации {{ TR }}](https://trino.io/docs/current/admin/fault-tolerant-execution.html#id1).

            * `additionalProperties` – дополнительные параметры в формате `ключ: значение`. Подробнее о параметрах см. в [документации {{ TR }}](https://trino.io/docs/current/admin/fault-tolerant-execution.html#advanced-configuration).

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

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
              <список_изменяемых_параметров>
            ]
          },
          "trino": {
            "retry_policy": {
              "policy": "<тип_объекта_для_перезапроса>",
              "exchange_manager": {
                "storage": {
                  "service_s3": ""
                },
                "additional_properties": {<дополнительные_параметры_хранилища>}
              },
              "additional_properties": {<дополнительные_параметры_перезапросов>}
            }
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

            При изменении кластера будут переопределены все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask`.

            {% endnote %}

        * `trino.retry_policy` – параметры [отказоустойчивого выполнения запросов](../concepts/retry-policy.md).

            * `policy` – способ повторного выполнения запросов. Возможные значения:

                * `TASK` — в рамках запроса повторно выполняется промежуточное задание, вызвавшее сбой воркера.
                * `QUERY` – повторно выполняются все [этапы запроса](../concepts/index.md#query-execution), в котором произошел сбой воркера.

            * `exchange_manager.additional_properties` – дополнительные параметры хранилища Exchange Manager в формате `ключ: значение`. Подробнее о параметрах см. в [документации {{ TR }}](https://trino.io/docs/current/admin/fault-tolerant-execution.html#id1).

            * `additional_properties` – дополнительные параметры в формате `ключ: значение`. Подробнее о параметрах см. в [документации {{ TR }}](https://trino.io/docs/current/admin/fault-tolerant-execution.html#advanced-configuration).

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить конфигурацию координатора и воркеров {#change-configuration}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
    1. Измените конфигурацию [координатора](../concepts/index.md#coordinator) и [воркеров](../concepts/index.md#workers).
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить конфигурацию [координатора](../concepts/index.md#coordinator) и [воркеров](../concepts/index.md#workers):

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-tr }} cluster update --help
        ```

    2. Измените конфигурацию [координатора](../concepts/index.md#coordinator) и [воркеров](../concepts/index.md#workers), выполнив команду:

        ```bash
        {{ yc-mdb-tr }} cluster update <имя_или_идентификатор_кластера> \
          --coordinator resource-preset-id=<класс_хостов> \
          --worker count=<количество_экземпляров>,`
                  `min-count=<минимальное_количество_экземпляров>,`
                  `max-count=<максимальное_количество_экземпляров>,`
                  `resource-preset-id=<класс_хостов>
        ```

        Где:

        * `--coordinator` — конфигурация [координатора](../concepts/index.md#coordinator):
            
            * `resource-preset-id` — [класс хостов](../concepts/instance-types.md) координатора.
        
        * `--worker` — конфигурация [воркера](../concepts/index.md#workers):

            * `resource-preset-id` — [класс хостов](../concepts/instance-types.md) воркера.
                
            * `count` — количество воркеров.
            * `min-count` — минимальное количество воркеров.
            * `max-count` — максимальное количество воркеров.
                
            Чтобы количество воркеров автоматически изменялось в зависимости от нагрузки, используйте `min-count` и `max-count`. Если требуется задать фиксированное число воркеров, используйте `count`.

        Имя и идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.   

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените конфигурацию [координатора](../concepts/index.md#coordinator) и [воркеров](../concepts/index.md#workers) в блоках `coordinator` и `worker`:
      
        ```hcl
        resource "yandex_trino_cluster" "<имя_кластера>" {
          ...
          coordinator = {
            resource_preset_id = "<класс_вычислительных_ресурсов>"
          }
          
          worker = {
            fixed_scale = {
              count = <количество_экземпляров>
            }
            auto_scale = {
              max_count=<минимальное_количество_экземпляров>
              min_count=<максимальное_количество_экземпляров>
            }
            resource_preset_id = "<класс_вычислительных_ресурсов>"
          }
          ...
        }
        ```
        
        Где:
        
        * `coordinator` — конфигурация [координатора](../concepts/index.md#coordinator):
            
            * `resource_preset_id` — [класс хостов](../concepts/instance-types.md) координатора.

        * `worker` — конфигурация [воркера](../concepts/index.md#workers):
        
            * `resource_preset_id` — [класс хостов](../concepts/instance-types.md) воркера.
            
            * `fixed_scale` — фиксированное количество воркеров.
                
                * `count` — количество воркеров.

            * `auto_scale` — автоматическое масштабирование количества воркеров.
                
                * `min_count` — минимальное количество воркеров.
                * `max_count` — максимальное количество воркеров.
            
            Чтобы количество воркеров автоматически изменялось в зависимости от нагрузки, используйте блок `auto_scale` и задайте минимальное и максимальное значения. Для фиксированного числа воркеров используйте блок `fixed_scale` и укажите требуемое значение.

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
          "updateMask": "<список_изменяемых_параметров>",
          "trino": {
            "coordinatorConfig": {
              "resources": {
                "resourcePresetId": "<класс_хостов>"
              }
            },
            "workerConfig": {
              "resources": {
                "resourcePresetId": "<класс_хостов>"
              },
              "scalePolicy": {
                "fixedScale": {
                  "count": "<количество_экземпляров>"
                },
                "autoScale": {
                  "minCount": "<минимальное_количество_экземпляров>",
                  "maxCount": "<максимальное_количество_экземпляров>"
                }
              }
            }
          }
        }
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в строку через запятую.

            {% note warning %}

            При изменении кластера будут переопределены все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask`.

            {% endnote %}

        * `trino.coordinatorConfig` — конфигурация [координатора](../concepts/index.md#coordinator):

            * `resources.resourcePresetId` — [класс хостов](../concepts/instance-types.md) координатора.
              
        * `trino.workerConfig` — конфигурация [воркера](../concepts/index.md#workers):

            * `resources.resourcePresetId` — [класс хостов](../concepts/instance-types.md) воркера.

            * `scalePolicy.fixedScale` — фиксированное количество воркеров.
                
                * `count` — количество воркеров.

            * `scalePolicy.autoScale` — автоматическое масштабирование количества воркеров.

                * `minCount` — минимальное количество воркеров.
                * `maxCount` — максимальное количество воркеров.

            Чтобы количество воркеров автоматически изменялось в зависимости от нагрузки, используйте настройку `scalePolicy.autoScale` и задайте минимальное и максимальное значения. Для фиксированного числа воркеров используйте настройку `scalePolicy.fixedScale` и укажите требуемое значение.

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

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
              <список_изменяемых_параметров>
            ]
          },
          "trino": {
            "coordinator_config": {
              "resources": {
                "resource_preset_id": "<класс_хостов>"
              }
            },
            "worker_config": {
              "resources": {
                "resource_preset_id": "<класс_хостов>"
              },
              "scale_policy": {
                "fixed_scale": {
                  "count": "<количество_экземпляров>"
                },
                "auto_scale": {
                  "min_count": "<минимальное_количество_экземпляров>",
                  "max_count": "<максимальное_количество_экземпляров>"
                }
              }
            }
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

            При изменении кластера будут переопределены все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask`.

            {% endnote %}

        * `trino.coordinator_config"` — конфигурация [координатора](../concepts/index.md#coordinator):

            * `resources.resource_preset_id` — [класс хостов](../concepts/instance-types.md) координатора.
              
        * `trino.worker_config` — конфигурация [воркера](../concepts/index.md#workers):

            * `resources.resource_preset_id` — [класс хостов](../concepts/instance-types.md) воркера.

            * `scale_policy.fixed_scale` — фиксированное количество воркеров.
                
                * `count` — количество воркеров.

            * `scale_policy.auto_scale` — автоматическое масштабирование количества воркеров.

                * `minCount` — минимальное количество воркеров.
                * `maxCount` — максимальное количество воркеров.

            Чтобы количество воркеров автоматически изменялось в зависимости от нагрузки, используйте настройку `scale_policy.auto_scale` и задайте минимальное и максимальное значения. Для фиксированного числа воркеров используйте настройку `scale_policy.fixed_scale` и укажите требуемое значение.

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
    1. Измените дополнительные настройки кластера:
        
        * **{{ ui-key.yacloud.mdb.forms.label_deletion-protection }}** — защита кластера от непреднамеренного удаления пользователем.

            Включенная защита кластера от удаления не помешает подключиться к нему вручную и удалить данные.
        
        * **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}** — настройки окна [технического обслуживания](../concepts/maintenance.md).

            {% include [Maintenance window](../../_includes/mdb/console/maintenance-window-description.md) %}

        * **{{ ui-key.yacloud.logging.field_logging }}** — опция включает логирование. 
        
            * Выберите место записи логов:
                
              * **{{ ui-key.yacloud.common.folder }}** — выберите каталог из списка. Логи будут записываться в лог-группу по умолчанию выбранного каталога.
                
              * **{{ ui-key.yacloud.logging.label_group }}** — выберите [лог-группу](../../logging/concepts/log-group.md) из списка или создайте новую.
            
            * Выберите **{{ ui-key.yacloud.logging.label_minlevel }}** из списка.

    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить дополнительные настройки кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-tr }} cluster update --help
        ```

    2. Измените дополнительные настройки кластера, выполнив команду:

        ```bash
        {{ yc-mdb-tr }} cluster update <имя_или_идентификатор_кластера> \
          --deletion-protection \
          --maintenance-window type=<тип_технического_обслуживания>,`
                              `day=<день_недели>,`
                              `hour=<час_дня> \
          --log-enabled \
          --log-folder-id <идентификатор_каталога> \
          --log-group-id <идентификатор_лог-группы> \
          --log-min-level <уровень_логирования>
        ```

        Где:

        * `--deletion-protection` — включает защиту кластера от непреднамеренного удаления.
          
            Включенная защита кластера от удаления не помешает подключиться к нему вручную и удалить данные.
        
        * `--maintenance-window` — настройки окна [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), где `type` — тип технического обслуживания:

            {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

        * Параметры логирования:

            * `--log-enabled` — включает логирование. Логи, сгенерированные компонентами {{ TR }}, будут отправляться в {{ cloud-logging-full-name }}.
            * `--log-folder-id` — идентификатор каталога. Логи будут записываться в [лог-группу](../../logging/concepts/log-group.md) по умолчанию для этого каталога.
            * `--log-group-id` — идентификатор пользовательской [лог-группы](../../logging/concepts/log-group.md).

                Вы можете указать только один из параметров: `--log-folder-id` или `--log-group-id`.

            * `--log-min-level` — минимальный уровень логирования. Возможные значения: `TRACE`, `DEBUG`, `INFO` (значение по умолчанию), `WARN`, `ERROR` и `FATAL`.

        Имя и идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.   

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Чтобы включить защиту кластера от непреднамеренного удаления, добавьте параметр `deletion_protection = true`:
        
        ```hcl
        resource "yandex_trino_cluster" "<имя_кластера>" {
          ...
          deletion_protection = true
          ...
        }
        ```

        Где `deletion_protection` — защита кластера от непреднамеренного удаления: `true` или `false`.

        Включенная защита кластера от удаления не помешает подключиться к нему вручную и удалить данные.

    1. Чтобы изменить время технического обслуживания (в т. ч. для выключенных кластеров), добавьте к описанию кластера блок `maintenance_window`:

        {% include [Terraform maintenance window parameters description](../../_includes/managed-trino/terraform/maintenance-window-parameters.md) %}

    1. Чтобы включить отправку логов {{ TR }} в сервис [{{ cloud-logging-full-name }}](../../logging/), добавьте к описанию кластера блок `logging`:

        {% include [Terraform logging parameters description](../../_includes/managed-trino/terraform/logging-parameters.md) %}

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
          "updateMask": "<список_изменяемых_параметров>",
          "deletionProtection": "<защита_от_удаления>",
          "logging": {
            "enabled": "<использование_логирования>",
            "folderId": "<идентификатор_каталога>",
            "logGroupId": "<идентификатор_лог-группы>",
            "minLevel": "<уровень_логирования>"
          },
          "maintenanceWindow": {
            "anytime": {},
            "weeklyMaintenanceWindow": {
              "day": "<день_недели>",
              "hour": "<час_дня>"
            }
          }
        }
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в строку через запятую.

            {% note warning %}

            При изменении кластера будут переопределены все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask`.

            {% endnote %}

        * `deletionProtection` — защита кластера от непреднамеренного удаления: `true` или `false`.

            Включенная защита от удаления не помешает подключиться к кластеру вручную и удалить его.

        * `logging` — параметры логирования:

            * `enabled` — включает логирование. Логи, сгенерированные компонентами {{ TR }}, будут отправляться в {{ cloud-logging-full-name }}. Возможные значения: `true` или `false`.
            * `folderId` — идентификатор каталога. Логи будут записываться в [лог-группу](../../logging/concepts/log-group.md) по умолчанию для этого каталога.
            * `logGroupId` — идентификатор пользовательской [лог-группы](../../logging/concepts/log-group.md).

                Вы можете указать только один из параметров: `folderId` или `logGroupId`.

            * `minLevel` — минимальный уровень логирования. Возможные значения: `TRACE`, `DEBUG`, `INFO` (значение по умолчанию), `WARN`, `ERROR` и `FATAL`.

        * `maintenanceWindow` — настройки окна [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). Передайте один из двух параметров:

            * `anytime` — техническое обслуживание происходит в любое время.
            * `weeklyMaintenanceWindow` — техническое обслуживание происходит раз в неделю в указанное время:
            
              * `day` — день недели для типа `WEEKLY`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
              * `hour` — час дня по UTC для типа `WEEKLY`: от `1` до `24`.


    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

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
              <список_изменяемых_параметров>
            ]
          },
          "deletion_protection": "<защита_от_удаления>",
          "logging": {
            "enabled": "<использование_логирования>",
            "folder_id": "<идентификатор_каталога>",
            "log_group_id": "<идентификатор_лог-группы>",
            "min_level": "<уровень_логирования>"
          },
          "maintenance_window": {
            "anytime": {},
            "weekly_maintenance_window": {
              "day": "<день_недели>",
              "hour": "<час_дня>"
            }
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

            При изменении кластера будут переопределены все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask`.

            {% endnote %}

        * `deletion_protection` — защита кластера от непреднамеренного удаления: `true` или `false`.

            Включенная защита кластера от удаления не помешает подключиться к нему вручную и удалить данные.

        * `logging` — параметры логирования:

            * `enabled` — включает логирование. Логи, сгенерированные компонентами {{ TR }}, будут отправляться в {{ cloud-logging-full-name }}. Возможные значения: `true` или `false`.
            * `folder_id` — идентификатор каталога. Логи будут записываться в [лог-группу](../../logging/concepts/log-group.md) по умолчанию для этого каталога.
            * `log_group_id` — идентификатор пользовательской [лог-группы](../../logging/concepts/log-group.md).

                Вы можете указать только один из параметров: `folderId` или `logGroupId`.

            * `min_level` — минимальный уровень логирования. Возможные значения: `TRACE`, `DEBUG`, `INFO` (значение по умолчанию), `WARN`, `ERROR` и `FATAL`.

        * `maintenance_window` — настройки окна [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). Передайте один из двух параметров:

            * `anytime` — техническое обслуживание происходит в любое время.
            * `weekly_maintenance_window` — техническое обслуживание происходит раз в неделю в указанное время:
            
              * `day` — день недели для типа `WEEKLY`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
              * `hour` — час дня по UTC для типа `WEEKLY`: от `1` до `24`.

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}