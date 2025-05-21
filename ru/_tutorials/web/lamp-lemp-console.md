1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте облачную сеть и подсети](#create-network).
1. [Создайте группу безопасности](#create-security-groups).
1. [Создайте ВМ с предустановленным веб-сервером](#create-vm).
1. [Загрузите файлы сайта](#upload-files).
1. [Настройте DNS](#configure-dns).
1. [Проверьте работу сайта](#test-site).

В качестве примера используется доменное имя `example.com`.

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [lamp-lemp-paid-resources](../_tutorials_includes/lamp-lemp-paid-resources.md) %}

## Создайте облачную сеть и подсети {#create-network}

Все ресурсы, созданные в сценарии, будут относиться к одной [облачной сети](../../vpc/concepts/network.md).

Чтобы создать сеть и подсети:

{% list tabs group=instructions %}

- Консоль управления {#console} 

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ vpc-name }}**.
  1. Нажмите кнопку **Создать сеть**.
  1. Укажите **Имя** сети: `web-network`.
  1. В поле **Дополнительно** выберите опцию **Создать подсети**.
  1. Нажмите кнопку **Создать сеть**.

{% endlist %}

## Создайте группу безопасности {#create-security-groups}

[Группы безопасности](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) содержат правила, которые разрешают обращаться к ВМ из интернета. Далее будет создана группа безопасности `sg-web`.

Чтобы создать группу безопасности:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ vpc-name }}**.
  1. Откройте вкладку **Группы безопасности**.
  1. Создайте группу безопасности для ВМ:
      1. Нажмите кнопку **Создать группу**.
      1. Укажите **Имя** группы: `sg-web`.
      1. Выберите **Сеть** `web-network`.
      1. В блоке **Правила** создайте следующие правила по инструкции под таблицей:

          | Направление<br/>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | Источник /<br/>назначение | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
          | --- | --- | --- | --- | --- | --- |
          | `Исходящий` | `any` | `Весь` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `CIDR` | `0.0.0.0/0` |
          | `Входящий` | `ext-http` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
          | `Входящий` | `ext-https` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |

          1. Выберите вкладку **Исходящий трафик** или **Входящий трафик**.
          1. Нажмите кнопку **Добавить правило**.
          1. В открывшемся окне в поле **Диапазон портов** укажите один порт или диапазон портов, куда или откуда будет поступать трафик.
          1. В поле **Протокол** укажите нужный протокол или оставьте **Любой**, чтобы разрешить передачу трафика по всем протоколам.
          1. В поле **Назначение** или **Источник** выберите назначение правила:
              * **CIDR** — правило будет применено к диапазону IP-адресов. В поле **CIDR блоки** укажите CIDR и маски [подсетей](../../vpc/concepts/network.md#subnet), в которые или из которых будет поступать трафик. Чтобы добавить несколько CIDR, нажимайте кнопку **Добавить CIDR**.
              * **Группа безопасности** — правило будет применено к ВМ из текущей группы или из выбранной группы безопасности.
          1. Нажмите кнопку **Сохранить**. Таким образом создайте все правила из таблицы.
      1. Нажмите кнопку **Сохранить**.

{% endlist %}

## Создайте ВМ с предустановленным веб-сервером {#create-vm}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления]({{ link-console-main }}) нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** в поле **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** введите `LAMP` или `LEMP` и выберите образ ВМ с нужным набором компонентов: 
      * [LAMP](/marketplace/products/yc/lamp) для Linux, Apache, {{ MY }}, PHP.
      * [LEMP](/marketplace/products/yc/lemp) для Linux, Nginx, {{ MY }}, PHP.

          LEMP рекомендуется использовать для статических сайтов.

  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет создана ВМ. Если вы не знаете, какая зона доступности вам нужна, оставьте выбранную по умолчанию.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** перейдите на вкладку `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` и укажите необходимую [платформу](../../compute/concepts/vm-platforms.md), количество vCPU и объем RAM. Для функционального тестирования сайта будет достаточно минимальной конфигурации:
      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Ice Lake`.
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `2`.
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `20%`.
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `1 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите сеть `web-network` и подсеть, в которой будет создана ВМ.
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** оставьте значение `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`, чтобы назначить ВМ случайный внешний IP-адрес из пула {{ yandex-cloud }}, или выберите статический адрес из списка, если вы зарезервировали его заранее.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа на ВМ:

      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.

      * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../organization/concepts/membership.md).

          Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
          * Нажмите кнопку **Добавить ключ**.
          * Задайте имя SSH-ключа.
          * Загрузите или вставьте содержимое открытого SSH-ключа. Пару SSH-ключей для подключения к ВМ по [SSH](../../glossary/ssh-keygen.md) необходимо [создать](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
          * Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

          SSH-ключ будет добавлен в ваш профиль пользователя организации.

          Если в организации отключена возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя создаваемой виртуальной машины.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `lamp-vm` или `lemp-vm`. Требования к имени:

      {% include [name-format](../../_includes/name-format.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

      {% note alert %}

      IP-адрес и [имя хоста (FQDN)](../../compute/concepts/network.md#hostname) для подключения к ВМ назначается ей при создании. Если в поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** вы выбрали вариант `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`, вы не сможете обращаться к ВМ из интернета.

      {% endnote %}

  1. Нажмите кнопку **Создать ВМ**.

      Создание ВМ может занять несколько минут. Когда ВМ перейдет в статус `RUNNING`, вы можете [загрузить на нее файлы сайта](#upload-files).

{% endlist %}

## Загрузите файлы сайта {#upload-files}

{% include [lamp-lemp-paid-upload-files](../_tutorials_includes/lamp-lemp-upload-files.md) %}

## Настройте DNS {#configure-dns}

Если у вас есть зарегистрированное доменное имя, воспользуйтесь сервисом Cloud DNS для управления доменом.

Далее описана настройка DNS для доменного имени `example.com`. Доменное имя `example.com` должно быть связано с IP-адресом ВМ с помощью [записей DNS](../../dns/concepts/resource-record.md). Чтобы это сделать:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Скопируйте IP-адрес созданной ВМ.
  1. На сайте компании, которая предоставляет вам услуги DNS-хостинга, перейдите в настройки DNS.
  1. Создайте или измените [A-запись](../../dns/concepts/resource-record.md#a) для `example.com` таким образом, чтобы она указывала на скопированный IP-адрес:

      ```text
      example.com. A <IP-адрес_ВМ>
      ```

  1. Создайте [CNAME](../../dns/concepts/resource-record.md#CNAME) с именем `www` и значением `example.com`.    

      Если вы пользуетесь [{{ dns-full-name }}](../../dns/), настройте запись по следующей инструкции:

      {% cut "Инструкция по настройке DNS-записей для {{ dns-name }}" %}

      1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
      1. Если у вас нет публичной [зоны DNS](../../dns/concepts/dns-zone.md), создайте ее:
          1. Нажмите кнопку **{{ ui-key.yacloud.dns.button_zone-create }}**.
          1. Укажите **{{ ui-key.yacloud.common.name }}** зоны: `example-zone-1`.
          1. В поле **{{ ui-key.yacloud.dns.label_zone }}** укажите доменное имя сайта с точкой в конце: `example.com.`
          1. Выберите **{{ ui-key.yacloud.common.type }}** зоны — `{{ ui-key.yacloud.dns.label_public }}`.
          1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
      1. Создайте запись [типа А](../../dns/concepts/resource-record.md#a):
          1. В списке зон нажмите на зону `example-zone-1`.
          1. Нажмите кнопку **{{ ui-key.yacloud.dns.button_record-set-create }}**.
          1. Поле **{{ ui-key.yacloud.common.name }}** оставьте пустым, чтобы запись соответствовала доменному имени `example.com` (а не имени с субдоменом, например `www.example.com`).
          1. Выберите **{{ ui-key.yacloud.common.type }}** записи — `A`.
          1. В поле **{{ ui-key.yacloud.dns.label_records }}** вставьте скопированный IP-адрес ВМ.
          1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
      1. Создайте запись [типа CNAME](../../dns/concepts/resource-record.md#cname):
         * Выберите зону DNS `example.com` из списка.
         * Нажмите кнопку **Создать запись**.
         * Задайте параметры записи:
           * **Имя**: `www`.
           * **Тип записи**: выберите значение `CNAME`.
           * **TTL** (время кеширования записи): оставьте значение по умолчанию.
           * **Значение**: введите `example.com`.
         * Нажмите кнопку **Создать**.
      
      {% endcut %}

{% endlist %}

### Делегируйте доменное имя {#delegate-domain}

Делегирование — это перенос ответственности с серверов регистратора на ваши серверы. Для домена создаются ресурсные записи [типа NS](../../dns/concepts/resource-record.md#ns) (`ns1.{{ dns-ns-host-sld }}` и `ns2.{{ dns-ns-host-sld }}`).

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

## Проверьте работу сайта {#test-site}

{% include [lamp-lemp-paid-test](../_tutorials_includes/lamp-lemp-test.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Удалите](../../compute/operations/vm-control/vm-delete.md) ВМ `lamp-vm` (`lemp-vm`).
  1. [Удалите](../../vpc/operations/address-delete.md) статический публичный IP-адрес, если вы зарезервировали его специально для этой ВМ.
  1. [Удалите](../../dns/operations/resource-record-delete.md) DNS-записи и [удалите](../../dns/operations/zone-delete.md) DNS-зону, если вы использовали {{ dns-name }}.

{% endlist %}
