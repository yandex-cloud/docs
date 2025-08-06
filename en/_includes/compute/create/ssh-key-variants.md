If there are no SSH keys in your profile or you want to add a new key:

1. Click **{{ ui-key.yacloud.compute.instances.create.button_add-ssh-key }}**.
1. Enter a name for the SSH key.
1. Select one of the following:

    * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-manual }}`: Paste the contents of the public SSH key. You need to [create](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) an SSH key pair on your own.
    * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-upload }}`: Upload the public part of the SSH key. You need to create an SSH key pair on your own.
    * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-generate }}`: Automatically create an SSH key pair.
    
      {% include [where-generated-keys](./where-generated-keys.md) %}

1. Click **{{ ui-key.yacloud.common.add }}**.

{% include [ssh-add-to-org-profile](./ssh-add-to-org-profile.md) %}