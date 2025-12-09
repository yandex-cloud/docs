# Недоступна CUDA на платформе GPU


## Описание проблемы {#issue-description}

CUDA недоступна на платформе GPU.

## Решение {#issue-resolution}

Необходимо выполнить команды:

1. `sudo apt update -y`.
1. `sudo apt upgrade -y`.
1. `pip3 install torch`.

После этого нужно проверить доступность CUDA: `torch.cuda.is_available()`.

Альтернативой может стать вариант использовать [сервис {{ ml-platform-name }}](../../../datasphere/concepts/configurations.md), где используются конфигурации на базе GPU. У каждого проекта сервиса есть несколько Docker-образов с определенным набором ПО. Если этого будет недостаточно, то можно [собрать собственный образ для проекта](../../../datasphere/operations/user-images.md).

{% note info %}

CUDA и cuDNN уже встроены в базовый Docker-образ. 

{% endnote %}

Проверить версию этих компонентов можно двумя командами:

* Проверить версию CUDA: `!nvcc --version`;
* Проверить версию cuDNN: `!cat /usr/include/cudnn_version.h`.

Дополнительно можно узнать:

* Информацию по NVIDIA: `!nvidia-smi`;
* Доступность CUDA через torch: `torch.cuda.is_available()`.

Если после перезагрузки системы видеоадаптер не определяется в списке устройств, подключенных к виртуальной машине, например в `lspci`, но виртуальная машина при этом работает штатно, добавьте скрипт по пути `/usr/libexec/manage-nvidia`:

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

После этого создайте юнит `systemd`. Для этого в файл `/etc/systemd/system/manage-nvidia.service` внесите содержимое:

```text
[Unit]
Description=Manage NVIDIA driver
Requires=nvidia-persistenced.service
Before=nvidia-persistenced.service
After=network.target

[Service]
Type=oneshot
RemainAfterExit=true
ExecStart=/usr/libexec/manage-nvidia load
ExecStop=/usr/libexec/manage-nvidia unload
StandardOutput=journal

[Install]
WantedBy=multi-user.target
```

Далее выполните команды перезагрузки драйвера:

```bash
sudo systemctl daemon-reload
sudo systemctl enable manage-nvidia
```

Последняя команда должна создать символическую ссылку и вывести:

```bash
Created symlink /etc/systemd/system/multi-user.target.wants/manage-nvidia.service → /etc/systemd/system/manage-nvidia.service.
Created symlink /etc/systemd/system/nvidia-persistenced.service.requires/manage-nvidia.service → /etc/systemd/system/manage-nvidia.service.
```

При этом у `nvidia-persistenced.service` должна появиться зависимость от `manage-nvidia.service`:

```bash
sudo systemctl list-dependencies nvidia-persistenced | grep manage-nvidia
○ ├─manage-nvidia.service
```

После выполнения этих действий при перезагрузке системы `systemd` будет корректно останавливать процесс `manage-nvidia`, драйвер выгрузится из оперативной памяти, что позволит GPU корректно инициализироваться при следующем старте системы.
