---
title: How to create an image from a {{ compute-full-name }} Linux instance in {{ cloud-desktop-full-name }}
description: Follow this guide to create an image from a Linux instance.
---

# Creating an image from a {{ compute-name }} Linux instance

In {{ cloud-desktop-name }}, you can create desktops from pre-installed [system images](../../concepts/images.md) or your own [custom images](../../concepts/images.md#custom-images).

Custom images can be [Windows](create-from-windows.md) or Linux-based.

A Linux image is created from a {{ compute-name }} [instance](../../../compute/concepts/vm.md).

To add a custom Linux image to {{ cloud-desktop-name }}:

1. [Create](../../../compute/operations/vm-create/create-linux-vm.md) or select a previously created VM instance with the following parameters:
   * Access: Via an **SSH key**. {{ cloud-desktop-name }} does not support {{ oslogin }} access.
   * Connecting to the internet to install additional software.

1. Configure the instance to create the image you need.
1. Configure remote [RDP](https://ru.wikipedia.org/wiki/Remote_Desktop_Protocol) access:
   1. Install `xrdp` and `xorgxrdp` or other relevant software.
   
        {% note info %}
        
        {{ cloud-desktop-name }} connects to a remote desktop over IPv6 using port `3389`. Make sure `xrdp` supports IPv6. To do it, after you install `xrdp`, check that it listens IPv6 addresses, e.g., by running `netstat -tulpn | grep xrdp`. The command output should contain IPv6 addresses, e.g., `::1` or `:::3389`. If there are none, set up IPv6 in the `/etc/xrdp/xrdp.ini` configuration file.

        {% endnote %}

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


1. Before creating a boot disk image, clean the instance’s OS from the data you do not need. For example, in distributions with the `apt` package manager, you can clear the cache:

    ```bash
    sudo apt-get clean
    ```

1. Create an image from the instance's disk.

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. Next to your instance, click ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.common.stop }}**.
      1. In the left-hand panel, select ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.disks_ddfdb }}**.
      1. In the line with the instance boot disk, click ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.compute.disks.button_action-image }}**.
      1. Enter a name for the image and provide some description, if needed.
      1. Click **{{ ui-key.yacloud.common.create }}**.

    {% endlist %}

1. Add this image to {{ cloud-desktop-name }}:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
      1. In the left-hand panel, select ![image](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.vdi.label_desktop-images }}**.
      1. Click **{{ ui-key.yacloud.vdi.button_add-image }}**.
      1. In the **{{ ui-key.yacloud.vdi.label_image-source }}** field, select `{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}`.
      1. In the **{{ ui-key.yacloud.vdi.label_image }}** field, select the previously created image.
      1. Specify the image name.
      1. Click **{{ ui-key.yacloud.common.add }}**.

    {% endlist %}

Once the image is created, you can use it as a boot disk image for desktop groups.

If you no longer need the image and the instance, delete them to avoid paying for them:

* [{#T}](../../../compute/operations/vm-control/vm-delete.md)
* [{#T}](../../../compute/operations/image-control/delete.md)
