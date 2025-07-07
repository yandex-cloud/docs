1. In the **{{ ui-key.yacloud.baremetal.field_password }}** field, select one of the following options to create a root password:

    * To generate a new root password, select `{{ ui-key.yacloud.baremetal.label_password-plain }}` and click **{{ ui-key.yacloud.component.password-input.label_button-generate }}**.

        {% note warning %}

        This option requires you to maintain password security. Save the password you generated in a secure location. {{ yandex-cloud }} does not store it, and you will not be able to retrieve it once the server is deployed.

        {% endnote %}

    * To use the root password saved in a {{ lockbox-full-name }} [secret](../../lockbox/concepts/secret.md), select `{{ ui-key.yacloud.baremetal.label_password-lockbox }}`.

        In the **{{ ui-key.yacloud.baremetal.label_lockbox-name }}**, **{{ ui-key.yacloud.baremetal.label_lockbox-version }}**, and **{{ ui-key.yacloud.baremetal.label_lockbox-key }}** fields, select the secret containing your password, its version, and its key, respectively.
        
        If you do not have a {{ lockbox-name }} secret, click **{{ ui-key.yacloud.common.create }}** to create it.

        Choose the `{{ ui-key.yacloud.lockbox.forms.title_secret-type-custom }}` secret type to specify a custom password or `{{ ui-key.yacloud.lockbox.forms.title_secret-type-generated }}` to generate password automatically.

1. In the **{{ ui-key.yacloud.baremetal.field_ssh-public-key }}** field, select the SSH key saved in your [organization user](../../organization/concepts/membership.md) profile.

    If your profile has no SSH keys or you need to add a new one:
    * Click **{{ ui-key.yacloud.compute.instances.create.button_add-ssh-key }}**.
    * Specify the SSH key name.
    * Upload your public key file or paste its contents in the field below. You will need to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) your own SSH key pair to establish a secure server connection.
    * Click **{{ ui-key.yacloud.common.add }}**.

    The system will add the SSH key to your organization user profile.

    If, due to restrictions, you cannot add SSH keys to your organization profile, the system will save the new public SSH key to your {{ baremetal-name }} server’s user profile.