# How to create a VM with password access



## Scenario description {#case-description}

You need to create a VM instance with password access.

## Solution {#case-resolution}

In the public Linux images provided by Yandex Cloud, the option to connect via SSH using a login and password is disabled by default. You can enable it either from within your VM or when creating a VM based on metadata.

For more about VM metadata, see the [documentation](../../../compute/concepts/vm-metadata).

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
You can deliver metadata when creating a VM using the CLI, API, or Terraform. Example of a CLI command:
```
yc compute instance create  --name instance --zone ru-central1-a \
--network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
--create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2204-lts \
--metadata-from-file user-data=metadata.yaml
```
