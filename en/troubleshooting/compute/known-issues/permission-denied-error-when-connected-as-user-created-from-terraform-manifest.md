# You see a «Permission denied» error when connecting to a VM created in Terraform

## Issue description {#issue-description}

You see a `"Permission denied"` error when trying to establish an SSH connection to a VM created in Terraform.

## Solution {#issue-resolution}

If you pass a key in the `ssh-keys` option, the text specified in the SSH key's comment will not be processed.
As a result, the key will be assigned to the user set as default in the cloud-init configuration for this image.

{% note info %}

Such a username might vary between VM images. For more information, see the [documentation article](../../../compute/concepts/vm-metadata.md#keys-processed-in-public-images).

{% endnote %}

If you need to add a user with a specific name when creating your VM, pass the metadata file in a cloud-init-compatible YAML format, adding the metadata file path to the Terraform's manifest:

1. Create a UTF-8 encoded text file with the following contents:

    ```
    #cloud-config
    users:
      - name: <user name>
        groups: sudo
        shell: /bin/bash
        sudo: 'ALL=(ALL) NOPASSWD:ALL'
        ssh_authorized_keys:
          - ssh-ed25519 AAAAB3Nza......OjbSMRX user@example.com
          - ssh-ed25519 AAAAB3Nza......Pu00jRN user@desktop
    ```

2. Add the following text to the `metadata` section in your Terraform manifest:

    ```
    metadata = {
        user-data = "${file("<file_path>")}"
    }
    ```

You can look up details about the user and the key [in the serial port output](../../../compute/operations/vm-info/get-serial-port-output.md) for the created VM. If the SSH key is valid, the output should include:

```
ci-info: ++++++++++++++++++++++++++++++++++++++Authorized keys from /home/test/.ssh/authorized_keys for user ubuntu++++++++++++++++++++++++++++++++++++
ci-info: +---------+-------------------------------------------------------------------------------------------------+---------+----------------------+
ci-info: | Keytype |                                       Fingerprint (sha256)                                      | Options |       Comment        |
ci-info: +---------+-------------------------------------------------------------------------------------------------+---------+----------------------+
ci-info: | ssh-rsa | 7f:fa:ab:5c:b5:67:6b:4a:65:1e:65:bb:93:13:0b:0b:d2:06:52:63:bf:ed:c6:16:4d:55:b6:fb:c5:a2:30:f0 |    -    | some_text            |
ci-info: +---------+-------------------------------------------------------------------------------------------------+---------+----------------------+
```

Where `ubuntu` is the username, and `ssh-rsa` is the SSH key fingerprint.

{% note alert %}

The serial output containing this data is available after the VM is created and until it restarts for the first time.

{% endnote %}