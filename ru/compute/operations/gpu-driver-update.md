---
title: Как обновлять драйверы NVIDIA
description: Следуя данной инструкции, вы сможете обновить драйверы NVIDIA и CUDA.
---

# Рекомендации по обновлению драйверов NVIDIA


{% note warning %}

Данное руководство предназначено для платформ `gpu-standard-v3` ({{ a100-epyc }}) и `gpu-standard-v3i`.

Для платформы `gpu-standard-v3i` поддерживается только образ с драйвером [NVIDIA 535 и поддержкой secure-boot](/marketplace/products/yc/ubuntu-2004-lts-secureboot-cuda-12-2). Обновление видеодрайвера на этой платформе невозможно; допустимо обновлять только библиотеку CUDA.

{% endnote %}

## Поддерживаемые драйверы и рекомендации {#supported-drivers}

Виртуальные машины платформ `gpu-standard-v3` ({{ a100-epyc }}) и `gpu-standard-v3i` в {{ yandex-cloud }} преднастраиваются с драйвером NVIDIA 535.
Мы рекомендуем использовать именно эту версию драйвера — обновление драйвера до других версий не поддерживается и может привести к нестабильности работы GPU.

## Модель виртуализации Shared NVSwitch {#shared-nvswitch}

Мы используем модель виртуализации `Shared NVSwitch`, описанную в документации [NVIDIA Fabric Manager User Guide](https://docs.nvidia.com/datacenter/tesla/pdf/fabric-manager-user-guide.pdf).

NVSwitch-устройства вынесены в отдельную служебную ВМ и управляются отдельным драйвером NVIDIA версии 535. При старте гостевой ВМ GPU преднастраиваются для работы с NVLink; чтобы сохранить эту предконфигурацию, в {{ yandex-cloud }} запрещен программный сброс GPU из пользовательских ВМ.

Если в пользовательской ВМ обновить драйвер до другой версии (например, 570), драйвер может не распознать текущее состояние GPU — это ограничение драйверов NVIDIA. Поэтому смена версии драйвера из пользовательской ВМ не рекомендуется.

## Почему именно драйвер версии 535? {#why-version-535}

NVIDIA публикует несколько веток драйверов ([NVIDIA Data Center Drivers Overview](https://docs.nvidia.com/datacenter/tesla/pdf/NVIDIA_Datacenter_Drivers.pdf)):

* **LTSB (Long-Term Support Branch)** — долгосрочная поддержка (обновления безопасности и исправления в течение 3 лет);
* **PB (Production Branch)** — основная ветка для дата-центров;
* **NFB (New Feature Branch)** — драйверы с новыми возможностями.

Версия 535 относится к **LTSB**; она валидирована и поддерживается в инфраструктуре {{ yandex-cloud }}. Драйверы из других веток не проходят проверку совместимости и могут работать некорректно.

## Обновление CUDA {#cuda-update}

Часто требуется не смена драйвера, а обновление **CUDA Toolkit**. В большинстве случаев обновлять драйвер не нужно — достаточно установить требуемую версию CUDA и пакет `cuda-compat`, который обеспечивает совместимость с драйвером 535 (механизм [*CUDA Forward Compatibility*](https://docs.nvidia.com/deploy/cuda-compatibility/forward-compatibility.html)).

### Пример установки (Ubuntu) {#cuda-example-ubuntu}

1. Подключите репозиторий NVIDIA CUDA:

   ```bash
   sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu$(lsb_release -rs | sed -e 's/\.//')/x86_64/3bf863cc.pub
   sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/ /"
   sudo apt update
   ```

1. Установите `cuda-compat` (пример для CUDA 12.5):

   ```bash
   sudo apt install -y cuda-compat-12-5
   echo 'export LD_LIBRARY_PATH=/usr/local/cuda-12.5/compat:$LD_LIBRARY_PATH' >> ~/.bashrc && source ~/.bashrc
   ```

1. Проверьте текущую конфигурацию:

   ```bash
   nvidia-smi
   ```

## Проблема с `sudo reboot` после обновления драйвера выше 535 и рекомендуемый обход {#reboot-workaround}

При переустановке драйвера и последующем `sudo reboot` драйвер не успевает корректно выгрузиться — поскольку в {{ yandex-cloud }} программный сброс GPU запрещен, карта остается в невалидном состоянии. Это не приводит к аппаратным проблемам, но ВМ будет работать некорректно. Вместо `sudo reboot` используйте команду `yc compute instance restart`.

Поэтому обновление драйвера выше версии 535 **не рекомендуется**. Если требуется установить драйвер выше 535 и выполнить перезагрузку пользовательской ВМ, можно применить следующий обходной сценарий:

1. [Установите](https://docs.nvidia.com/datacenter/tesla/driver-installation-guide/index.html#ubuntu-installation-network) драйвер.

   {% cut "Скрипт для Ubuntu" %}
   
   ```bash
   #!/bin/bash
   set -e
   
   # Фиксируем архитектуру
   arch="x86_64"
   
   # Определяем версию Ubuntu (20.04 -> ubuntu2004, 22.04 -> ubuntu2204 и т.д.)
   . /etc/os-release
   if [[ "$ID" != "ubuntu" ]]; then
     echo "Этот скрипт рассчитан только на Ubuntu!"
     exit 1
   fi
   distro="ubuntu${VERSION_ID//./}"
   
   echo "Используем репозиторий: $distro/$arch"
   
   # 1. Скачиваем пакет с ключами
   wget https://developer.download.nvidia.com/compute/cuda/repos/${distro}/${arch}/cuda-keyring_1.1-1_all.deb
   
   # 2. Устанавливаем ключи
   sudo dpkg -i cuda-keyring_1.1-1_all.deb || {
     echo "Не удалось установить cuda-keyring, выполняем альтернативные шаги..."
     
     # 2a. Загружаем gpg-ключ вручную
     wget https://developer.download.nvidia.com/compute/cuda/repos/${distro}/${arch}/cuda-archive-keyring.gpg
     
     # 2b. Кладём ключ в правильное место
     sudo mv cuda-archive-keyring.gpg /usr/share/keyrings/cuda-archive-keyring.gpg
     
     # 2c. Подключаем репозиторий CUDA вручную
     echo "deb [signed-by=/usr/share/keyrings/cuda-archive-keyring.gpg] \
     https://developer.download.nvidia.com/compute/cuda/repos/${distro}/${arch}/ /" \
     | sudo tee /etc/apt/sources.list.d/cuda-${distro}-${arch}.list
   }
   
   # 3. Обновляем список пакетов
   sudo apt update
   
   # 4. Устанавливаем драйверы NVIDIA
   sudo apt install -y nvidia-open
   
   # 5. Устанавливаем метапакет драйверов CUDA
   sudo apt install -y cuda-drivers
   ```

   {% endcut %}

1. Дальнейшие шаги необходимо выполнять до перезагрузки системы через `sudo reboot`.
   Создайте скрипт `/usr/libexec/manage-nvidia`:

   ```bash
   #!/bin/bash
   set -eu
   usage() {
            echo "usage: manage-nvidia (load|unload)"
            exit 1
   }
   [ $# -eq 1 ] || usage
   case "$1" in
            load)   modprobe nvidia ;;
            unload) modprobe -r nvidia_uvm nvidia_drm nvidia_modeset nvidia ;;
            *)      usage ;;
   esac
   ```

1. Сделайте скрипт исполняемым:

   ```bash
   sudo chmod +x /usr/libexec/manage-nvidia
   ```

1. Создайте systemd-unit `/etc/systemd/system/manage-nvidia.service`:

   ```ini
   [Unit]
   Description=Manage NVIDIA driver
   Before=nvidia-persistenced.service
   
   [Service]
   Type=oneshot
   ExecStart=/usr/libexec/manage-nvidia load
   RemainAfterExit=true
   ExecStop=/usr/libexec/manage-nvidia unload
   StandardOutput=journal
   
   [Install]
   WantedBy=multi-user.target
   RequiredBy=nvidia-persistenced.service
   ```

1. Перезагрузите конфигурацию `systemd`, включите автоматический запуск сервиса `manage-nvidia` при загрузке системы и запустите сам сервис:

   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable --now manage-nvidia
   ```

   Ожидаемый вывод при успешном выполнении:

   ```
   Created symlink /etc/systemd/system/multi-user.target.wants/manage-nvidia.service → /etc/systemd/system/manage-nvidia.service.
   Created symlink /etc/systemd/system/nvidia-persistenced.service.requires/manage-nvidia.service → /etc/systemd/system/manage-nvidia.service.
   ```

   Проверьте зависимость от `manage-nvidia.service` у `nvidia-persistenced.service`:

   ```bash
   sudo systemctl list-dependencies nvidia-persistenced | grep manage-nvidia   
   ```

   Результат:
   ```bash
   ● ├─manage-nvidia.service
   ```

   Проверьте статус сервиса:

   ```
   sudo systemctl status manage-nvidia
   ```

После этого при `sudo reboot` systemd вызовет `ExecStop` для сервиса `manage-nvidia`, драйвер будет выгружен корректно, и перезагрузка пройдет без оставления GPU в невалидном состоянии.