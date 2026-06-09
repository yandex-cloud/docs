# Создание сайта на CMS Joomla с базой данных {{ PG }} с помощью консоли управления

Чтобы создать инфраструктуру для [сайта на CMS Joomla с базой данных {{ PG }}](index.md) c помощью консоли управления {{ yandex-cloud }}:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте и настройте облачную сеть](#setup-network).
1. [Создайте виртуальную машину для Joomla](#create-vm).
1. [Создайте и настройте публичную зону DNS](#configure-dns).
1. [Добавьте TLS-сертификат в {{ certificate-manager-full-name }}](#issue-certificate).
1. [Создайте кластер БД {{ PG }}](#create-cluster).
1. [Настройте окружение на виртуальной машине](#env-install).
1. [Настройте Joomla](#configure-joomla).
1. [Проверьте работу сайта](#test-site).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

* Виртуальная машина: использование вычислительных ресурсов, хранилища, публичного IP-адреса и операционной системы (см. [тарифы {{ compute-name }}](../../../compute/pricing.md)).
* Кластер {{ mpg-name }}: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий (см. [тарифы {{ mpg-name }}](../../../managed-postgresql/pricing.md)).
* Плата за исходящий трафик (см. [тарифы {{ compute-full-name }}](../../../compute/pricing.md)).
* Публичные [DNS-запросы](../../../glossary/dns.md) и [зоны DNS](../../../dns/concepts/dns-zone.md) (см. [тарифы {{ dns-name }}](../../../dns/pricing.md)).


## Создайте и настройте облачную сеть {#setup-network}

### Создайте облачную сеть и подсети {#create-network}

{% list tabs group=instructions %}

- Консоль управления {#console} 

  1. Создайте облачную сеть:

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы будете создавать инфраструктуру.
      1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
      1. Справа сверху нажмите **{{ ui-key.yacloud.vpc.networks.button_create }}**.
      1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_name }}** укажите `joomla-network`.
      1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** отключите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
      1. Нажмите **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. Создайте подсеть в [зоне доступности](../../../overview/concepts/geo-scope.md) `{{ region-id }}-b`:

      1. В открывшемся окне со списком сетей выберите вновь созданную сеть `joomla-network`.
      1. На панели сверху нажмите ![subnets](../../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.network.overview.button_create_subnetwork }}**.
      1. В поле **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** укажите `joomla-subnet-b`.
      1. В поле **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** выберите зону доступности `{{ region-id }}-b`.
      1. В поле **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** укажите `192.168.1.0/24`.
      1. Нажмите **{{ ui-key.yacloud.vpc.subnetworks.create.button_create }}**.
  1. Аналогичным образом создайте подсети `joomla-subnet-a` и `joomla-subnet-d` соответственно в зонах доступности `{{ region-id }}-a` и `{{ region-id }}-d`. Для этих подсетей в поле **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** укажите `192.168.2.0/24` и `192.168.3.0/24`.

{% endlist %}

### Создайте группы безопасности {#crete-sg}

Создайте [группы безопасности](../../../vpc/concepts/security-groups.md) `joomla-sg` и `postgresql-sg`, которые будут использоваться для разграничения сетевого доступа к виртуальной машине и кластеру {{ mpg-full-name }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Создайте группу безопасности `joomla-sg` для виртуальной машины:

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
      1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
      1. На панели слева выберите ![image](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}** и нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
      1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** задайте имя `joomla-sg`.
      1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** выберите созданную ранее сеть `joomla-network`.
      1. В блоке **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}** [создайте](../../../vpc/operations/security-group-add-rule.md) следующие правила для управления трафиком:

          | Направление<br/>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }} |
          | --- | --- | --- | --- | --- | --- |
          | Входящий | `http`           | `80` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
          | Входящий | `https`            | `443`   | `TCP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
          | Входящий | `ssh`            | `22`   | `TCP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
          | Входящий | `self`            | `Весь`   | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` |
          | Исходящий | `any`           | `Весь` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |

      1. Нажмите **{{ ui-key.yacloud.common.create }}**.
  1. Аналогичным образом создайте группу безопасности `postgresql-sg` для кластера {{ mpg-name }} со следующими правилами для трафика:

      | Направление<br/>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }} |
      | --- | --- | --- | --- | --- | --- |
      | Входящий | `port-6432`           | `6432` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `192.168.1.0/24` |
      | Входящий | `self`            | `Весь`   | `TCP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` |
      | Исходящий | `any`           | `Весь` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |

{% endlist %}

### Зарезервируйте статический публичный IP-адрес {#reserve-ip}

Зарезервируйте статический [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses) для виртуальной машины, на которой будет размещен ваш сайт.

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
   1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. На панели слева выберите ![image](../../../_assets/console-icons/map-pin.svg) **{{ ui-key.yacloud.vpc.switch_addresses }}** и нажмите кнопку **{{ ui-key.yacloud.vpc.addresses.button_create }}**.
   1. В открывшемся окне в поле **{{ ui-key.yacloud.vpc.addresses.popup-create_field_zone }}** выберите `{{ region-id }}-b` и нажмите **{{ ui-key.yacloud.vpc.addresses.popup-create_button_create }}**.

{% endlist %}

## Создайте виртуальную машину для Joomla {#create-vm}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) на странице каталога, в котором вы создаете инфраструктуру, нажмите кнопку ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите ![cpu](../../../_assets/console-icons/cpu.svg) `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** в поле **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** введите `Ubuntu 24.04` и выберите публичный образ [Ubuntu 24.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-24-04-lts).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите зону доступности `{{ region-id }}-b`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите сеть `joomla-network` и подсеть `joomla-subnet-b`.
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_list }}` и в появившемся поле выберите зарезервированный ранее публичный IP-адрес.
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** выберите созданную ранее группу безопасности `joomla-sg`.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа на ВМ:

      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя: `yc-user`.
      * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../../organization/concepts/membership.md).
        
        Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
        
        1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_add-ssh-key }}**.
        1. Задайте имя SSH-ключа.
        1. Выберите вариант:
        
            * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-manual }}` — вставьте содержимое открытого [SSH](../../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
            * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-upload }}` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
            * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-generate }}` — автоматическое создание пары SSH-ключей.
            
              При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
        
        1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
        
        SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `joomla-web-server`.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  Создание ВМ может занять несколько минут.

{% endlist %}

## Создайте и настройте публичную зону DNS {#configure-dns}

Доменное имя, которое вы хотите использовать для сайта, нужно связать с IP-адресом созданной ВМ `joomla-web-server`. Для управления доменом вы можете использовать сервис [{{ dns-full-name }}](../../../dns/index.md).

### Делегируйте доменное имя {#delegate-domain}

Делегирование — это перенос ответственности с серверов регистратора на ваши серверы, при котором для домена создаются ресурсные записи [типа NS](../../../dns/concepts/resource-record.md#ns).

Чтобы делегировать домен, в личном кабинете вашего регистратора домена укажите в настройках домена адреса DNS-серверов `ns1.{{ dns-ns-host-sld }}` и `ns2.{{ dns-ns-host-sld }}`.

Делегирование происходит не сразу. Серверы интернет-провайдеров обычно обновляют записи в течение 24 часов (86 400 секунд). Это обусловлено значением TTL, в течение которого кешируются записи для доменов.

Проверить делегирование домена можно с помощью [сервиса Whois](https://www.reg.ru/whois/check_site) или утилиты `dig`:

```bash
dig +short NS example.com
```

Результат:

```text
ns2.{{ dns-ns-host-sld }}.
ns1.{{ dns-ns-host-sld }}.
```

### Создайте публичную зону DNS {#create-zone}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}** и нажмите **{{ ui-key.yacloud.dns.button_zone-create }}**.
  1. Задайте настройки зоны, соответствующие вашему домену:

      1. **{{ ui-key.yacloud.dns.label_zone }}** — доменная зона. Название зоны должно заканчиваться точкой. Например, название доменной зоны `example.com.` соответствует домену `example.com`. Чтобы создать доменную зону с нелатинскими символами, используйте кодировку [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode).
      1. **{{ ui-key.yacloud.common.type }}** — `{{ ui-key.yacloud.dns.label_public }}`.
      1. **{{ ui-key.yacloud.common.name }}** — `joomla-zone`.

  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Создайте ресурсную запись типа A {#create-a-record}

Создайте в вашей зоне DNS [ресурсную запись типа A](../../../dns/concepts/resource-record.md#a), указывающую на публичный IP-адрес созданной ранее ВМ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Выберите созданную ранее DNS-зону `joomla-zone` и нажмите **{{ ui-key.yacloud.dns.button_record-set-create }}**.
  1. Задайте параметры записи:
      1. В поле **{{ ui-key.yacloud.common.name }}** выберите `{{ ui-key.yacloud.dns.label_fqdn-equal-to-zone }}`.
      1. В поле **{{ ui-key.yacloud.common.type }}** выберите [тип записи](../../../dns/concepts/resource-record.md#rr-types) `A`.
      1. В поле **{{ ui-key.yacloud.dns.label_records }}** укажите [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses) созданной ранее ВМ с веб-сервером.

          Узнать IP-адрес ВМ можно в [консоли управления]({{ link-console-main }}) на странице ВМ в блоке **{{ ui-key.yacloud.compute.instance.overview.section_network }}**.

  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Добавьте TLS-сертификат в {{ certificate-manager-full-name }} {#issue-certificate}

Создайте новый [сертификат](../../../certificate-manager/concepts/managed-certificate.md) от Let's Encrypt® для вашего домена, чтобы ваш сайт был доступен по защищенному TLS-протоколу:

1. Добавьте новый сертификат в сервис {{ certificate-manager-name }}:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
      1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
      1. Нажмите **{{ ui-key.yacloud.certificate-manager.button_empty-action }}** и выберите `{{ ui-key.yacloud.certificate-manager.action_request }}`.
      1. В открывшемся окне в поле **{{ ui-key.yacloud.certificate-manager.metadata.field_name }}** укажите `joomla-cert`.
      1. В поле **{{ ui-key.yacloud.certificate-manager.request.field_domains }}** укажите имя вашего домена. Например: `example.com`.
      1. Выберите [тип проверки прав на домен](../../../certificate-manager/concepts/challenges.md) — `{{ ui-key.yacloud.certificate-manager.request.challenge-type_label_dns }}`.
      1. Нажмите **{{ ui-key.yacloud.certificate-manager.request.button_request }}**.

    {% endlist %}

1. Для успешного выпуска сертификата пройдите проверку прав на домен:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

        1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
        1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
        1. В списке сертификатов выберите `joomla-cert`.
        1. В открывшемся окне в блоке **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}** выберите `CNAME-запись`.
        1. В секции ниже нажмите **{{ ui-key.yacloud.component.dns-integration.button_add-domain }}** и в открывшемся окне нажмите **{{ ui-key.yacloud.common.create }}**.

        Проверка прав на домены может занять от нескольких минут до нескольких дней — дождитесь ее успешного завершения. В результате сертификат будет выпущен и перейдет в статус `Issued`.

    {% endlist %}

## Создайте кластер БД {{ PG }} {#create-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) на странице каталога, в котором вы создаете инфраструктуру, нажмите кнопку ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите `{{ ui-key.yacloud.iam.folder.dashboard.value_managed-postgresql }}`.
  1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_name }}** введите имя кластера — `joomla-pg-cluster`.
  1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_version }}** выберите версию СУБД — `17`.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_resource }}** выберите подходящий вам класс [хоста](../../../managed-postgresql/concepts/instance-types.md).
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_disk }}** укажите `10 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_database }}** укажите:
      * **{{ ui-key.yacloud.mdb.forms.database_field_name }}** — `joomla_db`.
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** — `joomla`.
      * В поле **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}** выберите `{{ ui-key.yacloud.component.password-input.label_button-enter-manually }}` и задайте пароль, который вы будете использовать для доступа к БД.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}** выберите созданные ранее сеть `joomla-network` и группу безопасности `postgresql-sg`.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}** добавьте дополнительные хосты так, чтобы в каждой зоне доступности было по одному хосту. При создании хостов не включайте для них **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.

  Создание кластера БД может занять несколько минут.

{% endlist %}

## Настройте окружение на виртуальной машине {#env-install}

На этом этапе вы подготовите окружение на виртуальной машине для запуска и настройки Joomla.

1. Экспортируйте TLS-сертификат `joomla-cert` на локальный компьютер:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

        1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
        1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}** и выберите сертификат `joomla-cert`.
        1. На панели сверху нажмите ![ArrowUpFromLine](../../../_assets/console-icons/arrow-up-from-line.svg) **{{ ui-key.yacloud.certificate-manager.overview.certificate_content_export }}**, выберите вариант `{{ ui-key.yacloud.certificate-manager.overview.certificate_content_select_no_private_key }}` и нажмите **{{ ui-key.yacloud.certificate-manager.overview.certificate_content_download }}**. На ваш компьютер будет скачан файл с сертификатом `certificate.pem`.
        1. Повторите предыдущее действие и скачайте закрытый ключ, выбрав вариант `{{ ui-key.yacloud.certificate-manager.overview.certificate_content_select_private_key_only }}`. Переименуйте скачанный файл с закрытым ключом в `private_key.pem`.
        1. Сохраните скачанные файлы `certificate.pem` и `private_key.pem` — они понадобятся при настройке веб-сервера.

    {% endlist %}

1. Скопируйте на ВМ полученные сертификат и закрытый ключ:

    ```bash
    scp ./certificate.pem yc-user@<IP-адрес_ВМ>:certificate.pem \
      && scp ./private_key.pem yc-user@<IP-адрес_ВМ>:private_key.pem
    ```

    Где `<IP-адрес_ВМ>` — публичный IP-адрес созданной ранее ВМ `joomla-web-server`.

    Узнать IP-адрес ВМ можно в [консоли управления]({{ link-console-main }}) на странице ВМ в блоке **{{ ui-key.yacloud.compute.instance.overview.section_network }}**.

    При первом подключении к ВМ появится предупреждение о неизвестном хосте:

    ```text
    The authenticity of host '51.250.**.*** (51.250.**.***)' can't be established.
    ED25519 key fingerprint is SHA256:PpcKdcT09gjU045pkEIwIU8lAXXLpwJ6bKC********.
    This key is not known by any other names
    Are you sure you want to continue connecting (yes/no/[fingerprint])?
    ```

    Введите в терминале слово `yes` и нажмите **Enter**.

1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md) к ВМ по SSH:

    ```bash
    ssh yc-user@<IP-адрес_ВМ>
    ```
1. Создайте директорию для сертификата и перенесите в нее скопированные файлы:

    ```bash
    sudo mkdir /etc/ssl-certificates
    sudo mv certificate.pem /etc/ssl-certificates/
    sudo mv private_key.pem /etc/ssl-certificates/
    ```
1. Обновите версии пакетов, установленные на ВМ:

    ```bash
    sudo apt update && sudo apt upgrade -y
    ```
1. Установите и запустите [Apache HTTP-сервер](https://ru.wikipedia.org/wiki/Apache_HTTP_Server):

    ```bash
    sudo apt install apache2
    sudo systemctl start apache2 && sudo systemctl enable apache2
    ```
1. Установите [PHP](https://ru.wikipedia.org/wiki/PHP) c необходимыми библиотеками:

    ```bash
    sudo apt install php libapache2-mod-php php-common php-pgsql php-xml php-mbstring php-curl php-zip php-intl php-json unzip
    ```
1. Скачайте и распакуйте пакет Joomla:

    {% note info %}

    В примере приведена ссылка на скачивание версии Joomla `5.2.4`, актуальной на момент написания данного руководства. Уточнить наличие более новой версии и получить ссылку на скачивание вы можете на [сайте](https://downloads.joomla.org/) проекта.

    {% endnote %}

    ```bash
    wget https://downloads.joomla.org/cms/joomla5/5-2-4/Joomla_5-2-4-Stable-Full_Package.zip -O Joomla.zip
    sudo rm /var/www/html/index.html
    sudo unzip Joomla.zip -d /var/www/html
    rm Joomla.zip
    ```
1. Настройте разрешения на доступ к директории с сайтом:

    ```
    sudo chown -R www-data:www-data /var/www/html
    sudo chmod -R 755 /var/www/html
    ```
1. Измените номер порта по умолчанию, использующийся Joomla для доступа к базам данных {{ PG }}: в {{ mpg-full-name }} используется порт `6432`.

    1. Откройте файл настроек драйверов доступа к базам данных Joomla:

        ```bash
        sudo nano /var/www/html/libraries/vendor/joomla/database/src/Pdo/PdoDriver.php
        ```
    1. Найдите в файле раздел с настройками баз данных {{ PG }} и замените номер порта c `5432` на `6432`:

        ```php
        ...
        case 'pgsql':
        $this->options['port'] = $this->options['port'] ?? 6432;
        ...
        ```

        Не забудьте сохранить внесенные изменения.
1. Настройте виртуальный хост для вашего сайта:

    1. Создайте файл конфигурации виртуального хоста:

        ```bash
        sudo nano /etc/apache2/sites-available/joomla.conf
        ```

    1. Поместите в созданный файл следующую конфигурацию:

        ```text
        <VirtualHost *:80>
            ServerAdmin admin@localhost
            DocumentRoot /var/www/html
            ServerName <имя_домена>

            <Directory /var/www/html>
                Options FollowSymLinks
                AllowOverride All
                Require all granted
            </Directory>

            ErrorLog ${APACHE_LOG_DIR}/joomla_http_error.log
            CustomLog ${APACHE_LOG_DIR}/joomla_http_access.log combined
        </VirtualHost>

        <VirtualHost *:443>
            ServerAdmin admin@localhost
            DocumentRoot /var/www/html
            ServerName <имя_домена>

            ErrorLog ${APACHE_LOG_DIR}/joomla_ssl_error.log
            CustomLog ${APACHE_LOG_DIR}/joomla_ssl_access.log combined

            SSLEngine on
            SSLCertificateFile /etc/ssl-certificates/certificate.pem
            SSLCertificateChainFile /etc/ssl-certificates/certificate.pem
            SSLCertificateKeyFile /etc/ssl-certificates/private_key.pem
        </VirtualHost>
        ```

        Где `<имя_домена>` — доменное имя вашего сайта. Например: `example.com`.
1. Активируйте созданный виртуальный хост и перезапустите веб-сервер:

    ```bash
    sudo a2ensite joomla.conf
    sudo a2enmod rewrite
    sudo a2enmod ssl
    sudo systemctl restart apache2
    ```

## Настройте Joomla {#configure-joomla}

1. Получите имена хостов кластера {{ mpg-name }}, они потребуются в процессе установки Joomla:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится кластер.
      1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
      1. Выберите кластер `joomla-pg-cluster` и перейдите на вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}**.
      1. Наведите указатель мыши на поле **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** в строке с  каждым из хостов и нажмите значок ![Copy](../../../_assets/console-icons/copy.svg), чтобы скопировать FQDN хоста. Сохраните скопированные значения — они понадобятся позднее.

    {% endlist %}

1. Установите и настройте Joomla:

    1. Откройте в браузере мастер установки и настройки Joomla. На этом этапе он должен быть доступен по любому из адресов:

        * `http://<публичный_IP-адрес_ВМ>`
        * `http://<имя_вашего_домена>`
        * `https://<имя_вашего_домена>`
    1. При настройке параметров базы данных заполните поля:

        * **Тип базы данных** — `{{ PG }} (PDO)`.
        * **Имя хоста**:

            ```text
            <имя_хоста_1>,<имя_хоста_2>,<имя_хоста_3>
            ```

            Где `<имя_хоста_1>`, `<имя_хоста_2>`, `<имя_хоста_3>` — FQDN-имена хостов кластера {{ mpg-name }}, скопированные на предыдущем шаге.
        * **Имя пользователя базы данных** — `joomla`.
        * **Пароль пользователя базы данных** — пароль пользователя БД, заданный при создании кластера {{ PG }}.
        * **Имя базы данных** — `joomla_db`.
        * **Шифрование соединения** — оставьте значение по умолчанию.
    1. В качестве проверки безопасности Joomla может попросить вас создать или удалить определенный тестовый файл в директории установки продукта на ВМ. Перейдите в директорию `/var/www/html/installation/` и создайте или удалите там указанный файл:

        ```text
        Вы пытаетесь использовать хост базы данных, который недоступен на локальном 
        сервере. Вам необходимо подтвердить право собственности на учетную запись 
        на хостинге. Пожалуйста, ознакомьтесь с информацией на странице Защищенная 
        процедура установки Joomla.

        Для подтверждения права собственности на сайт, пожалуйста, удалите файл 
        _JoomlazUZKusLnD2jXi********.txt в каталоге installation и нажмите 
        "Установить Joomla" для продолжения.
        ```
