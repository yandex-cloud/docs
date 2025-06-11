---
title: Configuring DNS zone access permissions in {{ dns-name }}
description: In this tutorial, you will learn how to configure DNS zone access permissions.
---

# Configuring DNS zone access permissions

Assign an appropriate [role](../../iam/concepts/access-control/roles.md) to a user, group, or [service account](../../iam/concepts/users/service-accounts.md) to provide [DNS zone](../concepts/dns-zone.md) access.

## Assigning a role {#add-access}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for the DNS zone role assignment:

      ```bash
      yc dns zone add-access-binding --help
      ```

  1. Get a DNS zone list in the default [folder](../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc dns zone list
      ```

  1. Check currently assigned roles for the DNS zone you want to update:

      ```bash
      yc dns zone list-access-bindings <zone_ID>
      ```

  1. To assign the role, run the following command:

      * Assigning the role to a user:

        ```bash
        yc dns zone add-access-binding <zone_ID> \
          --user-account-id <user_ID> \
          --role <role>
        ```

        Where:

        * `--user-account-id`: [User ID](../../iam/operations/users/get.md). To assign the role to all authenticated users, use the `--all-authenticated-users` flag.
        * `--role`: [Role](../security/index.md#roles-list) to assign.

      * Assigning the role to a service account:

        ```bash
        yc dns zone add-access-binding <zone_ID> \
          --service-account-id <service_account_ID> \
          --role <role>
        ```

        Where:

        * `--service-account-id`: [Service account ID](../../iam/operations/sa/get-id.md).
        * `--role`: [Role](../security/index.md#roles-list) to assign.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To assign a role for a DNS zone using {{ TF }}, do the following:

  1. In the {{ TF }} configuration file, describe the resources you want to create:

      ```hcl
      resource "yandex_dns_zone_iam_binding" "zone-viewers" {
        dns_zone_id = "<zone_ID>"
        role        = "<role>"
        members     = ["<subject_type>:<subject_ID>","<subject_type>:<subject_ID>"]
      }
      ```

      Where:

      * `dns_zone_id`: DNS zone ID.
      * `role`: [Role](../security/index.md#roles-list).
      * `members`: Types and IDs of [entities](../../iam/concepts/access-control/index.md#subject) assigned the role. Use the following format: `type:<ID>`, e.g., `userAccount:<user_ID>` or `serviceAccount:<service_account_ID>`.

       For more information about `yandex_dns_zone_iam_binding` resource properties, see the [provider documentation]({{ tf-provider-resources-link }}/dns_zone_iam_binding).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all required resources. You can check the new resources using this [CLI](../../cli/) command:

      ```bash
      yc dns zone list-access-bindings <zone_ID>
      ```

- API {#api}

  To assign a role, use the [updateAccessBindings](../api-ref/DnsZone/updateAccessBindings.md) REST API method for the [DnsZone](../api-ref/DnsZone/index.md) resource or the [DnsZoneService/UpdateAccessBindings](../api-ref/grpc/DnsZone/updateAccessBindings.md) gRPC API call. In the request body, set the `action` property to `ADD` and specify the user type and ID under `subject`.

{% endlist %}

## Assigning multiple roles {#set-access}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  You can assign multiple roles using the `set-access-bindings` command.

  {% note alert %}

  The `set-access-binding` command completely rewrites access permissions for the resource! All roles previously assigned for this resource will be deleted.

  {% endnote %}

  1. Make sure the resource has no important roles assigned before proceeding:

      ```bash
      yc dns zone list-access-bindings <zone_ID>
      ```

  1. See the description of the CLI command for the DNS zone role assignment:

     ```bash
     yc dns zone set-access-bindings --help
     ```

  1. Assign roles:

     ```bash
     yc dns zone set-access-bindings <zone_ID> \
       --access-binding role=<role>,subject=<subject_type>:<subject_ID> \
       --access-binding role=<role>,subject=<subject_type>:<subject_ID>
     ```

     Where:

     * `--access-binding`: Access permission settings:

       * `role`: [Role](../security/index.md#roles-list).
       * `subject`: Type and ID of the [entity](../../iam/concepts/access-control/index.md#subject) assigned the role.

     For example, you can assign the `dns.editor` role to multiple users and a service account:

     ```bash
     yc dns zone set-access-bindings my-disk-group \
       --access-binding role=dns.editor,subject=userAccount:gfei8n54hmfh********
       --access-binding role=dns.editor,subject=serviceAccount:ajel6l0jcb9s********
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To assign multiple roles for a DNS zone using {{ TF }}:

  1. In the {{ TF }} configuration file, describe the resources you want to create:

      ```hcl
      resource "yandex_dns_zone_iam_binding" "role1" {
        dns_zone_id = "<zone_ID>"
        role        = "<role_1>"
        members     = ["<subject_type>:<subject_ID>"]
      }

      resource "yandex_dns_zone_iam_binding" "role2" {
        dns_zone_id = "<zone_ID>"
        role        = "<role_2>"
        members     = ["<subject_type>:<subject_ID>"]
      }
      ```

      Where:

      * `dns_zone_id`: DNS zone ID.
      * `role`: [Role](../security/index.md#roles-list).
      * `members`: Types and IDs of [entities](../../iam/concepts/access-control/index.md#subject) assigned the role. Use the following format: `type:<ID>`, e.g., `userAccount:<user_ID>` or `serviceAccount:<service_account_ID>`.

      For more information about `yandex_dns_zone_iam_binding` resource properties, see the [provider documentation]({{ tf-provider-resources-link }}/dns_zone_iam_binding).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      You can verify the changes using this [CLI](../../cli/) command:

      ```bash
      yc dns zone list-access-bindings <zone_ID>
      ```

- API {#api}

  To assign roles for a resource, use the [setAccessBindings](../api-ref/DnsZone/setAccessBindings.md) REST API method for the [DnsZone](../api-ref/DnsZone/index.md) resource or the [DnsZoneService/SetAccessBindings](../api-ref/grpc/DnsZone/setAccessBindings.md) gRPC API call.

  {% note alert %}

  The `setAccessBindings` method and the `DnsZoneService/SetAccessBindings` call overwrite all existing access permissions for the resource. All roles previously assigned for this resource will be deleted.

  {% endnote %}

{% endlist %}

## Revoking a role {#revoke-role}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for revoking DNS zone roles:

      ```bash
      yc dns zone add-access-binding --help
      ```

  1. Check what roles are currently assigned for the DNS zone you want to update:

      ```bash
      yc dns zone list-access-bindings <zone_ID>
      ```

  1. To revoke access permissions, run this command:

     ```bash
     yc dns zone remove-access-binding <zone_ID> \
       --role=<role> \
       --subject=<subject_type>:<subject_ID> \
     ```

     Where:

     * `--role`: ID of the role you want to revoke.
     * `--subject`: Type and ID of the target [entity](../../iam/concepts/access-control/index.md#subject) for role revocation.

     For example, run the following command to revoke the `dns.editor` role from a user with the `ajel6l0jcb9s********` ID:

     ```bash
     yc dns zone remove-access-binding my-dns-zone \
       --role dns.editor \
       --subject userAccount:ajel6l0jcb9s********
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To revoke a role assigned for a DNS zone:

  1. Open the {{ TF }} configuration file and delete the fragment describing the role:

      ```hcl
      ...
      resource "yandex_dns_zone_iam_binding" "sa-role" {
        dns_zone_id = "<zone_ID>"
        role        = "<role>"
        members     = ["<subject_type>:<subject_ID>"]
      }
      ```

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      You can verify the changes using this [CLI](../../cli/quickstart.md) command:

      ```bash
      yc dns zone list-access-bindings <zone_ID>
      ```

- API {#api}

  To revoke a role, use the [updateAccessBindings](../api-ref/DnsZone/updateAccessBindings.md) REST API method for the [DnsZone](../api-ref/DnsZone/index.md) resource or the [DnsZoneService/UpdateAccessBindings](../api-ref/grpc/DnsZone/updateAccessBindings.md) gRPC API call. In the request body, set the `action` property to `REMOVE` and specify the user type and ID under `subject`.

{% endlist %}