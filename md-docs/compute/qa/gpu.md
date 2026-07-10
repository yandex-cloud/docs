[Документация Yandex Cloud](../../index.md) > [Yandex Compute Cloud](../index.md) > Вопросы и ответы > Графические ускорители GPU

# Вопросы и ответы про графические ускорители GPU в Compute Cloud

* [Что делать, если на ВМ перестала работать GPU?](#gpu-not-working)

* [Ошибка «Not Supported» при сбросе ускорителей](#not-supported)

* [Ошибка «In use by another client» при сбросе ускорителей](#in-use)

* [Ошибка «Unknown Error» при выполнении команд nvidia-smi](#unknown-error)

* [Ошибка «Warning: persistence mode is disabled on device» при включении режима MIG](#persistence-mode)


* [Как проверить физическое состояние кластера GPU?](#test-physical-state)

* [Как запустить параллельные задачи в кластере GPU?](#mpirun-parallel)

* [Как проверить пропускную способность InfiniBand?](#preinstall-software)

#### Что делать, если на ВМ перестал работать GPU? {#gpu-not-working}

В таком случае необходимо [остановить](../operations/vm-control/vm-stop-and-start.md#stop) и снова [запустить](../operations/vm-control/vm-stop-and-start.md#start) виртуальную машину. В большинстве случаев требуются именно остановка и повторный запуск, а не перезагрузка, поскольку при перезагрузке ВМ остается на том же хосте, где возникла проблема с GPU.

#### Ошибка «Not Supported» при сбросе ускорителей {#not-supported}

#### Ошибка «Not Supported» при сбросе ускорителей {#not-supported}

При выполнении `sudo nvidia-smi -r` возвращается ошибка:

```text
The following GPUs could not be reset:
  GPU 00000000:8B:00.0: Not Supported
  GPU 00000000:8C:00.0: Not Supported
```

Это значит, что на ускорителях активен NVLink. [Отключите](../operations/enable-mig.md#disable-nvlink) его и повторите сброс.

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

#### Ошибка «In use by another client» при сбросе ускорителей {#in-use}

#### Ошибка «Not Supported» при сбросе ускорителей {#not-supported}

При выполнении `sudo nvidia-smi -r` возвращается ошибка:

```text
The following GPUs could not be reset:
  GPU 00000000:8B:00.0: Not Supported
  GPU 00000000:8C:00.0: Not Supported
```

Это значит, что на ускорителях активен NVLink. [Отключите](../operations/enable-mig.md#disable-nvlink) его и повторите сброс.

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

#### Ошибка «Unknown Error» при выполнении команд nvidia-smi {#unknown-error}

#### Ошибка «Not Supported» при сбросе ускорителей {#not-supported}

При выполнении `sudo nvidia-smi -r` возвращается ошибка:

```text
The following GPUs could not be reset:
  GPU 00000000:8B:00.0: Not Supported
  GPU 00000000:8C:00.0: Not Supported
```

Это значит, что на ускорителях активен NVLink. [Отключите](../operations/enable-mig.md#disable-nvlink) его и повторите сброс.

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

#### Ошибка «Warning: persistence mode is disabled on device» при включении режима MIG {#persistence-mode}

#### Ошибка «Not Supported» при сбросе ускорителей {#not-supported}

При выполнении `sudo nvidia-smi -r` возвращается ошибка:

```text
The following GPUs could not be reset:
  GPU 00000000:8B:00.0: Not Supported
  GPU 00000000:8C:00.0: Not Supported
```

Это значит, что на ускорителях активен NVLink. [Отключите](../operations/enable-mig.md#disable-nvlink) его и повторите сброс.

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


#### Как проверить физическое состояние кластера GPU? {#test-physical-state}

* Проверьте порты InfiniBand.
* Проверьте сеть.

Подробнее читайте в разделе [Проверить физическое состояние кластера GPU](../operations/gpu-cluster/gpu-cluster-test-physical-state.md).

#### Как запустить параллельные задачи в кластере GPU? {#mpirun-parallel}

Чтобы запустить параллельные задачи в кластере GPU:

1. Подключитесь к каждой ВМ по SSH и установите [Open MPI](https://www.open-mpi.org/) и [NCCL](https://github.com/NVIDIA/nccl).
1. На основной ВМ соберите тесты NVIDIA и настройте SSH-ключи без пароля.
1. На каждой ВМ добавьте публичный ключ в `authorized_keys`.
1. На основной ВМ выполните команду `mpirun` с IP-адресами ВМ и количеством GPU.

Подробнее читайте в разделе [Запустить параллельные задачи в кластере GPU](../operations/gpu-cluster/gpu-cluster-mpirun-parallel.md).

#### Как проверить пропускную способность InfiniBand? {#preinstall-software}

Чтобы проверить пропускную способность InfiniBand создайте и запустите скрипт для запуска тестов `perftest` с использованием `numactl`.

Подробнее читайте в разделе [Проверить пропускную способность InfiniBand](../operations/gpu-cluster/test-infiniband-bandwidth.md).