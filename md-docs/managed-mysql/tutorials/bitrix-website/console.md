# Создание сайта на базе «1С-Битрикс» с помощью консоли управления

Чтобы создать инфраструктуру для [сайта на базе «1С-Битрикс»](index.md) c помощью консоли управления {{ yandex-cloud }}:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте и настройте облачную сеть](#create-network).
1. [Создайте ВМ в облаке](#create-vm).
1. [Создайте кластер БД {{ MY }}](#create-mysql).
1. [Настройте сервер для работы с «1C-Битрикс»](#configure-server).
1. [Настройте «1С-Битрикс»](#configure-bitrix).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

* Виртуальная машина: использование вычислительных ресурсов, хранилища, публичного IP-адреса и операционной системы (см. [тарифы {{ compute-name }}](../../../compute/pricing.md)).

* Кластер {{ mmy-name }}: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий (см. [тарифы {{ mmy-name }}](../../pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ (см. [тарифы {{ vpc-name }}](../../../vpc/pricing.md)).

Для данного руководства используется пробная версия «1С-Битрикс» с ознакомительным периодом в 30 дней. Стоимость электронных версий продукта вы можете уточнить на официальном ресурсе [«1С-Битрикс»](https://www.1c-bitrix.ru).

## Создайте и настройте облачную сеть {#create-network}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Создайте сеть](../../../vpc/operations/network-create.md) с именем `network-1`. При создании сети отключите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. В сети `network-1` [создайте](../../../vpc/operations/subnet-create.md) две [подсети](../../../vpc/concepts/network.md#subnet) в разных [зонах доступности](../../../overview/concepts/geo-scope.md) со следующими параметрами:
     1. Подсеть в зоне доступности `{{ region-id }}-a`:
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** — `subnet-a`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** — `{{ region-id }}-a`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** — `192.168.0.0/24`.
     1. Подсеть в зоне доступности `{{ region-id }}-b`:
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** — `subnet-b`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** — `{{ region-id }}-b`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** — `192.168.1.0/24`.
  1. В сети `network-1` [создайте группы безопасности](../../../vpc/operations/security-group-create.md):
     1. С именем `bitrix-sg-vm` для ВМ в облаке. [Задайте правила](../../../vpc/operations/security-group-add-rule.md) для этой [группы безопасности](../../../vpc/concepts/security-groups.md) в соответствии с таблицей:

        Направление<br>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
        --- | --- | --- | --- | --- | ---
        Исходящий | `ANY` | `Весь` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}` | `0.0.0.0/0`
        Входящий | `HTTP` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}` | `0.0.0.0/0`
        Входящий | `EXT-HTTPS` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}` | `0.0.0.0/0`
        Входящий | `SSH` | `22` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}` | `0.0.0.0/0`

     1. С именем `bitrix-sg` для кластера баз данных {{ MY }}. [Задайте правила](../../../vpc/operations/security-group-add-rule.md) для этой группы безопасности в соответствии с таблицей:

        Направление<br>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
        --- | --- | --- | --- | --- | ---
        Исходящий | `ANY` | `Весь` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}` | `0.0.0.0/0`
        Входящий | `EXT-HTTPS` | `3306` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}` | `0.0.0.0/0`

{% endlist %}

## Создайте ВМ в облаке {#create-vm}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления]({{ link-console-main }}) нажмите кнопку ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите пункт `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** в поле **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** введите `Ubuntu 22.04 LTS` и выберите публичный образ [Ubuntu 22.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-22-04-lts).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../../overview/concepts/geo-scope.md): `{{ region-id }}-a`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** выберите [тип диска](../../../compute/concepts/disk.md#disks_types) `{{ ui-key.yacloud.compute.value_disk-type-network-ssd_4Mmub }}` и задайте размер `24 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** перейдите на вкладку `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` и укажите необходимую [платформу](../../../compute/concepts/vm-platforms.md), количество vCPU и объем RAM:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Ice Lake`.
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `2`.
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `20%`.
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `4 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите сеть `network-1` и подсеть `subnet-a`.
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** оставьте значение `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`, чтобы назначить ВМ случайный публичный IP-адрес из пула {{ yandex-cloud }}, или выберите статический адрес из списка, если вы зарезервировали его заранее.
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** выберите группу безопасности `bitrix-sg-vm`.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа на ВМ:

      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя, например: `ubuntu`. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
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

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `bitrixwebsite`.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  В процессе работы вам может потребоваться сохранять [снимки диска](../../../compute/operations/disk-control/create-snapshot.md) ВМ. Они содержат копию файловой системы ВМ на момент создания снимка.

  Вы можете использовать снимки для различных целей, например:
  * Перенос данных с одного диска на другой — например, на диск в другой зоне доступности.
  * Создание [резервной копии](../../../compute/concepts/backups.md) диска перед операциями, которые могут повлечь повреждение данных.
  * Версионирование диска путем [регулярного создания снимков диска](../../../compute/operations/disk-control/configure-schedule.md).

{% endlist %}

## Создайте кластер БД {{ MY }} {#create-mysql}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите пункт **{{ ui-key.yacloud.iam.folder.dashboard.value_managed-mysql }}**.
  1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_name }}** введите имя кластера, например `Bitrix{{ MY }}`.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_resource }}** выберите `s3-c2-m8`. Данных характеристик хватит для работы системы «1С-Битрикс».
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_disk }}** выберите [тип хранилища](../../concepts/storage.md) — `network-ssd` и укажите размер `10 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_database }}** укажите:
     * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**. В этом руководстве оставьте значение по умолчанию `db1`.
     * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**, которое является логином для подключения к БД. В этом руководстве оставьте значение по умолчанию `user1`.
     * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**, будет использоваться для доступа системой «1С-Битрикс» к БД {{ MY }}, например `p@s$woRd!`.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network }}**:
     * В поле **{{ ui-key.yacloud.mdb.forms.label_network }}** выберите созданную ранее сеть `network-1`.
     * В поле **{{ ui-key.yacloud.mdb.forms.field_security-group }}** выберите группу безопасности `bitrix-sg`.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}**, при необходимости, поменяйте зону доступности, в которой должна находиться база данных. Для этого нажмите значок ![pencil](../../../_assets/console-icons/pencil.svg) в строке с информацией о хосте. В открывшемся окне выберите нужную зону доступности и нажмите кнопку **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

     Рекомендуется выбрать ту же зону доступности, которую вы выбрали при создании ВМ. Это позволит уменьшить задержку (latency) между ВМ и БД.

  1. Для обеспечения отказоустойчивости вы можете добавить дополнительные хосты для вашей БД. Для этого нажмите **{{ ui-key.yacloud.mdb.forms.button_add-host }}** и укажите, в какой зоне доступности он будет размещен.
  1. Остальные поля оставьте без изменений.
  1. Нажмите на кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.

  Создание кластера БД может занять несколько минут. Проверить доступность созданного кластера вы можете в консоли управления {{ yandex-cloud }}, выбрав сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**. На вкладке **{{ ui-key.yacloud.mysql.switch_list }}** статус кластера должен быть `Running`, состояние `Alive`.

