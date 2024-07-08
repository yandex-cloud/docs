---
title: "How to add a user SSH key"
description: "Follow this guide to add SSH keys to a user profile that will allow them to connect to VMs and {{ k8s }} cluster nodes with OS Login access configured."
---

# Adding an SSH key

Upload SSH keys to the organization user or service account profile in {{ org-name }} so it can connect to virtual machines and {{ managed-k8s-full-name }} cluster nodes with [OS Login](../concepts/os-login.md) access enabled.

To add an SSH key to a user profile, make sure the **{{ ui-key.yacloud_org.form.oslogin-settings.title_user-ssh-key-settings }}** option is [enabled](./os-login-access.md) at the organization level. If required, [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a new SSH key pair.

To add an SSH key to an OS Login profile:

{% list tabs group=instructions %}

- {{ org-name }} interface {#console}

   1. [Log in]({{ link-passport-login }}) as the organization administrator or owner.
   1. Go to [{{ org-full-name }}]({{ link-org-main }}).
   1. [Switch](./manage-organizations.md#switch-to-another-org) to an organization or federation of your choice as needed.
   1. In the left-hand panel, select the ![icon-users](../../_assets/console-icons/person.svg) [{{ ui-key.yacloud_org.pages.users }}]({{ link-org-users }}) section and select the required user.
   1. Go to the **SSH keys** tab and click **Add key**.
   1. In the window that opens, enter a public SSH key manually or upload it from a file.
   1. Click **{{ ui-key.yacloud.common.add }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the CLI command to upload an SSH key to the user profile:

      ```bash
      yc organization-manager oslogin user-ssh-key create --help
      ```

   1. Get the ID of the required organization:

      ```bash
      yc organization-manager organization list
      ```

      Result:

      ```bash
      +----------------------+-------------------------+-------------------------+
      |          ID          |          NAME           |          TITLE          |
      +----------------------+-------------------------+-------------------------+
      | bpf1smsil5q0******** | sample-organization-1   | My organization         |
      | bpf2c65rqcl8******** | sample-organization-new | New organization        |
      +----------------------+-------------------------+-------------------------+
      ```

   1. Get the required user ID by specifying the organization ID you obtained earlier:

      ```bash
      yc organization-manager user list \
        --organization-id <organization_ID>
      ```

      Result:

      ```bash
      +----------------------+-----------------------+---------------------------------+----------------------+
      |          ID          |       USERNAME        |              EMAIL              |    FEDERATION ID     |
      +----------------------+-----------------------+---------------------------------+----------------------+
      | aje5qd0po0nj******** | sample-user-1         | sample-user-1@yandex.ru         |                      |
      | ajee30kevjjf******** | sample-user-2         | sample-user-2@yandex.ru         |                      |
      | ajeeg4ju49h6******** | sample-user-3         | sample-user-3@yandex.ru         | bpfbl7q3mjbr******** |
      | ajei280a73vc******** | sample-user-4         | sample-user-4@yandex.ru         |                      |
      +----------------------+-----------------------+---------------------------------+----------------------+
      ```

   1. Upload the SSH key to the user profile:

      ```bash
      yc organization-manager oslogin user-ssh-key create \
        --organization-id <organization_ID> \
        --name "<key_name>" \
        --subject-id <user_or_service_account_ID> \
        --data "<public_SSH_key>" \
        --expires-at <key_expiration_date>
      ```

      Where:

      * `--organization-id`: Previously obtained organization ID.
      * `--name`: Uploaded key name.
      * `--subject-id`: Previously obtained ID of the [user](./users-get.md) or [service account](../../iam/operations/sa/get-id.md) to whose profile you are adding the SSH key.
      * `--data`: Contents of a public SSH key.
      * `--expires-at`: Uploaded key expiration date. This is an optional parameter. It allows you to set any expiration date for the uploaded key. You can specify the value in two formats:

         * Key expiration date in [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601) format, e.g., `YYYY-MM-DDT00:00:00Z`.
         * Key validity period in hours and minutes, e.g., `1h` or `3h30m`.

      Result:

      ```bash
      id: bpfrtmgobqvc********
      subject_id: ajei280a73vc********
      data: ssh-ed25519 AAAAC3Nza_YOUR_PUBLIC_SSH_KEY_Ejal+P1sRgYA3T
      name: My Key
      fingerprint: SHA256:EJQdhwWDFj4TebYQzx9CmKZHr53rNN59u0W********
      organization_id: bpf2c65rqcl8********
      created_at: "2024-03-12T17:42:31.339022059Z"
      expires_at: "2024-03-12T21:12:31.176467230Z"
      ```

- {{ TF }} {#tf}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. In the configuration file, describe the parameters of the resources you want to create:

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

      * `organization_id`: Organization ID. You can get the organization ID using the [YC CLI](../../cli/quickstart.md) `yc organization-manager organization list` command or in the [management console]({{ link-console-main }}).
      * `subject_id`: ID of the [user](./users-get.md) or [service account](../../iam/operations/sa/get-id.md) to whose profile you are adding the SSH key.
      * `data`: Contents of a public SSH key.
      * `name`: Uploaded key name.
      * `expires_at`: Uploaded key expiration date. This is an optional parameter. It allows you to set any time and date for the uploaded key, after which the key becomes invalid. The value is set in [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601) format, e.g., `YYYY-MM-DDT00:00:00Z`.

      For more information about resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/organizationmanager_user_ssh_key).

   1. Make sure the configuration files are correct.

      1. In the command line, go to the folder where you created the configuration file.
      1. Run a check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm that you want to create the resources.

      The SSH key will then be uploaded to the user profile. To make sure the SSH key is added, run the YC CLI command, specifying the organization ID:

      ```bash
      yc organization-manager oslogin user-ssh-key list --organization-id <organization_ID>
      ```

      Result:

      ```bash
      +----------------------+--------+----------------------+----------------------+----------------------------------------------------+---------------------+---------------------+
      |          ID          |  NAME  |   ORGANIZATION ID    |      SUBJECT ID      |                    FINGERPRINT                     |     CREATED AT      |     EXPIRES AT      |
      +----------------------+--------+----------------------+----------------------+----------------------------------------------------+---------------------+---------------------+
      | bpf6big3s4h0******** | My key | bpf2c65rqcl8******** | ajei280a73vc******** | SHA256:EJQdhwWDFj4TebYQzx9CmKZHr53rNN59u0W******** | 2024-03-12 18:48:17 | 2024-03-12 21:12:31 |
      +----------------------+--------+----------------------+----------------------+----------------------------------------------------+---------------------+---------------------+
      ```

- API {#api}

   Use the [create](../../organization/api-ref/UserSshKey/create.md) REST API method for the [UserSshKey](../../organization/api-ref/UserSshKey/index.md) resource or the [UserSshKeyService/Create](../../organization/api-ref/grpc/user_ssh_key_service.md#Create) gRPC API call.

{% endlist %}

You can only add an SSH key to a service account profile using the CLI, {{ TF }}, or API.

To allow users to upload SSH keys to their own profiles, [enable](./os-login-access.md) the **{{ ui-key.yacloud_org.form.oslogin-settings.title_allow-edit-own-keys }}** option.

#### See also {#see-also}

* [{#T}](../operations/os-login-access.md)
* [{#T}](../operations/os-login-profile-create.md)
* [{#T}](../../compute/operations/vm-connect/os-login.md)
* [Connecting to a {{ k8s }} node via OS Login](../../managed-kubernetes/operations/node-connect-oslogin.md)
* [Using a service account with an OS Login profile for VM management via Ansible](../../tutorials/security/sa-oslogin-ansible.md)