# Интеграция {{ objstorage-full-name }} с Nextcloud

[Nextcloud](https://nextcloud.com/) — это программное решение с открытым исходным кодом, позволяющее удобно, гибко и безопасно управлять файлами, обмениваться ими и совместно работать над документами. Nextcloud позволяет как создавать собственные облачные хранилища, так и интегрировать готовые решения, например, [{{ objstorage-full-name }}](../../storage/index.yaml).

В этом руководстве вы подключите [бакет](../../storage/concepts/bucket.md) {{ objstorage-name }} к решению Nextcloud, развернутому на [виртуальной машине](../../compute/concepts/vm.md) {{ compute-full-name }} с базой данных в [кластере](../../managed-mysql/concepts/index.md) {{ mmy-full-name }}. Для обеспечения отказоустойчивости и избыточности создаваемой под Nextcloud инфраструктуры вы масштабируете Nextcloud на [группу виртуальных машин](../../compute/concepts/instance-groups/index.md) с распределением нагрузки при помощи [L7-балансировщика](../../application-load-balancer/concepts/application-load-balancer.md) {{ alb-full-name }}. В отказоустойчивой конфигурации Nextcloud будет доступен по доменному имени, для которого в {{ certificate-manager-full-name }} будет выпущен [TLS-сертификат](../../certificate-manager/concepts/managed-certificate.md).

{% note info %}

Для реализации отказоустойчивой конфигурации Nextcloud вам понадобится домен, который будет использоваться L7-балансировщиком.

{% endnote %}

Схема отказоустойчивого решения:

![integrate-nextcloud](../../_assets/tutorials/integrate-nextcloud/integrate-nextcloud.svg)

Где:
* `example.com` — ваш домен, для которого в {{ certificate-manager-full-name }} выпущен [сертификат](../../certificate-manager/concepts/managed-certificate.md) и который подключен к [L7-балансировщику](../../application-load-balancer/concepts/application-load-balancer.md) нагрузки.
* `nextcloud-alb` — L7-балансировщик, который равномерно распределяет входящий трафик от пользователей между хостами группы виртуальных машин.
* `nextcloud-instance-group` — [группа виртуальных машин](../../compute/concepts/instance-groups/index.md), в которую входят хосты с развернутым решением Nextcloud.
* `nextcloud-db-cluster` — [кластер](../../managed-mysql/concepts/index.md) {{ mmy-full-name }}, в котором расположена служебная база данных Nextcloud.
* `my-nextcloud-bucket` — [бакет](../../storage/concepts/bucket.md) {{ objstorage-full-name }}, подключенный к решению Nextcloud.

Чтобы развернуть Nextcloud в {{ yandex-cloud }} с интеграцией бакета {{ objstorage-name }}:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Разверните Nextcloud в базовой конфигурации](#the-basic-variant):

    1. [Создайте и настройте облачную сеть](#setup-network).
    1. [Создайте сервисный аккаунт и статический ключ доступа](#setup-sa).
    1. [Создайте бакет {{ objstorage-name }}](#create-bucket).
    1. [Создайте виртуальную машину](#create-vm).
    1. [Создайте кластер {{ mmy-name }}](#create-mysql-cluster).
    1. [Установите и настройте Nextcloud на виртуальной машине](#setup-nextcloud).
    1. [Протестируйте работу решения в базовой конфигурации](#test-simple).
1. [Разверните Nextcloud в отказоустойчивой конфигурации](#the-redundant-variant):

    1. [Масштабируйте кластер {{ mmy-name }}](#expand-mysql-cluster).
    1. [Донастройте Nextcloud и создайте снимок диска виртуальной машины](#create-snapshot).
    1. [Добавьте TLS-сертификат в {{ certificate-manager-full-name }}](#issue-certificate).
    1. [Разверните группу виртуальных машин](#create-instance-group).
    1. [Создайте L7-балансировщик](#setup-balancer).
    1. [Создайте ресурсную A-запись в публичной зоне DNS вашего домена](#create-a-record).
    1. [Протестируйте работу решения в отказоустойчивой конфигурации](#test-redundant).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость предлагаемого решения входят: 
* плата за [диски](../../compute/concepts/disk.md), [снимки дисков](../../compute/concepts/snapshot.md) и постоянно запущенные [ВМ](../../compute/concepts/vm.md) (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование [публичных IP-адресов](../../vpc/concepts/address.md#public-addresses) и [NAT-шлюзов](../../vpc/concepts/gateways.md#nat-gateway) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md));
* плата за [хранение данных](../../storage/concepts/bucket.md) в {{ objstorage-name }} и [операции](../../storage/operations/index.md) с ними (см. [тарифы {{ objstorage-full-name }}](../../storage/pricing.md));
* плата за использование управляемой БД {{ MY }} (см. [тарифы {{ mmy-name }}](../../managed-mysql/pricing.md));
* при использовании {{ dns-full-name }} плата за [DNS-зоны](../../dns/concepts/dns-zone.md#public-zones) и публичные DNS-запросы (см. [тарифы {{ dns-name }}](../../dns/pricing.md));
* при использовании балансировщика нагрузки плата за количество ресурсных единиц [L7-балансировщика](../../application-load-balancer/concepts/application-load-balancer.md) (см. [тарифы {{ alb-full-name }}](../../application-load-balancer/pricing.md));
* при использовании [лог-группы](../../logging/concepts/log-group.md) для записи логов балансировщика плата за запись и хранение данных (см. [тарифы {{ cloud-logging-full-name }}](../../logging/pricing.md)).

## Разверните Nextcloud в базовой конфигурации {#the-basic-variant}

Базовая конфигурация Nextcloud будет развернута на одной виртуальной машине, при этом служебная база данных Nextcloud будет создана в кластере {{ mmy-name }} с одним хостом или непосредственно на ВМ с развернутым Nextcloud.

### Создайте и настройте облачную сеть {#setup-network}

1. Создайте [облачную сеть](../../vpc/concepts/network.md#network) и [подсети](../../vpc/concepts/network.md#subnet), необходимые для работы создаваемой облачной инфраструктуры:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы будете создавать инфраструктуру.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
      1. В правом верхнем углу нажмите **{{ ui-key.yacloud.vpc.networks.button_create }}**.
      1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_name }}** укажите имя сети `nextcloud-network`.
      1. Убедитесь, что опция **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** включена, и нажмите **{{ ui-key.yacloud.vpc.networks.button_create }}**.

    {% endlist %}

1. Создайте [группу безопасности](../../vpc/concepts/security-groups.md), разрешающую необходимый для работы инфраструктуры Nextcloud трафик:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
      1. На панели слева выберите ![shield](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}**. 
      1. Нажмите **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
      1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** укажите имя `nextcloud-sg`.
      1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** выберите созданную ранее сеть `nextcloud-network`.
      1. В блоке **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}** [создайте](../../vpc/operations/security-group-add-rule.md) следующие правила для управления трафиком:

          | Направление<br/>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }} |
          | --- | --- | --- | --- | --- | --- |
          | Входящий | `http`           | `80` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
          | Входящий | `https`           | `443` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
          | Входящий | `ssh`            | `22`   | `TCP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
          | Входящий | `self`            | `Весь`   | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` |
          | Входящий | `healthchecks`            | `Весь`   | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}` | `–` |
          | Исходящий | `any`           | `Весь` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
      1. Нажмите **{{ ui-key.yacloud.common.create }}**.

    {% endlist %}

1. Создайте [NAT-шлюз](../../vpc/concepts/gateways.md#nat-gateway):

    Для доступа к бакетам {{ objstorage-name }} виртуальным машинам необходим доступ в интернет. Чтобы не назначать виртуальным машинам группы ВМ публичные IP-адреса, вы настроите для них доступ в интернет с помощью NAT-шлюза.

    {% note info %}

    Вы также можете настроить доступ ВМ к бакету с помощью [сервисных подключений](../../vpc/concepts/private-endpoint.md).

    {% include [preview-pp](../../_includes/preview-pp.md) %}

    {% endnote %}

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
      1. На панели слева выберите ![arrows-opposite-to-dots](../../_assets/console-icons/arrows-opposite-to-dots.svg) **{{ ui-key.yacloud.vpc.switch_gateways }}** и нажмите кнопку **{{ ui-key.yacloud.vpc.gateways.button_create-gateway }}**.
      1. В поле **{{ ui-key.yacloud.vpc.gateways.field_name }}** задайте имя шлюза `nextcloud-gateway`. 
      1. В поле **{{ ui-key.yacloud.vpc.gateways.field_type }}** выберите `{{ ui-key.yacloud.vpc.gateways.value_gateway-type-egress-nat }}` и нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

    {% endlist %}

1. Создайте [таблицу маршрутизации](../../vpc/concepts/routing.md):

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
      1. На панели слева выберите ![route](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.vpc.network.switch_route-table }}** и нажмите кнопку **{{ ui-key.yacloud.vpc.network.overview.button_create_route-table }}**.
      1. В поле **{{ ui-key.yacloud.vpc.route-table-form.field_name }}** задайте имя `nextcloud-rt-table`.
      1. В поле **{{ ui-key.yacloud.vpc.route-table-form.field_network-id }}** выберите сеть `nextcloud-network`.
      1. Нажмите кнопку **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}** и в открывшемся окне:

          1. В поле **{{ ui-key.yacloud.vpc.add-static-route.field_next-hop-address }}** выберите `{{ ui-key.yacloud.vpc.add-static-route.value_gateway }}`.
          1. В поле **{{ ui-key.yacloud.vpc.add-static-route.value_gateway }}** выберите созданный NAT-шлюз. Префикс назначения заполнится автоматически.
          1. Нажмите кнопку **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.vpc.route-table.create.button_create }}**. 

    {% endlist %}

1. Привяжите таблицу маршрутизации ко всем подсетям облачной сети `nextcloud-network`, чтобы направить трафик из них через NAT-шлюз:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
      1. На панели слева выберите ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
      1. В строке с нужной подсетью нажмите кнопку ![image](../../_assets/console-icons/ellipsis.svg) и в контекстном меню выберите пункт **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}**.
      1. В открывшемся окне выберите созданную на предыдущем шаге таблицу маршрутизации и нажмите кнопку **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.

    {% endlist %}

    Убедитесь, что в списке для каждой подсети в поле **{{ ui-key.yacloud.vpc.network.overview.column_subnetwork_route-table-id }}** отображается имя привязанной к ней таблицы маршрутизации.

### Создайте сервисный аккаунт и статический ключ доступа {#setup-sa}

Чтобы обеспечить доступ из Nextcloud к бакету {{ objstorage-name }}, создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) и [статический ключ доступа](../../iam/concepts/authorization/access-key.md).

1. Создайте сервисный аккаунт:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. Укажите имя сервисного аккаунта — `nextcloud-sa`.
      1. Нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите [роль](../../iam/roles-reference.md#editor) `editor`.
      1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

    {% endlist %}

1. Создайте статический ключ доступа:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
      1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}** и выберите созданный ранее сервисный аккаунт `nextcloud-sa`.
      1. На панели сверху нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
      1. Сохраните идентификатор и секретный ключ.

          {% note alert %}

          После закрытия диалога значение ключа будет недоступно.

          {% endnote %}

    {% endlist %}

### Создайте бакет {{ objstorage-name }} {#create-bucket}

Создайте бакет {{ objstorage-name }}, который вы будете подключать к Nextcloud:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Справа сверху нажмите **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. В поле **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** укажите имя бакета. Например: `my-nextcloud-bucket`. Имя бакета должно быть [уникальным](../../storage/concepts/bucket.md#naming) в пределах {{ objstorage-full-name }}.
  1. В поле **{{ ui-key.yacloud.storage.bucket.settings.field_size-limit }}** задайте нужный размер бакета или включите опцию **{{ ui-key.yacloud.storage.bucket.settings.label_size-limit-disabled }}**.
  1. Значения остальных параметров оставьте без изменений и нажмите **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

{% endlist %}

### Создайте виртуальную машину {#create-vm}

Создайте виртуальную машину, на которой будет развернут Nextcloud:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}** и нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** в поле **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** введите `Ubuntu 24.04 LTS` и выберите публичный образ [Ubuntu 24.04 LTS](/marketplace/products/yc/ubuntu-24-04-lts).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-a`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** выберите конфигурацию `2 {{ ui-key.yacloud.component.compute.resources.field_cores }} 4 {{ ui-key.yacloud.common.units.label_gigabyte }} {{ ui-key.yacloud.component.compute.resources.field_memory }}`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите сеть `nextcloud-network` и подсеть в зоне доступности виртуальной машины — `nextcloud-network-{{ region-id }}-a`.
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** оставьте значение `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`, чтобы назначить ВМ случайный публичный IP-адрес из пула {{ yandex-cloud }}.
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** выберите группу безопасности `nextcloud-sg`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа к ВМ:

      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя, например: `yc-user`. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `nextcloud-vm`.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

{% endlist %}

### Создайте кластер {{ mmy-name }} {#create-mysql-cluster}

Nextcloud использует базу данных {{ MY }} для хранения служебной информации. В этом руководстве база данных для Nextcloud развернута в [кластере](../../managed-mysql/concepts/index.md) {{ mmy-full-name }}.

{% note info %}

База данных {{ MY }} может быть создана на том же хосте, что и Nextcloud, но это менее надежно и не подходит для развертывания отказоустойчивой конфигурации. Если вы не планируете развертывать отказоустойчивую конфигурацию, вы можете пропустить этап создания кластера и позднее создать базу данных на одном хосте с Nextcloud.

{% endnote %}

Чтобы создать кластер {{ mmy-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}** и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_name }}** введите имя `nextcloud-db-cluster`.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_database }}**:

      * В поле **{{ ui-key.yacloud.mdb.forms.database_field_name }}** введите `nextcloud`.
      * В поле **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** введите `user`.
      * В поле **{{ ui-key.yacloud.mdb.forms.config_field_password }}** выберите `{{ ui-key.yacloud.component.password-input.label_button-enter-manually }}` и введите пароль, который вы будете использовать для доступа к БД.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network }}** выберите сеть `nextcloud-network` и группу безопасности `nextcloud-sg`.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}** убедитесь, что в кластере создается один [хост](../../managed-mysql/concepts/instance-types.md) в той же [зоне доступности](../../overview/concepts/geo-scope.md), в которой вы создали виртуальную машину.

      {% note info %}

      Для тестирования Nextcloud в базовой конфигурации достаточно кластера с одним хостом. Позднее, при развертывании отказоустойчивой конфигурации, вы расширите созданный кластер на остальные зоны доступности.

      {% endnote %}

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}** нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}** и в открывшемся окне:

      1. В поле **character_set_server** выберите значение `utf8mb4`.
      1. В поле **collation_server** выберите значение `utf8mb4_general_ci`.
      1. Значения остальных параметров оставьте без изменения и нажмите кнопку **{{ ui-key.yacloud.component.mdb.settings.popup_settings-submit }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.

{% endlist %}

Создание кластера может занять несколько минут.

### Установите и настройте Nextcloud на виртуальной машине {#setup-nextcloud}

1. Установите Nextcloud на виртуальную машину `nextcloud-vm`:

    1. [Подключитесь](../../compute/operations/vm-connect/ssh.md#vm-connect) к виртуальной машине `nextcloud-vm` по SSH. Все последующие действия этого шага будут выполняться в терминале виртуальной машины.
    1. Обновите версии пакетов, установленные на ВМ:

        ```bash
        sudo apt update && sudo apt upgrade
        ```
    1. Установите необходимые пакеты программного обеспечения и зависимости:

        ```bash
        sudo apt install \
          apache2 mariadb-server libapache2-mod-php php-gd php-mysql php-curl php-mbstring \
          php-intl php-gmp php-bcmath php-xml php-imagick php-zip php-fpm unzip
        ```
    1. (Опционально) Если вы хотите создать базу данных на одном хосте с Nextcloud:

        {% cut "Если вы не создавали кластер {{ MY }} и не планируете развертывать отказоустойчивое решение:" %}

        1. Запустите MySQL:

            ```bash
            sudo mysql
            ```
        1. Выполните команды, чтобы создать базу данных и пользователя, а также выдать пользователю необходимые для работы с базой данных права:

            ```bash
            CREATE USER 'user'@'localhost' IDENTIFIED BY '<пароль>';
            CREATE DATABASE IF NOT EXISTS nextcloud CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
            GRANT ALL PRIVILEGES ON nextcloud.* TO 'user'@'localhost';
            FLUSH PRIVILEGES;
            quit;
            ```

            Где `<пароль>` — пароль, который вы будете использовать для доступа к БД.

        {% endcut %}

    1. Скачайте архив с последней версией Nextcloud:

        ```bash
        wget https://download.nextcloud.com/server/releases/latest.zip
        ```
    1. Распакуйте скачанный архив в директорию `/var/www`:

        ```bash
        sudo unzip latest.zip -d /var/www
        ```
    1. Измените права доступа к директории с Nextcloud:

        ```bash
        sudo chown -R www-data:www-data /var/www/nextcloud
        sudo chmod -R 755 /var/www/nextcloud/
        ```
    1. Настройте виртуальный хост по умолчанию:

        1. Откройте файл конфигурации виртуального хоста по умолчанию:

            ```bash
            sudo nano /etc/apache2/sites-available/000-default.conf
            ```
        1. Замените содержимое открытого файла конфигурации `000-default.conf` на следующее:

            ```text
            <VirtualHost *:80>
            DocumentRoot /var/www/nextcloud/

            <Directory /var/www/nextcloud/>
            Require all granted
            AllowOverride All
            Options FollowSymLinks MultiViews

            <IfModule mod_dav.c>
            Dav off
            </IfModule>
            </Directory>
            </VirtualHost>
            ```
    1. Включите необходимые модули [веб-сервера Apache](https://ru.wikipedia.org/wiki/Apache_HTTP_Server):

        ```bash
        sudo a2enmod rewrite
        sudo a2enmod headers
        a2enmod env
        a2enmod dir
        a2enmod mime
        ```
    1. Увеличьте до `512 МБ` объем оперативной памяти, доступной интерпретатору PHP при обработке запросов к Nextcloud:

        1. Откройте файл `.htaccess` в директории установки Nextcloud:

            ```bash
            sudo nano /var/www/nextcloud/.htaccess
            ```
        1. В конце открытого файла добавьте строку:

            ```bash
            php_value memory_limit 512M
            ```
        
            Не забудьте сохранить внесенные изменения.
    1. Перезапустите веб-сервер:

        ```bash
        sudo systemctl restart apache2
        ```
1. Настройте Nextcloud в графическом пользовательском интерфейсе:

    1. На вашем локальном компьютере откройте браузер и в адресной строке введите:

        ```text
        http://<публичный_IP-адрес_ВМ>
        ```

        Узнать публичный IP-адрес виртуальной машины вы можете в [консоли управления]({{ link-console-main }}) на странице с информацией о ВМ в блоке **{{ ui-key.yacloud.compute.instance.overview.section_network }}** в поле **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}**.
    1. В открывшейся форме **Создайте учетную запись администратора**:

        1. В полях **Новое имя учетной записи администратора** и **Новый пароль администратора** задайте учетные данные администратора Nextcloud, которые вы будете использовать для входа в систему.
        1. В поле **Учётная запись базы данных** введите `user` — имя пользователя БД, которое вы задали при создании кластера {{ MY }} или локальной базы данных.
        1. В поле **Пароль базы данных** введите пароль пользователя БД, который вы задали при создании кластера {{ MY }} или локальной базы данных.
        1. В поле **Имя базы данных** введите `nextcloud` — имя БД, которое вы задали при создании кластера {{ MY }} или локальной базы данных.
        1. В поле **Хост базы данных** укажите [FQDN](../../glossary/fqdn.md) [текущего хост-мастера](../../managed-mysql/operations/connect.md#fqdn-master) кластера и порт в формате:

            ```text
            c-<идентификатор_кластера>.rw.{{ dns-zone }}:3306
            ```

            Узнать идентификатор кластера вы можете в [консоли управления]({{ link-console-main }}) на странице с информацией о кластере в поле **{{ ui-key.yacloud.common.id }}**.

            {% note info %}

            Если вы не будете развертывать отказоустойчивое решение, не создавали кластер {{ MY }}, а вместо этого создали базу данных на виртуальной машине `nextcloud-vm`, оставьте в поле **Хост базы данных** значение `localhost`.

            {% endnote %}

        1. Нажмите кнопку **Установить**.

            Начнется развертывание базы данных Nextcloud в кластере {{ MY }}. Дождитесь завершения этого процесса.
    1. После завершения установки в открывшемся окне с рекомендованными приложениями нажмите кнопку **Пропустить**. Вы сможете вернуться к установке необходимых приложений позднее.
    1. Закройте открывшееся окно с информацией об обновлениях в текущей версии Nextcloud.
    1. Откройте меню управления приложениями. Для этого в правом верхнем углу экрана нажмите на значок пользователя и в открывшемся контекстном меню выберите ![plus](../../_assets/console-icons/plus.svg) **Приложения**.
    1. В открывшемся окне на панели слева выберите ![person](../../_assets/console-icons/person.svg) **Ваши приложения**.
    1. В открывшемся списке найдите приложение `External storage support` и в строке с этим приложением нажмите кнопку **Включить**.

        При необходимости для подтверждения действия во всплывающем окне введите ваш пароль администратора Nextcloud.
    1. Откройте основное меню настроек. Для этого в правом верхнем углу экрана нажмите на значок пользователя и в открывшемся контекстном меню выберите ![admin-icon](../../_assets/tutorials/integrate-nextcloud/admin-icon.svg) **Параметры сервера**.
    1. В открывшемся окне на панели слева в блоке **Параметры сервера** выберите ![app-dark-icon](../../_assets/tutorials/integrate-nextcloud/app-dark-icon.svg) **Внешнее хранилище** и в открывшемся окне в блоке **Внешнее хранилище** задайте настройки интеграции с {{ objstorage-name }}:

        1. В секции **Внешнее хранилище** выберите `Amazon S3`.
        1. В секции **Способ авторизации** выберите `Ключ доступа`.
        1. В секции **Конфигурация**:

            * В поле **Корзина** укажите имя созданного ранее бакета. Например: `my-nextcloud-bucket`.
            * В поле **Имя хоста** укажите `{{ s3-storage-host }}`.
            * В поле **Порт** укажите `443`.
            * В поле **Ключ доступа** вставьте идентификатор созданного ранее статического ключа доступа.
            * В поле **Секретный ключ** вставьте секретный ключ созданного ранее статического ключа доступа.
        1. В секции **Доступно для** включите опцию **Все люди**.
        1. В правой части редактируемого блока нажмите значок ![check](../../_assets/console-icons/check.svg), чтобы сохранить изменения.

            Для подтверждения действия во всплывающем окне введите ваш пароль администратора Nextcloud.

### Протестируйте работу решения в базовой конфигурации {#test-simple}

Чтобы проверить работу интеграции {{ objstorage-full-name }} с Nextcloud на одном хосте:

1. На вашем локальном компьютере откройте браузер и в адресной строке введите публичный IPv4-адрес виртуальной машины, на которой развернут Nextcloud:

    ```text
    http://<публичный_IP-адрес_ВМ>
    ```
1. Аутентифицируйтесь в Nextcloud с помощью логина и пароля, созданных при настройке решения на предыдущем этапе.
1. В левой части верхнего меню выберите ![folder-fill](../../_assets/console-icons/folder-fill.svg) **Файлы**.
1. В меню слева выберите **Внешнее хранилище** и выберите **AmazonS3**.
1. Нажмите ![plus](../../_assets/console-icons/plus.svg) **Новый** и выберите ![arrow-shape-up-from-line](../../_assets/console-icons/arrow-shape-up-from-line.svg) **Загрузить файлы**, чтобы загрузить в хранилище файл с локального компьютера.
1. Выберите файл на локальном компьютере и загрузите его в хранилище.

    Загруженный файл отобразится в хранилище `AmazonS3` Nextcloud.
1. В сервисе {{ objstorage-full-name }} [убедитесь](../../storage/operations/objects/list.md), что файл был загружен в бакет.

На этом завершено развертывание базовой конфигурации Nextcloud. Если в базовой конфигурации вы использовали кластер {{ MY }}, теперь вы можете перейти к развертыванию отказоустойчивой конфигурации.

## Разверните Nextcloud в отказоустойчивой конфигурации {#the-redundant-variant}

Отказоустойчивая конфигурация Nextcloud будет развернута в группе из трех виртуальных машин, при этом нагрузка на хосты Nextcloud будет распределяться с помощью L7-балансировщика {{ alb-full-name }}. Служебная база данных будет расположена в кластере {{ MY }}, состоящем из трех хостов. Хосты группы ВМ, балансировщика и кластера {{ MY }} будут равномерно распределены по трем [зонам доступности](../../overview/concepts/geo-scope.md). Nextcloud будет доступен по доменному имени, для которого в {{ certificate-manager-name }} будет выпущен TLS-сертификат.

### Масштабируйте кластер {{ mmy-name }} {#expand-mysql-cluster}

Чтобы добавить дополнительные хосты в кластер {{ mmy-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}** и выберите кластер `nextcloud-db-cluster`.
  1. В меню слева выберите ![cube](../../_assets/console-icons/cube.svg) **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}**.
  1. С помощью кнопки **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}** добавьте дополнительные [хосты](../../managed-mysql/concepts/instance-types.md), так чтобы в кластере было три хоста — по одному в каждой [зоне доступности](../../overview/concepts/geo-scope.md).

        При создании хостов не включайте опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.

        {% note warning %}

        Прежде чем добавлять третий хост, дождитесь, когда второй хост перейдет в состояние `ALIVE`. Вы не сможете добавить в кластер новый хост до тех пор, пока не завершится операция добавления предыдущего хоста.

        {% endnote %}

{% endlist %}

### Донастройте Nextcloud и создайте снимок диска виртуальной машины {#create-snapshot}

Прежде чем создавать снимок виртуальной машины для последующего развертывания группы ВМ, добавьте ваш домен в список доверенных адресов и доменов Nextcloud:

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md#vm-connect) к виртуальной машине `nextcloud-vm` по SSH.
1. Добавьте ваш домен в массив доверенных адресов и доменов Nextcloud:

    1. В терминале ВМ откройте файл конфигурации Nextcloud:

        ```bash
        sudo nano /var/www/nextcloud/config/config.php
        ```
    1. В массиве `trusted_domains` замените IP-адрес хоста на имя вашего домена.

        Например:

        ```php
        'trusted_domains' =>
        array (
          0 => 'example.com',
        ),
        ```

        Массив значений `trusted_domains` позволяет задать ограничение на IP-адреса и/или домены, по которым вы можете обращаться к Nextcloud, и обеспечивает дополнительную защиту от несанкционированного доступа. Вы можете указать несколько адресов и/или доменов, а также ослабить или снять это ограничение с помощью символов подстановки:

        {% list tabs %}

        - Пример 1

          ```php
          'trusted_domains' =>
          array (
            0 => '*.example.com',
            1 => '198.168.*.*',
          ),
          ```

          В этом примере доступ разрешается с любых поддоменов домена `example.com`, а также с IP-адресов в диапазоне `192.168.0.0` — `192.168.255.255`.

        - Пример 2

          ```php
          'trusted_domains' =>
          array (
            0 => '*',
          ),
          ```

          В этом примере доступ разрешается с любых доменов и IP-адресов.

        {% endlist %}
    1. Удалите строку `'overwrite.cli.url' => 'http://<IP-адрес_ВМ>',`.
    1. Сохраните изменения и закройте редактор `nano`.
1. [Остановите](../../compute/operations/vm-control/vm-stop-and-start.md#stop) виртуальную машину `nextcloud-vm`.
1. После остановки ВМ создайте снимок диска виртуальной машины `nextcloud-vm`:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. На панели слева выберите ![hard-drive](../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.disks_ddfdb }}**.
      1. В строке с нужным диском нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.compute.disks.button_action-snapshot }}**.
      1. В поле **{{ ui-key.yacloud.common.name }}** задайте имя снимка `nextcloud-vm-snapshot`.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
      1. Дождитесь завершения процесса создания снимка.
      
          Чтобы отследить статус снимка, на панели слева выберите ![image](../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.snapshots_81jHX }}**.

    {% endlist %}


### Добавьте TLS-сертификат в {{ certificate-manager-full-name }} {#issue-certificate}

Для того чтобы организовать доступ к Nextcloud по протоколу HTTPS, выпустите TLS-сертификат для вашего домена:

1. Добавьте в сервис {{ certificate-manager-name }} [сертификат](../../certificate-manager/concepts/managed-certificate.md) от Let's Encrypt® для вашего домена:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
      1. Нажмите **{{ ui-key.yacloud.certificate-manager.button_empty-action }}** и выберите **{{ ui-key.yacloud.certificate-manager.action_request }}**.
      1. В открывшемся окне в поле **{{ ui-key.yacloud.certificate-manager.metadata.field_name }}** укажите `mymanagedcert`.
      1. В поле **{{ ui-key.yacloud.certificate-manager.request.field_domains }}** укажите имя вашего домена, например `example.com`.
      1. В поле **{{ ui-key.yacloud.certificate-manager.request.field_challenge-type }}** выберите `{{ ui-key.yacloud.certificate-manager.request.challenge-type_label_dns }}` и нажмите кнопку **{{ ui-key.yacloud.certificate-manager.request.button_request }}**.

    {% endlist %}

    В списке сертификатов появится новый сертификат со статусом `Validating`. Этот статус означает, что запрос на выпуск сертификата от Let's Encrypt® создан и для его успешной обработки вам необходимо пройти [процедуру проверки прав на домены](../../certificate-manager/operations/managed/cert-validate.md).
1. Для успешного выпуска сертификата пройдите проверку прав на домены:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
      1. В списке сертификатов выберите `mymanagedcert`.
      1. В открывшемся окне в блоке **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}** выберите `CNAME-запись`.
      1. Добавьте в публичную DNS-зону вашего домена [CNAME-запись](../../dns/concepts/resource-record.md#cname), необходимую для проверки прав на домен. Порядок действий на этом шаге будет зависеть от того, управляет вашим доменом сервис {{ dns-full-name }} или сторонний DNS-провайдер:

          {% include [creating-cname](../../_includes/certificate-manager/creating-cname.md) %}

          Проверка прав на домены может занять от нескольких минут до нескольких дней — дождитесь ее успешного завершения. В результате сертификат будет выпущен и перейдет в статус `Issued`.

    {% endlist %}

### Разверните группу виртуальных машин {#create-instance-group}

Чтобы обеспечить отказоустойчивость развернутого решения Nextcloud, масштабируйте его на [группу виртуальных машин](../../compute/concepts/instance-groups/index.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.groups.button_create }}**.
  1. В поле **{{ ui-key.yacloud.compute.groups.create.field_name }}** задайте имя группы `nextcloud-instance-group`.
  1. В поле **{{ ui-key.yacloud.compute.groups.create.field_service-account }}** выберите сервисный аккаунт `nextcloud-sa`.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_allocation }}** выберите все [зоны доступности](../../overview/concepts/geo-scope.md), чтобы обеспечить максимальную отказоустойчивость.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_instance }}** нажмите кнопку **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}** и в открывшейся форме:

      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}** и нажмите кнопку **{{ ui-key.yacloud.common.select }}**.

          В открывшемся окне выберите созданный ранее снимок `nextcloud-vm-snapshot` и нажмите кнопку **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** выберите конфигурацию `2 {{ ui-key.yacloud.component.compute.resources.field_cores }} 4 {{ ui-key.yacloud.common.units.label_gigabyte }} {{ ui-key.yacloud.component.compute.resources.field_memory }}`.
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

          1. В поле **{{ ui-key.yacloud.compute.instances.create.field_instance-group-network }}** выберите сеть `nextcloud-network`.
          1. В поле **{{ ui-key.yacloud.compute.instances.create.field_instance-group-address }}** выберите `{{ ui-key.yacloud.compute.instances.create.value_address-none }}`.
          1. В поле **{{ ui-key.yacloud.compute.instances.create.field_security-groups }}** выберите `nextcloud-sg`.
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа к ВМ:
      
          * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя, например: `yc-user`. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
          * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}
      1. Нажмите кнопку **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_scale }}** в поле **{{ ui-key.yacloud.compute.groups.create.field_scale-size }}** укажите `3`.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_alb }}** включите опцию **{{ ui-key.yacloud.compute.groups.create.field_target-group-attached }}** и в появившемся поле **{{ ui-key.yacloud.compute.groups.create.field_target-group-name }}** укажите имя `nextcloud-target-group`.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_health-check }}**:

      1. Включите опцию **{{ ui-key.yacloud.compute.groups.create.field_enable-health-check }}**.
      1. В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-protocol }}** выберите `{{ ui-key.yacloud.common.label_tcp }}`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}** и дождитесь создания и запуска группы ВМ.

