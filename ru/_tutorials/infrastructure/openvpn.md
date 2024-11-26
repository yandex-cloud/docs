---
title: OpenVPN. Создание VPN-соединения
keywords:
  - openvpn
  - openvpn настроить
  - open vpn
  - vpn server setup
  - vpn connection
  - vpn соединение
---

# Соединение с облачной сетью при помощи OpenVPN

С помощью туннелей на порт TCP или UDP и асимметричного шифрования можно создавать виртуальные сети. [VPN](../../glossary/vpn.md) может быть использован, например, чтобы:

* объединить территориально удаленные сети;
* подключить внештатных сотрудников к офисной сети;
* организовать соединение с шифрованием поверх открытой сети Wi-Fi.

Продукт [OpenVPN Access Server](/marketplace/products/yc/openvpn-access-server) совместим с [открытой версией](https://github.com/OpenVPN) OpenVPN и построен на ее основе. Он предоставляет клиенты для Windows, Mac, Android и iOS, а также позволяет управлять подключениями с помощью веб-интерфейса.

Ниже показан пример настройки автоподключения, а также по логину и паролю. Чтобы создать виртуальную сеть:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте подсети и тестовую ВМ](#create-environment).
1. [Запустите сервер VPN](#create-vpn-server).
1. [Настройте разрешения сетевого трафика](#network-settings).
1. [Получите пароль администратора](#get-admin-password).
1. [Активируйте лицензию](#get-license).
1. [Создайте пользователя OpenVPN](#configure-openvpn).
1. [Подключитесь к VPN](#test-vpn).

Если сервер VPN больше не нужен, [удалите ВМ](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры OpenVPN входят:

* плата за диски и постоянно запущенные виртуальные машины (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование динамического или статического внешнего IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md));
* плата за лицензию OpenVPN Access Server (при использовании более двух подключений).


## Создайте подсети и тестовую ВМ {#create-environment}

Для связи облачных ресурсов с интернетом необходимо иметь созданные [сети](../../vpc/operations/network-create.md) и [подсети](../../vpc/operations/subnet-create.md).

Создайте тестовую [виртуальную машину](../../compute/operations/vm-create/create-linux-vm.md) без публичного IP-адреса и подключите ее к подсети.

## Запустите сервер VPN {#create-vpn-server}

Создайте ВМ, которая будет шлюзом VPN-подключений:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления]({{ link-console-main }}) нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.  
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** в поле **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** введите `OpenVPN Access Server` и выберите публичный образ [OpenVPN Access Server](/marketplace/products/yc/openvpn-access-server).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой уже находится тестовая ВМ.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** задайте размер загрузочного [диска](../../compute/concepts/disk.md#disks_types) `20 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** перейдите на вкладку `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` и укажите необходимую [платформу](../../compute/concepts/vm-platforms.md), количество vCPU и объем RAM:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Ice Lake`.
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `2`.
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `100%`.
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `2 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите сеть и подсеть, к которым нужно подключить ВМ. Если нужной [сети](../../vpc/concepts/network.md#network) или [подсети](../../vpc/concepts/network.md#subnet) еще нет, [создайте их](../../vpc/operations/subnet-create.md).
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** оставьте значение `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`, чтобы назначить ВМ случайный внешний IP-адрес из пула {{ yandex-cloud }}, или выберите статический адрес из списка, если вы зарезервировали его заранее.

          Используйте только статические публичные IP-адреса [из списка](../../vpc/operations/get-static-ip), или [сделайте](../../vpc/operations/set-static-ip) IP-адрес созданной машины статическим. Динамический IP-адрес может измениться после перезагрузки ВМ, и соединения перестанут работать.

      * Если доступен список **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}**, выберите [группу безопасности](../../vpc/concepts/security-groups.md). Если оставить поле пустым, будет назначена [группа безопасности по умолчанию](../../vpc/concepts/security-groups.md#default-security-group).

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа на ВМ:

      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `vpn-server`.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.
  1. Появится окно с информацией о типе тарификации: BYOL (Bring Your Own License). Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Настройте разрешения сетевого трафика {#network-settings}

{% include [openvpn-network-settings](../_tutorials_includes/openvpn-network-settings.md) %}

## Получите пароль администратора {#get-admin-password}

{% include [openvpn-get-admin-password](../_tutorials_includes/openvpn-get-admin-password.md) %}

## Активируйте лицензию {#get-license}

{% include [openvpn-activate-license](../_tutorials_includes/openvpn-activate-license.md) %}

## Создайте пользователя OpenVPN {#configure-openvpn}

{% include [openvpn-create-user](../_tutorials_includes/openvpn-create-user.md) %}

## Подключитесь к VPN {#test-vpn}

В панели пользователя можно загрузить [OpenVPN Connect](https://openvpn.net/vpn-client/) для Windows, Linux, MacOS, Android, iOS. Также для подключения можно использовать [OpenSource-клиенты](https://openvpn.net/source-code/).
 
Чтобы убедиться, что соединение устанавливается и работает, подключитесь к VPN и выполните команду `ping` для внутреннего адреса тестовой ВМ:

{% list tabs group=operating_system %}

- Linux {#linux}

   1. Установите `openvpn` с помощью менеджера пакетов:

      ```bash
      sudo apt update && sudo apt install openvpn
      ```

   1. Разрешите для пользователя `test-user` автоматическое подключение:

      * Войдите в панель администратора по адресу `https://<публичный_IP-адрес_ВМ>/admin/`.
      * Откройте вкладку **User management** → **User permissions**.
      * Включите опцию **Allow Auto-login** в строке пользователя.

   1. Настройте маршрутизацию:

      * Войдите в панель администратора по адресу `https://<публичный_IP-адрес_ВМ>/admin/`.
      * Откройте вкладку **Configuration** → **VPN Settings**.
      * В блоке **Routing** отключите опцию **Should client Internet traffic be routed through the VPN?**

   1. Скачайте профиль конфигурации:

      * Откройте в браузере панель пользователя по адресу `https://<публичный_IP-адрес_ВМ>/`.
      * Войдите с помощью логина `test-user` и пароля.
      * В блоке **Available Connection Profiles** нажмите **Yourself (autologin profile)** и загрузите файл `profile-1.ovpn`.
      * Также файл конфигурации можно скачать в панели администратора по адресу `https://<<публичный_IP-адрес_ВМ>/admin/`.

   1. Загрузите профиль конфигурации на машину с Linux:

      ```bash
      scp profile-1.ovpn user@<IP-адрес>:~
      ```

   1. Переместите профиль конфигурации в каталог `/etc/openvpn`:

      ```bash
      sudo mv /home/user/profile-1.ovpn /etc/openvpn
      ```

   1. Поменяйте расширение файла `ovpn` на `conf`:

      ```bash
      sudo mv /etc/openvpn/profile-1.ovpn /etc/openvpn/profile-1.conf
      ```

   1. Закройте доступ к файлу:
 
      ```bash
      sudo chown root:root /etc/openvpn/profile-1.conf
      sudo chmod 600 /etc/openvpn/profile-1.conf
      ```

   1. VPN-соединение включится автоматически после перезагрузки. Чтобы запустить вручную, выполните команду:

      ```bash
      sudo openvpn --config /etc/openvpn/profile-1.conf
      ```

      Результат:
   
      ```text
      2022-04-05 15:35:49 DEPRECATED OPTION: --cipher set to 'AES-256-CBC' but missing in --data-ciphers (AES-256-GCM:AES-128-GCM). Future OpenVPN version will ignore --cipher for cipher negotiations. Add 'AES-256-CBC' to --data-ciphers or change --cipher 'AES-256-CBC' to --data-ciphers-fallback 'AES-256-CBC' to silence this warning.
      2022-04-05 15:35:49 OpenVPN 2.5.1 x86_64-pc-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [PKCS11] [MH/PKTINFO] [AEAD] built on May 14 2021
      2022-04-05 15:35:49 library versions: OpenSSL 1.1.1k  25 Mar 2021, LZO 2.10
      2022-04-05 15:35:49 Outgoing Control Channel Encryption: Cipher 'AES-256-CTR' initialized with 256 bit key
      2022-04-05 15:35:49 Outgoing Control Channel Encryption: Using 256 bit message hash 'SHA256' for HMAC authentication
      2022-04-05 15:35:49 Incoming Control Channel Encryption: Cipher 'AES-256-CTR' initialized with 256 bit key
      2022-04-05 15:35:49 Incoming Control Channel Encryption: Using 256 bit message hash 'SHA256' for HMAC authentication
      2022-04-05 15:35:49 TCP/UDP: Preserving recently used remote address: [AF_INET]51.250.25.105:443
      2022-04-05 15:35:49 Socket Buffers: R=[131072->131072] S=[16384->16384]
      2022-04-05 15:35:49 Attempting to establish TCP connection with [AF_INET]51.250.25.105:443 [nonblock]
      ...
      ...
      2022-04-05 15:35:54 Initialization Sequence Completed
      ```

   1. Проверьте работу сети с помощью команды `ping`:

      ```bash
      sudo ping <внутренний_IP-адрес_тестовой_ВМ>
      ```

      Если команда выполняется, доступ к ВМ через VPN есть.

   1. Чтобы прервать подключение, установленное вручную, нажмите  **Ctrl** + **C**.

- Windows {#windows}

   1. Скачайте дистрибутив для установки:

      * Откройте в браузере панель пользователя по адресу `https://<публичный_IP-адрес_ВМ>/`.
      * Войдите с помощью логина `test-user` и пароля.
      * Скачайте дистрибутив OpenVPN Connect версии 2 или версии 3, нажав на значок Windows.

   1. Установите и запустите OpenVPN Connect.

   1. VPN-соединение включится автоматически, если в профиле пользователя разрешен автоматический вход.

   1. В приложение можно импортировать новый профиль конфигурации. Для этого укажите адрес `https://<публичный_IP-адрес_ВМ>/` или выберите файл с профилем.

   1. Откройте терминал и выполните команду `ping <внутренний_IP-адрес_тестовой_ВМ>`. Если команда выполняется, доступ к ВМ через VPN есть.

- macOS {#macos}

   1. Скачайте дистрибутив для установки:

      * Откройте в браузере панель пользователя по адресу `https://<публичный_IP-адрес_ВМ>/`.
      * Войдите с помощью логина `test-user` и пароля.
      * Скачайте дистрибутив OpenVPN Connect версии 2 или версии 3, нажав на значок Apple.

   1. Установите и запустите OpenVPN Connect.

   1. VPN-соединение включится автоматически, если в профиле пользователя разрешен автоматический вход.

   1. В приложение можно импортировать новый профиль конфигурации. Для этого укажите адрес `https://<<публичный_IP-адрес_ВМ>/` или выберите файл с профилем.

   1. Откройте терминал и выполните команду `ping <внутренний_IP-адрес_тестовой_ВМ>`. Если команда выполняется, доступ к ВМ через VPN есть.

{% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

* [Удалите](../../compute/operations/vm-control/vm-delete.md) ВМ `vpn-server` и тестовую ВМ.
* Если вы зарезервировали публичный статический IP-адрес, [удалите его](../../vpc/operations/address-delete.md).

#### См. также {#see-also}

* [OpenVPN Project Wiki](https://community.openvpn.net/openvpn/wiki)
* [{#T}](../../certificate-manager/operations/managed/cert-get-content.md)
* [Connecting to Access Server](https://openvpn.net/vpn-server-resources/connecting-to-access-server-with-linux/#openvpn-open-source-openvpn-cli-program)


