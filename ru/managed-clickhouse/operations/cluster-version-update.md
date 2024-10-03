---
title: Как изменить версию кластера {{ CH }} в {{ mch-full-name }}
description: Следуя данной инструкции, вы сможете изменить версию кластера {{ CH }}.
---

# Обновление версии {{ CH }}

Вы можете изменить версию {{ CH }}, которую использует кластер, на любую из [поддерживаемых {{ mch-name }} версий](../concepts/update-policy.md#versioning-policy), но при этом переход с версии ниже 23.8 на версию 23.8 и выше производится поэтапно. Например, обновление версии {{ mch-name }} c 22.8 до 24.3 выполняется в такой последовательности: 22.8 → 23.3 → 23.8 → 24.3.

Об обновлениях в рамках одной версии и обслуживании хостов см. в разделе [Техническое обслуживание](../concepts/maintenance.md).

## Список доступных версий

{% list tabs group=instructions %}

- Консоль управления {#console}

    В [консоли управления]({{ link-console-main }}) откройте страницу [создания](cluster-create.md) или [изменения кластера](update.md) {{ mos-name }}. Список доступен в поле **{{ ui-key.yacloud.mdb.forms.base_field_version }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список доступных версий, выполните команду:

    ```bash
    yc managed-clickhouse version list
    ```

- API {#api}

    Чтобы посмотреть список доступных версий, воспользуйтесь методом REST API [list](../api-ref/Versions/list.md) для ресурса [Versions](../api-ref/Versions/index.md) или вызовом gRPC API [VersionsService/List](../api-ref/grpc/versions_service.md#List).

{% endlist %}

## Перед обновлением версии {#before-update}

Убедитесь, что это не нарушит работу ваших приложений:

1. Посмотрите в [истории изменений](https://clickhouse.com/docs/category/changelog) {{ CH }}, как обновления могут повлиять на работу ваших приложений.
1. Попробуйте обновить версию на тестовом кластере. Его можно развернуть из резервной копии основного кластера. В этом случае восстановятся только таблицы на движке MergeTree.
1. [Создайте резервную копию](cluster-backups.md) основного кластера непосредственно перед обновлением версии.

## Обновить версию {#start-update}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) откройте страницу сервиса **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}** в каталоге, где нужно обновить версию {{ CH }}.
    1. В списке кластеров выберите тот, который нужно изменить.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}** в поле **{{ ui-key.yacloud.mdb.forms.base_field_version }}** выберите нужную версию.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

    После того как изменение версии запущено, кластер переходит в статус **UPDATING**. Дождитесь окончания операции и проверьте версию кластера.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Получите список ваших кластеров {{ CH }} и посмотрите их версии:

        ```bash
        {{ yc-mdb-ch }} cluster list

        +----------------------+------+-------------+---------+---------------------+--------+---------+
        |          ID          | NAME | ENVIRONMENT | VERSION |     CREATED AT      | HEALTH | STATUS  |
        +----------------------+------+-------------+---------+---------------------+--------+---------+
        | c9qf1kmm0ebi******** | mych | PRODUCTION  |    23.8 | 2024-06-06 10:23:22 | ALIVE  | RUNNING |
        +----------------------+------+-------------+---------+---------------------+--------+---------+
        ```

    1. Обновите версию {{ CH }} для нужного кластера:

        ```bash
        {{ yc-mdb-ch }} cluster update --id <идентификатор_кластера> --version <версия_{{ CH }}>
        ```

        Укажите версию {{ CH }}: {{ versions.cli.str }}.

    После того как обновление запущено, кластер переходит в статус **UPDATING**. Дождитесь окончания операции и затем проверьте версию кластера.

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Добавьте к описанию кластера {{ mch-name }} поле `version` или измените его значение, если оно уже существует:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
          ...
          version = "<версия_{{ CH }}>"
        }
        ```

        Укажите версию {{ CH }}: {{ versions.tf.str }}.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API {#api}

    Чтобы обновить версию, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](./cluster-list.md#list-clusters).
    * Версию {{ CH }} в параметре `configSpec.version`: {{ versions.api.str }}.
    * Список настроек, которые необходимо изменить (в данном случае — `configSpec.version`), в параметре `updateMask`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