{% endlist %}

### Создайте L7-балансировщик {#setup-balancer}

Чтобы обеспечить распределение трафика между хостами будущей группы ВМ с Nextcloud, создайте [балансировщик нагрузки уровня приложений](../../application-load-balancer/concepts/application-load-balancer.md):

1. Создайте [группу бэкендов](../../application-load-balancer/concepts/backend-group.md):

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
      1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.alb.label_backend-groups }}** и нажмите кнопку **{{ ui-key.yacloud_billing.alb.button_backend-group-create }}**.
      1. В поле **{{ ui-key.yacloud.common.name }}** укажите имя группы `nextcloud-bg`.
      1. Включите опцию **{{ ui-key.yacloud_billing.alb.label_session-affinity }}** и в появившемся поле **{{ ui-key.yacloud_billing.alb.label_session-affinity-mode }}** выберите `{{ ui-key.yacloud.alb.label_affinity-connection }}`.
      1. В блоке **{{ ui-key.yacloud.alb.label_backends }}** нажмите кнопку **{{ ui-key.yacloud.common.add }}** и в появившейся форме **{{ ui-key.yacloud_billing.alb.label_new-backend }}**:

          1. В поле **{{ ui-key.yacloud.common.name }}** задайте имя `nextcloud-backend`.
          1. В поле **{{ ui-key.yacloud_billing.alb.label_target-groups }}** выберите созданную ранее целевую группу `nextcloud-target-group`.
          1. Разверните секцию **{{ ui-key.yacloud.alb.label_lb-settings }}** и в поле **{{ ui-key.yacloud.alb.label_load-balancing-mode }}** выберите `MAGLEV_HASH`.
          1. В секции **HTTP проверка состояния** нажмите кнопку ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

    {% endlist %}

