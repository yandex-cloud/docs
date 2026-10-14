---
title: Managing alert tags in {{ sd-full-name }}
description: In this section, you will learn how to add or remove alert tags in {{ sd-full-name }}.
---

# Managing alert tags

Tags make it easier to search for alerts. You can also use tags to add alert context.

## Adding tags to an alert {#add-tag}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}**.
  1. At the top of the window, select the [workspace](../../concepts/workspace.md).
  1. Select an alert.
  1. In the **{{ ui-key.yacloud_org.security-center.alert.overview_tags }}** field:
  
     * If the alert has no tags, click **{{ ui-key.yacloud_org.security.alerts.AlertTagsControl.action_add-tag_bu4cy }}**.
     * If it has some, click ![image](../../../_assets/security-deck/add-tag.svg).

  1. Enter a tag name or select one from the list.

{% endlist %}

## Adding tags to multiple alerts {#add-tag-multiple}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}**.
  1. At the top of the window, select the [workspace](../../concepts/workspace.md).
  1. Select the alerts with ![image](../../../_assets/console-icons/check.svg) and click ![image](../../../_assets/console-icons/tag.svg) **{{ ui-key.yacloud_org.security.alerts.i18n.ts.action-add-tags_kUsL6 }}**.
  1. In the window that opens, click **{{ ui-key.yacloud_org.security.alerts.AlertTagsControl.action_add-tag_bu4cy }}** and enter a tag name or select one from the list.

{% endlist %}

## Removing alert tags {#remove-tag}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}**.
  1. At the top of the window, select the [workspace](../../concepts/workspace.md).
  1. Select an alert.
  1. In the **{{ ui-key.yacloud_org.security-center.alert.overview_tags }}** field, click ![image](../../../_assets/security-deck/xmark.svg) next to the tag you want to remove.

{% endlist %}
