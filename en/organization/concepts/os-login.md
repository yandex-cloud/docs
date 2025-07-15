# {{ oslogin }}

{{ oslogin }} facilitates SSH connections to _virtual machines_ in {{ yandex-cloud }}. Here and below, virtual machines (or VMs) will refer both to actual [{{ compute-full-name }} VMs](../../compute/concepts/vm.md#project) and [individual nodes in node groups](../../managed-kubernetes/concepts/index.md#node-group) within [{{ managed-k8s-full-name }} clusters](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) used to run user containers.

With {{ oslogin }}, you can manage SSH access to VMs relying solely on the [{{ iam-full-name }} mechanisms](../../iam/concepts/index.md). There is no need to upload SSH keys to each new VM when it is created. {{ oslogin }} links the VM user account to a {{ org-full-name }} account, i.e., an [organization user](../../organization/concepts/membership.md) account or [service account](../../iam/concepts/users/service-accounts.md).

{{ oslogin }} benefits:

* Instant update of user [access permissions](../../iam/concepts/access-control/roles.md) within a VM when revoking or assigning roles. If you revoke the roles, the user will lose access to all VMs with {{ oslogin }} access enabled.
* Multiple available options to access VMs: you can use both short-lived SSH certificates and SSH keys including those added to the organization user profile.

## {{ oslogin }} structure {#structure}

{{ oslogin }} includes the following elements: [{{ oslogin }} agent](#agent), organization-level {{ oslogin }} [operation mode settings](#modes), as well as [{{ oslogin }} profiles](#os-login-profiles) and [SSH keys](#ssh-keys) of users and service accounts in the organization.

### {{ oslogin }} agent {#agent}

The _{{ oslogin }} agent_ is based on the [guest agent for Google Compute Engine](https://github.com/GoogleCloudPlatform/guest-agent). To monitor the changes introduced by the {{ yandex-cloud }} team, see the [project's repository on GitHub](https://github.com/yandex-cloud/yandex-cloud-guest-agent).

The {{ oslogin }} agent is integrated into [a number of Linux images]({{ link-cloud-marketplace }}?search=oslogin) available when creating a VM.

### {{ oslogin }} operating mode settings at the {{ org-full-name }} level {#modes}

{{ oslogin }} supports the following _operation modes_ used both individually and in combination:

* **Mode 1**: {{ ui-key.yacloud_org.form.oslogin-settings.title_ssh-certificate-settings }}.
    This mode allows you to connect to a VM with an SSH certificate [through the {{ yandex-cloud }} CLI](../../compute/operations/vm-connect/os-login.md#connect-with-yc-cli) or a [standard SSH client](../../compute/operations/vm-connect/os-login.md#connect-with-ssh-client).

* **Mode 2**: {{ ui-key.yacloud_org.form.oslogin-settings.title_user-ssh-key-settings }}.
    Allows you to connect to a VM through the {{ yandex-cloud }} CLI or a standard SSH client using an SSH key stored in the [{{ oslogin }} profile](../concepts/os-login.md#os-login-profiles) of a user or [service account](../../iam/concepts/users/service-accounts.md).

### {{ oslogin }} profiles for users and service accounts {#os-login-profiles}

_{{ oslogin }} profile_ defines the parameters to apply when creating a user account within a VM.

[Enabling](../operations/os-login-access.md) {{ oslogin }} access for an organization automatically creates _default {{ oslogin }} profiles_ for all user and service accounts in that organization.
  
The username (login) an account gets in the {{ oslogin }} profile by default depends on the account type:
* A user account's login is derived from the user's name in the organization. Any characters except Latin letters, numbers, hyphens, and underscores, as well as a hyphen prepending the name are ignored. Uppercase Latin letters are converted to lowercase.
* For a service account, the login will be its name prefixed by `yc-sa-`, e.g., `yc-sa-my-robot` will be the default login for `my-robot`.

A single user or service account in a {{ org-name }} can have multiple {{ oslogin }} profiles: different profiles allow you to connect to VMs as different local users of those VMs. To learn more about creating additional {{ oslogin }} profiles, see [{#T}](../operations/os-login-profile-create.md).

You can manage user {{ oslogin }} profiles via the [{{ cloud-center }} interface]({{ link-org-cloud-center }}) as well as the [{{ yandex-cloud }} CLI](../../cli/cli-ref/organization-manager/cli-ref/oslogin/index.md) and [API](../api-ref/OsLogin/index.md). {{ oslogin }} profiles of service accounts can be managed only via the {{ yandex-cloud }} CLI or API.

{% include [os-login-profile-tab-access-notice](../../_includes/organization/os-login-profile-tab-access-notice.md) %}

### SSH keys of users and service accounts {#ssh-keys}

The [organization administrator](../security/index.md#organization-manager-admin) can enable [Mode 2](#modes) to allow the use of public SSH keys for users and service accounts to connect to VMs via {{ oslogin }}. With this mode on, the administrator will have to load the public SSH keys of users and service accounts into their [{{ oslogin }} profiles](#os-login-profiles).

An organization administrator can also allow users to manage their public SSH keys themselves by additionally [enabling](../operations/os-login-access.md) the **{{ ui-key.yacloud_org.form.oslogin-settings.title_allow-edit-own-keys }}** option in the organization's security settings.

### {{ oslogin }} prerequisites {#pre-conditions}

{% note info %}

{{ oslogin }} works only with Linux-based VMs. VMs with other OS types, including Windows, are not supported.

{% endnote %}

To start [connecting](#os-login-connection) to a VM via {{ oslogin }}, make sure to do the following:

* [Enable {{ oslogin }} access](../operations/os-login-access.md) to the VM at the organization level.
* [Deploy the VM](../../compute/operations/vm-connect/os-login-create-vm.md) from an [image]({{ link-cloud-marketplace }}?search=oslogin) with an integrated [{{ oslogin }} agent](#agent).
    If the VM is created from an image without an integrated {{ oslogin }} agent, you can [install the agent](../../compute/operations/vm-connect/enable-os-login.md#enable-os-login) yourself.
* When creating a VM, select **{{ ui-key.yacloud.compute.instance.access-method.field_os-login-access-method }}** under **{{ ui-key.yacloud.compute.instances.create.section_access }}** in the management console. If this option is disabled, the selected image does not support {{ oslogin }} access.

{% note info %}

{% include [serial-port-settings-default](../../_includes/compute/serial-port-settings-default.md) %}

{% endnote %}

## Connecting via {{ oslogin }} {#os-login-connection}

To connect to a VM with {{ oslogin }} access enabled, you can use either a standard SSH client or the [{{ yandex-cloud }} CLI](../../cli/quickstart.md).

### Connecting with a standard SSH client {#connect-with-ssh-client}

Users or, if acting under service accounts, third-party tools, such as [{{ TF }}](https://www.terraform.io/) or [Ansible](https://www.ansible.com/), can use a standard SSH client to [connect](../../compute/operations/vm-connect/os-login.md#connect-with-ssh-client) to a VM with enabled {{ oslogin }} access using a short-lived SSH certificate or SSH key [saved](../../organization/operations/add-ssh.md) in the {{ oslogin }} profile of that user or service account.

To connect to a VM via a standard SSH client with an SSH certificate, you need to [export](../../compute/operations/vm-connect/os-login-export-certificate.md) the certificate and use it when connecting.

{% cut "Example of connecting using a short-lived SSH certificate" %}

```bash
# 1. Getting the `my-oslogin-vm` VM public IP address and organization ID
PUB_IP=$(yc compute instance get my-oslogin-vm \
  --format=json | jq -r '.network_interfaces[0].primary_v4_address.one_to_one_nat.address')
ORG_ID=$(yc organization-manager organization list --format=json | jq -r '.[0].id')

# 2. Getting a short-lived SSH certificate
yc compute ssh certificate export --organization-id $ORG_ID --directory ~/Downloads/cert

# 3. Connecting to a VM using its public IP address
ssh -i ~/Downloads/cert/yc-organization-id-bpfdp4pdeg8d********-username username@$PUB_IP
```

In our example:

1. With the `yc compute instance get` and `yc organization-manager organization list` commands, we get the `my-oslogin-vm` public IP address and the current organization ID and save them in variables.
1. With the `yc compute ssh certificate export` command, we export the user's short-lived SSH certificate to the `~/Downloads/cert` directory.
1. With the received SSH certificate, we connect to the VM using the previously saved public IP address.

{% endcut %}

The certificate is valid for one hour. After this time has elapsed, you will need to export a new certificate to connect to the VM.

### Connecting via the {{ yandex-cloud }} CLI {#connect-with-yc-cli}

You can connect to a VM with enabled {{ oslogin }} access using the {{ yandex-cloud }} CLI with either an SSH key [saved](../../organization/operations/add-ssh.md) in the {{ oslogin }} profile of a user or service account or an SSH certificate of that user or service account.

To learn more about connecting to VMs via {{ oslogin }}, see [{#T}](../../compute/operations/vm-connect/os-login.md#connect-with-yc-cli) and [Connecting to a {{ k8s }} node via {{ oslogin }}](../../managed-kubernetes/operations/node-connect-oslogin.md#connect-via-cli).

### Roles required to connect to a VM via {{ oslogin }} {#necessary-roles}

{% include [os-login-roles-needed-for-vm-access](../../_includes/organization/os-login-roles-needed-for-vm-access.md) %}

{% note alert %}

{% include [sudo-and-oslogin](../../_includes/compute/sudo-and-oslogin.md) %}

{% endnote %}

## Use cases {#examples}

* [{#T}](../tutorials/sa-oslogin-ansible.md)
* [{#T}](../../tutorials/security/user-group-access-control.md)

#### See also {#see-also}

* [{#T}](../operations/os-login-access.md)
* [{#T}](../operations/os-login-profile-create.md)
* [Using a service account with an {{ oslogin }} profile for VM management via Ansible](../tutorials/sa-oslogin-ansible.md)
