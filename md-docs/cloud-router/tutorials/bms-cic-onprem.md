# Организация сетевой связности между подсетями {{ baremetal-full-name }} и on-premises с помощью {{ interconnect-name }}

В данном руководстве вы установите сетевую связность между [сервером](../../baremetal/concepts/servers.md) {{ baremetal-name }}, расположенным в [приватной подсети](../../baremetal/concepts/private-network.md) {{ baremetal-full-name }}, и ресурсами, которые развернуты on-premises. Сетевая связность будет организована с помощью сервисов [{{ interconnect-name }}](../../interconnect/index.md) и [{{ cr-name }}](../index.md).

Схема решения:

![bms-cic-onprem](../../_assets/tutorials/bms-cic-onprem.svg)

На схеме выше показана организация сетевого взаимодействия между ресурсами в сегменте {{ baremetal-full-name }} и удаленными ресурсами на площадке клиента, которая подключена к {{ yandex-cloud }} с помощью сервиса {{ interconnect-name }}.

Для организации сетевого взаимодействия между такими ресурсами и виртуальной сетью нужно добавить соответствующие IP-префиксы подсетей {{ vpc-name }} в Routing Instance. Подробнее с организацией такого вида сетевого взаимодействия можно ознакомиться [в документации](bm-vrf-and-vpc-interconnect.md). 

{% note info %}

Предполагается, что сетевое взаимодействие между on-premises и виртуальной сетью {{ vpc-short-name }} с помощью сервиса {{ interconnect-name }} уже организовано и работает. 

{% endnote %}

Чтобы настроить сетевую связность между приватными подсетями {{ baremetal-name }} и on-premise-ресурсами с помощью {{ interconnect-name }} необходимо:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте облачную инфраструктуру](#setup-infrastructure).
1. [Создайте Routing Instance](#create-routing-instance).
1. [Создайте приватное соединение](#create-private-connection).
1. [Проверьте сетевую связность](#check-connectivity).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для организации сетевой связности между подсетями {{ baremetal-name }} и {{ vpc-short-name }} входят:

* плата за использование [публичного IP-адреса](../../vpc/concepts/address.md#public-addresses) виртуальной машины (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md));
* плата за вычислительные ресурсы и диски [ВМ](../../compute/concepts/vm.md) (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за аренду сервера {{ baremetal-name }} (см. [тарифы {{ baremetal-full-name }}](../../baremetal/pricing.md)).


## Создайте облачную инфраструктуру {#setup-infrastructure}

Создайте необходимую инфраструктуру {{ yandex-cloud }}, в которой вы будете настраивать сетевую связность.

Для настройки {{ interconnect-name }} в сервисе {{ baremetal-name }} понадобятся приватная маршрутизируемая [подсеть](../../baremetal/concepts/private-network.md#private-subnet) и [VRF](../../baremetal/concepts/private-network.md#vrf-segment) в {{ baremetal-name }}, [облачная сеть](../../vpc/concepts/network.md#network) с одной или более [подсетями](../../vpc/concepts/network.md#subnet) {{ vpc-name }}, а также Routing Instance, в составе которого будут [анонсированы](../../interconnect/concepts/priv-con.md#prc-announce) один или несколько префиксов приватных подсетей {{ vpc-short-name }}.

Для проверки сетевой связности понадобятся сервер {{ baremetal-name }} и виртуальная машина {{ compute-name }}.

### Создайте VRF и приватную подсеть {{ baremetal-name }} {#setup-vrf}

Создайте виртуальный сегмент сети (VRF) и приватную подсеть в [пуле серверов](../../baremetal/concepts/servers.md#server-pools) `{{ region-id }}-m3`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы будете создавать инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. Создайте виртуальный сегмент сети:
        1. На панели слева выберите ![icon](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud.baremetal.label_networks_kHgng }}** и нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-network }}**.
        1. В поле **{{ ui-key.yacloud.baremetal.field_name }}** задайте имя VRF: `my-vrf`.
        1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-network }}**.
  1. Создайте приватную подсеть:
        1. На панели слева выберите ![icon](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.baremetal.label_subnetworks_uU4LH }}** и нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-subnetwork }}**.
        1. В поле **{{ ui-key.yacloud.baremetal.field_hardware-pool-id }}** выберите пул серверов `{{ region-id }}-m3`.
        1. В поле **{{ ui-key.yacloud.baremetal.field_name }}** задайте имя подсети: `subnet-m3`.
        1. Включите опцию **{{ ui-key.yacloud.baremetal.title_routing-settings }}**.
        1. В поле **{{ ui-key.yacloud.baremetal.field_network-id }}** выберите созданный ранее сегмент `my-vrf`.
        1. В поле **{{ ui-key.yacloud.baremetal.field_CIDR_rwYMi }}** укажите `192.168.1.0/24`.
        1. В поле **{{ ui-key.yacloud.baremetal.field_gateway_t7LLk }}** оставьте значение по умолчанию `192.168.1.1`.
        1. Включите опцию **{{ ui-key.yacloud.baremetal.field_dhcp-settings }}** и в появившемся поле **{{ ui-key.yacloud.baremetal.field_dhcp-ip-range }}** оставьте значения по умолчанию: `192.168.1.1` — `192.168.1.254`.
        1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-subnetwork }}**.

