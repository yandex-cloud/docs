---
title: "Configuring access permissions for a symmetric encryption key"
description: "Follow this guide to assign roles for a symmetric encryption key."
---

# Configuring access permissions for a symmetric encryption key

You can grant access to a [symmetric key](../concepts/key.md) to a user, service account, or user group. To do this, assign [roles](../../iam/concepts/access-control/roles.md) for the key. To choose the ones you need, [learn](../security/index.md#roles-list) about the service's roles.

## Assigning a role {#add-access-binding}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where the secret is stored.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
   1. Click the name of the key you need.
   1. Go to the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** section and click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
   1. Select the group, user, or service account you want to grant access to the key.
   1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the roles.
   1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To assign a role for a symmetric key:

   1. See the description of the CLI command for assigning a role:

      ```bash
      yc kms symmetric-key add-access-binding --help
      ```

   1. Get a list of symmetric keys with their IDs:

      ```bash
      yc kms symmetric-key list
      ```

   1. Get the [ID of the user](../../iam/operations/users/get.md), [service account](../../iam/operations/sa/get-id.md), or user group you are assigning a role to.
   1. Use one of these commands to assign a role:

      * To a user:

         ```bash
         yc kms symmetric-key add-access-binding \
            --id <key_ID> \
            --role <role> \
            --user-account-id <user_ID>
         ```

      * To a federated user:

         ```bash
         yc kms symmetric-key add-access-binding \
            --id <key_ID> \
            --role <role> \
            --subject federatedUser:<user_ID>
         ```

      * To a service account:

         ```bash
         yc kms symmetric-key add-access-binding \
            --id <key_ID> \
            --role <role> \
            --service-account-id <service_account_ID>
         ```

      * To a user group:

         ```bash
         yc kms symmetric-key add-access-binding \
            --id <key_ID> \
            --role <role> \
            --subject group:<group_ID>
         ```

- API {#api}

   Use the [updateAccessBindings](../api-ref/SymmetricKey/updateAccessBindings.md) method for the [SymmetricKey](../api-ref/SymmetricKey/index.md) resource or the [SymmetricKeyService/UpdateAccessBindings](../api-ref/grpc/symmetric_key_service.md#UpdateAccessBindings) gRPC API call and provide the following in the request:

   * `ADD` in the `accessBindingDeltas[].action` parameter to add a role.
   * Role in the `accessBindingDeltas[].accessBinding.roleId` parameter.
   * ID of the subject you are assigning the role to in the `accessBindingDeltas[].accessBinding.subject.id` parameter.
   * Type of the subject you are assigning the role to in the `accessBindingDeltas[].accessBinding.subject.type` parameter.

{% endlist %}

## Assigning multiple roles {#set-access-bindings}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where the secret is stored.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
   1. Click the name of the key you need.
   1. Go to the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** section and click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
   1. Select the group, user, or service account you want to grant access to the key.
   1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the roles.
   1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

   {% include [set-access-bindings-cli](../../_includes/iam/roles/set-access-bindings-cli.md) %}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To assign multiple roles for a symmetric encryption key:

   1. Make sure the symmetric key has no roles assigned that you would not want to lose:

      ```bash
      yc kms symmetric-key list-access-bindings \
         --id <key_ID>
      ```

   1. See the description of the CLI command for assigning roles:

      ```bash
      yc kms symmetric-key set-access-bindings --help
      ```

   1. Get a list of symmetric encryption keys with their IDs:

      ```bash
      yc kms symmetric-key list
      ```

   1. Get the [ID of the user](../../iam/operations/users/get.md), [service account](../../iam/operations/sa/get-id.md), or user group you are assigning roles to.
   1. Use one of the commands below to assign roles:

      * To a Yandex account user:

         ```bash
         yc kms symmetric-key set-access-bindings \
            --id <key_ID> \
            --access-binding role=<role>,user-account-id=<user_ID>
         ```

      * To a federated user:

         ```bash
         yc kms symmetric-key set-access-bindings \
            --id <key_ID> \
            --access-binding role=<role>,subject=federatedUser:<user_ID>
         ```

      * To a service account:

         ```bash
         yc kms symmetric-key set-access-bindings \
            --id <key_ID> \
            --access-binding role=<role>,service-account-id=<service_account_ID>
         ```

      * To a user group:

         ```bash
         yc kms symmetric-key set-access-bindings \
            --id <key_ID> \
            --access-binding role=<role>,subject=group:<group_ID>
         ```

      Provide a separate `--access-binding` flag for each role. Example:

      ```bash
      yc kms symmetric-key set-access-bindings \
        --id <key_ID> \
        --access-binding role=<role_1>,service-account-id=<service_account_ID> \
        --access-binding role=<role_2>,service-account-id=<service_account_ID> \
        --access-binding role=<role_3>,service-account-id=<service_account_ID>
      ```

- API {#api}

   {% include [set-access-bindings-api](../../_includes/iam/roles/set-access-bindings-api.md) %}

   Use the [setAccessBindings](../api-ref/SymmetricKey/setAccessBindings.md) method for the [SymmetricKey](../api-ref/SymmetricKey/index.md) resource or the [SymmetricKeyService/SetAccessBindings](../api-ref/grpc/symmetric_key_service.md#SetAccessBindings) gRPC API call. In your request, provide an array of objects, each one corresponding to a particular role and containing the following data:

   * Role in the `accessBindings[].roleId` parameter.
   * ID of the subject getting the roles in the `accessBindings[].subject.id` parameter.
   * Type of the subject getting the roles in the `accessBindings[].subject.type` parameter.

{% endlist %}