1. После завершения установки удалите директорию `installation` на ВМ. Это требование безопасности Joomla:

    ```bash
    sudo rm -rf /var/www/html/installation
    ```

Если в процессе установки Joomla у вас возникли трудности, воспользуйтесь [инструкцией](https://docs.joomla.org/J4.x:Installing_Joomla) на сайте проекта.

## Проверьте работу сайта {#test-site}

После завершения установки Joomla введите в браузере IP-адрес или доменное имя вашего сайта, чтобы проверить его работу:

* `http://<публичный_IP-адрес_ВМ>`
* `http://example.com`
* `https://example.com`

Теперь вы можете приступить к дальнейшей настройке вашего сайта и наполнению его контентом с помощью административного интерфейса и инструментов Joomla.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. [Удалите](../../../compute/operations/vm-control/vm-delete.md) виртуальную машину `joomla-web-server`.
1. [Удалите](../../../vpc/operations/address-delete.md) статический публичный IP-адрес.
1. [Удалите](../../../managed-postgresql/operations/cluster-delete.md) кластер {{ mpg-name }} `joomla-pg-cluster`.
1. [Удалите](../../../dns/operations/resource-record-delete.md) DNS-записи, затем [удалите](../../../dns/operations/zone-delete.md) DNS-зону `joomla-zone`.
1. [Удалите](../../../certificate-manager/operations/managed/cert-delete.md) TLS-сертификат `joomla-cert`.
1. [Удалите](../../../vpc/operations/security-group-delete.md) группы безопасности `joomla-sg` и `postgresql-sg`.
1. [Удалите](../../../vpc/operations/subnet-delete.md) подсети `joomla-subnet-a`, `joomla-subnet-b` и `joomla-subnet-d`.
1. [Удалите](../../../vpc/operations/network-delete.md) облачную сеть `joomla-network`.

#### См. также {#see-also}

* [{#T}](terraform.md).