{% endlist %}

## Настройте сервер для работы с «1C-Битрикс» {#configure-server}

Для настройки сервера для работы с «1С-Битрикс» выполните следующие шаги:
1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md) к ВМ по SSH от имени пользователя, заданного при [создании ВМ](#create-vm) (например, `ubuntu`):

   ```bash
   ssh ubuntu@<публичный_IP-адрес_ВМ>
   ```

   Публичный IP-адрес ВМ можно узнать в [консоли управления]({{ link-console-main }}) в поле **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}** блока **{{ ui-key.yacloud.compute.instance.overview.section_network }}** на странице ВМ.

1. Установите необходимое программное обеспечение:

   {% note info %}

   Следующие команды установки предназначены для Ubuntu. Для других дистрибутивов используйте команды вашего менеджера пакетов.

   {% endnote %}

   ```bash
   sudo apt-get update
   sudo apt-get install -y apache2 libapache2-mod-php php-gd php-mbstring php-mysql
   ```

1. Перейдите в рабочий каталог проекта и скачайте дистрибутив «1С-Битрикс: Управление сайтом»:

   ```bash
   cd /var/www/html/
   sudo wget https://www.1c-bitrix.ru/download/business_encode.tar.gz
   ```

1. Распакуйте полученный архив и после этого удалите ненужные файлы:

   ```bash
   sudo tar -zxf business_encode.tar.gz
   sudo rm -f index.html business_encode.tar.gz
   ```

