---
title: Как создать образ на основе виртуальной машины {{ compute-full-name }} Linux в {{ cloud-desktop-full-name }}
description: Следуя данной инструкции, вы сможете создать образ на основе виртуальной машины Linux.
---

# Создать образ на основе ВМ Linux {{ compute-name }}

В {{ cloud-desktop-name }} вы можете создавать рабочие столы из предустановленных [системных образов](../../concepts/images.md) или собственных [пользовательских образов](../../concepts/images.md#custom-images).

Пользовательские образы могут быть с [ОС Windows](create-from-windows.md) или Linux.

Образ Linux создается на базе [виртуальной машины](../../../compute/concepts/vm.md) {{ compute-name }}.

Чтобы добавить в {{ cloud-desktop-name }} пользовательский образ Linux:

1. [Создайте](../../../compute/operations/vm-create/create-linux-vm.md) или выберите уже созданную ВМ со следующими параметрами:
   * Доступ — по **SSH-ключу**. Доступ по {{ oslogin }} в {{ cloud-desktop-name }} не поддерживается.
   * Подключение к интернету для установки дополнительного ПО.

1. Настройте виртуальную машину для создания нужного образа.
1. Настройте возможность удаленного доступа по [протоколу RDP](https://ru.wikipedia.org/wiki/Remote_Desktop_Protocol):
   1. Установите пакеты `xrdp` и `xorgxrdp` или другие подходящие программы.
   1. Для использования аудио и микрофона установите пакеты для работы с системным звуком. Например, для `xrdp` установите пакет `pipewire-module-xrdp` или `pulseaudio-module-xrdp`.
   
    Пример настройки RDP и звука для Debian 12:

    ```bash
    sudo apt-get update
    sudo apt-get install -y xfce4 pipewire pipewire-pulse xorgxrdp xrdp pipewire-module-xrdp
    sudo systemctl enable xrdp
    sudo systemctl enable xrdp-sesman
    ```

1. Настройте входящие соединения на всех сетевых интерфейсах для работы:
   * RDP — на порт TCP `3389`.
   * Для {{ yandex-cloud }} Desktop Agent — на порт TCP `5050`.

1. Проверьте доступность ВМ по протоколу RDP.

1. Установите агент сервиса {{ cloud-desktop-full-name }} для Linux с помощью последовательности команд:
  
    ```bash
    WORKDIR=$(mktemp -d -p $HOME)
    cd ${WORKDIR}
    curl -sSL https://{{ s3-storage-host }}/yandexcloud-vdi-agent/install.sh > desktop-agent-install.sh
    chmod +x desktop-agent-install.sh
    ./desktop-agent-install.sh -i ${WORKDIR}
    sudo mkdir -p /opt/yandex-cloud/cloud-desktops
    sudo rm -rf /opt/yandex-cloud/cloud-desktops/desktopagent
    sudo cp ${WORKDIR}/bin/desktopagent /opt/yandex-cloud/cloud-desktops/
    sudo chown root:root /opt/yandex-cloud/cloud-desktops/desktopagent
    sudo chmod +x /opt/yandex-cloud/cloud-desktops/desktopagent
    ```

1. Включите автозапуск агента при загрузке ОС виртуальной машины.

    Пример включения автозапуска для ОС с init-системой SystemD (Ubuntu, Debian, CentOS, Fedora, openSUSE и других):

    ```bash
    sudo cat >/etc/systemd/system/desktop-agent.service <<EOF
    [Unit]
    Description=Yandex Cloud Desktop Agent
    Wants=networking.service
    After=networking.service cloud-init.service

    ConditionFileIsExecutable=/opt/yandex-cloud/cloud-desktops/desktopagent

    [Service]
    Type=simple
    ExecStart=/opt/yandex-cloud/cloud-desktops/desktopagent start --log-level debug
    Restart=always
    RestartSec=30

    [Install]
    WantedBy=multi-user.target cloud-init.target
    EOF

    sudo systemctl daemon-reload
    sudo systemctl enable desktop-agent.service
    ```


1. Перед созданием образа загрузочного диска очистите ОС ВМ от ненужных данных. Например, в дистрибутивах с менеджером пакетов `apt` можно очистить кеш:

    ```bash
    sudo apt-get clean
    ```

1. Создайте образ из диска ВМ:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. Напротив вашей ВМ нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.common.stop }}**.
      1. На панели слева выберите ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.disks_ddfdb }}**.
      1. В строке с загрузочным диском ВМ нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.compute.disks.button_action-image }}**.
      1. Введите имя образа и при необходимости произвольное описание.
      1. Нажмите **{{ ui-key.yacloud.common.create }}**.

    {% endlist %}

1. Добавьте образ в {{ cloud-desktop-name }}:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
      1. На панели слева выберите ![image](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.vdi.label_desktop-images }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.vdi.button_add-image }}**.
      1. В поле **{{ ui-key.yacloud.vdi.label_image-source }}** выберите `{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}`.
      1. В поле **{{ ui-key.yacloud.vdi.label_image }}** выберите образ, созданный ранее.
      1. Введите имя образа.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

    {% endlist %}

После создания образа вы сможете использовать его как образ загрузочного диска для групп рабочих столов.

Если образ и ВМ больше не нужны, удалите их, чтобы не платить за их использование:

* [{#T}](../../../compute/operations/vm-control/vm-delete.md)
* [{#T}](../../../compute/operations/image-control/delete.md)