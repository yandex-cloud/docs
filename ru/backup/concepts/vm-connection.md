# Подключение виртуальных машин {{ compute-name }} к {{ backup-name }}

Если вы хотите создавать резервные копии [ВМ](../../compute/concepts/vm.md) [{{ compute-full-name }}](../../compute/) в сервисе {{ backup-name }}, ее нужно подключить к сервису и корректно настроить.

Чтобы ВМ можно было подключить к {{ backup-name }}, на ней должна быть установлена одна из [поддерживаемых операционных систем](#os). Подробнее о подключении см. в [инструкциях](../operations/index.md#connect-vm).

Чтобы подключение работало корректно, к ВМ нужно привязать [сервисный аккаунт](#sa) с ролью `backup.editor` и настроить для ВМ [сетевой доступ](#vm-network-access).

После подключения к {{ backup-name }} и настройки ВМ нужно привязать к [политике резервного копирования](policy.md).

## Требования к характеристикам ВМ {#requirements}

Минимальные характеристики ВМ для установки и корректной работы агента {{ backup-name }}:
* Объем свободного места на диске:
  * Для ВМ с ОС Linux — 2 ГБ.
  * Для ВМ с ОС Windows — 1,2 ГБ.
* Объем памяти (RAM) — при резервном копировании требуется 1 ГБ RAM на каждый ТБ резервной копии. Объем используемой памяти зависит от объема и типа данных, обрабатываемых агентом.

## Поддерживаемые операционные системы {#os}

Агент {{ backup-name }} доступен для автоматической установки при создании ВМ из образов {{ marketplace-full-name }}:

### Образы на базе Linux {#linux}

* [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts).
* [Ubuntu 18.04 LTS](/marketplace/products/yc/ubuntu-18-04-lts).
* [Ubuntu 16.04 LTS](/marketplace/products/yc/ubuntu-26-04-lts).
* [CentOS 7](/marketplace/products/yc/centos-7).

### Образы на базе Windows {#windows}

* [Kosmos VM 2022 на базе Windows Server Datacenter 2022](/marketplace/products/fotonsrv/kosmosvm2022).
* [Kosmos VM 2019 на базе Windows Server Datacenter 2019](/marketplace/products/fotonsrv/kosmosvm2019).
* [Kosmos VM 2016 на базе Windows Server Datacenter 2016](/marketplace/products/fotonsrv/kosmosvm2016).
* [Kosmos VM RDS (5 лицензий)](/marketplace/products/fotonsrv/kos-5-rds).
* [Kosmos VM RDS (10 лицензий)](/marketplace/products/fotonsrv/kos-10-rds).
* [Kosmos VM RDS (50 лицензий)](/marketplace/products/fotonsrv/kos-50-rds).
* [Kosmos BD WEB 2019](/marketplace/products/fotonsrv/kosmosbdweb2019).
* [Kosmos BD Standard 2019](/marketplace/products/fotonsrv/kosmosbdstd2019).
* [Kosmos VM Visio Pro 2021](/marketplace/products/fotonsrv/kosmosvisio).

{% note info %}

Ubuntu или CentOS должна быть установлена из публичного образа (продукта {{ marketplace-full-name }}). При создании ВМ можно выбрать ОС напрямую либо использовать [образ](../../compute/concepts/image.md) или [снимок диска](../../compute/concepts/snapshot.md) с другой ВМ, если ОС на нее тоже устанавливалась из публичного образа.

{% endnote %}

### Самостоятельная установка {#self-install}

Вы можете установить агента {{ backup-name }} самостоятельно:

* [Инструкция для Linux](../operations/connect-vm-linux.md).
* [Инструкция для Windows](../operations/connect-vm-windows.md).

С полным списком поддерживаемых ОС можно ознакомиться в [документации провайдера резервного копирования](https://docs.cyberprotect.ru/ru-RU/CyberBackupCloud/21.06/user/#supported-operating-systems-and-environments.html).

При возникновении проблем с установкой агента, [обратитесь]({{ link-console-support }}) в техническую поддержку.

Позже в {{ backup-name }} будет поддержана Ubuntu 22.04.

## Сервисный аккаунт {#sa}

[Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) — специальный аккаунт, от имени которого копии ВМ создаются и загружаются в хранилище {{ backup-name }}.

Когда вы создаете ВМ, для которой хотите настроить резервное копирование в {{ backup-name }}, к ВМ нужно привязать сервисный аккаунт с [ролью `backup.editor`](../security/index.md).

Вы можете [назначить роль](../../iam/operations/sa/assign-role-for-sa.md) существующему сервисному аккаунту или [создать](../../iam/operations/sa/create.md) сервисный аккаунт с нужными ролями.

## Разрешения сетевого доступа для ВМ {#vm-network-access}

Чтобы агент {{ backup-name }} мог обмениваться данными с серверами [провайдера резервного копирования](index.md#providers), для ВМ должен быть обеспечен сетевой доступ к IP-адресам ресурсов сервиса {{ backup-name }} согласно таблице:

{% list tabs %}

- Исходящий трафик

  {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
  --- | --- | --- | ---
  `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `213.180.193.0/24`
  `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `213.180.204.0/24`
  `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `84.47.172.0/24`
  `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `84.201.181.0/24`
  `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `178.176.128.0/24`
  `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `193.32.199.0/24`
  `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `213.180.193.0/24`
  `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `213.180.204.0/24`
  `7770-7800` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `84.47.172.0/24`
  `8443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `84.47.172.0/24`
  `44445` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `51.250.1.0/24`

{% endlist %}

Чтобы обеспечить сетевой доступ, [назначьте](../../compute/operations/vm-control/vm-attach-public-ip.md) ВМ публичный IP-адрес или примените [таблицу маршрутизации](../../vpc/concepts/static-routes.md#rt-vm), разрешающую доступ в интернет через [NAT-шлюз](../../vpc/concepts/gateways.md) или пользовательский маршрутизатор. 

Правила [группы безопасности](../../vpc/concepts/security-groups.md) ВМ должны разрешать доступ к указанным ресурсам. Вы можете [добавить правила](../../vpc/operations/security-group-add-rule.md) в существующую группу безопасности или [создать](../../vpc/operations/security-group-create.md) новую группу с нужными правилами.

