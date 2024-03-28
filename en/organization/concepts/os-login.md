# OS Login

OS Login is a convenient way to manage connections to [virtual machines](../../compute/concepts/vm.md) and {{ managed-k8s-full-name }} [cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) nodes over SSH with an SSH certificate via the YC CLI or a standard SSH client, as well as via the YC CLI with an SSH key previously added to the organization user profile in {{ org-full-name }}.

The OS Login agent is based on the [Guest Agent for Google Compute Engine](https://github.com/GoogleCloudPlatform/guest-agent). To monitor the changes introduced by the {{ yandex-cloud }} team, see the project's repository on [GitHub](https://github.com/yandex-cloud/yandex-cloud-guest-agent).

{% note info %}

To connect to a virtual machine or {{ k8s }} node with OS Login access enabled, the user must have the `compute.osLogin` or `compute.osAdminLogin` role.

{% endnote %}

OS Login links the virtual machine or {{ k8s }} node user account with an organization user account. To manage access to virtual machines and nodes, [at the organization level, enable the option](../operations/os-login-access.md) allowing OS Login access, then enable it on each virtual machine or {{ k8s }} node individually.

This way you can easily manage access to virtual machines and {{ k8s }} nodes by assigning appropriate roles to users. If you revoke the roles, the user will lose access to all virtual machines and {{ k8s }} nodes where OS Login access is enabled.

Users or third-party tools, such as [{{ TF }}](https://www.terraform.io/) or [Ansible](https://www.ansible.com/), can use a standard SSH client to [connect](../../compute/operations/vm-connect/os-login.md#connect-via-exported-certificate) to a VM and {{ k8s }} nodes with OS Login access enabled using SSH certificates.

To connect through a standard SSH client using an SSH certificate to a VM or {{ k8s }} node with OS Login access enabled, you must [export](../../compute/operations/vm-connect/os-login-export-certificate.md) the OS Login certificate and use it when connecting. The certificate is valid for one hour. After this time has elapsed, you will need to export a new certificate to connect to the VM or {{ k8s }} node.

To [connect](../../compute/operations/vm-connect/os-login.md#connect-via-key) to a VM or {{ k8s }} node with OS Login access enabled through the YC CLI with an SSH key, you need to create an [SSH key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) and [add](../../organization/operations/add-ssh.md) it to the organization user profile in {{ org-name }}.

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
* [{#T}](../../managed-kubernetes/operations/node-connect-oslogin.md)
