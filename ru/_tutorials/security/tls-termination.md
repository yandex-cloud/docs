# Терминирование TLS-соединений

[L7-балансировщики](../../application-load-balancer/concepts/application-load-balancer.md) [{{ alb-full-name }}](../../application-load-balancer/) могут _терминировать_ TLS-соединения: отправлять клиентам сертификаты, дешифровать входящий трафик для отправки [бэкендам](../../application-load-balancer/concepts/backend-group.md) и шифровать ответы бэкендов для отправки клиентам. Сценарий рассказывает, как настроить балансировщик, чтобы он терминировал TLS-соединения с помощью [сертификата](../../certificate-manager/concepts/index.md) из [{{ certificate-manager-full-name }}](../../certificate-manager/) и перенаправлял HTTP-запросы на HTTPS.

В качестве примера в сценарии используется доменное имя `my-site.com`.

Чтобы создать виртуальный хостинг:
1. [Подготовьте облако к работе](#before-begin).
1. [Создайте облачную сеть](#create-network).
1. [Зарезервируйте статический публичный IP-адрес](#reserve-ip).
1. [Создайте группы безопасности](#create-security-groups).
1. [Импортируйте TLS-сертификат сайта в {{ certificate-manager-name }}](#import-certificate).
1. [Создайте группу виртуальных машин для сайта](#create-ig).
1. [Загрузите файлы сайта на ВМ](#upload-site-files).
1. [Создайте группу бэкендов](#create-backend-group).
1. [Создайте и настройте HTTP-роутер](#create-http-router).
1. [Создайте L7-балансировщик](#create-l7-balancer).
1. [Настройте DNS для сайта](#configure-dns).
1. [Проверьте работу хостинга](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

Также инфраструктуру для виртуального хостинга можно развернуть через {{ TF }} с помощью [готового файла конфигурации](#terraform).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки виртуального хостинга входят:
* Плата за постоянно запущенные [ВМ](../../compute/concepts/vm.md) (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за использование [публичного статического IP-адреса](../../vpc/concepts/address.md#public-addresses) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).

## Создайте облачную сеть {#create-network}

Все ресурсы, созданные в сценарии, будут относиться к одной [облачной сети](../../vpc/concepts/network.md).

Чтобы создать сеть:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. Укажите **{{ ui-key.yacloud.vpc.networks.create.field_name }}** сети: `mysite-network`.
  1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** выберите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

- {{ TF }}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

{% endlist %}

## Зарезервируйте статический публичный IP-адрес {#reserve-ip}

Для работы виртуального хостинга потребуется статический публичный IP-адрес, который будет назначен L7-балансировщику.

Чтобы зарезервировать IP-адрес:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Откройте вкладку **{{ ui-key.yacloud.vpc.switch_addresses }}**. Нажмите кнопку **{{ ui-key.yacloud.vpc.addresses.button_create }}**.
  1. В открывшемся окне выберите [зону доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-a`. Нажмите кнопку **{{ ui-key.yacloud.vpc.addresses.popup-create_button_create }}**.

- {{ TF }}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

{% endlist %}

## Создайте группы безопасности {#create-security-groups}

[Группы безопасности](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) содержат правила, которые разрешают балансировщику получать входящий трафик и отправлять его на ВМ, а ВМ — получать этот трафик. В сценарии будут созданы две группы безопасности: для балансировщика и для всех ВМ.

Чтобы создать группы безопасности:

{% list tabs %}

- Консоль управления 

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
      
     | Направление<br/>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | Источник /<br/>назначение | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
     | --- | --- | --- | --- | --- | --- |
     | `Входящий` | `balancer` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}` | `mysite-sg-balancer` |
     | `Входящий` | `ssh` | `22` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |

- {{ TF }}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).
  
{% endlist %}

## Импортируйте TLS-сертификат сайта в {{ certificate-manager-name }} {#import-certificate}

Чтобы пользователи могли обращаться к сайту по защищенному протоколу HTTPS (HTTP over TLS), для него должен быть выпущен TLS-сертификат. Для использования в L7-балансировщике сертификат нужно импортировать в {{ certificate-manager-name }}.

Если у вашего сайта нет сертификата, вы можете [получить в {{ certificate-manager-name }} сертификат от Let's Encrypt®](../../certificate-manager/operations/managed/cert-create.md). В этом случае дополнительных действий после создания сертификата не потребуется: он — импортируется автоматически.

Чтобы импортировать уже имеющийся сертификат для сайта `my-site.com`:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.certificate-manager.button_add }}** и выберите пункт **{{ ui-key.yacloud.certificate-manager.action_import }}**.
  1. Укажите **{{ ui-key.yacloud.certificate-manager.metadata.field_name }}** сертификата: `mysite-cert`.
  1. В поле **{{ ui-key.yacloud.certificate-manager.import.field_certificate }}** нажмите кнопку **{{ ui-key.yacloud.certificate-manager.import.button_add-certificate }}**. Загрузите **{{ ui-key.yacloud.component.file-content-dialog.field_file }}** с вашим сертификатом или укажите его **{{ ui-key.yacloud.component.file-content-dialog.field_content }}** и нажмите кнопку **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.
  1. Если ваш сертификат выпущен сторонним центром сертификации, в поле **{{ ui-key.yacloud.certificate-manager.import.field_chain }}** нажмите кнопку **{{ ui-key.yacloud.certificate-manager.import.button_add-chain }}**. Загрузите **{{ ui-key.yacloud.component.file-content-dialog.field_file }}** с цепочкой сертификатов или укажите его **{{ ui-key.yacloud.component.file-content-dialog.field_content }}** и нажмите кнопку **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.
  1. В поле **{{ ui-key.yacloud.certificate-manager.import.field_privateKey }}** нажмите кнопку **{{ ui-key.yacloud.certificate-manager.import.button_add-privateKey }}**. Загрузите **{{ ui-key.yacloud.component.file-content-dialog.field_file }}** с ключом или укажите его **{{ ui-key.yacloud.component.file-content-dialog.field_content }}** и нажмите кнопку **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- {{ TF }}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

{% endlist %}

## Создайте группу ВМ для сайта {#create-ig}

Чтобы создать [группу ВМ](../../compute/concepts/instance-groups/index.md) для сайта `my-site.com`:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Откройте вкладку **{{ ui-key.yacloud.compute.switch_groups }}**. Нажмите кнопку **{{ ui-key.yacloud.compute.groups.button_create }}**.
  1. Укажите имя группы ВМ: `mysite-ig`.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_allocation }}** выберите несколько зон доступности, чтобы обеспечить отказоустойчивость хостинга.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_instance }}** нажмите кнопку **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** откройте вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** и нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.image_button_show-all-products }}**. Выберите продукт [LEMP](/marketplace/products/yc/lemp) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
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

- {{ TF }}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

{% endlist %}

Создание группы ВМ может занять несколько минут. Когда группа перейдет в [статус](../../compute/concepts/instance-groups/statuses.md#group-statuses) `RUNNING`, а все ВМ в ней — в [статус](../../compute/concepts/instance-groups/statuses.md#vm-statuses) `RUNNING_ACTUAL`, вы можете [загрузить на них файлы веб-сайта](#upload-site-files).

## Загрузите файлы сайта на ВМ {#upload-site-files}

Чтобы проверить работу веб-серверов, загрузите на ВМ файлы `index.html`.

{% cut "Пример файла index.html" %}

```html
<!DOCTYPE html>
<html>
  <head>
    <title>My site</title>
  </head>
  <body>
    <h1>This is my site</h1>
  </body>
</html>
```

{% endcut %}

Чтобы загрузить файл на ВМ:

{% include [upload-files](../_common/upload-web-site-files.md) %}

## Создайте группу бэкендов {#create-backend-group}

Целевую группу, созданную вместе с группой ВМ, нужно привязать к группе бэкендов с настройками распределения трафика.

Для бэкендов в группе будут созданы [проверки состояния](../../application-load-balancer/concepts/backend-group.md#health-checks): балансировщик будет периодически отправлять проверочные запросы к ВМ и ожидать ответа в течение определенного периода.

Чтобы создать группу бэкендов для сайта `my-site.com`:

{% list tabs %}

- Консоль управления

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

- {{ TF }}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

{% endlist %}

## Создайте и настройте HTTP-роутер {#create-http-router}

Группу бэкендов нужно привязать к [HTTP-роутеру](../../application-load-balancer/concepts/http-router.md) с правилами маршрутизации.

Чтобы создать HTTP-роутер:

{% list tabs %}

- Консоль управления 

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

- {{ TF }}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

{% endlist %}

## Создайте L7-балансировщик {#create-l7-balancer}

{% list tabs %}

- Консоль управления

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

- {{ TF }}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

{% endlist %}

## Настройте DNS для сайта {#configure-dns}

Доменное имя `my-site.com` должно быть связано с IP-адресом L7-балансировщика с помощью записей DNS. Чтобы это сделать:

1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
1. Скопируйте IP-адрес созданного балансировщика.
1. На сайте компании, которая предоставляет вам услуги DNS-хостинга, перейдите в настройки DNS.
1. Создайте или измените A-запись для `my-site.com` таким образом, чтобы она указывала на скопированный IP-адрес:

   ```text
   my-site.com. A <IP-адрес_L7-балансировщика>
   ```

   Если вы пользуетесь {{ dns-full-name }}, настройте запись по следующей инструкции:

   {% cut "Инструкция по настройке DNS-записей для {{ dns-name }}" %}

   {% list tabs %}

   - Консоль управления

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

   - {{ TF }}

     См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

   {% endlist %}

   {% endcut %}

## Проверьте работу хостинга {#test}

Чтобы проверить работу хостинга, в браузере откройте сайт по адресу `http://my-site.com` — должно произойти перенаправление на страницу `https://my-site.com`, где уже подключен TLS-сертификат из {{ certificate-manager-name }}.

## Удалите созданные ресурсы {#clear-out}

Чтобы остановить работу хостинга и перестать платить за созданные ресурсы:

1. Удалите нетарифицируемые ресурсы, которые блокируют удаление тарифицируемых ресурсов:
   
   1. [Удалите](../../application-load-balancer/operations/application-load-balancer-delete.md) L7-балансировщик `mysite-alb`.
   1. [Удалите](../../application-load-balancer/operations/http-router-delete.md) HTTP-роутер `mysite-router`.
   1. [Удалите](../../application-load-balancer/operations/backend-group-delete.md) группу бэкендов `my-site-bg`.
   
1. [Удалите](../../compute/operations/instance-groups/delete.md) группу виртуальных машин `mysite-ig`.
1. [Удалите](../../vpc/operations/address-delete.md) зарезервированный статический публичный адрес.

## Как создать инфраструктуру с помощью {{ TF }} {#terraform}

{% include [terraform-definition](../terraform-definition.md) %}

Чтобы создать инфраструктуру для терминирования TLS-соединений с помощью {{ TF }}:

1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).

1. Подготовьте файлы с описанием инфраструктуры:

    {% list tabs %}

    - Готовая конфигурация

      1. Клонируйте репозиторий с конфигурационными файлами.

          ```bash
          git clone https://github.com/yandex-cloud-examples/yc-alb-tls-termination.git
          ```

      1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
          
          * `tls-termination-config.tf` — конфигурация создаваемой инфраструктуры;
          * `tls-terminationg.auto.tfvars` — файл с пользовательскими данными.

    - Создание вручную
      
      1. Создайте папку для конфигурационных файлов.
      
      1. Создайте в папке:
          
          1. Конфигурационный файл `tls-termination-config.tf`:

              {% cut "tls-termination-config.tf" %}
              
              {% include [tls-termination-config](../../_includes/application-load-balancer/tls-termination-config.md) %}
              
              {% endcut %}
          
          1. Файл с пользовательскими данными `tls-termination.auto.tfvars`:
              
              {% cut "tls-termination.auto.tfvars" %}
             
              ```hcl
              folder_id    = "<идентификатор_каталога>"
              vm_user      = "<имя_пользователя_ВМ>"
              ssh_key_path = "<путь_к_публичному_SSH-ключу>"
              domain       = "<домен>"
              certificate  = "<путь_к_файлу_с_сертификатом>"
              private_key  = "<путь_к_файлу_с_закрытым_ключом>"
              ```

              {% endcut %}
    
    {% endlist %}
    
    Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:
    
    * [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network)
    * [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet)
    * [yandex_vpc_address]({{ tf-provider-resources-link }}/vpc_address)
    * [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group)
    * [yandex_cm_certificate]({{ tf-provider-resources-link }}/cm_certificate)
    * [yandex_compute_image]({{ tf-provider-resources-link }}/compute_image)
    * [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account)
    * [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member)
    * [yandex_compute_instance_group]({{ tf-provider-resources-link }}/compute_instance_group)
    * [yandex_alb_backend_group]({{ tf-provider-resources-link }}/alb_backend_group)
    * [yandex_alb_http_router]({{ tf-provider-resources-link }}/alb_http_router)
    * [yandex_alb_load_balancer]({{ tf-provider-resources-link }}/alb_load_balancer)
    * [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone)
    * [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset)

1. В файле `tls-termination.auto.tfvars` задайте пользовательские параметры:
    
    * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
    * `vm_user` — имя пользователя ВМ.
    * `ssh_key_path` — путь к файлу с публичным SSH-ключом. Подробнее см. [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
    * `domain` — домен, на котором будет размещен сайт.
    * `certificate` — путь к файлу с [пользовательским сертификатом](../../certificate-manager/operations/import/cert-create.md#create-file).
    * `private_key` — путь к файлу с закрытым ключом пользовательского сертификата.

1. Создайте ресурсы:
    
    {% include [terraform-validate-plan-apply](../terraform-validate-plan-apply.md) %}

1. [Загрузите файлы сайта на ВМ](#upload-site-files).
1. [Проверьте работу хостинга](#test).
