# {{ oslogin }}

{{ oslogin }} is a convenient way to manage connections to [VMs](../../compute/concepts/vm.md) and {{ managed-k8s-full-name }} [cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) nodes via SSH through the [YC CLI](../../cli/quickstart.md) or via a standard SSH client with an SSH certificate or SSH key, which you first need to add to organization user or [service account](../../iam/concepts/users/service-accounts.md) profile in {{ org-full-name }}.

The {{ oslogin }} agent is based on the [guest agent for Google Compute Engine](https://github.com/GoogleCloudPlatform/guest-agent). To monitor the changes introduced by the {{ yandex-cloud }} team, see the project's repository on [GitHub](https://github.com/yandex-cloud/yandex-cloud-guest-agent).

{{ oslogin }} links the account of a VM or {{ k8s }} node user with the account of an organization user. To manage access to virtual machines and nodes, [enable the {{ oslogin }} access option at the organization level](../operations/os-login-access.md) and then [activate](../../compute/operations/vm-control/vm-update.md#enable-oslogin-access) {{ oslogin }} access on each virtual machine or {{ k8s }} node separately.

{% note info %}

{% include [serial-port-settings-default](../../_includes/compute/serial-port-settings-default.md) %}

{% endnote %}

This way you can easily manage access to virtual machines and {{ k8s }} nodes by assigning appropriate roles to users. If you revoke the roles, the user will lose access to all virtual machines and {{ k8s }} nodes where {{ oslogin }} access is enabled.

{% note alert %}

{% include [sudo-and-oslogin](../../_includes/compute/sudo-and-oslogin.md) %}

{% endnote %}

## {{ oslogin }} profiles {#os-login-profiles}

For each user and service account in an organization, you can create _{{ oslogin }} profiles_ containing the name (login) and ID (UID) of the user or service account, which help to identify them in the operating systems of your VMs and {{ k8s }} cluster nodes.

[Enabling](../operations/os-login-access.md) {{ oslogin }} access for an organization automatically creates _default {{ oslogin }} profiles_ for all user and service accounts in that organization. Also, you can [create](../operations/os-login-profile-create.md) additional {{ oslogin }} profiles or edit the existing ones.
  
Username (login) for an account in the default {{ oslogin }} profile depends on the account type:
* For a user account, login will be the same as the username in the organization.
* For a service account, login will be its name prefixed by `yc-sa-`, e.g., `yc-sa-my-robot` will be the login for `my-robot`.

You can manage user {{ oslogin }} profiles via the [{{ cloud-center }} interface]({{ link-org-cloud-center }}) as well as the [{{ yandex-cloud }} CLI](../../cli/cli-ref/organization-manager/cli-ref/oslogin/index.md) and [API](../api-ref/OsLogin/index.md). To manage {{ oslogin }} profiles for service accounts, you can only use the CLI or API.

{% include [os-login-profile-tab-access-notice](../../_includes/organization/os-login-profile-tab-access-notice.md) %}

## Connecting via {{ oslogin }} {#os-login-connection}

Users or third-party tools, such as [{{ TF }}](https://www.terraform.io/) or [Ansible](https://www.ansible.com/), can use a standard SSH client to [connect](../../compute/operations/vm-connect/os-login.md#connect-with-ssh-client) to a VM and {{ k8s }} nodes with enabled {{ oslogin }} access using SSH certificates or SSH keys.

To connect a VM or {{ k8s }} node with enabled {{ oslogin }} access via a standard SSH client with an SSH certificate, you need to [export](../../compute/operations/vm-connect/os-login-export-certificate.md) the {{ oslogin }} certificate and use it when connecting. The certificate is valid for one hour. After this time has elapsed, you will need to export a new certificate to connect to the VM or {{ k8s }} node.

To [connect](../../compute/operations/vm-connect/os-login.md) to a VM instance or {{ k8s }} node with enabled {{ oslogin }} access via the YC CLI or a standard SSH client with an SSH key, you need to [create an SSH key pair](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) and [add](../../organization/operations/add-ssh.md) the public SSH key to the organization user profile in {{ org-name }}. You can also add an SSH key to the [service account](../../iam/concepts/users/service-accounts.md) profile and use that service account to [connect](../tutorials/sa-oslogin-ansible.md) to a VM via {{ oslogin }}.

{% note info %}

Roles required to connect to a VM via {{ oslogin }}:

{% include [os-login-roles-needed-for-vm-access](../../_includes/organization/os-login-roles-needed-for-vm-access.md) %}

{% endnote %}

{{ oslogin }} benefits:

* Instant update of access permissions when revoking or granting roles.
* Access using short-lived SSH certificates.
* Access using SSH keys.
* Restoring access to VMs and {{ k8s }} cluster nodes if you lose your SSH keys (in case you use regular SSH keys instead of {{ oslogin }}).
* Uploading your own SSH keys to your profile.

#### What's next {#what-is-next}

* [{#T}](../operations/os-login-access.md)
* [{#T}](../operations/os-login-profile-create.md)
* [{#T}](../../compute/operations/vm-connect/os-login.md)
* [Connecting to a {{ k8s }} node via {{ oslogin }}](../../managed-kubernetes/operations/node-connect-oslogin.md)
* [Using a service account with an {{ oslogin }} profile for VM management via Ansible](../tutorials/sa-oslogin-ansible.md)