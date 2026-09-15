### OS Login is used for connection to a VM {#vm}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | low | access.os-login-onto-hosts.vm ||
|#

#### Description

**How this rule works:** The rule automatically checks whether OS Login is enabled on virtual machines. It flags VMs where OS Login is not configured, meaning access is managed through manually distributed SSH keys rather than through IAM-linked identities. The rule does not verify whether the VMs are actively used or whether existing SSH keys have been audited.

[OS Login](https://yandex.cloud/en/docs/organization/concepts/os-login) is a convenient way to manage connections to [VMs](https://yandex.cloud/en/docs/compute/concepts/vm) over SSH via the [CLI](https://yandex.cloud/en/docs/cli/quickstart) or a standard SSH client with an SSH certificate or SSH key, which you first need to add to the OS Login profile of organization user or [service account](https://yandex.cloud/en/docs/iam/concepts/users/service-accounts) in Yandex Identity Hub.

OS Login links the account of a virtual machine user with that of an organization or service account user. To manage access to virtual machines, [enable](https://yandex.cloud/en/docs/organization/operations/os-login-access) the OS Login access option at the organization level and then [activate](https://yandex.cloud/en/docs/compute/operations/vm-connect/enable-os-login) OS Login access on each virtual machine separately.

Thus, you can easily manage access to virtual machines by assigning appropriate roles to users or service accounts. If you revoke the roles from a user or service account, they will lose access to all virtual machines with OS Login access enabled.

**Risks if the rule is not followed:** Without OS Login, VM access is managed through manually distributed SSH keys that are not tied to IAM identities. When an employee leaves or a key is compromised, there is no centralized way to revoke access — each key must be manually removed from every VM. Unmanaged SSH keys can persist indefinitely, giving former employees or attackers continued access to virtual machines.

#### Instructions and solutions

* [Enabling OS Login access at the organization level](https://yandex.cloud/en/docs/organization/operations/os-login-access).
* [Setting up OS Login access on an existing VM](https://yandex.cloud/en/docs/compute/operations/vm-connect/enable-os-login).
* [Connect to the virtual machine via OS Login](https://yandex.cloud/en/docs/compute/operations/vm-connect/os-login).
