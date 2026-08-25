---
title: Branding in {{ org-full-name }}
description: '{{ org-full-name }} allows you to customize the appearance of authentication pages and login forms to align them with your corporate style and preferences.'
---

# Branding


{% include [note-preview](../../_includes/note-preview.md) %}

In {{ org-full-name }}, you can customize the appearance of authentication pages and login forms to align them with your corporate style and preferences. In addition, branding allows you to customize the sign-in methods available to your users.

Authentication pages can be branded if signing in via SSO either to external [applications](./applications/index.md) and {{ yandex-cloud }} services. When signing in to {{ yandex-cloud }} services, branding works as follows:

* If you access the service via a regular link, the initial authentication page will not contain any branding. The branded login page will open after you enter your username.

    Here is an example of a regular link: `{{ link-datalens-main }}`.
* If you access the service via a direct link containing a [user pool](./user-pools.md) ID, the branded login page will open right away.

    Here is an example of a direct link: `{{ link-datalens-main }}/federations/ek0o6g0irskn********`.
    
    Where `ek0o6g0irskn********` is a user pool ID.

Branding can be configured only by users with the `organization-manager.admin` or `organization-manager.organizations.owner` [role](../security/index.md).

{% note info %}

This functionality is available only to organizations that have paid for their [limit](../pricing.md) of {{ org-full-name }} users authenticating via SSO to external applications. If the limit was paid earlier but not in the new billing month, branding will stop working.

{% endnote %}

## Login page appearance settings {#appearance}

{% note tip %}

Appearance is customized separately for the light and dark color themes.

{% endnote %}

The login page appearance settings offer you the following:

* Configurable button and text field border colors.
* Uploading custom `WebP`, `PNG`, `JPEG`, and `JPG` images:

    * Background image (up to 3840×2160 px, max 4 MB).
    * Logo for the top of the form (minimum 1920×1920 px, max 512 KB).
    * Favicon (up to 512×512 px, max 512 KB).
* Editing of logo and favicon images prior to uploading.
    
    With our built-in editor, you can prepare your logo or favicon for upload: crop out excess background, rescale, and adjust the layout.

## Sign-in method settings {#login-options}

Branding includes the following features to help you manage your sign-in methods and text hints:

* Customizable welcome text.
* Customizable hint for the username input field.
* Hideable input field.
* Automatic user redirection for sign-in via a specified [identity federation](./add-federation.md).

    {% note info %}

    With the automatic redirection feature enabled, users do not see any sign-in form.

    {% endnote %}

* Enabling and disabling individual sign-in methods:

    * With Yandex ID.
    * Via SSO.
    * Via identity federations (the login page can feature up to three separate federation sign-in buttons).

#### Useful links {#see-also}

* [{#T}](../operations/manage-branding.md)
