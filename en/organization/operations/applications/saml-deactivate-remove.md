---
title: How to deactivate or delete a SAML application in {{ org-full-name }}
description: Follow this guide to deactivate, reactivate, and delete a SAML application in {{ org-name }}.
---

# Deactivating and deleting a SAML application in {{ org-full-name }}

{% include [note-preview](../../../_includes/note-preview.md) %}

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

## Deactivate the application {#deactivate}

If you need to temporarily disable authentication in an external app using the [SAML](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language)-based single sign-on for your [organization](../../concepts/organization.md) users, deactivate the relevant [SAML application](../../concepts/applications.md#saml).

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. In the row with the SAML application you want to deactivate, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![pause](../../../_assets/console-icons/pause.svg) **{{ ui-key.yacloud_org.action.applications.components.action_deactivate }}**.
  1. In the window that opens, confirm the operation.

{% endlist %}

As a result, the SAML application will be deactivated and switch to the `Suspended` status, and the users will no longer be able to use it for authentication in the relevant external app.

## Activate the application {#reactivate}

If you need to restore the ability of your organization users to authenticate in an external app using the SAML-based single sign-on, activate the relevant SAML application in {{ org-name }}:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. In the row with the SAML application you want to activate, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![arrows-rotate-right](../../../_assets/console-icons/arrows-rotate-right.svg) **{{ ui-key.yacloud_org.action.applications.components.action_activate }}**.
  1. In the window that opens, confirm the operation.

{% endlist %}

As a result, the SAML application will be activated and switch to the `Active` status, and the users added to the application will again be able to use it for authentication in the external app.

## Delete the application {#delete}

To delete a SAML application:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. In the row with the SAML application you want to delete, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, confirm the operation.

{% endlist %}

As a result, the SAML application will be deleted, and the users will no longer be able to use it for authentication in the external app.

#### See also {#see-also}

* [{#T}](./saml-create.md)
* [{#T}](./saml-update.md)
* [{#T}](../add-account.md)
* [{#T}](../../concepts/applications.md)
* [{#T}](../manage-groups.md)