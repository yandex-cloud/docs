# Соединение с облачной сетью при помощи OpenVPN

С помощью туннелей на порт TCP или UDP и асимметричного шифрования можно создавать виртуальные сети. [VPN](../../glossary/vpn.md) может быть использован, например, чтобы:

* объединить территориально удаленные сети;
* подключить внештатных сотрудников к офисной сети;
* организовать соединение с шифрованием поверх открытой сети Wi-Fi.

Продукт [OpenVPN Access Server](https://yandex.cloud/ru/marketplace/products/yc/openvpn-access-server) совместим с [открытой версией](https://github.com/OpenVPN) OpenVPN и построен на ее основе. Он предоставляет клиенты для Windows, Mac, Android и iOS, а также позволяет управлять подключениями с помощью веб-интерфейса.

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

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры OpenVPN входят:

* плата за диски и постоянно запущенные виртуальные машины ([тарифы Yandex Compute Cloud](../../compute/pricing.md));
* плата за использование динамического или статического внешнего IP-адреса ([тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md));
* плата за лицензию OpenVPN Access Server (при использовании более двух подключений).

## Создайте подсети и тестовую ВМ {#create-environment}

Для связи облачных ресурсов с интернетом необходимо иметь созданные [сети](../operations/network-create.md) и [подсети](../operations/subnet-create.md).

Создайте тестовую [виртуальную машину](../../compute/operations/vm-create/create-linux-vm.md) без публичного IP-адреса и подключите ее к подсети.

## Запустите сервер VPN {#create-vpn-server}

Создайте ВМ, которая будет шлюзом VPN-подключений:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления](https://console.yandex.cloud) нажмите кнопку **Создать ресурс** и выберите `Виртуальная машина`.
  1. В блоке **Образ загрузочного диска** в поле **Поиск продукта** введите `OpenVPN Access Server` и выберите публичный образ [OpenVPN Access Server](https://yandex.cloud/ru/marketplace/products/yc/openvpn-access-server).
  1. В блоке **Расположение** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой уже находится тестовая ВМ.
  1. В блоке **Диски и файловые хранилища** задайте размер загрузочного [диска](../../compute/concepts/disk.md#disks_types) `20 ГБ`.
  1. В блоке **Вычислительные ресурсы** перейдите на вкладку `Своя конфигурация` и укажите необходимую [платформу](../../compute/concepts/vm-platforms.md), количество vCPU и объем RAM:

      * **Платформа** — `Intel Ice Lake`.
      * **vCPU** — `2`.
      * **Гарантированная доля vCPU** — `100%`.
      * **RAM** — `2 ГБ`.

  1. В блоке **Сетевые настройки**:

      * В поле **Подсеть** выберите сеть и подсеть, к которым нужно подключить ВМ. Если нужной [сети](../concepts/network.md#network) или [подсети](../concepts/network.md#subnet) еще нет, [создайте их](../operations/subnet-create.md).
      * В поле **Публичный IP-адрес** оставьте значение `Автоматически`, чтобы назначить ВМ случайный внешний IP-адрес из пула Yandex Cloud, или выберите статический адрес из списка, если вы зарезервировали его заранее.

          Используйте только статические публичные IP-адреса [из списка](../operations/get-static-ip.md), или [сделайте](../operations/set-static-ip.md) IP-адрес созданной машины статическим. Динамический IP-адрес может измениться после перезагрузки ВМ, и соединения перестанут работать.

      * Если доступен список **Группы безопасности**, выберите [группу безопасности](../concepts/security-groups.md). Если оставить поле пустым, будет назначена [группа безопасности по умолчанию](../concepts/security-groups.md#default-security-group).

  1. В блоке **Доступ** выберите вариант **SSH-ключ** и укажите данные для доступа на ВМ:

      * В поле **Логин** введите имя пользователя. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
      * В поле **SSH-ключ** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../organization/concepts/membership.md).
        
        Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
        
        1. Нажмите кнопку **Добавить ключ**.
        1. Задайте имя SSH-ключа.
        1. Выберите вариант:
        
            * `Ввести вручную` — вставьте содержимое открытого [SSH](../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
            * `Загрузить из файла` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
            * `Сгенерировать ключ` — автоматическое создание пары SSH-ключей.
            
              При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
        
        1. Нажмите кнопку **Добавить**.
        
        SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.

  1. В блоке **Общая информация** задайте имя ВМ: `vpn-server`.
  1. Нажмите кнопку **Создать ВМ**.
  1. Появится окно с информацией о типе тарификации: BYOL (Bring Your Own License). Нажмите кнопку **Создать**.

{% endlist %}

## Настройте разрешения сетевого трафика {#network-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

  [Группы безопасности](../concepts/security-groups.md) работают как виртуальный брандмауэр для входящего и исходящего трафика. Смотрите подробнее о [группе безопасности по умолчанию](../concepts/security-groups.md#default-security-group).
  1. Для работы OpenVPN Access Server [добавьте](../operations/security-group-add-rule.md) следующие правила в группу безопасности по умолчанию:

     Направление<br>трафика | Описание | Диапазон портов | Протокол | Источник | CIDR блоки
     --- | --- | --- | --- | --- | ---
     Входящий | `VPN Server` | `443` | `TCP` | `CIDR` | `0.0.0.0/0`
     Входящий | `VPN Server` | `1194` | `UDP` | `CIDR` | `0.0.0.0/0`
     Входящий | `Admin Web UI,`</br>`Client Web UI` | `943` | `TCP` | `CIDR` | `0.0.0.0/0`

     Сервер VPN способен перенаправлять трафик с порта `HTTPS`, поэтому при необходимости оставьте открытым единственный порт `TCP 443`. Смотрите также настройки на вкладке **Configuration** → **Network Settings** в административной панели сервера.

  1. Если вы настроили собственную группу безопасности, убедитесь, что в ней разрешен трафик между сервером VPN и требуемыми ресурсами. Например, они находятся в одной группе безопасности и создано [правило Self](../concepts/security-groups.md#rules-types) для всей группы.

{% endlist %}

## Получите пароль администратора {#get-admin-password}

На сервере OpenVPN заранее создан пользователь `openvpn` с административными правами. Пароль генерируется автоматически при создании [виртуальной машины](../../compute/concepts/vm.md).

Получите пароль в [выводе последовательного порта](../../compute/operations/vm-info/get-serial-port-output.md) или в серийной консоли. Пароль отобразится в строке:

```text
To login please use the "openvpn" account with <пароль> password.
```

Где `<пароль>` — пароль пользователя `openvpn`.

Для первого входа в административную панель используйте логин `openvpn` и полученный пароль.

Если вы не получили пароль после первого [запуска сервера VPN](#create-vpn-server), необходимо заново создать ВМ с [OpenVPN Access Server](https://yandex.cloud/ru/marketplace/products/yc/openvpn-access-server). При перезапусках пароль не отображается.

## Активируйте лицензию {#get-license}

{% note info %}

Если у вас до двух VPN-подключений, используйте продукт бесплатно (активация не требуется).

{% endnote %}

Чтобы активировать лицензию:

1. Создайте учетную запись на [сайте openvpn.net](https://myaccount.openvpn.com/signup).
1. Введите код подтверждения, полученный по электронной почте.
1. В окне **Where would you like to Go?** отметьте опцию **Remember my choice** и выберите продукт **Access server**.
1. В окне **Tell us more** выберите назначение: **Business use** или **Personal Use**.
1. На вкладке **Subscriptions** выберите максимальное количество подключений в поле **How many VPN connections do you need?** и нажмите кнопку **Create**.
1. На экране отобразится ваша подписка: **Subscription 1**.
1. Чтобы скопировать ключ активации, нажмите кнопку **Copy Key** в блоке **Subscription Key**.

Дождитесь перехода ВМ в статус `RUNNING` и введите ключ активации в административной панели по адресу `https://<публичный_IP-адрес_ВМ>/admin/`. 

Публичный IP-адрес ВМ можно узнать в [консоли управления](https://console.yandex.cloud) в поле **Публичный IPv4-адрес** блока **Сеть** на странице ВМ.

## Создайте пользователя OpenVPN {#configure-openvpn}

OpenVPN Access Server предоставляет два веб-интерфейса:

1. **Client Web UI** по адресу `https://<публичный_IP-адрес_ВМ>/`. Интерфейс предназначен для входа обычных пользователей, скачивания клиентских программ и профилей конфигурации.
1. **Admin Web UI** по адресу `https://<публичный_IP-адрес_ВМ>/admin/`. Интерфейс предназначен для настройки сервера.

{% note info %}

По умолчанию на сервер установлен самоподписанный сертификат. Если вам необходимо поменять сертификат, воспользуйтесь [инструкцией](https://openvpn.net/vpn-server-resources/installing-a-valid-ssl-web-certificate-in-access-server/).

{% endnote %}

Чтобы создать пользователя, войдите в административную панель:

1. Откройте в браузере URL вида `https://<публичный_IP-адрес_ВМ>/admin/`.
1. Введите имя пользователя `openvpn` и пароль (смотрите раздел [про получение пароля администратора](#get-admin-password)).
1. Ознакомьтесь с лицензионным соглашением и нажмите кнопку **Agree**. Откроется главный экран административной панели OpenVPN.
1. Разверните вкладку **User management** и выберите пункт **User permissions**.
1. В списке пользователей в поле **New Username** введите имя нового пользователя. Например: `test-user`.
1. В столбце **More Settings** нажмите значок карандаша и в поле **Password** введите пароль нового пользователя.
1. Нажмите кнопку **Save settings**.
1. Нажмите кнопку **Update running server**.

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
* Если вы зарезервировали публичный статический IP-адрес, [удалите его](../operations/address-delete.md).

#### Полезные ссылки {#see-also}

* [OpenVPN Project Wiki](https://community.openvpn.net/openvpn/wiki)
* [Получить содержимое сертификата от Let's Encrypt](../../certificate-manager/operations/managed/cert-get-content.md)
* [Connecting to Access Server](https://openvpn.net/vpn-server-resources/connecting-to-access-server-with-linux/#openvpn-open-source-openvpn-cli-program)