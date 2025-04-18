---
title: 'Keys processed in public images {{ yandex-cloud }} '
description: In this article, you will learn which keys are processed by the metadata service in public VM instance images in {{ yandex-cloud }}.
---

# Keys processed in public images {{ yandex-cloud }}

The list of keys processed by the [metadata service](../vm-metadata.md) in {{ yandex-cloud }} [public images](../image.md) depends on the image OS:

{% list tabs group=operating_system %}

- Linux {#linux}

  * `serial-port-enable`: Key responsible for access to [serial console](../../operations/serial-console/index.md) of the VM instance: The possible values are:
      * `0`: Access to serial console disabled. Default value.
      * `1`: Access to serial console enabled.
  * `enable-oslogin`: Key responsible for access to the VM instance via [{{ oslogin }}](../../operations/vm-connect/os-login.md). The possible values are:
      * `false`: Access via {{ oslogin }} disabled. Default value.
      * `true`: Access via {{ oslogin }} enabled.
  * `user-data`: Key containing a string with the user metadata that will be processed by the [cloud-init](https://cloudinit.readthedocs.io/en/latest/index.html) agent running on the VM instance.

      Cloud-init supports different metadata transmission [formats](https://cloudinit.readthedocs.io/en/latest/topics/format.html), e.g., [cloud-config](https://cloudinit.readthedocs.io/en/latest/topics/examples.html). In this format, you can provide SSH keys and indicate which user each key is associated with. To do this, specify them in the `users/ssh_authorized_keys` section:

      {% include [user-data](../../../_includes/compute/user-data.md) %}

      To provide this data in the request, replace line breaks with `\n`:

      ```json
      "metadata": {
        "user-data": "#cloud-config\nusers:\n  - name: user\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ssh-ed25519 AAAAB3Nza......OjbSMRX user@example.com\n      - ssh-ed25519 AAAAB3Nza...Pu00jRN"
      }
      ```

      In the `user-data` key, you may also describe the [software installation scripts](../../operations/vm-create/create-with-cloud-init-scripts.md#examples) you want executed when creating a new VM instance and [provide](../../operations/vm-create/create-with-lockbox-secret.md) to the VM instance the [{{ lockbox-full-name }} secrets](../../../lockbox/concepts/secret.md) and variables whose values you can later [get](../metadata/accessing-metadata.md#internal-access) from within the VM instance.

  * `ssh-keys`: Key responsible for delivering a public SSH key to the Linux VM instance via {{ TF }}. Use this format: `<username>:<SSH_key_contents>`, e.g., `user:ssh-ed25519 AAAAB3Nza...Pu00jRN`. If you specify multiple keys, only the first one will be used.

- Windows {#windows}

  `user-data`: Key containing a string with user metadata to be processed by the [Cloudbase-Init](https://cloudbase.it/cloudbase-init/) agent. This agent supports various [data formats](https://cloudbase-init.readthedocs.io/en/latest/userdata.html), such as PowerShell scripts that set the administrator password:

  ```json
  "metadata": {
    "user-data": "#ps1\nnet user Administrator Passw0rd"
  }
  ```

{% endlist %}

## Use cases {#examples}

* [{#T}](../../tutorials/rds-gw.md)
* [{#T}](../../tutorials/coi-with-terraform.md)
* [{#T}](../../../tutorials/archive/vm-with-backup-policy/index.md)
* [{#T}](../../../tutorials/routing/multi-folder-vpc.md)
* [{#T}](../../../tutorials/infrastructure-management/run-docker-on-vm/index.md)

#### See also {#see-also}

* [{#T}](../vm-metadata.md)
* [{#T}](./directories.md)
* [{#T}](./sending-metadata.md)
* [{#T}](./accessing-metadata.md)
* [{#T}](./identity-document.md)