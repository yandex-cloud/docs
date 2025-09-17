---
title: How to delete a user SSH key
description: Follow this guide to delete a user SSH key.
---

# Deleting an SSH key

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.

      [Switch](./manage-organizations.md#switch-to-another-org) to an organization or federation of your choice as needed.

  1. In the left-hand panel, select ![icon-users](../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}**.
 
  1. In the list of users, select the one whose SSH key you want to delete.
  
      Use the filter or search as needed.

  1. Navigate to the **{{ ui-key.yacloud_org.user.title_ssh-keys }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the SSH key row and select ![image](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_org.actions.delete }}**.
  1. In the window that opens, confirm deleting the SSH key.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for uploading an SSH key to a user or service account profile:

      ```bash
      yc organization-manager oslogin user-ssh-key delete --help
      ```

  1. Get the ID of the required organization:

      ```bash
      yc organization-manager organization list
      ```

      Result:

      ```text
      +----------------------+-------------------------+-------------------------+
      |          ID          |          NAME           |          TITLE          |
      +----------------------+-------------------------+-------------------------+
      | bpf1smsil5q0******** | sample-organization-1   | My organization         |
      | bpf2c65rqcl8******** | sample-organization-new | New organization        |
      +----------------------+-------------------------+-------------------------+
      ```

  1. Get the SSH key ID by specifying the organization ID you got earlier:

      ```bash
      yc organization-manager user-ssh-key list \
        --organization-id <organization_ID>
      ```

      Result:

     ```text
     +--------------------+-----------------------+----------------------+---------------------+-------------------------------------------+---------------------+---------------------+
     |         ID         |          NAME         |   ORGANIZATION ID    |      SUBJECT ID     |                FINGERPRINT                |      CREATED AT     |      EXPIRES AT     |
     +--------------------+-----------------------+----------------------+---------------------+-------------------------------------------+---------------------+---------------------+
     | bpfh4714g6******** | ssh-key-1756108465588 | bpf2c65rqcl8******** | aje0j5m02ta******** | SHA256:fUKV93PA7HYMZ3Jk6YaVaiK9i+******** | 2025-08-25 07:55:27 |                     |
     | bpf6big3s4******** | My key5               | bpf2c65r3ghy******** | ajei2a73kl3******** | SHA256:EJQdhwWDFj4TebYQzx9CmKZHr5******** | 2024-03-12 18:48:17 | 2024-03-10 21:48:17 |
     +--------------------+-----------------------+----------------------+---------------------+-------------------------------------------+---------------------+---------------------+
     ```

  1. Delete the SSH key of the user or service account:

      ```bash
      yc organization-manager oslogin user-ssh-key delete <SSH_key_ID>
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Describe the infrastructure in the configuration file, removing the relevant SSH key:

      ```hcl
      resource "yandex_organizationmanager_user_ssh_key" "my_user_ssh_key" {
        organization_id = "<organization_ID>"
        subject_id      = "<user_ID>"
        data            = "<public_SSH_key>"
        name            = "<key_name>"
        expires_at      = "<key_expiration_date>"
      }
      ```

      Where:

      * `organization_id`: [Organization ID](./organization-get-id.md).
      * `subject_id`: ID of the [user](./users-get.md) or [service account](../../iam/operations/sa/get-id.md) whose SSH key you are deleting.
      * `data`: Contents of a public SSH key.
      * `name`: Name of the key to delete.
      * `expires_at`: Expiration date of the key to delete.

  1. Delete the resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will delete all the resources as appropriate. You can check the availability of resources in the [management console]({{ link-console-main }}) or using this [CLI](../../cli/) command:

      ```bash
      yc organization-manager user-ssh-key list \
        --organization-id <organization_ID>
      ```

- API {#api}

  Use the [delete](../../organization/api-ref/UserSshKey/delete.md) REST API method for the [UserSshKey](../../organization/api-ref/UserSshKey/index.md) resource or the [UserSshKeyService/Delete](../../organization/api-ref/grpc/UserSshKey/delete.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](../operations/add-ssh.md)
* [{#T}](../operations/os-login-access.md)
* [{#T}](../operations/os-login-profile-create.md)
* [{#T}](../../compute/operations/vm-connect/os-login.md)
