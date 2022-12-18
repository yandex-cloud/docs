# Подключить файловое хранилище к виртуальной машине

1. Если виртуальная машина запущена и работает ([статус](../../concepts/vm-statuses.md) `RUNNING`), [остановите ее](../vm-control/vm-stop-and-start.md#stop).
1. Привяжите файловое хранилище к ВМ в {{ compute-name }}:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создано файловое хранилище.
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
   
     Используйте метод [InstanceService/AttachFilesystem](../../api-ref/grpc/instance_service.md#AttachFilesystem) gRPC API или метод [attachFilesystem](../../api-ref/Instance/attachFilesystem.md) ресурса Instance REST API.
     
   {% endlist %}
   
1. Смонтируйте файловое хранилище к ВМ:

   1. [Подключитесь к ВМ по SSH](../vm-connect/ssh.md).
   1. Выполните команду:
   
      ```bash
      sudo mount -t virtiofs <id устройства> <путь для монтирования>
      ```
      
   1. Чтобы проверить, что файловое хранилище смонтировано, выполните команду:
   
      ```bash
      df -T
      ```
      
      Результат:
      
      ```
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
      <id устройства>  <путь для монтирования> virtiofs    rw    0   0
      ```
