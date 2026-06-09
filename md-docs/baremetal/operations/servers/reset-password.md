# Сбросить пароль root-пользователя на сервере

Пароль root-пользователя генерируется при [аренде](server-lease.md) сервера {{ baremetal-name }}. Пользователь должен самостоятельно сохранить этот пароль, так как после запуска сервера посмотреть или восстановить его будет невозможно.

Если вы потеряли пароль root-пользователя сервера {{ baremetal-name }}, вы можете создать новый пароль. В зависимости от ситуации, вы можете сделать это несколькими способами.

{% note tip %}

Чтобы в KVM-консоли вставить текст из буфера обмена, воспользуйтесь полем **Paste text here** в правом верхнем углу.

{% endnote %}

{% list tabs %}

- Если сохранился доступ к серверу по SSH-ключу

  Если у вас сохранилась возможность подключаться к серверу от имени root-пользователя с помощью SSH-ключа, указанного при аренде сервера, вы можете изменить пароль root-пользователя, не прибегая к Rescue-CD:

  1. Подключитесь к серверу по SSH:

      ```bash
      ssh root@<публичный_IP-адрес_сервера>
      ```
  1. Чтобы изменить пароль root-пользователя операционной системы сервера {{ baremetal-name }}, выполните команду:
     
     ```bash
     passwd root
     ```
     
     и по запросу системы введите и подтвердите новый пароль:
     
     ```bash
     New password:
     Retype new password:
     ```
     
     Результат:
     
     ```text
     passwd: password updated successfully
     ```
     
     {% note info %}
     
     На этом этапе вы также можете [добавить](add-new-ssh-key.md) новый SSH-ключ пользователя для доступа на сервер или изменить любые другие настройки операционной системы сервера, которые могут препятствовать корректной загрузке или подключению к нему, а также провести необходимые работы по диагностике и исправлению ошибок.
     
     {% endnote %}

