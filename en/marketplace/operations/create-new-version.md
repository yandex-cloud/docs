---
title: Creating a new product version in {{ marketplace-full-name }}
description: Follow this guide to create a new product version.
---

# Creating a new product version

In the **{{ ui-key.yacloud_portal.marketplace_v2.product.tab_versions }}** tab, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_portal.marketplace_v2.version.version-table_action_create }}**. Fill out the form with the required information:

{% note info %}

All text fields support [Markdown](https://ydocs.tech/en/).

{% endnote %}

{% list tabs group=service %}

- {{ compute-name }} {#compute}

  {% include [product-version-compute](../../_includes/marketplace/product-version-compute.md) %}

- {{ cos-name }} {#cos}

  {% include [product-version-cos](../../_includes/marketplace/product-version-cos.md) %}

- {{ managed-k8s-name }} {#managed-k8s}

  {% include [product-version-k8s](../../_includes/marketplace/product-version-k8s.md) %}

- {{ cloud-apps-name }} {#cloud-apps}

  {% include [product-version-cloud-apps](../../_includes/marketplace/product-version-cloud-apps.md) %}

{% endlist %}

Before publication, the version must be moderated by technical experts and editors. When moderation succeeds, you can publish the approved version.