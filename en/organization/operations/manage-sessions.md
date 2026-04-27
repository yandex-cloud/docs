---
title: Managing {{ org-full-name }} user sessions
description: Follow this guide to view and terminate sessions of federated and local users in {{ org-full-name }}.
---

# Managing user sessions

The administrator can view and terminate {{ org-full-name }} [sessions](../concepts/sessions.md) of the organization’s [federated](../../iam/concepts/users/accounts.md#saml-federation) and [local](../../iam/concepts/users/accounts.md#local) users. The [organization](../concepts/organization.md) roles the administrator needs for that are [`organization-manager.federations.userAdmin`](../security/index.md#organization-manager-federations-userAdmin) and [`organization-manager.userpools.userAdmin`](../security/index.md#organization-manager-userpools-userAdmin) or higher, respectively.

{% note warning %}

The sessions of a user with a Yandex account can be [viewed](./manage-account.md#view-sessions) and [terminated](./manage-account.md#end-sessions) by this exact user only.

{% endnote %}

## Viewing user sessions {#view-sessions}

To view the active sessions of a federated or local user of the organization:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![person](../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}** and select the [federated](../../iam/concepts/users/accounts.md#saml-federation) or [local](../../iam/concepts/users/accounts.md#local) user from the list that opens.

      To find the right user faster, use the filter at the top of the screen.
  1. In the window that opens, go to the **{{ ui-key.yacloud_org.organization.users.UserPageLayout.title_sso-sessions_pDJYw }}** tab.

      The list that opens will contain the following information about the selected user’s sessions:

      {% include [session-contents-list](../../_includes/organization/session-contents-list.md) %}

{% endlist %}

## Terminating user sessions {#end-sessions}

To terminate the active sessions of a federated or local user of the organization:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![person](../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}** and select the [federated](../../iam/concepts/users/accounts.md#saml-federation) or [local](../../iam/concepts/users/accounts.md#local) user from the list that opens.

      To find the right user faster, use the filter at the top of the screen.
  1. In the window that opens, go to the **{{ ui-key.yacloud_org.organization.users.UserPageLayout.title_sso-sessions_pDJYw }}** tab. 

      The list that opens will contain information about the selected user’s sessions.
  1. To terminate a specific session:
  
      1. In the session row, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select ![arrow-right-from-square](../../_assets/console-icons/arrow-right-from-square.svg) **{{ ui-key.yacloud_org.actions.end }}**.
      1. In the window that opens, confirm the termination.

      As a result, the user will cease to have access to services that use {{ org-full-name }} as an identity provider from the selected device.
  1. To terminate all the user's sessions:

      1. In the top-right corner, click ![arrow-right-from-square](../../_assets/console-icons/arrow-right-from-square.svg) **{{ ui-key.yacloud_org.organization.users.action_end-all-sso-sessions_7DUdt }}**.
      1. In the window that opens, confirm the termination of all sessions.

      As a result, the user will cease to have access to services that use {{ org-full-name }} as an identity provider from all devices.
      
  To resume access, the user will have to re-authenticate in {{ org-full-name }}.

{% endlist %}

#### See also {#see-also}

* [{#T}](../concepts/sessions.md)
* [{#T}](./manage-account.md)