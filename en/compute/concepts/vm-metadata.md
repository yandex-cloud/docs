# VM metadata

Information about VMs is stored on the metadata server. You can request metadata from [inside](../operations/vm-info/get-info.md#inside-instance) or [outside](../operations/vm-info/get-info.md#outside-instance) a VM using the API or CLI.

Metadata is used by programs that are run when the VM starts. For example, to make a list of users or specify a public SSH key to connect to the VM.

[!INCLUDE [vm-metadata](../../_includes/vm-metadata.md)]

## Metadata format when creating a VM

Metadata is set in the `metadata` field as `key:value` pairs. Only a string can be used as a value. If you need to pass multiple strings, separate them with the line break character `\n`.

[!INCLUDE [metadata-from-file](../_includes_service/metadata-from-file.md)]

You can specify any keys. The keys you need to specify depend on the program that will handle them on your VM. For example, in Linux images provided by Yandex.Cloud, the [cloud-init](https://cloud-init.io) program is used.

> [!IMPORTANT]
> 
> Metadata, including user-defined, is stored unencrypted. Anyone who can connect to a VM can get this metadata. If you place confidential information in the metadata, take measures to protect it, for example, by encrypting it.

## Programs handling metadata in Yandex.Cloud images {#public-images-metadata}

In Linux public images, the program used to configure VMs by default is [cloud-init](https://cloud-init.io).

In Windows public images, it is [Cloudbase-Init](https://cloudbase.it/cloudbase-init/).

### Using cloud-init

The `cloud-init` program handles metadata that was passed in the keys `user-data` and `ssh-keys`.

#### user-data

All user-defined metadata for `cloud-init` should be passed in the `user-data` key. There are [several formats](https://cloudinit.readthedocs.io/en/latest/topics/format.html) of metadata supported by `cloud-init`, such as `cloud-config`.

You can use `user-data` to pass SSH keys to a VM and specify which user each key belongs to. To do this, pass them in the `users/ssh_authorized_keys` element. For more information, see the section [Users and Groups](https://cloudinit.readthedocs.io/en/latest/topics/modules.html#users-and-groups) in the `cloud-init` documentation.

Example of metadata in the `cloud-config` format:

```
#cloud-config
users:
  - name: demo
    groups: sudo
    shell: /bin/bash
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    ssh-authorized-keys:
      - ssh-rsa AAAAB3Nza......OjbSMRX user@example.com
      - ssh-rsa AAAAB3Nza......Pu00jRN user@desktop
```

#### ssh-keys

To pass SSH keys to a VM, use the `ssh-keys` field. `cloud-init` will handle only the first key in the list. The key will be assigned to the user specified in the `cloud-init` configuration by default. In different images, these users differ.

If you aren't sure which user is set by default, we recommend passing the SSH keys in the `user-data` field.

