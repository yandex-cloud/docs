---
title: "Виртуальный хостинг — инструкция по созданию"
description: "Из данной инструкции вы узнаете, как организовать виртуальный хостинг с размещением нескольких веб-сайтов и разными доменными именами по одному IP-адресу."
---

# Организация виртуального хостинга


Сценарий описывает организацию виртуального хостинга — размещение нескольких веб-сайтов с разными доменными именами по одному [IP-адресу](../../vpc/concepts/address.md) — с помощью [{{ alb-full-name }}](../../application-load-balancer/).

В качестве примеров в сценарии будут использоваться три доменных имени: `site-a.com`, `site-b.com` и `default.com`.

Чтобы создать виртуальный хостинг:
1. [Подготовьте облако к работе](#before-begin).
1. [Создайте облачную сеть](#create-network).
1. [Зарезервируйте статический публичный IP-адрес](#reserve-ip).
1. [Создайте группы безопасности](#create-security-groups).
1. [Импортируйте TLS-сертификаты сайтов в {{ certificate-manager-full-name }}](#import-certificates).
1. [Создайте группы виртуальных машин для сайтов](#create-vms).
1. [Загрузите файлы сайтов на ВМ](#upload-sites-files).
1. [Создайте группы бэкендов](#create-backend-groups).
1. [Создайте и настройте HTTP-роутеры](#create-http-routers).
1. [Создайте L7-балансировщик](#create-l7-balancer).
1. [Настройте DNS для сайтов](#configure-dns).
1. [Проверьте работу хостинга](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки виртуального хостинга входят:
* Плата за постоянно запущенные [ВМ](../../compute/concepts/vm.md) (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за использование [публичного статического IP-адреса](../../vpc/concepts/address.md#public-addresses) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).
* Плата за использование вычислительных ресурсов [L7-балансировщика](../../application-load-balancer/concepts/index.md) (см. [тарифы {{ alb-name }}](../../application-load-balancer/pricing.md)).
* Плата за публичные [DNS-запросы](../../glossary/dns.md) и [зоны DNS](../../dns/concepts/dns-zone.md), если вы используете [{{ dns-full-name }}](../../dns/) (см. [тарифы {{ dns-name }}](../../dns/pricing.md)).
  
## Создайте облачную сеть {#create-network}

Все ресурсы, созданные в сценарии, будут относиться к одной [облачной сети](../../vpc/concepts/network.md).

Чтобы создать сеть:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. Укажите **{{ ui-key.yacloud.vpc.networks.create.field_name }}** сети: `vhosting-network`.
  1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** выберите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.networks.button_create }}**.

{% endlist %}

## Зарезервируйте статический публичный IP-адрес {#reserve-ip}

Для работы виртуального хостинга потребуется статический публичный IP-адрес, который будет назначен [L7-балансировщику](../../application-load-balancer/concepts/application-load-balancer.md).

Чтобы зарезервировать IP-адрес:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/map-pin.svg) **{{ ui-key.yacloud.vpc.switch_addresses }}**. Нажмите кнопку **{{ ui-key.yacloud.vpc.addresses.button_create }}**.
  1. В открывшемся окне выберите [зону доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-a`. Нажмите кнопку **{{ ui-key.yacloud.vpc.addresses.popup-create_button_create }}**.

{% endlist %}

## Создайте группы безопасности {#create-security-groups}

[Группы безопасности](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) содержат правила, которые разрешают балансировщику получать входящий трафик и отправлять его на ВМ, а ВМ — получать этот трафик. В сценарии будут созданы две группы безопасности: для балансировщика и для всех ВМ.

Чтобы создать группы безопасности:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.switch_security-groups }}**.
  1. Создайте группу безопасности для балансировщика:
     1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
     1. Укажите **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** группы: `vhosting-sg-balancer`.
     1. Выберите **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** `vhosting-network`.
     1. В блоке **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}** создайте следующие правила по инструкции под таблицей:

        | Направление<br/>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | Источник /<br/>назначение | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
        | --- | --- | --- | --- | --- | --- |
        | `Исходящий` | `any` | `Весь` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
        | `Входящий` | `ext-http` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
        | `Входящий` | `ext-https` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
        | `Входящий` | `healthchecks` | `30080` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}` | — |

     1. Выберите вкладку **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** или **{{ ui-key.yacloud.vpc.network.security-groups.label_ingress }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
     1. В открывшемся окне в поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** укажите один порт или диапазон портов, куда или откуда будет поступать трафик.
     1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** укажите нужный протокол или оставьте `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`, чтобы разрешить передачу трафика по всем протоколам.
     1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** или **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** выберите назначение правила:
        * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` — правило будет применено к диапазону IP-адресов. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** укажите CIDR и маски подсетей, в которые или из которых будет поступать трафик. Чтобы добавить несколько CIDR, нажимайте кнопку **{{ ui-key.yacloud.vpc.subnetworks.create.button_add-cidr }}**.
        * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}` — правило будет применено к ВМ из текущей группы или из выбранной группы безопасности.
        * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}` — правило, которое позволяет балансировщику проверять состояние ВМ.
     1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**. Таким образом создайте все правила из таблицы.
     1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
  1. Аналогично создайте группу безопасности для ВМ с именем `vhosting-sg-vms`, той же сетью `vhosting-network` и следующими правилами:

     | Направление<br/>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | Источник | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
     | --- | --- | --- | --- | --- | --- |
     | `Входящий` | `balancer` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}` | `vhosting-sg-balancer` |
     | `Входящий` | `ssh` | `22` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |

{% endlist %}

## Импортируйте TLS-сертификаты сайтов в {{ certificate-manager-name }} {#import-certificates}

Чтобы пользователи могли обращаться к сайтам по защищенному протоколу HTTPS (HTTP over TLS), для них должны быть выпущены [TLS-сертификаты](../../certificate-manager/concepts/managed-certificate.md). Для использования в L7-балансировщике сертификаты нужно импортировать в {{ certificate-manager-name }}.

Если у ваших сайтов нет сертификатов, вы можете [получить в {{ certificate-manager-name }} сертификаты от Let's Encrypt<sup>®</sup>](../../certificate-manager/operations/managed/cert-create.md). В этом случае дополнительных действий после создания сертификатов не требуется: они импортируются автоматически.

Чтобы импортировать уже имеющийся сертификат для сайта `site-a.com`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.certificate-manager.button_empty-action }}** и выберите пункт **{{ ui-key.yacloud.certificate-manager.action_import }}**.
  1. Укажите **{{ ui-key.yacloud.certificate-manager.metadata.field_name }}** сертификата: `vhosting-cert-a`.
  1. В поле **{{ ui-key.yacloud.certificate-manager.import.field_certificate }}** нажмите кнопку **{{ ui-key.yacloud.certificate-manager.import.button_add-certificate }}**. Загрузите **{{ ui-key.yacloud.component.file-content-dialog.field_file }}** с вашим сертификатом или укажите его **{{ ui-key.yacloud.component.file-content-dialog.field_content }}** и нажмите кнопку **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.
  1. Если ваш сертификат выпущен сторонним центром сертификации, в поле **{{ ui-key.yacloud.certificate-manager.import.field_chain }}** нажмите кнопку **{{ ui-key.yacloud.certificate-manager.import.button_add-chain }}**. Загрузите **{{ ui-key.yacloud.component.file-content-dialog.field_file }}** с цепочкой сертификатов или укажите его **{{ ui-key.yacloud.component.file-content-dialog.field_content }}** и нажмите кнопку **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.
  1. В поле **{{ ui-key.yacloud.certificate-manager.import.field_privateKey }}** нажмите кнопку **{{ ui-key.yacloud.certificate-manager.import.button_add-privateKey }}**. Загрузите **{{ ui-key.yacloud.component.file-content-dialog.field_file }}** с ключом или укажите его **{{ ui-key.yacloud.component.file-content-dialog.field_content }}** и нажмите кнопку **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

Аналогично импортируйте сертификаты для сайтов `site-b.com` и `default.com` с именами `vhosting-cert-b` и `vhosting-cert-default`.

## Создайте группы ВМ для сайтов {#create-vms}

В качестве веб-серверов для двух сайтов будут выступать ВМ {{ compute-name }} — по одной [группе](../../compute/concepts/instance-groups/index.md) из нескольких одинаковых ВМ на каждый сайт. В этом сценарии серверы будут реализованы на LEMP-стеке (Linux, nginx, {{ MY }}, PHP; подробнее см. в сценарии использования [Веб-сайт на LAMP- или LEMP-стеке](../../tutorials/web/lamp-lemp/index.md)).

Чтобы создать группу ВМ для сайта `site-a.com`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**. Нажмите кнопку **{{ ui-key.yacloud.compute.groups.button_create }}**.
  1. Укажите имя группы ВМ: `vhosting-ig-a`.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_allocation }}** выберите несколько зон доступности, чтобы обеспечить отказоустойчивость хостинга.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_instance }}** нажмите кнопку **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** откройте вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** и нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**. Выберите продукт [LEMP](/marketplace/products/yc/lemp) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
     * Выберите [платформу](../../compute/concepts/vm-platforms.md) ВМ.
     * Укажите необходимое количество vCPU и объем RAM.

     Для функционального тестирования сайта хватит минимальной конфигурации:
     * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Ice Lake`.
     * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `20%`.
     * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `2`.
     * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `1 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}** выберите **{{ ui-key.yacloud.compute.instances.create.field_instance-group-network }}** `vhosting-network`, [созданную ранее](#create-network), и ее [подсети](../../vpc/concepts/network.md#subnet).
  1. В поле **{{ ui-key.yacloud.compute.instances.create.field_instance-group-address }}** выберите `{{ ui-key.yacloud.compute.instances.create.value_address-auto }}`.
  1. Выберите группу безопасности `vhosting-sg-vms`, [созданную ранее](#create-security-groups).
  1. Укажите данные для доступа на ВМ:
     * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.
     * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла открытого ключа.

       Пару ключей для подключения по [SSH](../../glossary/ssh-keygen.md) необходимо создать самостоятельно, см. [раздел о подключении к ВМ по SSH](../../compute/operations/vm-connect/ssh.md).

     {% note alert %}

     IP-адрес и [имя хоста (FQDN)](../../compute/concepts/network.md#hostname) для подключения к ВМ назначатся ей при создании. Если вы выбрали вариант `{{ ui-key.yacloud.compute.instances.create.value_address-none }}` в поле **{{ ui-key.yacloud.compute.instances.create.field_instance-group-address }}**, вы не сможете обращаться к ВМ из интернета.

     {% endnote %}

  1. Нажмите кнопку **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_scale }}** укажите **{{ ui-key.yacloud.compute.groups.create.field_scale-size }}** группы ВМ — `2`.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_alb }}** выберите опцию **{{ ui-key.yacloud.compute.groups.create.field_target-group-attached }}** и укажите имя группы — `vhosting-tg-a`. [Подробнее о целевых группах](../../application-load-balancer/concepts/target-group.md).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

Аналогично создайте для сайта `site-b.com` вторую группу ВМ с именем `vhosting-ig-b` и целевую группу с именем `vhosting-tg-b`.

Создание группы ВМ может занять несколько минут. Когда группа перейдет в [статус](../../compute/concepts/instance-groups/statuses.md#group-statuses) `RUNNING`, а все ВМ в ней — в [статус](../../compute/concepts/instance-groups/statuses.md#vm-statuses) `RUNNING_ACTUAL`, вы можете [загрузить на них файлы веб-сайта](#upload-sites-files).

![ig-running](../../_assets/application-load-balancer/tutorials/virtual-hosting/ig-running.png)

## Загрузите файлы сайтов на ВМ {#upload-sites-files}

Чтобы проверить работу веб-серверов, загрузите на ВМ файлы `index.html`: на ВМ из группы `vhosting-ig-a` — с одним содержанием, а на ВМ из группы `vhosting-ig-b` — с другим.

{% cut "Пример файла index.html для группы vhosting-ig-a" %}

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Site A</title>
  </head>
  <body>
    <p>This is site A</p>
  </body>
</html>
```

{% endcut %}

{% cut "Пример файла index.html для группы vhosting-ig-b" %}

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Site B</title>
  </head>
  <body>
    <p>This is site B</p>
  </body>
</html>
```

{% endcut %}

Чтобы загрузить файл на ВМ:

{% include [upload-files](../_tutorials_includes/upload-web-site-files.md) %}

Повторите этот процесс с нужными файлами для каждой ВМ из групп `vhosting-ig-a` и `vhosting-ig-b`.

## Создайте группы бэкендов {#create-backend-groups}

Целевые группы, созданные вместе с группами ВМ, нужно привязать к [группам бэкендов](../../application-load-balancer/concepts/backend-group.md) с настройками распределения трафика.

Для бэкендов в группах будут созданы [проверки состояния](../../application-load-balancer/concepts/backend-group.md#health-checks): балансировщик будет периодически отправлять проверочные запросы к ВМ и ожидать ответа в течение определенного периода.

Чтобы создать группу бэкендов для сайта `site-a.com`:
1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.alb.label_backend-groups }}**. Нажмите кнопку **{{ ui-key.yacloud.alb.button_backend-group-create }}**.
1. Укажите **{{ ui-key.yacloud.common.name }}** группы бэкендов: `vhosting-bg-a`.
1. В блоке **{{ ui-key.yacloud.alb.label_backends }}** нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
1. Укажите **{{ ui-key.yacloud.common.name }}** бэкенда: `vhosting-backend-a`.
1. В поле **{{ ui-key.yacloud.alb.label_target-groups }}** выберите группу `vhosting-tg-a`.
1. Укажите **{{ ui-key.yacloud.alb.label_port }}**, на котором ВМ бэкенда будут принимать входящий трафик от балансировщика: `80`.
1. Нажмите кнопку **Добавить проверку состояния**.
1. Укажите **{{ ui-key.yacloud.alb.label_port }}**, на котором ВМ бэкенда будут принимать проверочные соединения: `80`.
1. Укажите **{{ ui-key.yacloud.alb.label_path }}**, к которому будет обращаться балансировщик при проверке состояния: `/`.
1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

Аналогично создайте для сайта `site-b.com` вторую группу бэкендов `vhosting-bg-b`, в ней — бэкенд `vhosting-backend-b` и привяжите к нему целевую группу `vhosting-tg-b`.

## Создайте и настройте HTTP-роутеры {#create-http-routers}

Группы бэкендов нужно привязать к [HTTP-роутерам](../../application-load-balancer/concepts/http-router.md) с правилами маршрутизации HTTP-запросов. В сценарии будут созданы два роутера для «основных» сайтов `site-a.com` и `site-b.com` и роутер «по умолчанию» для сайта `default.com`, который будет отвечать на каждый запрос HTTP-кодом состояния `404 Not Found`.

### Создайте HTTP-роутеры для сайтов {#create-http-routers-sites}

Чтобы создать HTTP-роутер для сайта `site-a.com`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}**. Нажмите кнопку **{{ ui-key.yacloud.alb.button_http-router-create }}**.
  1. Укажите **{{ ui-key.yacloud.common.name }}** HTTP-роутера: `vhosting-router-a`.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_virtual-host-add }}**.
  1. Укажите **{{ ui-key.yacloud.common.name }}** виртуального хоста: `vhosting-host-a`.
  1. В поле **{{ ui-key.yacloud.alb.label_authority }}** укажите доменное имя сайта: `site-a.com`.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_add-route }}**.
  1. Укажите **{{ ui-key.yacloud.common.name }}** маршрута: `vhosting-route-a`.
  1. В поле **{{ ui-key.yacloud.alb.label_backend-group }}** выберите группу `vhosting-bg-a`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

