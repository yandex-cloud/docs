---
title: Изменение настроек кластера {{ OS }}
description: После создания кластера {{ OS }} вы можете изменить его сервисные настройки.
keywords:
  - настройки OpenSearch
  - настройки кластера OpenSearch
  - OpenSearch
---

# Изменение настроек кластера {{ OS }}

После создания кластера вы можете изменить:

* [сервисный аккаунт](#change-service-account);
* [пароль пользователя](#change-admin-password) `admin`;
* [настройки {{ OS }}](#change-opensearch-config);
* [дополнительные настройки кластера](#change-additional-settings);
* [группы безопасности](#change-sg-set).

Помимо этого вы можете:

* [обновить версию {{ OS }}](cluster-version-update.md);
* [изменить конфигурацию групп хостов](host-groups.md#update-host-group);
* [переместить группы хостов в другую зону доступности](host-migration.md).


## Изменить сервисный аккаунт {#change-service-account}


Для привязки сервисного аккаунта к кластеру {{ mos-name }} [убедитесь](../../iam/operations/roles/get-assigned-roles.md), что вашему аккаунту в {{ yandex-cloud }} назначена роль [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) или выше.


{% include [mdb-service-account-update](../../_includes/mdb/service-account-update.md) %}

О настройке сервисного аккаунта читайте в разделе [Настройка доступа к {{ objstorage-name }}](s3-access.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы изменить сервисный аккаунт, привязанный к кластеру {{ mos-name }}:

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Выберите кластер и нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
    1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** выберите аккаунт из списка или [создайте новый](../../iam/operations/sa/create.md). Подробнее о настройке сервисного аккаунта см. в разделе [Настройка доступа к {{ objstorage-name }}](s3-access.md).
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить сервисный аккаунт, привязанный к кластеру {{ mos-name }}, выполните команду:

    ```bash
    {{ yc-mdb-os }} cluster update <имя_или_идентификатор_кластера> \
       --service-account-name <имя_сервисного_аккаунта>
    ```

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    Подробнее о настройке сервисного аккаунта см. в разделе [Настройка доступа к {{ objstorage-name }}](s3-access.md).

- {{ TF }} {#tf}

    Чтобы изменить сервисный аккаунт, привязанный к кластеру {{ mos-name }}:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        Полный список доступных для изменения полей конфигурации кластера {{ mos-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mos }}).

    1. Укажите в поле `service_account_id` идентификатор сервисного аккаунта:

        ```hcl
        resource "yandex_mdb_opensearch_cluster" "<имя_кластера>" {
            ...
            service_account_id = "<идентификатор_сервисного_аккаунта>"
        }
        ```

        Подробнее о настройке сервисного аккаунта см. в разделе [Настройка доступа к {{ objstorage-name }}](s3-access.md).

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<идентификатор_кластера>' \
            --data '{
                        "updateMask": "serviceAccountId",
                        "serviceAccountId": "<идентификатор_сервисного_аккаунта>"
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            В данном случае передается только один параметр.

        * `serviceAccountId` — идентификатор сервисного аккаунта, используемого для работы с кластером.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "update_mask": {
                        "paths": [
                            "service_account_id"
                        ]
                    },
                    "service_account_id": "<идентификатор_сервисного_аккаунта>"
                }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.opensearch.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            В данном случае передается только один параметр.

        * `service_account_id` — идентификатор сервисного аккаунта, используемого для работы с кластером.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}


## Изменить пароль пользователя admin {#change-admin-password}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Выберите кластер и нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
    1. В поле **{{ ui-key.yacloud.mdb.forms.database_field_admin-password }}** укажите новый пароль.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить пароль пользователя `admin` для кластера, укажите новый пароль одним из возможных способов:

    * Ввод пароля открытым текстом (менее безопасный способ).

        ```bash
        {{ yc-mdb-os }} cluster update <имя_или_идентификатор_кластера> \
           --admin-password <новый_пароль>
        ```

    * Автоматическая генерация пароля. Сгенерированный пароль будет выведен в консоль.

        ```bash
        {{ yc-mdb-os }} cluster update <имя_или_идентификатор_кластера> \
           --generate-admin-password
        ```

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        Полный список доступных для изменения полей конфигурации кластера {{ mos-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mos }}).

    1. Измените в описании кластера значение поля `admin_password` в блоке `config`:

        ```hcl
        resource "yandex_mdb_opensearch_cluster" "<имя_кластера>" {
            ...
            config {
                admin_password = "<новый_пароль_пользователя-администратора>"
            }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<идентификатор_кластера>' \
            --data '{
                        "updateMask": "configSpec.adminPassword",
                        "configSpec": {
                            "adminPassword": "<новый_пароль>"
                        }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            В данном случае передается только один параметр.

        * `configSpec.adminPassword` — новый пароль пользователя `admin`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "update_mask": {
                        "paths": [
                            "config_spec.admin_password"
                        ]
                    },
                    "config_spec": {
                        "admin_password": "<новый_пароль>"
                    }
                }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.opensearch.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            В данном случае передается только один параметр.

        * `config_spec.admin_password` — новый пароль пользователя `admin`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить настройки {{ OS }} {#change-opensearch-config}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Выполните команду и передайте в ней список настроек, которые хотите изменить:

    ```bash
    {{ yc-mdb-os }} cluster update <имя_или_идентификатор_кластера> \
       --max-clause-count <количество_булевых_выражений> \
       --fielddata-cache-size <объем_кучи_JVM> \
       --reindex-remote-whitelist <адрес_хоста>:<порт>
    ```

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    Настройки в команде:

    * `--max-clause-count` — максимально допустимое количество булевых выражений (boolean clauses) в запросе. Подробнее см. в [документации {{ OS }}]({{ os.docs }}/query-dsl/compound/bool/).
    * `--fielddata-cache-size` — объем кучи JVM, который выделен для структуры данных fielddata. Можно указать абсолютное значение или проценты, например, `512mb` или `50%`. Подробнее см. в [документации {{ OS }}]({{ os.docs }}/install-and-configure/configuring-opensearch/index-settings/#cluster-level-index-settings).
    * `--reindex-remote-whitelist` — список удаленных хостов, из индекса которых нужно скопировать документы для переиндексации. Укажите значение параметра в формате `<адрес_хоста>:<порт>`. Если нужно указать несколько хостов, перечислите значения через запятую. Подробнее см. в [документации {{ OS }}]({{ os.docs }}/im-plugin/reindex-data/#reindex-from-a-remote-cluster).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<идентификатор_кластера>' \
            --data '{
                        "updateMask": "configSpec.opensearchSpec.opensearchConfig_2.maxClauseCount,configSpec.opensearchSpec.opensearchConfig_2.fielddataCacheSize,configSpec.opensearchSpec.opensearchConfig_2.reindexRemoteWhitelist",
                        "configSpec": {
                            "opensearchSpec": {
                                "opensearchConfig_2": {
                                    "maxClauseCount": "<количество_булевых_выражений>",
                                    "fielddataCacheSize": "<объем_кучи_JVM>",
                                    "reindexRemoteWhitelist": "<адрес_хоста>:9200"
                                }
                            }
                        }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.
        * `configSpec.opensearchSpec.opensearchConfig_2` — настройки {{ OS }}:

            * `maxClauseCount` — новое максимально допустимое количество булевых выражений. Подробнее см. в [документации {{ OS }}]({{ os.docs }}/query-dsl/compound/bool/).

            * `fielddataCacheSize` — новый объем кучи JVM, выделенный для структуры данных fielddata. Можно указать абсолютное значение или проценты, например, `512mb` или `50%`. Подробнее см. в [документации {{ OS }}]({{ os.docs }}/install-and-configure/configuring-opensearch/).

            * `reindexRemoteWhitelist` — новый список удаленных хостов, из индекса которых нужно скопировать документы для переиндексации. Укажите [FQDN хоста](connect.md#fqdn) и через двоеточие порт 9200. Чтобы указать несколько хостов, перечислите их через запятую, указанную после порта. Подробнее см. в [документации {{ OS }}]({{ os.docs }}/im-plugin/reindex-data/#reindex-from-a-remote-cluster).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "update_mask": {
                        "paths": [
                            "config_spec.opensearch_spec.opensearch_config_2.max_clause_count",
                            "config_spec.opensearch_spec.opensearch_config_2.fielddata_cache_size",
                            "config_spec.opensearch_spec.opensearch_config_2.reindex_remote_whitelist"
                        ]
                    },
                    "config_spec": {
                        "opensearch_spec": {
                            "opensearch_config_2": {
                                "max_clause_count": "<количество_булевых_выражений>",
                                "fielddata_cache_size": "<объем_кучи_JVM>",
                                "reindex_remote_whitelist": "<адрес_хоста>:9200"
                            }
                        }
                    }
                }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.opensearch.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            В данном случае передается только один параметр.

        * `config_spec.opensearch_spec.opensearch_config_2` — настройки {{ OS }}:

            * `max_clause_count` — новое максимально допустимое количество булевых выражений. Подробнее см. в [документации {{ OS }}]({{ os.docs }}/query-dsl/compound/bool/).

            * `fielddata_cache_size` — новый объем кучи JVM, выделенный для структуры данных fielddata. Можно указать абсолютное значение или проценты, например, `512mb` или `50%`. Подробнее см. в [документации {{ OS }}]({{ os.docs }}/install-and-configure/configuring-opensearch/).

            * `reindex_remote_whitelist` — новый список удаленных хостов, из индекса которых нужно скопировать документы для переиндексации. Укажите [FQDN хоста](connect.md#fqdn) и через двоеточие порт 9200. Чтобы указать несколько хостов, перечислите их через запятую, указанную после порта. Подробнее см. в [документации {{ OS }}]({{ os.docs }}/im-plugin/reindex-data/#reindex-from-a-remote-cluster).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Выберите кластер и нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
    1. Измените дополнительные настройки кластера:

        * **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}** — настройки времени [технического обслуживания](../concepts/maintenance.md):

            {% include [Maintenance window](../../_includes/mdb/console/maintenance-window-description.md) %}


        * {% include [Deletion protection](../../_includes/mdb/console/deletion-protection.md) %}

            {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-data.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Выполните команду и передайте в ней список настроек, которые хотите изменить:

    ```bash
    {{ yc-mdb-os }} cluster update <имя_или_идентификатор_кластера> \
       --maintenance schedule=<тип_технического_обслуживания>,`
                    `weekday=<день_недели>,`
                    `hour=<час_дня> \
       --delete-protection \
       --data-transfer-access=<true_или_false> \
       --serverless-access=<true_или_false>
    ```

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    Настройки в команде:

    * `--maintenance` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров):

        * Чтобы разрешить проведение технического обслуживания в любое время, укажите `--maintenance schedule=anytime`.
        * Чтобы указать предпочтительное время начала обслуживания, укажите `--maintenance schedule=weekly,weekday=<день_недели>,hour=<час_дня_по_UTC>`. Тогда техническое обслуживание будет проходить каждую неделю в обозначенный день и время.

            Возможные значения параметра `weekday`: `mon`, `tue`, `wed`, `thu`, `fry`, `sat`, `sun`. В параметре `hour` укажите, во сколько должно завершиться техническое обслуживание. Например, если указать `14`, техническое обслуживание будет проходить с 13:00 до 14:00 по UTC.

    * `--delete-protection` — защита кластера от непреднамеренного удаления пользователем.

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-data.md) %}


    * `--serverless-access` — доступ из [{{ serverless-containers-full-name }}](../../serverless-containers/index.yaml): `true` или `false`.

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        Полный список доступных для изменения полей конфигурации кластера {{ mos-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mos }}).

    1. Чтобы изменить время [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), укажите настройки в параметре `maintenance_window`:

        ```hcl
        resource "yandex_mdb_opensearch_cluster" "<имя_кластера>" {
            ...
            maintenance_window {
                type = "<частота_технического_обслуживания>"
                hour = <час_дня>
                day = "<день_недели>"
            }
        }
        ```

        Укажите в параметрах:

        * `type` — значение `ANYTIME`, чтобы разрешить проведение технического обслуживания в любое время, или `WEEKLY`, чтобы проводить техническое обслуживание каждую неделю.
        * `hour` — час дня по UTC, когда завершается техническое обслуживание. Например, если указать `14`, техническое обслуживание будет проходить с 13:00 до 14:00 по UTC.
        * `day` — день недели, когда проводится техническое обслуживание. Доступные значения: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, `SUN`.

    1. Чтобы включить защиту кластера от непреднамеренного удаления пользователем вашего облака, добавьте к описанию кластера поле `deletion_protection` со значением `true`:

        ```hcl
        resource "yandex_mdb_opensearch_cluster" "<имя_кластера>" {
            ...
            deletion_protection = <true_или_false>
        }
        ```

        Где `deletion_protection` — защита от удаления кластера.

        {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        
        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<идентификатор_кластера>' \
            --data '{
                        "updateMask": "configSpec.access,deletionProtection,maintenanceWindow",
                        "configSpec": {
                            "access": {
                                "dataTransfer": <доступ_из_Data_Transfer:_true_или_false>,
                                "serverless": <доступ_из_Serverless_Containers:_true_или_false>
                            }
                        },
                        "deletionProtection": <защита_от_удаления:_true_или_false>,
                        "maintenanceWindow": {
                            "weeklyMaintenanceWindow": {
                                "day": "<день_недели>",
                                "hour": "<час>"
                            }
                        }
                    }'
        ```


        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

        
        * `access` — настройки доступа кластера к следующим сервисам {{ yandex-cloud }}:

            * `dataTransfer` — [{{ data-transfer-full-name }}](../../data-transfer/index.yaml);
            * `serverless` — [{{ serverless-containers-full-name }}](../../serverless-containers/index.yaml).


        * `deletionProtection` — защита от удаления кластера, его баз данных и пользователей.

            {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

        * `maintenanceWindow.weeklyMaintenanceWindow` — расписание окна технического обслуживания:

            * `day` — день недели в формате `DDD`, когда должно проходить обслуживание.
            * `hour` — час в формате `HH`, когда должно проходить обслуживание. Возможные значения: от `1` до `24`. Задается в часовом поясе UTC.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        
        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "update_mask": {
                        "paths": [
                            "config_spec.access",
                            "deletion_protection",
                            "maintenance_window"
                        ]
                    },
                    "config_spec": {
                        "access": {
                            "data_transfer": <доступ_из_Data_Transfer:_true_или_false>,
                            "serverless": <доступ_из_Serverless_Containers:_true_или_false>
                        }
                    },
                    "deletion_protection": <защита_от_удаления:_true_или_false>,
                    "maintenance_window": {
                        "weekly_maintenance_window": {
                            "day": "<день_недели>",
                            "hour": "<час>"
                        }
                    }
                }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.opensearch.v1.ClusterService.Update
        ```


        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            В данном случае передается только один параметр.

        
        * `access` — настройки доступа кластера к следующим сервисам {{ yandex-cloud }}:

            * `data_transfer` — [{{ data-transfer-full-name }}](../../data-transfer/index.yaml);
            * `serverless` — [{{ serverless-containers-full-name }}](../../serverless-containers/index.yaml).


        * `deletion_protection` — защита от удаления кластера, его баз данных и пользователей.

            {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

        * `maintenance_window.weekly_maintenance_window` — расписание окна технического обслуживания:

            * `day` — день недели в формате `DDD`, когда должно проходить обслуживание.
            * `hour` — час в формате `HH`, когда должно проходить обслуживание. Возможные значения: от `1` до `24`. Задается в часовом поясе UTC.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}


## Изменить группы безопасности {#change-sg-set}

После того как вы назначите другие [группы безопасности](../concepts/network.md#security-groups), может потребоваться их [дополнительная настройка](connect.md#security-groups) для подключения к кластеру.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Выберите кластер и нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите группы безопасности для сетевого трафика кластера.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить список групп безопасности для кластера, укажите нужные группы безопасности в команде:

    ```bash
    {{ yc-mdb-os }} cluster update <имя_или_идентификатор_кластера> \
       --security-group-ids <список_идентификаторов_групп_безопасности>
    ```

    Если нужно указать несколько групп, перечислите их через запятую.

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        Полный список доступных для изменения полей конфигурации кластера {{ mos-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mos }}).

    1. В поле `security_group_ids` перечислите через запятую идентификаторы групп безопасности:

        ```hcl
        resource "yandex_mdb_opensearch_cluster" "<имя_кластера>" {
            ...
            security_group_ids = [ "<группы_безопасности>" ]
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<идентификатор_кластера>' \
            --data '{
                        "updateMask": "securityGroupIds",
                        "securityGroupIds": [
                            "<идентификатор_группы_безопасности_1>",
                            "<идентификатор_группы_безопасности_2>",
                            ...
                            "<идентификатор_группы_безопасности_N>"
                        ]
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            В данном случае передается только один параметр.

        * `securityGroupIds` — идентификаторы групп безопасности.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "update_mask": {
                        "paths": [
                            "security_group_ids"
                        ]
                    },
                    "security_group_ids": [
                        "<идентификатор_группы_безопасности_1>",
                        "<идентификатор_группы_безопасности_2>",
                        ...
                        "<идентификатор_группы_безопасности_N>"
                    ]
                }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.opensearch.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            В данном случае передается только один параметр.

        * `security_group_ids` — идентификаторы групп безопасности.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