- Если нет доступа к серверу

  Если у вас нет возможности подключиться к серверу с помощью SSH-ключа, указанного при аренде сервера, восстановите пароль root-пользователя при помощи загрузочного CD-образа Rescue-CD. Дальнейшие действия необходимо выполнять в [KVM-консоли](server-kvm.md).

  Чтобы изменить пароль root-пользователя или другие настройки сервера {{ baremetal-name }}:

  1. [Запустите](rescue-boot.md#boot-up) сервер с CD-образа Rescue-CD.
     
     В основном меню SystemRescue выберите опцию **Boot SystemRescue using default options**, нажмите **ENTER** и дождитесь загрузки операционной системы SystemRescue.
  1. Посмотрите информацию об устройствах хранения (дисках и созданных на них разделах) сервера:
     
     ```bash
     fdisk -l
     ```
     
     Результат:
     
     ```text
     Disk /dev/sda: 838.36 GiB, 900185481216 bytes, 1758174768 sectors
     Disk model: SAMSUNG MZ7GE900
     Units: sectors of 1 * 512 = 512 bytes
     Sector size (logical/physical): 512 bytes / 512 bytes
     I/0 size (minimum/optimal): 512 bytes / 512 bytes
     Disklabel type: gpt
     Disk identifier: D79F5407-DEEC-4A1D-983F-3AC5********
     
     Device      Start      End         Sectors      Size  Type
     /dev/sda1   2048       614399      612352       299M  BIOS boot
     /dev/sda2   614400     21585919    20971520     10G   Linux filesystem
     /dev/sda3   21585920   34168831    12582912     6G    Linux filesystem
     /dev/sda4   34168832   1732861951  1698693120   810G  Linux filesystem
     
     
     Disk /dev/sdb: 838.36 GiB, 900185481216 bytes, 1758174768 sectors
     Disk model: SAMSUNG MZ7GE900
     Units: sectors of 1 * 512 = 512 bytes
     Sector size (logical/physical): 512 bytes / 512 bytes
     I/0 size (minimum/optimal): 512 bytes / 512 bytes
     Disklabel type: gpt
     Disk identifier: CDZACB4C-1618-4BAF-A6BB-D2B9********
     
     Device      Start      End         Sectors      Size  Type
     /dev/sdb1   2048       614399      612352       299M  BIOS boot
     /dev/sdb2   614400     21585919    20971520     10G   Linux filesystem
     /dev/sdb3   21585920   34168831    12582912     6G    Linux filesystem
     /dev/sdb4   34168832   1732861951  1698693120   810G  Linux filesystem
     
     Disk /dev/md127: 6 GiB, 6438256640 bytes, 12574720 sectors
     Units: sectors of 1 * 512 = 512 bytes
     Sector size (logical/physical): 512 bytes / 512 bytes
     I/0 size (minimum/optimal): 512 bytes / 512 bytes
     
     Disk /dev/md126: 9.99 GiB, 10729029632 bytes, 20955136 sectors = 512 bytes
     Units: sectors of 1 * 512 = 512 bytes
     Sector size (logical/physical): 512 bytes / 512 bytes
     I/0 size (minimum/optimal): 512 bytes / 512 bytes
     
     Disk /dev/md125: 809.88 GiB, 869596659712 bytes, 1698430976 sectors
     Units: sectors of 1 * 512 = 512 bytes
     Sector size (logical/physical): 512 bytes / 512 bytes
     I/0 size (minimum/optimal): 512 bytes / 512 bytes
     
     Disk /dev/loop: 824.97 MiB, 865046528 bytes, 1689544 sectors
     Units: sectors of 1 * 512 = 512 bytes
     Sector size (logical/physical): 512 bytes / 512 bytes
     I/O size (minimum/optimal): 512 bytes / 512 bytes
     ```
     
     В примере выше утилита `fdisk` вывела информацию о физических дисках (`/dev/sda` и `/dev/sdb`) и их разделах, а также о разделах в созданном на сервере RAID-массиве (`/dev/md127`, `/dev/md126` и `/dev/md125`).
     
     Диски `/dev/sda` и `/dev/sdb` используются в RAID-массиве, корневая файловая система ОС сервера расположена в разделе `/dev/md125` размером `809.88 GiB`. Этот раздел и необходимо смонтировать.
  1. Смонтируйте раздел с корневой файловой системой ОС сервера {{ baremetal-name }}:
     
     ```bash
     mount /dev/md125 /mnt
     ```
  1. Создайте новую среду оболочки ОС SystemRescue с окружением в смонтированной ранее файловой системе ОС сервера {{ baremetal-name }}:
     
     ```bash
     chroot /mnt /bin/bash
     ```
  1. Чтобы изменить пароль root-пользователя операционной системы сервера {{ baremetal-name }}, выполните команду:
     
     ```bash
     passwd root
     ```
     
     и по запросу системы введите и подтвердите новый пароль:
     
     ```bash
     New password:
     Retype new password:
     ```
     
     Результат:
     
     ```text
     passwd: password updated successfully
     ```
     
     {% note info %}
     
     На этом этапе вы также можете [добавить](add-new-ssh-key.md) новый SSH-ключ пользователя для доступа на сервер или изменить любые другие настройки операционной системы сервера, которые могут препятствовать корректной загрузке или подключению к нему, а также провести необходимые работы по диагностике и исправлению ошибок.
     
     {% endnote %}
  1. Выполнив все необходимые действия в файловой системе сервера, выйдите из созданного окружения:
     
     ```bash
     exit
     ```
  1. Отмонтируйте файловую систему сервера {{ baremetal-name }}:
     
     ```bash
     umount /dev/md125 /mnt
     ```
     
     Результат:
     
     ```text
     umount: /mnt: not mounted.
     ```
  1. Отключите виртуальный CD-дисковод в KVM-консоли:
     
     1. В окне KVM-консоли в верхнем меню выберите **Media** → **Virtual Media Wizard...** или нажмите на значок с изображением CD-диска.
     1. В открывшемся окне в секции **CD/DVD Media1** нажмите кнопку **Disconnect**.
     1. Нажмите **Close**.
  1. Перезапустите сервер:
     
     ```bash
     reboot
     ```

{% endlist %}

#### См. также {#see-also}

* [{#T}](rescue-boot.md)
* [{#T}](add-new-ssh-key.md)
* [{#T}](restore-grub.md)
* [{#T}](switch-raid-member.md)