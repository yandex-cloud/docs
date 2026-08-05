---
title: How to configure {{ org-full-name }} branding
description: Follow this guide to customize the appearance of authentication pages and the login form for access to external applications from {{ org-full-name }}.
---

# Configuring branding


{% include [note-preview](../../_includes/note-preview.md) %}

## Configuring the login page appearance {#appearance}

To configure the login page [appearance](../concepts/branding.md#appearance):

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, select ![brush](../../_assets/console-icons/brush.svg) **{{ ui-key.yacloud_org.pages.organization-branding }}**.
  1. Under **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.styleSection.title }}**, configure the dark and light color themes separately:

     {% note info %}

     With our built-in editor, you can prepare your logo or favicon for upload: crop out excess background, rescale, and adjust the layout. The supported image formats are `WebP`, `PNG`, `JPEG`, and `JPG`.

     {% endnote %}

     1. **{{ ui-key.yacloud_org.organization.branding.AuthBrandingThemeBlock.backgroundName }}**: Select the page background image (up to 3840×2160 px, max 4 MB).
     1. **{{ ui-key.yacloud_org.organization.branding.AuthBrandingThemeBlock.logoName }}**: Select an image for the top of the form (from 1920×1920 px, max 512 KB).
     1. **{{ ui-key.yacloud_org.organization.branding.AuthBrandingThemeBlock.faviconName }}**: Select an image for the browser tab next to the website name (up to 512×512 px, max 512 KB).
     1. **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.styleSection.colorLabel }}**: Select the button and text field border colors.
  1. To save your changes, click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Setting up sign-in methods {#login-options}

To set up user [sign-in methods](../concepts/branding.md#login-options):

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, select ![brush](../../_assets/console-icons/brush.svg) **{{ ui-key.yacloud_org.pages.organization-branding }}**.
  1. To enable automatic user redirection for sign-in via an [identity federation](../concepts/add-federation.md):

      1. Under **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.autoLoginSection.title }}**, enable **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.autoLoginSection.redirectLabel }}**.
      1. In the **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.autoLoginSection.federationFieldLabel }}** field that appears, select the identity federation the users will use to auto sign-in to applications.

      {% note info %}

      If **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.autoLoginSection.redirectLabel }}** is on, other user sign-in settings in the **{{ ui-key.yacloud_org.pages.organization-branding }}** section become unavailable, and users do not get to choose their sign-in methods.

      {% endnote %}

  1. To configure the sign-in methods available to users on the login form:

      1. Make sure the **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.autoLoginSection.redirectLabel }}** option is off under **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.autoLoginSection.title }}**.
      1. Under **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.loginSection.title }}**:

          1. In the **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.loginSection.welcomeLabel }}** field, enter the text to appear below the logo.
          1. In the **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.loginSection.placeholderInlineLabel }}** field, enter the prompt text for the login input field.

              {% note info %}

              By default, the login input field is displayed on the login form. To hide it, disable the **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.loginSection.loginInputLabel }}** option.

              {% endnote %}

          1. To disable user sign-in via Yandex ID, turn off **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.loginSection.yandexIdLabel }}**.

              By default, Yandex sign-in ID is on.
          1. To disable sign-in via SSO, turn off **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.loginSection.ssoLabel }}**.

              By default, sign-in via SSO is on.
          1. To add additional identity federation sign-in buttons to the form, turn on **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.loginSection.federationLabel }}** and do the following:

              1. Select the identity federation you are adding a sign-in button for in the **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.federationLoginSection.federationFieldLabel }}** field.
              1. Enter the button text in the **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.federationLoginSection.buttonTextFieldLabel }}** field.
              1. To add an additional button for sign-in via another identity federation, click the **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.federationLoginSection.addButton }}** button configure the new button.

                  You can add up to three identity federation sign-in buttons to the sign-in page.
  1. To save your changes, click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

{% note tip %}

To discard your changes and set up branding from scratch, click ![broom-motion](../../_assets/console-icons/broom-motion.svg) **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.clearAllAction }}** and then **{{ ui-key.yacloud.common.save }}**. This will reset both the appearance and sign-in settings.

{% endnote %}