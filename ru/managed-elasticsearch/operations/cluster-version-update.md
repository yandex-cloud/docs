---
title: "Как изменить версии и редакции {{ ES }}"
description: "Следуя данной инструкции, вы сможете изменить версии и редакции {{ ES }}."
---

# Изменение версии и редакции {{ ES }}

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

В кластере {{ mes-name }} вы можете [обновить версию](#version-update) и [изменить редакцию](#start-edition-update) {{ ES }}.

Об обновлениях в рамках одной версии и обслуживании хостов см. в разделе [{#T}](../concepts/maintenance.md).

## Обновление версии {{ ES }} {#version-update}

Вы можете обновить кластер {{ mes-name }} до более новой [версии {{ ES }}](../concepts/update-policy.md#versioning-policy).

### Узнать доступные версии {{ ES }} {#version-list}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
    1. Выберите кластер и нажмите кнопку ![image](../../_assets/edit.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
    1. Откройте список в поле **{{ ui-key.yacloud.mdb.forms.base_field_version }}**.

{% endlist %}

### Перед обновлением версии {#before-version-update}

Убедитесь, что это не нарушит работу ваших приложений:

1. Посмотрите в [истории изменений](https://www.elastic.co/downloads/past-releases#elasticsearch) {{ ES }}, как обновления могут повлиять на работу ваших приложений.
1. Попробуйте обновить версию на тестовом кластере. Его можно развернуть из резервной копии основного кластера.
1. [Создайте резервную копию](cluster-backups.md) основного кластера непосредственно перед обновлением версии.

### Обновить версию {{ ES }} {#start-version-update}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
    1. Выберите кластер и нажмите кнопку ![image](../../_assets/edit.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
    1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_version }}** выберите нужную версию {{ ES }}.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Получите список ваших кластеров {{ ES }}:

        ```bash
        {{ yc-mdb-es }} cluster list
        ```

    1. Получите информацию о нужном кластере и проверьте версию в свойстве `config.version`:

        ```bash
        {{ yc-mdb-es }} cluster get <имя_или_идентификатор_кластера>
        ```

    1. Обновите версию:

        ```bash
        {{ yc-mdb-es }} cluster update <имя_или_идентификатор_кластера> --version <версия_{{ ES }}>
        ```

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

       О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

       Полный список доступных для изменения полей конфигурации кластера {{ mes-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mes }}).

    1. Добавьте к описанию кластера {{ mes-name }} поле `config.version` или измените его значение, если оно уже существует:

       ```hcl
       resource "yandex_mdb_elasticsearch_cluster" "<имя_кластера>" {
         ...
         config {
           version = "<версия_{{ ES }}>"
         }
       }
       ```

    1. Проверьте корректность настроек.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API

    Чтобы обновить версию, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`.

      {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

    * Новую версию {{ ES }} в параметре `configSpec.version`.
    * Список изменяемых полей конфигурации кластера в параметре `updateMask` (в данном случае — `configSpec.version`).

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Изменить редакцию {{ ES }} {#start-edition-update}

{% note info %}

С 13 июня 2022 года прекращена поддержка [редакции](../concepts/es-editions.md) `Gold` в кластерах {{ mes-name }}. Перейти на нее с редакций `Basic` или `Platinum` невозможно. 6 июля 2022 года редакция всех кластеров `Gold` была автоматически повышена до `Platinum`.

{% endnote %}

Вы можете изменить используемую кластером [редакцию {{ ES }}](../concepts/es-editions.md). Прежде чем понижать используемую редакцию, убедитесь, что сокращение функциональных возможностей не нарушит работу ваших приложений.

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
    1. Выберите кластер и нажмите кнопку ![image](../../_assets/edit.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
    1. В поле **{{ ui-key.yacloud.elasticsearch.base_field_edition }}** выберите нужную редакцию {{ ES }}: `Basic` или `Platinum`.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Получите список ваших кластеров {{ ES }}:

        ```bash
        {{ yc-mdb-es }} cluster list
        ```

    1. Получите информацию о нужном кластере и проверьте редакцию в свойстве `config.edition`:

        ```bash
        {{ yc-mdb-es }} cluster get <имя_или_идентификатор_кластера>
        ```

    1. Измените редакцию:

        ```bash
        {{ yc-mdb-es }} cluster update <имя_или_идентификатор_кластера> \
           --edition <редакция_{{ ES }}>
        ```

        Где `--edition` — редакция {{ ES }}: `basic` или `platinum`.

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Добавьте к описанию кластера {{ mes-name }} поле `config.edition` или измените его значение, если поле уже существует:

        ```hcl
        resource "yandex_mdb_elasticsearch_cluster" "<имя_кластера>" {
          ...
          config {
            edition = "<редакция_{{ ES }}>"
            ...
          }
          ...
        }
        ```

        Где `edition` — редакция {{ ES }}: `basic` или `platinum`.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_elasticsearch_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API

    Чтобы изменить редакцию {{ ES }}, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`.

      {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}
      
    * Новую редакцию {{ ES }} в параметре `configSpec.edition`.
    * Список изменяемых полей конфигурации кластера в параметре `updateMask` (в данном случае — `configSpec.edition`).

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