1. Создайте [HTTP-роутер](../../application-load-balancer/concepts/http-router.md):

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
      1. На панели слева выберите ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}** и нажмите кнопку **{{ ui-key.yacloud.alb.button_http-router-create }}**.
      1. В поле **{{ ui-key.yacloud.common.name }}** укажите имя HTTP-роутера `nextcloud-router`.
      1. В блоке **{{ ui-key.yacloud_billing.alb.label_virtual-hosts }}** нажмите кнопку **{{ ui-key.yacloud.alb.button_virtual-host-add }}** и в открывшейся форме **{{ ui-key.yacloud_billing.alb.label_new-virtual-host }}**:

          1. В поле **{{ ui-key.yacloud.common.name }}** укажите имя виртуального хоста `nextcloud-vh` и нажмите кнопку **{{ ui-key.yacloud_billing.alb.button_add-route }}**.
          1. В открывшейся форме **{{ ui-key.yacloud.alb.label_new-route }}** в поле **{{ ui-key.yacloud.common.name }}** задайте имя маршрута `nextcloud-route`.
          1. В поле **{{ ui-key.yacloud_billing.alb.label_backend-group }}** выберите созданную на предыдущем шаге группу бэкендов `nextcloud-bg`.
          1. Значения остальных параметров оставьте без изменения и внизу страницы нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

    {% endlist %}