1. Назначьте пользователя `www-data` владельцем рабочего каталога проекта:

   ```bash
   sudo chown -R www-data:www-data /var/www/html
   ```

   Проверьте права и владельцев рабочего каталога:

   ```bash
   ls -l
   ```

   Результат:

   ```text
   total 40
   drwxrwxr-x 7 www-data www-data  4096 Jun  8  2023 bitrix
   -rwxrwxr-x 1 www-data www-data  1150 Nov 30  2020 favicon.ico
   -rwxrwxr-x 1 www-data www-data  1353 Jun  8  2023 index.php
   -rwxrwxr-x 1 www-data www-data   268 Apr 17  2023 install.config
   -rwxrwxr-x 1 www-data www-data 12821 Mar 18  2022 readme.html
   -rwxrwxr-x 1 www-data www-data   112 Mar 27  2013 readme.php
   drwxrwxr-x 2 www-data www-data  4096 Jun  8  2023 upload
   ```

1. Для корректной работы 1С настройте параметры PHP. Для этого воспользуйтесь встроенным редактором `nano` и отредактируйте следующие переменные в файле конфигурации `php.ini`:

   ```bash
   sudo nano /etc/php/8.1/apache2/php.ini
   ```

   Было | Стало
   :--- | :---
   `short_open_tag = Off` | `short_open_tag = On`
   `memory_limit = 128M` | `memory_limit = 256M`
   `;date.timezone =` | `date.timezone = Europe/Moscow`
   `;opcache.revalidate_freq =2` | `opcache.revalidate_freq =0`
   `;session.save_path = "/var/lib/php/sessions"` | `session.save_path = "/var/lib/php/sessions"`

   Путь к файлу `php.ini` зависит от установленной версии PHP. В примере приведен путь для версии `8.1`. Для версии `8.0` введите `/etc/php/8.0/apache2/php.ini`, для версии `8.2` — `/etc/php/8.2/apache2/php.ini` и т. д.

   {% note tip %}

   Чтобы найти нужный параметр в редакторе `nano` нажмите сочетание клавиш **Ctrl** + **W**. Найдите требуемый параметр из таблицы выше, далее сохраните изменения при помощи сочетания клавиш **Ctrl** + **O**. Выход из редактора **Ctrl** + **X**.

   {% endnote %}

1. Настройте веб-сервер Apache. Для этого отредактируйте файл конфигурации `/etc/apache2/sites-enabled/000-default.conf`.
   1. Откройте файл в текстовом редакторе:

      ```bash
      sudo nano /etc/apache2/sites-enabled/000-default.conf
      ```

   1. После строки `DocumentRoot /var/www/html` добавьте следующий блок и сохраните изменения:

      ```html
      <Directory /var/www/html>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
      </Directory>
      ```

   1. Перезапустите веб-сервер, чтобы все измененные настройки применились:

      ```bash
      sudo systemctl restart apache2
      ```

После выполнения этих команд серверная часть будет сконфигурирована для корректной работы 1С-Битрикс.

## Настройте «1С-Битрикс» {#configure-bitrix}

Установите и настройте «1С-Битрикс»:
1. Откройте веб-интерфейс «1С-Битрикс: Управление сайтом». Для этого в браузере перейдите по адресу `http://<публичный_IP-адрес_ВМ>/`. Должна открыться страница с приглашением установить «1С-Битрикс».
1. Нажмите кнопку **Далее**.

   ![Шаг 1](../../../_assets/tutorials/bitrix-website/bitrix-website1.png)

1. Ознакомьтесь с лицензионным соглашением и выберите **Я принимаю лицензионное соглашение**. Затем нажмите кнопку **Далее**.

   ![Шаг 2](../../../_assets/tutorials/bitrix-website/bitrix-website2.png)

1. Регистрация необязательна, поэтому уберите соответствующую галочку, но оставьте **Установить в кодировке UTF-8** и нажмите кнопку **Далее**.

   ![Шаг 3](../../../_assets/tutorials/bitrix-website/bitrix-website3.png)

