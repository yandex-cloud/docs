---
title: How to buy a subscription in {{ marketplace-full-name }}
---

# Buying a subscription

To purchase a subscription, you need the [{{ roles-license-manager-user }}](../../security/index.md#license-manager-user) role for the folder.

By default, auto-renewal is enabled for all subscriptions you buy, but you can [disable](cancel-subscription.md) it at any time.


## When creating a resource {#with-resource}

You can buy a subscription when creating a virtual machine or after creating a {{ managed-k8s-name }} cluster.

{% list tabs group=service %}

- {{ compute-name }} {#compute}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a VM.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. At the top right, click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab and select a product available by [subscription](../../concepts/users/subscription.md).
  1. If the product you need is not in the list, click **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**.
  1. In the window that opens, select the product. To find products available by subscription, use the **{{ ui-key.yacloud.marketplace-v2.label_tariff-type }}** → **{{ ui-key.yacloud_components.marketplace.product-pricing-type_license }}** filter.
  1. Read the product description and subscription terms and conditions, select the pricing type, and click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
  1. Finish [creating](../../../compute/operations/vm-create/create-linux-vm.md) your VM.

  The subscription will be linked to the new VM automatically.

- {{ managed-k8s-name }} {#managed-k8s}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the {{ managed-k8s-name }} cluster is located.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Select the cluster.
  1. Go to the ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
  1. Choose a product. To find products available by [subscription](../../concepts/users/subscription.md), use the **{{ ui-key.yacloud.marketplace-v2.label_tariff-type }}** → **{{ ui-key.yacloud_components.marketplace.product-pricing-type_license }}** filter.
  1. Read the product description and subscription terms and conditions, select the pricing type, and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
  1. Configure the application.
  1. Under **{{ ui-key.yacloud.marketplace-v2.section_tariff-section }}**, select the subscription.

      If you do not have a subscription, click **{{ ui-key.yacloud.marketplace-v2.action_purchase-license }}**. Then specify the number of subscriptions you want to buy and click **{{ ui-key.yacloud.marketplace-v2.action_purchase-license }}**.

  1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.

  Once the app is installed, the subscription will be automatically linked to it.

{% endlist %}


## On the {{ marketplace-name }} website {#marketplace}

{% list tabs group=service %}

- {{ compute-name }} {#compute}

  1. On the [{{ marketplace-name }}](/marketplace) home page, select a product. To find products available by subscription, use the **{{ ui-key.yacloud.marketplace-v2.label_tariff-type }}** → **{{ ui-key.yacloud_components.marketplace.product-pricing-type_license }}** filter.
  1. Read the product description and subscription terms and conditions, select the pricing type, and click **Create VM**.
  1. Specify the number of subscriptions you want to purchase, choose the folder where the subscriptions will be active, and click **{{ ui-key.yacloud.marketplace-v2.action_purchase-license }}**.
  1. Click **{{ ui-key.yacloud.marketplace-v2.action_attach-license-compute }}**.

      If there is no appropriate VM, click **{{ ui-key.yacloud.marketplace-v2.action_create-vm }}** and [create](../../../compute/operations/vm-create/create-linux-vm.md) one.

  After purchasing a subscription on the {{ marketplace-name }} website, you need to [link](lock-subscription.md) it to the virtual machine yourself if you did not do so in the previous step.

- {{ managed-k8s-name }} {#managed-k8s}

  1. On the [{{ marketplace-name }}](/marketplace) home page, select a product. To find products available by subscription, use the **{{ ui-key.yacloud.marketplace-v2.label_tariff-type }}** → **{{ ui-key.yacloud_components.marketplace.product-pricing-type_license }}** filter.
  1. Read the product description and subscription terms and conditions, select the pricing type, and click **Deploy in cluster**.
  1. Specify the number of subscriptions you want to buy, select the cluster where you want to deploy the product, and click **{{ ui-key.yacloud.marketplace-v2.action_purchase-license }}**.

  After purchasing a subscription on the {{ marketplace-name }} website, you need to [install](../../../managed-kubernetes/operations/applications/marketplace.md#install-apps) the app in the cluster yourself. Once installation is complete, the subscription will be linked to the cluster.

- SaaS {#saas}

  1. On the [{{ marketplace-name }}](/marketplace) home page, select a product. To find products available by subscription, use the **{{ ui-key.yacloud.marketplace-v2.label_tariff-type }}** → **{{ ui-key.yacloud_components.marketplace.product-pricing-type_license }}** filter.
  1. Read the product description and subscription terms and conditions, select the pricing type, and click **Buy subscription**.
  1. Specify the number of subscriptions you want to purchase, choose the folder where the subscriptions will be active, and click **{{ ui-key.yacloud.marketplace-v2.action_purchase-license }}**.
  1. Click **{{ ui-key.yacloud.marketplace-v2.action_attach-to-service }}**.

  After purchasing a subscription on the {{ marketplace-name }} website, you need to [link](lock-subscription.md) it to the service yourself if you did not do so in the previous step.

{% endlist %}


## On the **Available products** page in the management console {#console-products}

{% list tabs group=service %}

- {{ compute-name }} {#compute}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a VM.
  1. At the top of the screen, click the panel with {{ marketplace-name }} ready-made solutions.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/circles-4-square.svg) **Available products**.
  1. Choose a product. To find products available by subscription, use the **{{ ui-key.yacloud.marketplace-v2.label_tariff-type }}** → **{{ ui-key.yacloud_components.marketplace.product-pricing-type_license }}** filter.
  1. Read the product description and subscription terms and conditions, select the pricing type, and click **{{ ui-key.yacloud.marketplace-v2.action_purchase-license }}**.
  1. Specify the number of subscriptions you want to buy and click **{{ ui-key.yacloud.marketplace-v2.action_purchase-license }}**.
  1. Click **{{ ui-key.yacloud.marketplace-v2.action_attach-license-compute }}**.

      If there is no appropriate VM, click **{{ ui-key.yacloud.marketplace-v2.action_create-vm }}** and [create](../../../compute/operations/vm-create/create-linux-vm.md) one.

  After purchasing a subscription on the **Available products** page in the [management console]({{ link-console-main }}), you need to [link](lock-subscription.md) it to the virtual machine yourself if you did not do so in the previous step.

- {{ managed-k8s-name }} {#managed-k8s}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the {{ managed-k8s-name }} cluster is located.
  1. At the top of the screen, click the panel with {{ marketplace-name }} ready-made solutions.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/circles-4-square.svg) **Available products**.
  1. Choose a product. To find products available by subscription, use the **{{ ui-key.yacloud.marketplace-v2.label_tariff-type }}** → **{{ ui-key.yacloud_components.marketplace.product-pricing-type_license }}** filter.
  1. Read the product description and subscription terms and conditions, select the pricing type, and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
  1. Select the folder and cluster where you want to deploy the product and click **{{ ui-key.yacloud.marketplace-v2.button_continue }}**.
  1. Configure the application.
  1. Under **{{ ui-key.yacloud.marketplace-v2.section_tariff-section }}**, select the subscription.

      If you do not have a subscription, click **{{ ui-key.yacloud.marketplace-v2.action_purchase-license }}**. Then specify the number of subscriptions you want to buy and click **{{ ui-key.yacloud.marketplace-v2.action_purchase-license }}**.

  1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.

  Once the app is installed, the subscription will be automatically linked to it.

- SaaS {#saas}

  1. In the [management console]({{ link-console-main }}), select the folder where the subscriptions will be active.
  1. At the top of the screen, click the panel with {{ marketplace-name }} ready-made solutions.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/circles-4-square.svg) **Available products**.
  1. Choose a product. To find products available by subscription, use the **{{ ui-key.yacloud.marketplace-v2.label_tariff-type }}** → **{{ ui-key.yacloud_components.marketplace.product-pricing-type_license }}** filter.
  1. Read the product description and subscription terms and conditions, select the pricing type, and click **{{ ui-key.yacloud.marketplace-v2.action_purchase-license }}**.
  1. Specify the number of subscriptions you want to buy and click **{{ ui-key.yacloud.marketplace-v2.action_purchase-license }}**.
  1. Click **{{ ui-key.yacloud.marketplace-v2.action_attach-to-service }}**.

  After purchasing a subscription on the **Available products** page in the [management console]({{ link-console-main }}), you need to [link](lock-subscription.md) it to the service yourself if you did not do so in the previous step.

{% endlist %}