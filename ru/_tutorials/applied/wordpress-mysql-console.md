Чтобы настроить сайт на WordPress с кластером {{ MY }}:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте ВМ для WordPress](#create-vm).
1. [Создайте кластер БД {{ MY }}](#create-cluster).
1. [Настройте веб-сервер Nginx](#configure-nginx).
1. [Установите WordPress и дополнительные компоненты](#install-wordpress).
1. [Завершите настройку WordPress](#configure-wordpress).
1. [Настройте DNS](#configure-dns).
1. [Проверьте работу сайта](#test-site).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/wordpress-mysql/paid-resources.md) %}

## Создайте ВМ для WordPress {#create-vm}

Чтобы создать виртуальную машину для WordPress:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления]({{ link-console-main }}) нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите один из публичных образов: [Debian 11](/marketplace/products/yc/debian-11), [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts) или [CentOS 7](/marketplace/products/yc/centos-7).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ. Если вы не знаете, какая зона доступности вам нужна, оставьте выбранную по умолчанию.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** перейдите на вкладку `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` и укажите необходимую [платформу](../../compute/concepts/vm-platforms.md), количество vCPU и объем RAM:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Ice Lake`.
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `2`.
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `20%`.
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `2 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите сеть и подсеть, к которым нужно подключить ВМ. Если нужной [сети](../../vpc/concepts/network.md#network) или [подсети](../../vpc/concepts/network.md#subnet) еще нет, [создайте их](../../vpc/operations/subnet-create.md).
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** оставьте значение `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`, чтобы назначить ВМ случайный внешний IP-адрес из пула {{ yandex-cloud }}, или выберите статический адрес из списка, если вы зарезервировали его заранее.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа на ВМ:

      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя, например: `yc-user`. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `wp-mysql-tutorial-web`.

      { % note alert %}

      IP-адрес и [имя хоста (FQDN)](../../compute/concepts/network.md#hostname) для подключения к ВМ назначается ей при создании. Если вы выбрали вариант `{{ ui-key.yacloud.component.compute.network-select.switch_none }}` в поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}**, вы не сможете обращаться к ВМ из интернета.

      {% endnote %}

  1. Нажмите **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

{% endlist %}

Создание ВМ может занять несколько минут. Когда ВМ перейдет в [статус](../../compute/concepts/vm-statuses.md) `RUNNING`, вы можете переходить к следующему шагу.

При создании ВМ назначается публичный IP-адрес и имя хоста (FQDN). Эти данные можно использовать для доступа по SSH.

## Создайте кластер БД {{ MY }} {#create-cluster}

Чтобы создать кластер БД {{ MY }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите **{{ ui-key.yacloud.iam.folder.dashboard.value_managed-mysql }}**.
  1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_name }}** введите имя: `wp-mysql-tutorial-db-cluster`.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_resource }}** выберите `s3-c2-m8`.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_disk }}** укажите `10 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_database }}**:
     * В поле **{{ ui-key.yacloud.mdb.forms.database_field_name }}** введите `wp-mysql-tutorial-db`.
     * В поле **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** введите `wordpress`.
     * В поле **{{ ui-key.yacloud.mdb.forms.config_field_password }}** введите пароль, который вы будете использовать для доступа к БД.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network }}** выберите сеть, к которой будет подключен кластер.


  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}** добавьте еще два [хоста](../../managed-mysql/concepts/instance-types.md) в других зонах доступности. При создании хостов не включайте для них **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.


  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}** нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}**.

     В поле **default_authentication_plugin** выберите пункт `mysql_native_password` и нажмите кнопку **{{ ui-key.yacloud.component.mdb.settings.popup_settings-submit }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.

{% endlist %}

Создание кластера БД может занять несколько минут.

## Настройте веб-сервер Nginx {#configure-nginx}

{% include [configure-nginx](../_tutorials_includes/wordpress-mysql/configure-nginx.md) %}

## Установите WordPress и дополнительные компоненты {#install-wordpress}

{% include [install-wordpress](../_tutorials_includes/wordpress-mysql/install-wordpress.md) %}

## Завершите настройку WordPress {#configure-wordpress}

{% include [configure-wordpress](../_tutorials_includes/wordpress-mysql/configure-wordpress.md) %}

## Настройте DNS {#configure-dns}

Если у вас есть зарегистрированное доменное имя, воспользуйтесь сервисом {{ dns-name }} для управления доменом.

{% include [configure-a-record-and-cname](../_tutorials_includes/configure-a-record-and-cname.md) %}

## Проверьте работу сайта {#test-site}

{% include [test-site](../_tutorials_includes/wordpress-mysql/test-site.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. [Удалите](../../dns/operations/zone-delete.md) зону DNS.
1. [Удалите](../../managed-mysql/operations/cluster-delete.md) кластер {{ MY }}.
1. [Удалите](../../compute/operations/vm-control/vm-delete.md) ВМ.

Если вы зарезервировали для ВМ статический публичный IP-адрес, [удалите его](../../vpc/operations/address-delete.md).
