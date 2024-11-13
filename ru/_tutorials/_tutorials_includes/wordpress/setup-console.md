1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте группу безопасности](#create-security-group).
1. [Создайте ВМ для WordPress](#create-vm).
1. [Настройте DNS (если есть доменное имя)](#configure-dns).
1. [Настройте WordPress](#wordpress-config).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}

{% include [network-is-exist](../../_tutorials_includes/network-is-exist.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources-wp](../../_tutorials_includes/wordpress/paid-resources-wp.md) %}

## Создайте группу безопасности {#create-security-group}

Чтобы создать [группу безопасности](../../../vpc/concepts/security-groups.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ vpc-name }}**.
  1. Откройте вкладку **Группы безопасности**.
  1. Нажмите кнопку **Создать группу**.
  1. Укажите **Имя** группы: `wordpress`.
  1. Выберите **Сеть**.
  1. В блоке **Правила** создайте следующие правила по инструкции под таблицей:

     Направление<br>трафика | Описание | Диапазон<br>портов | Протокол | Тип источника /<br>назначения | Источник /<br>назначение
     --- | --- | --- | --- | --- | ---
     Исходящий | any | Весь | Любой | CIDR | 0.0.0.0/0
     Входящий | ext-http | 80 | TCP | CIDR | 0.0.0.0/0
     Входящий | ext-https | 443 | TCP | CIDR | 0.0.0.0/0

     1. Выберите вкладку **Исходящий трафик** или **Входящий трафик**.
     1. Нажмите кнопку **Добавить правило**.
     1. В открывшемся окне в поле **Диапазон портов** укажите порт, куда будет поступать трафик. Для исходящего трафика не указывайте ничего.
     1. В поле **Протокол** укажите нужный протокол. Для исходящего трафика оставьте **Любой**, чтобы разрешить передачу трафика по всем протоколам.
     1. В поле **Назначение** или **Источник** выберите **CIDR** — правило будет применено к диапазону IP-адресов. В поле **CIDR блоки** укажите `0.0.0.0/0`.
     1. Нажмите кнопку **Сохранить**. Таким образом создайте все правила из таблицы.
  1. Нажмите кнопку **Сохранить**.

{% endlist %}

## Создайте ВМ для WordPress {#create-vm}

Чтобы создать ВМ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления]({{ link-console-main }}) нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** в поле **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** введите `WordPress` и выберите публичный образ [WordPress](/marketplace/products/yc/wordpress).
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
      * {% include [access-ssh-key](../../../_includes/compute/create/access-ssh-key.md) %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `wordpress`.
  1. Нажмите **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  Создание ВМ может занять несколько минут. Когда ВМ перейдет в статус `RUNNING`, вы можете начать настраивать сайт.

  При создании ВМ назначается публичный IP-адрес и [имя хоста (FQDN)](../../../compute/concepts/network.md#hostname). Эти данные можно использовать при настройке DNS и для доступа по SSH.

{% endlist %}

## Настройте DNS (если есть доменное имя) {#configure-dns}

Если у вас есть зарегистрированное доменное имя, воспользуйтесь сервисом [{{ dns-full-name }}](../../../dns/) для управления доменом.

{% include [configure-a-record-and-cname](../../_tutorials_includes/configure-a-record-and-cname.md) %}

## Настройте WordPress {#wordpress-config}

Чтобы настроить WordPress:

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [wordpress-config](wordpress-config.md) %}

{% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../../compute/operations/vm-control/vm-delete.md) ВМ `wordpress`.
1. [Удалите](../../../vpc/operations/address-delete.md) статический публичный IP-адрес, если вы зарезервировали его специально для этой ВМ.
1. [Удалите](../../../dns/operations/resource-record-delete.md) DNS-записи и [удалите](../../../dns/operations/zone-delete.md) DNS-зону, если вы использовали {{ dns-name }}.
