---
title: How to link a subscription purchased on {{ marketplace-full-name }} to a resource, app, or service
---

# Linking a subscription

To link a subscription, you need the [{{ roles-license-manager-user }}](../../security/index.md#license-manager-user) role for the folder.

{% list tabs group=service %}

- {{ compute-name }} {#compute}

  1. In the [management console]({{ link-console-main }}), select the folder where the [subscription](../../concepts/users/subscription.md) is located.
  1. At the top of the screen, click the panel with ready-made solutions for {{ marketplace-name }}.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/file-ruble.svg) **{{ ui-key.yacloud.marketplace-v2.label_licenses }}**.
  1. In the line with the appropriate subscription, click ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.marketplace-v2.action_specify-vm }}**.
  1. Select a virtual machine or [create a new one](../../../compute/operations/images-with-pre-installed-software/create.md).
  1. Click **{{ ui-key.yacloud.common.save }}**.

- {{ managed-k8s-name }} {#managed-k8s}

  The subscription is linked to the {{ managed-k8s-full-name }} app when it is installed.

- SaaS {#saas}

  1. In the [management console]({{ link-console-main }}), select the folder where the [subscription](../../concepts/users/subscription.md) is located.
  1. At the top of the screen, click the panel with ready-made solutions for {{ marketplace-name }}.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/file-ruble.svg) **{{ ui-key.yacloud.marketplace-v2.label_licenses }}**.
  1. In the line with the appropriate subscription, click ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.marketplace-v2.action_goto-partner-url }}**.
  1. You will be redirected to the appropriate service page. Follow the instructions on the page to authenticate and sign up.

{% endlist %}