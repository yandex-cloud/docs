# Создание балансировщика с защитой от DDoS

В этом сценарии вы создадите L7-балансировщик с обработчиком, который имеет публичный IP-адрес с функцией [защиты от DDoS-атак](../../vpc/ddos-protection/index.md).

Чтобы создать L7-балансировщик с защитой от DDoS-атак:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте облачную сеть](#create-network).
1. [Создайте группы безопасности](#create-security-groups).
1. [Создайте группу ВМ](#create-vms).
1. [Зарезервируйте статический публичный IP-адрес](#reserve-ip).
1. [Создайте группу бэкендов](#create-backend-group).
1. [Создайте HTTP-роутер](#create-http-routers-sites).
1. [Создайте L7-балансировщик](#create-balancer).
1. [Проверьте работу балансировщика](#test-work).

Если созданные ресурсы вам больше не нужны, [удалите их](#delete-resources).

Также инфраструктуру для балансировщика с защитой от DDoS можно развернуть через {{ TF }} с помощью [готового файла конфигурации](#terraform).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Создайте облачную сеть {#create-network}

Все ресурсы, созданные в сценарии, будут относиться к одной [облачной сети](../../vpc/concepts/network.md).

Чтобы создать сеть:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ vpc-name }}**.
  1. Нажмите кнопку **Создать сеть**.
  1. Укажите имя сети: `ddos-network`.
  1. В поле **Дополнительно** выберите опцию **Создать подсети**.
  1. Нажмите кнопку **Создать сеть**.

- CLI

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Создайте облачную сеть в каталоге по умолчанию:

     ```bash
     yc vpc network create \
       --name ddos-network
     ```

     Подробнее о команде `yc vpc network create` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/network/create.md).

  1. Создайте подсети в каждой зоне доступности, указав идентификатор облачной сети с помощью флага `--network-name`:

     ```bash
     yc vpc subnet create \
       --name ddos-network-ru-a \
       --network-name ddos-network \
       --zone {{ region-id }}-a \
       --range 192.168.0.0/24
     ```

     ```bash
     yc vpc subnet create \
       --name ddos-network-ru-b \
       --network-name ddos-network \
       --zone {{ region-id }}-b \
       --range 192.168.1.0/24
     ```

     ```bash
     yc vpc subnet create \
       --name ddos-network-ru-c \
       --network-name ddos-network \
       --zone {{ region-id }}-c \
       --range 192.168.2.0/24
     ```

     Подробнее о команде `yc vpc subnet create` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/subnet/create.md).

- {{ TF }}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

{% endlist %}

## Создайте группы безопасности {#create-security-groups}

{% note info %}

{% include [security-groups-note](../../_includes/vpc/security-groups-note-services.md) %}

{% endnote %}

[Группы безопасности](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) содержат правила, которые разрешают балансировщику получать входящий трафик и отправлять его на ВМ, а ВМ — получать этот трафик. В сценарии будут созданы две группы безопасности: для балансировщика и для всех ВМ.

Чтобы создать группы безопасности:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ vpc-name }}**.
  1. Откройте вкладку **Группы безопасности**.
  1. Создайте группу безопасности для балансировщика:

     1. Нажмите кнопку **Создать группу**.
     1. Укажите **Имя** группы: `ddos-sg-balancer`.
     1. Выберите **Сеть** `ddos-network`.
     1. В блоке **Правила** создайте следующие правила по инструкции под таблицей:

        | Направление<br/>трафика | Описание | Диапазон<br/>портов | Протокол | Тип источника /<br/>назначения | Источник /<br/>назначение |
        | --- | --- | --- | --- | --- | --- |
        | Исходящий | any | Весь | Любой | CIDR | 0.0.0.0/0 |
        | Входящий | ext-http | 80 | TCP | CIDR | 0.0.0.0/0 |
        | Входящий | ext-https | 443 | TCP | CIDR | 0.0.0.0/0 |
        | Входящий | healthchecks | 30080 | TCP | Проверки состояния балансировщика | — |

        1. Выберите вкладку **Исходящий трафик** или **Входящий трафик**.
        1. Нажмите кнопку **Добавить правило**.
        1. В открывшемся окне в поле **Диапазон портов** укажите один порт или диапазон портов, куда или откуда будет поступать трафик.
        1. В поле **Протокол** укажите нужный протокол или оставьте **Любой**, чтобы разрешить передачу трафика по всем протоколам.
        1. В поле **Назначение** или **Источник** выберите назначение правила:

           * **CIDR** — правило будет применено к диапазону IP-адресов. В поле **CIDR блоки** укажите CIDR и маски подсетей, в которые или из которых будет поступать трафик. Чтобы добавить несколько CIDR, нажимайте кнопку **Добавить CIDR**.
           * **Группа безопасности** — правило будет применено к ВМ из текущей группы или из выбранной группы безопасности.
           * **Проверки состояния балансировщика** — правило, которое позволяет балансировщику проверять состояние ВМ.

        1. Нажмите кнопку **Сохранить**. Таким образом создайте все правила из таблицы.

     1. Нажмите кнопку **Сохранить**.

  1. Аналогично создайте группу безопасности для ВМ с именем `ddos-sg-vms`, той же сетью `ddos-network` и следующими правилами:

     | Направление<br/>трафика | Описание | Диапазон<br/>портов | Протокол | Тип источника | Источник |
     | --- | --- | --- | --- | --- | --- |
     | Входящий | balancer | 80 | TCP | Группа безопасности | `ddos-sg-balancer` |
     | Входящий | ssh | 22 | TCP | CIDR | 0.0.0.0/0 |

- CLI

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
    --rule "direction=ingress,port=80,protocol=tcp,security-group-id=<идентификатор группы безопасности ddos-sg-balancer>" \
    --network-name ddos-network
  ```

  Подробнее о команде `yc vpc security-group create` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/security-group/create.md).

- {{ TF }}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

{% endlist %}

## Создайте группу ВМ {#create-vms}

На ВМ из [целевой группы](../../application-load-balancer/concepts/target-group.md) развертываются бэкенды вашего приложения. Целевая группа будет подключена к балансировщику, чтобы на эндпоинты бэкендов вашего приложения можно было направлять запросы. В этом сценарии достаточно создать группу ВМ с минимальной конфигурацией.

Чтобы создать группу ВМ:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ compute-name }}**.
  1. Откройте вкладку **Группы виртуальных машин** и нажмите кнопку **Создать группу**.
  1. В блоке **Базовые параметры**:

     * Введите **Имя** группы ВМ: `ddos-group`.
     * Выберите [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) из списка или создайте новый. Чтобы иметь возможность создавать, обновлять и удалять ВМ в группе, назначьте сервисному аккаунту роль `editor`. По умолчанию все операции в {{ ig-name }} выполняются от имени сервисного аккаунта.

  1. В блоке **Распределение** выберите несколько зон доступности, чтобы обеспечить отказоустойчивость хостинга.
  1. В блоке **Шаблон виртуальной машины** нажмите кнопку **Задать** и укажите конфигурацию базовой ВМ:

     * В блоке **Базовые параметры** введите **Описание** шаблона.
     * В блоке **Выбор образа/загрузочного диска** откройте вкладку **{{ marketplace-name }}** и нажмите кнопку **Посмотреть больше**. Выберите продукт [LEMP](/marketplace/products/yc/lemp) и нажмите кнопку **Использовать**.
     * В блоке **Диски** укажите:
       * **Тип диска** — HDD.
       * **Размер** диска — 3 ГБ.
     * В блоке **Вычислительные ресурсы** укажите:
       * **Платформа** — Intel Cascade Lake.
       * **vCPU** — 2.
       * **Гарантированная доля vCPU** — 5%.
       * **RAM** — 1 ГБ.
     * В блоке **Сетевые настройки**:
       * Выберите облачную сеть `ddos-network` и ее подсети.
       * В поле **Публичный адрес** выберите **Автоматически**.
       * Выберите группу безопасности `ddos-sg-vms`.
     * В блоке **Доступ** укажите данные для доступа на виртуальную машину:
       * В поле **Логин** введите имя пользователя.
       * В поле **SSH-ключ** вставьте содержимое файла открытого ключа.

        Для подключения по [SSH](../../glossary/ssh-keygen.md) необходимо создать пару ключей. Подробнее в разделе [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

     * Нажмите кнопку **Сохранить**.

  1. В блоке **Масштабирование** укажите **Размер** группы ВМ — 2.
  1. В блоке **Интеграция с Application Load Balancer** выберите опцию **Создать целевую группу** и укажите имя группы: `tg-ddos`. [Подробнее о целевых группах](../../application-load-balancer/concepts/target-group.md).
  1. Нажмите кнопку **Создать**.

- CLI

  1. Получите идентификаторы ресурсов, необходимые для создания группы ВМ, с помощью команд:

     * [yc iam service-account get <имя сервисного аккаунта>](../../cli/cli-ref/managed-services/iam/service-account/get.md) — для сервисного аккаунта;
     * [yc vpc network get ddos-network](../../cli/cli-ref/managed-services/vpc/network/get.md) — для сети `ddos-network`;
     * [yc vpc subnet get <имя подсети>](../../cli/cli-ref/managed-services/vpc/subnet/get.md) — для подсетей `ddos-network-ru-a`, `ddos-network-ru-b` и `ddos-network-ru-c`;
     * [yc compute image get-latest-by-family lemp --folder-id standard-images](../../cli/cli-ref/managed-services/compute/image/get-latest-from-family.md) — для образа загрузочного диска;
     * [yc vpc security-group get ddos-sg-vms](../../cli/cli-ref/managed-services/vpc/security-group/get.md) — для группы безопасности `ddos-sg-vms`.

  1. Создайте YAML-файл с именем `specification.yaml`.
  1. Добавьте в него описание конфигурации базовой виртуальной машины:

     ```yaml
     name: ddos-group
     service_account_id: <идентификатор сервисного аккаунта>
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
                 image_id: <идентификатор образа>
                 type_id: network-hdd
                 size: 3g
         network_interface_specs:
             - network_id: <идентификатор облачной сети>
               subnet_ids:
                 - <идентификатор подсети в зоне {{ region-id }}-a>
                 - <идентификатор подсети в зоне {{ region-id }}-b>
                 - <идентификатор подсети в зоне {{ region-id }}-c>
               primary_v4_address_spec: {}
               security_group_ids:
                 - <идентификатор группы безопасности ddos-sg-vms>
     deploy_policy:
         max_unavailable: 1
         max_expansion: 0
     scale_policy:
         fixed_scale:
             size: 2
     allocation_policy:
         zones:
             - zone_id: {{ region-id }}-a
             - zone_id: {{ region-id }}-b
             - zone_id: {{ region-id }}-c
     application_load_balancer_spec:
         target_group_spec:
             name: tg-ddos
     ```

  1. Создайте группу виртуальных машин в каталоге по умолчанию:

     ```bash
     yc compute instance-group create \
       --file specification.yaml
     ```

     Результат:

     ```bash
     done (25s)
     id: cl1qjhlcdofg6rujs29d
     folder_id: b1g86q4m5vej8lkljme5
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
           image_id: fd8r6kq84o7be9tm50ms
       network_interface_specs:
       - network_id: enp3srbi9u49pjvcejnb
         subnet_ids:
         - e9b17pi15695qc0mngl2
         - e2lt87g1rligsso4ketj
         - b0c7kl8riq244aq2mfc1
         primary_v4_address_spec: {}
         security_group_ids:
         - enpi08rif04dcugga5e3
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
       - zone_id: {{ region-id }}-a
       - zone_id: {{ region-id }}-b
       - zone_id: {{ region-id }}-c
     load_balancer_state: {}
     managed_instances_state:
       target_size: "2"
     service_account_id: aje2stn6id9k43qk7n7l
     status: ACTIVE
     application_load_balancer_spec:
       target_group_spec:
         name: first-target-group
     application_load_balancer_state:
       target_group_id: ds78imh0ds2eluau7ojp
     ```

     Подробнее о команде `yc compute instance-group create` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/compute/instance-group/create.md).

- {{ TF }}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

{% endlist %}

## Зарезервируйте статический публичный IP-адрес {#reserve-ip}

{% note info %}

Этот шаг нельзя выполнить через [интерфейс командной строки (CLI)](../../cli/).

{% endnote %}

Чтобы защитить балансировщик от DDoS-атак, необходимо зарезервировать для него статический публичный IP-адрес с опцией **Защита от DDoS**:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ vpc-name }}**.
  1. Откройте вкладку **IP-адреса** и нажмите кнопку **Зарезервировать адрес**.
  1. Выберите зону доступности, в которой нужно зарезервировать адрес.
  1. Включите опцию **Защита от DDoS**.
  1. Нажмите кнопку **Зарезервировать**.

- {{ TF }}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

{% endlist %}

## Создайте группу бэкендов {#create-backend-group}

Целевую группу, созданную вместе с группой ВМ, нужно привязать к [группе бэкендов](../../application-load-balancer/concepts/backend-group.md) с настройками распределения трафика.

Для бэкендов в группах будут созданы [проверки состояния](../../application-load-balancer/concepts/backend-group.md#health-checks): балансировщик будет периодически отправлять проверочные запросы к ВМ и ожидать ответа в течение определенного периода.

Чтобы создать группу бэкендов:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ alb-name }}**.
  1. Откройте вкладку **Группы бэкендов**. Нажмите кнопку **Создать группу бэкендов**.
  1. Укажите **Имя** группы бэкендов: `ddos-backend-group`.
  1. В блоке **Бэкенды** нажмите кнопку **Добавить**.
  1. Укажите **Имя** бэкенда: `backend-1`.
  1. В поле **Целевая группа** выберите группу `tg-ddos`.
  1. Укажите **Порт**, на котором ВМ бэкенда будут принимать входящий трафик от балансировщика: `80`.
  1. Нажмите кнопку **Добавить проверку состояния**.
  1. Укажите **Порт**, на котором ВМ бэкенда будут принимать проверочные соединения: `80`.
  1. Укажите **Путь**, к которому будет обращаться балансировщик при проверке состояния: `/`.
  1. Нажмите кнопку **Создать**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Создайте группу бэкендов:

     ```bash
     yc alb backend-group create ddos-backend-group
     ```

     Результат:

     ```bash
     id: a5dg2cv4ngne8575fb1p
     name: ddos-backend-group
     folder_id: aoerb349v3h4bupphtaf
     created_at: "2021-08-08T20:46:21.688940670Z"
     ```

     Подробнее о команде `yc alb backend-group create` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/backend-group/create.md).

  1. Добавьте в группу бэкенд и проверку состояния:

     ```bash
     yc alb backend-group add-http-backend \
       --backend-group-name ddos-backend-group \
       --name backend-1 \
       --weight 1 \
       --port 80 \
       --target-group-id=<идентификатор целевой группы> \
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

     ```bash
     done (21s)
     id: ds7fea2pggr2e2vlncd5
     name: ddos-backend-group
     folder_id: b1g86q4m5vej8lkljme5
     http:
     backends:
     - name: backend-1
       backend_weight: "1"
       port: "80"
       target_groups:
         target_group_ids:
         - ds78ate00f8e7c0p1rem
       healthchecks:
       - timeout: 1s
         interval: 1s
         healthcheck_port: "80"
         http:
           path: /
     created_at: "2021-08-08T07:59:22.922603189Z"
     ```

     Подробнее о команде `yc alb backend-group add-http-backend` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/backend-group/add-http-backend.md).

- {{ TF }}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

{% endlist %}

## Создайте HTTP-роутер {#create-http-routers-sites}

Группу бэкендов нужно привязать к [HTTP-роутеру](../../application-load-balancer/concepts/http-router.md) с правилами маршрутизации HTTP-запросов.

Чтобы создать HTTP-роутер и добавить в него маршрут:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ alb-name }}**.
  1. Откройте вкладку **HTTP-роутеры**. Нажмите кнопку **Создать HTTP-роутер**.
  1. Укажите **Имя** HTTP-роутера: `ddos-router`.
  1. Нажмите кнопку **Добавить виртуальный хост**.
  1. Укажите **Имя** виртуального хоста: `ddos-host`.
  1. Укажите значение Authority: `alb-with-ddos.com`.
  1. Нажмите кнопку **Добавить маршрут**.
  1. Введите **Имя**: `route-1`.
  1. В поле **Путь** выберите `Начинается с` и укажите путь `/`.
  1. В поле **Действие** оставьте `Маршрутизация`.
  1. В списке **Группа бэкендов** выберите созданную ранее группу.
  1. Остальные настройки оставьте без изменений и нажмите кнопку **Создать**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Выполните команду:

     ```bash
     yc alb http-router create ddos-router
     ```

     Результат:

     ```bash
     id: a5dcsselagj4o2v4a6e7
     name: ddos-router
     folder_id: aoerb349v3h4bupphtaf
     created_at: "2021-08-08T21:04:59.438292069Z"
     ```

     Подробнее о команде `yc alb http-router create` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/http-router/create.md).

  1. Создайте виртуальный хост, указав имя HTTP-роутера:

     ```bash
     yc alb virtual-host create ddos-host \
       --http-router-name ddos-router
       --authority alb-with-ddos.com
     ```

     Подробнее о команде `yc alb virtual-host create` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/virtual-host/create.md).

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

     ```bash
     done (1s)
      name: ddos-host
      routes:
      - name: route-1
        http:
          match:
            path:
              prefix_match: /
          route:
            backend_group_id: ds7fea2pggr2e2vlncd5
            timeout: 60s
     ```

     Подробнее о команде `yc alb virtual-host append-http-route` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/virtual-host/append-http-route.md).

