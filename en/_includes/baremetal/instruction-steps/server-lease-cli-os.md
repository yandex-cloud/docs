`--os-settings-spec`: OS settings. To lease a server without an operating system, skip this parameter. Possible settings:

* `image-id`: ID of an available {{ marketplace-full-name }} public OS [image](../../../baremetal/concepts/images.md#marketplace-images).
* `ssh-key`: SSH key for connection to the server:

  * `ssh-public-key`: Public SSH key contents. You will need to [create](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) your own SSH key pair to establish a secure server connection.
  * `user-ssh-id`: Custom SSH key ID.
* `password`: Root user's password:

  * `password-plain-text`: Password in plain text.

    {% include [server-lease-access-password-warning](../server-lease-access-password-warning.md) %}

  * `password-lockbox-secret`: {{ lockbox-full-name }} [secret](../../../lockbox/concepts/secret.md):

    * `secret-id`: Secret ID.
    * `version-id`: Secret version.
    * `key`: Secret key.
