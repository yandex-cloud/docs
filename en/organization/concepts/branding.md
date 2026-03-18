---
title: Branding in {{ org-full-name }}
description: '{{ org-name }} allows you to customize the appearance of authentication pages and login forms to align them with your corporate style and preferences.'
---

# Branding


{% include [note-preview](../../_includes/note-preview.md) %}

In {{ org-name }}, you can customize the appearance of authentication pages and login forms to align them with your corporate style and preferences.

Authentication pages can be branded only if signing in via SSO to external [applications](./applications.md). The login pages of other {{ yandex-cloud }} services do not support branding.

{% note info %}

This functionality is available only to organizations that have paid for their [limit](../pricing.md) of {{ org-name }} users authenticating via SSO to external applications. If the the limit had been paid earlier but not in the new billing month, branding will stop working.

{% endnote %}

Branding can be configured only by users with the `organization-manager.admin` or `organization-manager.organizations.owner` [role](../security/index.md). The following settings can be customized separately for the light and dark color themes:

* Uploading of custom images in `WebP`, `PNG`, `JPEG`, `JPG` format:
  * Background image (up to 3840×2160 px, max 4 MB)
  * Logo for the top of the form (minimum 1920×1920 px, max 512 KB)
  * Favicon (up to 512×512 px, max 512 KB)
* Button and text field border colors
* Welcome message text
* Email template used as a prompt in the email input field
* Enabling or disabling the Yandex ID and SSO log-in methods

#### See also {#see-also}

* [{#T}](../operations/manage-branding.md)
