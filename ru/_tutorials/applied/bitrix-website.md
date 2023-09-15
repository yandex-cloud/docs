---
title: "Сайт на Битрикс – Установка и настройка"
description: "В этом практическом руководстве мы расскажем, как развернуть и настроить сайт на Битрикс (Bitrix) в облаке. 1С-Битрикс — это система управления сайтами и веб-проектами от компании 1С-Битрикс. С его помощью вы можете управлять структурой и содержимым вашего сайта, не обладая специальными знаниями программирования и верстки."
---

# Веб-сайт на базе 1С-Битрикс

[1С-Битрикс: Управление сайтом](https://www.1c-bitrix.ru/products/cms/) — это система управления веб-проектами от компании 1С-Битрикс. С его помощью вы можете достаточно просто управлять структурой и содержимым вашего веб-сайта, не обладая специальными знаниями программирования и верстки. Техническую часть работы за вас выполнит «1С-Битрикс: Управление сайтом».

В этом руководстве вы развернете и настроите веб-сайт, используя шаблон информационного портала на платформе 1С-Битрикс. В процессе настройки вы создадите [виртуальную машину](../../compute/concepts/vm.md) в инфраструктуре {{ yandex-cloud }}, на которой развернете [образ](../../compute/concepts/image.md) платформы 1С-Битрикс и требуемые для нее сервисы. В качестве базы данных вами будет развернут [кластер](../../managed-mysql/concepts/index.md) [{{ mmy-full-name }}](../../managed-mysql/) с возможностью обеспечения его отказоустойчивости.

Используемые ресурсы для правильной работы 1С-Битрикс:
* ВМ на базе [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts) с доступом во внешнюю [сеть](../../vpc/concepts/network.md#network), на которой будет установлен 1С-Битрикс.
* Кластер {{ mmy-name }}, являющийся БД для веб-сайта 1С-Битрикс.

Чтобы развернуть и настроить 1С-Битрикс:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте и настройте облачную сеть](#setup-cloud-net).
1. [Создайте ВМ в облаке](#create-vm).
1. [Создайте кластер БД {{ MY }}](#create-mysql).
1. [Настройте сервер для работы с 1C-Битрикс](#configure-server).
1. [Настройте 1С-Битрикс](#configure-bitrix).

Если сайт вам больше не нужен, [удалите все используемые им ресурсы](#clear-out).


Также инфраструктуру для веб-сайта на Битрикс можно развернуть через {{ TF }} с помощью [готовой конфигурации](#terraform).


## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы

В стоимость поддержки сервера для 1С-Битрикс и БД входит:
* Плата за [диски](../../compute/concepts/disk.md) [{{ compute-full-name }}](../../compute/) и постоянно запущенную ВМ (см. [тарифы {{ compute-name }}](../../compute/pricing.md)).
* Плата за использование динамического или статического [публичного IP-адреса](../../vpc/concepts/address.md#public-addresses) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).
* Плата за использование управляемой БД (см. [тарифы {{ mmy-name }}](../../managed-mysql/pricing.md)).

Для текущего сценария используется пробная версия 1С-Битрикс с ознакомительным периодом в 30 дней. Стоимость электронных версий продукта вы можете уточнить на официальном ресурсе [«1С-Битрикс»](https://www.1c-bitrix.ru).


## Создайте и настройте облачную сеть {#setup-cloud-net}

{% list tabs %}

- Консоль управления

  1. [Создайте сеть](../../vpc/operations/network-create.md) с именем `network-1`. При создании сети отключите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. В сети `network-1` [создайте](../../vpc/operations/subnet-create.md) две [подсети](../../vpc/concepts/network.md#subnet) в разных [зонах доступности](../../overview/concepts/geo-scope.md) со следующими параметрами:
     1. Подсеть в зоне доступности `{{ region-id }}-a`:
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** — `subnet-a`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** — `{{ region-id }}-a`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** — `192.168.0.0/24`.
     1. Подсеть в зоне доступности `{{ region-id }}-b`:
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** — `subnet-b`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** — `{{ region-id }}-b`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** — `192.168.1.0/24`.
  1. В сети `network-1` [создайте группы безопасности](../../vpc/operations/security-group-create.md):
     1. С именем `bitrix-sg-vm` для ВМ в облаке. [Задайте правила](../../vpc/operations/security-group-add-rule.md) для этой [группы безопасности](../../vpc/concepts/security-groups.md) в соответствии с таблицей:

        Направление<br>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
        --- | --- | --- | --- | --- | ---
        Исходящий | `ANY` | `Весь` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}` | `0.0.0.0/0`
        Входящий | `HTTP` | `80` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}` | `0.0.0.0/0`
        Входящий | `EXT-HTTPS` | `443` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}` | `0.0.0.0/0`
        Входящий | `SSH` | `22` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}` | `0.0.0.0/0`

     1. С именем `bitrix-sg` для кластера баз данных {{ MY }}. [Задайте правила](../../vpc/operations/security-group-add-rule.md) для этой группы безопасности в соответствии с таблицей:

        Направление<br>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
        --- | --- | --- | --- | --- | ---
        Исходящий | `ANY` | `Весь` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}` | `0.0.0.0/0`
        Входящий | `EXT-HTTPS` | `3306` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}` | `0.0.0.0/0`

- {{ TF }}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

{% endlist %}

## Создайте ВМ в облаке {#create-vm}

Чтобы создать ВМ:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
  1. В списке сервисов выберите **{{ compute-name }}**.
  1. Нажмите кнопку **Создать ВМ**.
  1. В поле **Имя** введите имя ВМ, например, `bitrixwebsite`.
  1. В поле **Зона доступности** выберите `{{ region-id }}-a`.
  1. В блоке **{{ marketplace-name }}** выберите образ операционной системы [Ubuntu 22.04 lts](/marketplace/products/yc/ubuntu-22-04-lts).
  1. В блоке **Диски** выберите жесткий диск `SSD` размером `24 ГБ`.
  1. В блоке **Вычислительные ресурсы**:
     * Выберите [платформу](../../compute/concepts/vm-platforms.md) ВМ.
     * Для корректной работы системы 1С-Битрикс укажите конфигурацию:
       * **Платформа** — `Intel Ice Lake`.
       * **Гарантированная доля vCPU** — `20%`.
       * **vCPU** — `2`.
       * **RAM** — `4 ГБ`.
  1. В блоке **Сетевые настройки**:
     * В поле **Подсеть** выберите созданную ранее подсеть `subnet-a`.
     * В поле **Публичный адрес** оставьте значение **Автоматически**, чтобы назначить ВМ случайный публичный IP-адрес из пула {{ yandex-cloud }}, или выберите статический адрес из списка, если вы зарезервировали его заранее.
     * В поле **Группы безопасности** выберите группу безопасности `bitrix-sg-vm`.
    1. В блоке **Доступ** укажите данные для доступа к ВМ:
     * В поле **Логин** введите предпочтительное имя пользователя, который будет создан на ВМ, например `ubuntu`.
     * В поле **SSH-ключ** скопируйте ваш открытый [SSH-ключ](../../glossary/ssh-keygen.md). Пару ключей для подключения по SSH необходимо создать [самостоятельно](../../compute/operations/vm-connect/ssh.md).
  1. Нажмите кнопку **Создать ВМ**.

  В процессе работы вам может потребоваться сохранять [снимки диска](../../compute/operations/disk-control/create-snapshot.md) ВМ. Они содержат копию файловой системы ВМ на момент создания снимка.

  Вы можете использовать снимки для различных целей, например:
  * Перенос данных с одного диска на другой — например, на диск в другой зоне доступности.
  * Создание [резервной копии](../../compute/concepts/backups.md) диска перед операциями, которые могут повлечь повреждение данных.
  * Версионирование диска путем [регулярного создания снимков диска](../../compute/operations/disk-control/configure-schedule.md).

- {{ TF }}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

{% endlist %}

## Создайте кластер БД {{ MY }} {#create-mysql}

Чтобы создать кластер {{ mmy-name }}:

{% list tabs %}

- Консоль управления

  1. На странице каталога в [консоли управления]({{ link-console-main }}) выберите сервис **{{ mmy-name }}**.
  1. Нажмите кнопку **Создать ресурс** и выберите пункт **Кластер {{ MY }}**.
  1. В поле **Имя** введите имя кластера, например `Bitrix{{ MY }}`.
  1. В блоке **Класс хоста** выберите `s2.micro`. Данных характеристик хватит для работы системы 1С-Битрикс.
  1. В блоке **Размер хранилища** выберите [тип хранилища](../../managed-mysql/concepts/storage.md) — `network-ssd` размером 10 ГБ.
  1. В блоке **База данных** укажите:
     * **Имя БД**. В этом руководстве оставьте значение по умолчанию `db1`.
     * **Имя пользователя**, которое является логином для подключения к БД. В этом руководстве оставьте значение по умолчанию `user1`.
     * **Пароль**, будет использоваться для доступа системой 1С-Битрикс к БД {{ MY }}, например `p@s$woRd!`.
  1. В блоке **Сетевые настройки**:
     * В поле **Сеть** выберите созданную ранее сеть `network-1`.
     * В поле **Группы безопасности** выберите группу безопасности `bitrix-sg`.
  1. В блоке **Хосты**, при необходимости, поменяйте **Зону доступности**, в которой должна находиться база данных. Для этого нажмите значок ![pencil](../../_assets/pencil.svg) в строке с деталями о хосте. В открывшемся окне выберите нужную зону доступности и нажмите кнопку **Сохранить**.

     Рекомендуется выбрать ту же зону доступности, которую вы выбрали при создании ВМ. Это позволит уменьшить задержку (latency) между ВМ и БД.

     ![Шаг 3](../../_assets/tutorials/bitrix-website/create-mysql-cluster3.png)

  1. Для обеспечения отказоустойчивости вы можете добавить дополнительные хосты для вашей БД. Для этого выберите **Добавить хост** и укажите, в какой зоне доступности он будет размещен.
  1. Остальные поля оставьте без изменений.
  1. Нажмите на кнопку **Создать кластер**.

  Создание кластера БД может занять несколько минут. Проверить доступность созданного кластера вы можете в консоли управления {{ yandex-cloud }}, выбрав сервис **{{ mmy-name }}**. На вкладке **Кластеры** статус кластера должен быть **Running**, состояние **Alive**.


- {{ TF }}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).


{% endlist %}

## Настройте сервер для работы с 1C-Битрикс {#configure-server}

Для настройки сервера для работы с 1С-Битрикс выполните следующие шаги:
1. Войдите на созданную ВМ с помощью [SSH](../../compute/operations/vm-connect/ssh.md).

   ```bash
   ssh ubuntu@<публичный_IP-адрес_ВМ>
   ```

   Где `ubuntu` — имя пользователя в поле **Логин**, которое вы указывали при [создании ВМ](#create-vm).

   Чтобы узнать публичный IP-адрес вашей ВМ на странице каталога в [консоли управления]({{ link-console-main }}):
   1. Выберите блок **{{ compute-name }}**.
   1. Нажмите на имя вашей ВМ (в данном примере — **bitrixwebsite**).
   1. Откроется окно с общей информацией о вашей ВМ. Публичный IP-адрес вы можете найти в блоке **Сеть**, в поле **Публичный IPv4**.
1. Установите необходимое программное обеспечение:

   ```bash
   sudo apt-get update
   sudo apt-get install -y apache2 libapache2-mod-php php-gd php-mbstring php-mysql
   ```

1. Перейдите в рабочий каталог проекта и скачайте дистрибутив «1С-Битрикс: Управление сайтом»:

   ```bash
   cd /var/www/html/
   sudo wget https://www.1c-bitrix.ru/download/standard_encode.tar.gz
   ```

1. Распакуйте полученный архив и после этого удалите ненужные файлы:

   ```bash
   sudo tar -zxf standard_encode.tar.gz
   sudo rm -f index.html standard_encode.tar.gz
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
   total 76
   drwxrwxr-x 6 www-data www-data  4096 May 15 13:50 bitrix
   -rwxrwxr-x 1 www-data www-data  1378 May 15 13:50 index.php
   -rwxrwxr-x 1 www-data www-data   150 Mar 11  2013 install.config
   -rwxrwxr-x 1 www-data www-data 30741 Apr 10 14:36 license.html
   -rwxrwxr-x 1 www-data www-data   113 Nov 20  2012 license.php
   -rwxrwxr-x 1 www-data www-data 14054 Feb  6  2017 readme.html
   -rwxrwxr-x 1 www-data www-data   112 Mar 27  2013 readme.php
   drwxrwxr-x 2 www-data www-data  4096 May 15 13:50 upload
   -rwxrwxr-x 1 www-data www-data   691 Oct 27  2009 web.config
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

   1. Добавьте после строки `DocumentRoot /var/www/html` следующий блок:

      ```html
      <Directory /var/www/html>
      Options Indexes FollowSymLinks
      AllowOverride All
      Require all granted
      </Directory>
      ```

   1. Перезапустите веб-сервер, чтобы все измененные настройки применились.

      ```bash
      sudo service apache2 restart
      ```

После выполнения этих команд серверная часть будет сконфигурирована для корректной работы 1С-Битрикс.

## Настройте 1С-Битрикс {#configure-bitrix}

Установите и настройте 1С-Битрикс:
1. Откройте веб-интерфейс 1С-Битрикс: Управление сайтом — перейдите по адресу `http://<публичный_IP-адрес_ВМ>/`. Должна открыться страница с приглашением установить 1С-Битрикс.
1. Нажмите кнопку **Далее**.

   ![Шаг 1](../../_assets/tutorials/bitrix-website/bitrix-website1.png)

1. Ознакомьтесь с лицензионным соглашением и выберите **Я принимаю лицензионное соглашение**. Затем нажмите кнопку **Далее**.

   ![Шаг 2](../../_assets/tutorials/bitrix-website/bitrix-website2.png)

1. Регистрация необязательна, поэтому уберите соответствующую галочку, но оставьте **Установить в кодировке UTF-8** и нажмите кнопку **Далее**.

   ![Шаг 3](../../_assets/tutorials/bitrix-website/bitrix-website3.png)

1. Система проверит, верно ли сконфигурирован сервер. Просмотрите все параметры на данной странице и нажмите кнопку **Далее**.

   ![Шаг 4](../../_assets/tutorials/bitrix-website/bitrix-website6.png)

1. Укажите параметры созданной БД:
   1. В поле **Сервер** укажите полное доменное имя созданной вами БД. Чтобы его узнать:
      1. В [консоли управления]({{ link-console-main }}) перейдите в новой вкладке браузера на страницу каталога.
      1. Выберите раздел **{{ mmy-name }}**.
      1. В таблице выберите созданный ранее кластер `BitrixMySQL`.
      1. В меню слева выберите вкладку **Хосты**.
      1. Подведите курсор к **Имени хоста** (вида `rc1c-cfazv1db********`) и скопируйте полное доменное имя базы данных, нажав появившийся значок ![copy](../../_assets/copy.svg). К имени хоста добавится полное доменное имя, в результате в поле **Сервер** должно быть указано имя вида `rc1c-cfazv1db********.{{ dns-zone }}`.
   1. В полях **Имя пользователя** и **Пароль** укажите данные, с которыми вы создавали БД в разделе [Создайте кластер БД {{ MY }}](#create-mysql).
   1. В поле **Имя базы данных** укажите имя созданной БД (`db1`).
   1. Нажмите кнопку **Далее**.

   ![Шаг 6](../../_assets/tutorials/bitrix-website/bitrix-website7.png)

1. Дождитесь инициализации БД {{ MY }}.

   ![Шаг 7](../../_assets/tutorials/bitrix-website/bitrix-website8.png)

1. Создайте аккаунт администратора, который сможет вносить изменения в вашу систему. Заполните все поля и нажмите кнопку **Далее**.

   ![Шаг 8](../../_assets/tutorials/bitrix-website/bitrix-website9.png)

1. Выберите шаблон **Информационный портал** и нажмите кнопку **Далее**.

   ![Шаг 9](../../_assets/tutorials/bitrix-website/bitrix-website10.png)

1. Подтвердите выбор единственного шаблона оформления, нажав кнопку **Далее**.

   ![Шаг 10](../../_assets/tutorials/bitrix-website/bitrix-website11.png)

1. Выберите цветовое оформление и нажмите кнопку **Далее**.

   ![Шаг 11](../../_assets/tutorials/bitrix-website/bitrix-website12.png)

1. Заполните все поля в соответствии с требованиями к веб-сайту и нажмите кнопку **Установить**. Начнется установка и настройка всех компонентов системы. Дождитесь ее окончания.

   ![Шаг 12](../../_assets/tutorials/bitrix-website/bitrix-website13.png)

1. Через некоторое время появится страница, уведомляющая о том, что система установлена и настроена. Для начала работы с веб-сайтом нажмите кнопку **Перейти на сайт**.

   ![Шаг 13](../../_assets/tutorials/bitrix-website/bitrix-website15.png)

1. Вы попали в веб-интерфейс полностью готовой для дальнейшей эксплуатации системы и находитесь в режиме редактирования содержимого.

   ![Шаг 14](../../_assets/tutorials/bitrix-website/bitrix-website16.png)

1. Чтобы увидеть главную страницу сайта глазами пользователя, нажмите **Выйти** из панели администрирования вашим сайтом, в правом верхнем углу страницы, затем перейдите по адресу `http://<публичный_IP-адрес_ВМ>/`. Чтобы вернуться обратно в режим редактирования, авторизуйтесь на сайте с теми учетными данными, которые вы указали для администратора 1С-Битрикс.

   ![Шаг 15](../../_assets/tutorials/bitrix-website/bitrix-website17.png)

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за развернутый сервер:
1. [Удалите ВМ](../../compute/operations/vm-control/vm-delete.md) `bitrixwebsite`.

   Если вы зарезервировали статический публичный IP-адрес специально для этой ВМ:
   1. Выберите сервис **{{ vpc-name }}** в вашем каталоге.
   1. Перейдите на вкладку **IP-адреса**.
   1. Найдите нужный IP-адрес, нажмите значок ![ellipsis](../../_assets/options.svg) и выберите пункт **Удалить**.
1. [Удалите кластер БД](../../managed-mysql/operations/cluster-delete.md) `Bitrix{{ MY }}`.


## Как создать инфраструктуру с помощью {{ TF }} {#terraform}

{% include [terraform-definition](../terraform-definition.md) %}

Чтобы разместить веб-сайт на Битрикс с помощью {{ TF }}:
1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

   {% list tabs %}

   - Готовая конфигурация
 
     1. Склонируйте репозиторий с конфигурационными файлами.

         ```bash
         git clone https://github.com/yandex-cloud-examples/yc-terraform-bitrix-website.git
         ```

     1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
         * `bitrix-website.tf` — конфигурация создаваемой инфраструктуры;
         * `bitrix-website.auto.tfvars` — файл с пользовательскими данными.

         {% include [sg-note-tf](../../_includes/vpc/sg-note-tf.md) %}

   - Создание вручную

     1. Создайте папку для конфигурационных файлов.

     1. Создайте в папке:
   
         1. Конфигурационный файл `bitrix-website.tf`:

             {% include [sg-note-tf](../../_includes/vpc/sg-note-tf.md) %}

             {% cut "bitrix-website.tf" %}

             {% include [bitrix-tf-config](../../_includes/web/bitrix-tf-config.md) %}

             {% endcut %}

         1. Файл с пользовательскими данными `bitrix-website.auto.tfvars`:

             {% cut "bitrix-website.auto.tfvars" %}

             ```hcl
             folder_id      = "<идентификатор_каталога>"
             vm_user        = "<имя_пользователя_ВМ>"
             ssh_key_path   = "<путь_к_файлу_с_открытым_SSH-ключом>"
             mysql_user     = "<имя_пользователя_БД>"
             mysql_password = "<пароль_пользователя_БД>"
             ```

             {% endcut %}

   {% endlist %}

   Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:
   * [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network)
   * [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet)
   * [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group)
   * [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance)
   * [yandex_mdb_mysql_cluster]({{ tf-provider-resources-link }}/mdb_mysql_cluster)
   * [yandex_mdb_mysql_database]({{ tf-provider-resources-link }}/mdb_mysql_database)
   * [yandex_mdb_mysql_user]({{ tf-provider-resources-link }}/mdb_mysql_user)

1. В файле `bitrix-website.auto.tfvars` задайте пользовательские параметры:
    * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
    * `vm_user` — имя пользователя ВМ.
    * `ssh_key_path` — путь к файлу с открытым SSH-ключом для аутентификации пользователя на ВМ. Подробнее см. [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
    * `mysql_user` — имя пользователя для подключения к БД {{ MY }}. В этом руководстве укажите `user1`.
    * `mysql_password` — пароль пользователя для доступа к БД {{ MY }}. В этом руководстве укажите значение `p@s$woRd!`.

1. Создайте ресурсы:

   {% include [terraform-validate-plan-apply](../terraform-validate-plan-apply.md) %}

1. [Настройте сервер для работы с 1C-Битрикс](#configure-server).

1. [Настройте 1С-Битрикс](#configure-bitrix).

