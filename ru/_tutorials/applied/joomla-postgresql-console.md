1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте ВМ для Joomla](#create-vm).
1. [Создайте кластер БД {{ PG }}](#create-cluster).
1. [Установите Joomla и дополнительные компоненты](#install).
1. [Настройте веб-сервер Apache2](#configure-apache2).
1. [Настройте Joomla](#configure-joomla).
1. [Загрузите файлы веб-сайта](#upload-files).
1. [Настройте DNS](#configure-dns).
1. [Проверьте работу сайта](#test-site).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

Убедитесь, что в выбранном [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) есть [сеть](../../vpc/concepts/network.md#network) с [подсетями](../../vpc/concepts/network.md#subnet) в [зонах доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-a`, `{{ region-id }}-b` и `{{ region-id }}-d`. Для этого на странице каталога выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**. Если в списке есть сеть — нажмите на нее, чтобы увидеть список подсетей. Если нужных подсетей или сети нет, [создайте их](../../vpc/quickstart.md).

### Необходимые платные ресурсы {#paid-resources}

{% include [joomla-postgresql-paid-resources](../_tutorials_includes/joomla-postgresql-paid-resources.md) %}

## Создайте ВМ для Joomla {#create-vm}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления]({{ link-console-main }}) нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** введите имя ВМ — `joomla-pg-tutorial-web`.
  1. Выберите зону доступности, в которой будет находиться ВМ.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** и выберите публичный образ [CentOS Stream](/marketplace/products/yc/centos-stream-8).
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** на вкладке **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}**:
     * Выберите [платформу](../../compute/concepts/vm-platforms.md).
     * Укажите необходимое количество vCPU и объем RAM.

     Для функционального тестирования достаточно минимальной конфигурации:
     * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Ice Lake`.
     * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `2`.
     * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `20%`.
     * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `1 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}** выберите, к какой подсети необходимо подключить ВМ при создании.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа на ВМ:
     * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.
     * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла открытого ключа.

       Пару ключей для подключения по [SSH](../../glossary/ssh-keygen.md) необходимо создать самостоятельно. Для создания ключей используйте сторонние инструменты, например утилиты `ssh-keygen` в Linux и macOS или [PuTTYgen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) в Windows.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  Создание ВМ может занять несколько минут.

  При создании ВМ назначаются IP-адрес и [имя хоста (FQDN)](../../compute/concepts/network.md#hostname). Эти данные можно использовать для доступа по SSH.

{% endlist %}

## Создайте кластер БД {{ PG }} {#create-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице каталога нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите **{{ ui-key.yacloud.iam.folder.dashboard.value_managed-postgresql }}**.
  1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_name }}** введите имя кластера — `joomla-pg-tutorial-db-cluster`.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_resource }}** выберите подходящий вам класс [хоста](../../managed-postgresql/concepts/instance-types.md).
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_disk }}** укажите `10 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_database }}** укажите:
     * **{{ ui-key.yacloud.mdb.forms.database_field_name }}** — `joomla-pg-tutorial-db`.
     * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** — `joomla`.
     * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}** — пароль, который вы будете использовать для доступа к БД.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}** выберите сеть, к которой подключена ваша ВМ.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}** добавьте еще два хоста в других зонах доступности. При создании хостов не включайте для них **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.

  Создание кластера БД может занять несколько минут.

{% endlist %}

## Установите Joomla и дополнительные компоненты {#install}

{% include [joomla-postgresql-install](../_tutorials_includes/joomla-postgresql-install.md) %}

## Настройте веб-сервер Apache2 {#configure-apache2}

{% include [joomla-postgresql-configure-apache2](../_tutorials_includes/joomla-postgresql-configure-apache2.md) %}

## Настройте Joomla {#configure-joomla}

{% include [joomla-postgresql-configure-joomla](../_tutorials_includes/joomla-postgresql-configure-joomla.md) %}

## Загрузите файлы веб-сайта {#upload-files}

{% include [joomla-postgresql-upload-files.md](../_tutorials_includes/joomla-postgresql-upload-files.md) %}

## Настройте DNS {#configure-dns}

Доменное имя, которое вы хотите использовать для веб-сайта, нужно связать с IP-адресом созданной ВМ `joomla-pg-tutorial-web`. Для управления доменом можно использовать сервис [{{ dns-full-name }}](../../dns/).

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [configure-a-record-and-cname](../../_tutorials/_tutorials_includes/configure-a-record-and-cname.md) %}

{% endlist %}

## Проверьте работу сайта {#test-site}

{% include [joomla-postgresql-test-site](../_tutorials_includes/joomla-postgresql-test-site.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
* [Удалите](../../compute/operations/vm-control/vm-delete.md) ВМ.
* [Удалите](../../vpc/operations/address-delete.md) статический публичный IP-адрес, если вы его зарезервировали.
* [Удалите](../../managed-postgresql/operations/cluster-delete.md) кластер {{ mpg-name }}.
* Если вы использовали {{ dns-name }}, то [удалите](../../dns/operations/resource-record-delete.md) DNS-записи и [удалите](../../dns/operations/zone-delete.md) DNS-зону.

