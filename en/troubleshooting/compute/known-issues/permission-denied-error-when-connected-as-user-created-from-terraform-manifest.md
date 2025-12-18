# Resolving the `Permission denied` error when connecting to a VM created with {{ TF }}


## Issue description {#issue-description}

Trying to connect to a VM over SSH after creating that VM using {{ TF }} returns the `Permission denied` error.

## Solution {#issue-resolution}

If you provide a key within `ssh-keys`, the text specified in the SSH key comment will not be processed. As a result, the key will be assigned to the user set as default in the `cloud-init` configuration for this image. 

{% note info %}

Such a username might vary across VM images. For more information on this, see [this article](../../../compute/concepts/vm-metadata.md#keys-processed-in-public-images).

{% endnote %}

If you need to add a user with a specific name when creating your VM, provide the user metadata file as a `cloud-init`-compatible YAML, adding the metadata file path to the {{ TF }} manifest:

1. Create a UTF-8-encoded text file with the following contents:

    ```
    #cloud-config
    users:
      - name: <username>
        groups: sudo
        shell: /bin/bash
        sudo: 'ALL=(ALL) NOPASSWD:ALL'
        ssh_authorized_keys:
          - ssh-ed25519 AAAAB3Nza......OjbSMRX user@example.com
          - ssh-ed25519 AAAAB3Nza......Pu00jRN user@desktop
    ```

1. In the `metadata` section inside your {{ TF }} manifest, specify the following:

    ```
    metadata = {
        user-data = "${file("<file_path>")}"
    }
    ```

You can look up the details about the user and the key [in the serial port output](../../../compute/operations/vm-info/get-serial-port-output.md) for the created VM. If the SSH key is valid, the output should include the following:

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

The serial output containing this data is available after the VM is created and until it restarts for the first time.

{% endnote %}
