# Подключить файловое хранилище к виртуальной машине

1. Если [ВМ](../../concepts/vm.md) запущена и работает ([статус](../../concepts/vm-statuses.md) `RUNNING`), [остановите ее](../vm-control/vm-stop-and-start.md#stop).
1. Привяжите [файловое хранилище](../../concepts/filesystem.md) к ВМ в {{ compute-name }}:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создано файловое хранилище.
     1. Выберите сервис **{{ compute-name }}**.
     1. На панели слева выберите ![image](../../../_assets/compute/storage.svg) **Файловые хранилища**.
     1. Выберите нужное хранилище.
     1. Перейдите на вкладку **Виртуальные машины**.
     1. Нажмите кнопку **Подключить к ВМ**.
     1. В открывшемся окне:
        1. Выберите **Виртуальную машину**.
        1. Укажите **Имя устройства**, под которым файловое хранилище будет доступно в ВМ.
        1. Нажмите кнопку **Подключить к ВМ**.

   - API

     Воспользуйтесь методом REST API [attachFilesystem](../../api-ref/Instance/attachFilesystem.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/AttachFilesystem](../../api-ref/grpc/instance_service.md#AttachFilesystem).

   {% endlist %}

1. Смонтируйте файловое хранилище к ВМ:
   1. [Подключитесь](../vm-connect/ssh.md) к ВМ по [SSH](../../../glossary/ssh-keygen.md).
   1. Выполните команду:

      ```bash
      sudo mount -t virtiofs <имя устройства> <путь для монтирования>
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

      ```text
      <имя устройства>  <путь для монтирования> virtiofs    rw    0   0
      ```