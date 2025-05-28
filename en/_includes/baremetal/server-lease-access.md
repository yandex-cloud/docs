1. In the **{{ ui-key.yacloud.baremetal.field_password }}** field, use one of these options to create a password for the root user:

    * To generate a password for the root users, select `{{ ui-key.yacloud.baremetal.label_password-plain }}` and click **{{ ui-key.yacloud.component.password-input.label_button-generate }}**.

        {% note warning %}

        This option assumes that the user is responsible for password security. Save the password in a safe place. {{ yandex-cloud }} does not store this password, and you will not be able to view it once you lease the server.

        {% endnote %}

    * To use the root user password saved in a {{ lockbox-full-name }} [secret](../../lockbox/concepts/secret.md), select `{{ ui-key.yacloud.baremetal.label_password-lockbox }}`.

        In the **{{ ui-key.yacloud.baremetal.label_lockbox-name }}**, **{{ ui-key.yacloud.baremetal.label_lockbox-version }}**, and **{{ ui-key.yacloud.baremetal.label_lockbox-key }}** fields, select the secret, its version, and the key your password is saved in, respectively.
        
        If you do not have a {{ lockbox-name }} secret, click **{{ ui-key.yacloud.common.create }}** to create it.

        This option allows you either to set your own password (the `{{ ui-key.yacloud.lockbox.forms.title_secret-type-custom }}` secret type) or to use an automatically generated one (the `{{ ui-key.yacloud.lockbox.forms.title_secret-type-generated }}` secret type).

1. In the **{{ ui-key.yacloud.baremetal.field_ssh-public-key }}** field, select the SSH key saved in your [organization user](../../organization/concepts/membership.md) profile.

    If there are no SSH keys in your profile or you want to add a new key:
    * Click **{{ ui-key.yacloud.compute.instances.create.button_add-ssh-key }}**.
    * Enter a name for the SSH key.
    * Upload or paste the contents of the public key file. You will need to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair for the SSH connection to a server yourself.
    * Click **{{ ui-key.yacloud.common.add }}**.

    The SSH key will be added to your organization user profile.

    If adding SSH keys by users to their profiles is disabled in the organization, the public SSH key you add will be saved only to the OS user profile of the new {{ baremetal-name }} server.