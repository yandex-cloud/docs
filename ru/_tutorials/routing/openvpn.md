---
title: "OpenVPN. Создание VPN-соединения"
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

1. На странице каталога в [консоли управления]({{ link-console-main }}) в правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}**.
1. Выберите пункт **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
1. Укажите имя виртуальной машины: `vpn-server` и описание ВМ.
1. Выберите [зону доступности](../../overview/concepts/geo-scope.md), где уже находится тестовая ВМ.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** и выберите образ [OpenVPN Access Server](/marketplace/products/yc/openvpn-access-server).
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** укажите размер диска — `10 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:

     * Выберите [платформу](../../compute/concepts/vm-platforms.md) Intel Ice Lake.
     * Укажите необходимое количество vCPU и объем RAM:

       * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `2`.
       * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `2 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

   * Выберите нужную сеть, подсеть и назначьте ВМ публичный IP-адрес из списка или автоматически.

     Используйте только статические публичные IP-адреса [из списка](../../vpc/operations/get-static-ip), или [сделайте](../../vpc/operations/set-static-ip) IP-адрес созданной машины статическим. Динамический IP-адрес может измениться после перезагрузки ВМ, и соединения перестанут работать.

   * Если доступен список **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}**, выберите [группу безопасности](../../vpc/concepts/security-groups.md). Если оставить поле пустым, будет назначена [группа безопасности по умолчанию](../../vpc/concepts/security-groups.md#default-security-group).

1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа на ВМ:

   * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя [SSH](../../glossary/ssh-keygen.md), например, `yc-user`.
   * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла открытого ключа.

     Пару ключей для подключения по [SSH](../../glossary/ssh-keygen.md) необходимо создать самостоятельно, см. раздел [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.
1. Появится окно с информацией о типе тарификации: BYOL (Bring Your Own License). Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% include [openvpn-network-settings](../_tutorials_includes/openvpn-network-settings.md) %}

{% include [openvpn-get-admin-password](../_tutorials_includes/openvpn-get-admin-password.md) %}

## Активируйте лицензию {#get-license}

{% note info %}

Если у вас до двух VPN-подключений, используйте продукт бесплатно (активация не требуется).

{% endnote %}

Чтобы активировать лицензию:

1. Создайте учетную запись на [сайте openvpn.net](https://myaccount.openvpn.com/signup).
1. Введите код подверждения, полученный по электронной почте.
1. В окне **Where would you like to Go?** отметьте опцию **Remember my choice** и выберите продукт **Access server**.
1. В окне **Tell us more** выберите назначение: **Business use** или **Personal Use**.
1. На вкладке **Subscriptions** выберите максимальное количество подключений в поле **How many VPN connections do you need?** и нажмите кнопку **Create**.
1. На экране отобразится ваша подписка: **Subscription 1**.
1. Чтобы скопировать ключ активации, нажмите кнопку **Copy Key** в блоке **Subscription Key**.

Дождитесь перехода ВМ в статус `RUNNING` и введите ключ активации в административной панели по адресу `https://<публичный IP-адрес ВМ>/admin/`.

## Создайте пользователя OpenVPN {#configure-openvpn}

OpenVPN Access Server предоставляет два веб-интерфейса:

1. Client Web UI по адресу `https://<публичный_IP-адрес_ВМ>/`. Интерфейс предназначен для входа обычных пользователей, скачивания клиентских программ и профилей конфигурации.
1. Admin Web UI по адресу `https://<публичный_IP-адрес_ВМ>/admin/`. Интерфейс предназначен для настройки сервера.

{% note info %}

По умолчанию на сервер установлен самоподписанный сертификат. Если вам необходимо поменять сертификат, воспользуйтесь [инструкцией](https://openvpn.net/vpn-server-resources/installing-a-valid-ssl-web-certificate-in-access-server/).

{% endnote %}

Чтобы создать пользователя, войдите в административную панель:

1. Откройте в браузере URL вида `https://<публичный_IP-адрес_ВМ>/admin/`.
1. Введите имя пользователя `openvpn` и пароль (см. раздел [про получение админского пароля](#get-admin-password)).
1. Нажмите кнопку **Agree**. Откроется главный экран административной панели OpenVPN.
1. Разверните вкладку **User management** и выберите пункт **User permissions**.
1. В списке пользователей введите имя нового пользователя в поле **New Username**, например `test-user`.
1. Нажмите значок карандаша в столбце **More Settings** и в поле **Password** введите пароль нового пользователя.
1. Нажмите кнопку **Save settings**.
1. Нажмите кнопку **Update running server**.

## Подключитесь к VPN {#test-vpn}

В панели пользователя можно загрузить [OpenVPN Connect](https://openvpn.net/vpn-client/) для Windows, Linux, MacOS, Android, iOS. Также для подключения можно использовать [OpenSource-клиенты](https://openvpn.net/source-code/).
 
Чтобы убедиться, что соединение устанавливается и работает, подключитесь к VPN и выполните команду `ping` для внутреннего адреса тестовой ВМ:

{% list tabs %}

- Linux

   1. Установите `openvpn` с помощью менеджера пакетов:

      ```
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

      ```
      scp profile-1.ovpn user@<IP-адрес>:~
      ```

   1. Переместите профиль конфигурации в каталог `/etc/openvpn`:
      ```
      sudo mv /home/user/profile-1.ovpn /etc/openvpn
      ```

   1. Поменяйте расширение файла `ovpn` на `conf`:
      ```
      sudo mv /etc/openvpn/profile-1.ovpn /etc/openvpn/profile-1.conf
      ```

   1. Закройте доступ к файлу:
      ```
      sudo chown root:root /etc/openvpn/profile-1.conf
      sudo chmod 600 /etc/openvpn/profile-1.conf
      ```

   1. VPN-соединение включится автоматически после перезагрузки. Чтобы запустить вручную, выполните команду:
      ```
      sudo openvpn --config /etc/openvpn/profile-1.conf
      ```
      Результат:
      ```
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
      ```
      sudo ping <внутренний_IP-адрес_тестовой_ВМ>
      ```
      Если команда выполняется, доступ к ВМ через VPN есть.

   1. Чтобы прервать подключение, установленное вручную, нажмите  **Ctrl** + **C**.

- Windows

   1. Скачайте дистрибутив для установки:

      * Откройте в браузере панель пользователя по адресу `https://<публичный_IP-адрес_ВМ>/`.
      * Войдите с помощью логина `test-user` и пароля.
      * Скачайте дистрибутив OpenVPN Connect версии 2 или версии 3, нажав на значок Windows.

   1. Установите и запустите OpenVPN Connect.

   1. VPN-соединение включится автоматически, если в профиле пользователя разрешен автоматический вход.

   1. В приложение можно импортировать новый профиль конфигурации. Для этого укажите адрес `https://<публичный_IP-адрес_ВМ>/` или выберите файл с профилем.

   1. Откройте терминал и выполните команду `ping <внутренний_IP-адрес_тестовой_ВМ>`. Если команда выполняется, доступ к ВМ через VPN есть.

- MacOS

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


