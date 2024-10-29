# OS Login

OS Login provides a convenient way to manage SSH connections to [virtual machines](../../compute/concepts/vm.md) and {{ managed-k8s-full-name }} [cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) nodes using the [YC CLI](../../cli/quickstart.md) or a standard SSH client with an SSH certificate or an SSH key, which you first need to add to the organization user or [service account](../../iam/concepts/users/service-accounts.md) profile in {{ org-full-name }}.

The OS Login agent is based on the [Guest Agent for Google Compute Engine](https://github.com/GoogleCloudPlatform/guest-agent). To monitor the changes introduced by the {{ yandex-cloud }} team, see the project's repository on [GitHub](https://github.com/yandex-cloud/yandex-cloud-guest-agent).

{% note info %}

Required roles:

{% include [os-login-roles-needed-for-vm-access](../../_includes/organization/os-login-roles-needed-for-vm-access.md) %}

{% endnote %}

OS Login links the virtual machine or {{ k8s }} node user account with an organization user account. To manage access to virtual machines and nodes, [at the organization level, enable the option](../operations/os-login-access.md) allowing OS Login access, then enable it on each virtual machine or {{ k8s }} node individually.

This way you can easily manage access to virtual machines and {{ k8s }} nodes by assigning appropriate roles to users. If you revoke the roles, the user will lose access to all virtual machines and {{ k8s }} nodes where OS Login access is enabled.

Users or third-party tools, such as [{{ TF }}](https://www.terraform.io/) or [Ansible](https://www.ansible.com/), can use a standard SSH client to [connect](../../compute/operations/vm-connect/os-login.md#connect-with-ssh-client) to a VM and {{ k8s }} nodes with OS Login access enabled using SSH certificates or SSH keys.

To connect through a standard SSH client using an SSH certificate to a VM or {{ k8s }} node with OS Login access enabled, you must [export](../../compute/operations/vm-connect/os-login-export-certificate.md) the OS Login certificate and use it when connecting. The certificate is valid for one hour. After this time has elapsed, you will need to export a new certificate to connect to the VM or {{ k8s }} node.

To [connect](../../compute/operations/vm-connect/os-login.md) to a VM or {{ k8s }} node with OS Login access enabled using the YC CLI or a standard SSH client with an SSH key, you need to [create an SSH key pair](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) and [add](../../organization/operations/add-ssh.md) the public SSH key to the OS Login profile of an organization user in {{ org-name }}. You can also add an SSH key to the OS Login profile of a [service account](../../iam/concepts/users/service-accounts.md) and use that service account to [connect](../tutorials/sa-oslogin-ansible.md) to a VM via OS Login.

OS Login has the following benefits:

* Instant update of access rights when revoking or granting roles.
* Access using short-lived SSH certificates.
* Access using SSH keys.
* Restoring access to VMs and {{ k8s }} cluster nodes if you lose your SSH keys (in case you use regular SSH keys instead of OS Login).
* Uploading your own SSH keys to your profile.

#### What's next {#what-is-next}

* [{#T}](../operations/os-login-access.md)
* [{#T}](../operations/os-login-profile-create.md)
* [{#T}](../../compute/operations/vm-connect/os-login.md)
* [Connecting to a {{ k8s }} node via OS Login](../../managed-kubernetes/operations/node-connect-oslogin.md)
* [Using a service account with an OS Login profile for VM management via Ansible](../tutorials/sa-oslogin-ansible.md)