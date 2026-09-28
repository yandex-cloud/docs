---
title: Configuring access permissions for a symmetric encryption key
description: Follow this guide to assign roles for a symmetric encryption key.
---

# Configuring access permissions for a symmetric encryption key

You can grant access to a [symmetric key](../concepts/key.md) to a user, service account, or user group. To do this, assign [roles](../../iam/concepts/access-control/roles.md) for the key. To choose the ones you need, [learn](../security/index.md#roles-list) about the existing roles.

## Assigning a role {#add-access-binding}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the secret.
  1. [Navigate]({{ link-console-main }}/link/kms) to **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
  1. Click the key name.
  1. Navigate to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** section and click **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
  1. Select the group, user, or service account you need to grant access to the key.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the roles.
  1. Click **{{ ui-key.yacloud_components.acl.AclEditDialogNew.action_apply }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To assign a role for a symmetric key:

  1. View the description of the CLI command for assigning roles:

     ```bash
     yc kms symmetric-key add-access-binding --help
     ```

  1. Get a list of symmetric keys with their IDs:

     ```bash
     yc kms symmetric-key list
     ```

  1. Get the [ID of the user](../../organization/operations/users-get.md), [service account](../../iam/operations/sa/get-id.md), user group, organization, or identity federation to which (or to the users of which) you are assigning a role.
  1. To assign a role, run this command:

     ```bash
     yc kms symmetric-key add-access-binding \
       --id <key_ID> \
       --role <role> \
       --subject <subject_type>:<subject_ID>
     ```

     Where:

     * `--id`: Symmetric key ID.
     * `--role`: [Role](../security/index.md#roles-list).
     * `--subject`: [Subject](../../iam/concepts/access-control/index.md#subject) getting the role.

         {% cut "Subject designations" %}

         {% include [subjects-designations-cli](../../_includes/iam/subjects-designations-cli.md) %}

         {% endcut %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To assign a role for a symmetric encryption key using {{ TF }}:

  1. In the {{ TF }} configuration file, describe the resources you want to create:

      ```hcl
      resource "yandex_kms_symmetric_key_iam_member" "key-viewers" {
        symmetric_encryption_key_id = "<key_ID>"

        role   = "<role>"
        member = "<subject_type>:<subject_ID>"
      }
      ```

      Where:

      * `symmetric_encryption_key_id`: ID of the symmetric encryption key.
      * `role`: [Role](../security/index.md#roles-list).
      * `member`: [Subject](../../iam/concepts/access-control/index.md#subject) getting the role.

          {% cut "Subject designations" %}

          {% include [subjects-designations-terraform](../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

      For more on the properties of the `yandex_kms_symmetric_key_iam_member` resource, see [this provider guide]({{ tf-provider-resources-link }}/kms_symmetric_key_iam_member).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources using this [CLI](../../cli/) command:

      ```bash
      yc kms symmetric-key list-access-bindings <key_ID>
      ```

- API {#api}

  Use the [updateAccessBindings](../api-ref/SymmetricKey/updateAccessBindings.md) method for the [SymmetricKey](../api-ref/SymmetricKey/index.md) resource or the [SymmetricKeyService/UpdateAccessBindings](../api-ref/grpc/SymmetricKey/updateAccessBindings.md) gRPC API call and provide the following in the request:

  * `ADD` value in the `accessBindingDeltas[].action` parameter to add a role.
  * Role in the `accessBindingDeltas[].accessBinding.roleId` parameter.
  * ID of the [subject](../../iam/concepts/access-control/index.md#subject) getting the role in the `accessBindingDeltas[].accessBinding.subject.id` parameter.
  * Type of the subject getting the role in the `accessBindingDeltas[].accessBinding.subject.type` parameter.

      {% cut "Subject designations" %}

      {% include [subjects-designations-api](../../_includes/iam/subjects-designations-api.md) %}

      {% endcut %}

{% endlist %}

## Assigning multiple roles {#set-access-bindings}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the secret.
  1. [Navigate]({{ link-console-main }}/link/kms) to **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
  1. Click the key name.
  1. Navigate to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** section and click **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
  1. Select the group, user, or service account you need to grant access to the key.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the roles.
  1. Click **{{ ui-key.yacloud_components.acl.AclEditDialogNew.action_apply }}**.

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

  1. View the description of the CLI command for assigning roles:

     ```bash
     yc kms symmetric-key set-access-bindings --help
     ```

  1. Get a list of symmetric encryption keys with their IDs:

     ```bash
     yc kms symmetric-key list
     ```

  1. Get the [ID of the user](../../organization/operations/users-get.md), [service account](../../iam/operations/sa/get-id.md), user group, organization, or identity federation to which (or to the users of which) you are assigning roles.
  1. To assign roles, run this command:

     ```bash
     yc kms symmetric-key set-access-bindings \
       --id <key_ID> \
       --access-binding role=<role>,subject=<subject_type>:<subject_ID>
     ```

     Where:

     * `--id`: Symmetric key ID.
     * Where `--access-binding` is the [role](../security/index.md#roles-list) and the [subject](../../iam/concepts/access-control/index.md#subject) the role is assigned to.

         {% cut "Subject designations" %}

         {% include [subjects-designations-cli](../../_includes/iam/subjects-designations-cli.md) %}

         {% endcut %}

     Provide a separate `--access-binding` parameter for each role. Here is an example:

     ```bash
     yc kms symmetric-key set-access-bindings \
       --id <key_ID> \
       --access-binding role=<role1>,subject=<subject_type>:<subject_ID> \
       --access-binding role=<role2>,subject=<subject_type>:<subject_ID> \
       --access-binding role=<role3>,subject=<subject_type>:<subject_ID>
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To assign multiple roles for a symmetric encryption key using {{ TF }}:

  1. In the {{ TF }} configuration file, describe the resources you want to create:

      ```hcl
      # Role 1
      resource "yandex_kms_symmetric_key_iam_member" "key-viewers" {
        symmetric_encryption_key_id = "<key_ID>"

        role   = "<role_1>"
        member = "<subject_type>:<subject_ID>"
      }

      # Role 2
      resource "yandex_kms_symmetric_key_iam_member" "key-editors" {
        symmetric_encryption_key_id = "<key_ID>"

        role   = "<role_2>"
        member = "<subject_type>:<subject_ID>"
      }
      ```

      Where:

      * `symmetric_encryption_key_id`: ID of the symmetric encryption key.
      * `role`: [Role](../security/index.md#roles-list).
      * `member`: [Subject](../../iam/concepts/access-control/index.md#subject) getting the role.

          {% cut "Subject designations" %}

          {% include [subjects-designations-terraform](../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

      For more on the properties of the `yandex_kms_symmetric_key_iam_member` resource, see [this provider guide]({{ tf-provider-resources-link }}/kms_symmetric_key_iam_member).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources using this [CLI](../../cli/) command:

      ```bash
      yc kms symmetric-key list-access-bindings <key_ID>
      ```

- API {#api}

  {% include [set-access-bindings-api](../../_includes/iam/set-access-bindings-api.md) %}

  Use the [SetAccessBindings](../api-ref/SymmetricKey/setAccessBindings.md) method for the [SymmetricKey](../api-ref/SymmetricKey/index.md) resource or the [SymmetricKeyService/SetAccessBindings](../api-ref/grpc/SymmetricKey/setAccessBindings.md) gRPC API call. In your request, provide an array of objects, each one matching a particular role and containing the following data:

  * Role in the `accessBindings[].roleId` parameter.
  * ID of the [subject](../../iam/concepts/access-control/index.md#subject) getting the roles in the `accessBindings[].subject.id` parameter.
  * Type of the subject getting the roles in the `accessBindings[].subject.type` parameter.

      {% cut "Subject designations" %}

      {% include [subjects-designations-api](../../_includes/iam/subjects-designations-api.md) %}

      {% endcut %}

{% endlist %}
