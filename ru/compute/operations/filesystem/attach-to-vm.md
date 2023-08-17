# Подключить файловое хранилище к виртуальной машине

1. Если [ВМ](../../concepts/vm.md) запущена и работает ([статус](../../concepts/vm-statuses.md) `RUNNING`), [остановите ее](../vm-control/vm-stop-and-start.md#stop).
1. Привяжите [файловое хранилище](../../concepts/filesystem.md) к ВМ в {{ compute-name }}:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создано файловое хранилище.
     1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
     1. На панели слева выберите ![image](../../../_assets/compute/storage.svg) **{{ ui-key.yacloud.compute.switch_file-storages }}**.
     1. Выберите нужное хранилище.
     1. Перейдите на вкладку **{{ ui-key.yacloud.compute.nfs.label_attached-instances }}**.
     1. Нажмите кнопку ![image](../../../_assets/plus-sign.svg) **{{ ui-key.yacloud.compute.nfs.button_attach-instance-to-the-filesystem }}**.
     1. В открывшемся окне:
        1. Выберите виртуальную машину.
        1. Укажите имя устройства, под которым файловое хранилище будет доступно в ВМ.
        1. Нажмите **{{ ui-key.yacloud.compute.nfs.button_attach-instance-to-the-filesystem }}**.

   - {{ TF }}

      Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

      Если вы не указали для ВМ параметр `allow_stopping_for_update` в значении `true`, сделайте это.

      Чтобы подключить файловое хранилище к виртуальной машине, добавьте к ее описанию блок `filesystem` с параметром `filesystem_id` (см. пример).

      1. Откройте файл конфигурации {{ TF }} и добавьте фрагмент с описанием хранилища к описанию ВМ:

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

      Проверить присоединение хранилища к ВМ можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

        ```bash
        yc compute instance get <имя_ВМ>
        ```

   - API

     Воспользуйтесь методом REST API [attachFilesystem](../../api-ref/Instance/attachFilesystem.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/AttachFilesystem](../../api-ref/grpc/instance_service.md#AttachFilesystem).

   {% endlist %}

1. Смонтируйте файловое хранилище к ВМ:
   1. [Подключитесь](../vm-connect/ssh.md) к ВМ по [SSH](../../../glossary/ssh-keygen.md).
   1. Выполните команду:

      ```bash
      sudo mount -t virtiofs <имя_устройства> <путь_для_монтирования>
      ```

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
      filesystem        virtiofs      66774660       0  66774660   0% /mnt/vfs0
      ```

   1. Чтобы файловое хранилище монтировалось при каждом запуске ВМ, добавьте в файл `/etc/fstab` строку вида:
   
      ```
      <имя_устройства>  <путь_для_монтирования> virtiofs    rw    0   0
      ```