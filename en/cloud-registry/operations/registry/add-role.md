---
title: How to assign roles for a registry in {{ cloud-registry-full-name }}
description: Follow this tutorial to assign roles for a registry.
---

# Assigning a role for a registry

{% note info %}

We recommend assigning roles to the public group `All users` only for Docker registries: correct operation is not guaranteed for other formats.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where the registry is located.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-registry }}**.
  1. Select the registry.
  1. Navigate to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
  1. Click **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
  1. In the window that opens, select a group, user, or [service account](../../../iam/concepts/users/service-accounts.md).
  1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the role from the list.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Run the following command to assign a role for a registry:

  * To a user:

    ```bash
    yc cloud-registry registry add-access-binding <registry_name_or_ID> \
      --role <role> \
      --user-account-id <user_ID>
    ```

  * To a [service account](../../../iam/concepts/users/service-accounts.md):

    ```bash
    yc cloud-registry registry add-access-binding <registry_name_or_ID> \
      --role <role> \
      --service-account-id <service_account_ID>
    ```

  * To all authenticated users (the `All authenticated users` [public group](../../../iam/concepts/access-control/public-group.md#allAuthenticatedUsers)):

    ```bash
    yc cloud-registry registry add-access-binding <registry_name_or_ID> \
      --role <role> \
      --allAuthenticatedUsers
    ```

  * To all users (the `All users` [public group](../../../iam/concepts/access-control/public-group.md#allUsers)):

    ```bash
    yc cloud-registry registry add-access-binding <registry_name_or_ID> \
      --role <role> \
      --allUsers
    ```

    Where `<role>` is the [role](../../security/index.md#service-roles) you want to assign.

  To revoke all registry roles and assign new ones right away, use the `yc cloud-registry registry set-access-bindings` command.
  
  **Example**

  In the example below, we are assigning the `cloud-registry.admin` role for `my-first-registry` to a user.

  ```bash
  yc cloud-registry registry add-access-binding my-first-registry \
    --role cloud-registry.admin \
    --user-account-id ajeugsk5ubk6********
  ```

  Result:

  ```text
  done (4s)
  ```
- API {#api}

  Use the [updateAccessBindings](../../api-ref/Registry/updateAccessBindings.md) REST API method for the [Registry](../../api-ref/Registry/index.md) resource or the [RegistryService/UpdateAccessBindings](../../api-ref/grpc/Registry/updateAccessBindings.md) gRPC API call.

{% endlist %}

For more information on role assignment, see [this {{ iam-full-name }} guide](../../../iam/operations/roles/grant.md).
