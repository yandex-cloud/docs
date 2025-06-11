---
title: Configuring access permissions for an asymmetric encryption key pair
description: Follow this guide to assign roles for an asymmetric encryption key pair.
---

# Configuring access permissions for an asymmetric encryption key pair

You can grant access to an [asymmetric encryption key pair](../concepts/asymmetric-encryption-key.md) to a user, service account, or user group. To do this, assign [roles](../../iam/concepts/access-control/roles.md) for the key pair. To choose the ones you need, [learn](../security/index.md#roles-list) about the service's roles.

## Assigning a role {#add-access-binding}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a folder containing an asymmetric encryption key pair.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
   1. In the left-hand panel, select ![image](../../_assets/kms/asymmetric-key.svg) **{{ ui-key.yacloud.kms.switch_asymmetric-keys }}**.
   1. On the **{{ ui-key.yacloud.kms.asymmetric-key.form.label_encryption }}** tab, click the name of the key pair.
   1. Go to ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** and click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
   1. Select the group, user, or service account you want to grant access to the key pair.
   1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the required roles.
   1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To assign a role for an asymmetric encryption key pair:

   1. See the description of the CLI role assignment command:

      ```bash
      yc kms asymmetric-encryption-key add-access-binding --help
      ```

   1. Get a list of asymmetric key pairs along with their IDs:

      ```bash
      yc kms asymmetric-encryption-key list
      ```

   1. Get the [ID of the user](../../iam/operations/users/get.md), [service account](../../iam/operations/sa/get-id.md), or user group you are assigning a role to.
   1. Use one of these commands to assign a role:

      * To a user:

         ```bash
         yc kms asymmetric-encryption-key add-access-binding \
           --id <key_pair_ID> \
           --role <role> \
           --user-account-id <user_ID>
         ```

      * To a federated user:

         ```bash
         yc kms asymmetric-encryption-key add-access-binding \
           --id <key_pair_ID> \
           --role <role> \
           --subject federatedUser:<user_ID>
         ```

      * To a service account:

         ```bash
         yc kms asymmetric-encryption-key add-access-binding \
           --id <key_pair_ID> \
           --role <role> \
           --service-account-id <service_account_ID>
         ```

      * To a user group:

         ```bash
         yc kms asymmetric-encryption-key add-access-binding \
           --id <key_pair_ID> \
           --role <role> \
           --subject group:<group_ID>
         ```

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To assign a role for an asymmetric encryption key pair through {{ TF }}:

   1. In the {{ TF }} configuration file, describe the resources you want to create:

       ```hcl
       resource "yandex_kms_asymmetric_encryption_key_iam_member" "key-viewers" {
         asymmetric_encryption_key_id = "<key_pair_ID>"
         role                         = "<role_1>"
         members                      = ["<subject_type>:<subject_ID>"]
       }
       ```

       Where:

       * `asymmetric_encryption_key_id`: ID of the asymmetric encryption key pair.
       * `role`: [Role](../security/index.md#roles-list) being assigned.
       * `members`: Types and IDs of [entities](../../iam/concepts/access-control/index.md#subject) assigned the role. Specify it as `userAccount:<user_ID>` or `serviceAccount:<service_account_ID>`.

       For more information about `yandex_kms_asymmetric_encryption_key_iam_member` resource properties, see the [provider documentation]({{ tf-provider-resources-link }}/kms_asymmetric_encryption_key_iam_member).

   1. Create the resources:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

       {{ TF }} will create all the required resources. You can check the new resources using this [CLI](../../cli/) command:

       ```bash
       yc kms asymmetric-key list-access-bindings <key_ID>
       ```

- API {#api}

   Use the [UpdateAccessBindings](../asymmetricencryption/api-ref/AsymmetricEncryptionKey/updateAccessBindings.md) method for the [AsymmetricEncryptionKey](../asymmetricencryption/api-ref/AsymmetricEncryptionKey/index.md) resource or the [AsymmetricEncryptionKeyService/UpdateAccessBindings](../asymmetricencryption/api-ref/grpc/AsymmetricEncryptionKey/updateAccessBindings.md) gRPC API call and provide the following in the request:

   * `ADD` value in the `access_binding_deltas[].action` parameter to add a role.
   * Role in the `access_binding_deltas[].access_binding.role_id` parameter.
   * ID of the subject you are assigning the role to in the `access_binding_deltas[].access_binding.subject.id` parameter.
   * Type of the subject you are assigning the role to in the `access_binding_deltas[].access_binding.subject.type` parameter.

{% endlist %}

## Assigning multiple roles {#set-access-bindings}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a folder containing an asymmetric encryption key pair.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
   1. In the left-hand panel, select ![image](../../_assets/kms/asymmetric-key.svg) **{{ ui-key.yacloud.kms.switch_asymmetric-keys }}**.
   1. On the **{{ ui-key.yacloud.kms.asymmetric-key.form.label_encryption }}** tab, click the name of the key pair.
   1. Go to ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** and click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
   1. Select the group, user, or service account you want to grant access to the key pair.
   1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the required roles.
   1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

   {% include [set-access-bindings-cli](../../_includes/iam/set-access-bindings-cli.md) %}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To assign multiple roles for an asymmetric encryption key pair:

   1. Make sure the key pair has no roles assigned that you would not want to lose:

      ```bash
      yc kms asymmetric-encryption-key list-access-bindings \
        --id <key_pair_ID>
      ```

   1. See the description of the CLI role assignment command:

      ```bash
      yc kms asymmetric-encryption-key set-access-bindings --help
      ```

   1. Get a list of asymmetric key pairs along with their IDs:

      ```bash
      yc kms asymmetric-encryption-key list
      ```

   1. Get the [ID of the user](../../iam/operations/users/get.md), [service account](../../iam/operations/sa/get-id.md), or user group you are assigning roles to.
   1. Use one of the commands below to assign roles:

      * To a Yandex account user:

         ```bash
         yc kms asymmetric-encryption-key set-access-bindings \
           --id <key_pair_ID> \
           --access-binding role=<role>,user-account-id=<user_ID>
         ```

      * To a federated user:

         ```bash
         yc kms asymmetric-encryption-key set-access-bindings \
           --id <key_pair_ID> \
           --access-binding role=<role>,subject=federatedUser:<user_ID>
         ```

      * To a service account:

         ```bash
         yc kms asymmetric-encryption-key set-access-bindings \
           --id <key_pair_ID> \
           --access-binding role=<role>,service-account-id=<service_account_ID>
         ```

      * To a user group:

         ```bash
         yc kms asymmetric-encryption-key set-access-bindings \
           --id <key_pair_ID> \
           --access-binding role=<role>,subject=group:<group_ID>
         ```

      Provide a separate `--access-binding` parameter for each role. For example:

      ```bash
      yc kms asymmetric-encryption-key set-access-bindings \
        --id <key_pair_ID> \
        --access-binding role=<role1>,service-account-id=<service_account_ID> \
        --access-binding role=<role2>,service-account-id=<service_account_ID> \
        --access-binding role=<role3>,service-account-id=<service_account_ID>
      ```

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To assign multiple roles for an asymmetric encryption key pair through {{ TF }}:

   1. In the {{ TF }} configuration file, describe the resources you want to create:

       ```hcl
       # Role 1
       resource "yandex_kms_asymmetric_encryption_key_iam_member" "key-viewers" {
         asymmetric_encryption_key_id = "<key_pair_ID>"
         role                         = "<role_1>"
         members                      = ["<subject_type>:<subject_ID>"]
       }

       # Role 2
       resource "yandex_kms_asymmetric_encryption_key_iam_member" "key-editors" {
         asymmetric_encryption_key_id = "<key_pair_ID>"
         role                         = "<role_2>"
         members                      = ["<subject_type>:<subject_ID>"]
       }
       ```

       Where:

       * `asymmetric_encryption_key_id`: ID of the asymmetric encryption key pair.
       * `role`: [Role](../security/index.md#roles-list) being assigned.
       * `members`: Types and IDs of [entities](../../iam/concepts/access-control/index.md#subject) assigned the role. Specify it as `userAccount:<user_ID>` or `serviceAccount:<service_account_ID>`.

       For more information about `yandex_kms_asymmetric_encryption_key_iam_member` resource properties, see the [provider documentation]({{ tf-provider-resources-link }}/kms_asymmetric_encryption_key_iam_member).

   1. Create the resources:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

       {{ TF }} will create all the required resources. You can check the new resources using this [CLI](../../cli/) command:

       ```bash
       yc kms asymmetric-key list-access-bindings <key_ID>
       ```

- API {#api}

   {% include [set-access-bindings-api](../../_includes/iam/set-access-bindings-api.md) %}

   Use the [SetAccessBindings method](../asymmetricencryption/api-ref/AsymmetricEncryptionKey/setAccessBindings.md) for the [AsymmetricEncryptionKey](../asymmetricencryption/api-ref/AsymmetricEncryptionKey/index.md) resource or the [AsymmetricEncryptionKeyService/SetAccessBindings](../asymmetricencryption/api-ref/grpc/AsymmetricEncryptionKey/setAccessBindings.md) gRPC API call. In your request, provide an array of objects, each one corresponding to a particular role and containing the following data:

   * Role in the `access_bindings[].role_id` parameter.
   * ID of the subject getting the roles in the `access_bindings[].subject.id` parameter.
   * Type of the subject getting the roles in the `access_bindings[].subject.type` parameter.

{% endlist %}
