---
title: Managing queries in {{ ycdr-full-name }}
description: Follow this guide to learn how to create, edit, run, and delete queries in {{ ycdr-name }}.
---

# Managing queries

{% include [preview-by-request](../../../_includes/note-preview-by-request.md) %}

This section describes how to create, manage, and run [KQL (Kusto Query Language)](../../kql-reference.md) queries.

## Creating a new query {#create-query}

To create a new query:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Open an investigation.
  1. Click **{{ ui-key.yacloud_org.security.siem.InvestigationPageLayout.newQuery_mzeBV }}**.
  1. In the query editor, enter a KQL query or select a template.

  {% note tip %}

  Use the tooltip in the editor: {{ ui-key.yacloud_org.security.ycdr.query-placeholder_auE1D }}.

  {% endnote %}

{% endlist %}

## Editing a query {#edit-query}

To edit a query:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Open an investigation with the required query.
  1. Select the tab with your query.
  1. Make your changes in the query editor.

  Changes are saved automatically.

{% endlist %}

## Selecting a period {#select-time-period}

To select a period for your query:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Click the period selector next to the start button.
  1. Select one of the presets:
     * {{ ui-key.yacloud_org.security.ycdr.preset_last_5_minutes_s5Gq5 }}
     * {{ ui-key.yacloud_org.security.ycdr.preset_last_30_minutes_s5Gq5 }}
     * {{ ui-key.yacloud_org.security.ycdr.preset_last_1_hour_s5Gq5 }}
     * {{ ui-key.yacloud_org.security.ycdr.preset_last_3_hours_s5Gq5 }}
     * {{ ui-key.yacloud_org.security.ycdr.preset_last_6_hours_s5Gq5 }}
     * {{ ui-key.yacloud_org.security.ycdr.preset_last_12_hours_s5Gq5 }}
     * {{ ui-key.yacloud_org.security.ycdr.preset_last_day_s5Gq5 }}

  Or select a custom period:

  1. Click the time period selector.
  1. Select a custom period.
  1. Specify the start date and time of the period.
  1. Specify the end date and time of the period.
  1. Click **{{ ui-key.yacloud.common.apply }}**.

{% endlist %}

## Running a query {#run-query}

To run a query:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Make sure your query is entered in the editor.
  1. Select a time period.
  1. Click the query run button.

  After you run it, the query enters the **{{ ui-key.yacloud_org.security.siem.cell-result-running_4S3Mi }}** status. Once it is over, its results are presented in the table and on the histogram.

{% endlist %}

## Stopping a running query {#stop-query}

To stop a running query:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. While the query is running, click the stop button.
  1. The request will enter the **{{ ui-key.yacloud_org.security.siem.cell-result-canceled_fqtbJ }}** status.

{% endlist %}

## Renaming a query {#rename-query}

To rename a query:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Click the query name in the tab.
  1. Enter a new name.
  1. Press **Enter** or click outside the input field.

{% endlist %}

## Deleting a query {#delete-query}

To delete a query:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Right-click the query tab.
  1. Select **{{ ui-key.yacloud_org.security.siem.action_delete_wM5k5 }}**.
  1. Confirm the deletion.

  {% note warning %}

  Deleting a query is irreversible. The results and execution history will be deleted.

  {% endnote %}

{% endlist %}

## Sharing a query {#share-query}

To share a query:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Open the query.
  1. In the actions menu, select **{{ ui-key.yacloud_org.security.siem.cell-result-action-share_i1khy }}**.
  1. Copy the query link.

  This link contains the query text and the selected period. The recipient will be able to open the query in their investigation.

{% endlist %}

## Customizing the fields displayed in the results {#configure-result-fields}

To customize the fields displayed in the results table:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Run the query.
  1. In the results table, click the column settings icon.
  1. Select the fields you want displayed.
  1. Reorder the fields by dragging and dropping.
  1. Click **{{ ui-key.yacloud.common.apply }}**.

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/investigations.md)
* [{#T}](../../concepts/queries.md)
* [{#T}](work-with-templates.md)
* [{#T}](query-history.md)