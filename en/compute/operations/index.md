---
title: Working with VMs. Step-by-step guides
description: Step-by-step guides on how to use and manage VMs in {{ yandex-cloud }}. In this article, you will learn how to work with VMs, manage resources, and connect to them using SSH, RDP, and PowerShell. Find out how to use disks, images, and hosts.
---

# Step-by-step guides for {{ compute-name }}

## Creating a VM {#vm-create}

* [{#T}](vm-create/create-linux-vm.md)
* [{#T}](vm-create/create-from-disks.md)
* [{#T}](vm-create/create-from-snapshots.md)
* [{#T}](vm-create/create-from-user-image.md)
* [{#T}](vm-create/create-with-cloud-init-scripts.md)
* [{#T}](vm-create/create-with-env-variables.md)
* [{#T}](vm-create/create-vm-with-gpu.md)
* [{#T}](vm-create/create-preemptible-vm.md)

## DSVM {#dsvm}

* [{#T}](dsvm/index.md)
* [{#T}](dsvm/quickstart.md)

## Placement groups {#placement-groups}

* [{#T}](placement-groups/create.md)
* [{#T}](placement-groups/delete.md)
* [{#T}](placement-groups/create-vm-in-pg.md)
* [{#T}](placement-groups/create-ig-in-pg.md)
* [{#T}](placement-groups/add-vm.md)
* [{#T}](placement-groups/delete-vm.md)
* [{#T}](placement-groups/placement-groups-get-info.md)
* [{#T}](placement-groups/delete-ig-from-pg.md)
* [{#T}](placement-groups/access.md)

## Images with pre-installed software {#images-with-pre-installed-software}

* [{#T}](images-with-pre-installed-software/create.md)
* [{#T}](images-with-pre-installed-software/setup.md)
* [{#T}](images-with-pre-installed-software/operate.md)
* [{#T}](images-with-pre-installed-software/get-list.md)
* [{#T}](images-with-pre-installed-software/get-info.md)

## Getting information about VMs {#vm-info}

* [{#T}](vm-info/get-info.md)
* [{#T}](vm-info/get-serial-port-output.md)

## Managing VMs {#vm-control}

* [{#T}](vm-control/vm-stop-and-start.md)
* [{#T}](vm-control/vm-reset-password.md)
* [{#T}](vm-control/vm-attach-disk.md)
* [{#T}](vm-control/vm-detach-disk.md)
* [{#T}](vm-control/vm-change-zone.md)
* [{#T}](vm-control/vm-change-folder.md)
* [{#T}](vm-control/vm-change-cloud.md)
* [{#T}](vm-control/attach-network-interface.md)
* [{#T}](vm-control/detach-network-interface.md)
* [{#T}](vm-control/vm-attach-public-ip.md)
* [{#T}](vm-control/vm-detach-public-ip.md)
* [{#T}](vm-control/vm-set-static-ip.md)
* [{#T}](vm-control/vm-update.md)
* [{#T}](vm-control/vm-update-resources.md)
* [{#T}](vm-control/vm-change-security-groups-set.md)
* [{#T}](vm-control/vm-access.md)
* [{#T}](vm-control/vm-delete.md)

## Using a VM {#vm-use}

* [{#T}](vm-connect/ssh.md)
* [{#T}](vm-connect/rdp.md)
* [{#T}](vm-connect/powershell.md)
* [{#T}](vm-connect/os-login-create-vm.md)
* [{#T}](vm-connect/enable-os-login.md)
* [{#T}](vm-connect/os-login-export-certificate.md)
* [{#T}](vm-connect/os-login.md)
* [{#T}](vm-connect/auth-inside-vm.md)
* [{#T}](vm-operate/install-nvidia-drivers.md)
* [{#T}](vm-connect/recovery-access.md)

## Managing the password reset agent {#guest-agent}

* [{#T}](vm-guest-agent/check.md)
* [{#T}](vm-guest-agent/install.md)
* [{#T}](vm-guest-agent/reset-password.md)
* [{#T}](vm-guest-agent/uninstall.md)

## Creating a disk {#disk-create}

* [{#T}](disk-create/empty.md)
* [{#T}](disk-create/empty-disk-blocksize.md)
* [{#T}](disk-create/nonreplicated.md)
* [{#T}](disk-create/from-snapshot.md)
* [{#T}](disk-create/from-image.md)

## Disk management {#disk-control}

* [{#T}](disk-control/update.md)
* [{#T}](disk-control/configure-schedule.md)
* [{#T}](disk-control/disk-change-folder.md)
* [{#T}](disk-control/disk-encrypt.md)
* [{#T}](disk-control/get-info.md)
* [{#T}](disk-control/disk-access.md)
* [{#T}](disk-control/delete.md)

## Disk snapshots {#snapshots}

* [{#T}](disk-control/create-snapshot.md)
* [{#T}](snapshot-control/get-snapshot.md)
* [{#T}](snapshot-control/delete.md)
* [{#T}](snapshot-control/create-schedule.md)
* [{#T}](snapshot-control/get-snapshot-schedule.md)
* [{#T}](snapshot-control/update-schedule.md)
* [{#T}](snapshot-control/stop-and-start-schedule.md)
* [{#T}](snapshot-control/snapshot-encrypt.md)
* [{#T}](snapshot-control/snapshot-access.md)
* [{#T}](snapshot-control/snapshot-schedule-access.md)
* [{#T}](snapshot-control/delete-schedule.md)


## Disk placement groups {#placement-groups}

* [{#T}](disk-placement-groups/create.md)
* [{#T}](disk-placement-groups/add-disk.md)
* [{#T}](disk-placement-groups/get-info.md)
* [{#T}](disk-placement-groups/access.md)
* [{#T}](disk-placement-groups/remove-disk.md)


## Creating an image {#image-create}

* [{#T}](image-create/custom-image.md)
* [{#T}](image-create/upload.md)
* [{#T}](image-create/create-from-disk.md)
* [{#T}](image-create/create-from-snapshot.md)
* [{#T}](image-create/create-from-image.md)

## Managing an image {#image-control}

* [{#T}](image-control/get-list.md)
* [{#T}](image-control/image-control-get-info.md)
* [{#T}](image-control/delete.md)
* [{#T}](image-control/import.md)
* [{#T}](image-control/access.md)


## File storages {#filesystem}

* [{#T}](filesystem/create.md)
* [{#T}](filesystem/attach-to-vm.md)
* [{#T}](filesystem/detach-from-vm.md)
* [{#T}](filesystem/update.md)
* [{#T}](filesystem/get-info.md)
* [{#T}](filesystem/filesystem-access.md)
* [{#T}](filesystem/delete.md)


## Managing the serial console {#serial-console}

* [{#T}](serial-console/index.md)
* [{#T}](serial-console/connect-ssh.md)
* [{#T}](serial-console/connect-cli.md)
* [{#T}](serial-console/windows-sac.md)
* [{#T}](serial-console/disable.md)

## Creating an instance group {#ig-create}

* [{#T}](instance-groups/create-fixed-group.md)
* [{#T}](instance-groups/create-with-balancer.md)
* [{#T}](instance-groups/create-with-load-balancer.md)
* [{#T}](instance-groups/create-autoscaled-group.md)
* [{#T}](instance-groups/create-with-coi.md)
* [{#T}](instance-groups/create-from-yaml.md)
* [{#T}](placement-groups/create-ig-in-pg.md)
* [{#T}](instance-groups/create-with-fixed-ip.md)
* [{#T}](instance-groups/create-with-filesystem.md)
* [{#T}](instance-groups/create-with-bucket.md)

## Getting information about an instance group {#ig-info}

* [{#T}](instance-groups/get-list.md)
* [{#T}](instance-groups/get-info.md)
* [{#T}](instance-groups/get-list-instances.md)

## Managing instance groups {#ig-control}

* [{#T}](instance-groups/update.md)
* [{#T}](instance-groups/update-from-yaml.md)
* [{#T}](instance-groups/move-group.md)
* [{#T}](instance-groups/move-group-with-nlb.md)
* [{#T}](instance-groups/move-group-with-alb.md)
* [{#T}](instance-groups/enable-autohealing.md)
* [{#T}](instance-groups/deploy/rolling-update.md)
* [{#T}](instance-groups/deploy/zero-downtime.md)
* [{#T}](instance-groups/pause-processes.md)
* [{#T}](instance-groups/resume-processes.md)
* [{#T}](instance-groups/rolling-restart.md)
* [{#T}](instance-groups/rolling-recreate.md)
* [{#T}](instance-groups/stop.md)
* [{#T}](instance-groups/start.md)
* [{#T}](instance-groups/access.md)
* [{#T}](instance-groups/delete.md)
* [{#T}](placement-groups/delete-ig-from-pg.md)


## Dedicated hosts {#dedicated-host}

* [{#T}](dedicated-host/create-host-group.md)
* [{#T}](dedicated-host/running-host-group-vms.md)
* [{#T}](dedicated-host/running-host-vms.md)
* [{#T}](dedicated-host/access.md)

## GPU clusters {#gpu-cluster}

* [{#T}](gpu-cluster/gpu-cluster-create.md)
* [{#T}](gpu-cluster/gpu-add-to-cluster.md)
* [{#T}](gpu-cluster/gpu-cluster-update.md)
* [{#T}](gpu-cluster/gpu-cluster-delete.md)
* [{#T}](gpu-cluster/gpu-cluster-get-info.md)
* [{#T}](gpu-cluster/access.md)

