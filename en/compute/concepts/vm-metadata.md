# VM metadata

The VM details are available in the metadata service. You can use metadata to provide any keys and values, and then request metadata from [inside](../operations/vm-info/get-info.md#inside-instance) or [outside](../operations/vm-info/get-info.md#outside-instance) a VM. For more information about setting up a metadata service, see [{#T}](../operations/vm-info/get-info.md#metadata-options).

Metadata is also used by apps that launch at VM startup.

## Metadata formats supported inside VM {#metadata-formats}

From inside a VM, metadata is available in the following formats:
* [Google Compute Engine](../operations/vm-info/get-info.md#gce-metadata) (not all fields are supported).
* [Amazon EC2](../operations/vm-info/get-info.md#ec2-metadata) (not all fields are supported).

## How to send metadata {#how-to-send-metadata}

You can provide metadata when you create or [change](../operations/vm-control/vm-update.md#change-metadata) your virtual machine. VM connection data cannot be changed, which means you need to provide it when creating a VM:
* [For a Linux VM](../operations/vm-create/create-linux-vm.md), you need to provide the public SSH key to be able to connect to it.

{% list tabs %}

- CLI

  In the CLI, you can specify metadata in three parameters:
  * `--metadata-from-file`: Provide metadata as a file, for example, `--metadata-from-file key=path/to/file`. This is convenient when providing values consisting of multiple strings.
  * `--metadata`: Provide a list of `key-value` pairs separated by commas, for example, `--metadata foo1=bar, foo2=baz`.

      If the value is multiline, use `\n` to split lines, e.g.: `--metadata user-data="#ps1\nnet user Administrator Passw0rd"`
  * `--ssh-key`: Provide an SSH key. This is only available for Linux-based virtual machines.

    {{ compute-short-name }} creates the `yc-user` user and adds the specified SSH key to the list of authorized keys. After the VM is created, you can use this key to connect to it over SSH.

  You can combine these parameters, for example:

  ```bash
  yc compute instance create \
    --name my-instance \
    --metadata-from-file user-data=metadata.yaml \
    --metadata serial-port-enable=1
  ...
  ```

- {{ TF }}

  In {{ TF }}, you can specify metadata in three ways:

  * As a separate file with user metadata to process by the `cloud-init` agent. Under `metadata`, specify the path to the file with user metadata, such as `cloud-init.yaml`:

    ```hcl
    ...
    metadata = {
      user-data = "${file("cloud-init.yaml")}"
    }
    ...
    ```

    {% cut "Sample contents of the `cloud-init.yaml` file" %}

    ```hcl
    #cloud-config
    users:
      - name: <username>
        groups: sudo
        shell: /bin/bash
        sudo: ['ALL=(ALL) NOPASSWD:ALL']
        ssh_authorized_keys:
          - <SSH_key_contents>
      ```

    {% endcut %}

  * In the `metadata` section, as a line with user metadata. If the value is multiline, use `\n` to split lines, e.g.:

    ```hcl
    ...
    metadata = {
      user-data = "#cloud-config\nusers:\n  - name: <username>\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - <SSH_key _contents>")}"
    }
    ...
    ```

  * Only for Linux-based virtual machines: Under `ssh-keys`, specify the username and the SSH key to access Linux VMs. Enter your username and the contents of your SSH key as follows:

    ```hcl
    ...
    metadata = {
      ssh-keys = "<username>:<SSH_key_contents>"
    }
    ...
    ```

    If you are using an out-of-the-box public image from {{ marketplace-name }}, the specified username does not matter. The key will be assigned to the user specified in the `cloud-init` configuration by default. Such users vary depending on an image.

    If you do not know the default user, find the string containing `Authorized keys from` in the [serial port output](../operations/vm-info/get-serial-port-output.md). It contains the name of the user assigned the authorized keys.

    If no such string is found, but you see the `no authorized ssh keys fingerprints found for user` string, it means that you did not provide your SSH key correctly. In this case, check the format or try providing the SSH keys in the `user-data` field.

- API

  In the API, specify the metadata in the `metadata` property as a JSON object, e.g.:

  ```json
  "metadata": {
    "ssh-keys": "ssh-ed25519 AAAAB3Nza... user@example.com",
    "serial-port-enable": "1"
  }
  ```

  For a line break, use `\n`.

{% endlist %}

{% note warning %}

The metadata, including the user-defined one, is available in unencrypted format. If the metadata contains sensitive information, make sure to protect it, e.g., through encryption.

{% endnote %}

## Keys processed in public images {#keys-processed-in-public-images}

The list of keys that are processed in {{ yandex-cloud }} public images depends on the operating system.

{% list tabs %}

- Linux

  * `serial-port-enable`: Flag that enables access to the serial console. `1` means it is enabled, while `0`, which is the default value, means it is disabled.
  * `user-data`: String with the user metadata to be processed by the [cloud-init](https://cloud-init.io) agent running on a virtual machine.

    Cloud-init supports different [formats](https://cloudinit.readthedocs.io/en/latest/topics/format.html) for providing metadata, such as [cloud-config](https://cloudinit.readthedocs.io/en/latest/topics/examples.html). In this format, you can provide SSH keys and indicate which user each key is associated with. To do this, specify them in the `users/ssh_authorized_keys` section:

    {% include [user-data](../../_includes/compute/user-data.md) %}

    To provide this data in the request, replace line breaks with `\n`:

    ```json
    "metadata": {
      "user-data": "#cloud-config\nusers:\n  - name: user\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ssh-ed25519 AAAAB3Nza......OjbSMRX user@example.com\n      - ssh-ed25519 AAAAB3Nza......Pu00jRN user@desktop"
    }
    ```

  * `ssh-keys`: Key for delivering the SSH key to Linux VMs through {{ TF }}. Specify it in `<username>:<SSH key content>` format, e.g., `user:ssh-ed25519 AAC4NzaC1 user@example.com`. If you specify multiple keys, only the first one will be used.

- Windows

  `user-data`: String with user metadata to be processed by the [Cloudbase-Init](https://cloudbase.it/cloudbase-init/) agent. This agent supports various [data formats](https://cloudbase-init.readthedocs.io/en/latest/userdata.html), such as PowerShell scripts that set the administrator password:

  ```json
  "metadata": {
    "user-data": "#ps1\nnet user Administrator Passw0rd"
  }
  ```

{% endlist %}