- {{ TF }}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

{% endlist %}

## Создайте балансировщик {#create-balancer}

Чтобы создать балансировщик:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ alb-name }}**.
  1. В меню слева выберите **Балансировщики**.
  1. Нажмите кнопку **Создать L7-балансировщик**.
  1. Введите имя балансировщика: `ddos-protect-alb`.
  1. В блоке **Сетевые настройки** выберите сеть `ddos-network` и группу безопасности `ddos-sg-balancer`.
  1. В блоке **Размещение** выберите подсети для узлов балансировщика в каждой зоне доступности и включите передачу трафика.
  1. В блоке **Обработчики** нажмите кнопку **Добавить обработчик**. Задайте настройки обработчика:

     1. Введите имя обработчика: `ddos-listener`.
     1. В блоке **Настройки публичного IP-адреса** включите передачу трафика.
     1. Укажите порт `80`.
     1. Выберите тип **Список** и укажите [зарезервированный ранее](#reserve-ip) адрес с защитой от DDoS.

  1. В поле **HTTP-роутер** выберите `ddos-router`.
  1. Нажмите кнопку **Создать**.

- CLI

  1. Создайте балансировщик с узлами в подсетях облачной сети:

      ```bash
      yc alb load-balancer create ddos-protect-alb \
        --network-name ddos-network \
        --location subnet-name=ddos-network-ru-a,zone={{ region-id }}-a \
        --location subnet-name=ddos-network-ru-b,zone={{ region-id }}-b \
        --location subnet-name=ddos-network-ru-c,zone={{ region-id }}-c
      ```

      Подробнее о команде `yc alb load-balancer create` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/load-balancer/create.md).

  1. Добавьте обработчик:

      ```bash
      yc alb load-balancer add-listener ddos-protect-alb \
        --listener-name ddos-listener \
        --http-router-id <идентификатор HTTP-роутера> \
        --external-ipv4-endpoint port=80, address=<IP-адрес с защитой от DDoS>
      ```

      Подробнее о команде `yc alb load-balancer add-listener` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/load-balancer/add-listener.md).

