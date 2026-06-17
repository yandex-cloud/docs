# Развертывание мультиплеер-сервера для GTA V в Yandex Cloud

Для организации многопользовательского режима в игре [Grand Theft Auto V](https://ru.wikipedia.org/wiki/Grand_Theft_Auto_V) от компании Rockstar Games вы можете развернуть мультиплеер-сервер на [виртуальной машине](../../compute/concepts/vm.md) в Yandex Cloud.

Чтобы развернуть мультиплеер-сервер GTA V в Yandex Cloud:

1. [Подготовьте облако к работе](#prepare-cloud).
1. [Создайте группу безопасности](#create-sg).
1. [Создайте ВМ для сервера GTA V](#vm-gta-v).
1. [Установите необходимые утилиты и пакеты](#install-tools).
1. [Запустите сервер GTA V](#launch-server).
1. [Протестируйте работоспособность решения](#test-functionality).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#prepare-cloud}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:

* плата за постоянно работающие ВМ ([тарифы Yandex Compute Cloud](../../compute/pricing.md));
* плата за использование публичных IP-адресов и исходящий трафик ([тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).

## Создайте группу безопасности {#create-sg}

Создайте [группу безопасности](../../vpc/concepts/security-groups.md) с правилом, разрешающим трафик к портам `22005` и `22006`. Эти порты заданы по умолчанию в файле конфигурации GTA V сервера.

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите ваш каталог.
   1. Перейдите в сервис **Virtual Private Cloud**.
   1. На панели слева выберите ![image](../../_assets/vpc/security-group.svg) **Группы безопасности**. 
   1. Нажмите кнопку **Создать группу безопасности**.
   1. В поле **Имя** укажите имя `gta-v-sg`.
   1. В поле **Сеть** выберите сеть `default`.
   1. В блоке **Правила** [создайте](../../vpc/operations/security-group-add-rule.md) следующие правила для управления трафиком:

      | Направление<br/>трафика | Описание | Диапазон портов | Протокол | Источник /<br/>Назначение | CIDR блоки |
      | --- | --- | --- | --- | --- | --- |
      | Входящий | `sessions-u`           | `22005` | `Любой` | `CIDR` | `0.0.0.0/0` |
      | Входящий | `server-http`           | `22006` | `Любой` | `CIDR` | `0.0.0.0/0` |

   1. Нажмите кнопку **Сохранить**.

{% endlist %}

## Создайте ВМ для мультиплеер-сервера GTA V {#vm-gta-v}

1. Создайте пару ключей [SSH](../../glossary/ssh-keygen.md):
   ```bash
   ssh-keygen -t ed25519
   ```
   Рекомендуем оставить имя файла ключа без изменения.

1. Создайте ВМ с публичным IP-адресом:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
      1. Перейдите в сервис **Compute Cloud**.
      1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **Виртуальные машины**.
      1. Нажмите кнопку **Создать виртуальную машину**.
      1. В блоке **Образ загрузочного диска** в поле **Поиск продукта** введите `Ubuntu 22.04 LTS` и выберите публичный образ [Ubuntu 22.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-22-04-lts).
      1. В блоке **Расположение** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
      1. В блоке **Диски и файловые хранилища** выберите [тип диска](../../compute/concepts/disk.md#disks_types) `HDD` и задайте размер `20 ГБ`.
      1. В блоке **Вычислительные ресурсы** перейдите на вкладку `Своя конфигурация` и укажите необходимую [платформу](../../compute/concepts/vm-platforms.md), количество vCPU и объем RAM:

          * **Платформа** — `Intel Ice Lake`.
          * **vCPU** — `2`.
          * **Гарантированная доля vCPU** — `100%`.
          * **RAM** — `2 ГБ`.

      1. В блоке **Сетевые настройки**:

          * В поле **Подсеть** выберите сеть и подсеть, к которым нужно подключить ВМ. Если нужной [сети](../../vpc/concepts/network.md#network) или [подсети](../../vpc/concepts/network.md#subnet) еще нет, [создайте их](../../vpc/operations/subnet-create.md).
          * В поле **Публичный IP-адрес** оставьте значение `Автоматически`, чтобы назначить ВМ случайный внешний IP-адрес из пула Yandex Cloud, или выберите статический адрес из списка, если вы зарезервировали его заранее.
          * В поле **Группы безопасности** выберите созданную ранее группу безопасности `gta-v-sg`.

      1. В блоке **Доступ** выберите вариант **SSH-ключ** и укажите данные для доступа на ВМ:

          * В поле **Логин** введите имя пользователя, например: `ubuntu`. Не используйте имя `root` или другие [имена, зарезервированные ОС](https://github.com/canonical/subiquity/blob/main/reserved-usernames). Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
          * В поле **SSH-ключ** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../organization/concepts/membership.md).
            
            Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
            
            1. Нажмите кнопку **Добавить ключ**.
            1. Задайте имя SSH-ключа.
            1. Выберите вариант:
            
                * `Ввести вручную` — вставьте содержимое открытого [SSH](../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
                * `Загрузить из файла` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
                * `Сгенерировать ключ` — автоматическое создание пары SSH-ключей.
                
                  При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
            
            1. Нажмите кнопку **Добавить**.
            
            SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.

      1. В блоке **Общая информация** задайте имя ВМ: `gta-v-server`.
      1. Нажмите **Создать ВМ**.

   {% endlist %}

## Установите необходимые утилиты и пакеты {#install-tools}

1. [Подключитесь по протоколу SSH](../../compute/operations/vm-connect/ssh.md#vm-connect) к созданной ВМ.
1. Установите необходимые пакеты `toolchain` из репозитория Ubuntu-Toolchain, `libstdc++6`, `libatomic1` и утилиту `screen` для запуска терминальной сессии в фоновом режиме:

   ```bash
   sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
   sudo apt update -y && sudo apt install libstdc++6 libatomic1 screen
   ```

1. Скачайте дистрибутив сервера в текущую директорию:

   ```bash
   wget https://cdn.rage.mp/updater/prerelease/server-files/linux_x64.tar.gz
   ```

1. Распакуйте архив:

   ```bash
   tar -xzf linux_x64.tar.gz
   ```

1. Перейдите в директорию с сервером и сделайте файл `ragemp-server` исполняемым:

   ```bash
   cd ragemp-srv
   chmod +x ragemp-server
   ```

1. При желании, установите пакет RAGE.MP Freeroam. RAGE.MP Freeroam является простым модом, дающим пользователям мультиплейера доступ ко всем скинам, оружию и средствам передвижения. Так же можно восстановить здоровье и защиту. Чтобы установить пакет:

   1. Перейдите в директорию с установленным сервером:

   ```bash
   cd ~/ragemp-srv
   ```

   1. Скачайте дистрибутив мода со страницы разработчика на GitHub:

   ```bash
   git clone https://github.com/n-n1ks/rage.mp-freeroam.git
   ```

   1. Перейдите в директорию репозитория `rage.mp-freeroam` и скопируйте необходимые папки:

   ```bash
   cd rage.mp-freeroam
   cp -r ./client_packages/* ../client_packages/
   cp -r ./packages/* ../packages/
   ```

## Запустите сервер GTA V {#launch-server}

1. Запустите фоновую сессию screen:

   ```bash
   screen
   ```

1. В фоновой сессии запустите сервер:

   ```bash
   ./ragemp-server
   ```

   Вы должны увидеть вывод с подтверждением, что сервер готов принимать соединения “The server is ready to accept connections.” :

   ```bash
   [INFO] Starting RAGE Multiplayer server...

   [============================================================]
   ||
   ||      MaxPlayers              100
   ||      Sync rate               40ms
   ||      Name                    RAGE:MP Unofficial server
   ||      Gamemode                freeroam
   ||      Streaming distance      300
   ||      Announcement            disabled
   ||      Voice chat              disabled
   ||      Address                 127.0.0.1:22005
   ||      Connection limits       disabled
   ||      Encryption              enabled
   ||      NodeJS                  enabled
   ||      C#                      disabled
   ||
   [============================================================]


   [INFO] Loading NodeJS packages...
   [INFO] Starting packages...
   [DONE] Server packages have been started.
   [DONE] Started resource transfer server at 22006 port.
   [DONE] Client-side packages weight: 0.000000 MB (uncompressed: 0.000000 MB).
   [INFO] Initializing networking...
   [DONE] Networking has been started: (IPv4-only) at 127.0.0.1:22005
   [DONE] The server is ready to accept connections.
   ```

## Протестируйте работоспособность решения {#test-functionality}

1. Скачайте и установите мультиплеер [RageMP](https://rage.mp/ru) на компьютере, где установлена игра GTA 5:

   ```url
   https://cdn.rage.mp/public/files/RAGEMultiplayer_Setup.exe
   ```

1. Запустите игру Grand Theft Auto V через RageMP. 
1. В окне мультиплеера нажмите на иконку прямого подключения к серверу.
1. В открывшемся диалоге укажите публичный IP-адрес вашей виртуальной машины и порт `22005`.
1. Подключитесь к серверу нажав кнопку **Подключиться**. 
1. Если вы настроили мод RAGE.MP Freeroam, вызовите меню дополнительных возможностей клавишей F2.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. В сервисе Compute Cloud [удалите](../../compute/operations/vm-control/vm-delete.md) созданную виртуальную машину.
1. В сервисе Virtual Private Cloud [удалите](../../vpc/operations/security-group-delete.md) созданную группу безопасности.