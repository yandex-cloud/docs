---
title: "Tutorial on changing\_the organization for the cloud in {{ resmgr-full-name }}"
description: "In this tutorial, you will learn how to change the organization for the cloud in {{ resmgr-full-name }}."
---

# Changing an organization for a cloud

If there are multiple organizations registered in your account, you can move clouds between them.

{% note info %}

Manually [add](../../../organization/operations/add-account.md) to the target organization all users having the roles assigned for the cloud to transfer, folders, or resources in the source organization. The roles are transferred to the new organization automatically.

{% endnote %}


To move a cloud to another organization, you must have the `{{ roles-organization-owner }}` role for the organization and `{{ roles-cloud-owner }}` for the cloud. For information on assigning roles to users, see [Roles for cloud](set-access-bindings.md#access-to-user) and [Roles for organization](../../../organization/security/index.md#add-role).

{% list tabs %}

- Management console



  1. In the [management console]({{ link-console-main }}), select the appropriate cloud.
  1. In the top-right corner, click ![***](../../../_assets/options.svg) and select **{{ ui-key.yacloud.component.console-dashboard.button_action-change-org }}**.
  1. Select a new organization from the list and click **{{ ui-key.yacloud.iam.cloud.change-org.button_change }}**.

- API

   Currently, you cannot change the organization assigned to the cloud using the API.

{% endlist %}
