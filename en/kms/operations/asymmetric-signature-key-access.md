---
title: "Configuring access permissions for a digital signature key pair"
description: "Follow this guide to assign roles for an asymmetric digital signature key pair."
---

# Configuring access permissions for a digital signature key pair

You can grant access to an asymmetric [digital signature key pair](../concepts/asymmetric-signature-key.md) to a user, service account, or user group. To do this, assign [roles](../../iam/concepts/access-control/roles.md)for the digital signature key pair. To choose the ones you need, [learn](../security/index.md#roles-list) about the service's roles.

## Assigning a role {#add-access-binding}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a folder containing an asymmetric encryption key pair.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
   1. In the left-hand panel, select ![image](../../_assets/kms/asymmetric-key.svg) **{{ ui-key.yacloud.kms.switch_asymmetric-keys }}**.
   1. On the **{{ ui-key.yacloud.kms.asymmetric-key.form.label_signature }}** tab, click the name of the key pair.
   1. Go to the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** section and click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
   1. Select the group, user, or service account you want to grant access to the key pair.
   1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the roles.
   1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To assign a role for an asymmetric digital signature key pair:

   1. See the description of the CLI role assignment command:

      ```bash
      yc kms asymmetric-signature-key add-access-binding --help
      ```

   1. Get a list of digital signature key pairs with their IDs:

      ```bash
      yc kms asymmetric-signature-key list
      ```

   1. Get the [ID of the user](../../iam/operations/users/get.md), [service account](../../iam/operations/sa/get-id.md), or user group you are assigning a role to.
   1. Use one of these commands to assign a role:

      * To a user:

         ```bash
         yc kms asymmetric-signature-key add-access-binding \
            --id <key_pair_ID> \
            --role <role> \
            --user-account-id <user_ID>
         ```

      * To a federated user:

         ```bash
         yc kms asymmetric-signature-key add-access-binding \
            --id <key_pair_ID> \
            --role <role> \
            --subject federatedUser:<user_ID>
         ```

      * To a service account:

         ```bash
         yc kms asymmetric-signature-key add-access-binding \
            --id <key_pair_ID> \
            --role <role> \
            --service-account-id <service_account_ID>
         ```

      * To a user group:

         ```bash
         yc kms asymmetric-signature-key add-access-binding \
            --id <key_pair_ID> \
            --role <role> \
            --subject group:<group_ID>
         ```

- API {#api}

   Use the [AsymmetricSignatureKeyService/UpdateAccessBindings](../api-ref/grpc/asymmetric_signature_key_service.md#UpdateAccessBindings) gRPC API call and provide the following in the request:

   * `ADD` in the `access_binding_deltas[].action` parameter to add a role.
   * Role in the `access_binding_deltas[].access_binding.role_id` parameter.
   * ID of the subject you are assigning the role to in the `access_binding_deltas[].access_binding.subject.id` parameter.
   * Type of the subject you are assigning the role to in the `access_binding_deltas[].access_binding.subject.id` parameter.

{% endlist %}

## Assign multiple roles {#set-access-bindings}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a folder containing an asymmetric encryption key pair.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
   1. In the left-hand panel, select ![image](../../_assets/kms/asymmetric-key.svg) **{{ ui-key.yacloud.kms.switch_asymmetric-keys }}**.
   1. On the **{{ ui-key.yacloud.kms.asymmetric-key.form.label_signature }}** tab, click the name of the key pair.
   1. Go to the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** section and click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
   1. Select the group, user, or service account you want to grant access to the key pair.
   1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the roles.
   1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

   {% include [set-access-bindings-cli](../../_includes/iam/set-access-bindings-cli.md) %}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To assign multiple roles for a digital signature key pair:

   1. Make sure the key pair has no roles assigned that you would rather not lose:

      ```bash
      yc kms asymmetric-signature-key list-access-bindings \
         --id <key_pair_ID>
      ```

   1. See the description of the CLI role assignment command:

      ```bash
      yc kms asymmetric-signature-key set-access-bindings --help
      ```

   1. Get a list of digital signature key pairs with their IDs:

      ```bash
      yc kms asymmetric-signature-key list
      ```

   1. Get the [ID of the user](../../iam/operations/users/get.md), [service account](../../iam/operations/sa/get-id.md), or user group you are assigning roles to.
   1. Use one of the commands below to assign roles:

      * To a user with a Yandex account:

         ```bash
         yc kms asymmetric-signature-key set-access-bindings \
            --id <key_pair_ID> \
            --access-binding role=<role>,user-account-id=<user_ID>
         ```

      * To a federated user:

         ```bash
         yc kms asymmetric-signature-key set-access-bindings \
            --id <key_pair_ID> \
            --access-binding role=<role>,subject=federatedUser:<user_ID>
         ```

      * To a service account:

         ```bash
         yc kms asymmetric-signature-key set-access-bindings \
            --id <key_pair_ID> \
            --access-binding role=<role>,service-account-id=<service_account_ID>
         ```

      * To a user group:

         ```bash
         yc kms asymmetric-signature-key set-access-bindings \
            --id <key_pair_ID> \
            --access-binding role=<role>,subject=group:<group_ID>
         ```

      Provide a separate `--access-binding` flag for each role. Example:

      ```bash
      yc kms asymmetric-signature-key set-access-bindings \
         --id <key_pair_ID> \
         --access-binding role=<role_1>,service-account-id=<service_account_ID> \
         --access-binding role=<role_2>,service-account-id=<service_account_ID> \
         --access-binding role=<role_3>,service-account-id=<service_account_ID>
      ```

- API {#api}

   {% include [set-access-bindings-api](../../_includes/iam/set-access-bindings-api.md) %}

   Use the [AsymmetricSignatureKeyService/SetAccessBindings](../api-ref/grpc/asymmetric_signature_key_service.md#SetAccessBindings) gRPC API call. In your request, provide an array of objects, each one corresponding to a particular role and containing the following data:

   * Role in the `access_bindings[].role_id` parameter.
   * ID of the subject you are assigning the roles to in the `access_bindings[].subject.id` parameter.
   * Type of the subject you are assigning the roles to in the `access_bindings[].subject.type` parameter.

{% endlist %}
