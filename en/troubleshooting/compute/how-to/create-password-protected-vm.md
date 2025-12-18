# How to create a VM instance with password access



## Case description {#case-description}

You need to create a VM instance with password access.

## Solution {#case-resolution}

In public Linux images provided by {{ yandex-cloud }}, SSH connections using a login and password are disabled by default. You can enable it either from within your VM instance or by using metadata when creating a VM.

Learn more about VM metadata in [this guide](../../../compute/concepts/vm-metadata.md).

{% note alert %}

Please note that connecting with a login and password is less secure than connecting with a key pair.

{% endnote %}

Example of metadata to create a `username` user with the `12345678` password:
```
#cloud-config
datasource:
 Ec2:
  strict_id: false
ssh_pwauth: yes
users:
  - name: username
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
chpasswd:
  list: |
     username:12345678
  expire: False

```
You can provide metadata when creating a VM using the CLI, API, or {{ TF }}. Example of a CLI command:
```
yc compute instance create  --name instance --zone {{ region-id }}-a \
--network-interface subnet-name=default-{{ region-id }}-a,nat-ip-version=ipv4 \
--create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2204-lts \
--metadata-from-file user-data=metadata.yaml
```