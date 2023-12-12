---
title: "How to create products in the {{ marketplace-full-name }} partner dashboard"
description: "Follow this guide to create a product in the {{ marketplace-full-name }} partner dashboard."
---

# Creating a product in the partner dashboard {{ marketplace-short-name }}

You can add different types of products to {{ marketplace-short-name }}:
* Products for {{ compute-full-name }}: Upload an image based on [Linux](create-image.md#create).
* Products for {{ managed-k8s-full-name }}: Upload a helm chart and all the docker images it contains to the {{ yandex-cloud }} [registry](../../container-registry/concepts/registry.md). For more information, see [{#T}](create-container.md).

## Creating an application for product approval {#create-prod}

{% include [product](../../_includes/marketplace/product-new.md) %}