- {{ TF }}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

{% endlist %}

## Проверьте работу балансировщика {#test-work}

Проверьте доступность сервиса на хосте `alb-with-ddos.com`. Для этого выполните команду:

```bash
curl -H "Host: alb-with-ddos.com" http://<IP-адрес L7-балансировщика>
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

## Удалите созданные ресурсы {#delete-resources}

Чтобы остановить работу хостинга и перестать платить за созданные ресурсы:

1. Удалите нетарифицируемые ресурсы, которые блокируют удаление тарифицируемых ресурсов:

   1. [Удалите](../../application-load-balancer/operations/application-load-balancer-delete.md) L7-балансировщик `ddos-protect-alb`.
   1. [Удалите](../../application-load-balancer/operations/http-router-delete.md) HTTP-роутер `ddos-router`.
   1. [Удалите](../../application-load-balancer/operations/backend-group-delete.md) группу бэкендов `ddos-backend-group`.

1. [Удалите](../../compute/operations/instance-groups/delete.md) группу виртуальных машин `ddos-group`.
1. [Удалите](../../vpc/operations/address-delete.md) зарезервированный статический публичный адрес.

## Как создать инфраструктуру с помощью {{ TF }} {#terraform}

{% include [terraform-definition](../terraform-definition.md) %}

Чтобы создать L7-балансировщик с защитой от DDoS-атак с помощью {{ TF }}:

1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файл с описанием инфраструктуры:

   {% list tabs %}

   - Готовый архив

     1. Создайте папку для файла с описанием инфраструктуры.
     1. Скачайте [архив](https://{{ s3-storage-host }}/doc-files/alb-with-ddos-protection.zip) (3 КБ).
     1. Разархивируйте архив в папку. В результате в ней должны появиться конфигурационный файл `alb-with-ddos-protection.tf` и файл с пользовательскими данными `alb-with-ddos-protection.auto.tfvars`.

   - Создание вручную

     1. Создайте папку для файла с описанием инфраструктуры.
     1. Создайте в папке конфигурационный файл `alb-with-ddos-protection.tf`:

          {% cut "Содержимое файла alb-with-ddos-protection.tf" %}

          {% include [alb-with-ddos-protection-tf-config](../../_includes/web/alb-with-ddos-protection-tf-config.md) %}

          {% endcut %}

     1. Создайте в папке файл с пользовательскими данными `alb-with-ddos-protection.auto.tfvars`:

          {% cut "Содержимое файла alb-with-ddos-protection.auto.tfvars" %}

          {% include [alb-with-ddos-protection-tf-variables](../../_includes/web/alb-with-ddos-protection-tf-variables.md) %}

          {% endcut %}

   {% endlist %}

   {% include [sg-note-tf](../../_includes/vpc/sg-note-tf.md) %}

   Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:

   * [yandex_iam_service_account]({{ tf-provider-link }}/iam_service_account)
   * [yandex_resourcemanager_folder_iam_member]({{ tf-provider-link }}/resourcemanager_folder_iam_member)
   * [yandex_vpc_network]({{ tf-provider-link }}/vpc_network)
   * [yandex_vpc_subnet]({{ tf-provider-link }}/vpc_subnet)
   * [yandex_vpc_security_group]({{ tf-provider-link }}/vpc_security_group)
   * [yandex_compute_image]({{ tf-provider-link }}/compute_image)
   * [yandex_compute_instance_group]({{ tf-provider-link }}/compute_instance_group)
   * [yandex_vpc_address]({{ tf-provider-link }}/vpc_address)
   * [yandex_alb_backend_group]({{ tf-provider-link }}/alb_backend_group)
   * [yandex_alb_http_router]({{ tf-provider-link }}/alb_http_router)
   * [yandex_alb_virtual_host]({{ tf-provider-link }}/alb_virtual_host)
   * [yandex_alb_load_balancer]({{ tf-provider-link }}/alb_load_balancer)

1. В файле `alb-with-ddos-protection.auto.tfvars` задайте пользовательские параметры:

    * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
    * `vm_user` — имя пользователя ВМ.
    * `ssh_key_path` — путь к файлу с открытым SSH-ключом для аутентификации пользователя на ВМ. Подробнее см. [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

1. Создайте ресурсы:

   {% include [terraform-validate-plan-apply](../terraform-validate-plan-apply.md) %}

1. [Проверьте работу балансировщика](#test-work).
