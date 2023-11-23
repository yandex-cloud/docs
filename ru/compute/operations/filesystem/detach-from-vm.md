---
title: "Как отключить файловое хранилище от виртуальной машины в {{ compute-full-name }}"
description: "Следуя данной инструкции, вы сможете отключить файловое хранилище от виртуальной машины." 
---

# Отключить файловое хранилище от виртуальной машины

1. Отмонтируйте [файловое хранилище](../../concepts/filesystem.md) от [ВМ](../../concepts/vm.md):
   1. [Подключитесь](../vm-connect/ssh.md) к ВМ по [SSH](../../../glossary/ssh-keygen.md).
   1. Если вы добавляли в файл `/etc/fstab` строку для автоматического монтирования файлового хранилища к ВМ при ее запуске (например, при [подключении хранилища к ВМ](attach-to-vm.md)), удалите строку.
   1. Выполните команду:

      ```bash
      sudo umount <путь для монтирования>
      ```

   1. Чтобы проверить, что файловое хранилище отмонтировано, выполните команду:

      ```bash
      df -T
      ```

      В результате не должно быть файловой системы с типом `virtiofs`, соответствующей файловому хранилищу:

      ```text
      Filesystem        Type         1K-blocks    Used Available Use% Mounted on
      udev              devtmpfs        988600       0    988600   0% /dev
      tmpfs             tmpfs           203524     780    202744   1% /run
      /dev/vda2         ext4          13354932 1909060  10861420  15% /
      tmpfs             tmpfs          1017604       0   1017604   0% /dev/shm
      tmpfs             tmpfs             5120       0      5120   0% /run/lock
      tmpfs             tmpfs          1017604       0   1017604   0% /sys/fs/cgroup
      tmpfs             tmpfs           203520       0    203520   0% /run/user/1000
      ```

1. [Остановите ВМ](../vm-control/vm-stop-and-start.md).
1. Отключите файловое хранилище от ВМ в {{ compute-name }}:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится файловое хранилище.
     1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
     1. На панели слева выберите ![image](../../../_assets/compute/storage.svg) **{{ ui-key.yacloud.compute.switch_file-storages }}**.
     1. Выберите нужное хранилище.
     1. Перейдите на вкладку **{{ ui-key.yacloud.compute.nfs.label_attached-instances }}**.
     1. В строке нужной ВМ нажмите ![image](../../../_assets/options-grey.svg) и выберите пункт **{{ ui-key.yacloud.compute.nfs.button_detach-instance-from-the-filesystem }}**.
     1. В открывшемся окне подтвердите отключение.

   - {{ TF }}

      {% include [terraform-install](../../../_includes/terraform-install.md) %}

      Если вы не указали для ВМ параметр `allow_stopping_for_update` в значении `true`, сделайте это.

      1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием хранилища:

            {% cut "Пример описания хранилища в конфигурации ВМ в {{ TF }}" %}

            ```hcl
            ...
            resource "yandex_compute_instance" "vm-1" {

               name        = "test-vm"
               platform_id = "standard-v3"
               zone        = "{{ region-id }}-a"

               filesystem {
                  filesystem_id = "fhmaikp755grp4mlvvem"
               }
            ...
            ```

            {% endcut %}

      1. Примените изменения:

          {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

      Проверить отсоединение хранилища от ВМ можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

        ```bash
        yc compute instance get <имя_ВМ>
        ```

   - API

     Воспользуйтесь методом REST API [detachFilesystem](../../api-ref/Instance/detachFilesystem.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/DetachFilesystem](../../api-ref/grpc/instance_service.md#DetachFilesystem).

   {% endlist %}