# OS Login

{% include notitle [preview](../../_includes/note-preview-by-request.md) %}

OS Login is a convenient tool for managing SSH connections to [VM instances](../../compute/concepts/vm.md) using {{ iam-short-name }}. Use OS Login to manage SSH access to VM instances without having to create and manage separate SSH keys.

The OS Login agent is based on the [Guest Agent for Google Compute Engine](https://github.com/GoogleCloudPlatform/guest-agent). To monitor the changes introduced by the {{ yandex-cloud }} team, see the project's repository on [GitHub](https://github.com/yandex-cloud/yandex-cloud-guest-agent).

{% note info %}

Connecting to a virtual machine with OS Login access enabled requires the user to have the `compute.osLogin` or `compute.osAdminLogin` role.

{% endnote %}

OS Login associates the VM user's account with the organization's account. To manage access to VM instances, [enable the option](../operations/os-login-access.md) to allow OS Login access at the organization level, then enable it on each VM instance individually.

This way you can easily manage access to instances by assigning roles to users. If you revoke a user's roles, they will lose access to all VM instances within the organization where OS Login access is enabled.

Benefits of OS Login:

* Instant assignment and revocation of access rights.
* Access using short-lived SSH certificates.
* No need to manage SSH keys manually.
* Restoring access to instances in case of key loss (if you opt to use regular keys instead of OS Login).
* Advanced mode for loading your own SSH keys (upcoming).

#### What's next {#what-is-next}

* [{#T}](../operations/os-login-access.md)
* [{#T}](../operations/os-login-profile-create.md)
