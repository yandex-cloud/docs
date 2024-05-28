1. [Подготовьте облако к работе](#before-begin).
1. [Создайте облачную сеть](#create-network).
1. [Зарезервируйте статический публичный IP-адрес](#reserve-ip)
1. [Создайте группы безопасности](#create-security-groups).
1. [Импортируйте TLS-сертификат сайта в {{ certificate-manager-name }}](#import-certificate).
1. [Создайте группу ВМ для сайта](#create-ig).
1. [Создайте группу бэкендов](#create-backend-group).
1. [Создайте и настройте HTTP-роутер](#create-http-router).
1. [Создайте L7-балансировщик](#create-l7-balancer).
1. [Настройте DNS для сайта](#configure-dns).
1. [Проверьте работу хостинга](#test).

В качестве примера используется доменное имя `my-site.com`.

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [tls-termination-paid-resources](../_tutorials_includes/tls-termination-paid-resources.md) %}

### Создайте облачную сеть {#create-network}

Все ресурсы, созданные в сценарии, будут относиться к одной [облачной сети](../../vpc/concepts/network.md).

Чтобы создать сеть:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. Укажите **{{ ui-key.yacloud.vpc.networks.create.field_name }}** сети: `mysite-network`.
  1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** выберите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

{% endlist %}

### Зарезервируйте статический публичный IP-адрес {#reserve-ip}

Для работы виртуального хостинга потребуется статический публичный IP-адрес, который будет назначен L7-балансировщику.

Чтобы зарезервировать IP-адрес:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Откройте вкладку **{{ ui-key.yacloud.vpc.switch_addresses }}**. Нажмите кнопку **{{ ui-key.yacloud.vpc.addresses.button_create }}**.
  1. В открывшемся окне выберите [зону доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-a`. Нажмите кнопку **{{ ui-key.yacloud.vpc.addresses.popup-create_button_create }}**.

{% endlist %}

### Создайте группы безопасности {#create-security-groups}

[Группы безопасности](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) содержат правила, которые разрешают балансировщику получать входящий трафик и отправлять его на ВМ, а ВМ — получать этот трафик. В сценарии будут созданы две группы безопасности: для балансировщика и для всех ВМ.

Чтобы создать группы безопасности:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Откройте вкладку **{{ ui-key.yacloud.vpc.switch_security-groups }}**.
  1. Создайте группу безопасности для балансировщика:
      1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
      1. Укажите **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** группы безопасности: `mysite-sg-balancer`.
      1. Выберите **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** `mysite-network`.
      1. В блоке **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}** создайте следующие правила по инструкции под таблицей:
  
        Направление<br>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | Источник /<br>назначение | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
        --- | --- | --- | --- | --- | ---
        `Исходящий` | `any` | `Весь` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
        `Входящий` | `ext-http` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
        `Входящий` | `ext-https` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
        `Входящий` | `healthchecks` | `30080` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}` | —
  
        1. Выберите вкладку **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** или **{{ ui-key.yacloud.vpc.network.security-groups.label_ingress }}**.
        1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
        1. В открывшемся окне в поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** укажите один порт или диапазон портов, куда или откуда будет поступать трафик.
        1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** укажите нужный протокол или оставьте `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`, чтобы разрешить передачу трафика по всем протоколам.
        1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** или **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** выберите назначение правила:
            * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` — правило будет применено к диапазону IP-адресов. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** укажите CIDR и маски [подсетей](../../vpc/concepts/network.md#subnet), в которые или из которых будет поступать трафик. Чтобы добавить несколько CIDR, нажимайте кнопку **{{ ui-key.yacloud.vpc.network.security-groups.forms.button_add-cidr }}**.
            * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}` — правило будет применено к ВМ из текущей группы или из выбранной группы безопасности.
            * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}` — правило, которое позволяет балансировщику проверять состояние ВМ.
        1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**. Таким образом создайте все правила из таблицы.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
  1. Аналогично для ВМ создайте группу безопасности `mysite-sg-vms` и сетью `mysite-network` со следующими правилами:

      Направление<br>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | Источник /<br>назначение | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
      --- | --- | --- | --- | --- | ---
      `Входящий` | `balancer` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}` | `mysite-sg-balancer`
      `Входящий` | `ssh` | `22` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`

{% endlist %}

### Импортируйте TLS-сертификат сайта в {{ certificate-manager-name }} {#import-certificate}

Чтобы пользователи могли обращаться к сайту по защищенному протоколу HTTPS (HTTP over TLS), для него должен быть выпущен TLS-сертификат. Для использования в L7-балансировщике сертификат нужно импортировать в {{ certificate-manager-name }}.

Если у вашего сайта нет сертификата, вы можете [получить в {{ certificate-manager-name }} сертификат от Let's Encrypt®](../../certificate-manager/operations/managed/cert-create.md). В этом случае дополнительных действий после создания сертификата не потребуется: он — импортируется автоматически.

Чтобы импортировать уже имеющийся сертификат для сайта `my-site.com`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.certificate-manager.button_add }}** и выберите пункт **{{ ui-key.yacloud.certificate-manager.action_import }}**.
  1. Укажите **{{ ui-key.yacloud.certificate-manager.metadata.field_name }}** сертификата: `mysite-cert`.
  1. В поле **{{ ui-key.yacloud.certificate-manager.import.field_certificate }}** нажмите кнопку **{{ ui-key.yacloud.certificate-manager.import.button_add-certificate }}**. Загрузите **{{ ui-key.yacloud.component.file-content-dialog.field_file }}** с вашим сертификатом или укажите его **{{ ui-key.yacloud.component.file-content-dialog.field_content }}** и нажмите кнопку **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.
  1. Если ваш сертификат выпущен сторонним центром сертификации, в поле **{{ ui-key.yacloud.certificate-manager.import.field_chain }}** нажмите кнопку **{{ ui-key.yacloud.certificate-manager.import.button_add-chain }}**. Загрузите **{{ ui-key.yacloud.component.file-content-dialog.field_file }}** с цепочкой сертификатов или укажите его **{{ ui-key.yacloud.component.file-content-dialog.field_content }}** и нажмите кнопку **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.
  1. В поле **{{ ui-key.yacloud.certificate-manager.import.field_privateKey }}** нажмите кнопку **{{ ui-key.yacloud.certificate-manager.import.button_add-privateKey }}**. Загрузите **{{ ui-key.yacloud.component.file-content-dialog.field_file }}** с ключом или укажите его **{{ ui-key.yacloud.component.file-content-dialog.field_content }}** и нажмите кнопку **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Создайте группу ВМ для сайта {#create-ig}

Чтобы создать [группу ВМ](../../compute/concepts/instance-groups/index.md) для сайта `my-site.com`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Откройте вкладку **{{ ui-key.yacloud.compute.switch_groups }}**. Нажмите кнопку **{{ ui-key.yacloud.compute.groups.button_create }}**.
  1. Укажите имя группы ВМ: `mysite-ig`.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_allocation }}** выберите несколько зон доступности, чтобы обеспечить отказоустойчивость хостинга.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_instance }}** нажмите кнопку **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** откройте вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** и нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**. Выберите продукт [LEMP](/marketplace/products/yc/lemp) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
      * Выберите [платформу](../../compute/concepts/vm-platforms.md) ВМ.
      * Укажите необходимое количество vCPU и объем RAM.

      Для функционального тестирования сайта хватит минимальной конфигурации:
      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Cascade Lake`.
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `5%`.
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `2`.
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `1 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}** выберите **{{ ui-key.yacloud.compute.instances.create.field_instance-group-network }}** `mysite-network`, [созданную ранее](#create-network), и ее подсети.
  1. Выберите группу безопасности `mysite-sg-vms`, [созданную ранее](#create-security-groups).
  1. Укажите данные для доступа на ВМ:
      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.
      * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла открытого ключа.

        Пару ключей для подключения по [SSH](../../glossary/ssh-keygen.md) необходимо создать самостоятельно, см. [раздел о подключении к ВМ по SSH](../../compute/operations/vm-connect/ssh.md).

      {% note alert %}

      IP-адрес и [имя хоста (FQDN)](../../compute/concepts/network.md#hostname) для подключения к ВМ назначаются ей при создании. Если вы выбрали вариант **{{ ui-key.yacloud.compute.instances.create.value_address-none }}** в поле **{{ ui-key.yacloud.compute.instances.create.field_instance-group-address }}**, вы не сможете обращаться к ВМ из интернета.

      {% endnote %}

  1. Нажмите кнопку **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_scale }}** укажите **{{ ui-key.yacloud.compute.groups.create.field_scale-size }}** группы ВМ — 2.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_alb }}** выберите опцию **{{ ui-key.yacloud.compute.groups.create.field_target-group-attached }}** и укажите имя группы ВМ — `mysite-tg`. [Подробнее о целевых группах](../../application-load-balancer/concepts/target-group.md).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.


Создание группы ВМ может занять несколько минут. Дождитесь когда группа перейдет в [статус](../../compute/concepts/instance-groups/statuses.md#group-statuses) `RUNNING`, а все ВМ в ней — в [статус](../../compute/concepts/instance-groups/statuses.md#vm-statuses) `RUNNING_ACTUAL`.

Скопируйте публичные IP-адреса созданных ВМ: они будут указаны на странице ВМ в блоке **{{ ui-key.yacloud.compute.instance.overview.section_network }}**. IP-адреса потребуются далее, чтобы [проверить работу хостинга](#test).

{% endlist %}

### Создайте группу бэкендов {#create-backend-group}

Целевую группу, созданную вместе с группой ВМ, нужно привязать к группе бэкендов с настройками распределения трафика.

Для бэкендов в группе будут созданы [проверки состояния](../../application-load-balancer/concepts/backend-group.md#health-checks): балансировщик будет периодически отправлять проверочные запросы к ВМ и ожидать ответа в течение определенного периода.

Чтобы создать группу бэкендов для сайта `my-site.com`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Откройте вкладку **{{ ui-key.yacloud.alb.label_backend-groups }}**. Нажмите кнопку **{{ ui-key.yacloud.alb.button_backend-group-create }}**.
  1. Укажите **{{ ui-key.yacloud.common.name }}** группы бэкендов: `my-site-bg`.
  1. В блоке **{{ ui-key.yacloud.alb.label_backends }}** нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
  1. Укажите **{{ ui-key.yacloud.common.name }}** бэкенда: `mysite-backend`.
  1. В поле **{{ ui-key.yacloud.alb.label_target-groups }}** выберите группу `mysite-tg`.
  1. Укажите **{{ ui-key.yacloud.alb.label_port }}**, на котором ВМ бэкенда будут принимать входящий трафик от балансировщика: `80`.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_add-healthcheck }}**.
  1. Укажите **{{ ui-key.yacloud.alb.label_port }}**, на котором ВМ бэкенда будут принимать проверочные соединения: `80`.
  1. Укажите **{{ ui-key.yacloud.alb.label_path }}**, к которому будет обращаться балансировщик при проверке состояния: `/`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Создайте и настройте HTTP-роутер {#create-http-router}

Группу бэкендов нужно привязать к [HTTP-роутеру](../../application-load-balancer/concepts/http-router.md) с правилами маршрутизации.

Чтобы создать HTTP-роутер:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Откройте вкладку **{{ ui-key.yacloud.alb.label_http-routers }}**. Нажмите кнопку **{{ ui-key.yacloud.alb.button_http-router-create }}**.
  1. Укажите **{{ ui-key.yacloud.common.name }}** HTTP-роутера: `mysite-router`.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_virtual-host-add }}**.
  1. Укажите **{{ ui-key.yacloud.common.name }}** виртуального хоста: `mysite-host`.
  1. В поле **{{ ui-key.yacloud.alb.label_authority }}** укажите доменное имя сайта: `my-site.com`.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_add-route }}**.
  1. Укажите **{{ ui-key.yacloud.common.name }}** маршрута: `mysite-route`.
  1. В поле **{{ ui-key.yacloud.alb.label_backend-group }}** выберите группу `my-site-bg`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Создайте L7-балансировщик {#create-l7-balancer}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_load-balancer-create }}**.
  1. Укажите **{{ ui-key.yacloud.common.name }}** балансировщика: `mysite-alb`.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите группу безопасности `mysite-sg-balancer`, [созданную ранее](#create-security-groups).
  1. Создайте обработчик для перенаправления HTTP-запросов на HTTPS:
      1. В блоке **{{ ui-key.yacloud.alb.label_listeners }}** нажмите кнопку **{{ ui-key.yacloud.alb.button_add-listener }}**.
      1. Укажите **{{ ui-key.yacloud.common.name }}** обработчика: `listener-http`.
      1. В блоке **{{ ui-key.yacloud.alb.section_external-address-specs }}** выберите тип `{{ ui-key.yacloud.alb.label_address-list }}` и IP-адрес, [зарезервированный ранее](#reserve-ip).
      1. В поле **{{ ui-key.yacloud.alb.label_protocol-type }}** выберите пункт `{{ ui-key.yacloud.alb.label_redirect-to-https }}`.
  1. Создайте обработчик HTTPS-запросов:
      1. Снова нажмите кнопку **{{ ui-key.yacloud.alb.button_add-listener }}**.
      1. Укажите **{{ ui-key.yacloud.common.name }}** обработчика: `listener-https`.
      1. В блоке **{{ ui-key.yacloud.alb.section_external-address-specs }}** выберите тип `{{ ui-key.yacloud.alb.label_address-list }}` и IP-адрес, [зарезервированный ранее](#reserve-ip).
      1. В поле **{{ ui-key.yacloud.alb.label_protocol-type }}** выберите пункт `{{ ui-key.yacloud.alb.label_proto-http-tls }}`.
      1. В блоке **{{ ui-key.yacloud.alb.section_default-sni-match }}** выберите сертификат `mysite-cert` и HTTP-роутер `mysite-router`.
      1. Добавьте обработчик SNI для сайта `my-site.com`:
        1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_add-sni-match }}**.
        1. Укажите **{{ ui-key.yacloud.common.name }}** обработчика SNI: `mysite-sni`.
        1. В поле **{{ ui-key.yacloud.alb.label_server-names }}** укажите `my-site.com`.
        1. Выберите сертификат `mysite-cert` и HTTP-роутер `mysite-router`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Настройте DNS для сайта {#configure-dns}

Доменное имя `my-site.com` должно быть связано с IP-адресом L7-балансировщика с помощью [записей DNS](../../dns/concepts/resource-record.md). Чтобы это сделать:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Скопируйте IP-адрес созданного балансировщика.
  1. На сайте компании, которая предоставляет вам услуги DNS-хостинга, перейдите в настройки DNS.
  1. Создайте или измените [A-запись](../../dns/concepts/resource-record.md#a) для `my-site.com` таким образом, чтобы она указывала на скопированный IP-адрес:

      ```text
      my-site.com. A <IP-адрес_L7-балансировщика>
      ```

      Если вы пользуетесь [{{ dns-full-name }}](../../dns/), настройте запись по следующей инструкции:

      {% cut "Инструкция по настройке DNS-записей для {{ dns-name }}" %}

      Чтобы получить доступ к именам из публичной зоны, вам нужно делегировать домен. Укажите адреса серверов `ns1.{{ dns-ns-host-sld }}` и `ns2.{{ dns-ns-host-sld }}` в личном кабинете вашего регистратора.

      1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
      1. Если у вас нет публичной [зоны DNS](../../dns/concepts/dns-zone.md), создайте ее:
          1. Нажмите кнопку **{{ ui-key.yacloud.dns.button_zone-create }}**.
          1. Укажите **{{ ui-key.yacloud.common.name }}** зоны: `tls-termination-dns`.
          1. В поле **{{ ui-key.yacloud.dns.label_zone }}** укажите доменное имя сайта с точкой в конце: `my-site.com.`
          1. Выберите **{{ ui-key.yacloud.common.type }}** зоны — `{{ ui-key.yacloud.dns.label_public }}`.
          1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
      1. Создайте запись в зоне:
          1. В списке зон нажмите на зону `tls-termination-dns`.
          1. Нажмите кнопку **{{ ui-key.yacloud.dns.button_record-set-create }}**.
          1. Поле **{{ ui-key.yacloud.common.name }}** оставьте пустым, чтобы запись соответствовала доменному имени `my-site.com` (а не имени с субдоменом, например `www.my-site.com`).
          1. Выберите **{{ ui-key.yacloud.common.type }}** записи — **A**.
          1. В поле **{{ ui-key.yacloud.dns.label_records }}** вставьте скопированный IP-адрес балансировщика.
          1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

      {% endcut %}

{% endlist %}

После настройки DNS, [проверьте работу хостинга](#test).

## Проверьте работу хостинга {#test}

{% include [tls-termination-test](../_tutorials_includes/tls-termination-test.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Удалите](../../application-load-balancer/operations/application-load-balancer-delete.md) L7-балансировщик `mysite-alb`.
  1. [Удалите](../../application-load-balancer/operations/http-router-delete.md) HTTP-роутер `mysite-router`.
  1. [Удалите](../../application-load-balancer/operations/backend-group-delete.md) группу бэкендов `my-site-bg`.
  1. [Удалите](../../compute/operations/instance-groups/delete.md) группу ВМ `mysite-ig`.
  1. [Удалите](../../vpc/operations/address-delete.md) зарезервированный статический публичный IP-адрес.
  1. Если вы использовали {{ dns-name }}, то [удалите](../../dns/operations/resource-record-delete.md) DNS-записи и [удалите](../../dns/operations/zone-delete.md) DNS-зону.

{% endlist %}
