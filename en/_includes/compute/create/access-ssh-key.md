In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, select the SSH key saved in your [organization user](../../../organization/concepts/membership.md) profile.

If there are no saved SSH keys in your profile, or you want to add a new key:
* Click **{{ ui-key.yacloud.compute.instances.create.button_add-ssh-key }}**.
* Enter a name for the SSH key.
* Upload or paste the contents of the public key file. You need to [create](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair for the SSH connection to a VM yourself.
* Click **{{ ui-key.yacloud.common.add }}**.

The SSH key will be added to your organization user profile.

If users cannot add SSH keys to their profiles in the organization, the added public SSH key will only be saved to the user profile of the VM being created.