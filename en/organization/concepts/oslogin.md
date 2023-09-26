# OS Login

{% include notitle [preview](../../_includes/note-preview-by-request.md) %}

OS Login allows you to easily manage [VM](../../compute/concepts/vm.md) connections through SSH using IAM. Use OS Login to manage access to virtual machines without having to create and manage SSH keys for each user.

The OS Login agent is based on the [guest agent for Google Compute Engine](https://github.com/GoogleCloudPlatform/guest-agent). You can track the changes made by the {{ yandex-cloud }} team on [GitHub](https://github.com/yandex-cloud/yandex-cloud-guest-agent).

{% note info %}

To access VMs that have the OS Login option enabled, one must have either the `compute.osLogin` or the `compute.osAdminLogin` role.

{% endnote %}

OS Login links an account on a virtual machine with one of an organization member. To manage access to virtual machines, enable logging in through OS Login on the organization level, and then activate it on each required virtual machine separately.

This way, you can easily manage access by assigning the appropriate roles to users. If you revoke a user's roles, they will lose access to all virtual machines in the organization with the OS Login option enabled.

OS Login advantages:

* Instant access binding updates in case the appropriate roles have been correctly revoked or assigned.
* Access via short-lived SSH certificates.
* No need to manage SSH keys on your own.
* You can restore access to VMs in case of SSH key loss (if you use regular SSH keys instead of OS Login).
* For advanced users: You can upload your own SSH keys (coming soon).
