---
title: Подключение к серийной консоли ВМ с операционной системой Windows
description: Следуя данной инструкции, вы научитесь подключаться к серийной консоли виртуальной машины {{ compute-full-name }} под управлением операционной системы Windows с использованием Windows SAC.
---

# Подключиться к серийной консоли виртуальной машины с ОС Windows

{% include [sc-warning](../../../_includes/compute/serial-console-warning.md) %}

Чтобы подключиться к [серийной консоли](../../concepts/serial-console.md) ВМ, для этой виртуальной машины необходимо предварительно [разрешить доступ](./index.md#enable) к серийной консоли.

## Подключитесь к Windows SAC {#sac-connect}

К серийной консоли виртуальной машины под управлением операционной системы Windows вы можете подключиться с помощью [консоли управления]({{ link-console-main }}) или [{{ yandex-cloud }} CLI](../../../cli/index.yaml), запустив командную оболочку в Windows SAC:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится виртуальная машина.
  1. Перейдите в сервис **{{ compute-name }}**.
  1. На панели слева выберите ![server](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}** и в открывшемся списке выберите нужную виртуальную машину.
  1. В меню слева выберите **{{ ui-key.yacloud.compute.instance.switch_console }}**.
  1. В верхней части экрана в раскрывающемся списке выберите [последовательный порт](../../concepts/serial-console.md#serial-ports), используемый серийной консолью для подключения к ВМ.

      {% include [serial-console-default-port-win](../../../_includes/compute/serial-console-default-port-win.md) %}

- CLI {#cli}

  1. Убедитесь, что на вашем компьютере установлен и настроен интерфейс [{{ yandex-cloud }} CLI](../../../cli/index.yaml).

      {% include [cli-install](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для подключения к серийной консоли:

      ```bash
      yc compute connect-to-serial-port --help
      ```
  1. Включите авторизацию по метаданным при подключении к серийной консоли, указав в команде имя или идентификатор виртуальной машины:
  
      ```bash
      yc compute instance update <имя_или_идентификатор_ВМ> \
        --serial-port-settings ssh-authorization=INSTANCE_METADATA
      ```
      
      О том, как узнать имя или идентификатор ВМ, читайте в разделе [{#T}](../vm-info/get-info.md).
      
      Результат:
      
      ```yaml
      done (6s)
      id: fhm0b28lgfp4********
      folder_id: b1g9d2k0itu4********
      created_at: "2024-03-28T19:53:23Z"
      name: first-instance
      zone_id: {{ region-id }}-a
      platform_id: standard-v3
      resources:
        memory: "1073741824"
        cores: "2"
        core_fraction: "20"
      status: RUNNING
      metadata_options:
        gce_http_endpoint: ENABLED
        aws_v1_http_endpoint: ENABLED
        gce_http_token: ENABLED
        aws_v1_http_token: DISABLED
      boot_disk:
        mode: READ_WRITE
        device_name: epdu3ce920e7********
        auto_delete: true
        disk_id: epdu3ce920e7********
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:5c:**:**:**
          subnet_id: e2luhnr3rhf8********
          primary_v4_address:
            address: 192.168.1.21
            one_to_one_nat:
              address: 51.250.***.***
              ip_version: IPV4
          security_group_ids:
            - enpjauvetqfb********
      serial_port_settings:
        ssh_authorization: INSTANCE_METADATA
      gpu_settings: {}
      fqdn: sample-vm.{{ region-id }}.internal
      scheduling_policy:
        preemptible: true
      network_settings:
        type: STANDARD
      placement_policy: {}
      hardware_generation:
        legacy_features:
          pci_topology: PCI_TOPOLOGY_V1
      ```
      
      {% note info %}
      
      {% include [serial-port-settings-default](../../../_includes/compute/serial-port-settings-default.md) %}
      
      {% endnote %}

  1. Подключитесь к Windows SAC виртуальной машины:

      ```bash
      yc compute connect-to-serial-port \
        --instance-name <имя_ВМ> \
        --port 2
      ```

      Где:
      * `--instance-name` — имя виртуальной машины. Вместо имени ВМ можно передать ее идентификатор в параметре `--instance-id`.
      * `--port` — номер [последовательного порта](../../concepts/serial-console.md#serial-ports), используемого серийной консолью для подключения к ВМ.

          {% include [serial-console-default-port-win](../../../_includes/compute/serial-console-default-port-win.md) %}

      Подробнее о команде `yc compute connect-to-serial-port` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/connect-to-serial-port.md).

{% endlist %}

В результате откроется оболочка Windows SAC.

## Запустите оболочку командной строки {#load-commandline}

Чтобы получить доступ к данным и настройкам виртуальной машины, запустите оболочку командной строки:

1. В открывшемся окне серийной консоли отобразится приглашение для ввода команд:

    ```bash
    SAC>
    ```
1. Просмотрите список открытых каналов:

    ```bash
    ch
    ```

    Результат:

    ```text
    Channel List

    (Use "ch -?" for information on using channels)

    # Status  Channel Name
    0 (AV)    SAC
    ```
1. Создайте новый канал с экземпляром командной оболочки `CMD`:

    ```bash
    cmd
    ```

    Результат:

    ```text
    The Command Prompt session was successfully launched.
    SAC>
    EVENT:   A new channel has been created.  Use "ch -?" for channel help.
    Channel: Cmd0001
    ```
1. Чтобы перейти к созданному каналу, нажмите сочетание клавиш **ESC** + **TAB** или выполните команду:

    ```bash
    ch -sn Cmd0001
    ```

    Результат:

    ```text
    Name:                  Cmd0001
    Description:           Command
    Type:                  VT-UTF8
    Channel GUID:          e203fb79-d80d-11ea-87e3-c2679e14957d
    Application Type GUID: 63d02271-8aa4-11d5-bccf-00b0d014a2d0

    Press <esc><tab> for next channel.
    Press <esc><tab>0 to return to the SAC channel.
    Use any other key to view this channel.
    ```
1. Нажмите **Enter**, затем последовательно введите:
    - Имя пользователя.
    - Домен, если вход выполняется доменной учетной записью. Иначе введите имя хоста либо оставьте пустым.
    - Пароль.

    ```bash
    Please enter login credentials.
    Username: Administrator
    Domain  :
    Password: ***************
    ```

    В результате запустится экземпляр оболочки командной строки `CMD`:

    ```bash
    C:\Windows\system32>
    ```
1. Чтобы запустить экземпляр PowerShell, выполните команду:

    ```bash
    powershell
    ```

    Результат:

    ```text
    Windows PowerShell
    Copyright (C) Microsoft Corporation. All rights reserved.

    PS C:\Windows\system32>
    ```

    {% note tip %}

    Для ввода текста на английском языке при использовании PowerShell в серийной консоли настройте языковые параметры Windows:

    Перейдите в **Control Panel** → **Region** → **Administrative** → **Welcome screen and new user accounts settings**. В блоке **Welcome Screen** установите:
    * `Display Language` — `English (United States)`.
    * `Input Language` — `English (United States) — US`.

    {% endnote %}

1. Чтобы вернуться в интерфейс SAC, нажмите сочетание клавиш **ESC** + **TAB** + **0**.

{% note warning %}

{% include [disable-serial-console-tip](../../../_includes/compute/disable-serial-console-tip.md) %}

{% endnote %}

#### См. также {#see-also}

* [{#T}](../../concepts/serial-console.md)
* [{#T}](./index.md)
* [{#T}](./connect-ssh.md)
