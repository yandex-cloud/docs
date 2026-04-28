---
title: How to configure access permissions for a {{ certificate-manager-full-name }} certificate
description: Follow this guide to configure access permissions for a certificate.
---

# Configuring access permissions for a certificate

To grant a user, group, or [service account](../../iam/concepts/users/service-accounts.md) access to a [certificate](../concepts/index.md#types), assign a [role](../../iam/concepts/access-control/roles.md) for it.

## Assigning a role {#access-to-user}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for assigning a role for a certificate:

      ```bash
      yc certificate-manager certificate add-access-binding --help
      ```

  1. Get a list of certificates in the default [folder](../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc certificate-manager certificate list
      ```

      Result:

      ```text
      +----------------------+--------+-------------+---------------------+----------+---------+
      |          ID          |  NAME  |   DOMAINS   |      NOT AFTER      |   TYPE   | STATUS  |
      +----------------------+--------+-------------+---------------------+----------+---------+
      | fpqgbg3fajpg******** | cert-1 | example.com | 2026-01-04 13:58:14 | IMPORTED | ISSUED  |
      | fpqlhev2j4ad******** | cert-2 | example.com | 2026-01-04 14:07:02 | IMPORTED | ISSUED  |
      +----------------------+--------+-------------+---------------------+----------+---------+
      ```

  1. Check what roles are currently assigned for the DNS zone you want to update:

      ```bash
      yc certificate-manager certificate list-access-bindings <certificate_ID>
      ```

  1. To assign the role, run the following command:

      * To a user:

          ```bash
          yc certificate-manager certificate add-access-binding <certificate_ID> \
            --user-account-id <user_ID> \
            --role <role>
          ```

          Where:

          * `--user-account-id`: [User ID](../../organization/operations/users-get.md).
          * `--role`: [Role](../security/index.md#roles-list) to assign.

      * To a service account:

          ```bash
          yc certificate-manager certificate add-access-binding <certificate_ID> \
            --service-account-id <service_account_ID> \
            --role <role>
          ```

          Where:

          * `--service-account-id`: [Service account ID](../../iam/operations/sa/get-id.md).
          * `--role`: Role to assign.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To assign a role for a certificate using {{ TF }}:

  1. In the {{ TF }} configuration file, describe the resources you want to create:

      ```hcl
      resource "yandex_cm_certificate_iam_member" "mycert-roles" {
        certificate_id = "<certificate_ID>"
        role           = "<role>"
        member         = "<subject_type>:<subject_ID>"
      }
      ```

      Where:

      * `certificate_id`: Certificate ID.
      * `role`: [Role](../security/index.md#roles-list) to assign.
      * `member`: Type and ID of the [subject](../../iam/concepts/access-control/index.md#subject) the role is assigned to. Specify it as `userAccount:<user_ID>` or `serviceAccount:<service_account_ID>`.

       For more information about `yandex_cm_certificate_iam_member` resource properties, see this [provider guide]({{ tf-provider-resources-link }}/cm_certificate_iam_member).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources using this [CLI](../../cli/) command:

      ```bash
      yc certificate-manager certificate list-access-bindings <certificate_ID>
      ```

- API {#api}

  Use the [updateAccessBindings](../api-ref/Certificate/updateAccessBindings.md) REST API method for the [Certificate](../api-ref/Certificate/) resource or the [CertificateService/UpdateAccessBindings](../api-ref/grpc/Certificate/updateAccessBindings.md) gRPC API call. In the request body, set the `action` property to `ADD` and specify the user type and ID under `subject`.

{% endlist %}

## Assigning multiple roles {#multiple-roles}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  You can assign multiple roles using the `set-access-bindings` command.

  {% include [set-access-bindings](../../_includes/compute/set-access-bindings-note.md) %}

  1. View the list of roles assigned for a certificate:

      ```bash
      yc certificate-manager certificate list-access-bindings <certificate_ID>
      ```

      If you need to save the roles, specify them in the command for assigning roles.

  1. See the description of the CLI command for assigning roles for a certificate:

      ```bash
      yc certificate-manager certificate set-access-bindings --help
      ```

  1. Assign roles:

      ```bash
      yc certificate-manager certificate set-access-bindings <certificate_ID> \
        --access-binding role=<role>,subject=<subject_type>:<subject_ID>
      ```

      Where:

      * `--access-binding`: Role to assign:
          * `role`: ID of the role to assign.
          * `subject`: Type and ID of the [subject](../../iam/concepts/access-control/index.md#subject) the role is assigned to.

      For example, the following command will assign roles to multiple users and a single service account:

      ```bash
      yc certificate-manager certificate set-access-bindings my-certificate \
        --access-binding role=editor,subject=userAccount:gfei8n54hmfh********
        --access-binding role=viewer,subject=userAccount:helj89sfj80a********
        --access-binding role=editor,subject=serviceAccount:ajel6l0jcb9s********
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To assign multiple roles for a certificate using {{ TF }}:

  1. In the {{ TF }} configuration file, describe the resources you want to create:

      ```hcl
      resource "yandex_cm_certificate_iam_member" "mycert-roles1" {
        certificate_id = "<certificate_ID>"
        role           = "<role_1>"
        member         = "<subject_type>:<subject_ID>"
      }

      resource "yandex_cm_certificate_iam_member" "mycert-roles2" {
        certificate_id = "<certificate_ID>"
        role           = "<role_2>"
        member         = "<subject_type>:<subject_ID>"
      }
      ```

      Where:

      * `certificate_id`: Certificate ID.
      * `role`: [Role](../security/index.md#roles-list) to assign.
      * `member`: Type and ID of the [subject](../../iam/concepts/access-control/index.md#subject) the role is assigned to. Specify it as `userAccount:<user_ID>` or `serviceAccount:<service_account_ID>`.

       For more information about `yandex_cm_certificate_iam_member` resource properties, see this [provider guide]({{ tf-provider-resources-link }}/cm_certificate_iam_member).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources using this [CLI](../../cli/) command:

      ```bash
      yc certificate-manager certificate list-access-bindings <certificate_ID>
      ```

- API {#api}

  Use the [setAccessBindings](../api-ref/Certificate/setAccessBindings.md) REST API method for the [Certificate](../api-ref/Certificate/) resource or the [CertificateService/SetAccessBindings](../api-ref/grpc/Certificate/setAccessBindings.md) gRPC API call.

{% endlist %}

## Revoking a role {#revoke-role}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for revoking a role for a certificate:

      ```bash
      yc certificate-manager certificate remove-access-binding --help
      ```

  1. View the roles and assignees for the resource:

      ```bash
      yc certificate-manager certificate list-access-bindings <certificate_ID>
      ```

  1. To revoke access permissions, run this command:

      ```bash
      yc certificate-manager certificate remove-access-binding <certificate_ID> \
        --role <role_ID> \
        --subject <subject_type>:<subject_ID>
      ```

      Where:

      * `--role`: ID of the role you want to revoke.
      * `--subject`: [Subject](../../iam/concepts/access-control/index.md#subject) to revoke the role from.

      For example, to revoke the `{{ roles-viewer }}` role from a user with the `ajel6l0jcb9s********` ID:

      ```bash
      yc certificate-manager certificate remove-access-binding my-certificate \
        --role viewer \
        --subject userAccount:ajel6l0jcb9s********
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To revoke a role assigned for a certificate:

  1. Open the {{ TF }} configuration file and delete the fragment describing the role:

      ```hcl
      resource "yandex_cm_certificate_iam_member" "mycert-roles" {
        certificate_id = "<certificate_ID>"
        role           = "<role>"
        member         = "<subject_type>:<subject_ID>"
      }
      ```

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      You can verify the changes using this [CLI](../../cli/quickstart.md) command:
      ```bash
      yc certificate-manager certificate list-access-bindings <certificate_ID>
      ``

- API {#api}

  To revoke roles for a certificate, use the [updateAccessBindings](../api-ref/Certificate/updateAccessBindings.md) REST API method for the [Certificate](../api-ref/Certificate/) resource or the [CertificateService/UpdateAccessBindings](../api-ref/grpc/Certificate/updateAccessBindings.md) gRPC API call. In the request body, set the `action` property to `REMOVE` and specify the user type and ID under `subject`.

{% endlist %}
