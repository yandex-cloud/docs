# Развертывание веб-приложения на серверах Yandex BareMetal с L7-балансировщиком и защитой Smart Web Security

# Развертывание веб-приложения на серверах Yandex BareMetal с L7-балансировщиком и защитой Yandex Smart Web Security


В этом руководстве вы развернете веб-приложение на [серверах](../../baremetal/concepts/servers.md) Yandex BareMetal. Для обеспечения равномерного распределения нагрузки на хосты с приложением вы настроите [L7-балансировщик](../../application-load-balancer/concepts/application-load-balancer.md) Yandex Application Load Balancer. Создаваемое веб-приложение будет защищено от ботов, [DDoS](../../glossary/ddos.md)- и веб-атак в помощью [профиля безопасности](../concepts/profiles.md) Yandex Smart Web Security. [Приватное соединение](../../interconnect/concepts/priv-con.md) между [облачной сетью](../../vpc/concepts/network.md#network) Yandex Virtual Private Cloud и [приватной сетью](../../baremetal/concepts/private-network.md) Yandex BareMetal обеспечивается с помощью [Routing Instance](../../cloud-router/concepts/routing-instance.md) Yandex Cloud Interconnect.

Схема решения:

![webapp-on-bms-behind-sws](../../_assets/tutorials/webapp-on-bms-behind-sws.svg)

Где:
* Инфраструктура на стороне BareMetal, которая включает в себя:

    * приватную подсеть `subnet-m4` в [пуле](../../baremetal/concepts/servers.md#server-pools) серверов `ru-central1-m4`;
    * [виртуальный сегмент сети](../../baremetal/concepts/private-network.md#vrf-segment) (VRF) `my-vrf`;
    * два сервера BareMetal в пуле серверов `ru-central1-m4` с развернутым веб-приложением — `alb-back-0` и `alb-back-1`.
* `Routing Instance` Cloud Interconnect, который обеспечивает сетевую связность между сетями Virtual Private Cloud и BareMetal.
* Инфраструктура на стороне [Virtual Private Cloud](../../vpc/index.md), которая включает в себя:

    * облачную сеть `sample-network`;
    * [подсети](../../vpc/concepts/network.md#subnet) `vpc-subnet-a` и `vpc-subnet-b` в [зонах доступности](../../overview/concepts/geo-scope.md) `ru-central1-a` и `ru-central1-b`;
    * L7-балансировщик Application Load Balancer `demo-alb-bms`;
    * профиль безопасности Smart Web Security `sws-demo-profile`;
    * [виртуальную машину](../../compute/concepts/vm.md) `vm-validator`, используемую для проверки сетевой связности между сетями Virtual Private Cloud и BareMetal.

Чтобы развернуть веб-приложение на серверах Yandex BareMetal с L7-балансировщиком и защитой Yandex Smart Web Security:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Подготовьте окружение VPC](#setup-vpc).
1. [Создайте Routing Instance](#create-routing-instance).
1. [Подготовьте окружение BareMetal](#setup-baremetal).
1. [Настройте L7-балансировщик](#setup-balancer).
1. [Настройте защиту от ботов, DDoS- и веб-атак](#setup-sws).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для развертывания веб-приложения на серверах BareMetal с L7-балансировщиком и защитой Smart Web Security входят:

* плата за использование [публичного IP-адреса](../../vpc/concepts/address.md#public-addresses) виртуальной машины (см. [тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md));
* плата за вычислительные ресурсы и диски [ВМ](../../compute/concepts/vm.md) (см. [тарифы Yandex Compute Cloud](../../compute/pricing.md));
* плата за аренду серверов BareMetal (см. [тарифы Yandex BareMetal](../../baremetal/pricing.md));
* плата за использование вычислительных ресурсов L7-балансировщика (см. [тарифы Yandex Application Load Balancer](../../application-load-balancer/pricing.md));
* плата за запросы, обработанные правилами профиля безопасности (см. [тарифы Yandex Smart Web Security](../pricing.md));
* при использовании [лог-группы](../../logging/concepts/log-group.md) для записи логов балансировщика плата за запись и хранение данных (см. [тарифы Yandex Cloud Logging](../../logging/pricing.md)).

Трафик между приватными адресами Yandex BareMetal и Yandex Virtual Private Cloud, передаваемый в обоих направлениях через [Yandex Cloud Interconnect](../../interconnect/index.md), не тарифицируется.

## Подготовьте окружение VPC {#setup-vpc}

Настройте инфраструктуру на стороне Virtual Private Cloud. На этом этапе вы создадите [облачную сеть](../../vpc/concepts/network.md#network), [подсети](../../vpc/concepts/network.md#subnet), необходимые [группы безопасности](../../vpc/concepts/security-groups.md) и [виртуальную машину](../../compute/concepts/vm.md).

### Создайте облачную сеть {#create-network}

{% list tabs group=instructions %}

- Консоль управления {#console} 

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы будете создавать инфраструктуру.
  1. Перейдите в сервис **Virtual Private Cloud**.
  1. Справа сверху нажмите **Создать сеть**.
  1. В поле **Имя** укажите `sample-network`.
  1. В поле **Дополнительно** отключите опцию **Создать подсети**.
  1. Нажмите кнопку **Создать сеть**.

{% endlist %}

### Создайте подсети {#create-subnets}

{% list tabs group=instructions %}

- Консоль управления {#console} 

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете облачную инфраструктуру.
  1. Перейдите в сервис **Virtual Private Cloud**.
  1. На панели слева выберите ![subnets](../../_assets/console-icons/nodes-right.svg) **Подсети**.
  1. Справа сверху нажмите **Создать подсеть**.
  1. В поле **Имя** укажите `vpc-subnet-a`.
  1. В поле **Зона доступности** выберите зону доступности `ru-central1-a`.
  1. В поле **Сеть** выберите облачную сеть `sample-network`.
  1. В поле **CIDR** укажите `192.168.6.0/24`.
  
      {% note warning %}
      
      Для успешной настройки сетевой связности между подсетями BareMetal и подсетями VPC/on-prem, их диапазоны адресов, заданные CIDR, не должны совпадать или пересекаться.
      
      {% endnote %}

  1. Нажмите **Создать подсеть**.
  1. Аналогичным способом создайте в сети `sample-network` подсеть `vpc-subnet-b` в зоне доступности `ru-central1-b` с CIDR `192.168.11.0/24`.

{% endlist %}

### Создайте группы безопасности {#create-sg}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете облачную инфраструктуру.
  1. Перейдите в сервис **Virtual Private Cloud**.
  1. На панели слева выберите ![image](../../_assets/console-icons/shield.svg) **Группы безопасности** и нажмите кнопку **Создать группу безопасности**.
  1. В поле **Имя** задайте имя `vpc-ingress-sg`.
  1. В поле **Сеть** выберите созданную ранее сеть `sample-network`.
  1. В блоке **Правила** [создайте](../../vpc/operations/security-group-add-rule.md) следующие правила для управления трафиком:

      | Направление<br/>трафика | Описание | Диапазон портов | Протокол | Источник /<br/>Назначение | CIDR блоки /<br/>Группа безопасности |
      | --- | --- | --- | --- | --- | --- |
      | Входящий | `http`            | `80`   | `TCP`  | `CIDR` | `0.0.0.0/0` |
      | Входящий | `https`            | `443`   | `TCP`  | `CIDR` | `0.0.0.0/0` |
      | Входящий | `ssh`            | `22`   | `TCP`  | `CIDR` | `0.0.0.0/0` |
      | Исходящий | `any`           | `Весь` | `Любой` | `CIDR` | `0.0.0.0/0` |
  1. Нажмите **Создать**.
  1. Аналогичным способом создайте в сети `sample-network` [группу безопасности](../../vpc/concepts/security-groups.md) `alb-sg` со следующими правилами:

      | Направление<br/>трафика | Описание | Диапазон портов | Протокол | Источник /<br/>Назначение | CIDR блоки /<br/>Группа безопасности |
      | --- | --- | --- | --- | --- | --- |
      | Входящий | `http`            | `80`   | `TCP`  | `CIDR` | `0.0.0.0/0` |
      | Входящий | `healthchecks`            | `30080`   | `TCP`  | `Проверки состояния балансировщика` | — |
      | Исходящий | `any`           | `Весь` | `Любой` | `CIDR` | `0.0.0.0/0` |

{% endlist %}

### Создайте виртуальную машину {#create-vm}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете инфраструктуру.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **Виртуальные машины** и нажмите кнопку **Создать виртуальную машину**.
  1. В блоке **Образ загрузочного диска** выберите образ [Ubuntu 24.04](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2404-lts-oslogin).
  1. В блоке **Расположение** выберите [зону доступности](../../overview/concepts/geo-scope.md) `ru-central1-a`.
  1. В блоке **Сетевые настройки**:

      * В поле **Подсеть** выберите созданную ранее подсеть `vpc-subnet-a`.
      * В поле **Публичный IP-адрес** выберите `Автоматически`.
      * В поле **Группы безопасности** выберите созданную ранее группу безопасности `vpc-ingress-sg`.

  1. В блоке **Доступ** выберите вариант **SSH-ключ** и укажите данные для доступа на ВМ:

      * В поле **Логин** введите имя пользователя: `yc-user`.
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

  1. В блоке **Общая информация** задайте имя ВМ: `vm-validator`.
  1. Нажмите кнопку **Создать ВМ**.

{% endlist %}

## Создайте Routing Instance {#create-routing-instance}

Для организации сетевой связности между подсетями BareMetal и подсетями Virtual Private Cloud необходимо создать ресурс [Routing Instance](../../cloud-router/concepts/routing-instance.md). `Routing Instance` можно создать через [обращение](https://center.yandex.cloud/support/tickets/create) в службу технической поддержки.

Если в вашем каталоге уже есть настроенная сетевая связность с использованием [Cloud Interconnect](../../interconnect/index.md) (VPC-to-On-Prem), то вы можете как использовать уже существующий `Routing Instance`, так и запросить создание нового, дополнительного `Routing Instance` для организации обособленной сетевой связности.

### Проверьте наличие Routing Instance в вашем каталоге {#check-for-ri}

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. Проверьте наличие Routing Instance в каталоге по умолчанию:
   
   {% list tabs group=instructions %}
   
   - CLI {#cli}
   
     Выполните команду:
   
     ```bash
     yc cloudrouter routing-instance list
     ```
   
     Если в вашем каталоге уже есть Routing Instance, команда выведет приблизительно такой результат:
   
     ```text
     +----------------------+-------------------------------------------+--------+-----------------------+
     |          ID          |                    NAME                   | STATUS | PRIVATE CONNECTION ID |
     +----------------------+-------------------------------------------+--------+-----------------------+
     | cf35oot8f0eu******** | ajeol2afu1js********-enpcfncr6uld******** | ACTIVE | cf395uf8dg7h********  |
     +----------------------+-------------------------------------------+--------+-----------------------+
     ```
   
   {% endlist %}

1. Если у вас уже есть `Routing Instance`, вы можете пропустить следующий шаг и [переходить](#setup-baremetal) к подготовке окружения BareMetal.

    Если у вас нет `Routing Instance` или вы хотите построить дополнительную, обособленную сетевую связность, [запросите](#request-ri) создание нового `Routing Instance`.

### Запросите создание Routing Instance {#request-ri}

[Обратитесь](https://center.yandex.cloud/support/tickets/create) в службу технической поддержки для создания `Routing Instance` в вашем каталоге.

Оформите ваше обращение следующим образом:

```text
Тема: [CIC для BareMetal] Создать Routing Instance.

Текст обращения:
Прошу Создать Routing Instance в указанном облачном каталоге со следующими параметрами:

folder_id: <идентификатор_каталога>

vpc:
  vpc_net_id: <идентификатор_сети>
    vpc_subnets: 
      ru-central1-a: [CIDR_a1, CIDR_a2, ..., CIDR_an]
      ru-central1-b: [CIDR_b1, CIDR_b2, ..., CIDR_bn]
      ru-central1-d: [CIDR_d1, CIDR_d2, ..., CIDR_dn]
```

Где:
* `folder_id` — [идентификатор](../../resource-manager/operations/folder/get-id.md) каталога.
* `vpc_net_id` — [идентификатор](../../vpc/operations/network-get-info.md) облачной сети.
* `vpc_subnets` — список [анонсируемых](../../interconnect/concepts/priv-con.md#prc-announce) адресных префиксов для каждой из [зон доступности](../../overview/concepts/geo-scope.md). Например, для созданной ранее подсети VPC вы укажете `ru-central1-b: [192.168.11.0/24]`.

    Допускается анонсирование адресных префиксов с [агрегированием](../../interconnect/concepts/priv-con.md#agg-subnets).

{% note info %}

Создание `Routing Instance` службой технической поддержки может занять до 24 часов. В результате вы сможете получить идентификатор созданного `Routing Instance`, выполнив команду [Yandex Cloud CLI](../../cli/index.md) `yc cloudrouter routing-instance list`.

{% endnote %}

## Подготовьте окружение BareMetal {#setup-baremetal}

Настройте инфраструктуру на стороне BareMetal. На этом этапе вы создадите [виртуальный сегмент сети (VRF)](../../baremetal/concepts/private-network.md#vrf-segment), [приватную подсеть](../../baremetal/concepts/private-network.md#private-subnet) и настроите [приватное соединение](../../baremetal/concepts/private-network.md#private-connection-to-vpc) с облачной сетью, а также арендуете два [сервера](../../baremetal/concepts/servers.md) BareMetal.

### Создайте виртуальный сегмент сети и приватную подсеть {#setup-vrf}

Создайте VRF и приватную подсеть в [пуле серверов](../../baremetal/concepts/servers.md#server-pools) `ru-central1-m4`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете инфраструктуру.
  1. Перейдите в сервис **BareMetal**.
  1. Создайте виртуальный сегмент сети:
        1. На панели слева выберите ![icon](../../_assets/console-icons/vector-square.svg) **VRF** и нажмите кнопку **Создать VRF**.
        1. В поле **Имя** задайте имя VRF: `my-vrf`.
        1. Нажмите кнопку **Создать VRF**.
  1. Создайте приватную подсеть:
        1. На панели слева выберите ![icon](../../_assets/console-icons/nodes-right.svg) **Приватные подсети** и нажмите кнопку **Создать подсеть**.
        1. В поле **Пул** выберите пул серверов `ru-central1-m4`.
        1. В поле **Имя** задайте имя подсети: `subnet-m4`.
        1. Включите опцию **IP-адресация и маршрутизация**.
        1. В поле **Виртуальный сетевой сегмент (VRF)** выберите созданный ранее сегмент `my-vrf`.
        1. В поле **CIDR** укажите `172.28.4.0/24`.
        1. В поле **Шлюз по умолчанию** оставьте значение по умолчанию `172.28.4.1`.
        1. Включите опцию **Назначение IP-адресов по DHCP** и в появившемся поле **Диапазон IP-адресов** оставьте значения по умолчанию: `172.28.4.1` — `172.28.4.254`.
        1. Нажмите кнопку **Создать подсеть**.

{% endlist %}

### Настройте приватное соединение с облачной сетью {#connect-to-vpc}

Создайте [приватное соединение](../../baremetal/concepts/private-network.md#private-connection-to-vpc) Cloud Interconnect в сервисе BareMetal:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать приватное соединение.
  1. Перейдите в сервис **BareMetal**.
  1. На панели слева выберите ![icon](../../_assets/console-icons/vector-square.svg) **VRF** и выберите нужный виртуальный сегмент сети.
  1. В блоке **Приватное соединение с облачными сетями** нажмите кнопку **Настроить соединение** и в открывшемся окне:

      1. В поле **Способ настройки** выберите вариант `Указать идентификатор` и в поле **Идентификатор соединения** вставьте идентификатор приватного соединения `Routing Instance`.

          Вы также можете выбрать вариант `Выбрать из каталога`. В этом случае в появившемся списке выберите нужный `Routing Instance`.

          В результате в форме отобразятся CIDR подсетей Virtual Private Cloud, которые будут [анонсироваться](../../interconnect/concepts/priv-con.md#prc-announce) в Cloud Interconnect.

          {% note warning %}
          
          Для успешной настройки сетевой связности между подсетями BareMetal и подсетями VPC/on-prem, их диапазоны адресов, заданные CIDR, не должны совпадать или пересекаться.
          
          {% endnote %}
      1. Чтобы создать приватное соединение с указанными CIDR подсетей, нажмите кнопку **Сохранить**.

  В результате на странице с информацией о VRF в блоке **Приватное соединение с облачными сетями** отобразится идентификатор созданного соединения и его статус.

- API {#api}

  Чтобы создать приватное соединение с облачными сетями, воспользуйтесь методом REST API [PrivateCloudConnection.Create](../../baremetal/api-ref/PrivateCloudConnection/create.md) или вызовом gRPC API [PrivateCloudConnectionService/Create](../../baremetal/api-ref/grpc/PrivateCloudConnection/create.md).

  Выполните запрос:

  ```bash
  curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer <IAM-токен>" \
    -d '{
      "routingInstanceId":"fokrf2in3c7********",
      "vrfId":"ly5uyq2gbxu2********"
      }' \
    "https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/privateCloudConnections"
  ```

  Где:

  * `routingInstanceId` — идентификатор [Routing Instance](../../cloud-router/concepts/routing-instance.md) в Cloud Router.
  * `vrfId` — идентификатор VRF, который подключается к Routing Instance. Чтобы получить идентификатор VRF, воспользуйтесь методом [VrfService.List](../../baremetal/api-ref/Vrf/list.md).

  Результат:

  ```json
  {
    "done": false,
    "id": "arpas4mne3********",
    "description": "Create private cloud connection",
    "createdAt": "2024-01-01T12:00:00Z",
    "createdBy": "user-id",
    "modifiedAt": "2024-01-01T12:00:00Z",
    "metadata": {
      "privateCloudConnectionId": "kor4msi1aqq********"
    }
  }
  ```

  Операция создания приватного соединения выполняется асинхронно. Отслеживайте статус операции по полю `done`.

{% endlist %}

{% note info %}

Создание приватного соединения может занять до двух рабочих дней — в это время соединение будет находиться в статусе `Creating`. После создания статус соединения изменится на `Ready`.

{% endnote %}

Приватное соединение c облачными сетями может находиться в одном из следующих статусов:

* `CREATING` — соединение создается.
* `READY` — соединение сконфигурировано и готово к работе.
* `ERROR` — возникла проблема с приватным соединением, для устранения необходимо обратиться в поддержку.
* `DELETING` — соединение удаляется.
* `UPDATING` — настройки приватного соединения обновляются.

### Арендуйте серверы BareMetal {#rent-servers}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете инфраструктуру.
  1. Перейдите в сервис **BareMetal**.
  1. Нажмите кнопку **Заказать сервер** и в открывшемся окне выберите вариант `Готовые конфигурации` и подходящую [конфигурацию](../../baremetal/concepts/server-configurations.md) сервера BareMetal в пуле серверов `ru-central1-m4`.

      Для этого в фильтре в правой части окна в блоке **Пул** выберите пул серверов `ru-central1-m4`.

      Чтобы выбрать подходящую вам конфигурацию сервера, нажмите на блок с именем этой конфигурации в центральной части экрана.

      {% note tip %}
      
      Вы можете снизить стоимость аренды сервера в некоторых конфигурациях, заказав его [сборку](../../baremetal/concepts/server-custom-configurations.md#assembly).
      
      Чтобы воспользоваться скидкой, в блоке с нужной конфигурацией наведите курсор на **Дешевле со сборкой** ![circle-info.svg](../../_assets/console-icons/circle-info.svg) и во всплывающем окне нажмите ![person-nut-hex.svg](../../_assets/console-icons/person-nut-hex.svg) **Перейти к сборке**.
      
      При заказе сервера со сборкой воспользуйтесь приведенной ниже инструкцией, чтобы задать необходимые параметры сервера. При этом сервер станет доступен вам не сразу, а после завершения сборки (в течение четырех календарных дней) и по более низкой цене.
      
      {% endnote %}

  1. В открывшемся окне с настройками конфигурации сервера:

      1. В поле **Период аренды** выберите период, на который вы заказываете аренду — `1 день`.

          По окончании указанного периода аренда сервера будет автоматически продлена на такой же период. Прервать аренду в течение указанного периода аренды нельзя, но можно [отказаться](../../baremetal/operations/servers/server-lease-cancel.md) от дальнейшего продления аренды сервера.

      1. В блоке **Образ** выберите образ `Debian 11`.
      1. В блоке **Сетевые интерфейсы**:
          1. В поле **Приватная подсеть** выберите созданную ранее подсеть `subnet-m3`.
          1. В поле **Публичный адрес** выберите `Из эфемерной подсети`.

      1. В блоке **Доступ**:

          1. В поле **Пароль** воспользуйтесь одним из вариантов создания пароля для root-пользователя:
          
              * Чтобы сгенерировать пароль для root-пользователя, выберите опцию `Новый пароль` и нажмите кнопку **Сгенерировать**.
          
                  {% note warning %}
                  
                  Этот вариант предусматривает ответственность пользователя за безопасность пароля. Сохраните сгенерированный пароль в надежном месте: он не сохраняется в Yandex Cloud, и после заказа сервера вы не сможете посмотреть его.
                  
                  {% endnote %}
          
              * Чтобы использовать пароль root-пользователя, сохраненный в [секрете](../../lockbox/concepts/secret.md) Yandex Lockbox, выберите опцию `Секрет Lockbox`:
          
                  В полях **Имя**, **Версия** и **Ключ** выберите соответственно секрет, его версию и ключ, в которых сохранен ваш пароль.
                  
                  Если у вас еще нет секрета Yandex Lockbox, нажмите кнопку **Создать**, чтобы создать его.
          
                  Этот вариант позволяет вам как задать собственный пароль (тип секрета `Пользовательский`), так и использовать пароль, сгенерированный автоматически (тип секрета `Генерируемый`).
          
          1. В поле **Открытый SSH-ключ** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../organization/concepts/membership.md).
          
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

      1. В блоке **Информация о сервере** в поле **Имя** задайте имя сервера: `alb-back-0`.
      1. Нажмите кнопку **Заказать сервер**.
  1. Аналогичным способом арендуйте в пуле серверов `ru-central1-m4` еще один сервер `alb-back-1`.

{% endlist %}

{% note info %}

Подготовка сервера и установка на него операционной системы может занять до 45 минут — в это время сервер будет находиться в статусе `Provisioning`. После завершения установки ОС сервер перейдет в статус `Ready`.

{% endnote %}

### Разверните веб-приложение {#deploy-web-service}

На этом этапе вы развернете веб-приложение на серверах BareMetal. Веб-приложением на серверах будут использованы следующие ресурсы:
* `/opt/mygoapp` — рабочая директория веб-сервера.
* `/opt/mygoapp/server` — исполняемый файл веб-сервера.
* `/etc/systemd/system/mygoapp.service` — файл конфигурации сервиса для управления веб-сервером через [systemd](https://ru.wikipedia.org/wiki/Systemd).

Чтобы развернуть веб-приложение на сервере:

1. [Подключитесь по SSH](../../compute/operations/vm-connect/ssh.md) к серверу BareMetal `alb-back-0`:

    ```bash
    ssh root@<публичный_IP-адрес_сервера>
    ```

    Публичный IP-адрес сервера можно узнать в [консоли управления](https://console.yandex.cloud) на странице **Обзор** с информацией о сервере BareMetal. Нужный адрес указан в блоке **Сетевые интерфейсы** в поле **Публичный адрес**.

    Все последующие действия этого шага выполняются в терминале сервера.
1. Подготовьте рабочую директорию:

    ```bash
    mkdir -p /opt/mygoapp && cd /opt/mygoapp
    ```
1. Загрузите исполняемый файл веб-сервера:

    ```bash
    wget https://storage.yandexcloud.net/yc-public-share/server
    ```
1. Установите для скачанного файла разрешение на исполнение:

    ```bash
    chmod +x server
    ```
1. Создайте в `systemd` новый сервис:

    1. Откройте файл конфигурации создаваемого сервиса:

        ```bash
        nano /etc/systemd/system/mygoapp.service
        ```
    1. Вставьте в открытый файл следующее содержимое:

        ```
        [Unit]
        Description=Simple Web Server on Go
        After=network.target
        [Service]
        Type=simple
        WorkingDirectory=/opt/mygoapp
        ExecStart=/opt/mygoapp/server
        Restart=always
        RestartSec=5
        [Install]
        WantedBy=multi-user.target
        ```
    1. Закройте файл, сохранив изменения.
1. Инициализируйте созданный сервис:

    ```bash
    systemctl daemon-reload
    ```
1. Запустите сервис:

    ```bash
    systemctl start mygoapp.service
    ```
1. Проверьте работу веб-приложения. Для этого на вашем локальном компьютере вставьте публичный IP-адрес сервера `alb-back-0` в адресную строку браузера. 

    В результате в окне браузера откроется страница с именем хоста и информацией о продолжительности работы веб-сервера с момента его запуска.

    {% cut "Исходный код создаваемого веб-приложения" %}

    ```go
    package main

    import (
      "context"
      "fmt"
      "net/http"
      "os"
      "os/signal"
      "syscall"
      "time"
      "github.com/gorilla/handlers"
    )

    var (
      hostname    string
      htmlContent []byte
    )

    const (
      serverTimeout  = 5 * time.Second
      cacheDuration  = 86400 * 30 // 30 дней в секундах
      htmlTemplate = `
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <!-- Минифицированный CSS -->
        <style>*{margin:0;padding:0;box-sizing:border-box;font-family:'Segoe UI',system-ui,sans-serif}body{min-height:100vh;display:flex;justify-content:center;align-items:center;background:linear-gradient(135deg,#1a1a1a,#2d2d2d);color:#fff;padding:20px}.container{background:rgba(255,255,255,0.1);backdrop-filter:blur(10px);border-radius:20px;padding:40px;box-shadow:0 8px 32px rgba(0,0,0,0.3);text-align:center;max-width:600px;width:100%%;transition:transform .3s ease}.server-name{font-size:1.8rem;margin-bottom:30px;color:#0f0;font-weight:600;text-shadow:0 0 10px rgba(0,255,136,0.3)}.datetime{font-size:2.5rem;letter-spacing:2px;margin-bottom:20px}.date{font-size:1.5rem;opacity:.8}@media (max-width:768px){.container{padding:25px;border-radius:15px}.server-name{font-size:1.4rem}.datetime{font-size:2rem}.date{font-size:1.2rem}}@media (max-width:480px){.datetime{font-size:1.6rem}}</style>
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <title>Server Info & Time</title>
    </head>
    <body>
        <div class="container">
            <div class="server-name">Server Hostname: %s</div>
            <div class="datetime" id="datetime"></div>
            <div class="date" id="date"></div>
        </div>
        <script>
            // Минифицированный JavaScript
            const e=()=>{const e=new Date;document.getElementById("datetime").textContent=e.toLocaleTimeString("en-US",{timeZone:"Europe/Moscow",hour12:!1,hour:"2-digit",minute:"2-digit",second:"2-digit"}),document.getElementById("date").textContent=e.toLocaleDateString("en-US",{timeZone:"Europe/Moscow",weekday:"long",year:"numeric",month:"long",day:"numeric"})};e(),setInterval(e,1e3);
        </script>
    </body>
    </html>`
    )

    func init() {
      // Инициализация хоста при старте
      var err error
      if hostname, err = os.Hostname(); err != nil {
        hostname = "Unavailable"
      }
      
      // Предварительная генерация HTML
      htmlContent = []byte(fmt.Sprintf(htmlTemplate, hostname))
    }

    func main() {
      // Настройка обработчиков
      mux := http.NewServeMux()
      mux.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        w.Header().Set("Content-Type", "text/html; charset=utf-8")
        w.Header().Set("Cache-Control", fmt.Sprintf("public, max-age=%d", cacheDuration))
        w.Write(htmlContent)
      })

      // Middleware
      chain := handlers.CompressHandler(
        handlers.CombinedLoggingHandler(os.Stdout, mux),
      )

      // Конфигурация сервера
      server := &http.Server{
        Addr:         ":80",
        Handler:      chain,
        ReadTimeout:  serverTimeout,
        WriteTimeout: serverTimeout,
        IdleTimeout:  serverTimeout * 2,
      }

      // Graceful shutdown
      ctx, stop := signal.NotifyContext(context.Background(), 
        os.Interrupt, syscall.SIGTERM)
      defer stop()

      go func() {
        <-ctx.Done()
        shutdownCtx, cancel := context.WithTimeout(
          context.Background(), 5*time.Second)
        defer cancel()
        server.Shutdown(shutdownCtx)
      }()

      fmt.Println("Server started")
      if err := server.ListenAndServe(); err != http.ErrServerClosed {
        fmt.Printf("Server error: %v\n", err)
      }
    }
    ```

    {% endcut %}

1. Аналогичным способом разверните веб-приложение на сервере `alb-back-1`.

### Проверьте сетевую связность {#check-connectivity}

Убедитесь, что [созданное ранее](#connect-to-vpc) приватное соединение с облачной сетью готово к работе (статус `Ready`), затем проверьте наличие сетевой связности между виртуальной машиной `vm-validator` в сети Virtual Private Cloud и серверами в приватной подсети BareMetal:

1. [Подключитесь по SSH](../../compute/operations/vm-connect/ssh.md) к виртуальной машине `vm-validator`:

    ```bash
    ssh yc-user@<публичный_IP-адрес_ВМ>
    ```

    Публичный IP-адрес ВМ можно узнать в [консоли управления](https://console.yandex.cloud), в поле **Публичный IPv4-адрес** блока **Сеть** на странице с информацией о ВМ.

    Все последующие действия этого шага выполняются в терминале виртуальной машины.
1. Выполните проверку сетевого доступа к серверу `alb-back-0`, указав его приватный IP-адрес:

    ```bash
    ping <приватный_IP-адрес_сервера> -s 1024 -c 3
    ```

    Приватный IP-адрес сервера можно узнать в [консоли управления](https://console.yandex.cloud) на странице **Обзор** с информацией о сервере BareMetal. Нужный адрес указан в блоке **Сетевые интерфейсы** в поле **Приватный IP-адрес**.

    Результат:

    ```text
    PING 172.28.4.11 (172.28.4.11) 1024(1052) bytes of data.
    1032 bytes from 172.28.4.11: icmp_seq=1 ttl=58 time=3.77 ms
    1032 bytes from 172.28.4.11: icmp_seq=2 ttl=58 time=3.83 ms
    1032 bytes from 172.28.4.11: icmp_seq=3 ttl=58 time=3.80 ms

    --- 172.28.4.11 ping statistics ---
    3 packets transmitted, 3 received, 0% packet loss, time 2004ms
    rtt min/avg/max/mdev = 3.767/3.800/3.830/0.025 ms
    ```
1. Аналогичным способом убедитесь в наличии сетевого доступа к серверу `alb-back-1`, указав в команде `ping` его приватный IP-адрес.

Сохраните полученные приватные IP-адреса серверов BareMetal — они понадобятся при настройке L7-балансировщика.

## Настройте L7-балансировщик {#setup-balancer}

Создав сегменты инфраструктуры на стороне Virtual Private Cloud и на стороне BareMetal, а также убедившись в наличии сетевой связности между этими сегментами, настройте балансировку трафика от пользователей к веб-приложению при помощи L7-балансировщика.

### Создайте целевую группу L7-балансировщика {#create-tg}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете инфраструктуру.
  1. Перейдите в сервис **Application Load Balancer**.
  1. На панели слева выберите ![image](../../_assets/console-icons/target.svg) **Целевые группы** и нажмите кнопку **Создать целевую группу**.
  1. В поле **Имя** укажите имя [целевой группы](../../application-load-balancer/concepts/target-group.md) `bms-target-group`.
  1. В блоке **Целевые ресурсы**:
  
      1. В поле **IP-адрес** введите сохраненный ранее приватный IP-адрес сервера `alb-back-0`.
      1. В строке с введенным IP-адресом включите опцию **Не из VPC** и нажмите кнопку **Добавить целевой ресурс**.
      1. Повторите два предыдущих действия, чтобы добавить в целевую группу приватный IP-адрес сервера `alb-back-1`.
  1. Нажмите кнопку **Создать**.

{% endlist %}

### Создайте группу бэкендов {#create-backend-group}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете инфраструктуру.
  1. Перейдите в сервис **Application Load Balancer**.
  1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3-overlap.svg) **Группы бэкендов** и нажмите кнопку **Создать группу бэкендов**.
  1. В поле **Имя** укажите имя [группы бэкендов](../../application-load-balancer/concepts/backend-group.md) `bms-backend-group`.
  1. В поле **Тип** выберите `HTTP`.
  1. В блоке **Бэкенды** нажмите кнопку **Добавить** и в появившейся форме **Новый бэкенд**:

      1. В поле **Имя** задайте имя [бэкенда](../../application-load-balancer/concepts/backend-group.md#types) `bms-backend`.
      1. В поле **Целевые группы** выберите созданную ранее целевую группу `bms-target-group`.
      1. В секции **HTTP проверка состояния**:

          1. В поле **Таймаут, с** задайте значение `3`.
          1. В поле **Интервал** задайте значение `10`.
          1. В поле **Путь** укажите корневой путь `/`.
          1. В поле **HTTP-коды** выберите код ответа `200`.

      Значения остальных параметров оставьте без изменений.
  1. Нажмите кнопку **Создать**.

{% endlist %}

### Создайте HTTP-роутер {#create-http-router}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете инфраструктуру.
  1. Перейдите в сервис **Application Load Balancer**.
  1. На панели слева выберите ![image](../../_assets/console-icons/route.svg) **HTTP-роутеры** и нажмите кнопку **Создать HTTP-роутер**.
  1. В поле **Имя** укажите имя [HTTP-роутера](../../application-load-balancer/concepts/http-router.md) `http-80`.
  1. В блоке **Виртуальные хосты** нажмите кнопку **Добавить виртуальный хост** и в открывшейся форме **Новый виртуальный хост**:

      1. В поле **Имя** укажите имя [виртуального хоста](../../application-load-balancer/concepts/http-router.md#virtual-host) `http-vh` и нажмите кнопку **Добавить маршрут**.
      1. В открывшейся форме **Новый маршрут** в поле **Имя** задайте имя [маршрута](../../application-load-balancer/concepts/http-router.md#routes) `main-route-80`.
      1. В поле **Методы HTTP** выберите `GET`.
      1. В поле **Группа бэкендов** выберите созданную на предыдущем шаге группу бэкендов `bms-backend-group`.
      1. Значения остальных параметров оставьте без изменений и внизу страницы нажмите кнопку **Создать**.

{% endlist %}

### Создайте L7-балансировщик {#create-alb}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете инфраструктуру.
  1. Перейдите в сервис **Application Load Balancer**.
  1. Нажмите кнопку **Создать L7-балансировщик** и выберите **Вручную**.
  1. В поле **Имя** укажите имя балансировщика `demo-alb-bms`.
  1. В поле **Сеть** выберите сеть `sample-network`.
  1. В поле **Группы безопасности** выберите `Из списка` и в появившемся списке выберите группу безопасности `alb-sg`.
  1. В блоке **Размещение** оставьте только зоны доступности `ru-central1-a` и `ru-central1-b` с подсетями `vpc-subnet-a` и `vpc-subnet-b` соответственно.
  1. Если вы не хотите сохранять логи работы балансировщика в [лог-группу](../../logging/concepts/log-group.md), отключите опцию **Запись логов**.
  1. В секции **Обработчики** нажмите кнопку **Добавить обработчик** и в открывшейся форме:

      1. В поле **Имя** укажите имя [обработчика](../../application-load-balancer/concepts/application-load-balancer.md#listener) `alb-bms-listener`.
      1. В поле **HTTP-роутер** выберите созданный ранее HTTP-роутер `http-80`.
  1. Значения остальных параметров оставьте без изменений и внизу страницы нажмите кнопку **Создать**.
  1. Дождитесь, когда статус балансировщика изменится на `Active`, и в поле **IP-адреса** скопируйте его публичный IP-адрес.
  1. На вашем локальном компьютере вставьте IP-адрес балансировщика в адресную строку браузера. Если все настроено корректно, в окне браузера откроется развернутое на серверах BareMetal веб-приложение.

{% endlist %}

## Настройте защиту от ботов, DDoS- и веб-атак {#setup-sws}

Убедившись в корректной работе L7-балансировщика, настройте для вашего веб-приложения защиту от ботов, DDoS- и веб-атак с помощью профиля безопасности Smart Web Security.

### Создайте профиль ARL {#create-arl-profile}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете инфраструктуру.
  1. Перейдите в сервис **Smart Web Security**.
  1. На панели слева выберите ![arl](../../_assets/smartwebsecurity/arl.svg) **Профили ARL** и нажмите кнопку **Создать профиль ARL**.
  1. В поле **Имя** задайте имя [профиля ARL](../concepts/arl.md) `arl-profile-demo`.
  1. Нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **Добавить правило** и в открывшемся окне:

      1. В поле **Имя** задайте имя правила `permit-50-rps-in`.
      1. В поле **Приоритет** укажите `10`.
      1. В поле **Лимит запросов** задайте лимит в `50` запросов за `1 секунду`.
      1. Значения остальных параметров оставьте без изменений и нажмите кнопку **Сохранить правило**.
  1. Нажмите кнопку **Создать**.

{% endlist %}

### Создайте профиль WAF {#create-waf-profile}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете инфраструктуру.
  1. Перейдите в сервис **Smart Web Security**.
  1. На панели слева выберите ![waf](../../_assets/smartwebsecurity/waf.svg) **Профили WAF** и нажмите кнопку **Создать профиль WAF**.
  1. В поле **Имя** задайте имя [профиля WAF](../concepts/waf.md) `waf-profile-demo`.
  1. По умолчанию в профиле WAF включен набор базовых правил [OWASP Core Rule Set](https://coreruleset.org/). Нажмите на строку с набором правил, чтобы посмотреть правила, которые в него входят.
  1. Нажмите кнопку **Создать**.

{% endlist %}

### Создайте профиль безопасности {#create-security-profile}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете инфраструктуру.
  1. Перейдите в сервис **Smart Web Security**.
  1. На панели слева выберите ![shield-check](../../_assets/console-icons/shield-check.svg) **Профили безопасности**.
  1. Нажмите кнопку **Создать профиль** и выберите вариант `С чистого листа`.
  1. В поле **Имя** задайте имя [профиля безопасности](../concepts/profiles.md) `sws-demo-profile`.
  1. В поле **Профиль ARL** выберите созданный ранее профиль `arl-profile-demo`.
  1. Создайте новое [правило](../concepts/rules.md) `Web Application Firewall`:
  
      1. Нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **Добавить правило**.
      1. В поле **Имя** задайте имя правила `waf-rule`.
      1. В поле **Приоритет** укажите значение `200`.
      1. В блоке **Тип правила** выберите `Web Application Firewall` и в появившемся списке выберите созданное ранее правило `waf-profile-demo`.

          К создаваемому правилу будет применен набор правил из профиля WAF. Подозрительные запросы будут направляться в [Yandex SmartCaptcha](../../smartcaptcha/index.md).
      1. Нажмите кнопку **Добавить**.

      Добавленное правило появится в списке правил в блоке **Правила безопасности**.
  1. Создайте новое правило `Smart Protection`:

      1. Повторно нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **Добавить правило**.
      1. В поле **Имя** задайте имя правила `smart-rule`.
      1. В поле **Приоритет** укажите значение `300`.
      1. В блоке **Тип правила** выберите `Smart Protection`.

          Создаваемое правило будет направлять трафик на автоматический анализ с помощью алгоритмов машинного обучения и поведенческого анализа. Подозрительные запросы будут направляться в Yandex SmartCaptcha для дополнительной верификации.
      1. Нажмите кнопку **Добавить**.
  
      Добавленное правило появится в списке правил в блоке **Правила безопасности**.
  1. Нажмите кнопку **Создать профиль**.

{% endlist %}

### Включите защиту на хостах {#apply-protection-to-hosts}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете инфраструктуру.
  1. Перейдите в сервис **Smart Web Security**.
  1. На панели слева нажмите ![shield-check](../../_assets/console-icons/shield-check.svg) **Профили безопасности** и выберите созданный ранее профиль `sws-demo-profile`.
  1. На панели сверху нажмите кнопку ![plug](../../_assets/console-icons/plug-connection.svg) **Подключить к хосту**.
  1. В открывшемся окне нажмите **Добавить ресурс** и выберите **Виртуальный хост**.
  1. Последовательно установите значения в полях:

      1. Выберите балансировщик `demo-alb-bms`.
      1. Выберите HTTP-роутер `http-80`.
      1. Выберите виртуальный хост `http-vh`.
      1. Нажмите кнопку **Подключить**.

      Информация о подключенном виртуальном хосте появится в разделе ![cubes-3-overlap](../../_assets/console-icons/cubes-3-overlap.svg) **Подключенные ресурсы** на странице с обзором профиля безопасности Smart Web Security.

{% endlist %}

Вы настроили веб-приложение, развернув его на двух серверах BareMetal, организовав балансировку пользовательского трафика с помощью L7-балансировщика Application Load Balancer и обеспечив защиту с помощью профиля безопасности Smart Web Security.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../compute/operations/vm-control/vm-delete.md) виртуальную машину.
1. [Удалите](../../application-load-balancer/operations/application-load-balancer-delete.md) L7-балансировщик, затем последовательно удалите [HTTP-роутер](../../application-load-balancer/operations/http-router-delete.md), [группу бэкендов](../../application-load-balancer/operations/backend-group-delete.md) и [целевую группу](../../application-load-balancer/operations/target-group-delete.md) балансировщика.
1. [Удалите](../operations/profile-delete.md) профиль безопасности Smart Web Security, затем удалите [профиль WAF](../operations/waf-profile-delete.md) и [профиль ARL](../operations/arl-profile-delete.md).
1. Удалить серверы BareMetal нельзя. Вместо этого [откажитесь](../../baremetal/operations/servers/server-lease-cancel.md) от продления их аренды.
1. Если вы оставляли включенной опцию записи логов L7-балансировщика, [удалите](../../logging/operations/delete-group.md) лог-группу.
1. При необходимости последовательно удалите [группы безопасности](../../vpc/operations/security-group-delete.md), [подсети](../../vpc/operations/subnet-delete.md) и [облачную сеть](../../vpc/operations/network-delete.md).
1. При необходимости удалите приватное соединение:

    {% list tabs group=instructions %}

    - Консоль управления {#console} 
    
      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создали инфраструктуру.
      1. Перейдите в сервис **BareMetal**.
      1. На панели слева выберите ![icon](../../_assets/console-icons/vector-square.svg) **VRF** и выберите виртуальный сегмент сети `my-vrf`.
      1. В блоке **Приватное соединение с облачными сетями** нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите ![CircleXmark](../../_assets/console-icons/circle-xmark.svg) **Отключить соединение**.
      1. В открывшемся окне подтвердите удаление.

      В результате статус соединения сменится на `Deleting`. После того как все связи будут удалены, соединение пропадет из списка.

    {% endlist %}