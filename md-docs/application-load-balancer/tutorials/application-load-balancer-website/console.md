# Отказоустойчивый сайт с балансировкой нагрузки через {{ alb-full-name }} с помощью консоли управления


Чтобы создать инфраструктуру для [сайта с балансировкой нагрузки](index.md) в трех [зонах доступности](../../../overview/concepts/geo-scope.md) с использованием балансировщика [{{ alb-name }}](../../concepts/index.md) c помощью консоли управления {{ yandex-cloud }}:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте облачную сеть](#create-network).
1. [Создайте группы безопасности](#create-security-groups).
1. [Создайте группу виртуальных машин](#create-vms).
1. [Загрузите файлы сайта](#upload-files).
1. [Создайте группу бэкендов](#create-backend-group).
1. [Создайте HTTP-роутер](#create-http-routers-sites).
1. [Создайте L7-балансировщик](#create-alb).
1. [Настройте DNS](#configure-dns).
1. [Протестируйте отказоустойчивость](#test-ha).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:
* плата за постоянно запущенные [ВМ](../../../compute/concepts/vm.md) (см. [тарифы {{ compute-full-name }}](../../../compute/pricing.md));
* плата за использование динамического [публичного IP-адреса](../../../vpc/concepts/address.md#public-addresses) (см. [тарифы {{ vpc-full-name }}](../../../vpc/pricing.md));
* плата за балансировку трафика (см. [тарифы {{ alb-name }}](../../pricing.md));
* плата за публичные [DNS-запросы](../../../glossary/dns.md) и [зоны DNS](../../../dns/concepts/dns-zone.md), если вы используете [{{ dns-full-name }}](../../../dns/index.md) (см. [тарифы {{ dns-name }}](../../../dns/pricing.md)).

## Создайте облачную сеть {#create-network}

Все ресурсы, созданные в сценарии, будут относиться к одной [облачной сети](../../../vpc/concepts/network.md).

Чтобы создать сеть:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления]({{ link-console-main }}).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. Укажите **{{ ui-key.yacloud.vpc.networks.create.field_name }}** сети: `mysite-network`.
  1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** выберите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

{% endlist %}

## Создайте группы безопасности {#create-security-groups}

[Группы безопасности](../../concepts/application-load-balancer.md#security-groups) содержат правила, которые разрешают [балансировщику](../../concepts/application-load-balancer.md) получать входящий трафик и отправлять его на ВМ, а ВМ — получать этот трафик.

Чтобы создать группы безопасности для балансировщика и для [группы ВМ](../../../compute/concepts/instance-groups/index.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления]({{ link-console-main }}).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}**. 
  1. Создайте группу безопасности для балансировщика:
     1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
     1. Введите имя группы, например `alb-sg`.
     1. Выберите сеть, которой будет назначена группа безопасности.
     1. В блоке **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}** создайте следующие правила по инструкции под таблицей:

        Направление<br>трафика | Описание | Диапазон<br>портов | Протокол | Тип источника /<br>назначения | Источник /<br>назначение
        --- | --- | --- | --- | --- | ---
        `Исходящий` | `any` | `Весь` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
        `Входящий` | `ext-http` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
        `Входящий` | `ext-https` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
        `Входящий` | `healthchecks` | `30080` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}` | —

        1. Выберите вкладку **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** или **{{ ui-key.yacloud.vpc.network.security-groups.label_ingress }}**.
        1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
        1. В открывшемся окне в поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** укажите один порт или диапазон портов, куда или откуда будет поступать трафик.
        1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** укажите нужный протокол или оставьте **{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}**, чтобы разрешить передачу трафика по всем протоколам.
        1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** или **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** выберите назначение правила:
           * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` — правило будет применено к диапазону IP-адресов. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** укажите CIDR и маски подсетей, в которые или из которых будет поступать трафик. Чтобы добавить несколько CIDR, нажимайте кнопку **{{ ui-key.yacloud.vpc.subnetworks.create.button_add-cidr }}**.
           * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}` — правило будет применено к ВМ из текущей группы или из выбранной группы безопасности.
           * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}` — правило, которое позволяет балансировщику проверять состояние ВМ.
        1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**. Таким образом создайте все правила из таблицы.
     1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
  1. Аналогично создайте группу безопасности для группы ВМ с именем `alb-vm-sg`, той же сетью и следующими правилами:

     Направление<br>трафика | Описание | Диапазон<br>портов | Протокол | Тип источника | Источник
     --- | --- | --- | --- | --- | ---
     `Входящий` | `balancer` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}` | `alb-sg`
     `Входящий` | `ssh` | `22` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`

{% endlist %}

## Создайте группу ВМ {#create-vms}

На ВМ из [целевой группы](../../concepts/target-group.md) развертываются [бэкенды](../../concepts/backend-group.md) вашего приложения. Целевая группа будет подключена к балансировщику, чтобы на эндпоинты бэкендов приложения можно было направлять запросы.

Чтобы создать группу ВМ с минимальной конфигурацией:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления]({{ link-console-main }}).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Откройте вкладку **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}** и нажмите кнопку **{{ ui-key.yacloud.compute.groups.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_base }}**:
     * Введите имя группы ВМ, например `website-vm-group`.
     * Выберите [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) из списка или создайте новый. Чтобы иметь возможность создавать, обновлять и удалять ВМ в группе, назначьте сервисному аккаунту [роль](../../../iam/concepts/access-control/roles.md) `editor`. По умолчанию все операции с группами безопасности выполняются от имени сервисного аккаунта.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_allocation }}** выберите три зоны доступности (`{{ region-id }}-a`, `{{ region-id }}-b` и `{{ region-id }}-d`), чтобы обеспечить отказоустойчивость хостинга.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_instance }}** нажмите кнопку **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}** и укажите [шаблон](../../../compute/concepts/instance-groups/instance-template.md) ВМ:
     * В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** и выберите продукт [LEMP](https://yandex.cloud/ru/marketplace/products/yc/lemp) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
     * В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** укажите:
       * **{{ ui-key.yacloud.compute.disk-form.field_type }}** [диска](../../../compute/concepts/disk.md) — `HDD`.
       * **{{ ui-key.yacloud.compute.disk-form.field_size }}** — `3 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
     * В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** укажите:
       * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Cascade Lake`.
       * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `5%`.
       * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `2`.
       * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `1 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
     * В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
       * Выберите облачную сеть и ее подсети.
       * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите **{{ ui-key.yacloud.component.compute.network-select.switch_auto }}**.
       * Выберите группу безопасности `alb-vm-sg`.
     * В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа на ВМ:
       * В поле **{{ ui-key.yacloud.compute.instances.create.field_service-account }}** выберите сервисный аккаунт для привязки к ВМ.
       * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.
       * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла открытого ключа.

       Для подключения по [SSH](../../../glossary/ssh-keygen.md) необходимо создать пару ключей. Подробнее в разделе [Подключиться к ВМ Linux по SSH](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
     * Нажмите кнопку **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_scale }}** укажите **{{ ui-key.yacloud.compute.groups.create.field_scale-size }}** группы ВМ — `3`.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_alb }}** выберите опцию **{{ ui-key.yacloud.compute.groups.create.field_target-group-attached }}** и укажите имя группы: `alb-tg`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

Создание группы ВМ может занять несколько минут. Когда все ВМ перейдут в [статус](../../../compute/concepts/vm-statuses.md) `RUNNING`, вы можете [загрузить на них файлы сайта](#upload-files).

## Загрузите файлы сайта {#upload-files}

Чтобы проверить работу веб-сервера, необходимо загрузить файлы сайта на каждую ВМ. Для примера вы можете использовать файл `index.html` из [архива](https://{{ s3-storage-host }}/doc-files/index.html.zip).

Для каждой ВМ в [созданной группе](#create-vms) выполните следующее:
1. На вкладке **{{ ui-key.yacloud.compute.instances.label_title }}** нажмите на имя нужной ВМ в списке.
1. Скопируйте **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}** из блока **{{ ui-key.yacloud.compute.instance.overview.section_network }}**.
1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ по протоколу SSH.
1. Выдайте права на запись для вашего пользователя на директорию `/var/www/html`:

   ```bash
   sudo chown -R "$USER":www-data /var/www/html
   ```

1. Загрузите на ВМ файлы сайта с помощью [протокола SCP](https://ru.wikipedia.org/wiki/SCP).

   {% list tabs group=operating_system %}

   - Linux/macOS {#linux-macos}

     Используйте утилиту командной строки `scp`:

     ```bash
     scp -r <путь_до_директории_с-файлами> <имя_пользователя_ВМ>@<IP-адрес_ВМ>:/var/www/html
     ```

   - Windows {#windows}

     С помощью программы [WinSCP](https://winscp.net/eng/download.php) скопируйте локальную директорию с файлами в директорию `/var/www/html` на ВМ.

   {% endlist %}

## Создайте группу бэкендов {#create-backend-group}

Целевую группу, созданную вместе с группой ВМ, привяжите к [группе бэкендов](../../concepts/backend-group.md) с настройками распределения трафика.

Для бэкендов в группах будут созданы [проверки состояния](../../concepts/backend-group.md#health-checks): балансировщик будет периодически отправлять проверочные запросы к ВМ и ожидать ответа в течение определенного периода.

Чтобы создать группу бэкендов:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали группу ВМ.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Откройте вкладку **{{ ui-key.yacloud.alb.label_backend-groups }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_backend-group-create }}**.
  1. Введите имя группы бэкендов, например `website-bg`.
  1. В блоке **{{ ui-key.yacloud.alb.label_backends }}** нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
  1. Введите имя бэкенда, например `backend-1`.
  1. В поле **{{ ui-key.yacloud.alb.label_target-groups }}** выберите созданную ранее целевую группу `alb-tg`.
  1. Укажите **{{ ui-key.yacloud.alb.label_port }}**, на котором ВМ бэкенда будут принимать входящий трафик от балансировщика: `80`.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_add-healthcheck }}**.
  1. Укажите **{{ ui-key.yacloud.alb.label_port }}**, на котором ВМ бэкенда будут принимать проверочные соединения: `80`.
  1. Укажите **{{ ui-key.yacloud.alb.label_path }}**, к которому будет обращаться балансировщик при проверке состояния: `/`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Создайте HTTP-роутер {#create-http-routers-sites}

Привяжите группу бэкендов к [HTTP-роутеру](../../concepts/http-router.md) с правилами маршрутизации HTTP-запросов.

Чтобы создать HTTP-роутер и добавить в него маршрут:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте вкладку **{{ ui-key.yacloud.alb.label_http-routers }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_http-router-create }}**.
  1. Введите имя роутера, например `website-router`.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_virtual-host-add }}**.
  1. Введите имя виртуального хоста, например `alb-host`.
  1. В поле **{{ ui-key.yacloud.alb.label_authority }}** введите доменное имя сайта: `alb-example.com`.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_add-route }}**.
  1. Введите имя, например `route-1`.
  1. В поле **{{ ui-key.yacloud.alb.label_backend-group }}** выберите созданную ранее группу `website-bg`.
  1. Остальные настройки оставьте без изменений и нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Создайте L7-балансировщик {#create-alb}

Чтобы создать балансировщик:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте вкладку **{{ ui-key.yacloud.alb.label_load-balancers }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_load-balancer-create }}**.
  1. Введите имя балансировщика, например `website-alb`.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите сеть, к которой подключена группа ВМ, и [созданную ранее](#create-security-groups) группу безопасности `alb-sg`.
  1. В блоке **{{ ui-key.yacloud.alb.section_allocation-settings }}** выберите подсети для узлов балансировщика в каждой зоне доступности и включите прием трафика.
  1. В блоке **{{ ui-key.yacloud.alb.label_listeners }}** нажмите кнопку **{{ ui-key.yacloud.alb.button_add-listener }}**.
  1. Введите имя обработчика, например `alb-listener`.
  1. В блоке **{{ ui-key.yacloud.alb.section_external-address-specs }}** включите передачу трафика.
  1. Укажите порт `80`.
  1. В поле **{{ ui-key.yacloud.alb.label_http-router }}** выберите созданный ранее роутер `website-router`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Настройте DNS {#configure-dns}

Доменное имя `alb-example.com`, которое вы хотите использовать для сайта, нужно связать с IP-адресом балансировщика с помощью [записей DNS](../../../dns/concepts/resource-record.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления]({{ link-console-main }}).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Скопируйте IP-адрес созданного балансировщика.
  1. На сайте компании, которая предоставляет вам услуги DNS-хостинга, перейдите в настройки DNS.
  1. Создайте или измените [A-запись](../../../dns/concepts/resource-record.md#a) и [CNAME-запись](../../../dns/concepts/resource-record.md#cname) для `alb-example.com`:

      ```text
      alb-example.com. A <IP-адрес_L7-балансировщика>
      alb-example.com. CNAME
      ```

      Если вы пользуетесь [{{ dns-full-name }}](../../../dns/index.md), настройте записи по следующей инструкции:

      {% cut "Инструкция по настройке DNS-записей для {{ dns-name }}" %}

      Чтобы получить доступ к именам из публичной зоны, вам нужно делегировать домен. Укажите адреса серверов `ns1.{{ dns-ns-host-sld }}` и `ns2.{{ dns-ns-host-sld }}` в личном кабинете вашего регистратора.

      1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
      1. Если у вас нет публичной [зоны DNS](../../../dns/concepts/dns-zone.md), создайте ее:
          1. Нажмите кнопку **{{ ui-key.yacloud.dns.button_zone-create }}**.
          1. Укажите **{{ ui-key.yacloud.common.name }}** зоны: `alb-zone`.
          1. В поле **{{ ui-key.yacloud.dns.label_zone }}** укажите доменное имя сайта с точкой в конце: `alb-example.com.`
          1. Выберите **{{ ui-key.yacloud.common.type }}** зоны — `{{ ui-key.yacloud.dns.label_public }}`.
          1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
      1. Создайте А-запись в зоне:
          1. Нажмите кнопку **{{ ui-key.yacloud.dns.button_record-set-create }}**.
          1. **{{ ui-key.yacloud.common.name }}**: оставьте пустым.
          1. **{{ ui-key.yacloud.common.type }}**: оставьте значение `А`.
          1. **TTL** (время кеширования записи): оставьте значение по умолчанию.
          1. **{{ ui-key.yacloud.dns.label_records }}**: введите публичный IP-адрес балансировщика `website-alb`.
          1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
      1. Создайте CNAME-запись:
          1. Нажмите кнопку **{{ ui-key.yacloud.dns.button_record-set-create }}**.
          1. **{{ ui-key.yacloud.common.name }}**: `www`.
          1. **{{ ui-key.yacloud.common.type }}**: выберите значение `CNAME`.
          1. **TTL** (время кеширования записи): оставьте значение по умолчанию.
          1. **{{ ui-key.yacloud.dns.label_records }}**: введите `alb-example.com`.
          1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

      {% endcut %}

{% endlist %}

## Протестируйте отказоустойчивость {#test-ha}

1. Откройте [консоль управления]({{ link-console-main }}).
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. Перейдите на страницу ВМ из созданной ранее группы.
1. Скопируйте **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}** из блока **{{ ui-key.yacloud.compute.instance.overview.section_network }}**.
1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ по протоколу SSH.
1. Остановите веб-сервис, чтобы сымитировать сбой в работе веб-сервера:

   ```bash
   sudo service nginx stop
   ```

1. Откройте ваш сайт в браузере. Несмотря на сбой в работе одного из веб-серверов, сайт должен успешно открыться.
1. После завершения проверки запустите веб-сервис:

   ```bash
   sudo service nginx start
   ```

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Удалите нетарифицируемые ресурсы, которые блокируют удаление тарифицируемых ресурсов:
   1. [Удалите](../../operations/application-load-balancer-delete.md) L7-балансировщик `website-alb`.
   1. [Удалите](../../operations/http-router-delete.md) HTTP-роутер `website-router`.
   1. [Удалите](../../operations/backend-group-delete.md) группу бэкендов `website-bg`.
1. [Удалите](../../../compute/operations/instance-groups/delete.md) группу ВМ `website-vm-group`.
1. Если вы использовали {{ dns-full-name }}, то [удалите](../../../dns/operations/resource-record-delete.md) DNS-записи и [удалите](../../../dns/operations/zone-delete.md) DNS-зону.

#### См. также {#see-also}

* [{#T}](terraform.md)