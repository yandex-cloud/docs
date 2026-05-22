---
title: Getting started with {{ ycdr-full-name }}
description: Follow this guide to learn how to create investigations, run KQL queries, and analyze security events in {{ ycdr-name }}.
---

# How to get started with investigations

{% include [preview-by-request](../_includes/note-preview-by-request.md) %}

In this tutorial, you will create an investigation and run your first [KQL (Kusto Query Language)](kql-reference.md) query.

## Getting started {#before-you-begin}

{% include [before-you-begin](../_includes/ycdr/before-you-begin.md) %}

## Create an investigation {#create-investigation}

1. Go to [{{ sd-name }}]({{ link-sd-main }}).
1. In the left-hand panel, select **{{ ycdr-name }}**.
1. Navigate to the **{{ ui-key.yacloud_org.security.ycdr.YcdrPageLayout.investigations_wYxSe }}** tab.
1. Click **{{ ui-key.yacloud_org.security.siem.InvestigationsPage.create-investigation_iCPUP }}**.
1. Enter a name for your investigation, e.g., `Failed login analysis`.
1. Under **{{ ui-key.yacloud_org.security.siem.InvestigationPageLayout.fieldDescription_wiAxw }}**, add a description: `Searching for failed console login attempts within the last 30 minutes`.

## Create a query {#create-query}

1. In the query editor, enter the following KQL query:

   ```kql
   Events
   | project event_class, ['time']
   | limit 1
   ```

   This query:
   * Selects events from the `Events` table.
   * Displays the `event_class` and `time` fields.
   * Limits the result to a single entry.

1. Set the time period to **{{ ui-key.yacloud_org.security.ycdr.preset_last_30_minutes_s5Gq5 }}**.
1. Click the query run button.

## Analyze the results {#analyze-results}

After the query is completed, the results are displayed in a table with the following fields:

* `event_class`: Event class
* `time`: Event time

This is an example of a simple query which checks service performance. For more complex analysis, use additional queries and filters.


## What's next {#whats-next}

* Learn more about [investigations](concepts/investigations.md) and [queries](concepts/queries.md).
* Learn how to [manage investigations](operations/investigations/manage-investigations.md).
* Explore [working with queries](operations/queries/index.md).
* Review the [KQL reference](kql-reference.md).
