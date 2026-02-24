### OS Login is used for connection to a VM or Kubernetes node {#vm}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | low | access.os-login-onto-hosts.vm ||
|#

#### Description

{% note tip "**Automatic verification**" %}

This control automatically checks for OS Login usage on virtual machines and Kubernetes nodes.

{% endnote %}

[OS Login](https://yandex.cloud/en/docs/organization/concepts/os-login) is a convenient way to manage connections to [VMs](https://yandex.cloud/en/docs/compute/concepts/vm) over SSH via the [CLI](https://yandex.cloud/en/docs/cli/quickstart) or a standard SSH client with an SSH certificate or SSH key, which you first need to add to the OS Login profile of organization user or [service account](https://yandex.cloud/en/docs/iam/concepts/users/service-accounts) in Yandex Identity Hub.

OS Login links the account of a virtual machine user with that of an organization or service account user. To manage access to virtual machines, [enable](https://yandex.cloud/en/docs/organization/operations/os-login-access) the OS Login access option at the organization level and then [activate](https://yandex.cloud/en/docs/compute/operations/vm-connect/enable-os-login) OS Login access on each virtual machine separately.

Thus, you can easily manage access to virtual machines by assigning appropriate roles to users or service accounts. If you revoke the roles from a user or service account, they will lose access to all virtual machines with OS Login access enabled.

#### Guides and solutions

Guides and solutions to use:

* [Enabling OS Login access at the organization level](https://yandex.cloud/en/docs/organization/operations/os-login-access)
* [Setting up OS Login access on an existing VM](https://yandex.cloud/en/docs/compute/operations/vm-connect/enable-os-login)
* [Connect to the virtual machine via OS Login](https://yandex.cloud/en/docs/compute/operations/vm-connect/os-login)