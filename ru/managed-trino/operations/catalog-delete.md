---
title: Удаление каталога {{ TR }}
description: Следуя этой инструкции, вы удалите каталог из кластера {{ mtr-name }}.
---

# Удаление каталога {{ TR }}

{% include [preview](../../_includes/managed-trino/note-preview.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице [каталога ресурсов]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Нажмите на имя нужного кластера.
  1. На панели слева выберите ![image](../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.trino.title_catalogs }}**.
  1. В строке с нужным каталогом Trino нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}