---
title: "Подключить файловое хранилище к виртуальной машине"
description: "Следуя данной инструкции, вы сможете подключить файловое хранилище к виртуальной машине."
---

# Подключить файловое хранилище к виртуальной машине

{% note warning %}

[Файловое хранилище](../../concepts/filesystem.md) можно подключить только к [ВМ](../../concepts/vm.md) под управлением [операционной системы](../../concepts/filesystem.md#os) Linux с версией ядра 5.4 или выше.

Чтобы проверить версию ядра, выполните команду `sudo uname -r`.

{% endnote %}

1. Если ВМ запущена и работает ([статус](../../concepts/vm-statuses.md) `RUNNING`), [остановите ее](../vm-control/vm-stop-and-start.md#stop).
1. Привяжите файловое хранилище к ВМ в {{ compute-name }}:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создано файловое хранилище.
     1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
     1. На панели слева выберите ![image](../../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.compute.switch_file-storages }}**.
     1. Выберите нужное хранилище.
     1. Перейдите на вкладку **{{ ui-key.yacloud.compute.nfs.label_attached-instances }}**.
     1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.compute.nfs.button_attach-instance-to-the-filesystem }}**.
     1. В открывшемся окне:
        1. Выберите ВМ.
        1. Укажите имя устройства, под которым файловое хранилище будет доступно в ВМ. Сохраните это значение: оно понадобится при монтировании хранилища.
        1. Нажмите **{{ ui-key.yacloud.compute.nfs.button_attach-instance-to-the-filesystem }}**.

   - {{ TF }} {#tf}

     {% include [terraform-install](../../../_includes/terraform-install.md) %}

     Если вы не указали для ВМ параметр `allow_stopping_for_update` в значении `true`, сделайте это.

     Чтобы подключить файловое хранилище к ВМ, добавьте к ее описанию блок `filesystem` с параметром `filesystem_id` (см. пример).
     1. Откройте файл конфигурации {{ TF }} и добавьте фрагмент с описанием хранилища к описанию ВМ:

        {% cut "Пример описания хранилища в конфигурации ВМ в {{ TF }}" %}

        ```hcl
        ...
        resource "yandex_compute_instance" "vm-1" {
          name        = "test-vm"
          platform_id = "standard-v3"
          zone        = "{{ region-id }}-a"

          filesystem {
            filesystem_id = "fhmaikp755gr********"
          }
        }
        ...
        ```

        {% endcut %}

     1. Примените изменения:

        {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     Проверить присоединение хранилища к ВМ можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

     ```bash
     yc compute instance get <имя_ВМ>
     ```

   - API {#api}

     Воспользуйтесь методом REST API [attachFilesystem](../../api-ref/Instance/attachFilesystem.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/AttachFilesystem](../../api-ref/grpc/instance_service.md#AttachFilesystem).

   {% endlist %}

1. Смонтируйте файловое хранилище на ВМ.
   1. Если вы не знаете имя устройства для монтирования, получите его:

      ```bash
      yc compute instance get <имя_ВМ>
      ```

      Результат:

      ```text
      ...
      filesystems:
        - mode: READ_WRITE
          device_name: storagename
          filesystem_id: epdb1jata63j********
      ...
      ```

      Сохраните значение поля `device_name` в блоке `filesystems`. Это имя устройства для монтирования, которое понадобится далее.
   1. [Подключитесь](../vm-connect/ssh.md) к ВМ по [SSH](../../../glossary/ssh-keygen.md).
   1. Выполните команду:

      ```bash
      sudo mount -t virtiofs <имя_устройства> <путь_монтирования>
      ```

      Где:
      * `<имя_устройства>` — значение поля `device_name`, сохраненное ранее. В примере выше имя устройства — `storagename`. У вас имя устройства может отличаться.
      * `<путь_монтирования>` — каталог или диск, в который будет смонтировано файловое хранилище. Например: `/mnt/vfs0`.
   1. Проверьте, что файловое хранилище смонтировано:

      ```bash
      df -T
      ```

      Результат:

      ```text
      Filesystem        Type         1K-blocks    Used Available Use% Mounted on
      udev              devtmpfs        988600       0    988600   0% /dev
      tmpfs             tmpfs           203524     780    202744   1% /run
      /dev/vda2         ext4          13354932 1909060  10861420  15% /
      tmpfs             tmpfs          1017604       0   1017604   0% /dev/shm
      tmpfs             tmpfs             5120       0      5120   0% /run/lock
      tmpfs             tmpfs          1017604       0   1017604   0% /sys/fs/cgroup
      tmpfs             tmpfs           203520       0    203520   0% /run/user/1000
      storagename       virtiofs      66774660       0  66774660   0% /mnt/vfs0
      ```

   1. Чтобы файловое хранилище монтировалось при каждом запуске ВМ, добавьте в файл `/etc/fstab` строку вида:

      ```text
      <имя_устройства> <путь_монтирования> virtiofs    rw    0   0
      ```