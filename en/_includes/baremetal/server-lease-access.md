Under **{{ ui-key.yacloud.baremetal.title_server-access }}**:

1. Next to the **{{ ui-key.yacloud.baremetal.field_password }}** field, click **Generate** to generate a password for the root user.  

    {% note warning %}

    Save the password in a safe place. {{ yandex-cloud }} does not store this password, and you will not be able to view it once you lease the server.

    {% endnote %}

1. In the **{{ ui-key.yacloud.baremetal.field_ssh-public-key }}** field, paste the contents of the public key file. You need to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) an SSH key pair yourself.