---
title: Удаление каталога {{ TR }}
description: Следуя этой инструкции, вы удалите каталог из кластера {{ mtr-name }}.
---

# Удаление каталога {{ TR }}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице [каталога ресурсов]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Нажмите на имя нужного кластера.
  1. На панели слева выберите ![image](../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.trino.title_catalogs }}**.
  1. В строке с нужным каталогом {{ TR }} нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы удалить каталог {{ TR }}, выполните команду:

    ```bash
    {{ yc-mdb-tr }} catalog delete <имя_или_идентификатор_каталога_{{ TR }}> \
      --cluster-id <идентификатор_кластера>
    ```

	Идентификатор и имя каталога {{ TR }} можно запросить со [списком каталогов {{ TR }} в кластере](catalog-list.md#list-catalogs).

  Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters).

{% endlist %}