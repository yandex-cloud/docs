---
title: How to configure {{ org-full-name }} branding
description: Follow this guide to customize the appearance of authentication pages and the login form for access to external applications from {{ org-full-name }}.
---

# Configuring branding


{% include [note-preview](../../_includes/note-preview.md) %}

To configure [branding](../concepts/branding.md):

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, select ![brush](../../_assets/console-icons/brush.svg) **{{ ui-key.yacloud_org.pages.organization-branding }}**.
  1. Under **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.styleSection.title }}**, configure the dark and light color themes separately:

     1. **{{ ui-key.yacloud_org.organization.branding.AuthBrandingThemeBlock.backgroundName }}**: Select the page background image (up to 3840×2160 px, max 4 MB).
     1. **{{ ui-key.yacloud_org.organization.branding.AuthBrandingThemeBlock.logoName }}**: Select an image for the top of the form (from 1920×1920 px, max 512 KB).
     1. **{{ ui-key.yacloud_org.organization.branding.AuthBrandingThemeBlock.faviconName }}**: Select an image for the browser tab next to the website name (up to 512×512 px, max 512 KB).
     1. **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.styleSection.colorLabel }}**: Select the button and text field border colors.

     {% note tip %}
     
     The following image formats are supported: WebP, PNG, JPEG, JPG.
     
     {% endnote %}

  1. Under **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.loginSection.title }}**:

     1. In the **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.loginSection.welcomeLabel }}** field, enter the text to appear below the logo.
     1. In the **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.loginSection.placeholderLabel }}** field, enter the email template to appear in the input field.
     1. Under **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.loginSection.alternativeEntryLabel }}**, enable or disable the Yandex ID and SSO log-in methods.

  1. To discard your changes and set up branding from scratch, click **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.clearAllAction }}**.
  1. To save your changes, click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}