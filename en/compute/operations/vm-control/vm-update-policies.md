---
title: Maintenance policy management
description: Follow this guide to manage your maintenance policy.
---

# Maintenance policy management


To enable and configure a [VM maintenance policy](../../concepts/vm-policies.md), complete the following steps:

1. [Create a VM with a configured maintenance policy](#create).
1. [Check the maintenance event processing](#check).
1. [Connect to the VM over SSH](#ssh).
1. [Create a script to track VM maintenance events](#script).
1. [Simulate the occurrence of a VM maintenance event](#simulate).
1. [Optionally, change the VM maintenance policy type](#change-policy).

## Create a VM with a configured maintenance policy {#create}

{% list tabs group=instructions %}

- CLI {#cli}

  Create a VM with the maintenance policies:

  ```
  FOLDER_ID=$(yc config get folder-id)

  yc compute instance create --name mnt-vm1 --hostname mnt-vm1\
    --folder-id $FOLDER_ID \
    --zone {{ region-id }}-a \
    --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2204-lts \
    --cores=2 --memory=4G --core-fraction=100 \
    --network-interface subnet-name=default-{{ region-id }}-a,ipv4-address=auto,nat-ip-version=ipv4 \
    --ssh-key ~/.ssh/id_ed25519.pub \
    --maintenance-policy restart \
    --maintenance-grace-period 1m
  ```

- {{ TF }} {#tf}

  1. Create a {{ TF }} manifest named `mnt-vm.tf`:

      ```
      terraform {
        required_providers {
          yandex = {
            source  = "yandex-cloud/yandex"
            version = "~> 0.105.0"
          }
        }
      }

      variable "folder_id" {
        type = string
      }

      data "yandex_compute_image" "vm_image" {
        family = "ubuntu-2204-lts"
      }

      data "yandex_vpc_subnet" "vm_subnet" {
        folder_id = var.folder_id
        name      = "default-{{ region-id }}-a"
      }

      resource "yandex_compute_instance" "vm_instance" {
        name                     = "mnt-vm1"
        folder_id                = var.folder_id
        hostname                 = "mnt-vm1"
        zone                     = "{{ region-id }}-a"
        maintenance_policy       = "restart" # restart| migrate | unspecified
        maintenance_grace_period = "1m"

        resources {
          cores  = 2
          memory = 4
        }

        boot_disk {
          initialize_params {
            image_id = data.yandex_compute_image.vm_image.id
          }
        }

        network_interface {
          subnet_id = data.yandex_vpc_subnet.vm_subnet.id
          nat       = true
        }

        metadata = {
          ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
        }
      }
      ```

  1. Apply the {{ TF }} manifest:

      ```bash
      export YC_TOKEN=$(yc iam create-token)
      export TF_VAR_folder_id=$(yc config get folder-id)

      terraform init
      terraform apply
      ```

{% endlist %}

## Check the maintenance event processing {#check}

You can use the CLI to check the configuration of the VM maintenance policies after it has been created. Run this command:

```
yc compute instance get --name=mnt-vm1 --format=json | grep maintenance
```

Expected result:

```
  "maintenance_policy": "RESTART",
  "maintenance_grace_period": "60s"
```

## Connect to the VM via SSH {#ssh}

Get the VM IP address and save it to a variable, then connect to the VM via SSH with your username:

```
VM_IP=$(yc compute instance get --name=mnt-vm1 --format=json | jq -r '.network_interfaces[0].primary_v4_address.one_to_one_nat.address')

ssh <username>@$VM_IP
```

## Create a script to track VM maintenance events {#script}

Create a file named `mnt-pol.sh` and paste the following code into it:

```
#!/bin/bash

while true
do
  echo -n `date`" : "
  curl \
    --silent \
    --header Metadata-Flavor:Google http://metadata.google.internal/computeMetadata/v1/instance/maintenance-event
  echo
  sleep 1
done
```

Run the script:

```
chmod u+x mnt-pol.sh
./mnt-pol.sh
```

## Simulate the occurrence of a VM maintenance event {#simulate}

Simulate the occurrence of a maintenance event using the CLI. Run this command:

```
yc compute instance simulate-maintenance-event --name=mnt-vm1
```

Make sure the event is displayed in the terminal:

```
yc-user@mnt-vm1:~$ ./mnt-pol.sh
Tue Jan 16 14:14:40 UTC 2024 : NONE
Tue Jan 16 14:14:41 UTC 2024 : NONE
...
Tue Jan 16 14:23:38 UTC 2024 : NONE
Tue Jan 16 14:23:39 UTC 2024 : TERMINATE_ON_HOST_MAINTENANCE
Tue Jan 16 14:23:40 UTC 2024 : TERMINATE_ON_HOST_MAINTENANCE
Tue Jan 16 14:23:41 UTC 2024 : TERMINATE_ON_HOST_MAINTENANCE
...
Tue Jan 16 14:24:48 UTC 2024 : TERMINATE_ON_HOST_MAINTENANCE
Tue Jan 16 14:24:49 UTC 2024 : NONE
```

## Change the VM maintenance policy type {#change-policy}

You can change the VM maintenance policy type by specifying a new value for the `--maintenance-policy` parameter through the following command:

```
yc compute instance update --name=mnt-vm1 --maintenance-policy=migrate
```

Simulate the occurrence of a maintenance event using the CLI:

```
yc compute instance simulate-maintenance-event --name=mnt-vm1
```

Run the script again and make sure the policy has changed:

```
yc-user@mnt-vm1:~$ ./mnt-pol.sh
Tue Jan 16 14:32:09 UTC 2024 : NONE
Tue Jan 16 14:32:10 UTC 2024 : NONE
...
Tue Jan 16 14:32:23 UTC 2024 : MIGRATE_ON_HOST_MAINTENANCE
Tue Jan 16 14:32:24 UTC 2024 : MIGRATE_ON_HOST_MAINTENANCE
...
Tue Jan 16 14:33:23 UTC 2024 : MIGRATE_ON_HOST_MAINTENANCE
Tue Jan 16 14:33:24 UTC 2024 : MIGRATE_ON_HOST_MAINTENANCE
Tue Jan 16 14:33:25 UTC 2024 : NONE
```
