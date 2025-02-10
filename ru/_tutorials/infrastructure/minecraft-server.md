# Развертывание сервера Minecraft в {{ yandex-cloud }}

С помощью руководства вы развернете сервер [Minecraft](https://www.minecraft.net/) ([Java Edition](https://www.minecraft.net/en-us/store/minecraft-java-edition/)) актуальной версии в {{ yandex-cloud }} на [виртуальной машине](../../compute/concepts/vm.md) с Ubuntu 24.04.

Чтобы развернуть сервер Minecraft в {{ yandex-cloud }}:

1. [Подготовьте облако к работе](#prepare-cloud).
1. [Создайте группу безопасности](#create-sg).
1. [Создайте ВМ для сервера Minecraft](#vm-minecraft).
1. [Установите необходимые утилиты](#install-tools).
1. [Скачайте и запустите сервер Minecraft](#get-and-launch-server).
1. [Проверьте работу сервера](#test-functionality).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:
* плата за постоянно запущенную [ВМ](../../compute/concepts/vm.md) (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование публичного IP-адреса и исходящий трафик (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).

## Создайте группу безопасности {#create-sg}

Создайте [группу безопасности](../../vpc/concepts/security-groups.md), с правилом, разрешающим входящий трафик к порту `25565`. Этот порт для доступа клиентов задан по умолчанию в файле конфигурации сервера Minecraft. Также в группу безопасности будут добавлены правила, разрешающие доступ на ВМ по SSH для настройки сервера и доступ ВМ в интернет для скачивания ПО.

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите ваш каталог.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. На панели слева выберите ![image](../../_assets/vpc/security-group.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}**. 
   1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
   1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** укажите имя `minecraft-sg`.
   1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** выберите сеть `default`.
   1. В блоке **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}** [создайте](../../vpc/operations/security-group-add-rule.md) следующие правила для управления трафиком:

      #|
      || **Направление**
      **трафика**
      | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}** 
      | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**
      | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**
      | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** /
      **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**
      | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** ||
      || Входящий
      | `Доступ клиента к`
      `серверу Minecraft`
      | `25565`
      | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`
      | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
      | `0.0.0.0/0` ||
      || Входящий
      | `Доступ на ВМ по`
      `SSH`
      | `22`
      | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`
      | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
      | `0.0.0.0/0` ||
      || Исходящий
      | `Доступ ВМ в`
      `интернет`
      | `0-65535`
      | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`
      | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
      | `0.0.0.0/0` ||
      |#

   1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}


## Создайте ВМ для сервера Minecraft {#vm-minecraft}

1. [Создайте](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) пару ключей [SSH](../../glossary/ssh-keygen.md):
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
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите образ [Ubuntu 24.04 LTS](/marketplace/products/yc/ubuntu-24-04-lts).
      1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** настройте загрузочный [диск](../../compute/concepts/disk.md):

          * **{{ ui-key.yacloud.compute.disk-form.field_type }}** — `{{ ui-key.yacloud.compute.value_disk-type-network-hdd }}`.
          * **{{ ui-key.yacloud.compute.disk-form.field_size }}** — `18 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** перейдите на вкладку **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}** и укажите рекомендуемые параметры для сервера Minecraft:

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
          * В поле **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** выберите созданную ранее группу безопасности `minecraft-sg`.

      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа к ВМ:

          * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя, который будет создан на виртуальной машине, например `ubuntu`.

            {% note alert %}

            Не используйте логин `root` или другие имена, зарезервированные операционной системой. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.

            {% endnote %}

          * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `minecraft-server`.
      1. Нажмите **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   {% endlist %}

   Рекомендуемая конфигурация виртуальной машины:

   | Конфигурация     |   Количество игроков  |   vCPU  |   RAM  |   Объем диска        |
   |------------------|-----------------------|---------|--------|----------------------|
   |   Минимальная    |   1-4                 |   2     |   1GB  |   минимум 150MB HDD  |
   |   Рекомендуемая  |   5-10                |   2     |   2GB  |   минимум 200MB HDD  |
   |   Лучшая         |   10+                 |   4     |   4GB  |   минимум 200MB SSD  |

   {% note warning %}

   Обратите внимание, что эта таблица с конфигурацией отражает настройки по умолчанию, определяемые в `server.properties`. Чем больше становится мир, тем выше требования — особенно к оперативной памяти. Чем больше будут области прорисовки игрового мира, деревень и других динамических объектов, тем выше будут требования к виртуальному серверу.

   {% endnote %}


## Установите необходимые утилиты {#install-tools}

1. [Подключитесь по протоколу SSH](../../compute/operations/vm-connect/ssh.md#vm-connect) к созданной ВМ.
1. Установите необходимые пакеты Java из репозитория и утилиту `screen` для запуска терминальной сессии в фоновом режиме:

   ```bash
   sudo add-apt-repository -y ppa:openjdk-r/ppa && sudo apt update -y && sudo apt install -y openjdk-23-jre-headless screen
   ```


## Скачайте и запустите сервер Minecraft {#get-and-launch-server}

1. Создайте отдельную директорию и перейдите в нее:
   ```bash
   mkdir minecraft-server && cd minecraft-server
   ```

1. Перейдите по [ссылке](https://www.minecraft.net/en-us/download/server/) и скопируйте URL для скачивания дистрибутива актуальной версии сервера.
1. Скачайте актуальный дистрибутив в текущую директорию с помощью `wget`, указав скопированную ранее ссылку, например:
   ```bash
   wget -O minecraft_server.jar https://piston-data.mojang.com/v1/objects/4707d00eb834b446575d89a61a11b5d548d8c001/server.jar
   ```

1. Создайте файл `eula.txt` для автоматического согласия с условиями лицензионного соглашения [EULA](https://aka.ms/MinecraftEULA):

   ```bash
   cat << EOF > eula.txt
   eula=true
   EOF
   ```

1. Запустите фоновую сессию `screen`:

   ```bash
   screen
   ```

1. В фоновой сессии запустите сервер:

   ```bash
   java -Xms1024M -Xmx1024M -jar minecraft_server.jar nogui
   ```

   Дождитесь успешного завершения создания игрового мира.

   ```text
   [09:18:58] [Worker-Main-2/INFO]: Preparing spawn area: 81%
   [09:18:59] [Worker-Main-2/INFO]: Preparing spawn area: 82%
   [09:19:00] [Worker-Main-2/INFO]: Preparing spawn area: 83%
   ...
   [09:19:08] [Worker-Main-2/INFO]: Preparing spawn area: 97%
   [09:19:09] [Server thread/INFO]: Time elapsed: 75917 ms
   [09:19:09] [Server thread/INFO]: Done (92.666s)! For help, type "help"
   ```

1. (Опционально) Можно оставить сессию `screen` работать в фоне, используя горячие клавиши **Ctrl + A + D** и вернуться в основной терминал виртуальной машины.

   Чтобы вернуться к фоновой сессии с запущенным сервером, если такая фоновая сессия только одна, выполните команду:

   ```bash
   screen -r
   ```

   Если фоновых сессий несколько, получите их список, выполнив команду:

   ```bash
   screen -list
   ```

   Результат выполнения:

   ```text
   There is a screen on:
      24257.pts-0.mcft-test	(02/28/2024 09:17:15 AM)	(Detached)
   1 Socket in /run/screen/S-username.
   ```

   Затем перейдите в сессию по нужному номеру ID из списка:
   
   ```bash
   screen -r 24257
   ```

1. После запуска сервера в директории будут созданы новые директории и необходимые файлы для работы и конфигурации сервера, в том числе логи:

   ```text
       4096 Mar 16 09:50 .
       4096 Mar 16 09:52 ..
          2 Mar 16 09:16 banned-ips.json
          2 Mar 16 09:16 banned-players.json
         10 Mar 16 09:48 eula.txt
       4096 Mar 16 09:50 libraries
       4096 Mar 16 09:16 logs
   49150256 Dec  7 09:04 minecraft_server_1.20.4.jar
          2 Mar 16 09:16 ops.json
       1303 Mar 16 09:16 server.properties
          2 Mar 16 09:16 usercache.json
       4096 Mar 16 09:50 versions
          2 Mar 16 09:50 whitelist.json
       4096 Mar 16 09:13 world
   ```


## Проверьте работу сервера {#test-functionality}

1. Добавьте сервер в список серверов в клиенте Minecraft. Название сервера задайте произвольно, а в поле **Адрес сервера** укажите [публичный IP-адрес](../../vpc/concepts/address#public-addresses) виртуальной машины `minecraft-server`.

   ![add-server-address](../../_assets/tutorials/infrastructure/minecraft-add-server-address.png =750x447)

1. В списке серверов выберите добавленный сервер и нажмите кнопку `Подключиться`.

   ![server-list](../../_assets/tutorials/infrastructure/minecraft-server-list.png =750x449)


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. [Удалите](../../compute/operations/vm-control/vm-delete.md) виртуальную машину `minecraft-server`.
1. [Удалите](../../vpc/operations/security-group-delete.md) группу безопасности `minecraft-sg`.
