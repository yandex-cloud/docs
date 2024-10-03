---
title: How to buy a subscription on {{ marketplace-full-name }}
---

# Buying a subscription

To purchase a subscription, you need the [{{ roles-license-manager-user }}](../../security/index.md#license-manager-user) role for the folder.

{% list tabs group=service %}

- {{ compute-name }} {#compute}

   **When creating a VM**

   1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a VM.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. At the top right, click **{{ ui-key.yacloud.compute.instances.button_create }}**.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab and select a product that is available on a [subscription](../../concepts/users/subscription.md) basis.
   1. If the product you need is not in the list, click **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**.
   1. In the window that opens, select the product. To find products available by subscription, use the following filter: **Pricing type** → **Subscription**.
   1. Read the product description and subscription purchase terms and conditions and click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.

   {% include [buy-subscription-site](../../../_includes/marketplace/buy-subscription-site.md) %}

   After purchasing a subscription on the {{ marketplace-name }} website, you need to [link](lock-subscription.md) it to the virtual machine yourself.

- {{ managed-k8s-name }} {#managed-k8s}

   **After creating a cluster**

   1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the {{ managed-k8s-name }} cluster is located.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
   1. Select the cluster.
   1. Go to the **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
   1. Choose a product. To find products available by [subscription](../../concepts/users/subscription.md), use the **Pricing type** → **Subscription** filter.
   1. Read the product description and subscription purchase terms and conditions and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
   1. Specify app settings and click **Install**.

   **On the {{ marketplace-name }} website**

   1. On the [{{ marketplace-name }}](/marketplace) home page, select a product. To find products available by subscription, use the following filter: **Pricing type** → **Subscription**.
   1. Read the product description and subscription purchase terms and conditions and click **Buy subscription**.
   1. Select the folder and cluster where you want to deploy the product and click **Next**.
   1. Specify app settings and click **Install**.

   Once the app is installed, the subscription will be automatically linked to it.

- SaaS {#saas}

   {% include [buy-subscription-site](../../../_includes/marketplace/buy-subscription-site.md) %}

   After purchasing a subscription on the {{ marketplace-name }} website, you need to [link](lock-subscription.md) it to the service yourself.

{% endlist %}

By default, purchased subscriptions have auto-renewal enabled. [How to disable auto-renewal](cancel-subscription.md).