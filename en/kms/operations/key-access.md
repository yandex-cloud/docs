---
title: Configuring access permissions for a symmetric encryption key
description: Follow this guide to assign roles for a symmetric encryption key.
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
  1. Go to ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** and click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. Select the group, user, or service account you want to grant access to the key.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the required roles.
  1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To assign a role for a symmetric key:

  1. See the description of the CLI role assignment command:

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

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To assign a role for a symmetric encryption key using {{ TF }}:

  1. In the {{ TF }} configuration file, define the parameters of the resources you want to create:

      ```hcl
      resource "yandex_kms_symmetric_encryption_key_iam_member" "key-viewers" {
        symmetric_encryption_key_id = "<key_ID>"

        role    = "<role>"
        members = ["<subject_type>:<subject_ID>","<subject_type>:<subject_ID>"]
      }
      ```

      Where:

      * `symmetric_encryption_key_id`: ID of the symmetric encryption key.
      * `role`: [Role](../security/index.md#roles-list).
      * `members`: List of types and IDs of [subjects](../../iam/concepts/access-control/index.md#subject) getting the role. Use this format: `userAccount:<user_ID>` or `serviceAccount:<service_account_ID>`.

      For more information about the `yandex_kms_symmetric_encryption_key_iam_member` resource properties, see the [provider documentation]({{ tf-provider-resources-link }}/kms_symmetric_encryption_key_iam_member).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all required resources. You can check the new resources using this [CLI](../../cli/) command:

      ```bash
      yc kms symmetric-key list-access-bindings <key_ID>
      ```

- API {#api}

  Use the [updateAccessBindings](../api-ref/SymmetricKey/updateAccessBindings.md) method for the [SymmetricKey](../api-ref/SymmetricKey/index.md) resource or the [SymmetricKeyService/UpdateAccessBindings](../api-ref/grpc/SymmetricKey/updateAccessBindings.md) gRPC API call and provide the following in the request:

  * `ADD` value in the `accessBindingDeltas[].action` parameter to add a role.
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
  1. Go to ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** and click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. Select the group, user, or service account you want to grant access to the key.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the required roles.
  1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

  {% include [set-access-bindings-cli](../../_includes/iam/set-access-bindings-cli.md) %}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To assign multiple roles for a symmetric encryption key:

  1. Make sure the symmetric key has no roles assigned that you would not want to lose:

     ```bash
     yc kms symmetric-key list-access-bindings \
       --id <key_ID>
     ```

  1. See the description of the CLI role assignment command:

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

     Provide a separate `--access-binding` flag for each role. For example:

      ```bash
      yc kms symmetric-key set-access-bindings \
        --id <key_ID> \
        --access-binding role=<role1>,service-account-id=<service_account_ID> \
        --access-binding role=<role2>,service-account-id=<service_account_ID> \
        --access-binding role=<role3>,service-account-id=<service_account_ID>
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To assign multiple roles for a symmetric encryption key using {{ TF }}:

  1. In the {{ TF }} configuration file, define the parameters of the resources you want to create:

      ```hcl
      # Role 1
      resource "yandex_kms_symmetric_encryption_key_iam_member" "key-viewers" {
        symmetric_encryption_key_id = "<key_ID>"

        role    = "<role_1>"
        members = ["<subject_type>:<subject_ID>"]
      }

      # Role 2
      resource "yandex_kms_symmetric_encryption_key_iam_member" "key-editors" {
        symmetric_encryption_key_id = "<key_ID>"

        role    = "<role_2>"
        members = ["<subject_type>:<subject_ID>"]
      }
      ```

      Where:

      * `symmetric_encryption_key_id`: ID of the symmetric encryption key.
      * `role`: [Role](../security/index.md#roles-list).
      * `members`: List of types and IDs of [subjects](../../iam/concepts/access-control/index.md#subject) getting the role. Use this format: `userAccount:<user_ID>` or `serviceAccount:<service_account_ID>`.

      For more information about the `yandex_kms_symmetric_encryption_key_iam_member` resource properties, see the [provider documentation]({{ tf-provider-resources-link }}/kms_symmetric_encryption_key_iam_member).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all required resources. You can check the new resources using this [CLI](../../cli/) command:

      ```bash
      yc kms symmetric-key list-access-bindings <key_ID>
      ```

- API {#api}

  {% include [set-access-bindings-api](../../_includes/iam/set-access-bindings-api.md) %}

  Use the [setAccessBindings](../api-ref/SymmetricKey/setAccessBindings.md) method for the [SymmetricKey](../api-ref/SymmetricKey/index.md) resource or the [SymmetricKeyService/SetAccessBindings](../api-ref/grpc/SymmetricKey/setAccessBindings.md) gRPC API call. In your request, provide an array of objects, each one corresponding to a particular role and containing the following data:

  * Role in the `accessBindings[].roleId` parameter.
  * ID of the subject getting the roles in the `accessBindings[].subject.id` parameter.
  * Type of the subject getting the roles in the `accessBindings[].subject.type` parameter.

{% endlist %}
