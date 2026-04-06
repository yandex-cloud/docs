---
title: Working with the {{ kspm-full-name }} ({{ kspm-name }}) dashboard in {{ sd-full-name }}
description: How to work with the {{ kspm-full-name }} ({{ kspm-name }}) interface in {{ sd-name }}.
---

# Working with the {{ kspm-name }} dashboard

{% include [note-preview](../../../_includes/note-preview.md) %}

To work with the dashboard, you need the `security-deck.viewer` role or higher for the folder containing the {{ kspm-name }} module resources.

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![image](../../../_assets/security-deck/kspm.svg) **{{ ui-key.yacloud_org.security-center.label_kspm }}**.
  1. At the top of the window, select the [workspace](../../concepts/workspace.md).
  1. On the **{{ ui-key.yacloud_org.security-center.kspm.title_clusters }}** tab, make sure all the clusters are connected to {{ kspm-name }} and are in the active control status.
  1. Review the **{{ ui-key.yacloud_org.security-center.kspm.title_dashboard }}** tab. It has the following sections:
      * **{{ ui-key.yacloud_org.security.kspm.TopControlsByErrorsWidget.table_controls_rJ32E }}**: Contains the most frequently violated rules within the control scope and gives the number of violations.
      * Section with overall statistics for the scope of control: Gives the number of clusters with {{ kspm-name }} connection errors, numbers of clusters with security warnings, number of **{{ ui-key.yacloud_org.kspm.TopClustersByErrorsWidget.table_clusters }}**, and number of violations.
      * A list of alerts stating threat type, status, and last update time.

        {% include [kspm-alerts](../../../_includes/security-deck/kspm-alerts.md) %}

{% endlist %}