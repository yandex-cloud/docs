---
title: Как начать работать с {{ baremetal-full-name }}
description: Следуя данной инструкции, вы сможете арендовать и настроить свой первый физический сервер в {{ baremetal-full-name }}.
---

# Как начать работать с {{ baremetal-full-name }}

Арендуйте свой первый [физический сервер](./concepts/servers.md) и подключитесь к нему. Все ресурсы арендованного сервера выделяются только вам и могут обеспечить лучшую производительность, чем аналогичная [виртуальная машина](../glossary/vm.md).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Арендуйте сервер {#server-lease}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. {% include [server-lease-step1](../_includes/baremetal/instruction-steps/server-lease-step1.md) %}
  1. {% include [server-lease-step2](../_includes/baremetal/instruction-steps/server-lease-step2.md) %}
  1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-server }}** и в открывшемся окне выберите вариант `{{ ui-key.yacloud.baremetal.servers.ServerConfigPage.ready-configs_ibA3Y }}` и подходящую [конфигурацию](./concepts/server-configurations.md) сервера {{ baremetal-name }}. Например: `BA-i103-S-10G`.

      {% include [server-lease-selecting-the-right-config](../_includes/baremetal/instruction-steps/server-lease-selecting-the-right-config.md) %}

  1. В открывшемся окне с настройками конфигурации сервера:

      1. {% include [server-lease-step4](../_includes/baremetal/instruction-steps/server-lease-step4.md) %}
      1. В поле **{{ ui-key.yacloud.baremetal.field_server-lease-duration }}** выберите [период](./concepts/servers.md#server-lease), на который вы будете арендовать сервер.

          {% note tip %}

          Для первоначального тестирования достаточно арендовать сервер сроком на 1 день или 1 месяц. Если этого времени окажется недостаточно, аренда сервера будет автоматически продлена на следующий период той же продолжительности.

          {% endnote %}
      1. В поле **{{ ui-key.yacloud.baremetal.field_server-count_jPgTg }}** оставьте `1`.
      1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-product }}** выберите вариант `{{ ui-key.yacloud.baremetal.field_choose-marketplace-os }}` и образ с операционной системой `Ubuntu 24.04 LTS`.
      1. В блоке **{{ ui-key.yacloud.baremetal.title_section-disk_9Txqx }}** нажмите кнопку **{{ ui-key.yacloud.baremetal.action_disk-layout-settings }}**, чтобы задать конфигурацию разделов дисковых устройств, имеющихся на сервере.

          В открывшемся окне оставьте параметры разметки дисков по умолчанию или измените их, затем нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
      1. {% include [server-lease-step9-bm](../_includes/baremetal/instruction-steps/server-lease-step9-bm.md) %}
      1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-public-network }}** в поле **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** выберите `{{ ui-key.yacloud.baremetal.label_public-ip-ephemeral }}`.
      1. В блоке **{{ ui-key.yacloud.baremetal.title_server-access }}**:

          {% include [server-lease-access](../_includes/baremetal/server-lease-access.md) %}

      1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-info }}** введите **{{ ui-key.yacloud.baremetal.field_name }}** сервера — `bm-server`.
      1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-server }}**.

{% endlist %}

## Подключитесь к серверу {#server-connect}

{% list tabs group=operating_system %}

