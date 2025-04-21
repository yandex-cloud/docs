---
title: Creating a connection to {{ speechsense-full-name }} from {{ datalens-full-name }}
description: In this tutorial, you will learn how to create a connection to {{ speechsense-name }} from {{ datalens-short-name }}.
---

# Creating a connection to {{ speechsense-name }} from {{ datalens-full-name }}

{% include [datalens-speechsense-connection-roles-note](../../../_includes/datalens/operations/datalens-speechsense-connection-roles-note.md) %}

You can create a connection from the {{ speechsense-name }} project page.

{% list tabs group=instructions %}


- {{ speechsense-name }} interface {#speechsense}

  1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
  1. Go to the space you need and select a project.
  1. Navigate to the **{{ ui-key.yc-ui-talkanalytics.reports.reports }}** tab.
  1. Click **{{ ui-key.yc-ui-talkanalytics.reports.datalens-key-value }}** to go to {{ datalens-short-name }}. The **Project ID** field in your {{ speechsense-name }} connection will be automatically filled in.

     ![image](../../../_assets/datalens/operations/connection/connection-speechsense.png)

  1. Click **Create connection**.
  1. Give your connection a name and click **Create**.

{% endlist %}
