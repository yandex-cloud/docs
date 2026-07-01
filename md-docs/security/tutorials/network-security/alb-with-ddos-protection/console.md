# Создание L7-балансировщика с защитой от DDoS с помощью консоли управления или CLI


Чтобы создать балансировщик с защитой от DDoS c помощью консоли управления Yandex Cloud или CLI:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте облачную сеть](#create-network).
1. [Создайте группы безопасности](#create-security-groups).
1. [Создайте группу виртуальных машин](#create-vms).
1. [Зарезервируйте статический публичный IP-адрес](#reserve-ip).
1. [Создайте группу бэкендов](#create-backend-group).
1. [Создайте HTTP-роутер](#create-http-routers-sites).
1. [Создайте L7-балансировщик](#create-balancer).
1. [Проверьте работу балансировщика](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../../billing/quickstart/index.md) и [привяжите](../../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для балансировщика с защитой от DDoS входят:

* плата за постоянно запущенные [ВМ](../../../../compute/concepts/vm.md) ([тарифы Yandex Compute Cloud](../../../compute/pricing.md));
* плата за использование [публичного статического IP-адреса](../../../../vpc/concepts/address.md#public-addresses) ([тарифы Yandex Virtual Private Cloud](../../../vpc/pricing.md));
* плата за фильтрацию входящего трафика на публичный IP-адрес с [защитой от DDoS-атак](../../../../vpc/ddos-protection/index.md) ([тарифы Yandex Virtual Private Cloud](../../../vpc/pricing.md#prices-ddos-protection));
* плата за использование вычислительных ресурсов [L7-балансировщика](../../../../application-load-balancer/concepts/index.md) ([тарифы Application Load Balancer](../../../application-load-balancer/pricing.md)).


## Подготовьте сервисный аккаунт {#prepare-sa}

{% note alert %}

Создавая группы ВМ, учитывайте [лимиты](../../../../compute/concepts/limits.md). Чтобы не нарушить работу компонента Instance Groups, не изменяйте и не удаляйте вручную созданные им ресурсы: [целевую группу](../../../../application-load-balancer/concepts/target-group.md) Application Load Balancer, ВМ и диски. Вместо этого измените или удалите группу полностью.

{% endnote %}

Все операции в Instance Groups выполняются от имени сервисного аккаунта. Если сервисного аккаунта нет, [создайте его](../../../../iam/operations/sa/create.md).

Чтобы иметь возможность создавать, обновлять и удалять ВМ в группе, а также интегрировать группу с L7-балансировщиком Application Load Balancer, [назначьте](../../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../../../../iam/concepts/access-control/roles.md) `editor`.

## Создайте облачную сеть {#create-network}

Все ресурсы, созданные в практическом руководстве, будут относиться к одной [облачной сети](../../../../vpc/concepts/network.md).

Чтобы создать сеть:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Virtual Private Cloud**.
  1. Нажмите кнопку **Создать сеть**.
  1. Укажите имя сети `ddos-network`.
  1. В поле **Дополнительно** выберите опцию **Создать подсети**.
  1. Нажмите кнопку **Создать сеть**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Создайте облачную сеть в [каталоге](../../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     ```bash
     yc vpc network create \
       --name ddos-network
     ```

     Подробнее о команде `yc vpc network create` читайте в [справочнике CLI](../../../../cli/cli-ref/vpc/cli-ref/network/create.md).

  1. Создайте [подсети](../../../../vpc/concepts/network.md#subnet) в каждой [зоне доступности](../../../../overview/concepts/geo-scope.md), указав идентификатор облачной сети с помощью параметра `--network-name`:

     ```bash
     yc vpc subnet create \
       --name ddos-network-ru-a \
       --network-name ddos-network \
       --zone ru-central1-a \
       --range 192.168.0.0/24
     ```

     ```bash
     yc vpc subnet create \
       --name ddos-network-ru-b \
       --network-name ddos-network \
       --zone ru-central1-b \
       --range 192.168.1.0/24
     ```

     ```bash
     yc vpc subnet create \
       --name ddos-network-ru-d \
       --network-name ddos-network \
       --zone ru-central1-d \
       --range 192.168.2.0/24
     ```

     Подробнее о команде `yc vpc subnet create` читайте в [справочнике CLI](../../../../cli/cli-ref/vpc/cli-ref/subnet/create.md).

{% endlist %}


## Создайте группы безопасности {#create-security-groups}

[Группы безопасности](../../../../application-load-balancer/concepts/application-load-balancer.md#security-groups) содержат правила, которые разрешают балансировщику получать входящий трафик и отправлять его на ВМ, а ВМ — получать этот трафик. В сценарии будут созданы две группы безопасности: для балансировщика и для всех ВМ.

Чтобы создать группы безопасности:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Virtual Private Cloud**.
  1. На панели слева выберите ![image](../../../../_assets/console-icons/shield.svg) **Группы безопасности**.
  1. Создайте группу безопасности для балансировщика:

     1. Нажмите кнопку **Создать группу безопасности**.
     1. Укажите **Имя** группы безопасности: `ddos-sg-balancer`.
     1. Выберите **Сеть** `ddos-network`.
     1. В блоке **Правила** создайте следующие правила по инструкции под таблицей:

        Направление<br>трафика | Описание | Диапазон портов | Протокол | Источник /<br>назначение | Добавить CIDR
        --- | --- | --- | --- | --- | ---
        `Исходящий` | `any` | `Весь` | `Любой` | `CIDR` | `0.0.0.0/0`
        `Входящий` | `ext-http` | `80` | `TCP` | `CIDR` | `0.0.0.0/0`
        `Входящий` | `ext-https` | `443` | `TCP` | `CIDR` | `0.0.0.0/0`
        `Входящий` | `healthchecks` | `30080` | `TCP` | `Проверки состояния балансировщика` | —

        1. Выберите вкладку **Исходящий трафик** или **Входящий трафик**.
        1. Нажмите кнопку **Добавить правило**.
        1. В открывшемся окне в поле **Диапазон портов** укажите один порт или диапазон портов, куда или откуда будет поступать трафик.
        1. В поле **Протокол** укажите нужный протокол или оставьте `Любой`, чтобы разрешить передачу трафика по всем протоколам.
        1. В поле **Назначение** или **Источник** выберите назначение правила:

           * `CIDR` — правило будет применено к диапазону IP-адресов. В поле **CIDR блоки** укажите CIDR и маски подсетей, в которые или из которых будет поступать трафик. Чтобы добавить несколько CIDR, нажимайте кнопку **Добавить CIDR**.
           * `Группа безопасности` — правило будет применено к ВМ из текущей группы или из выбранной группы безопасности.
           * `Проверки состояния балансировщика` — правило, которое позволяет балансировщику проверять состояние ВМ.

        1. Нажмите кнопку **Сохранить**. Таким образом создайте все правила из таблицы.

     1. Нажмите кнопку **Сохранить**.

  1. Аналогично создайте группу безопасности для ВМ с именем `ddos-sg-vms`, той же сетью `ddos-network` и следующими правилами:

     Направление<br>трафика | Описание | Диапазон портов | Протокол | Источник | CIDR блоки
     --- | --- | --- | --- | --- | ---
     `Входящий` | `balancer` | `80` | `TCP` | `Группа безопасности` | `ddos-sg-balancer`
     `Входящий` | `ssh` | `22` | `TCP` | `CIDR` | `0.0.0.0/0`

- CLI {#cli}

  Чтобы создать группу безопасности для балансировщика, выполните команду:

  ```bash
  yc vpc security-group create \
    --name ddos-sg-balancer \
    --rule "direction=egress,port=any,protocol=any,v4-cidrs=[0.0.0.0/0]" \
    --rule "direction=ingress,port=80,protocol=tcp,v4-cidrs=[0.0.0.0/0]" \
    --rule "direction=ingress,port=443,protocol=tcp,v4-cidrs=[0.0.0.0/0]" \
    --rule "direction=ingress,port=30080,protocol=tcp,predefined=loadbalancer_healthchecks" \
    --network-name ddos-network
  ```

  Чтобы создать группу безопасности для ВМ, выполните команду:

  ```bash
  yc vpc security-group create \
    --name ddos-sg-vms \
    --rule "direction=ingress,port=22,protocol=tcp,v4-cidrs=[0.0.0.0/0]" \
    --rule "direction=ingress,port=80,protocol=tcp,security-group-id=<идентификатор_группы_безопасности>" \
    --network-name ddos-network
  ```

  Где `security-group-id` — идентификатор группы безопасности `ddos-sg-balancer`.

  Подробнее о команде `yc vpc security-group create` читайте в [справочнике CLI](../../../../cli/cli-ref/vpc/cli-ref/security-group/create.md).

{% endlist %}


## Создайте группу ВМ {#create-vms}

На ВМ из [целевой группы](../../../../application-load-balancer/concepts/target-group.md) развертываются бэкенды вашего приложения. Целевая группа ВМ будет подключена к балансировщику, чтобы на эндпоинты бэкендов вашего приложения можно было направлять запросы. В этом сценарии достаточно создать [группу ВМ](../../../../compute/concepts/instance-groups/index.md) с минимальной конфигурацией.

Чтобы создать группу ВМ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../../_assets/console-icons/layers-3-diagonal.svg) **Группы виртуальных машин**. Нажмите кнопку **Создать группу виртуальных машин**.
  1. В блоке **Базовые параметры**:

     * Введите **Имя** группы ВМ: `ddos-group`.
     * Выберите [сервисный аккаунт](../../../../iam/concepts/users/service-accounts.md) из списка или создайте новый. Чтобы иметь возможность создавать, обновлять и удалять ВМ в группе, а также интегрировать группу с L7-балансировщиком Application Load Balancer, [назначьте](../../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../../../../iam/concepts/access-control/roles.md) `editor`.

  1. В блоке **Распределение** выберите несколько зон доступности, чтобы обеспечить отказоустойчивость хостинга.
  1. В блоке **Шаблон виртуальной машины** нажмите кнопку **Задать** и укажите конфигурацию базовой ВМ:

     * В блоке **Общая информация** введите **Описание** шаблона.
     * В блоке **Образ загрузочного диска** откройте вкладку **Marketplace** и нажмите кнопку **Показать все продукты Marketplace**. Выберите продукт [LEMP](https://yandex.cloud/ru/marketplace/products/yc/lemp) и нажмите кнопку **Использовать**.
     * В блоке **Диски и файловые хранилища** укажите:

       * **Тип** — `HDD`.
       * **Размер** диска — `3 ГБ`.

     * В блоке **Вычислительные ресурсы** укажите:

       * **Платформа** — `Intel Cascade Lake`.
       * **vCPU** — `2`.
       * **Гарантированная доля vCPU** — `5%`.
       * **RAM** — `1 ГБ`.

     * В блоке **Сетевые настройки**:

       * Выберите облачную сеть `ddos-network` и ее подсети.
       * В поле **Публичный адрес** выберите `Автоматически`.
       * Выберите группу безопасности `ddos-sg-vms`.

     * В блоке **Доступ** укажите данные для доступа на ВМ:

       * В поле **Логин** введите имя пользователя.
       * В поле **SSH-ключ** вставьте содержимое файла открытого ключа.

        Для подключения по [SSH](../../../../glossary/ssh-keygen.md) необходимо создать пару ключей. Подробнее в разделе [Создание пары ключей SSH](../../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

     * Нажмите кнопку **Сохранить**.

  1. В блоке **Масштабирование** укажите **Размер** группы ВМ — `2`.
  1. В блоке **Интеграция с Application Load Balancer** выберите опцию **Создать целевую группу** и укажите имя группы: `tg-ddos`. [Подробнее о целевых группах](../../../../application-load-balancer/concepts/target-group.md).
  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  1. Получите идентификаторы ресурсов, необходимые для создания группы ВМ, с помощью команд:

     * [yc iam service-account get <имя_сервисного_аккаунта>](../../../../cli/cli-ref/iam/cli-ref/service-account/get.md) — для сервисного аккаунта.
     * [yc vpc network get ddos-network](../../../../cli/cli-ref/vpc/cli-ref/network/get.md) — для сети `ddos-network`.
     * [yc vpc subnet get <имя_подсети>](../../../../cli/cli-ref/vpc/cli-ref/subnet/get.md) — для подсетей `ddos-network-ru-a`, `ddos-network-ru-b` и `ddos-network-ru-d`.
     * [yc compute image get-latest-by-family lemp --folder-id standard-images](../../../../cli/cli-ref/compute/cli-ref/image/get-latest-from-family.md) — для образа загрузочного диска.
     * [yc vpc security-group get ddos-sg-vms](../../../../cli/cli-ref/vpc/cli-ref/security-group/get.md) — для группы безопасности `ddos-sg-vms`.

  1. Создайте YAML-файл с именем `specification.yaml`.
  1. Добавьте в него описание конфигурации базовой ВМ:

     ```yaml
     name: ddos-group
     service_account_id: <идентификатор_сервисного_аккаунта> // сервисный аккаунт должен иметь роль editor
     description: "DDoS alb scenario"
     instance_template:
         platform_id: standard-v3
         resources_spec:
             memory: 1g
             cores: 2
             core_fraction: 5
         boot_disk_spec:
             mode: READ_WRITE
             disk_spec:
                 image_id: <идентификатор_образа>
                 type_id: network-hdd
                 size: 3g
         network_interface_specs:
             - network_id: <идентификатор_облачной_сети>
               subnet_ids:
                 - <идентификатор_подсети_в_зоне_ru-central1-a>
                 - <идентификатор_подсети_в_зоне_ru-central1-b>
                 - <идентификатор_подсети_в_зоне_ru-central1-d>
               primary_v4_address_spec: {}
               security_group_ids:
                 - <идентификатор_группы_безопасности>
     deploy_policy:
         max_unavailable: 1
         max_expansion: 0
     scale_policy:
         fixed_scale:
             size: 2
     allocation_policy:
         zones:
             - zone_id: ru-central1-a
             - zone_id: ru-central1-b
             - zone_id: ru-central1-d
     application_load_balancer_spec:
         target_group_spec:
             name: tg-ddos
     ```

     Где `security_group_ids` — идентификатор группы безопасности `ddos-sg-vms`.

  1. Создайте группу ВМ в каталоге по умолчанию:

     ```bash
     yc compute instance-group create \
       --file specification.yaml
     ```

     Результат:

     ```text
     done (25s)
     id: cl1qjhlcdofg********
     folder_id: b1g86q4m5vej********
     created_at: "2021-08-30T19:25:02.031Z"
     name: ddos-group
     description: DDoS scenario
     instance_template:
       platform_id: standard-v2
       resources_spec:
         memory: "1073741824"
         cores: "2"
         core_fraction: "5"
       boot_disk_spec:
         mode: READ_WRITE
         disk_spec:
           type_id: network-hdd
           size: "3221225472"
           image_id: fd8r6kq84o7b********
       network_interface_specs:
       - network_id: enp3srbi9u49********
         subnet_ids:
         - e9b17pi15695********
         - e2lt87g1rlig********
         - b0c7kl8riq24********
         primary_v4_address_spec: {}
         security_group_ids:
         - enpi08rif04d********
       scheduling_policy: {}
     scale_policy:
       fixed_scale:
         size: "2"
     deploy_policy:
       max_unavailable: "1"
       startup_duration: 0s
       strategy: PROACTIVE
     allocation_policy:
       zones:
       - zone_id: ru-central1-a
       - zone_id: ru-central1-b
       - zone_id: ru-central1-d
     load_balancer_state: {}
     managed_instances_state:
       target_size: "2"
     service_account_id: aje2stn6id9k********
     status: ACTIVE
     application_load_balancer_spec:
       target_group_spec:
         name: first-target-group
     application_load_balancer_state:
       target_group_id: ds78imh0ds2e********
     ```

     Подробнее о команде `yc compute instance-group create` читайте в [справочнике CLI](../../../../cli/cli-ref/compute/cli-ref/instance-group/create.md).

{% endlist %}


## Зарезервируйте статический публичный IP-адрес {#reserve-ip}

{% note info %}

Этот шаг нельзя выполнить через [интерфейс командной строки (CLI)](../../../../cli/index.md).

{% endnote %}

Чтобы защитить балансировщик от DDoS-атак, необходимо зарезервировать для него статический публичный IP-адрес с опцией **Защита от DDoS-атак**:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Virtual Private Cloud**.
  1. На панели слева выберите ![image](../../../../_assets/console-icons/map-pin.svg) **Публичные IP-адреса** и нажмите кнопку **Зарезервировать публичный IP-адрес**.
  1. Выберите зону доступности, в которой нужно зарезервировать IP-адрес.
  1. Включите опцию **Защита от DDoS-атак**.
  1. Нажмите кнопку **Зарезервировать**.

{% endlist %}


## Создайте группу бэкендов {#create-backend-group}

Целевую группу, созданную вместе с группой ВМ, нужно привязать к [группе бэкендов](../../../../application-load-balancer/concepts/backend-group.md) с настройками распределения трафика.

Для бэкендов в группах будут созданы [проверки состояния](../../../../application-load-balancer/concepts/backend-group.md#health-checks): балансировщик будет периодически отправлять проверочные запросы к ВМ и ожидать ответа в течение определенного периода.

Чтобы создать группу бэкендов:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Application Load Balancer**.
  1. На панели слева выберите ![image](../../../../_assets/console-icons/cubes-3-overlap.svg) **Группы бэкендов**. Нажмите кнопку **Создать группу бэкендов**.
  1. Укажите **Имя** группы бэкендов: `ddos-backend-group`.
  1. В блоке **Бэкенды** нажмите кнопку **Добавить**.
  1. Укажите **Имя** бэкенда: `backend-1`.
  1. В поле **Целевые группы** выберите группу `tg-ddos`.
  1. Укажите **Порт**, на котором ВМ бэкенда будут принимать входящий трафик от балансировщика: `80`.
  1. Нажмите кнопку **Добавить проверку состояния**.
  1. Укажите **Порт**, на котором ВМ бэкенда будут принимать проверочные соединения: `80`.
  1. Укажите **Путь**, к которому будет обращаться балансировщик при проверке состояния: `/`.
  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Создайте группу бэкендов:

     ```bash
     yc alb backend-group create ddos-backend-group
     ```

     Результат:

     ```text
     id: a5dg2cv4ngne********
     name: ddos-backend-group
     folder_id: aoerb349v3h4********
     created_at: "2021-08-08T20:46:21.688940670Z"
     ```

     Подробнее о команде `yc alb backend-group create` читайте в [справочнике CLI](../../../../cli/cli-ref/application-load-balancer/cli-ref/backend-group/create.md).

  1. Добавьте в группу бэкенд и проверку состояния:

     ```bash
     yc alb backend-group add-http-backend \
       --backend-group-name ddos-backend-group \
       --name backend-1 \
       --weight 1 \
       --port 80 \
       --target-group-id=<идентификатор_целевой_группы> \
       --http-healthcheck timeout=1s,interval=1s,port=80,path=/
     ```

     Где:
     * `--backend-group-name` — имя группы бэкендов.
     * `--name` — имя бэкенда.
     * `--weight` — вес бэкенда.
     * `--port` — порт.
     * `--target-group-id` — идентификатор целевой группы.
     * `--http-healthcheck` — параметры проверки состояния ресурсов.
       * `port` — порт.
       * `timeout` — таймаут.
       * `interval` — интервал.
       * `host` — адрес хоста.
       * `path` — путь.

     Результат:

     ```text
     done (21s)
     id: ds7fea2pggr2********
     name: ddos-backend-group
     folder_id: b1g86q4m5vej********
     http:
     backends:
     - name: backend-1
       backend_weight: "1"
       port: "80"
       target_groups:
         target_group_ids:
         - ds78ate00f8e********
       healthchecks:
       - timeout: 1s
         interval: 1s
         healthcheck_port: "80"
         http:
           path: /
     created_at: "2021-08-08T07:59:22.922603189Z"
     ```

     Подробнее о команде `yc alb backend-group add-http-backend` читайте в [справочнике CLI](../../../../cli/cli-ref/application-load-balancer/cli-ref/backend-group/add-http-backend.md).

{% endlist %}


## Создайте HTTP-роутер {#create-http-routers-sites}

Группу бэкендов нужно привязать к [HTTP-роутеру](../../../../application-load-balancer/concepts/http-router.md) с правилами маршрутизации HTTP-запросов.

Чтобы создать HTTP-роутер и добавить в него маршрут:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Application Load Balancer**.
  1. На панели слева выберите ![image](../../../../_assets/console-icons/route.svg) **HTTP-роутеры**. Нажмите кнопку **Создать HTTP-роутер**.
  1. Укажите **Имя** HTTP-роутера: `ddos-router`.
  1. Нажмите кнопку **Добавить виртуальный хост**.
  1. Укажите **Имя** виртуального хоста: `ddos-host`.
  1. Укажите значение **Authority**: `alb-with-ddos.com`.
  1. Нажмите кнопку **Добавить маршрут**.
  1. Введите **Имя**: `route-1`.
  1. В поле **Путь** выберите `Начинается с` и укажите путь `/`.
  1. В поле **Действие** оставьте `Маршрутизация`.
  1. В списке **Группа бэкендов** выберите созданную ранее группу.
  1. Остальные настройки оставьте без изменений и нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Выполните команду:

     ```bash
     yc alb http-router create ddos-router
     ```

     Результат:

     ```text
     id: a5dcsselagj4********
     name: ddos-router
     folder_id: aoerb349v3h4********
     created_at: "2021-08-08T21:04:59.438292069Z"
     ```

     Подробнее о команде `yc alb http-router create` читайте в [справочнике CLI](../../../../cli/cli-ref/application-load-balancer/cli-ref/http-router/create.md).

  1. Создайте виртуальный хост, указав имя HTTP-роутера:

     ```bash
     yc alb virtual-host create ddos-host \
       --http-router-name ddos-router
       --authority alb-with-ddos.com
     ```

     Подробнее о команде `yc alb virtual-host create` читайте в [справочнике CLI](../../../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/create.md).

  1. Добавьте маршрут, указав имя роутера и параметры маршрутизации:

     ```bash
     yc alb virtual-host append-http-route route-1 \
       --virtual-host-name ddos-host \
       --http-router-name ddos-router \
       --prefix-path-match / \
       --backend-group-name ddos-backend-group \
       --request-timeout 60s
     ```

     Результат:

     ```text
     done (1s)
      name: ddos-host
      routes:
      - name: route-1
        http:
          match:
            path:
              prefix_match: /
          route:
            backend_group_id: ds7fea2pggr2********
            timeout: 60s
     ```

     Подробнее о команде `yc alb virtual-host append-http-route` читайте в [справочнике CLI](../../../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/append-http-route.md).

{% endlist %}


## Создайте балансировщик {#create-balancer}

Чтобы создать балансировщик:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Application Load Balancer**.
  1. В меню слева выберите **Балансировщики**.
  1. Нажмите кнопку **Создать L7-балансировщик**.
  1. Введите имя балансировщика: `ddos-protect-alb`.
  1. В блоке **Сетевые настройки** выберите сеть `ddos-network` и группу безопасности `ddos-sg-balancer`.
  1. В блоке **Размещение** выберите подсети для узлов балансировщика в каждой зоне доступности и включите передачу трафика.
  1. В блоке **Обработчики** нажмите кнопку **Добавить обработчик**. Задайте настройки обработчика:

     1. Введите имя обработчика: `ddos-listener`.
     1. В блоке **Публичный IP-адрес** включите передачу трафика.
     1. Укажите порт `80`.
     1. Выберите тип **Список** и укажите [зарезервированный ранее](#reserve-ip) IP-адрес с защитой от DDoS.

  1. В поле **HTTP-роутер** выберите `ddos-router`.
  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  1. Создайте балансировщик с узлами в подсетях облачной сети:

     ```bash
     yc alb load-balancer create ddos-protect-alb \
       --network-name ddos-network \
       --location subnet-name=ddos-network-ru-a,zone=ru-central1-a \
       --location subnet-name=ddos-network-ru-b,zone=ru-central1-b \
       --location subnet-name=ddos-network-ru-d,zone=ru-central1-d
     ```

     Подробнее о команде `yc alb load-balancer create` читайте в [справочнике CLI](../../../../cli/cli-ref/application-load-balancer/cli-ref/load-balancer/create.md).

  1. Добавьте обработчик:

     ```bash
     yc alb load-balancer add-listener ddos-protect-alb \
       --listener-name ddos-listener \
       --http-router-id <идентификатор_HTTP-роутера> \
       --external-ipv4-endpoint port=80, address=<IP-адрес_с_защитой_от_DDoS>
     ```

     Подробнее о команде `yc alb load-balancer add-listener` читайте в [справочнике CLI](../../../../cli/cli-ref/application-load-balancer/cli-ref/load-balancer/add-listener.md).

{% endlist %}

После создания балансировщика, [проверьте](#test) его работу.

## Проверьте работу балансировщика {#test}

Проверьте доступность сервиса на хосте `alb-with-ddos.com`. Для этого выполните команду:

```bash
curl \
  --header "Host: alb-with-ddos.com" \
  http://<IP-адрес_L7-балансировщика>
```

Результат:

```html
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
  body {
    width: 35em;
    margin: 0 auto;
    font-family: Tahoma, Verdana, Arial, sans-serif;
  }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```


## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить работу хостинга и перестать платить за созданные ресурсы:

1. Удалите нетарифицируемые ресурсы, которые блокируют удаление тарифицируемых ресурсов:

   1. [Удалите](../../../../application-load-balancer/operations/application-load-balancer-delete.md) L7-балансировщик `ddos-protect-alb`.
   1. [Удалите](../../../../application-load-balancer/operations/http-router-delete.md) HTTP-роутер `ddos-router`.
   1. [Удалите](../../../../application-load-balancer/operations/backend-group-delete.md) группу бэкендов `ddos-backend-group`.

1. [Удалите](../../../../compute/operations/instance-groups/delete.md) группу ВМ `ddos-group`.
1. [Удалите](../../../../vpc/operations/address-delete.md) зарезервированный статический публичный IP-адрес.

#### Полезные ссылки {#see-also}

* [Создание L7-балансировщика с защитой от DDoS с помощью Terraform](terraform.md)