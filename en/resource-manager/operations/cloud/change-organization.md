---
title: "How to change an organization for a cloud in {{ resmgr-full-name }}"
description: "In this tutorial, you will learn how to change an organization for a cloud in {{ resmgr-full-name }}."
---

# Changing an organization for a cloud

If there are multiple organizations registered in your account, you can move clouds between them.

{% note info %}

Manually [add](../../../organization/operations/add-account.md) to the target organization all users having the roles assigned for the cloud to transfer, folders, or resources in the source organization. The roles are transferred to the new organization automatically.

{% endnote %}

To move a cloud to another organization, you need the `{{ roles-cloud-owner }}` [role](../../../organization/security/index.md#organization-manager-organizations-owner) for the cloud being transferred and the `{{ roles-organization-owner }}` [role](../../security/index.md#resource-manager-clouds-owner) for the organization to transfer that cloud to. For more information about assigning roles, see [Assigning a role for a cloud](set-access-bindings.md#access-to-user) and [Assigning a role for an organization](../../../organization/security/index.md#add-role).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the relevant cloud.
  1. In the top-right corner, click ![***](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.component.console-dashboard.button_action-change-org }}**.
  1. Select a new organization from the list and click **{{ ui-key.yacloud.iam.cloud.change-org.button_change }}**.

- API {#api}

  Currently, you cannot change the organization assigned to the cloud using the API.

{% endlist %}

## See also {#see-also}

* [{#T}](../../../organization/operations/leave-organization.md)
* [{#T}](../../../organization/concepts/manage-services.md)
