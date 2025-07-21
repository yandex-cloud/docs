---
title: Удаление кластера {{ ytsaurus-name }}
description: Вы можете удалить кластер {{ ytsaurus-name }}, если он вам больше не нужен.
keywords:
  - удаление кластера {{ ytsaurus-name }}
  - кластер {{ ytsaurus-name }}
  - '{{ ytsaurus-name }}'
---

# Удаление кластера {{ ytsaurus-name }}

{% include [preview](../../_includes/managed-ytsaurus/note-preview.md) %}

Вы можете удалить кластер {{ ytsaurus-name }}, если он вам больше не нужен.

## Удалить кластер {#delete}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, из которого нужно удалить кластер.
  1. Выберите сервис **{{ myt-name }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) для нужного кластера и выберите пункт **{{ ui-key.yacloud.mdb.cluster.overview.button_action-delete }}**.
  1. В открывшемся окне подтвердите удаление и нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-delete-cluster_button }}**.

{% endlist %}
