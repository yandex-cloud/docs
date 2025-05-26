---
title: How to get started with {{ marketplace-full-name }}
description: Follow this guide to learn how to use out-of-the-box solutions from {{ yandex-cloud }} and partners featured on {{ marketplace-name }}.
---


# How to get started with {{ marketplace-full-name }}

{{ marketplace-name }} offers out-of-the-box solutions for development, data analysis, security, business apps, and more. {{ marketplace-name }} products are available to all {{ yandex-cloud }} users.


## Getting started {#before-you-begin}

Sign up for {{ yandex-cloud }} and create a [billing account](../../../billing/concepts/billing-account.md):

1. Navigate to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or register a new account.
1. On the **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** page, check that you have a linked billing account with the `ACTIVE` status. If you do not have a billing account, [create one](../../../billing/quickstart/index.md) and [link](../../../billing/operations/pin-cloud.md) a cloud to it.
1. On the [cloud page]({{ link-console-cloud }}), [create](../../../resource-manager/operations/folder/create.md) or select a [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) your {{ marketplace-name }} solution will operate in.


## Select and install the product {#select-and-setup-product}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the appropriate folder.
  1. Click the **{{ ui-key.yacloud.marketplace-v2.label_service-short-description }} panel at the top of the screen.
  1. In the **{{ ui-key.yacloud.marketplace-v2.label_product-filter-search-placeholder }}** field, enter the name of the product you want to install or use search filters by category, [product type](../../concepts/users/products-types.md), or billing type. You can also use sorting.
  1. Click the selected {{ marketplace-name }} product's card and study its description, use cases, and other information.
  1. Follow the instructions on the card to install the product.

{% endlist %}


## Product installation example {#examples}

To create a VM from a [Ubuntu 24.04 LTS](/marketplace/products/yc/ubuntu-2404-lts-oslogin) distribution in {{ marketplace-name }}:

{% list tabs group=instructions %}

- Management console {#console}

  1. On the {{ marketplace-name }} home page, select the Ubuntu 24.04 LTS image and click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
  1. In the **{{ ui-key.yacloud.compute.instances.create.label_title }}** window that opens, the Ubuntu 24.04 LTS [image](../../../compute/concepts/image.md) will be selected under **{{ ui-key.yacloud.compute.instances.create.section_image }}** on the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.field_os-login-access-method }}** to [connect](../../../compute/operations/vm-connect/os-login.md) to your VM and manage its access using [{{ oslogin }}](../../../organization/concepts/os-login.md) in {{ org-full-name }}.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, enter a name for the VM name or leave the automatically generated one.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  Your Ubuntu 24.04 LTS VM will now appear on the list. The new VM will get an [IP address](../../../vpc/concepts/address.md) and a [host name](../../../vpc/concepts/address.md#fqdn) (FQDN).

{% endlist %}

