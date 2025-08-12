---
title: How to deactivate or delete an OIDC application in {{ org-full-name }}
description: Follow this guide to deactivate, reactivate, and delete an OIDC application in {{ org-name }}.
---

# Deactivating and deleting an OIDC application in {{ org-full-name }}

{% include [note-preview](../../../_includes/note-preview.md) %}

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

## Deactivate the application {#deactivate}

If you need to temporarily disable authentication in an external app using the [OpenID Connect](https://en.wikipedia.org/wiki/OpenID#OpenID_Connect_(OIDC)) (OIDC) single sign-on for your [organization’s](../../concepts/organization.md) users, deactivate the relevant [OIDC application](../../concepts/applications.md#oidc) in {{ org-name }}:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. Next to the OIDC application you want to deactivate, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![pause](../../../_assets/console-icons/pause.svg) **{{ ui-key.yacloud_org.action.applications.components.action_deactivate }}**.
  1. In the window that opens, confirm the operation.

{% endlist %}

This will deactivate the OIDC application and switch its status to `Suspended`, and the users will no longer be able to use it for authentication in the relevant external app.

## Activate the application {#reactivate}

If you need to restore the ability of your organization’s users to authenticate in an external app using the OIDC single sign-on, activate the OIDC application in {{ org-name }}:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. Next to the OIDC application you want to activate, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![arrows-rotate-right](../../../_assets/console-icons/arrows-rotate-right.svg) **{{ ui-key.yacloud_org.action.applications.components.action_activate }}**.
  1. In the window that opens, confirm the operation.

{% endlist %}

This will activate the OIDC application, switch its status to `Active`, and enable the users added to the application to use it for authentication in the external app again.

## Delete the application {#delete}

To delete an OIDC application:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. Next to the OIDC application you want to delete, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, confirm the operation.

{% endlist %}

This will delete the OIDC application, and the users will no longer be able to use it for authentication in the external app.

#### See also {#see-also}

* [{#T}](./oidc-create.md)
* [{#T}](./oidc-update.md)
* [{#T}](../add-account.md)
* [{#T}](../../concepts/applications.md#oidc)
* [{#T}](../manage-groups.md)