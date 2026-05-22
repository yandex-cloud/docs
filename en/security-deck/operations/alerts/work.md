---
title: Working with alerts in {{ sd-full-name }}
description: In this section, you will learn how to work with alerts in {{ sd-full-name }}.
---

# Working with alerts

## Changing alert status {#status}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}**.
  1. At the top of the window, select the [workspace](../../concepts/workspace.md).
  1. Click the table row containing the [alert](../../concepts/alerts.md) name.
  1. In the window that opens, select the status in the top-left corner.

{% endlist %}


## Analyzing alerts with the help of AI {#ai-analysis}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}**.
  1. At the top of the window, select the [workspace](../../concepts/workspace.md).
  1. Click the table row containing the alert name.
  1. In the window that opens, click ![sparkles](../../../_assets/console-icons/sparkles-fill.svg) **{{ ui-key.yacloud_org.security-center.alert.action_alert_analysis }}**.

      The AI ​​assistant's dialog panel with its analysis will open on the right.

{% endlist %}


## Leaving a comment on an alert {#comment}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}**.
  1. At the top of the window, select the [workspace](../../concepts/workspace.md).
  1. Click the table row containing the alert name.
  1. In the window that opens, go to the **{{ ui-key.yacloud_org.security-center.alerts.title_alert_comments }}** tab.
  1. Enter and finalize your comment, then click ![paper-plane](../../../_assets/console-icons/paper-plane.svg) **{{ ui-key.yacloud_org.security.alerts.comment_form.send }}**.

{% endlist %}
