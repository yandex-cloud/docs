---
title: Creating a REST catalog in {{ datalens-platform-full-name }}
description: Follow this guide to create a new REST catalog in {{ datalens-platform-full-name }}.
alternate:
  - href: en/datalens/datalens-platform/operations/rest-catalog/create-rest-catalog.md
    type: text/markdown
    title: Markdown version
---

# Creating a REST catalog

In {{ yandex-cloud }}, you can create [REST catalogs](../../concepts/rest-catalog/index.md) to store tables and views. To create a REST catalog:

1. Go to the ![image](../../../../_assets/console-icons/compass.svg) **Navigation** section, select the **REST catalogs** tab, and click **Create**.
1. Under **General settings**, specify the catalog settings:
   * In the **Name** field, enter the catalog name.
   * Optionally, enter the catalog’s purpose in the **Description** field.
   * In the **Cloud environment** field, select the environment from the list. Make sure your REST catalog and clusters that will use it reside in the same cloud and environment. If you do not have the appropriate environment, click **Create** and [create a new one](../clusters/manage-environment.md#create-environment).
1. Under **Bucket**, set up the catalog’s data storage:

   {% include [backet-settings](../../../../_includes/dlp/rest-catalog/bucket.md) %}

1. Click **Create REST catalog**.

As a result, you should see your REST catalog in the catalog list. You can [continue working](work-with-rest-catalog.md) with it or create [namespaces](create-namespace.md) in it.
