#### Ошибка «Not Supported» при сбросе ускорителей {#not-supported}

При выполнении `sudo nvidia-smi -r` возвращается ошибка:

```text
The following GPUs could not be reset:
  GPU 00000000:8B:00.0: Not Supported
  GPU 00000000:8C:00.0: Not Supported
```

Это значит, что на ускорителях активен NVLink. [Отключите](../../compute/operations/enable-mig.md#disable-nvlink) его и повторите сброс.

#### Ошибка «In use by another client» при сбросе ускорителей {#in-use}

При выполнении `sudo nvidia-smi -r` возвращается ошибка:

```text
The following GPUs could not be reset:
  GPU 00000000:8B:00.0: In use by another client
  GPU 00000000:8C:00.0: In use by another client

2 devices are currently being used by one or more other processes (e.g., Fabric Manager, CUDA application, graphics application such as an X server, or a monitoring application such as another instance of nvidia-smi). Please first kill all processes using these devices and all compute applications running in the system.
```

Это значит, что ускорители заняты другим процессом, например модулем `nvidia_drm` с включенным `modeset=1` или пользовательским процессом, который удерживает устройство.

Чтобы устранить проблему:
1. Проверьте, загружен ли модуль `nvidia_drm` с параметром `modeset=1`:

    ```bash
    cat /sys/module/nvidia_drm/parameters/modeset
    ```

    Если в выводе `Y`, отключите `modeset`. Для этого создайте файл `/etc/modprobe.d/nomodeset.conf` со следующим содержимым:

    ```text
    options nvidia-drm modeset=0
    ```

1. Обновите `initramfs` (Initial RAM File System):

    ```bash
    sudo update-initramfs -u
    ```

1. Найдите процессы, удерживающие устройство:

    ```bash
    sudo ls -l /proc/*/fd/* | grep /dev/nvidia
    ```

    {% cut "Пример вывода команды" %}

    ```bash
    lrwx------ 1 root             root             64 Jun 17 12:01 /proc/1574/fd/3 -> /dev/nvidiactl
    lrwx------ 1 root             root             64 Jun 17 12:01 /proc/1574/fd/4 -> /dev/nvidia0
    lrwx------ 1 root             root             64 Jun 17 12:01 /proc/1574/fd/5 -> /dev/nvidia0
    lrwx------ 1 root             root             64 Jun 17 12:01 /proc/1574/fd/6 -> /dev/nvidia0
    lrwx------ 1 root             root             64 Jun 17 12:01 /proc/1574/fd/7 -> /dev/nvidia0
    lrwx------ 1 root             root             64 Jun 17 11:59 /proc/904/fd/13 -> /dev/nvidiactl
    lrwx------ 1 root             root             64 Jun 17 11:59 /proc/904/fd/17 -> /dev/nvidia0
    lrwx------ 1 root             root             64 Jun 17 11:59 /proc/904/fd/18 -> /dev/nvidia0
    lrwx------ 1 root             root             64 Jun 17 11:59 /proc/904/fd/19 -> /dev/nvidia0
    lrwx------ 1 root             root             64 Jun 17 11:59 /proc/904/fd/20 -> /dev/nvidia0
    lrwx------ 1 root             root             64 Jun 17 11:59 /proc/904/fd/24 -> /dev/nvidia0
    lrwx------ 1 root             root             64 Jun 17 11:59 /proc/904/fd/25 -> /dev/nvidia0
    lrwx------ 1 root             root             64 Jun 17 11:59 /proc/904/fd/27 -> /dev/nvidia0
    lrwx------ 1 root             root             64 Jun 17 11:59 /proc/904/fd/28 -> /dev/nvidia0
    lrwx------ 1 root             root             64 Jun 17 11:59 /proc/904/fd/29 -> /dev/nvidia0
    lrwx------ 1 root             root             64 Jun 17 11:59 /proc/904/fd/3 -> /dev/nvidiactl
    lrwx------ 1 root             root             64 Jun 17 11:59 /proc/904/fd/39 -> /dev/nvidia0
    lrwx------ 1 root             root             64 Jun 17 11:59 /proc/904/fd/43 -> /dev/nvidia0
    lrwx------ 1 root             root             64 Jun 17 11:59 /proc/904/fd/8 -> /dev/nvidia-modeset
    ```

    {% endcut %}

1. Завершите эти процессы командой `sudo kill -9 <PID_процесса>`.
1. Повторите сброс ускорителей:

    ```bash
    sudo nvidia-smi -r
    ```

{% note tip %}

Если после перезагрузки ВМ значение `modeset` снова возвращается к `1`, проверьте, что в файловой системе нет других конфигураций, переопределяющих этот параметр:

```bash
sudo grep -R "modeset=1" /etc
```

{% endnote %}

#### Ошибка «Unknown Error» при выполнении команд nvidia-smi {#unknown-error}

Если команды `nvidia-smi`, например `nvidia-smi --gpu-reset`, возвращают ошибку `Unknown Error`, перезапустите сервис `nvidia-persistenced`:

```bash
sudo systemctl restart nvidia-persistenced
```

#### Ошибка «Warning: persistence mode is disabled on device» при включении режима MIG {#persistence-mode}

Если после выполнения команды `nvidia-smi -mig 1` в выводе появилось предупреждение `Warning: persistence mode is disabled on device ...`, запустите сервис `nvidia-persistenced`:

```bash
sudo systemctl start nvidia-persistenced
```