Аналогично создайте для сайта `site-b.com` HTTP-роутер `vhosting-router-b` и привяжите к нему группу бэкендов `vhosting-bg-b`.

### Создайте HTTP-роутер «по умолчанию» {#create-http-routers-default}

Чтобы создать HTTP-роутер для сайта `default.com`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}**. Нажмите кнопку **{{ ui-key.yacloud.alb.button_http-router-create }}**.
  1. Укажите **{{ ui-key.yacloud.common.name }}** HTTP-роутера: `vhosting-router-default`.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_virtual-host-add }}**.
  1. Укажите **{{ ui-key.yacloud.common.name }}** виртуального хоста: `vhosting-host-default`.
  1. В поле **{{ ui-key.yacloud.alb.label_authority }}** укажите доменное имя сайта: `default.com`.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_add-route }}**.
  1. Укажите **{{ ui-key.yacloud.common.name }}** маршрута: `vhosting-route-a`.
  1. В поле **{{ ui-key.yacloud.alb.label_route-action }}** выберите `{{ ui-key.yacloud.alb.label_route-action-statusResponse }}`.
  1. В поле **{{ ui-key.yacloud.alb.label_http-status-code }}** выберите `404 Not Found`.
  1. В поле **{{ ui-key.yacloud.alb.label_body }}** нажмите кнопку **{{ ui-key.yacloud.alb.button_select }}**. Выберите способ `{{ ui-key.yacloud.component.file-content-dialog.value_manual }}` и в поле **{{ ui-key.yacloud.component.file-content-dialog.field_content }}** укажите:

     ```text
     404 Not Found

     This is the default site.
     ```

     Нажмите кнопку **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Создайте L7-балансировщик {#create-l7-balancer}

Чтобы создать балансировщик:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_load-balancer-create }}**.
  1. Укажите **{{ ui-key.yacloud.common.name }}** балансировщика: `vhosting-alb`.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите группу безопасности `vhosting-sg-balancer`, [созданную ранее](#create-security-groups).
  1. Создайте обработчик для перенаправления HTTP-запросов на HTTPS:
     1. В блоке **{{ ui-key.yacloud.alb.label_listeners }}** нажмите кнопку **{{ ui-key.yacloud.alb.button_add-listener }}**.
     1. Укажите **{{ ui-key.yacloud.common.name }}** обработчика: `vhosting-listener-http`.
     1. В блоке **{{ ui-key.yacloud.alb.section_external-address-specs }}** выберите тип `{{ ui-key.yacloud.alb.label_address-list }}` и IP-адрес, [зарезервированный ранее](#reserve-ip).
     1. В поле **{{ ui-key.yacloud.alb.label_protocol-type }}** выберите пункт `{{ ui-key.yacloud.alb.label_redirect-to-https }}`.
  1. Создайте обработчик HTTPS-запросов:
     1. Снова нажмите кнопку **{{ ui-key.yacloud.alb.button_add-listener }}**.
     1. Укажите **{{ ui-key.yacloud.common.name }}** обработчика: `vhosting-listener-https`.
     1. В блоке **{{ ui-key.yacloud.alb.section_external-address-specs }}** выберите тип `{{ ui-key.yacloud.alb.label_address-list }}` и IP-адрес, [зарезервированный ранее](#reserve-ip).
     1. В поле **{{ ui-key.yacloud.alb.label_protocol-type }}** выберите пункт `{{ ui-key.yacloud.alb.label_proto-http-tls }}`.
     1. В блоке **{{ ui-key.yacloud.alb.section_default-sni-match }}** выберите сертификат `vhosting-cert-default` и HTTP-роутер `vhosting-router-default`.
     1. Добавьте обработчик SNI для сайта `site-a.com`:
        1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_add-sni-match }}**.
        1. Укажите **{{ ui-key.yacloud.common.name }}** обработчика SNI: `vhosting-sni-a`.
        1. В поле **{{ ui-key.yacloud.alb.label_server-names }}** укажите `site-a.com`.
        1. Выберите сертификат `vhosting-cert-a` и HTTP-роутер `vhosting-router-a`.
     1. Аналогично добавьте обработчик SNI для сайта `site-b.com` — с именем `vhosting-sni-b`, именем сервера `site-b.com`, сертификатом `vhosting-cert-b` и HTTP-роутером `vhosting-router-b`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Настройте DNS для сайтов {#configure-dns}

Доменные имена `site-a.com`, `site-b.com` и `default.com` должны быть связаны с IP-адресом L7-балансировщика с помощью записей DNS.

Чтобы настроить DNS для сайта `site-a.com`:
1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
1. Скопируйте IP-адрес созданного балансировщика.
1. На сайте компании, которая предоставляет вам услуги DNS-хостинга, перейдите в настройки DNS.
1. Создайте или измените A-запись для `site-a.com` таким образом, чтобы она указывала на скопированный IP-адрес:

   ```text
   site-a.com. A <IP-адрес_L7-балансировщика>
   ```

   Если вы пользуетесь {{ dns-full-name }}, настройте запись по следующей инструкции:

   {% cut "Инструкция по настройке DNS-записей для {{ dns-name }}" %}

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
     1. Если у вас нет публичной [зоны DNS](../../dns/concepts/dns-zone.md), создайте ее:
        1. Нажмите кнопку **{{ ui-key.yacloud.dns.button_zone-create }}**.
        1. Укажите **{{ ui-key.yacloud.common.name }}** зоны: `vhosting-dns-a`.
        1. В поле **{{ ui-key.yacloud.dns.label_zone }}** укажите доменное имя сайта с точкой в конце: `site-a.com.`
        1. Выберите **{{ ui-key.yacloud.common.type }}** зоны — `{{ ui-key.yacloud.dns.label_public }}`.
        1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
     1. Создайте запись в зоне:
        1. В списке зон нажмите на зону `vhosting-dns-a`.
        1. Нажмите кнопку **{{ ui-key.yacloud.dns.button_record-set-create }}**.
        1. Поле **{{ ui-key.yacloud.common.name }}** оставьте пустым, чтобы запись соответствовала доменному имени `site-a.com` (а не имени с субдоменом, например `www.site-a.com`).
        1. Выберите **{{ ui-key.yacloud.common.type }}** записи — **A**.
        1. В поле **{{ ui-key.yacloud.dns.label_records }}** вставьте скопированный IP-адрес балансировщика.
        1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

   {% endlist %}

   {% endcut %}

Аналогично настройте DNS для сайтов `site-b.com` и `default.com`, используя тот же IP-адрес.

Через 15–20 минут после настройки DNS вы сможете проверить работу сайтов.

## Проверьте работу хостинга {#test}

Чтобы проверить работу хостинга, откройте каждый из трех сайтов в браузере:
* `https://site-a.com` и `https://site-b.com` — должны отобразиться страницы, [загруженные на ВМ](#upload-sites-files).
* `https://default.com` — должна отобразиться страница с ошибкой `404 Not Found`, настроенная при [создании HTTP-роутера](#create-http-routers-default).

## Удалите созданные ресурсы {#clear-out}

Чтобы остановить работу хостинга и перестать платить за созданные ресурсы:
1. Удалите нетарифицируемые ресурсы, которые блокируют удаление тарифицируемых ресурсов:
   1. [Удалите](../../application-load-balancer/operations/application-load-balancer-delete.md) L7-балансировщик `vhosting-alb`.
   1. [Удалите](../../application-load-balancer/operations/http-router-delete.md) HTTP-роутеры `vhosting-router-a`, `vhosting-router-b` и `vhosting-router-default`.
   1. [Удалите](../../application-load-balancer/operations/backend-group-delete.md) группы бэкендов `vhosting-bg-a` и `vhosting-bg-b`.
1. [Удалите](../../compute/operations/instance-groups/delete.md) группы ВМ `vhosting-ig-a` и `vhosting-ig-b`.
1. [Удалите](../../vpc/operations/address-delete.md) зарезервированный статический публичный адрес.
1. Если вы использовали {{ dns-full-name }}, то [удалите](../../dns/operations/resource-record-delete.md) DNS-записи и [удалите](../../dns/operations/zone-delete.md) DNS-зону.