1. Создайте L7-балансировщик:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_load-balancer-create }}** и выберите **{{ ui-key.yacloud.alb.label_alb-create-form }}**.
      1. В поле **{{ ui-key.yacloud.common.name }}** укажите имя балансировщика `nextcloud-alb`.
      1. В поле **{{ ui-key.yacloud.mdb.forms.label_network }}** выберите сеть `nextcloud-network`.
      1. В поле **{{ ui-key.yacloud.mdb.forms.field_security-group }}** выберите `{{ ui-key.yacloud.component.security-group-field.label_sg-from-list }}` и в появившемся списке выберите группу безопасности `nextcloud-sg`.
      1. В блоке **{{ ui-key.yacloud_billing.alb.section_allocation-settings }}** убедитесь, что выбраны все зоны доступности.
      1. Если вы не хотите сохранять логи работы балансировщика в [лог-группу](../../logging/concepts/log-group.md), отключите опцию **{{ ui-key.yacloud.alb.label_log-requests }}**.
      1. В секции **{{ ui-key.yacloud_billing.alb.label_listeners }}** нажмите кнопку **{{ ui-key.yacloud.alb.button_add-listener }}** и в открывшейся форме:

          1. В поле **{{ ui-key.yacloud.common.name }}** укажите имя обработчика `nextcloud-listener`.
          1. В поле **{{ ui-key.yacloud.alb.label_protocol-type }}** выберите `HTTPS`.
          1. В поле **{{ ui-key.yacloud_billing.alb.label_certificate }}** выберите созданный ранее сертификат `mymanagedcert`.
          1. В поле **{{ ui-key.yacloud_billing.alb.label_http-router }}** выберите созданный ранее HTTP-роутер `nextcloud-router`.
      1. Значения остальных параметров оставьте без изменения и внизу страницы нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

    {% endlist %}

    Дождитесь, когда статус балансировщика изменится на `Active`, и в поле **{{ ui-key.yacloud.alb.column_addresses }}** скопируйте его IP-адрес.

