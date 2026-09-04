---
title: How to create a project
description: Follow this guide to create a project.
---

# Creating a project

To create a [project](../../program/var-tools.md#project-reg) in the Partner portal:

{% list tabs group=instructions %}

- Partner portal {#partner}

  1. Go to the [partner portal]({{ link-cloud-partners }}).
  1. In the left-hand panel, select ![icon](../../../_assets/console-icons/briefcase.svg) **Deals**.
  1. In the top-right corner, click **Create deal**.
  1. In the window that opens:
     1. In the **Name** field, enter the project name.
     1. In the **Type** list, select **Project**.
     1. In the **Products** list, select the {{ yandex-cloud }} or Yandex 360 products your customer consumes.

        {% note warning %}

        Once a deal has been created, you cannot change products from {{ yandex-cloud }} to Yandex 360 and back.

        {% endnote %}

     1. In the **Account** list, select the customer's account. If there is no account yet, click ![image](../../../_assets/console-icons/plus.svg) and follow [this guide](../create-account.md) to create one.
     1. In the **Project scope** drop-down menu, select your target scope. Use the link with instructions that appears below to get your project scope ID for the next step.
     1. In the **Project scope** list, specify the project scope ID.
     1. In the **Amount** field, specify the target consumption threshold for the project.
     1. Select **Consumption type**: monthly or one-time.
     1. Specify a **Closing period** for the project You can specify it accurate to the month or day.
     1. Optionally, add a **Description** for the project.

  1. Click **Create**. The project will be added to the page with the list of deals.

{% endlist %}