1. Система проверит, верно ли сконфигурирован сервер. Просмотрите все параметры на данной странице и нажмите кнопку **Далее**.

   ![Шаг 4](../../../_assets/tutorials/bitrix-website/bitrix-website6.png)

1. Настройте БД:
   1. В поле **Сервер** укажите полное доменное имя созданной вами БД. Чтобы его узнать:
      1. В [консоли управления]({{ link-console-main }}) перейдите в новой вкладке браузера на страницу каталога.
      1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
      1. В открывшемся окне выберите созданный ранее кластер `BitrixMySQL`.
      1. В меню слева выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}**.
      1. В поле **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** подведите курсор к имени хоста (вида `rc1c-cfazv1db********`) и скопируйте полное доменное имя базы данных, нажав появившийся значок ![copy](../../../_assets/copy.svg). К имени хоста добавится полное доменное имя, в результате в поле **Сервер** должно быть указано имя вида `rc1c-cfazv1db********.{{ dns-zone }}`.
   1. В полях **Имя пользователя** и **Пароль** укажите данные, с которыми вы создавали БД в разделе [Создайте кластер БД {{ MY }}](#create-mysql).
   1. В поле **Имя базы данных** укажите имя созданной БД (`db1`).
   1. Нажмите кнопку **Далее**.

   ![Шаг 5](../../../_assets/tutorials/bitrix-website/bitrix-website7.png)

1. Дождитесь инициализации БД {{ MY }}.

   ![Шаг 6](../../../_assets/tutorials/bitrix-website/bitrix-website8.png)

1. Создайте аккаунт администратора, который сможет вносить изменения в вашу систему. Заполните все поля и нажмите кнопку **Далее**.

   ![Шаг 7](../../../_assets/tutorials/bitrix-website/bitrix-website9.png)

1. Выберите шаблон **Информационный портал** и нажмите кнопку **Далее**.

   ![Шаг 8](../../../_assets/tutorials/bitrix-website/bitrix-website10.png)

1. Подтвердите выбор единственного шаблона оформления, нажав кнопку **Далее**.

   ![Шаг 9](../../../_assets/tutorials/bitrix-website/bitrix-website11.png)

1. Выберите цветовое оформление и нажмите кнопку **Далее**.

   ![Шаг 10](../../../_assets/tutorials/bitrix-website/bitrix-website12.png)

1. Заполните все поля в соответствии с требованиями к сайту и нажмите кнопку **Установить**. Начнется установка и настройка всех компонентов системы. Дождитесь ее окончания.

   ![Шаг 11](../../../_assets/tutorials/bitrix-website/bitrix-website13.png)

1. Через некоторое время появится страница, уведомляющая о том, что система установлена и настроена. Для начала работы с сайтом нажмите кнопку **Перейти на сайт**.

   ![Шаг 12](../../../_assets/tutorials/bitrix-website/bitrix-website15.png)

1. Вы открыли веб-интерфейс полностью готовой для дальнейшей эксплуатации системы в режиме редактирования содержимого.

   ![Шаг 13](../../../_assets/tutorials/bitrix-website/bitrix-website16.png)

1. Чтобы увидеть главную страницу сайта глазами пользователя, выйдите из режима администрирования вашим сайтом. Для этого в правом верхнем углу страницы нажмите **Выйти**, затем перейдите по адресу `http://<публичный_IP-адрес_ВМ>/`.
   Чтобы вернуться в режим редактирования, авторизуйтесь на сайте с учетными данными администратора, которые вы указали при настройке «1С-Битрикс».

   ![Шаг 14](../../../_assets/tutorials/bitrix-website/bitrix-website17.png)

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. [Удалите](../../../compute/operations/vm-control/vm-delete.md) ВМ `bitrixwebsite`.
1. [Удалите](../../operations/cluster-delete.md) кластер БД `Bitrix{{ MY }}`.

Если вы зарезервировали статический публичный IP-адрес специально для этой ВМ:
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}** в вашем каталоге.
1. Перейдите на вкладку **{{ ui-key.yacloud.vpc.switch_addresses }}**.
1. Найдите нужный IP-адрес, нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.common.delete }}**.

#### См. также {#see-also}

* [{#T}](terraform.md).