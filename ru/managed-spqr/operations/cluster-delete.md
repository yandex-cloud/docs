---
title: Удаление кластера {{ SPQR }}
description: Вы можете удалить кластер {{ SPQR }}, если он вам больше не нужен.
keywords:
  - удаление кластера {{ SPQR }}
  - кластер {{ SPQR }}
  - '{{ SPQR }}'
---

# Удаление кластера {{ SPQR }}

{% include notitle [preview](../../_includes/note-preview.md) %}

Вы можете удалить кластер {{ SPQR }}, если он вам больше не нужен.

## Удалить кластер {#delete}

Перед удалением кластера отключите его защиту от удаления, если она включена.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, из которого нужно удалить кластер.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
    1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) для нужного кластера и выберите пункт **{{ ui-key.yacloud.mdb.cluster.overview.button_action-delete }}**.
    1. В открывшемся окне подтвердите удаление и нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-delete-cluster_button }}**.

{% endlist %}
