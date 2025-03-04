---
title: How to enable {{ oslogin }} access in an organization
description: Follow this guide to enable {{ oslogin }} access to virtual machines and {{ k8s }} cluster nodes in an organization.
---

# Enabling access via {{ oslogin }}

{% note info %}

{% include [serial-port-settings-default](../../_includes/compute/serial-port-settings-default.md) %}

{% endnote %}

With [{{ oslogin }}](../concepts/os-login.md), you can manage SSH access to [VMs](../../compute/concepts/vm.md#project) and [individual nodes in node groups](../../managed-kubernetes/concepts/index.md#node-group) within [{{ managed-k8s-full-name }} clusters](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) relying solely on the [{{ iam-full-name }}](../../iam/concepts/index.md) mechanisms. There is no need to upload SSH keys to each new VM or {{ k8s }} node when one is created. {{ oslogin }} links the VM or {{ k8s }} node user account to a {{ org-full-name }} account, i.e., an [organization user](../../organization/concepts/membership.md) account or [service account](../../iam/concepts/users/service-accounts.md).

{% note alert %}

{% include [sudo-and-oslogin](../../_includes/compute/sudo-and-oslogin.md) %}

{% endnote %}

To create virtual machines or {{ k8s }} nodes with {{ oslogin }} access, enable this feature at the organization level. To do this:

{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.

      [Switch](./manage-organizations.md#switch-to-another-org) to an organization or federation of your choice as needed.

  1. In the left-hand panel, select ![shield](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.oslogin.title }}**.

  1. Enable the required operating modes:

      * **{{ ui-key.yacloud_org.form.oslogin-settings.title_ssh-certificate-settings }}**.
          This mode allows you to connect to a VM or {{ k8s }} cluster node with an SSH certificate [through the {{ yandex-cloud }} CLI](../../compute/operations/vm-connect/os-login.md#connect-with-yc-cli) or a [standard SSH client](../../compute/operations/vm-connect/os-login.md#connect-with-ssh-client).

      * **{{ ui-key.yacloud_org.form.oslogin-settings.title_user-ssh-key-settings }}**.
          This mode allows you to connect to a VM or {{ k8s }} cluster node through the {{ yandex-cloud }} CLI or a standard SSH client using an SSH key stored in the [{{ oslogin }} profile](../concepts/os-login.md#os-login-profiles) of a user or [service account](../../iam/concepts/users/service-accounts.md).

      * **{{ ui-key.yacloud_org.form.oslogin-settings.title_allow-edit-own-keys }}**.
          Allows users themselves to upload public SSH keys to their {{ oslogin }} profiles for connection to VMs or {{ k8s }} cluster nodes.

          You can add a new SSH key to your profile in the management console when creating a VM or by following the guide titled [Adding an SSH key](./add-ssh.md).

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to enable {{ oslogin }} access at the organization level:

      ```bash
      yc organization-manager oslogin update-settings --help
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

  1. Enable access via {{ oslogin }} for the selected organization:

      ```bash
      yc organization-manager oslogin update-settings \
        --organization-id <organization_ID> \
        --ssh-certificates-enabled \
        --ssh-user-keys-enabled \
        --allow-manage-own-keys
      ```

      Where:

      * `--organization-id`: Organization ID you got earlier.
      * `--ssh-certificates-enabled`: {{ oslogin }} access using SSH certificates. This option allows you to connect to VMs or {{ k8s }} cluster nodes with an SSH certificate [through the {{ yandex-cloud }} CLI](../../compute/operations/vm-connect/os-login.md#connect-with-yc-cli) or a [standard SSH client](../../compute/operations/vm-connect/os-login.md#connect-with-ssh-client).

          To disable this option, provide the `false` value in the `--ssh-certificates-enabled=false` parameter.

      * `--ssh-user-keys-enabled`: {{ oslogin }} access using SSH keys. This option allows you to connect to VMs or {{ k8s }} cluster nodes via the {{ yandex-cloud }} CLI or a standard SSH client, using an SSH key stored in the {{ oslogin }} profile of an organization user or service account.

          To disable this option, provide the `false` value in the `--ssh-user-keys-enabled=false` parameter.

      * `--allow-manage-own-keys`: Allow users to upload their own SSH keys. This option allows users themselves to upload public SSH keys to their {{ oslogin }} profiles for connection to VMs and {{ k8s }} cluster nodes. To upload your own SSH keys, follow [this guide](./add-ssh.md).

          To disable this option, provide the `false` value in the `--allow-manage-own-keys=false` parameter.

      Result:

      ```text
      user_ssh_key_settings:
        enabled: true
        allow_manage_own_keys: true
      ssh_certificate_settings:
        enabled: true
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. In the configuration file, define the parameters of the resources you want to create:

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

      * `organization_id`: Organization ID. You can get the organization ID using the `yc organization-manager organization list` command in the [{{ yandex-cloud }} CLI](../../cli/quickstart.md) or through the [{{ cloud-center }} interface]({{ cloud-center-link }}).

      * `ssh_certificate_settings`: {{ oslogin }} access using SSH certificates. This option allows you to connect to VMs or {{ k8s }} cluster nodes with an SSH certificate [through the {{ yandex-cloud }} CLI](../../compute/operations/vm-connect/os-login.md#connect-with-yc-cli) or a [standard SSH client](../../compute/operations/vm-connect/os-login.md#connect-with-ssh-client). The `enabled` parameter may take either the `true` (option enabled) or `false` (option disabled) values.

      * `user_ssh_key_settings`: Section for managing access through user SSH keys.

          * `enabled`: {{ oslogin }} access using SSH keys. This option allows you to connect to VMs or {{ k8s }} cluster nodes via the {{ yandex-cloud }} CLI or an SSH key stored in the profile of an organization user. It may take either the `true` (option enabled) or `false` (option disabled) values.

          * `allow_manage_own_keys`: Allow users to upload their own SSH keys. This option allows users themselves to upload public SSH keys to their {{ oslogin }} profiles for connection to VMs and {{ k8s }} cluster nodes. To upload your own SSH keys, follow [this guide](./add-ssh.md). It may take either the `true` (option enabled) or `false` (option disabled) values.

      For more information about the resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/organizationmanager_os_login_settings).

  1. Make sure the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

          ```bash
          terraform plan
          ```

      If you described the configuration correctly, the terminal will display a list of the resources being created and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

  1. Deploy the cloud resources.

      1. If the configuration does not contain any errors, run this command:

          ```bash
          terraform apply
          ```

      1. Confirm creating the resources.

      The organization settings will then be changed. To make sure {{ oslogin }} access is enabled, run this {{ yandex-cloud }} CLI command by specifying the organization ID:

      ```bash
      yc organization-manager oslogin get-settings --organization-id <organization_ID>
      ```

      Result:

      ```text
      user_ssh_key_settings:
        enabled: true
        allow_manage_own_keys: true
      ssh_certificate_settings:
        enabled: true
      ```

- API {#api}

  Use the [updateSettings](../../organization/api-ref/OsLogin/updateSettings.md) REST API method for the [OsLogin](../../organization/api-ref/OsLogin/index.md) resource or the [OsLoginService/UpdateSettings](../../organization/api-ref/grpc/OsLogin/updateSettings.md) gRPC API call.

{% endlist %}

{% include [os-login-profile-tab-access-notice](../../_includes/organization/os-login-profile-tab-access-notice.md) %}

#### See also {#see-also}

* [{#T}](../operations/os-login-profile-create.md)
* [{#T}](../operations/add-ssh.md)
* [{#T}](../../compute/operations/vm-connect/os-login.md)
* [Connecting to a {{ k8s }} node via {{ oslogin }}](../../managed-kubernetes/operations/node-connect-oslogin.md)
* [Using a service account with an {{ oslogin }} profile for VM management via Ansible](../tutorials/sa-oslogin-ansible.md)