{% endlist %}


### Арендуйте сервер {{ baremetal-name }} {#rent-bms}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-server }}** и в открывшемся окне выберите вариант `{{ ui-key.yacloud_components.baremetal.StockConfigurations }}` и подходящую [конфигурацию](../../baremetal/concepts/server-configurations.md) сервера {{ baremetal-name }} в пуле серверов `{{ region-id }}-m3`.

      Для этого в фильтре в правой части окна в блоке **{{ ui-key.yacloud_components.baremetal.poolFilter }}** выберите пул серверов `{{ region-id }}-m3`.

      Чтобы выбрать подходящую вам конфигурацию сервера, нажмите на блок с именем этой конфигурации в центральной части экрана.

      {% note tip %}
      
      Вы можете снизить стоимость аренды сервера в некоторых конфигурациях, заказав его [сборку](../../baremetal/concepts/server-custom-configurations.md#assembly).
      
      Чтобы воспользоваться скидкой, в блоке с нужной конфигурацией наведите курсор на **{{ ui-key.yacloud_components.baremetal.assemblyDiscountLabel }}** ![circle-info.svg](../../_assets/console-icons/circle-info.svg) и во всплывающем окне нажмите ![person-nut-hex.svg](../../_assets/console-icons/person-nut-hex.svg) **{{ ui-key.yacloud_components.baremetal.goToAssembly }}**.
      
      При заказе сервера со сборкой воспользуйтесь приведенной ниже инструкцией, чтобы задать необходимые параметры сервера. При этом сервер станет доступен вам не сразу, а после завершения сборки (в течение четырех календарных дней) и по более низкой цене.
      
      {% endnote %}

  1. В открывшемся окне с настройками конфигурации сервера:

      1. В поле **{{ ui-key.yacloud.baremetal.field_server-lease-duration }}** выберите [период](../../baremetal/concepts/servers.md#server-lease), на который вы хотите арендовать сервер: `1 день`, `1 месяц`, `3 месяца`, `6 месяцев` или `1 год`.
         
         По окончании указанного периода аренда сервера будет автоматически продлена на такой же период. Прервать аренду в течение указанного периода аренды нельзя, но можно [отказаться](../../baremetal/operations/servers/server-lease-cancel.md) от дальнейшего продления аренды сервера.
      1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-product }}** выберите образ. Например: `Ubuntu 24.04`.
      1. (Опционально) В блоке **{{ ui-key.yacloud.baremetal.title_section-disk }}** настройте разметку [дисков](../../baremetal/concepts/disks/disk-types.md):
         
         1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.action_disk-layout-settings }}**.
         1. Укажите параметры разделов. Чтобы создать новый раздел, нажмите кнопку ![icon](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.baremetal.actions_add-partition }}**.
         
             Чтобы самостоятельно собрать [RAID](../../baremetal/concepts/disks/raid.md)-массивы и настроить разделы дисков, нажмите кнопку **{{ ui-key.yacloud.baremetal.action_destroy-raid }}**.
         1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
      1. В блоке **{{ ui-key.yacloud.baremetal.title_section-network-interfaces }}**:
          1. В поле **{{ ui-key.yacloud.baremetal.field_subnet-id }}** выберите созданную ранее подсеть `subnet-m3`.
          1. В поле **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** выберите `{{ ui-key.yacloud.baremetal.label_public-ip-no }}`.

      1. В блоке **{{ ui-key.yacloud.baremetal.title_server-access }}**:

          1. В поле **{{ ui-key.yacloud.baremetal.field_password }}** воспользуйтесь одним из вариантов создания пароля для root-пользователя:
          
              * Чтобы сгенерировать пароль для root-пользователя, выберите опцию `{{ ui-key.yacloud.baremetal.label_password-plain }}` и нажмите кнопку **{{ ui-key.yacloud.component.password-input.label_button-generate }}**.
          
                  {% note warning %}
                  
                  Этот вариант предусматривает ответственность пользователя за безопасность пароля. Сохраните сгенерированный пароль в надежном месте: он не сохраняется в {{ yandex-cloud }}, и после заказа сервера вы не сможете посмотреть его.
                  
                  {% endnote %}
          
              * Чтобы использовать пароль root-пользователя, сохраненный в [секрете](../../lockbox/concepts/secret.md) {{ lockbox-full-name }}, выберите опцию `{{ ui-key.yacloud.baremetal.label_password-lockbox }}`:
          
                  В полях **{{ ui-key.yacloud.baremetal.label_lockbox-name }}**, **{{ ui-key.yacloud.baremetal.label_lockbox-version }}** и **{{ ui-key.yacloud.baremetal.label_lockbox-key }}** выберите соответственно секрет, его версию и ключ, в которых сохранен ваш пароль.
                  
                  Если у вас еще нет секрета {{ lockbox-name }}, нажмите кнопку **{{ ui-key.yacloud.common.create }}**, чтобы создать его.
          
                  Этот вариант позволяет вам как задать собственный пароль (тип секрета `{{ ui-key.yacloud.lockbox.FormFields.title_secret-type-custom }}`), так и использовать пароль, сгенерированный автоматически (тип секрета `{{ ui-key.yacloud.lockbox.FormFields.title_secret-type-generated }}`).
          
          1. В поле **{{ ui-key.yacloud.baremetal.field_ssh-public-key }}** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../organization/concepts/membership.md).
          
              Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
              
              1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_add-ssh-key }}**.
              1. Задайте имя SSH-ключа.
              1. Выберите вариант:
              
                  * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-manual }}` — вставьте содержимое открытого [SSH](../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
                  * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-upload }}` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
                  * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-generate }}` — автоматическое создание пары SSH-ключей.
                  
                    При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
              
              1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
              
              SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.

      1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-info }}** в поле **{{ ui-key.yacloud.baremetal.field_name }}** задайте имя сервера: `server-m3`.
      1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-server }}**.

{% endlist %}

{% note info %}

Подготовка сервера и установка на него операционной системы может занять до 45 минут — в это время сервер будет находиться в статусе `Provisioning`. После завершения установки ОС сервер перейдет в статус `Ready`.

{% endnote %}

## Создайте Routing Instance {#create-routing-instance}

Для организации сетевой связности между подсетями {{ baremetal-name }} и on-premise-подсетями необходимо создать ресурс `Routing Instance`. `Routing Instance` можно создать через [обращение]({{ link-console-support }}/tickets/create) в службу технической поддержки.

Если в вашем каталоге уже есть настроенная сетевая связность с использованием [{{ interconnect-name }}](../../interconnect/index.md) (VPC-to-On-Prem), то вы можете как использовать уже существующий `Routing Instance`, так и запросить создание нового, дополнительного `Routing Instance` для организации обособленной сетевой связности.

### Проверьте наличие Routing Instance в вашем каталоге {#check-for-ri}

1. Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

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

1. Если у вас уже есть Routing Instance, вы можете пропустить следующий шаг и [переходить](#create-private-connection) к созданию приватного соединения.

    Если у вас нет Routing Instance или вы хотите построить дополнительную, обособленную сетевую связность, запросите создание нового Routing Instance.

### Запросите создание Routing Instance {#request-ri}

[Обратитесь]({{ link-console-support }}/tickets/create) в службу технической поддержки для создания `Routing Instance` в вашем каталоге.

Оформите ваше обращение следующим образом:

```text
Тема: [CIC для BareMetal] Создать Routing Instance.

