---
title: How to configure access permissions for a {{ certificate-manager-full-name }} certificate
description: Follow this guide to configure access permissions for a certificate.
---

# Configuring access to a certificate

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

  1. View a list of roles already assigned for the resource in question:

      ```bash
      yc certificate-manager certificate list-access-bindings <certificate_ID>
      ```

  1. Assign the role using this command:

      * To a user:

          ```bash
          yc certificate-manager certificate add-access-binding <certificate_ID> \
            --user-account-id <user_ID> \
            --role <role>
          ```

          Where:

          * `--user-account-id`: [User ID](../../iam/operations/users/get.md).
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
          * `subject`: Type and ID of the [subject](../../iam/concepts/access-control/index.md#subject) you are assigning the role to.

      For example, this command will assign roles to multiple users and a single service account:

      ```bash
      yc certificate-manager certificate set-access-bindings my-certificate \
        --access-binding role=editor,subject=userAccount:gfei8n54hmfh********
        --access-binding role=viewer,subject=userAccount:helj89sfj80a********
        --access-binding role=editor,subject=serviceAccount:ajel6l0jcb9s********
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

      * `--role`: ID of the role to revoke.
      * `--subject`: [Subject](../../iam/concepts/access-control/index.md#subject) to revoke the role from.

      For example, to revoke the `{{ roles-viewer }}` role from a user with the `ajel6l0jcb9s********` ID:

      ```bash
      yc certificate-manager certificate remove-access-binding my-certificate \
        --role viewer \
        --subject userAccount:ajel6l0jcb9s********
      ```

- API {#api}

  To revoke roles for a certificate, use the [updateAccessBindings](../api-ref/Certificate/updateAccessBindings.md) REST API method for the [Certificate](../api-ref/Certificate/) resource or the [CertificateService/UpdateAccessBindings](../api-ref/grpc/Certificate/updateAccessBindings.md) gRPC API call. In the request body, set the `action` property to `REMOVE` and specify the user type and ID under `subject`.

{% endlist %}
