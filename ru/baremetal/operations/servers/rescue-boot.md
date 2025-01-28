---
title: Как запустить сервер {{ baremetal-full-name }} с Rescue-CD
description: Следуя данной инструкции, вы сможете воспользоваться инструментами диагностики и восстановления, доступными в штатном загрузочном CD-образе {{ baremetal-name }} Rescue-CD.
---

# Воспользоваться диском восстановления и диагностики Rescue-CD

Если запуск основной операционной системы сервера оказался невозможен, вы можете запустить сервер со специального Rescue-CD от [SystemRescue](https://www.system-rescue.org/), содержащего набор утилит и доступного в KVM-консоли.

## Запустите сервер с Rescue-CD {#boot-up}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит сервер.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. В строке с нужным сервером нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **KVM-консоль**.
  1. В окне KVM-консоли в верхнем меню выберите **Media** → **Virtual Media Wizard...** или нажмите на значок с изображением CD-диска. В открывшемся окне:

      1. В секции **CD/DVD Media1** нажмите кнопку **Browse** и в директории `common-iso` выберите образ `systemrescue<...>.iso`.
      1. Нажмите кнопку **Connect CD/DVD**.
      1. Убедитесь, что в секции **Status** для устройства **Virtual CD 1** значение поля **Connected To** изменилось на путь к выбранному CD-образу, и нажмите кнопку **Close**.
  1. Чтобы запустить сервер с выбранного образа Rescue-CD, в правом верхнем углу KVM-консоли нажмите кнопку **Reboot to cdrom**.
  1. Дождитесь перезапуска сервера и загрузки основного меню SystemRescue. Чтобы выбрать необходимый пункт меню, используйте **стрелки вверх и вниз** на клавиатуре и нажмите **Enter**.

      {% cut "Элементы основного меню SystemRescue" %}

      * **Boot SystemRescue using default options**

          Интерфейс восстановления SystemRescue будет запущен со стандартными настройками.
      * **Boot SystemRescue and copy system to RAM (copyram)**

          Будет запущен интерфейс восстановления SystemRescue, при этом утилиты и системные файлы операционной системы, используемой SystemRescue, будут помещены в ОЗУ.
      * **Boot SystemRescue and verify integrity of the medium (checksum)**

          Будет запущен интерфейс восстановления SystemRescue, при этом будет выполнена проверка целостности диска-носителя Rescue-CD.
      * **Boot SystemRescue using basic display drivers (nomodeset)**

          Будет запущен интерфейс восстановления SystemRescue, при этом для графического интерфейса будет использован базовый видеодрайвер.
      * **Boot SystemRescue with serial console (ttyS0,115200n8)**

          Будет запущен интерфейс восстановления SystemRescue с использованием серийной консоли.
      * **Boot SystemRescue, do not activate md raid or lvm (nomdlvm)**

          Будет запущен интерфейс восстановления SystemRescue, при этом не будет доступно управление RAID-массивами.
      * **Boot a Linux operating system installed on the disk (findroot)**

          Будет загружена операционная система Linux, установленная на загрузочном диске сервера.
      * **Stop during the boot process before mounting the root filesystem**

          Будет загружена операционная система, установленная на загрузочном диске сервера, при этом процесс загрузки будет остановлен перед монтированием корневой файловой системы.
      * **Boot existing OS**

          Будет загружена операционная система, установленная на сервере. С помощью кнопки **Tab** на клавиатуре можно предварительно выбрать диск и номер раздела, в котором установлена нужная ОС.
      * **Run Memtest86+ (RAM test)**

          Будет запущена утилита тестирования ОЗУ Memtest86+.
      * **Reboot**

          Сервер будет перезагружен.
      * **Power Off**

          Питание сервера будет выключено.

      {% endcut %}

{% endlist %}

## Воспользуйтесь инструментами SystemRescue {#use-tools}

Используйте SystemRescue для восстановления или настройки вашего сервера:

{% list tabs %}

- Документация SystemRescue

  1. [Запустите](#boot-up) сервер с Rescue-CD.
  1. В основном меню SystemRescue выберите **Boot SystemRescue using default options**.
  1. После запуска SystemRescue в KVM-консоли будет запущен терминал SystemRescue. В этом терминале введите `Manual`.

      В открывшемся браузере ELinks вы сможете узнать о возможностях и изучить документацию SystemRescue.

      Чтобы выйти из ELinks, нажмите **Esc** на клавиатуре, с помощью **стрелок вверх и вниз** выберите пункт меню **Exit** и нажмите **Enter**. Затем подтвердите выход.

  Познакомиться с [документацией SystemRescue](https://www.system-rescue.org/) также можно в графическом интерфейсе.

- Монтирование диска

  1. [Запустите](#boot-up) сервер с Rescue-CD.
  1. В основном меню SystemRescue выберите **Boot SystemRescue using default options**.

      После запуска SystemRescue в KVM-консоли будет запущен терминал SystemRescue. Все последующие команды будут выполняться в нем.
  1.  Определите метку подключенного к серверу раздела, который необходимо смонтировать:

      ```bash
      blkid
      ```

      Результат:

      ```
      /dev/md127: LABEL="/" UUID="97e4ad6e-edd9-4574-b4b3-23a86f2a701e" BLOCK_SIZE="4096" TYPE="ext4"
      /dev/sdb4: UUID="29395ea9-a41c-c71c-2807-2f5889e52967" UUID_SUB="287cdff0-ba68-6981-f46e-e52e0bf2d799" LABEL="3" TYPE="linux_raid_member" PARTLABEL="primary" PARTUUID="d6ad0b56-8291-4e0b-ad93-85d98e078ecf"
      /dev/sdb2: UUID="557a2516-47d1-a676-2cad-fa629a418c1f" UUID_SUB="27dfdf6c-c521-c0f3-e52c-46e2b728c0c1" LABEL="1" TYPE="linux_raid_member" PARTLABEL="primary" PARTUUID="b4483bff-0bb2-4077-a530-b64daa4b6fff"
      /dev/sdb3: UUID="20426859-f357-0447-6123-af035e85ca01" UUID_SUB="4dd828b0-4b6d-ea13-a9b9-cbeb5aaa0917" LABEL="2" TYPE="linux_raid_member" PARTLABEL="primary" PARTUUID="8e624512-5665-4c11-aa0b-ecbcdb7b1d7a"
      /dev/sdb1: PARTLABEL="primary" PARTUUID="b152360c-3157-482e-9804-36620f654ec1"
      /dev/md125: LABEL="/boot" UUID="58a6d4a4-d20a-4125-b52c-f76529a398f4" BLOCK_SIZE="4096" TYPE="ext3"
      ...
      /dev/sda1: PARTLABEL="primary" PARTUUID="1a1c7c88-4cce-429f-984f-1626587626c3"
      ```

      Например: раздел с операционной системой сервера имеет метку `md127`. Сохраните это значение — оно понадобится при монтировании диска.

  1. Создайте локальную директорию, которая будет использоваться как точка монтирования раздела:

      ```bash
      mkdir /mnt/serverdisk
      ```

  1. Смонтируйте выбранный раздел, указав сохраненную ранее метку:

      ```bash
      mount /dev/<метка_раздела> /mnt/serverdisk
      ```

  1. Перейдите в смонтированный диск:

      ```bash
      cd /mnt/serverdisk
      ```

      Здесь расположено дерево директорий операционной системы сервера:

      ```bash
      ls -l
      ```

      Результат:

      ```bash
      total 64
      lrwxrwxrwx   1 root root     7 июл  8 10:47 bin -> usr/bin
      drwxr-xr-x   4 root root  4096 окт 23 12:09 boot
      drwxr-xr-x  21 root root  4360 окт 24 05:43 dev
      drwxr-xr-x  91 root root  4096 окт 23 12:09 etc
      drwxr-xr-x   2 root root  4096 апр 18  2022 home
      lrwxrwxrwx   1 root root     7 июл  8 10:47 lib -> usr/lib
      lrwxrwxrwx   1 root root     9 июл  8 10:47 lib32 -> usr/lib32
      lrwxrwxrwx   1 root root     9 июл  8 10:47 lib64 -> usr/lib64
      lrwxrwxrwx   1 root root    10 июл  8 10:47 libx32 -> usr/libx32
      drwx------   2 root root 16384 окт 18 14:33 lost+found
      drwxr-xr-x   2 root root  4096 июл  8 10:47 media
      drwxr-xr-x   2 root root  4096 окт 23 20:08 mnt
      drwxr-xr-x   2 root root  4096 июл  8 10:47 opt
      dr-xr-xr-x 482 root root     0 окт 24 05:43 proc
      drwx------   5 root root  4096 окт 23 12:05 root
      drwxr-xr-x  25 root root   800 окт 24 05:43 run
      lrwxrwxrwx   1 root root     8 июл  8 10:47 sbin -> usr/sbin
      drwxr-xr-x   2 root root  4096 окт 18 14:43 snap
      drwxr-xr-x   2 root root  4096 июл  8 10:47 srv
      dr-xr-xr-x  13 root root     0 окт 24 05:43 sys
      drwxrwxrwt  12 root root  4096 окт 24 05:43 tmp
      drwxr-xr-x  14 root root  4096 июл  8 10:47 usr
      drwxr-xr-x  14 root root  4096 окт 18 14:38 var
      ```

- GUI SystemRescue

  1. [Запустите](#boot-up) сервер с Rescue-CD.
  1. В основном меню SystemRescue выберите **Boot SystemRescue using default options**.

      После запуска SystemRescue в KVM-консоли будет запущен терминал SystemRescue.
  1. Чтобы запустить графический интерфейс SystemRescue, в этом терминале выполните команду `startx`.

      Будет запущен графический интерфейс SystemRescue, который содержит браузер, набор инструментов диагностики и управления компьютером, а также имеет выход в интернет.

- Тест ОЗУ

  1. [Запустите](#boot-up) сервер с Rescue-CD.
  1. В основном меню SystemRescue выберите **Run Memtest86+ (RAM test)**.
  1. В открывшемся окне утилиты Memtest86+ дождитесь завершения тестирования ОЗУ на наличие ошибок.

      Чтобы прервать выполнение теста и перезагрузить сервер, нажмите **Esc** на клавиатуре.

{% endlist %}

#### См. также {#see-also}

* [{#T}](./reset-password.md)
* [{#T}](./add-new-ssh-key.md)
* [{#T}](./restore-grub.md)
* [{#T}](./switch-raid-member.md)
* [{#T}](../image-upload.md)