- KVM-консоль {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит сервер.
  1. [Перейдите](../console/operations/select-service.md#select-service) в сервис **{{ baremetal-name }}**.
  1. В строке с нужным сервером нажмите значок ![image](../_assets/console-icons/ellipsis.svg) и выберите **KVM-консоль**.

- Linux/macOS {#linux-macos}

  Для подключения к серверу необходимо указать его публичный IP-адрес, который можно узнать в консоли управления, в поле **{{ ui-key.yacloud.baremetal.field_server-public-ip }}** блока **{{ ui-key.yacloud.baremetal.title_section-server-public-network }}** на странице сервера.

  В терминале выполните команду:

  ```bash
  ssh root@<публичный_IP-адрес_сервера>
  ```

  При первом подключении к серверу появится предупреждение о неизвестном хосте:

  ```text
  The authenticity of host '51.250.83.243 (51.250.83.243)' can't be established.
  ED25519 key fingerprint is SHA256:6Mjv93NJDCaf/vu3NYwiLQK4tKI+4cfLtkd********.
  This key is not known by any other names.
  Are you sure you want to continue connecting (yes/no/[fingerprint])?
  ```

  Введите в терминале слово `yes` и нажмите **Enter**.

- Windows 10/11 {#windows}

  Для подключения к серверу необходимо указать его публичный IP-адрес, который можно узнать в консоли управления, в поле **{{ ui-key.yacloud.baremetal.field_server-public-ip }}** блока **{{ ui-key.yacloud.baremetal.title_section-server-public-network }}** на странице сервера.

  Убедитесь, что учетная запись Windows обладает правами на чтение файлов в папке с ключами.

  Для подключения к серверу в командной строке выполните команду:

  ```shell
  ssh root@<публичный_IP-адрес_сервера>
  ```

  При первом подключении к серверу появится предупреждение о неизвестном хосте:

  ```text
  The authenticity of host '89.169.132.223 (89.169.132.223)' can't be established.
  ECDSA key fingerprint is SHA256:DfjfFB+in0q0MGi0HnqLNMdHssLfm1yRanB********.
  Are you sure you want to continue connecting (yes/no/[fingerprint])?
  ```

  Введите в командной строке `yes` и нажмите **Enter**.

- Windows 7/8 {#windows7-8}

  Для подключения к серверу необходимо указать его публичный IP-адрес, который можно узнать в консоли управления, в поле **{{ ui-key.yacloud.baremetal.field_server-public-ip }}** блока **{{ ui-key.yacloud.baremetal.title_section-server-public-network }}** на странице сервера.

  Установите соединение с помощью приложения PuTTY:

  1. Запустите приложение Pageant.
     1. Нажмите правой кнопкой мыши на значок Pageant на панели задач.
     1. В контекстном меню выберите пункт **Add key**.
     1. Выберите сгенерированный PuTTY приватный ключ в формате `.ppk`. Если для ключа задан пароль, введите его.
  1. Запустите приложение PuTTY.
     1. В поле **Host Name (or IP address)** введите публичный IP-адрес сервера, к которому вы хотите подключиться. Укажите порт `22` и тип соединения **SSH**.

        ![ssh_add_ip](../_assets/compute/ssh-putty/ssh_add_ip.png)

     1. Откройте в дереве слева пункт **Connection** → **SSH** → **Auth**.
     1. Установите флаг **Allow agent forwarding**.

        ![ssh_choose_private_key](../_assets/compute/ssh-putty/authentication_parameters.png)

     1. Откройте в дереве слева пункт **Connection** → **SSH** → **Auth** → **Credentials**.
     1. В поле **Private key file for authentication** выберите файл с приватным ключом.

        ![ssh_choose_private_key](../_assets/compute/ssh-putty/ssh_choose_private_key.png)

     1. Вернитесь в меню **Sessions**. В поле **Saved sessions** введите любое название для сессии и нажмите кнопку **Save**. Настройки сессии сохранятся под указанным именем. Вы сможете использовать этот профиль сессии для подключения с помощью Pageant.

        ![ssh_save_session](../_assets/compute/ssh-putty/ssh_save_session.png)

     1. Нажмите кнопку **Open**. Если вы подключаетесь к серверу в первый раз, может появиться предупреждение о неизвестном хосте:

        ![ssh_unknown_host_warning](../_assets/compute/ssh-putty/ssh_unknown_host_warning.png)

        Нажмите кнопку **Accept**. Откроется окно терминала с предложением ввести логин пользователя, от имени которого устанавливается соединение. Введите имя пользователя `root`.

        Если все настроено верно, будет установлено соединение с сервером.

        ![ssh_login](../_assets/compute/ssh-putty/ssh_login.png)

  Если вы сохранили профиль сессии в PuTTY, в дальнейшем для установки соединения можно использовать Pageant:

  1. Нажмите правой кнопкой мыши на значок Pageant на панели задач.
  1. Выберите пункт меню **Saved sessions**.
  1. В списке сохраненных сессий выберите нужную сессию.

{% endlist %}
