---
title: Creating a connection to {{ speechsense-full-name }} from {{ datalens-full-name }}
description: In this tutorial, you will learn how to create a connection to {{ speechsense-name }} from {{ datalens-short-name }}.
---

# Creating a connection to {{ speechsense-name }} from {{ datalens-full-name }}

{% include [datalens-speechsense-connection-roles-note](../../../_includes/datalens/operations/datalens-speechsense-connection-roles-note.md) %}

You can create a connection from the {{ datalens-full-name }} interface or from the {{ speechsense-name }} project page.

{% list tabs group=instructions %}

- {{ datalens-name }} interface {#datalens}

  {% include [create-speechsense-connection](../../../_includes/datalens/operations/datalens-create-speechsense-connection.md) %}

- {{ speechsense-name }} interface {#speechsense}

  1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
  1. Go to the space you need and select a project.
  1. Navigate to the **{{ ui-key.yc-ui-talkanalytics.reports.reports }}** tab.
  1. Click **{{ ui-key.yc-ui-talkanalytics.reports.datalens-key-value }}** to go to {{ datalens-short-name }}. The **Project ID** field in your {{ speechsense-name }} connection will be automatically filled in.
  1. Leave the **Automatically create dashboard, charts, and dataset over connection** option enabled if you want to get a ready-to-use dashboard, dataset, and standard charts.

     ![image](../../../_assets/datalens/operations/connection/connection-speechsense.png)

  1. Click **Create connection**.
  1. Give your connection a name and click **Create**.

{% endlist %}
