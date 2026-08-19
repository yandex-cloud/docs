---
title: Trace archiving
description: Automatic archiving of viewed traces with extended retention period.
---

# Trace archiving

When you open a trace in the {{ monium-name }} UI, it gets archived automatically. Archived traces are retained longer than traces in the main storage, which allows you to access them to analyze incidents, perform audits, and investigate issues.

## How archiving works {#how-it-works}

{% list tabs group=instructions %}

- {{ monium-name }} UI {#console}

  1. On the [{{ monium-name }}]({{ link-monium }}) home page, select ![alt](../../../_assets/console-icons/compass.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.all-panel.menu.category.explore }}** → ![alt](../../../_assets/console-icons/hierarchy.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.traces.title }}** on the left.
  1. Select a trace. The system automatically archives that trace.
  1. The archived trace will have an extended retention period.
  1. You can access the archived trace at any time.

{% endlist %}

Archiving is performed automatically, no further actions are required.

## Access to archived traces {#access}

Archived traces are available in the {{ monium-name }} UI:

{% list tabs group=instructions %}

- {{ monium-name }} UI {#console}

  1. On the [{{ monium-name }}]({{ link-monium }}) home page, select ![alt](../../../_assets/console-icons/compass.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.all-panel.menu.category.explore }}** → ![alt](../../../_assets/console-icons/hierarchy.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.traces.title }}** on the left.
  1. Search by `trace_id`.
  1. If the trace was previously viewed and archived, it will appear in the search results.

{% endlist %}

Archived traces are also available via a direct link.
