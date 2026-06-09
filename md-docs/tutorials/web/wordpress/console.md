# Создание сайта на WordPress с помощью консоли управления

Чтобы создать и настроить [сайт на WordPress](index.md) с помощью консоли управления {{ yandex-cloud }}:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте группу безопасности](#create-security-group).
1. [Создайте ВМ для WordPress](#create-vm).
1. [Настройте DNS (если есть доменное имя)](#configure-dns).
1. [Получите данные для аутентификации в веб-интерфейсе](#get-auth-data).
1. [Подключитесь к веб-интерфейсу WordPress](#connect-wordpress-interface).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

Убедитесь, что в выбранном [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) есть [облачная сеть](../../../vpc/concepts/network.md#network) с [подсетью](../../../vpc/concepts/network.md#subnet) хотя бы в одной [зоне доступности](../../../overview/concepts/geo-scope.md). Для этого на странице каталога выберите сервис **{{ vpc-short-name }}**. Если в списке есть сеть — нажмите на нее, чтобы увидеть список подсетей. Если нужных подсетей или сети нет, [создайте их](../../../vpc/quickstart.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки сайта на WordPress входит:
* плата за постоянно запущенную ВМ (см. [тарифы {{ compute-full-name }}](../../../compute/pricing.md));
* плата за использование динамического или статического [публичного IP-адреса](../../../vpc/concepts/address.md#public-addresses) (см. [тарифы {{ vpc-full-name }}](../../../vpc/pricing.md));
* плата за публичные [DNS-запросы](../../../glossary/dns.md) и [зоны DNS](../../../dns/concepts/dns-zone.md), если вы используете [{{ dns-full-name }}](../../../dns/index.md) (см. [тарифы {{ dns-name }}](../../../dns/pricing.md)).

## Создайте группу безопасности {#create-security-group}

Чтобы создать [группу безопасности](../../../vpc/concepts/security-groups.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Откройте вкладку **{{ ui-key.yacloud.vpc.network.security-groups.label_title }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
  1. Укажите **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** группы: `wordpress`.
  1. Выберите **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}**.
  1. В блоке **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}** создайте следующие правила по инструкции под таблицей:

     Направление<br/>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
     --- | --- | --- | --- | --- | ---
     Исходящий | `any` | `Весь` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
     Входящий  | `ext-http` | `80` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
     Входящий  | `ext-https` | `443` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
     Входящий  | `ext-ssh` | `22` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`

     1. Выберите вкладку **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** или **{{ ui-key.yacloud.vpc.network.security-groups.label_ingress }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
     1. В открывшемся окне в поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** укажите порт, куда будет поступать трафик. Для исходящего трафика не указывайте ничего.
     1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** укажите нужный протокол. Для исходящего трафика оставьте `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`, чтобы разрешить передачу трафика по всем протоколам.
     1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** или **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** выберите `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` — правило будет применено к диапазону IP-адресов. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** введите `0.0.0.0`, в списке после **/** выберите `0`.
     1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**. Таким образом создайте все правила из таблицы.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Создайте ВМ для WordPress {#create-vm}

Чтобы создать ВМ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления]({{ link-console-main }}) нажмите кнопку ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** в поле **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** введите `WordPress` и выберите публичный образ [WordPress](https://yandex.cloud/ru/marketplace/products/yc/wordpress).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться ВМ. Если вы не знаете, какая зона доступности вам нужна, оставьте выбранную по умолчанию.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** перейдите на вкладку `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` и укажите необходимую [платформу](../../../compute/concepts/vm-platforms.md), количество vCPU и объем RAM:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Ice Lake`.
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `2`.
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `20%`.
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `1 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите сеть, в которой вы создали группу безопасности `wordpress`, и [подсеть](../../../vpc/concepts/network.md#subnet), к которой нужно подключить ВМ. Если подсети еще нет, [создайте](../../../vpc/operations/subnet-create.md) ее.
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** оставьте значение `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`, чтобы назначить ВМ случайный внешний IP-адрес из пула {{ yandex-cloud }}, или выберите статический адрес из списка, если вы зарезервировали его заранее.
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** выберите группу безопасности `wordpress`.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа на ВМ:

      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
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

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `wordpress`.
  1. Нажмите **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  Создание ВМ может занять несколько минут. Когда ВМ перейдет в статус `RUNNING`, вы можете начать настраивать сайт.

  При создании ВМ назначается публичный IP-адрес и [имя хоста (FQDN)](../../../compute/concepts/network.md#hostname). Эти данные можно использовать при настройке DNS и для доступа по SSH.

{% endlist %}

## Настройте DNS (если есть доменное имя) {#configure-dns}

Если у вас есть зарегистрированное доменное имя, воспользуйтесь сервисом [{{ dns-full-name }}](../../../dns/index.md) для управления доменом.

В инструкции ниже описана настройка DNS для доменного имени `example.com`.

### Добавьте зону DNS {#create-dns-zone}

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы добавить [публичную зону DNS](../../../dns/concepts/dns-zone.md#public-zones):
   1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}** в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), где требуется создать [зону DNS](../../../dns/concepts/dns-zone.md).
   1. Нажмите кнопку **{{ ui-key.yacloud.dns.button_zone-create }}**.
   1. Задайте настройки зоны DNS:
      * **{{ ui-key.yacloud.dns.label_zone }}** — `example.com.`. Или укажите ваш зарегистрированный домен.
      * **{{ ui-key.yacloud.common.type }}** — `{{ ui-key.yacloud.dns.label_public }}`.
      * **{{ ui-key.yacloud.common.name }}** — `example-zone-1`.
   1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Добавьте ресурсные записи {#create-dns-records}

Создайте в публичной зоне записи DNS:

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В блоке **{{ ui-key.yacloud.compute.instance.overview.section_network }}** на странице [виртуальной машины](../../../compute/concepts/vm.md) в [консоли управления]({{ link-console-main }}) найдите [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses) ВМ.
   1. Создайте запись [типа А](../../../dns/concepts/resource-record.md#a):
      * Откройте раздел **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}** в каталоге, где находится зона DNS `example.com`.
      * Выберите зону DNS `example.com` из списка.
      * Нажмите кнопку **{{ ui-key.yacloud.dns.button_record-set-create }}**.
      * Задайте параметры записи:
         * **{{ ui-key.yacloud.common.name }}** — оставьте пустым.
         * **{{ ui-key.yacloud.common.type }}** — оставьте значение `А`.
         * **{{ ui-key.yacloud.dns.label_records }}** — введите публичный адрес вашей ВМ.
         * **{{ ui-key.yacloud.dns.label_form-ttl }}** (время кеширования записи) — оставьте значение по умолчанию.
      * Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
   1. Создайте запись [типа CNAME](../../../dns/concepts/resource-record.md#cname):
      * Выберите зону DNS `example.com` из списка.
      * Нажмите кнопку **{{ ui-key.yacloud.dns.button_record-set-create }}**.
      * Задайте параметры записи:
         * **{{ ui-key.yacloud.common.name }}** — `www`.
         * **{{ ui-key.yacloud.common.type }}** — выберите значение `CNAME`.
         * **{{ ui-key.yacloud.dns.label_records }}** — введите `example.com`.
         * **{{ ui-key.yacloud.dns.label_form-ttl }}** (время кеширования записи) — оставьте значение по умолчанию.
      * Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Делегируйте доменное имя {#delegate-domain}

Делегирование — это перенос ответственности с серверов регистратора на ваши серверы. Для домена создаются ресурсные записи [типа NS](../../../dns/concepts/resource-record.md#ns) (`ns1.{{ dns-ns-host-sld }}` и `ns2.{{ dns-ns-host-sld }}`).

Чтобы делегировать домен, укажите для него DNS-серверы в личном кабинете регистратора.

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

## Получите данные для аутентификации в веб-интерфейсе {#get-auth-data}

При создании ВМ автоматически создается учетная запись администратора для веб-интерфейса. Чтобы получить данные для аутентификации:

1. Подключитесь по протоколу SSH к созданной ВМ:

   ```bash
   ssh <имя_пользователя>@<публичный_IP-адрес_ВМ>
   ```

1. Переключитесь в режим root, чтобы получить привилегии суперпользователя:

   ```bash
   sudo su
   ```

1. Откройте файл для чтения:

   ```bash
   cat root/default_passwords.txt
   ```

1. Скопируйте имя пользователя и пароль из строк `WP_ADMIN_USER` и `WP_ADMIN_PASSWORD`.

## Подключитесь к веб-интерфейсу WordPress {#connect-wordpress-interface}

Чтобы подключиться к веб-интерфейсу WordPress:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу ВМ, в блоке **Сеть** найдите публичный IP-адрес ВМ и внесите в [ресурсную запись](../../../dns/concepts/dns-zone.md) [типа А](../../../dns/concepts/resource-record.md#a), созданную ранее.
  
     ![add-ssh](../../../_assets/tutorials/wordpress/vm-create-5.png)
  
  1. В браузере перейдите по доменному имени, которое вы настроили, или по адресу ВМ в панель администратора WordPress: `http://<доменное_имя_или_публичный_адрес_ВМ>/wp-admin`.
  1. Введите имя пользователя и пароль, сохраненные ранее.

{% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../../compute/operations/vm-control/vm-delete.md) ВМ `wordpress`.
1. [Удалите](../../../vpc/operations/address-delete.md) статический публичный IP-адрес, если вы зарезервировали его специально для этой ВМ.
1. [Удалите](../../../dns/operations/resource-record-delete.md) DNS-записи и [удалите](../../../dns/operations/zone-delete.md) DNS-зону, если вы использовали {{ dns-name }}.

#### См. также {#see-also}

* [{#T}](terraform.md).