### Создайте ресурсную A-запись в публичной зоне DNS вашего домена {#create-a-record}

Для того чтобы запросы, поступающие к вашему домену, направлялись на L7-балансировщик, создайте в вашей зоне DNS ресурсную [A-запись](../../dns/concepts/resource-record.md#a), указывающую на полученный на предыдущем шаге IP-адрес балансировщика. Порядок действий на этом шаге будет зависеть от того, управляет вашим доменом сервис {{ dns-full-name }} или сторонний DNS-провайдер.

{% cut "**Если вашим доменом управляет сервис {{ dns-full-name }}**" %}
 
{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Выберите нужную зону DNS, нажмите кнопку **{{ ui-key.yacloud.dns.button_record-set-create }}** и в открывшемся окне:

      1. В поле **{{ ui-key.yacloud.common.name }}** выберите `{{ ui-key.yacloud.dns.label_fqdn-equal-to-zone }}`.
      1. В поле **{{ ui-key.yacloud.common.type }}** выберите `A`.
      1. В поле **{{ ui-key.yacloud.dns.label_records }}** укажите сохраненный на предыдущем шаге IP-адрес балансировщика нагрузки.
      1. Значения других параметров оставьте без изменения и нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

{% endcut %}

{% cut "**Если вашим доменом управляет сторонний DNS-провайдер**" %}

Разместите у своего DNS-провайдера или на собственном [DNS-сервере](../../glossary/dns.md#dns-server) ресурсную A-запись со следующими значениями:

* Хост — `@`.
* Тип — `A`.
* Значение — `<IP-адрес_балансировщика>`.

{% endcut %}

### Протестируйте работу решения в отказоустойчивой конфигурации {#test-redundant}

Чтобы проверить работу интеграции {{ objstorage-full-name }} с Nextcloud в отказоустойчивой конфигурации:

1. На вашем локальном компьютере откройте браузер и в адресной строке введите имя вашего домена, например:

    ```text
    https://example.com
    ```
1. Аутентифицируйтесь в Nextcloud с помощью логина и пароля, созданных при настройке решения.
1. В левой части верхнего меню выберите ![folder-fill](../../_assets/console-icons/folder-fill.svg) **Файлы**.
1. В меню слева выберите **Внешнее хранилище** и выберите **AmazonS3**.
1. Убедитесь, что вы видите загруженный на предыдущем этапе проверки файл.
1. Скачайте загруженный ранее файл. Для этого в строке с именем файла нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![arrow-down](../../_assets/console-icons/arrow-down.svg) **Скачать**.
1. Удалите файл. Для этого в строке с именем файла нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../_assets/console-icons/trash-bin.svg) **Удалить файл**.
1. В сервисе {{ objstorage-full-name }} [убедитесь](../../storage/operations/objects/list.md), что файл был удален из бакета.

## Как удалить созданные ресурсы {#clear-out}

1. Если вы создавали L7-балансировщик, [удалите](../../application-load-balancer/operations/application-load-balancer-delete.md) его, затем последовательно удалите [HTTP-роутер](../../application-load-balancer/operations/http-router-delete.md), [группу бэкендов](../../application-load-balancer/operations/backend-group-delete.md) и [целевую группу](../../application-load-balancer/operations/target-group-delete.md) балансировщика.
1. Если вы создавали группу ВМ, [удалите](../../compute/operations/instance-groups/delete.md) ее.
1. Если вы создавали ресурсные записи, удалите их [в {{ dns-full-name }}](../../dns/operations/resource-record-delete.md) или в личном кабинете вашего регистратора доменных имен.
1. Если вы создавали зону DNS, удалите ее в [в {{ dns-full-name }}](../../dns/operations/zone-delete.md) или в личном кабинете вашего регистратора доменных имен.
1. Если вы оставляли включенной опцию записи логов L7-балансировщика, [удалите](../../logging/operations/delete-group.md) лог-группу.
1. [Удалите](../../compute/operations/vm-control/vm-delete.md) виртуальную машину.
1. [Удалите](../../managed-mysql/operations/cluster-delete.md) кластер БД {{ MY }}.
1. [Удалите](../../storage/operations/objects/delete.md) созданные в бакете объекты, затем [удалите](../../storage/operations/buckets/delete.md) сам бакет.
1. [Удалите](../../compute/operations/snapshot-control/delete.md) снимок диска.
1. [Удалите](../../iam/operations/sa/delete.md) сервисный аккаунт.
1. Последовательно удалите [подсети](../../vpc/operations/subnet-delete.md), [группу безопасности](../../vpc/operations/security-group-delete.md), [таблицу маршрутизации](../../vpc/operations/delete-route-table.md), [NAT-шлюз](../../vpc/operations/delete-nat-gateway.md) и [облачную сеть](../../vpc/operations/network-delete.md).
1. При необходимости [удалите](../../certificate-manager/operations/managed/cert-delete.md) TLS-сертификат, если вы создавали его.