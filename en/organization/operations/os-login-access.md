---
title: "How to enable OS Login access in an organization"
description: "Follow this guide to enable OS Login access to virtual machines and {{ k8s }} cluster nodes in an organization."
---

# Enabling access via OS Login

[OS Login](../concepts/os-login.md) access allows you to connect to VMs and {{ k8s }} [cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) nodes with an SSH certificate [via the YC CLI](../../compute/operations/vm-connect/os-login.md#connect-via-cli) or a [standard SSH client](../../compute/operations/vm-connect/os-login.md#connect-via-exported-certificate), as well as via the YC CLI with an [SSH key](../../compute/operations/vm-connect/os-login.md#connect-via-key) previously added to the organization user profile in {{ org-full-name }}.

To create virtual machines or {{ k8s }} nodes with OS Login access, enable this feature at the organization level. This will allow you to [enable](../../compute/operations/vm-control/vm-update.md#enable-oslogin-access) OS Login access for VMs created from a ready-made image with OS Login support or [configure](../../compute/operations/vm-connect/enable-os-login.md) the OS Login agent on an already running VM. For more information about connecting via OS Login, see [{#T}](../../compute/operations/vm-connect/os-login.md).

{% note info %}

Images with OS Login support are available on [{{ marketplace-full-name }}](/marketplace) and have `OS Login` in their name.

{% endnote %}

To enable OS Login access at the organization level:

{% list tabs group=instructions %}

- {{ org-name }} interface {#console}

   1. [Log in]({{ link-passport-login }}) as the organization administrator or owner.
   1. Go to [{{ org-full-name }}]({{ link-org-main }}).
   1. [Switch](./manage-organizations.md#switch-to-another-org) to an organization or federation of your choice as needed.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.oslogin.title }}**.
   1. Enable the required access options:

      * **{{ ui-key.yacloud_org.form.oslogin-settings.title_ssh-certificate-settings }}**.
         The option allows you to connect to a VM or {{ k8s }} cluster node with an OS Login certificate [via the YC CLI](../../compute/operations/vm-connect/os-login.md#connect-via-cli) or a [standard SSH client](../../compute/operations/vm-connect/os-login.md#connect-via-exported-certificate).

      * **{{ ui-key.yacloud_org.form.oslogin-settings.title_user-ssh-key-settings }}**.
         The option allows you to connect to a VM or {{ k8s }} cluster node via the YC CLI with an [SSH key](../../compute/operations/vm-connect/os-login.md#connect-via-key) stored in an organization user profile.

      * **{{ ui-key.yacloud_org.form.oslogin-settings.title_allow-edit-own-keys }}**.
         The option is available if OS Login access with SSH keys is enabled.
         It allows users to [upload](./add-ssh.md) public SSH keys to their profile to connect to VMs or {{ k8s }} cluster nodes on their own.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View the description of the CLI command to enable OS Login access at the organization level:

      ```bash
      yc organization-manager oslogin update-settings --help
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

   1. Enable OS Login access for the selected organization:

      ```bash
      yc organization-manager oslogin update-settings \
        --organization-id <organization_ID> \
        --ssh-certificates-enabled \
        --ssh-user-keys-enabled \
        --allow-manage-own-keys
      ```

      Where:

      * `--organization-id`: Previously obtained organization ID.
      * `--ssh-certificates-enabled`: Access via OS Login using SSH certificates. The option allows you to connect to a VM with an OS Login certificate [via the YC CLI](../../compute/operations/vm-connect/os-login.md#connect-via-cli) or a [standard SSH client](../../compute/operations/vm-connect/os-login.md#connect-via-exported-certificate).

         To disable the option, provide the `false` value in the `--ssh-certificates-enabled=false` parameter.

      * `--ssh-user-keys-enabled`: Access via OS Login using SSH keys. The option allows you to connect to a VM via the YC CLI [with an SSH key](../../compute/operations/vm-connect/os-login.md#connect-via-key) stored in an organization user profile.

         To disable the option, provide the `false` value in the `--ssh-user-keys-enabled=false` parameter.

      * `--allow-manage-own-keys`: Allow users to upload their own SSH keys. This option allows users to [upload](./add-ssh.md) public SSH keys to their profile to connect to VMs on their own. The option is available if OS Login access with SSH keys is enabled.

         To disable the option, provide the `false` value in the `--allow-manage-own-keys=false` parameter.

      Result:

      ```bash
      user_ssh_key_settings:
        enabled: true
        allow_manage_own_keys: true
      ssh_certificate_settings:
        enabled: true
      ```

- {{ TF }} {#tf}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. In the configuration file, describe the parameters of the resources you want to create:

      ```hcl
      resource "yandex_organizationmanager_os_login_settings" "my_os_login_settings" {
        organization_id = "<organization_ID>"
        ssh_certificate_settings {
          enabled = true
        }
        user_ssh_key_settings {
          enabled               = true
          allow_manage_own_keys = true
        }
      }
      ```

      Where:

      * `organization_id`: Organization ID. You can get the organization ID using the [YC CLI](../../cli/quickstart.md) `yc organization-manager organization list` command or in the [management console]({{ link-console-main }}).

      * `ssh_certificate_settings`: Access via OS Login using SSH certificates. The option allows you to connect to a VM with an OS Login certificate [via the YC CLI](../../compute/operations/vm-connect/os-login.md#connect-via-cli) or a [standard SSH client](../../compute/operations/vm-connect/os-login.md#connect-via-exported-certificate). The `enabled` parameter may take the `true` (option enabled) and `false` (option disabled) values.

      * `user_ssh_key_settings`: Parameter block for managing access with user SSH keys.

         * `enabled`: Access via OS Login using SSH keys. The option allows you to connect to a VM via the YC CLI [with an SSH key](../../compute/operations/vm-connect/os-login.md#connect-via-key) stored in an organization user profile. It may take the `true` (option enabled) and `false` (option disabled) values.

         * `allow_manage_own_keys`: Allows users to upload their own SSH keys. This option allows users to [upload](./add-ssh.md) public SSH keys to their profile to connect to VMs on their own. The option is available if OS Login access with SSH keys is enabled. It may take the `true` (option enabled) and `false` (option disabled) values.

      For more information about resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/organizationmanager_os_login_settings).

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

      The organization settings will then be changed. To make sure the OS Login access is enabled, run the YC CLI command, specifying the organization ID:

      ```bash
      yc organization-manager oslogin get-settings --organization-id <organization_ID>
      ```

      Result:

      ```bash
      user_ssh_key_settings:
        enabled: true
        allow_manage_own_keys: true
      ssh_certificate_settings:
        enabled: true
      ```

- API {#api}

   Use the [updateSettings](../../organization/api-ref/OsLogin/updateSettings.md) REST API method for the [OsLogin](../../organization/api-ref/OsLogin/index.md) resource or the [OsLoginService/UpdateSettings](../../organization/api-ref/grpc/os_login_service.md#UpdateSettings) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](../operations/os-login-profile-create.md)
* [{#T}](../operations/add-ssh.md)
* [{#T}](../../compute/operations/vm-connect/os-login.md)
* [Connecting to a {{ k8s }} node via OS Login](../../managed-kubernetes/operations/node-connect-oslogin.md)
* [Using a service account with an OS Login profile for VM management via Ansible](../../tutorials/security/sa-oslogin-ansible.md)