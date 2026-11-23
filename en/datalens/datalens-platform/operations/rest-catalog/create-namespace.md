---
title: Creating a namespace in a {{ datalens-platform-full-name }} REST catalog
description: Follow this guide to create namespaces in a {{ datalens-platform-full-name }} REST catalog.
---

# Creating a namespace

A [namespace](../../concepts/rest-catalog/index.md#namespace) is created within a [REST catalog](../../concepts/rest-catalog/index.md) and stores its data in a bucket. For the bucket, you can use a parent or existing bucket, or create a new one. To create a namespace:

1. Go to the ![image](../../../../_assets/console-icons/compass.svg) **Navigation** section and select the **REST catalogs** tab.
1. Open the REST catalog where you need to create a namespace.
1. Click ![image](../../../../_assets/console-icons/plus.svg) **Create namespace**.
1. In the **New namespace** window that opens, specify the basic parameters:
   * In the **Name** field, enter the namespace name.
   * Optionally, in the **Description** field, specify the purpose of the namespace.
1. Under **Bucket**, select where the namespace data will be stored:
   * **Parent**: Use the bucket of the parent REST catalog. Its name and capacity usage are displayed, e.g.: `bucket-default 66 / 500 GB`.
   * **New**: Create a new bucket. Set its parameters:

     {% include [backet-settings](../../../../_includes/dlp/rest-catalog/bucket.md) %}

1. Click **Create**.

You can create nested namespaces to manage tables and views within the REST catalog with greater granularity. To create a nested namespace:

1. Open the REST catalog where you need to create a nested namespace.
1. Hover over the namespace name and click ![image](../../../../_assets/console-icons/plus.svg) to the right of the name.
1. Specify the parameters for the namespace you are creating and save your changes.

{% note info %}

The maximum nesting depth for namespaces in a REST catalog is 32 levels.

{% endnote %}

Once a namespace has been created, you can [modify its settings](work-with-rest-catalog.md#edit-namespace) and [configure access to data](work-with-rest-catalog.md#access-rest-catalog).
