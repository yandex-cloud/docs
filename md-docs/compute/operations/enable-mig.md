[Документация Yandex Cloud](../../index.md) > [Yandex Compute Cloud](../index.md) > [Пошаговые инструкции](index.md) > GPU > Включить MIG на ВМ с GPU

# Включение режима MIG на ВМ с GPU в Compute Cloud


{% note info %}

Инструкция проверена на образах Ubuntu 20.04, Ubuntu 22.04 и Ubuntu 24.04 с драйвером NVIDIA версии 535.

{% endnote %}

_MIG (Multi-Instance GPU)_ — технология NVIDIA, которая позволяет разделить один графический ускоритель на несколько независимых GPU-инстансов. Каждый GPU-инстанс получает собственные вычислительные блоки, кеш L2 и выделенную часть памяти HBM2. Инстансы изолированы друг от друга на аппаратном уровне, поэтому нагрузка в одном инстансе не влияет на производительность остальных.

Подробное описание технологии и схемы разбиения приведены на странице [NVIDIA MIG User Guide](https://docs.nvidia.com/datacenter/tesla/mig-user-guide/).

С помощью режима MIG вы можете:
* Запускать на одной ВМ несколько независимых задач машинного обучения или инференса без взаимного влияния на производительность и память.
* Эффективнее утилизировать GPU, если отдельная задача не нагружает весь ускоритель целиком.
* Гарантированно распределять ресурсы GPU между несколькими пользователями или процессами.

Режим MIG поддерживается для следующих [платформ](../concepts/vm-platforms.md):
* AMD EPYC™ with NVIDIA® Ampere® A100 (`gpu-standard-v3`);
* Gen2 (`gpu-standard-v3i`);
* GPU PLATFORM V4 (`gpu-standard-v4`).

{% note warning %}

В режиме MIG недоступна передача данных через [NVLink](https://ru.wikipedia.org/wiki/NVLink) между ускорителями.

{% endnote %}

Чтобы включить режим MIG на ВМ с GPU:
1. Подготовьте ВМ:
    1. [Создайте](vm-create/create-vm-with-gpu.md) ВМ с GPU на одной из следующих платформ:
        * AMD EPYC™ with NVIDIA® Ampere® A100 (`gpu-standard-v3`);
        * Gen2 (`gpu-standard-v3i`);
        * GPU PLATFORM V4 (`gpu-standard-v4`).

        {% note tip %}

        Убедитесь, что в облаке достаточно [квот](../concepts/limits.md#compute-quotas) на суммарное количество GPU нужной платформы, объем RAM, количество vCPU и объем SSD-дисков для создания ВМ. Для этого используйте сервис [Yandex Cloud Quota Manager](../../quota-manager/index.md).

        {% endnote %}

    1. [Подключитесь](vm-connect/ssh.md) к ВМ по SSH.
    1. [Установите](vm-operate/install-nvidia-drivers.md) драйверы NVIDIA версии 535.
1. Отключите NVLink на ускорителях. {#disable-nvlink}
    1. Создайте файл `/etc/modprobe.d/nonvlink.conf` со следующим содержимым:

        ```text
        options nvidia NVreg_NvLinkDisable=1
        ```

    1. Перезагрузите драйвер NVIDIA:

        {% note warning %}

        Тут и далее выполняйте все команды от имени пользователя `root` или через `sudo`.

        {% endnote %}

        ```bash
        sudo systemctl stop nvidia-persistenced
        sudo modprobe -r nvidia_uvm nvidia_drm nvidia_modeset nvidia
        sudo modprobe nvidia
        sudo systemctl start nvidia-persistenced
        nvidia-smi
        ```

    1. Убедитесь, что NVLink отключен:

        ```bash
        grep NvLink /proc/driver/nvidia/params
        ```

        Ожидаемый результат:

        ```text
        NvLinkDisable: 1
        ```

1. Сбросьте состояние ускорителей:

    ```bash
    sudo nvidia-smi -r
    ```

    Результат:

    ```text
    GPU 00000000:8B:00.0 was successfully reset.
    GPU 00000000:8C:00.0 was successfully reset.
    All done.
    ```

    Подробнее о возможных ошибках в разделе [Устранение проблем](#troubleshooting).

1. Включите режим MIG для всех ускорителей ВМ:

    ```bash
    sudo nvidia-smi -mig 1
    ```

    Результат:

    ```text
    Enabled MIG Mode for GPU 00000000:8B:00.0
    Enabled MIG Mode for GPU 00000000:8C:00.0
    All done.
    ```

    {% note info %}

    Если в выводе появилось предупреждение `Warning: persistence mode is disabled on device ...`, запустите сервис `nvidia-persistenced`:

    ```bash
    sudo systemctl start nvidia-persistenced
    ```

    {% endnote %}

1. Разделите ускорители на GPU-инстансы. В примере ниже на каждом ускорителе создаются два GPU-инстанса по профилю `1g.10gb`:

    ```bash
    sudo nvidia-smi mig -cgi 19,1g.10gb -C
    ```

    Результат:

    ```text
    Successfully created GPU instance ID 13 on GPU  0 using profile MIG 1g.10gb (ID 19)
    Successfully created compute instance ID  0 on GPU  0 GPU instance ID 13 using profile MIG 1g.10gb (ID  0)
    Successfully created GPU instance ID 11 on GPU  0 using profile MIG 1g.10gb (ID 19)
    Successfully created compute instance ID  0 on GPU  0 GPU instance ID 11 using profile MIG 1g.10gb (ID  0)
    ...
    ```

    Список доступных профилей разбиения для NVIDIA® A100 приведен в [NVIDIA MIG User Guide](https://docs.nvidia.com/datacenter/tesla/mig-user-guide/#supported-mig-profiles). Также вы можете воспользоваться командой `nvidia-smi mig -lgip`.

1. Проверьте созданные GPU-инстансы:

    ```bash
    nvidia-smi -L
    ```

    Результат:

    ```text
    GPU 0: NVIDIA A100-SXM4-80GB (UUID: GPU-9c73eb7b-8d6d-6c0e-dc13-97873e2ede40)
      MIG 1g.10gb     Device  0: (UUID: MIG-a686709d-6dc2-542a-8851-0d2508448c10)
      MIG 1g.10gb     Device  1: (UUID: MIG-53864714-0a66-5df2-9007-9268e30d9a72)
    GPU 1: NVIDIA A100-SXM4-80GB (UUID: GPU-c92e2d5d-4a69-f1cd-4df0-305f8606705a)
      MIG 1g.10gb     Device  0: (UUID: MIG-d5a46a2e-1d77-575d-99e3-1f96c8555a2e)
      MIG 1g.10gb     Device  1: (UUID: MIG-b8479d6e-d08f-5a92-9a24-0946db72b2a0)
    ```

GPU-инстансы готовы к использованию. Чтобы запустить вычисления на конкретном инстансе, передавайте его UUID в переменную окружения `CUDA_VISIBLE_DEVICES`.

## Устранение проблем {#troubleshooting}

#### Ошибка «Not Supported» при сбросе ускорителей {#not-supported}

При выполнении `sudo nvidia-smi -r` возвращается ошибка:

```text
The following GPUs could not be reset:
  GPU 00000000:8B:00.0: Not Supported
  GPU 00000000:8C:00.0: Not Supported
```

Это значит, что на ускорителях активен NVLink. [Отключите](enable-mig.md#disable-nvlink) его и повторите сброс.

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

#### Полезные ссылки {#see-also}

* [Графические ускорители GPU](../concepts/gpus.md)
* [Создание виртуальной машины с GPU](vm-create/create-vm-with-gpu.md)
* [Установка NVIDIA-драйверов](vm-operate/install-nvidia-drivers.md)
* [Рекомендации по обновлению драйверов NVIDIA](gpu-driver-update.md)