Текст обращения:
Прошу Создать Routing Instance в указанном облачном каталоге со следующими параметрами:

folder_id: <идентификатор_каталога>

vpc:
  vpc_net_id: <идентификатор_сети>
    vpc_subnets: 
      {{ region-id }}-a: [CIDR_a1, CIDR_a2, ..., CIDR_an]
      {{ region-id }}-b: [CIDR_b1, CIDR_b2, ..., CIDR_bn]
      {{ region-id }}-d: [CIDR_d1, CIDR_d2, ..., CIDR_dn]
```

Где:
* `folder_id` — [идентификатор](../../resource-manager/operations/folder/get-id.md) каталога.
* `vpc_net_id` — [идентификатор](../../vpc/operations/network-get-info.md) облачной сети.
* `vpc_subnets` — список [анонсируемых](../../interconnect/concepts/priv-con.md#prc-announce) адресных префиксов для каждой из [зон доступности](../../overview/concepts/geo-scope.md). Например, для созданной ранее подсети {{ vpc-short-name }} вы укажете `{{ region-id }}-b: [192.168.11.0/24]`.

    Допускается анонсирование адресных префиксов с [агрегированием](../../interconnect/concepts/priv-con.md#agg-subnets).

{% note info %}

Создание `Routing Instance` службой технической поддержки может занять до 24 часов. В результате вы сможете получить идентификатор созданного `Routing Instance`, выполнив команду [{{ yandex-cloud }} CLI](../../cli/index.md) `yc cloudrouter routing-instance list`.

{% endnote %}

## Настройте Routing Instance {#config-ri}

В дополнение к списку IP-префиксов из предыдущего шага в Routing Instance необходимо добавить:

1. Список агрегированных IP-префиксов для приватных подсетей из сегмента Baremetal.
1. Список агрегированных IP-префиксов для анонсируемых подсетей из on-premise.

Список агрегированных IP-префиксов может быть ассоциирован с любой из существующих зон доступности.

Например, для IP-префикса подсети `192.168.1.0/24`, агрегатом может быть префикс - `192.168.0.0/22`.

## Создайте приватное соединение {#create-private-connection}

После того как в вашем каталоге будет создан необходимый Routing Instance, создайте [приватное соединение](../../baremetal/concepts/private-network.md#private-connection-to-vpc) {{ interconnect-name }} в сервисе {{ baremetal-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать приватное соединение.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. На панели слева выберите ![icon](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud.baremetal.label_networks_kHgng }}** и выберите нужный виртуальный сегмент сети.
  1. В блоке **{{ ui-key.yacloud.baremetal.title_vrf-interconnect-section }}** нажмите кнопку **{{ ui-key.yacloud.baremetal.action_add-vrf-interconnect }}** и в открывшемся окне:

      1. В поле **{{ ui-key.yacloud.baremetal.label_vrf-interconnect-select-type }}** выберите вариант `{{ ui-key.yacloud.baremetal.field_interconnect-direct-id }}` и в поле **{{ ui-key.yacloud.baremetal.label_vrf-interconnect-direct-type }}** вставьте идентификатор приватного соединения `Routing Instance`.

          Вы также можете выбрать вариант `{{ ui-key.yacloud.baremetal.field_interconnect-from-folder }}`. В этом случае в появившемся списке выберите нужный `Routing Instance`.

          В результате в форме отобразятся CIDR подсетей {{ vpc-name }}, которые будут [анонсироваться](../../interconnect/concepts/priv-con.md#prc-announce) в {{ interconnect-name }}.

          {% note warning %}
          
          Для успешной настройки сетевой связности между подсетями {{ baremetal-name }} и подсетями {{ vpc-short-name }}/on-prem, их диапазоны адресов, заданные CIDR, не должны совпадать или пересекаться.
          
          {% endnote %}
      1. Чтобы создать приватное соединение с указанными CIDR подсетей, нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

  В результате на странице с информацией о VRF в блоке **{{ ui-key.yacloud.baremetal.title_vrf-interconnect-section }}** отобразится идентификатор созданного соединения и его статус.

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

  * `routingInstanceId` — идентификатор [Routing Instance](../concepts/routing-instance.md) в {{ cr-name }}.
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

## Проверьте сетевую связность {#check-connectivity}

После того как статус созданного приватного соединения изменится на `Ready`, сетевая связность между подсетями {{ baremetal-name }} и {{ vpc-short-name }} будет установлена и вы сможете приступить к ее проверке.

Проверка сетевой связности предполагает, что:
* процесс настройки приватного соединения с облачными подсетями успешно завершен (статус соединения отображается как `Ready`);
* локальный сервис Firewall на сервере {{ baremetal-name }} разрешает прохождение трафика [ICMP](https://ru.wikipedia.org/wiki/ICMP);
* маршрутная таблица в операционной системе сервера {{ baremetal-name }} содержит маршрут до CIDR подсети с виртуальной машиной;
* [группа безопасности](../../vpc/concepts/security-groups.md), которая назначена [сетевому интерфейсу](../../compute/concepts/network.md) виртуальной машины, разрешает прохождение ICMP-трафика.

### Проверьте сетевую связность из приватной подсети {{ baremetal-name }} к on-premise-ресурсам {#check-bms-to-onprem}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. В строке с сервером `server-m3` нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.baremetal.label_kvm-console_37Kma }}**.
  
      Откроется окно с терминалом KVM-консоли, в котором вы увидите строку аутентификации:
      
      ```
      server-m3 login:
      ```

      Если вы не видите этой строки, попробуйте [перезапустить](../../baremetal/operations/servers/server-stop-and-start.md#restart) сервер.

  1. В терминале KVM-консоли введите имя пользователя `root` и нажмите **ENTER**.
  1. В строке для ввода пароля вставьте сгенерированный при аренде сервера пароль и нажмите **ENTER**. Обратите внимание, что при наборе или вставке пароля в ОС Linux введенные символы не отображаются на экране.

      {% note tip %}
      
      Чтобы в KVM-консоли вставить текст из буфера обмена, воспользуйтесь полем **Paste text here** в правом верхнем углу.
      
      {% endnote %}

      Результат:

      ```text
      Welcome to Ubuntu 24.04.2 LTS (GNU/Linux 6.8.0-53-generic x86_64)
      ...
      root@server-m3:~# _
      ```

      Если вы не сохранили пароль администратора к серверу, вы можете создать новый пароль по [инструкции](../../baremetal/operations/servers/reset-password.md) или [переустановить](../../baremetal/operations/servers/reinstall-os-from-marketplace.md) на сервере операционную систему.
  1. В терминале KVM-консоли выполните команду `ping`, чтобы убедиться в доступности виртуальной машины `sample-vm` по ее [внутреннему](../../compute/concepts/network.md#internal-ip) IP-адресу:

      ```bash
      ping <внутренний_IP-адрес_ВМ> -c 5
      ```

      Узнать внутренний IP-адрес ВМ вы можете в [консоли управления]({{ link-console-main }}) в блоке **{{ ui-key.yacloud.compute.instance.overview.label_network-interface }}** на странице с информацией о ВМ.

      Результат:

      ```text
      PING 192.168.11.2 (192.168.11.2) 56(84) bytes of data.
      64 bytes from 192.168.11.2: icmp_seq=1 ttl=64 time=3.90 ms
      64 bytes from 192.168.11.2: icmp_seq=2 ttl=64 time=0.235 ms
      64 bytes from 192.168.11.2: icmp_seq=3 ttl=64 time=0.222 ms
      64 bytes from 192.168.11.2: icmp_seq=4 ttl=64 time=0.231 ms
      64 bytes from 192.168.11.2: icmp_seq=5 ttl=64 time=0.235 ms

      --- 192.168.11.2 ping statistics ---
      5 packets transmitted, 5 received, 0% packet loss, time 4086ms
      rtt min/avg/max/mdev = 0.222/0.964/3.899/1.467 ms
      ```

      Сетевая связность между сервером {{ baremetal-name }} и виртуальной машиной установлена, пакеты проходят без потерь.

{% endlist %}

### Проверьте сетевую связность от on-premise-ресурса с приватной подсетью {{ baremetal-name }} {#check-onprem-to-bms}

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к виртуальной машине по SSH.
1. В терминале выполните команду `ping`, чтобы убедиться в доступности сервера `server-m3` по его приватному IP-адресу:

      ```bash
      ping <приватный_IP-адрес_сервера> -c 5
      ```

      Узнать приватный IP-адрес сервера {{ baremetal-name }} вы можете в [консоли управления]({{ link-console-main }}) в блоке **Сетевые настройки** на странице с информацией о сервере.

      Результат:

      ```text
      PING 192.168.1.3 (192.168.1.3) 56(84) bytes of data.
      64 bytes from 192.168.1.3: icmp_seq=1 ttl=64 time=0.271 ms
      64 bytes from 192.168.1.3: icmp_seq=2 ttl=64 time=0.215 ms
      64 bytes from 192.168.1.3: icmp_seq=3 ttl=64 time=0.262 ms
      64 bytes from 192.168.1.3: icmp_seq=4 ttl=64 time=0.223 ms
      64 bytes from 192.168.1.3: icmp_seq=5 ttl=64 time=0.208 ms

      --- 192.168.1.3 ping statistics ---
      5 packets transmitted, 5 received, 0% packet loss, time 4106ms
      rtt min/avg/max/mdev = 0.208/0.235/0.271/0.025 ms
      ```

      Сетевая связность между виртуальной машиной и сервером {{ baremetal-name }} установлена, пакеты проходят без потерь.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../compute/operations/vm-control/vm-delete.md) виртуальную машину.
1. Удалить сервер {{ baremetal-name }} нельзя. Вместо этого [откажитесь](../../baremetal/operations/servers/server-lease-cancel.md) от продления аренды сервера.
1. При необходимости удалите приватное соединение:

    {% list tabs group=instructions %}

    - Консоль управления {#console} 
    
      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали инфраструктуру.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
      1. На панели слева выберите ![icon](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud.baremetal.label_networks_kHgng }}** и выберите виртуальный сегмент сети `my-vrf`.
      1. В блоке **{{ ui-key.yacloud.baremetal.title_vrf-interconnect-section }}** нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите ![CircleXmark](../../_assets/console-icons/circle-xmark.svg) **{{ ui-key.yacloud.baremetal.action_delete-external-connection }}**.
      1. В открывшемся окне подтвердите удаление.

      В результате статус соединения сменится на `Deleting`. После того как все связи будут удалены, соединение пропадет из списка.

    {% endlist %}