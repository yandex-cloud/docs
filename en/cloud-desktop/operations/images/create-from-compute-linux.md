---
title: How to create an image from a {{ compute-full-name }} Linux instance in {{ cloud-desktop-full-name }}
description: In this tutorial, you will create an image from a Linux instance.
---

# Creating an image from a {{ compute-name }} Linux instance

In {{ cloud-desktop-name }}, you can create desktops from pre-installed [system images](../../concepts/images.md) or your own [custom images](../../concepts/images.md#custom-images).

Currently, you can add a Linux-based image. Later on, we are going to add support for Windows images.

A custom image is created from a {{ compute-name }} [instance](../../../compute/concepts/vm.md).

To add a custom image to {{ cloud-desktop-name }}:

1. [Create](../../../compute/operations/vm-create/create-linux-vm.md) or select a previously created VM instance with the following parameters:
   * Access: Via an **SSH key**. {{ cloud-desktop-name }} does not support access via OS Login.
   * Connecting to the internet to install additional software.

1. Configure the instance to create the image you need.
1. Configure remote [RDP](https://ru.wikipedia.org/wiki/Remote_Desktop_Protocol) access:
   1. Install `xrdp` and `xorgxrdp` or other relevant software.
   1. Install system audio management packages to enable audio and a microphone. For example, install `pipewire-module-xrdp` or `pulseaudio-module-xrdp` for `xrdp`.
   
    Example of RDP and audio configuration for Debian 12:

    ```bash
    sudo apt-get update
    sudo apt-get install -y xfce4 pipewire pipewire-pulse xorgxrdp xrdp pipewire-module-xrdp
    sudo systemctl enable xrdp
    sudo systemctl enable xrdp-sesman
    ```

1. Set the incoming connections on all network interfaces for:
   * RDP: To TCP port `3389`.
   * {{ yandex-cloud }} Desktop Agent: To TCP port `5050`.

1. Check VM availability over RDP.

1. Install the {{ cloud-desktop-full-name }} agent for Linux using the following series of commands:
  
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

1. Enable agent autorun on VM OS boot.

    Example of enabling autorun for an OS with the SystemD init system (Ubuntu, Debian, CentOS, Fedora, openSUSE, other):

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

1. Reboot the VM and make sure the agent starts automatically.
   
    Example of checking autorun for an OS with the SystemD init system:

   1. Run this command:
    
      ```bash
      sudo systemctl status desktop-agent-updater
      ```

    1. Make sure the command output contains `Active: active (running)` or `Active: activating (auto-restart)`.

1. Before creating a boot disk image, clean the instance’s OS from the data you do not need. For example, in distributions with the `apt` package manager, you can clear the cache:

    ```bash
    sudo apt-get clean
    ```

1. Create an image from the instance's disk.

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. Next to your instance, click ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.common.stop }}**.
      1. In the left-hand panel, select ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.switch_disks }}**.
      1. In the line with the instance boot disk, click ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.compute.disks.button_action-image }}**.
      1. Enter the image name and give some description, if needed.
      1. Click **{{ ui-key.yacloud.common.create }}**.

    {% endlist %}

1. Add the image to {{ cloud-desktop-name }}:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
      1. In the left-hand panel, select ![image](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.vdi.label_desktop-images }}**.
      1. Click **{{ ui-key.yacloud.vdi.button_add-image }}**.
      1. In the **{{ ui-key.yacloud.vdi.label_image-source }}** field, select `{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}`.
      1. In the **{{ ui-key.yacloud.vdi.label_image }}** field, select the previously created image.
      1. Enter a name for the image.
      1. Click **{{ ui-key.yacloud.common.add }}**.

    {% endlist %}

Once the image is created, you can use it as a boot disk image for desktop groups.

If you no longer need the image and the instance, delete them to avoid paying for them:

* [{#T}](../../../compute/operations/vm-control/vm-delete.md)
* [{#T}](../../../compute/operations/image-control/delete.md)