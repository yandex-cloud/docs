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

Убедитесь, что в выбранном [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) есть [сеть](../../vpc/concepts/network.md#network) с [подсетями](../../vpc/concepts/network.md#subnet) в [зонах доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-a`, `{{ region-id }}-b` и `{{ region-id }}-d`. Для этого на странице каталога выберите сервис **{{ vpc-name }}**. Если в списке есть сеть — нажмите на нее, чтобы увидеть список подсетей. Если нужных подсетей или сети нет, [создайте их](../../vpc/quickstart.md).

### Необходимые платные ресурсы {#paid-resources}

{% include [joomla-postgresql-paid-resources](../_tutorials_includes/joomla-postgresql-paid-resources.md) %}

## Создайте ВМ для Joomla {#create-vm}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления]({{ link-console-main }}) нажмите кнопку **Создать ресурс** и выберите **Виртуальная машина**.
  1. В поле **Имя** введите имя ВМ — `joomla-pg-tutorial-web`.
  1. Выберите зону доступности, в которой будет находиться ВМ.
  1. В блоке **Выбор образа/загрузочного диска** перейдите на вкладку **{{ marketplace-name }}** и выберите публичный образ [CentOS Stream](/marketplace/products/yc/centos-stream-8).
  1. В блоке **Вычислительные ресурсы**:
     * Выберите [платформу](../../compute/concepts/vm-platforms.md).
     * Укажите необходимое количество vCPU и объем RAM.

     Для функционального тестирования достаточно минимальной конфигурации:
     * **Платформа** — Intel Ice Lake.
     * **Гарантированная доля vCPU** — 20%.
     * **vCPU** — 2.
     * **RAM** — 1 ГБ.
  1. В блоке **Сетевые настройки** выберите, к какой подсети необходимо подключить ВМ при создании.
  1. Укажите данные для доступа на ВМ:
     * В поле **Логин** введите имя пользователя.
     * В поле **SSH-ключ** вставьте содержимое файла открытого ключа.

       Пару ключей для подключения по [SSH](../../glossary/ssh-keygen.md) необходимо создать самостоятельно. Для создания ключей используйте сторонние инструменты, например утилиты `ssh-keygen` в Linux и macOS или [PuTTYgen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) в Windows.
  1. Нажмите кнопку **Создать ВМ**.

  Создание ВМ может занять несколько минут.

  При создании ВМ назначаются IP-адрес и [имя хоста (FQDN)](../../compute/concepts/network.md#hostname). Эти данные можно использовать для доступа по SSH.

{% endlist %}

## Создайте кластер БД {{ PG }} {#create-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице каталога нажмите кнопку **Создать ресурс** и выберите **Кластер {{ PG }}**.
  1. В поле **Имя** введите имя кластера — `joomla-pg-tutorial-db-cluster`.
  1. В разделе **Класс хоста** выберите подходящий вам класс [хоста](../../managed-postgresql/concepts/instance-types.md).
  1. В разделе **Размер хранилища** укажите 10 ГБ.
  1. В разделе **База данных** укажите:
     * **Имя БД** — `joomla-pg-tutorial-db`.
     * **Имя пользователя** — `joomla`.
     * **Пароль** — пароль, который вы будете использовать для доступа к БД.
  1. В списке **Сеть** выберите сеть, к которой подключена ваша ВМ.
  1. В разделе **Хосты** добавьте еще два хоста в других зонах доступности. При создании хостов не включайте для них **Публичный доступ**.
  1. Нажмите кнопку **Создать кластер**.

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

