---
title: "Изменение настроек кластера {{ OS }}"
description: "После создания кластера {{ OS }} вы можете изменить его сервисные настройки."
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

{% note warning %}

Если для доступа к объектам из {{ objstorage-full-name }} в кластере уже используется сервисный аккаунт, то его смена может привести к недоступности этих объектов и нарушению работы кластера. Перед изменением настроек сервисного аккаунта убедитесь, что кластер не использует соответствующие объекты.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

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

- API {#api}

    Чтобы изменить настройки сервисного аккаунта, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Идентификатор сервисного аккаунта, используемого для работы с кластером, в параметре `serviceAccountId`.

    Подробнее о настройке сервисного аккаунта см. в разделе [Настройка доступа к {{ objstorage-name }}](s3-access.md).

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

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

- API {#api}

    Чтобы изменить пароль пользователя `admin`, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Новый пароль пользователя `admin` в параметре `configSpec.adminPassword`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

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

- API {#api}

    Чтобы изменить настройки {{ OS }}, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Новое максимально допустимое количество булевых выражений в параметре `configSpec.opensearchSpec.opensearchConfig_2.maxClauseCount`. Подробнее см. в [документации {{ OS }}]({{ os.docs }}/query-dsl/compound/bool/).
    * Новый объем кучи JVM, выделенный для структуры данных fielddata, в параметре `configSpec.opensearchSpec.opensearchConfig_2.fielddataCacheSize`. Можно указать абсолютное значение или проценты, например, `512mb` или `50%`. Подробнее см. в [документации {{ OS }}]({{ os.docs }}/install-and-configure/configuring-opensearch/index-settings/#cluster-level-index-settings).
    * Новый список удаленных хостов, из индекса которых нужно скопировать документы для переиндексации, в параметре `configSpec.opensearchSpec.opensearchConfig_2.reindexRemoteWhitelist`. Подробнее см. в [документации {{ OS }}]({{ os.docs }}/im-plugin/reindex-data/#reindex-from-a-remote-cluster).

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

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
       --delete-protection=<true_или_false> \
       --data-transfer-access=<true_или_false> \
       --serverless-access=<true_или_false>
    ```

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    Настройки в команде:

    * `--maintenance` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров):

        * Чтобы разрешить проведение технического обслуживания в любое время, укажите `--maintenance schedule=anytime`.
        * Чтобы указать предпочтительное время начала обслуживания, укажите `--maintenance schedule=weekly,weekday=<день_недели>,hour=<час_дня_по_UTC>`. Тогда техническое обслуживание будет проходить каждую неделю в обозначенный день и время.

            Возможные значения параметра `weekday`: `mon`, `tue`, `wed`, `thu`, `fry`, `sat`, `sun`. В параметре `hour` укажите, во сколько должно завершиться техническое обслуживание. Например, если указать `14`, техническое обслуживание будет проходить с 13:00 до 14:00 по UTC.

    * `--delete-protection` — защита кластера от непреднамеренного удаления пользователем: `true` или `false`.

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-data.md) %}

    * `--data-transfer-access` — доступ из [{{ data-transfer-full-name }}](../../data-transfer/index.yaml): `true` или `false`.
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

- API {#api}

    Чтобы изменить пароль пользователя `admin`, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров) в параметре `maintenanceWindow`.
    * Настройки защиты от удаления кластера в параметре `deletionProtection`.

        {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

    * Настройки доступа из [{{ data-transfer-full-name }}](../../data-transfer/index.yaml) в параметре `configSpec.access.dataTransfer`.
    * Настройки доступа из [{{ serverless-containers-full-name }}](../../serverless-containers/index.yaml) в параметре `configSpec.access.serverless`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

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

- API {#api}

    Чтобы изменить список групп безопасности для кластера, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Список идентификаторов групп безопасности в параметре `securityGroupIds`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

