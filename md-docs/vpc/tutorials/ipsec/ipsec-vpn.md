# Самостоятельная организация сетевой связности с помощью IPsec-шлюзов средствами Yandex Cloud


Вы можете самостоятельно реализовать защищенное соединение между облачной инфраструктурой и условным корпоративным ЦОД с помощью IPsec-шлюзов по схеме из [подраздела](index.md). Для этого:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Настройте облачную площадку](#cloud-setup).
1. [Настройте удаленную площадку](#remote-setup).
1. [Проверьте работу IPsec-соединения и связность между удаленными и облачными ресурсами](#ipsec-test).

Если созданные ресурсы вам больше не нужны, [удалите](#clear-out) их.

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость развертывания инфраструктуры для данного решения на базе IPsec-шлюзов входят:

* Плата за постоянно запущенные виртуальные машины (см. [тарифы Yandex Compute Cloud](../../../compute/pricing.md)).
* Плата за использование статического внешнего IP-адреса (см. [тарифы Yandex Virtual Private Cloud](../../pricing.md)).

### Создайте пару ключей SSH {#create-ssh-keys}

Чтобы подключаться к [виртуальной машине](../../../compute/concepts/vm.md) по [SSH](../../../glossary/ssh-keygen.md), нужна пара ключей: открытый ключ размещается на ВМ, а закрытый ключ хранится у пользователя. Такой способ более безопасен, чем подключение по логину и паролю.

{% note info %}

В публичных образах Linux, предоставляемых Yandex Cloud, возможность подключения по протоколу SSH с использованием логина и пароля по умолчанию отключена.

{% endnote %}

Чтобы создать пару ключей:

{% list tabs group=operating_system %}

- Linux/macOS {#linux-macos}

  1. Откройте терминал.
  1. Создайте новый ключ с помощью команды `ssh-keygen`:
  
      ```bash
      ssh-keygen -t ed25519 -C "<опциональный_комментарий>"
      ```
  
      Вы можете передать в параметре `-C` пустую строку, чтобы не добавлять комментарий, или не указывать параметр `-C` вообще — в таком случае будет добавлен комментарий по умолчанию.
  
      После выполнения команды вам будет предложено указать имя и путь к файлам с ключами, а также ввести пароль для закрытого ключа. Если задать только имя, пара ключей будет создана в текущей директории. Открытый ключ будет сохранен в файле с расширением `.pub`, закрытый ключ — в файле без расширения.
  
      По умолчанию команда предлагает сохранить ключ под именем `id_ed25519` в директории `/home/<имя_пользователя>/.ssh`. Если в этой директории уже есть SSH-ключ с именем `id_ed25519`, вы можете случайно перезаписать его и потерять доступ к ресурсам, в которых он используется. Поэтому рекомендуется использовать уникальные имена для всех SSH-ключей.

- Windows 10/11 {#windows}

  Если у вас еще не установлен [OpenSSH](https://ru.wikipedia.org/wiki/OpenSSH), установите его по [инструкции](https://learn.microsoft.com/ru-ru/windows-server/administration/openssh/openssh_install_firstuse).
  
  1. Запустите `cmd.exe` или `powershell.exe` (предварительно обновите PowerShell).
  1. Создайте новый ключ с помощью команды `ssh-keygen`:
  
      ```shell
      ssh-keygen -t ed25519 -C "<опциональный_комментарий>"
      ```
  
      Вы можете передать в параметре `-C` пустую строку, чтобы не добавлять комментарий, или не указывать параметр `-C` вообще — в таком случае будет добавлен комментарий по умолчанию.
  
      После выполнения команды вам будет предложено указать имя и путь к файлам с ключами, а также ввести пароль для закрытого ключа. Если задать только имя, пара ключей будет создана в текущей директории. Открытый ключ будет сохранен в файле с расширением `.pub`, закрытый ключ — в файле без расширения.
  
      По умолчанию команда предлагает сохранить ключ под именем `id_ed25519` в папку `C:\Users\<имя_пользователя>/.ssh`. Если в этой директории уже есть SSH-ключ с именем `id_ed25519`, вы можете случайно перезаписать его и потерять доступ к ресурсам, в которых он используется. Поэтому рекомендуется использовать уникальные имена для всех SSH-ключей.

- Windows 7/8 {#windows7-8}

  Создайте ключи с помощью приложения PuTTY:
  
  1. [Скачайте](https://www.putty.org) и установите PuTTY.
  1. Добавьте папку с PuTTY в переменную `PATH`:
  
      1. Нажмите кнопку **Пуск** и в строке поиска Windows введите **Изменение системных переменных среды**.
      1. Справа снизу нажмите кнопку **Переменные среды...**.
      1. В открывшемся окне найдите параметр `PATH` и нажмите **Изменить**.
      1. Добавьте путь к папке в список.
      1. Нажмите кнопку **ОК**.
  
  1. Запустите приложение PuTTYgen.
  1. В качестве типа генерируемой пары выберите **EdDSA**. Нажмите **Generate** и поводите курсором в поле выше до тех пор, пока не закончится создание ключа.
  
      ![ssh_generate_key](../../../_assets/compute/ssh-putty/ssh_generate_key.png)
  
  1. В поле **Key passphrase** введите надежный пароль. Повторно введите его в поле ниже.
  1. Нажмите кнопку **Save private key** и сохраните закрытый ключ. Никому не сообщайте ключевую фразу от него.
  1. Нажмите кнопку **Save public key** и сохраните открытый ключ в файле `<имя_ключа>.pub`.

{% endlist %}

## Настройте облачную площадку {#cloud-setup}

На этом этапе вы зарезервируете два статических IP-адреса для IPsec-шлюзов, а также создадите и настроите инфраструктуру облачной площадки Yandex Cloud: IPsec-шлюз, две виртуальные машины, сеть с двумя подсетями.

### Создайте и настройте облачную сеть {#setup-cloud-net}

#### Зарезервируйте публичные IP-адреса для шлюзов {#reserve-public-ip}

[Зарезервируйте](../../operations/get-static-ip.md) два статических [публичных IP-адреса](../../concepts/address.md#public-addresses) в зоне доступности `ru-central1-b`:

* Адрес основного IPsec-шлюза `cloud-gw` — в дальнейшем будет обозначаться `<x1.x1.x1.x1>`.
* Адрес удаленного IPsec-шлюза `remote-gw` — в дальнейшем будет обозначаться `<x2.x2.x2.x2>`.

#### Создайте сеть и подсети на облачной площадке {#cloud-net}

1. [Создайте сеть](../../operations/network-create.md) с именем `cloud-net`. При создании сети отключите опцию **Создать подсети**.
1. В сети `cloud-net` вручную [создайте подсети](../../operations/subnet-create.md) со следующими параметрами:

    1. Для подключения основного IPsec-шлюза `cloud-gw`:
        * **Имя** — `ipsec-subnet`.
        * **Зона доступности** — `ru-central1-b`.
        * **CIDR** — `172.16.0.0/24`.

    1. Для подключения виртуальной машины `vm-d`:
        * **Имя** — `subnet-d`.
        * **Зона доступности** — `ru-central1-d`.
        * **CIDR** — `172.16.1.0/24`.

    1. Для подключения виртуальной машины `vm-b`:
        * **Имя** — `subnet-b`.
        * **Зона доступности** — `ru-central1-b`.
        * **CIDR** — `172.16.2.0/24`.

#### Создайте и настройте группу безопасности для основного IPsec-шлюза {#cloud-sg}

1. В сети `cloud-net` [создайте группу безопасности](../../operations/security-group-create.md) с именем `cloud-net-sg`.
1. В группе безопасности `cloud-net-sg` [создайте правила](../../operations/security-group-add-rule.md) в соответствии с таблицей:

    | Направление<br/>трафика | Описание | Диапазон портов | Протокол | Источник /<br/>Назначение | CIDR блоки |
    | --- | --- | --- | --- | --- | --- |
    | Исходящий | `any`           | `Весь` | `Любой` | `CIDR` | `0.0.0.0/0` |
    | Входящий | `icmp`           | `Весь` | `ICMP` | `CIDR` | `0.0.0.0/0` |
    | Входящий | `ssh`            | `22`   | `TCP`  | `CIDR` | `0.0.0.0/0` |
    | Входящий | `ipsec-udp-500`  | `500`  | `UDP`  | `CIDR` | `<x2.x2.x2.x2>/32` |
    | Входящий | `ipsec-udp-4500` | `4500` | `UDP`  | `CIDR` | `<x2.x2.x2.x2>/32` |
    | Входящий | `subnet-d`       | `Весь` | `Любой` | `CIDR` | `172.16.1.0/24` |
    | Входящий | `subnet-b`       | `Весь` | `Любой` | `CIDR` | `172.16.2.0/24` |

#### Настройте статическую маршрутизацию для основного IPsec-шлюза {#cloud-static}

1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором создана сеть `cloud-net`.
1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Virtual Private Cloud**.
1. Выберите сеть `cloud-net`.
1. Перейдите на вкладку **Таблицы маршрутизации** и нажмите **Создать**.
1. В поле **Имя** укажите `cloud-net-rt`.
1. В блоке **Статические маршруты** нажмите **Добавить маршрут**.

    1. В открывшемся окне в поле **Префикс назначения** укажите `10.10.0.0/16`.
    1. В поле **IP-адрес** укажите внутренний IP-адрес основного IPsec-шлюза — `172.16.0.10`.
    1. Нажмите **Добавить**.

1. Нажмите **Создать таблицу маршрутизации**.
1. Привяжите таблицу маршрутизации `cloud-net-rt` к подсетям `subnet-d` и `subnet-b`:

    1. Перейдите на вкладку **Обзор**.
    1. В строке подсети `subnet-d` нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Привязать таблицу маршрутизации**.
    1. В открывшемся окне выберите таблицу маршрутизации `cloud-net-rt` и нажмите **Привязать**.
    1. Повторите два предыдущих шага для подсети `subnet-b`, чтобы привязать к ней таблицу маршрутизации `cloud-net-rt`.

### Создайте и настройте виртуальные машины на облачной площадке {#setup-cloud-vms}

#### Создайте ВМ с основным IPsec-шлюзом на облачной площадке {#create-cloud-gw}

1. На странице [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления](https://console.yandex.cloud) нажмите кнопку **Создать ресурс** и выберите `Виртуальная машина`.
1. В блоке **Образ загрузочного диска** в поле **Поиск продукта** введите `IPSec-инстанс` и выберите публичный образ [IPSec-инстанс](https://yandex.cloud/ru/marketplace/products/yc/ipsec-instance-ubuntu).
1. В блоке **Расположение** выберите [зону доступности](../../../overview/concepts/geo-scope.md) `ru-central1-b`, где находится подсеть, к которой будет подключен основной IPsec-шлюз.
1. В блоке **Сетевые настройки**:

    1. В поле **Подсеть** выберите подсеть `ipsec-subnet`.
    1. В поле **Публичный IP-адрес** выберите `Список`.
    1. В открывшемся поле **IP-адрес** выберите публичный IP-адрес `<x1.x1.x1.x1>`, который вы ранее [зарезервировали](#reserve-public-ip).
    1. В поле **Группы безопасности** выберите [ранее созданную](#cloud-sg) группу безопасности `cloud-net-sg`.
    1. Разверните блок **Дополнительно**:

        * В поле **Внутренний IPv4 адрес** выберите `Вручную`.
        * В появившемся поле для ввода укажите `172.16.0.10`.

1. В блоке **Доступ** выберите вариант **SSH-ключ** и укажите данные для доступа на ВМ:

    * В поле **Логин** укажите `ipsec`.
    * В поле **SSH-ключ**:

        * Нажмите кнопку **Добавить ключ**.
        * Задайте имя SSH-ключа.
        * Загрузите или вставьте содержимое [созданного ранее](#create-ssh-keys) публичного SSH-ключа для доступа к ВМ.
        * Нажмите кнопку **Добавить**.

        SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.

1. В блоке **Общая информация** задайте имя ВМ: `cloud-gw`.
1. Нажмите кнопку **Создать ВМ**.

Дождитесь, когда ВМ перейдет в статус `Running`.

#### Настройте основной IPsec-шлюз {#config-cloud-gw}

Для настройки шлюза используйте IP-адреса, имя пользователя и ключ SSH, которые вы указывали при создании виртуальной машины `cloud-gw`.

1. Подключитесь к виртуальной машине по [SSH](../../../glossary/ssh-keygen.md):

    ```bash
    ssh ipsec@<x1.x1.x1.x1>
    ```

1. Задайте параметры даты и времени для ВМ:

    ```bash
    sudo timedatectl set-timezone Europe/Moscow
    sudo timedatectl set-ntp True
    timedatectl
    ```

1. Для оптимальной работы протокола ICMP отключите функциональность `ICMP Redirects` на IPsec-шлюзе:

    ```bash
	  sudo su -c "echo 'net.ipv4.conf.eth0.send_redirects=0' >> /etc/sysctl.conf"
	  sudo su -c "echo 'net.ipv4.conf.default.send_redirects=0' >> /etc/sysctl.conf"
    ```

    Подробнее об этом читайте в [документации strongSwan](https://docs.strongswan.org/docs/5.9/howtos/forwarding.html#_hosts_on_the_lan).

1. Создайте резервную копию файла конфигурации `swanctl.conf`:

    ```bash
    sudo mv /etc/swanctl/swanctl.conf /etc/swanctl/swanctl.orig
    ```

1. Создайте конфигурацию для основного IPsec-шлюза в файле `/etc/swanctl/swanctl.conf`:

    ```bash
    sudo nano /etc/swanctl/swanctl.conf
    ```

    В открывшемся файле укажите:

    ```bash
    connections {
      cloud-ipsec {
        local_addrs = 172.16.0.10
        remote_addrs = <x2.x2.x2.x2>
        local {
          auth = psk
        }
        remote {
          auth = psk
        }
        version = 2 # IKEv2
        mobike = no
        proposals = aes128gcm16-prfsha256-ecp256, default
        dpd_delay = 10s
        children {
          cloud-ipsec {
            # List of local IPv4 subnets
            local_ts = 172.16.1.0/24, 172.16.2.0/24

            # List of remote IPv4 subnets
            remote_ts = 10.10.0.0/16

            start_action = trap
            esp_proposals = aes128gcm16
            dpd_action = clear
          }
        }
      }
    }

    # Pre-shared key (PSK) for IPsec connection
    secrets {
      ike-cloud-ipsec {
        secret = <пароль_ipsec>
      }
    }
    ```

    Где:

    * `cloud-ipsec` — имя IPsec-соединения.
    * `remote_addrs` — публичный IP-адрес `<x2.x2.x2.x2>` удаленного IPsec-шлюза.
    * `proposals` — [Internet Key Exchange Version 2 (IKEv2)](https://docs.strongswan.org/docs/5.9/howtos/ipsecProtocol.html#_internet_key_exchange_version_2_ikev2). Список шифров (ciphers), которые могут использоваться для шифрования канала управления IPsec-соединением.
    * `esp_proposals` — [Encapsulating Security Payload](https://docs.strongswan.org/docs/5.9/howtos/ipsecProtocol.html#_encapsulating_security_payload_esp). Список шифров (ciphers), которые могут использоваться для шифрования передаваемых данных.
    * `secret` — [Pre-Shared Key](https://docs.strongswan.org/docs/5.9/howtos/ipsecProtocol.html#_psk_based_authentication). Ключ (пароль) `<пароль_ipsec>`, который будет использоваться для установки IPsec-соединения.

    {% note info %}

    В файле конфигурации `swanctl.conf` вы можете указать дополнительные параметры в соответствии с [документацией strongSwan](https://docs.strongswan.org/docs/5.9/swanctl/swanctlConf.html).

    Например, для увеличения скорости передачи данных через IPsec-соединение используйте [оптимизированные алгоритмы шифрования](https://docs.strongswan.org/docs/5.9/config/IKEv2CipherSuites.html#_authenticated_encryption_aead_algorithms) в режиме [IKEv2](https://docs.strongswan.org/docs/5.9/features/ietf.html#_ikev2). Поддержка этих алгоритмов должна быть реализована на платформе удаленного IPsec-шлюза, если это не strongSwan.

    {% endnote %}

1. Загрузите конфигурацию в strongSwan:

    ```bash
    sudo swanctl --load-all
    ```

1. Перезапустите strongSwan:

    ```bash
    sudo systemctl restart strongswan
    ```

1. Проверьте состояние strongSwan:

    ```bash
    sudo swanctl -L
    ```

1. (Опционально) Посмотрите логи strongSwan:

    ```bash
    sudo journalctl -u strongswan --no-pager
    sudo journalctl -u strongswan -n 20
    sudo journalctl -u strongswan -f
    ```

1. Закройте соединение с `cloud-gw`:

    ```bash
    exit
    ```


#### Разверните тестовые ВМ на облачной площадке {#cloud-test-vm}

1. [Создайте тестовую ВМ](../../../compute/operations/vm-create/create-linux-vm.md) `vm-d` со следующими параметрами:

    * **Операционная система** — [Ubuntu 22.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ipsec-instance-ubuntu).
    * **Зона доступности** — `ru-central1-d`.
    * **Подсеть** — `subnet-d`.
    * **Публичный IP-адрес** — `Без адреса`.
    * **Внутренний IPv4-адрес** — `172.16.1.5`.
    * **Логин** — `ipsec`.
    * **SSH-ключ** — публичный SSH-ключ для доступа к ВМ.
    * **Имя** — `vm-d`.

1. [Создайте тестовую ВМ](../../../compute/operations/vm-create/create-linux-vm.md) `vm-b` со следующими параметрами:

    * **Операционная система** — `Ubuntu 22.04 LTS`.
    * **Зона доступности** — `ru-central1-b`.
    * **Подсеть** — `subnet-b`.
    * **Публичный IP-адрес** — `Без адреса`.
    * **Внутренний IPv4-адрес** — `172.16.2.5`.
    * **Логин** — `ipsec`.
    * **SSH-ключ** — публичный SSH-ключ для доступа к ВМ.
    * **Имя** — `vm-b`.

## Настройте удаленную площадку {#remote-setup}

На этом этапе вы создадите и настроите инфраструктуру удаленной площадки условного корпоративного ЦОД. В нее войдут IPsec-шлюз, виртуальная машина, сеть и подсеть.

### Создайте и настройте удаленную сеть {#setup-remote-net}

#### Создайте сеть и подсеть на удаленной площадке {#remote-net}

1. [Создайте сеть](../../operations/network-create.md) с именем `remote-net`. При создании сети отключите опцию **Создать подсети**.
1. В сети `remote-net` вручную [создайте подсеть](../../operations/subnet-create.md) для подключения удаленного IPsec-шлюза `remote-gw` и ВМ `vm-1` со следующими параметрами:

    * **Имя** — `subnet-1`.
    * **Зона доступности** — `ru-central1-b`.
    * **CIDR** — `10.10.0.0/16`.

#### Создайте и настройте группу безопасности для удаленного IPsec-шлюза {#remote-sg}

1. В сети `remote-net` [создайте группу безопасности](../../operations/security-group-create.md) с именем `remote-net-sg`.
1. В группе безопасности `remote-net-sg` [создайте правила](../../operations/security-group-add-rule.md) в соответствии с таблицей:

    | Направление<br/>трафика | Описание | Диапазон портов | Протокол | Источник /<br/>Назначение | CIDR блоки |
    | --- | --- | --- | --- | --- | --- |
    | Исходящий | `any`           | `Весь` | `Любой` | `CIDR` | `0.0.0.0/0` |
    | Входящий | `icmp`           | `Весь` | `ICMP` | `CIDR` | `0.0.0.0/0` |
    | Входящий | `ssh`            | `22`   | `TCP`  | `CIDR` | `0.0.0.0/0` |
    | Входящий | `ipsec-udp-500`  | `500`  | `UDP`  | `CIDR` | `<x1.x1.x1.x1>/32` |
    | Входящий | `ipsec-udp-4500` | `4500` | `UDP`  | `CIDR` | `<x1.x1.x1.x1>/32` |
    | Входящий | `subnet-1`       | `Весь` | `Любой` | `CIDR` | `10.10.0.0/16` |

#### Настройте статическую маршрутизацию для удаленного IPsec-шлюза {#remote-static}

1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором создана сеть `remote-net`.
1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Virtual Private Cloud**.
1. Выберите сеть `remote-net`.
1. Перейдите на вкладку **Таблицы маршрутизации** и нажмите **Создать**.
1. В поле **Имя** укажите `remote-net-rt`.
1. В блоке **Статические маршруты** нажмите **Добавить маршрут**.

    1. В открывшемся окне в поле **Префикс назначения** укажите `172.16.1.0/24`.
    1. В поле **IP-адрес** укажите внутренний IP-адрес основного IPsec-шлюза — `10.10.20.20`.
    1. Нажмите **Добавить**.

1. Повторите предыдущий шаг, чтобы добавить второе правило с параметрами:

    * **Префикс назначения** — `172.16.2.0/24`.
    * **IP-адрес** — `10.10.20.20`.

1. Нажмите **Создать таблицу маршрутизации**.
1. Привяжите таблицу маршрутизации `remote-net-rt` к подсети `subnet-1`:

    1. Перейдите на вкладку **Обзор**.
    1. В строке подсети `subnet-1` нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите пункт **Привязать таблицу маршрутизации**.
    1. В открывшемся окне выберите таблицу `remote-net-rt` и нажмите **Привязать**.

### Создайте и настройте виртуальные машины на удаленной площадке {#setup-remote-vms}

#### Создайте ВМ с удаленным IPsec-шлюзом {#create-remote-gw}

Создайте ВМ, которая будет выступать в роли удаленного IPsec-шлюза.

1. На странице [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления](https://console.yandex.cloud) нажмите кнопку **Создать ресурс** и выберите `Виртуальная машина`.
1. В блоке **Образ загрузочного диска** в поле **Поиск продукта** введите `IPSec-инстанс` и выберите публичный образ [IPSec-инстанс](https://yandex.cloud/ru/marketplace/products/yc/ipsec-instance-ubuntu).
1. В блоке **Расположение** выберите [зону доступности](../../../overview/concepts/geo-scope.md) `ru-central1-b` — зону доступности, где находится подсеть, к которой будет подключен удаленный IPsec-шлюз.
1. В блоке **Сетевые настройки**:

    1. В поле **Подсеть** выберите `subnet-1`.
    1. В поле **Публичный IP-адрес** выберите `Список`.
    1. В открывшемся поле **IP-адрес** выберите публичный IP-адрес `<x2.x2.x2.x2>`, который был [зарезервирован ранее](#reserve-public-ip).
    1. В поле **Группы безопасности** выберите [ранее созданную](#cloud-sg) группу безопасности `remote-net-sg`.
    1. Разверните блок **Дополнительно**:

        * В поле **Внутренний IPv4 адрес** выберите `Вручную`.
        * В появившемся поле для ввода укажите `10.10.20.20`.

1. В блоке **Доступ** выберите вариант **SSH-ключ** и укажите данные для доступа на ВМ:

    * В поле **Логин** укажите `ipsec`.
    * В поле **SSH-ключ** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../../organization/concepts/membership.md) после [создания](#create-cloud-gw) ВМ с основным IPsec-шлюзом.

        Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:

        * Нажмите кнопку **Добавить ключ**.
        * Задайте имя SSH-ключа.
        * Загрузите или вставьте содержимое [созданного ранее](#create-ssh-keys) публичного SSH-ключа для доступа к ВМ.
        * Нажмите кнопку **Добавить**.

        SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.

1. В блоке **Общая информация** задайте имя ВМ: `remote-gw`. Требования к имени:

    * длина — от 3 до 63 символов;
    * может содержать строчные буквы латинского алфавита, цифры и дефисы;
    * первый символ — буква, последний — не дефис.

1. Нажмите кнопку **Создать ВМ**.

Дождитесь, когда ВМ перейдет в статус `Running`.

#### Настройте удаленный IPsec-шлюз {#config-remote-gw}

Для настройки шлюза используйте IP-адреса, имя пользователя и ключ SSH, которые вы указывали при создании ВМ `remote-gw`.

1. Подключитесь к виртуальной машине по [SSH](../../../glossary/ssh-keygen.md):

    ```bash
    ssh ipsec@<x2.x2.x2.x2>
    ```

1. Задайте параметры даты и времени для ВМ:

    ```bash
    sudo timedatectl set-timezone Europe/Moscow
    sudo timedatectl set-ntp True
    timedatectl
    ```

1. Для оптимальной работы протокола ICMP отключите функциональность `ICMP Redirects` на IPsec-шлюзе:

    ```bash
	  sudo su -c "echo 'net.ipv4.conf.eth0.send_redirects=0' >> /etc/sysctl.conf"
	  sudo su -c "echo 'net.ipv4.conf.default.send_redirects=0' >> /etc/sysctl.conf"
    ```

    Подробнее об этом читайте в [документации strongSwan](https://docs.strongswan.org/docs/5.9/howtos/forwarding.html#_hosts_on_the_lan).

1. Создайте резервную копию файла конфигурации `swanctl.conf`:

    ```bash
    sudo mv /etc/swanctl/swanctl.conf /etc/swanctl/swanctl.orig
    ```

1. Создайте конфигурацию для удаленного IPsec-шлюза в файле `/etc/swanctl/swanctl.conf`:

    ```bash
    sudo nano /etc/swanctl/swanctl.conf
    ```

    В открывшемся файле укажите:

    ```bash
    connections {
      cloud-ipsec {
        local_addrs = 10.10.20.20
        remote_addrs = <x1.x1.x1.x1>
        local {
          auth = psk
        }
        remote {
          auth = psk
        }
        version = 2 # IKEv2
        mobike = no
        proposals = aes128gcm16-prfsha256-ecp256, default
        dpd_delay = 10s
        children {
          cloud-ipsec {
            # List of local IPv4 subnets
            local_ts = 10.10.0.0/16

            # List of remote IPv4 subnets
            remote_ts = 172.16.1.0/24, 172.16.2.0/24

            start_action = trap
            esp_proposals = aes128gcm16
            dpd_action = clear
          }
        }
      }
    }

    # Pre-shared key (PSK) for IPsec connection
    secrets {
      ike-cloud-ipsec {
        secret = <пароль_ipsec>
      }
    }
    ```

    Где:

    * `cloud-ipsec` — имя IPsec-соединения.
    * `remote_addrs` — публичный IP-адрес `<x1.x1.x1.x1>` основного IPsec-шлюза.
    * `proposals` — [Internet Key Exchange Version 2 (IKEv2)](https://docs.strongswan.org/docs/5.9/howtos/ipsecProtocol.html#_internet_key_exchange_version_2_ikev2). Список шифров (ciphers), которые могут использоваться для шифрования канала управления IPsec-соединением.
    * `esp_proposals` — [Encapsulating Security Payload](https://docs.strongswan.org/docs/5.9/howtos/ipsecProtocol.html#_encapsulating_security_payload_esp). Список шифров (ciphers), которые могут использоваться для шифрования передаваемых данных.
    * `secret` — [Pre-Shared Key](https://docs.strongswan.org/docs/5.9/howtos/ipsecProtocol.html#_psk_based_authentication). Ключ (пароль) `<пароль_ipsec>`, который будет использоваться для установки IPsec-соединения.

    {% note info %}

    В файле конфигурации `swanctl.conf` вы можете указать дополнительные параметры в соответствии с [документацией strongSwan](https://docs.strongswan.org/docs/5.9/swanctl/swanctlConf.html).

    Например, для увеличения скорости передачи данных через IPsec-соединение используйте [оптимизированные алгоритмы шифрования](https://docs.strongswan.org/docs/5.9/config/IKEv2CipherSuites.html#_authenticated_encryption_aead_algorithms) в режиме [IKEv2](https://docs.strongswan.org/docs/5.9/features/ietf.html#_ikev2). Поддержка этих алгоритмов должна быть реализована на платформе удаленного IPsec-шлюза, если это не strongSwan.

    {% endnote %}

1. Загрузите конфигурацию в strongSwan:

    ```bash
    sudo swanctl --load-all
    ```

1. Перезапустите strongSwan:

    ```bash
    sudo systemctl restart strongswan
    ```

1. Проверьте состояние strongSwan:

    ```bash
    sudo swanctl -L
    ```

1. (Опционально) Посмотрите логи strongSwan:

    ```bash
    sudo journalctl -u strongswan --no-pager
    sudo journalctl -u strongswan -n 20
    sudo journalctl -u strongswan -f
    ```

1. Закройте соединение с `remote-gw`:

    ```bash
    exit
    ```


#### Разверните тестовую ВМ на удаленной площадке {#remote-test-vm}

[Создайте тестовую ВМ](../../../compute/operations/vm-create/create-linux-vm.md) со следующими параметрами:

  * **Операционная система** — `Ubuntu 22.04 LTS`.
  * **Зона доступности** — `ru-central1-b`.
  * **Подсеть** — `subnet-1`.
  * **Публичный IP-адрес** — `Без адреса`.
  * **Внутренний IPv4-адрес** — `10.10.10.10`.
  * **Логин** — `ipsec`.
  * **SSH-ключ** — публичный SSH-ключ для доступа к ВМ.
  * **Имя** — `vm-1`.

## Проверьте работу IPsec-соединения и связность между удаленными и облачными ресурсами {#ipsec-test}

### Установите IPsec-соединение между шлюзами и проверьте его работу {#ipsec-bringup}

IPsec-шлюзы на основной и удаленной площадках настроены на установление IPsec-соединения между собой при получении любым из них трафика, предназначенного для подсети на другой стороне IPsec-соединения (за другим шлюзом).

{% note info %}

На создание туннеля между шлюзами может потребоваться время. Если при активации IPsec-соединения команда `ping` не выдает нужного результата, подождите несколько минут, затем попробуйте выполнить команду снова.

{% endnote %}

Для активации IPsec-соединения между шлюзами:

1. Отправьте несколько пакетов ICMP со стороны удаленной площадки, например, от ВМ `vm-1` к ВМ `vm-d` с помощью команды `ping`:

    ```bash
    ssh -J ipsec@<x2.x2.x2.x2> ipsec@10.10.10.10 ping -c4 172.16.1.5
    ```

    Результат:

    ```bash
    PING 172.16.1.5 (172.16.1.5) 56(84) bytes of data.
    64 bytes from 172.16.1.5: icmp_seq=1 ttl=58 time=4.92 ms
    64 bytes from 172.16.1.5: icmp_seq=2 ttl=58 time=4.33 ms
    64 bytes from 172.16.1.5: icmp_seq=3 ttl=58 time=4.31 ms
    64 bytes from 172.16.1.5: icmp_seq=4 ttl=58 time=4.38 ms

    --- 172.16.1.5 ping statistics ---
    4 packets transmitted, 4 received, 0% packet loss, time 3005ms
    rtt min/avg/max/mdev = 4.306/4.483/4.916/0.251 ms
    ```

1. Активируйте IPsec-соединение со стороны облачной площадки — отправьте пакеты ICMP от ВМ `vm-b` к ВМ `vm-1`:

    ```bash
    ssh -J ipsec@<x1.x1.x1.x1> ipsec@172.16.2.5 ping -c4 10.10.10.10
    ```

    Результат:

    ```bash
    PING 10.10.10.10 (10.10.10.10) 56(84) bytes of data.
    64 bytes from 10.10.10.10: icmp_seq=1 ttl=58 time=4.92 ms
    64 bytes from 10.10.10.10: icmp_seq=2 ttl=58 time=4.33 ms
    64 bytes from 10.10.10.10: icmp_seq=3 ttl=58 time=4.31 ms
    64 bytes from 10.10.10.10: icmp_seq=4 ttl=58 time=4.38 ms

    --- 10.10.10.10 ping statistics ---
    4 packets transmitted, 4 received, 0% packet loss, time 3005ms
    rtt min/avg/max/mdev = 4.306/4.483/4.916/0.251 ms
    ```

### Проверьте связность между ВМ {#ipsec-test-vm}

1. Подключитесь к основному IPsec-шлюзу `cloud-gw`:

    ```bash
    ssh ipsec@<x1.x1.x1.x1>
    ```

    1. Проверьте состояние strongSwan:

        ```bash
        sudo swanctl -L
        ```

        Результат:

        ```bash
        cloud-to-remote-site: IKEv1/2, reauthentication every 3060s, no rekeying, dpd delay 30s
          local:  %any
          remote: <x2.x2.x2.x2>
          local pre-shared key authentication:
            id: <x1.x1.x1.x1>
          remote pre-shared key authentication:
            id: <x2.x2.x2.x2>
          cloud-to-remote-site: TUNNEL, rekeying every 28260s, dpd action is restart
            local:  172.16.1.0/24
            remote: 10.10.0.0/16
        cloud-ipsec: IKEv2, no reauthentication, rekeying every 14400s, dpd delay 10s
          local:  172.16.0.10
          remote: <x2.x2.x2.x2>
          local pre-shared key authentication:
          remote pre-shared key authentication:
          cloud-ipsec: TUNNEL, rekeying every 3600s, dpd action is clear
            local:  172.16.1.0/24 172.16.2.0/24
            remote: 10.10.0.0/16
        ```

    1. Проверьте активные IPsec-соединения:

        ```bash
        sudo swanctl -l
        ```

        Результат:

        ```bash
        cloud-ipsec: #6, ESTABLISHED, IKEv2, 80e6fa659b4f6307_i* 9f63a85191df1e48_r
          local  '172.16.0.10' @ 172.16.0.10[4500]
          remote '10.10.20.20' @ <x2.x2.x2.x2>[4500]
          AES_GCM_16-128/PRF_HMAC_SHA2_256/ECP_256
          established 9716s ago, rekeying in 4107s
          cloud-ipsec: #19, reqid 1, INSTALLED, TUNNEL-in-UDP, ESP:AES_GCM_16-128
            installed 682s ago, rekeying in 2735s, expires in 3278s
            in  cf9668bb,      0 bytes,     0 packets
            out c3a00b2c,      0 bytes,     0 packets
            local  172.16.1.0/24 172.16.2.0/24
            remote 10.10.0.0/16
        ```

        Состояние соединения `ESTABLISHED` означает, что IPsec-соединение установилось и работает.

    1. Закройте соединение с `cloud-gw`:

        ```bash
        exit
        ```

1. Подключитесь к удаленному IPsec-шлюзу `remote-gw`:

    ```bash
    ssh ipsec@<x2.x2.x2.x2>
    ```

    1. Проверьте состояние strongSwan:

        ```bash
        sudo swanctl -L
        ```

        Результат:

        ```bash
        remote-site-to-cloud: IKEv1/2, reauthentication every 3060s, no rekeying, dpd delay 30s
          local:  %any
          remote: <x1.x1.x1.x1>
          local pre-shared key authentication:
            id: <x2.x2.x2.x2>
          remote pre-shared key authentication:
            id: <x1.x1.x1.x1>
          remote-site-to-cloud: TUNNEL, rekeying every 28260s, dpd action is restart
            local:  10.10.0.0/16
            remote: 172.16.1.0/24
        cloud-ipsec: IKEv2, no reauthentication, rekeying every 14400s, dpd delay 10s
          local:  10.10.20.20
          remote: <x1.x1.x1.x1>
          local pre-shared key authentication:
          remote pre-shared key authentication:
          cloud-ipsec: TUNNEL, rekeying every 3600s, dpd action is clear
            local:  10.10.0.0/16
            remote: 172.16.1.0/24 172.16.2.0/24
        ```

    1. Проверьте активные IPsec-соединения:
    
        ```bash
        sudo swanctl -l
        ```

        Результат:

        ```bash
        cloud-ipsec: #6, ESTABLISHED, IKEv2, 80e6fa659b4f6307_i 9f63a85191df1e48_r*
          local  '10.10.20.20' @ 10.10.20.20[4500]
          remote '172.16.0.10' @ <x1.x1.x1.x1>[4500]
          AES_GCM_16-128/PRF_HMAC_SHA2_256/ECP_256
          established 9833s ago, rekeying in 3346s
          cloud-ipsec: #19, reqid 1, INSTALLED, TUNNEL-in-UDP, ESP:AES_GCM_16-128
            installed 799s ago, rekeying in 2620s, expires in 3161s
            in  c3a00b2c,      0 bytes,     0 packets
            out cf9668bb,      0 bytes,     0 packets
            local  10.10.0.0/16
            remote 172.16.1.0/24 172.16.2.0/24
        ```

        Состояние соединения `ESTABLISHED` означает, что IPsec-соединение установилось и работает.

    1. Закройте соединение с `remote-gw`:

        ```bash
        exit
        ```

1. Подключитесь к ВМ `vm-d`:

    ```bash
    ssh -J ipsec@<x1.x1.x1.x1> ipsec@172.16.1.5
    ```

    1. Задайте параметры даты и времени для ВМ:

        ```bash
        sudo timedatectl set-timezone Europe/Moscow
        sudo timedatectl set-ntp True
        timedatectl
        ```

    1. Проверьте IP-связность между `vm-d` и `vm-1`:

        ```bash
        ping -c4 10.10.10.10
        ```

        Результат:

        ```bash
        PING 10.10.10.10 (10.10.10.10) 56(84) bytes of data.
        64 bytes from 10.10.10.10: icmp_seq=1 ttl=58 time=4.92 ms
        64 bytes from 10.10.10.10: icmp_seq=2 ttl=58 time=4.33 ms
        64 bytes from 10.10.10.10: icmp_seq=3 ttl=58 time=4.31 ms
        64 bytes from 10.10.10.10: icmp_seq=4 ttl=58 time=4.38 ms

        --- 10.10.10.10 ping statistics ---
        4 packets transmitted, 4 received, 0% packet loss, time 3005ms
        rtt min/avg/max/mdev = 4.306/4.483/4.916/0.251 ms
        ```

    1. Закройте соединение с `vm-d`:

        ```bash
        exit
        ```

1. Подключитесь к ВМ `vm-b`:

    ```bash
    ssh -J ipsec@<x1.x1.x1.x1> ipsec@172.16.2.5
    ```

    1. Задайте параметры даты и времени для ВМ:

        ```bash
        sudo timedatectl set-timezone Europe/Moscow
        sudo timedatectl set-ntp True
        timedatectl
        ```

    1. Проверьте IP-связность между `vm-b` и `vm-1`:

        ```bash
        ping -c4 10.10.10.10
        ```

        Результат:

        ```bash
        PING 10.10.10.10 (10.10.10.10) 56(84) bytes of data.
        64 bytes from 10.10.10.10: icmp_seq=1 ttl=58 time=4.92 ms
        64 bytes from 10.10.10.10: icmp_seq=2 ttl=58 time=4.33 ms
        64 bytes from 10.10.10.10: icmp_seq=3 ttl=58 time=4.31 ms
        64 bytes from 10.10.10.10: icmp_seq=4 ttl=58 time=4.38 ms

        --- 10.10.10.10 ping statistics ---
        4 packets transmitted, 4 received, 0% packet loss, time 3005ms
        rtt min/avg/max/mdev = 4.306/4.483/4.916/0.251 ms
        ```

    1. Закройте соединение с `vm-b`:

        ```bash
        exit
        ```

1. Подключитесь к ВМ `vm-1`:

    ```bash
    ssh -J ipsec@<x2.x2.x2.x2> ipsec@10.10.10.10
    ```

    1. Задайте параметры даты и времени для ВМ:

        ```bash
        sudo timedatectl set-timezone Europe/Moscow
        sudo timedatectl set-ntp True
        timedatectl
        ```

    1. Проверьте IP-связность между `vm-1` и `vm-d`:

        ```bash
        ping -c4 172.16.1.5
        ```

        Результат:

        ```bash
        PING 172.16.1.5 (172.16.1.5) 56(84) bytes of data.
        64 bytes from 172.16.1.5: icmp_seq=1 ttl=58 time=4.92 ms
        64 bytes from 172.16.1.5: icmp_seq=2 ttl=58 time=4.33 ms
        64 bytes from 172.16.1.5: icmp_seq=3 ttl=58 time=4.31 ms
        64 bytes from 172.16.1.5: icmp_seq=4 ttl=58 time=4.38 ms

        --- 172.16.1.5 ping statistics ---
        4 packets transmitted, 4 received, 0% packet loss, time 3005ms
        rtt min/avg/max/mdev = 4.306/4.483/4.916/0.251 ms
        ```

    1. Проверьте IP-связность между `vm-1` и `vm-b`:

        ```bash
        ping -c4 172.16.2.5
        ```

        Результат:

        ```bash
        PING 172.16.2.5 (172.16.2.5) 56(84) bytes of data.
        64 bytes from 172.16.2.5: icmp_seq=1 ttl=58 time=4.92 ms
        64 bytes from 172.16.2.5: icmp_seq=2 ttl=58 time=4.33 ms
        64 bytes from 172.16.2.5: icmp_seq=3 ttl=58 time=4.31 ms
        64 bytes from 172.16.2.5: icmp_seq=4 ttl=58 time=4.38 ms

        --- 172.16.2.5 ping statistics ---
        4 packets transmitted, 4 received, 0% packet loss, time 3005ms
        rtt min/avg/max/mdev = 4.306/4.483/4.916/0.251 ms
        ```
    
    1. Закройте соединение с `vm-1`:

        ```bash
        exit
        ```


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

* [Удалите ВМ](../../../compute/operations/vm-control/vm-delete.md).
* [Удалите статический публичный IP-адрес](../../operations/address-delete.md).
* [Удалите подсеть](../../operations/subnet-delete.md).
* [Удалите облачную сеть](../../operations/network-delete.md).