# Развертывание мультиплеер-сервера для GTA V в {{ yandex-cloud }}

Для организации многопользовательского режима в игре [Grand Theft Auto V](https://ru.wikipedia.org/wiki/Grand_Theft_Auto_V) от компании Rockstar Games вы можете развернуть мультиплеер-сервер на [виртуальной машине](../../compute/concepts/vm.md) в {{ yandex-cloud }}.

Чтобы развернуть мультиплеер-сервер GTA V в {{ yandex-cloud }}:

1. [Подготовьте облако к работе](#prepare-cloud).
1. [Создайте группу безопасности](#create-sg).
1. [Создайте ВМ для сервера GTA V](#vm-gta-v).
1. [Установите необходимые утилиты и пакеты ](#install-tools).
1. [Запустите сервер GTA V](#launch-server).
1. [Протестируйте работоспособность решения](#test-functionality).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:

* плата за постоянно работающие ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование публичных IP-адресов и исходящий трафик (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).


## Создайте группу безопасности {#create-sg}

Создайте [группу безопасности](../../vpc/concepts/security-groups.md) с правилом, разрешающим трафик к портам `22005` и `22006`. Эти порты заданы по умолчанию в файле конфигурации GTA V сервера.

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите ваш каталог.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. На панели слева выберите ![image](../../_assets/vpc/security-group.svg) **{{ ui-key.yacloud.vpc.switch_security-groups }}**. 
   1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
   1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** укажите имя `gta-v-sg`.
   1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** выберите сеть `default`.
   1. В блоке **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}** [создайте](../../vpc/operations/security-group-add-rule.md) следующие правила для управления трафиком:

      | Направление<br/>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
      | --- | --- | --- | --- | --- | --- |
      | Входящий | `sessions-u`           | `22005` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
      | Входящий | `server-http`           | `22006` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |

   1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

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

      1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.      
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите образ [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts).
      1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** настройте загрузочный [диск](../../compute/concepts/disk.md):

          * **{{ ui-key.yacloud.compute.disk-form.field_type }}** — `{{ ui-key.yacloud.compute.value_disk-type-network-hdd }}`.
          * **{{ ui-key.yacloud.compute.disk-form.field_size }}** — `20 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** перейдите на вкладку **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}** и укажите:

          * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Ice Lake`.
          * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `2`.
          * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `100%`.
          * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `2 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

          * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** укажите идентификатор подсети в зоне доступности создаваемой ВМ или выберите [облачную сеть](../../vpc/concepts/network.md#network) из списка.

              * У каждой сети должна быть как минимум одна [подсеть](../../vpc/concepts/network.md#subnet). Если подсети нет, создайте ее, выбрав **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.
              * Если сети нет, нажмите **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** и создайте ее:

                  * В открывшемся окне укажите имя сети и выберите каталог, в котором она будет создана.
                  * (Опционально) Выберите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**, чтобы автоматически создать подсети во всех зонах доступности.
                  * Нажмите **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

          * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`, чтобы назначить виртуальной машине случайный внешний IP-адрес из пула {{ yandex-cloud }}, или выберите статический адрес из списка, если вы зарезервировали его заранее.
          * В поле **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** выберите созданную ранее группу безопасности `gta-v-sg`.

      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа к ВМ:

          * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя, который будет создан на виртуальной машине, например `ubuntu`.

            {% note alert %}

            Не используйте логин `root` или другие имена, зарезервированные операционной системой. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.

            {% endnote %}

          * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `gta-v-server`.
      1. Нажмите **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

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
1. В сервисе {{ compute-name }} [удалите](../../compute/operations/vm-control/vm-delete.md) созданную виртуальную машину.
1. В сервисе {{ vpc-name }} [удалите](../../vpc/operations/security-group-delete.md) созданную группу безопасности.