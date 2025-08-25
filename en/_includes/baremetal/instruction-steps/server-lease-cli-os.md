`--os-settings`: OS settings. To lease a server without an operating system, skip this parameter. Possible settings:

* `image-id`: ID of an available {{ marketplace-full-name }} public OS [image](../../../baremetal/concepts/images.md#marketplace-images).
* `image-name`: Name of one of the available {{ marketplace-full-name }} public OS images.
* `ssh-key-public`: Public SSH key contents. You will need to [create](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) your own SSH key pair to establish a secure server connection.
* `ssh-key-user-id`: SSH key user ID.
* `password-plain-text`: Root user's password.

  {% include [server-lease-access-password-warning](../server-lease-access-password-warning.md) %}

* `password-lockbox-secret`: {{ lockbox-full-name }} [secret](../../../lockbox/concepts/secret.md):
  * `secret-id`: Secret ID.
  * `version-id`: Secret version.
  * `key`: Secret key.