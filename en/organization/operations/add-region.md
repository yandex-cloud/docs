---
title: How to add a controlled organization in {{ org-full-name }}
description: In this tutorial, you will learn how to link a new region to an organization in {{ org-full-name }}.
---

# Creating a controlled organization

{% note info %}

{% include [kz-region-role](../../_includes/organization/kz-region-role.md) %}

{% endnote %}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Go to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the **{{ ui-key.yacloud_org.dashboard.organization.label_regions }}** field under your organization name, click the region you want to link.
  1. In the pop-up window, click **{{ ui-key.yacloud_org.dashboard.organization.action_connect-new-region }}**.
  1. Click **{{ ui-key.yacloud_org.dashboard.organization.action_submit-new-region }}**.
  1. Enter your company name and description.
  1. Click **{{ ui-key.yacloud_components.organization.action.create }}**.

{% endlist %}

This will create a [controlled organization](../concepts/controlled-org.md), and you will become able to [create](../../resource-manager/operations/cloud/create-in-another-region.md) a cloud in another [region](../../overview/concepts/region.md).

{% note info %}

You will be able to manage resources in another region only after the initial synchronization of the main and controlled organizations. Synchronization time depends on the size of the main organization and may take up to several hours.

{% endnote %}
