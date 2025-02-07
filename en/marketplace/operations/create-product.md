---
title: How to create a product in the {{ marketplace-full-name }} partner dashboard
description: Follow this guide to create a product in the {{ marketplace-full-name }} partner dashboard.
---

# Creating a product in the {{ marketplace-short-name }} partner dashboard

You can add different types of products to {{ marketplace-short-name }}:
  * Products for {{ compute-full-name }}: Upload an image based on [Linux](create-image.md#create).
  * Products for {{ managed-k8s-full-name }}: Upload a helm chart and all the docker images it contains to the {{ yandex-cloud }} [registry](../../container-registry/concepts/registry.md). For more information, see [{#T}](create-container.md).
  * {{ cloud-apps-name }}: Select {{ yandex-cloud }} services for the application to operate based on and create an application template.

## Apply for product approval {#create-prod}

{% include [product](../../_includes/marketplace/product-new.md) %}