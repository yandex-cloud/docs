---
title: How to add a controlled organization in {{ org-full-name }}
description: In this tutorial, you will learn how to link a new region to an organization.
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

This will create a [controlled organization](../concepts/controlled-org.md) and connect a new [region](../../overview/concepts/region.md) to the main organization.

The controlled organization is not shown in the list of organizations in the management console and in {{ cloud-center }}: you cannot switch to it and manage it directly like a regular organization. To start working with resources in the newly connected region, [create a cloud in that region](../../resource-manager/operations/cloud/create-in-another-region.md). From then on, you can work with this cloud in the new region's management console the same way as with the clouds of the main organization.

{% note info %}

You will be able to manage resources in another region only after the initial synchronization of the main and controlled organizations. Synchronization time depends on the size of the main organization and may take up to several hours.

{% endnote %}
