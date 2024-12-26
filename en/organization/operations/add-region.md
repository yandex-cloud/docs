---
title: How to add a managed organization in {{ org-full-name }}
description: In this tutorial, you will learn how to link a new region to your organization.
---

# Connecting a managed organization

{% include [note-preview-by-request](../../_includes/note-preview-by-request.md) %}

1. Go to [{{ org-full-name }}]({{ link-org-cloud-center }}).

1. In the pop-up window, click **{{ ui-key.yacloud_org.entity.organization.other-regions_attach-region_action }}**.

1. Click **{{ ui-key.yacloud_org.entity.organization.other-regions_confirm-dialog_submit }}**.

1. Enter your company name and description.

1. Click **{{ ui-key.yacloud_org.form.organization.select.action.create }}**.

This will create a [managed organization](../concepts/controlled-org.md), and you will become able to [create](../../resource-manager/operations/cloud/create-in-another-region.md) a cloud in another [region](../../overview/concepts/region.md).
