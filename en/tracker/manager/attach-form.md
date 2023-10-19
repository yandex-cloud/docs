---
title: "How to set up a custom form for creating issues and embed it into the {{ tracker-name }} interface"
description: "You can use this guide to set up a custom form for creating issues and embed it into the {{ tracker-name }} interface."
---

# Using a form as a template for creating issues

{% note warning %}

Only the queue's owner can configure the queue by default.

{% endnote %}

You can use {{ forms-full-name }} to set up your form to act as a template for creating issues as well as integrate it with the {{ tracker-name }} interface. This form will be displayed on the issue creation page next to the standard one. It will help users create issues based on a certain template without being distracted by unnecessary fields and parameters.

## Step 1. Create and configure your form {#section_ovd_5hl_1gb}

1. Go to [{{ forms-full-name }}]({{ link-forms }}). If the service hasn't been activated, contact your company's administrator.

1. [Create](../../forms/new-form.md) a new form.

   Set up its fields to collect from users the data needed to create the issue.

1. Set up the form name. This name will be displayed in the {{ tracker-name }} interface when creating an issue.

1. Set up [integration with {{ tracker-name }}](../../forms/create-task.md) for the form.

1. [Publish](../../forms/publish.md#section_link) the form and copy the link to it from the **{{ ui-key.startrek.blocks-desktop_field-create-form.field-type-uri }}** field.

## Step 2. Connect your form to the queue {#section_xxj_fll_1gb}

1. Go to the [{{ tracker-name }}]({{ link-tracker }}).

1. {% include [go to settings](../../_includes/tracker/transition-page.md) %}

1. In the top-right corner, click ![](../../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Under **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--forms }}**, click **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_forms.add-btn }}**.

1. Add a link to the form.

1. Add a name and description for the form. Users will see them in the form selection window when creating an issue.

1. Click **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_form-editor.create-btn }}**.

