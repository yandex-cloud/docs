---
title: Получение информации о каталогах в кластере {{ mtr-name }}
description: Следуя этой инструкции, сможете получить список каталогов в кластере {{ mtr-name }} и запросить подробную информацию о каждом из них.
---

# Получение информации о каталогах в кластере {{ mtr-name }}

## Получить список каталогов в кластере {#list-catalogs}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. На странице [каталога ресурсов]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Нажмите на имя нужного кластера.
    1. На панели слева выберите ![image](../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.trino.title_catalogs }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список каталогов {{ TR }} в кластере {{ mtr-name }}, выполните команду:

    ```bash
    {{ yc-mdb-tr }} catalog list \
        --cluster-id <идентификатор_кластера>
    ```

    Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters).

    Результат:

    ```bash
    +----------------------+---------+----------------+---------------+
    |          ID          |  NAME   | CONNECTOR TYPE |  DESCRIPTION  |
    +----------------------+---------+----------------+---------------+
    | c9qimrjgi9os******** | catalog |   postgresql   | Trino catalog |
    +----------------------+---------+----------------+---------------+
    ```

{% endlist %}

## Получить детальную информацию о каталоге {#get-catalog}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. На странице [каталога ресурсов]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Нажмите на имя нужного кластера.
    1. На панели слева выберите ![image](../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.trino.title_catalogs }}**.
    1. Нажмите на имя нужного каталога {{ TR }}.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить информацию о каталоге {{ TR }}, выполните команду:

    ```bash
    {{ yc-mdb-tr }} catalog get <имя_или_идентификатор_каталога_{{ TR }}> \
        --cluster-id <идентификатор_кластера>
    ```

    Идентификатор и имя каталога {{ TR }} можно запросить со [списком каталогов {{ TR }} в кластере](#list-catalogs.md).

    Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters).

    Результат:

    ```yml
    id: c9qimrjgi9os********
    name: my-catalog
    connector:
      postgresql:
        connection:
          connection_manager:
            connection_id: a5968k5e1cpn********
            database: my-db
    ```

{% endlist %}