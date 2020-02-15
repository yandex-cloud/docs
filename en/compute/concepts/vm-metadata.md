# VM instance metadata

The VM instance details are available in the metadata service. You can use the metadata to pass any keys and values, and then request metadata from [inside](../operations/vm-info/get-info.md#inside-instance) or [outside](../operations/vm-info/get-info.md#outside-instance) an instance.

Metadata is also used by programs launched on VM start.

## Metadata formats supported inside VM {#metadata-formats}

From inside a VM instance, metadata is available in the following formats:

* [Google Compute Engine](../operations/vm-info/get-info.md#gce-metadata) (not all fields are supported).
* [Amazon EC2](../operations/vm-info/get-info.md#ec2-metadata) (not all fields are supported).

## How to send metadata {#how-to-pass-metadata}

You can pass metadata when you create or [change](../operations/vm-control/vm-update.md#change-metadata) your virtual machine. VM connection data can't change, so it must be passed during creation:

* [For a Linux VM](../operations/vm-create/create-linux-vm.md), you must pass the public SSH key to connect to it.
* [For a Windows VM](../operations/vm-create/create-windows-vm.md), you must pass the administrator password to connect to it.

{% list tabs %}

- CLI

  In the CLI, you can specify metadata in any of three parameters :

  * `--metadata-from-file` as a file (for example, `--metadata-from-file key=path/to/file`). This is convenient when passing values consisting of multiple strings.

  * `--metadata` with a the list of `key-value` pairs separated by commas (for example, `--metadata foo1=bar, foo2=baz`).

      If the value is multiline, use `\n` as a delimiter: `--metadata user-data="#ps1\nnet user Administrator Passw0rd"`

  * `--ssh-key` with an SSH key. Only for Linux-based virtual machines.

      {{ compute-short-name }} Create the user `yc-user` and add the specified SSH key to the list of authorized keys. After the VM is created, you can use this key to connect to it via SSH.

  You can combine these parameters, for example:

  ```
  $ yc compute instance create \
  --name my-instance \
  --metadata-from-file user-data=metadata.yaml \
  --metadata serial-port-enable=1
  ...
  ```

- API

  In the API, you specify the metadata in the `metadata` property as a JSON object, for example:

    ```json
    "metadata": {
      "ssh-keys": "ssh-rsa AAAAB3Nza... user@example.com",
      "serial-port-enable": "1"
    }
    ```

  To enter a line break in values, use the character combination `\n`.

{% endlist %}

{% note important %}

The metadata, including the user-defined metadata, is available in unencrypted format. If you place confidential information in the metadata, take measures to protect it (for example, by encrypting it).

{% endnote %}

## Keys processed in public images {#metadata-keys}

The list of keys that are processed in Yandex.Cloud's public images depends on the operating system.

{% list tabs %}

- Linux

  * `serial-port-enable`: A flag that enables access to the serial console. 1 — enable, 0 (default) — disable.

  * `user-data`: A string with the user metadata to be processed by the [cloud-init](https://cloud-init.io) agent running on a virtual machine.

      Cloud-init supports different [formats](https://cloudinit.readthedocs.io/en/latest/topics/format.html) for passing metadata, such as [cloud-config](https://cloudinit.readthedocs.io/en/latest/topics/examples.html). In this format, you can pass SSH keys and indicate which user each key is associated with. To do this, specify them in the `users/ssh_authorized_keys` element.

      {% include [user-data](../../_includes/compute/user-data.md) %}

      To pass this data in the request, replace line breaks with `\n`:

      ```json
      "metadata": {
        "user-data": "#cloud-config\nusers:\n  - name: user\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ssh-rsa AAAAB3Nza......OjbSMRX user@example.com\n      - ssh-rsa AAAAB3Nza......Pu00jRN user@desktop"
      }
      ```

  * `ssh-keys`: A key for delivering an SSH key to Linux VMs. The key is specified in the format `any name>:<SSH key content>`, for example, `user:ssh-rsa AAAAB3Nza... user@example.com`. If you specify multiple keys, only the first one is used.

      {% note important %}

      Regardless of the username specified, the key is assigned to the user given in the `cloud-init` configuration by default. In different images, these users differ.

      {% endnote %}

      If you don't know the default user, find the string containing `Authorized keys from` in the [serial port output](../operations/vm-info/get-serial-port-output.md). It contains the name of the user assigned the authorized keys.

      If no such string is found, but you see the string `no authorized ssh keys fingerprints found for user`, it means that you incorrectly passed your SSH key. Check the format again or try passing the SSH keys in the `user-data` field.

- Windows

  `user-data`: A string with user metadata to be processed by the [Cloudbase-Init](https://cloudbase.it/cloudbase-init/) agent. This agent supports various [data formats](https://cloudbase-init.readthedocs.io/en/latest/userdata.html), such as PowerShell scripts that set the administrator password:

  ```json
  "metadata": {
    "user-data": "#ps1\nnet user Administrator Passw0rd"
  }
  ```

{% endlist %}

