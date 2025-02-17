Under **{{ ui-key.yacloud.baremetal.title_server-access }}**:

1. Next to the **{{ ui-key.yacloud.baremetal.field_password }}** field, click **Generate** to generate a password for the root user.  

    {% note warning %}

    Save the password in a safe place. {{ yandex-cloud }} does not store this password, and you will not be able to view it once you lease the server.

    {% endnote %}

1. In the **{{ ui-key.yacloud.baremetal.field_ssh-public-key }}** field, select the SSH key saved in your [organization user](../../organization/concepts/membership.md) profile.

    If there are no saved SSH keys in your profile, or you want to add a new key:
    * Click **{{ ui-key.yacloud.compute.instances.create.button_add-ssh-key }}**.
    * Enter a name for the SSH key.
    * Upload or paste the contents of the public key file. You need to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair for the SSH connection to a server yourself.
    * Click **{{ ui-key.yacloud.common.add }}**.

    The SSH key will be added to your organization user profile.

    If adding SSH keys by users to their profiles is disabled in the organization, the public SSH key will be saved only to the new {{ baremetal-name }} server's user profile.