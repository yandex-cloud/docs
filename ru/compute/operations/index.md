---
title: "Как работать с виртуальными машинами. Пошаговые инструкции"
description: "Пошаговые инструкции по работе и управлению виртуальными машинами в Yandex.Cloud. Из статьи вы узнаете, как работать с виртуальными машинами, управлять ресурсами, подключаться к ним с помощью SSH, RDP и PowerShell. Подробно рассказываем о работе с дисками, образами и хостами."

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---


# Пошаговые инструкции

## Создание виртуальной машины {#vm-create}

* [{#T}](vm-create/create-linux-vm.md)
* [{#T}](vm-create/create-windows-vm.md)
* [{#T}](vm-create/create-from-disks.md)
* [{#T}](vm-create/create-from-snapshots.md)
* [{#T}](vm-create/create-from-user-image.md)
* [{#T}](vm-create/create-preemptible-vm.md)
* [{#T}](vm-create/create-vm-with-gpu.md)

## DSVM {#dsvm}

* [{#T}](dsvm/index.md)
* [{#T}](dsvm/quickstart.md)

## Группы размещения {#placement-groups}

* [{#T}](placement-groups/create.md)
* [{#T}](placement-groups/delete.md)
* [{#T}](placement-groups/create-vm-in-pg.md)
* [{#T}](placement-groups/add-vm.md)
* [{#T}](placement-groups/delete-vm.md)

## Образы с предустановленным программным обеспечением {#images-with-pre-installed-software}

* [{#T}](images-with-pre-installed-software/create.md)
* [{#T}](images-with-pre-installed-software/setup.md)
* [{#T}](images-with-pre-installed-software/operate.md)
* [{#T}](images-with-pre-installed-software/get-list.md)

## Получение информации о виртуальных машинах {#vm-info}

* [{#T}](vm-info/get-info.md)
* [{#T}](vm-info/get-serial-port-output.md)

## Управление виртуальной машиной {#vm-control}

* [{#T}](vm-control/vm-stop-and-start.md)
* [{#T}](vm-control/vm-attach-disk.md)
* [{#T}](vm-control/vm-detach-disk.md)
* [{#T}](vm-control/vm-change-zone.md)
* [{#T}](vm-control/vm-set-static-ip.md)
* [{#T}](vm-control/vm-update.md)
* [{#T}](vm-control/vm-update-resources.md)
* [{#T}](vm-control/vm-delete.md)

## Работа на виртуальной машине {#vm-use}

* [{#T}](vm-connect/ssh.md)
* [{#T}](vm-connect/rdp.md)
* [{#T}](vm-connect/powershell.md)
* [{#T}](vm-connect/auth-inside-vm.md)
* [{#T}](vm-operate/install-nvidia-drivers.md)
* [{#T}](vm-connect/recovery-access.md)

## Создание нового диска {#disk-create}

* [{#T}](disk-create/empty.md)
* [{#T}](disk-create/empty-disk-blocksize.md)

## Управление диском {#disk-control}

* [{#T}](disk-control/create-snapshot.md)
* [{#T}](disk-control/update.md)
* [{#T}](disk-control/delete.md)
* [{#T}](snapshot-control/delete.md)

## Группы размещения дисков {#placement-groups}

* [{#T}](disk-placement-groups/create.md)
* [{#T}](disk-placement-groups/remove-disk.md)

## Создание нового образа {#image-create}

* [{#T}](image-create/custom-image.md)
* [{#T}](image-create/upload.md)

## Управление образом {#image-control}

* [{#T}](image-control/delete.md)

## Управление серийной консолью {#serial-console}

* [{#T}](serial-console/index.md)
* [{#T}](serial-console/connect-ssh.md)
* [{#T}](serial-console/connect-cli.md)
* [{#T}](serial-console/windows-sac.md)
* [{#T}](serial-console/disable.md)

## Создание группы виртуальных машин {#ig-create}

* [{#T}](instance-groups/create-fixed-group.md)
* [{#T}](instance-groups/create-with-balancer.md)
* [{#T}](instance-groups/create-autoscaled-group.md)
* [{#T}](instance-groups/create-with-coi.md)

## Получение информации о группе виртуальных машин {#ig-info}

* [{#T}](instance-groups/get-list.md)
* [{#T}](instance-groups/get-info.md)
* [{#T}](instance-groups/get-list-instances.md)

## Управление группой виртуальных машин {#ig-control}

* [{#T}](instance-groups/update.md)
* [{#T}](instance-groups/enable-autohealing.md)
* [{#T}](instance-groups/deploy/rolling-update.md)
* [{#T}](instance-groups/deploy/zero-downtime.md)
* [{#T}](instance-groups/stop.md)
* [{#T}](instance-groups/start.md)
* [{#T}](instance-groups/delete.md)

## Выделенные хосты {#dedicated-host}

* [{#T}](dedicated-host/running-host-group-vms.md)
* [{#T}](dedicated-host/running-host-vms.md)