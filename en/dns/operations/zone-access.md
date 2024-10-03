---
title: Configuring access permissions for a DNS zone in {{ dns-name }}
description: Follow this guide to configure DNS zone access permissions.
---

# Configuring DNS zone access permissions

To grant a user, group, or [service account](../../iam/concepts/users/service-accounts.md) access to a [DNS zone](../concepts/dns-zone.md), assign a [role](../../iam/concepts/access-control/roles.md) for it.

## Assigning a role {#add-access}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View the CLI command description for assigning a role for a DNS zone:

      ```bash
      yc dns zone add-access-binding --help
      ```

  1. Get a list of DNS zones in the default [folder](../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc dns zone list
      ```

  1. View the list of roles already assigned for the resource:

      ```bash
      yc dns zone list-access-bindings <zone_ID>
      ```

  1. Assign the role using the command:

      * To a user:

        ```bash
        yc dns zone add-access-binding <zone_ID> \
          --user-account-id <user_ID> \
          --role <role>
        ```

        Where:

        * `--user-account-id`: [User ID](../../iam/operations/users/get.md). To assign a role to all authenticated users, use the `--all-authenticated-users` flag.
        * `--role`: [Role](../security/index.md#roles-list) to assign.

      * To a service account:

        ```bash
        yc dns zone add-access-binding <zone_ID> \
          --service-account-id <service_account_ID> \
          --role <role>
        ```

        Where:

        * `--service-account-id` is the [service account ID](../../iam/operations/sa/get-id.md).
        * `--role`: [Role](../security/index.md#roles-list) to assign.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To assign a role for a DNS zone using {{ TF }}:

  1. In the {{ TF }} configuration file, describe the parameters of the resources you want to create:

      ```hcl
      resource "yandex_dns_zone_iam_binding" "zone-viewers" {
        dns_zone_id = "<zone_ID>"
        role        = "<role>"
        members     = ["<subject_type>:<subject_ID>","<subject_type>:<subject_ID>"]
      }
      ```

      Where:

      * `dns_zone_id`: DNS zone ID.
      * `role`: [Role](../security/index.md#roles-list) to assign.
      * `members`: List of types and IDs of [subjects](../../iam/concepts/access-control/index.md#subject) the roles are assigned to. Specify it as `userAccount:<user_ID>` or `serviceAccount:<service_account_ID>`.

      For more information about the `yandex_dns_zone_iam_binding` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/dns_zone_iam_binding).

  1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources using this [CLI](../../cli/) command:

      ```bash
      yc dns zone list-access-bindings <zone_ID>
      ```

- API {#api}

  To assign a role, use the [updateAccessBindings](../api-ref/DnsZone/updateAccessBindings.md) REST API method for the [DnsZone](../api-ref/DnsZone/index.md) resource or the [DnsZoneService/UpdateAccessBindings](../api-ref/grpc/dns_zone_service.md#UpdateAccessBindings) gRPC API call. In the request body, set the `action` property to `ADD` and specify the user type and ID in the `subject` property.

{% endlist %}

## Assigning multiple roles {#set-access}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  You can assign multiple roles using the `set-access-bindings` command.

  {% note alert %}

  The `set-access-binding` method completely rewrites access permissions for the resource! All current resource roles will be deleted.

  {% endnote %}

  1. Make sure the resource has no roles assigned that you would not want to lose:

      ```bash
      yc dns zone list-access-bindings <zone_ID>
      ```

  1. View the CLI command description for assigning roles for a DNS zone:

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

     * `--access-binding`: Parameters for setting access permissions:

       * `role`: [Role](../security/index.md#roles-list) to assign.
       * `subject`: Type and ID of the [subject](../../iam/concepts/access-control/index.md#subject) getting the role.

     For example, assign the `dns.editor` roles to multiple users and a service account:

     ```bash
     yc dns zone set-access-bindings my-disk-group \
       --access-binding role=dns.editor,subject=userAccount:gfei8n54hmfh********
       --access-binding role=dns.editor,subject=serviceAccount:ajel6l0jcb9s********
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To assign multiple roles for a DNS zone using {{ TF }}:

  1. In the {{ TF }} configuration file, describe the parameters of the resources you want to create:

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
      * `role`: [Role](../security/index.md#roles-list) to assign.
      * `members`: List of types and IDs of [subjects](../../iam/concepts/access-control/index.md#subject) the roles are assigned to. Specify it as `userAccount:<user_ID>` or `serviceAccount:<service_account_ID>`.

      For more information about the `yandex_dns_zone_iam_binding` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/dns_zone_iam_binding).

  1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      You can check the changes using this [CLI](../../cli/) command:

      ```bash
      yc dns zone list-access-bindings <zone_ID>
      ```

- API {#api}

  To assign roles for a resource, use the [setAccessBindings](../api-ref/DnsZone/setAccessBindings.md) REST API method for the [DnsZone](../api-ref/DnsZone/index.md) resource or the [DnsZoneService/SetAccessBindings](../api-ref/grpc/dns_zone_service.md#SetAccessBindings) gRPC API call.

  {% note alert %}

  The `setAccessBindings` method and the `DnsZoneService/SetAccessBindings` call completely rewrite the resource access permissions. All current resource roles will be deleted.

  {% endnote %}

{% endlist %}

## Revoking a role {#revoke-role}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View the CLI command description for revoking a role for a DNS zone:

      ```bash
      yc dns zone add-access-binding --help
      ```

  1. View the list of roles already assigned for the resource:

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

     * `--role`: ID of the role to revoke.
     * `--subject`: Type and ID of the [subject](../../iam/concepts/access-control/index.md#subject) to revoke the role from.

     For example, to revoke the `dns.editor` role for a DNS zone from a user with the `ajel6l0jcb9s********` ID:

     ```bash
     yc dns zone remove-access-binding my-dns-zone \
       --role dns.editor \
       --subject userAccount:ajel6l0jcb9s********
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To revoke a role assigned for a DNS zone using {{ TF }}:

  1. Open the {{ TF }} configuration file and delete the fragment with the role description.

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

      You can check the changes using this [CLI](../../cli/quickstart.md) command:

      ```bash
      yc dns zone list-access-bindings <zone_ID>
      ```

- API {#api}

  To revoke a role, use the [updateAccessBindings](../api-ref/DnsZone/updateAccessBindings.md) REST API method for the [DnsZone](../api-ref/DnsZone/index.md) resource or the [DnsZoneService/UpdateAccessBindings](../api-ref/grpc/dns_zone_service.md#UpdateAccessBindings) gRPC API call. In the request body, set the `action` property to `REMOVE` and specify the user type and ID in the `subject` property.

{% endlist %}