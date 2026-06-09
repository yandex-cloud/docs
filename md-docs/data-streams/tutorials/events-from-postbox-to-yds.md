# Передача событий {{ postbox-full-name }} в {{ yds-full-name }} и их анализ с помощью {{ datalens-full-name }}


В этом руководстве вы настроите передачу событий [{{ postbox-full-name }}](../../postbox/index.md) в [{{ yds-full-name }}](../index.md) и визуализацию этих событий с помощью [{{ datalens-full-name }}](../../datalens/index.md) для последующего анализа. Источник событий — отправка электронных писем.

Реализовать предлагаемое решение можно с помощью [консоли управления]({{ link-console-main }}) {{ yandex-cloud }}, даже не имея навыков разработки. Для обработки и хранения данных будут использоваться сервисы [{{ sf-full-name }}](../../functions/index.md) и [{{ ydb-full-name }}](../../ydb/index.md).

Чтобы настроить передачу событий и их визуализацию:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте сервисные аккаунты](#service-accounts).
1. [Создайте статический ключ доступа](#static-key).
1. [Настройте базу данных {{ ydb-name }}](#ydb).
1. [Создайте поток данных {{ yds-name }}](#stream).
1. [Подготовьте ресурсы {{ postbox-name }}](#postbox).
1. [Подготовьте ресурсы {{ sf-name }}](#serverless-functions).
1. [Отправьте письма](#send-letters).
1. [Настройте визуализацию в {{ datalens-name }}](#datalens).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за операции с {{ ydb-short-name }} и хранение данных (см. [тарифы {{ ydb-full-name }}](../../ydb/pricing/serverless.md));
* плата за хранение данных {{ yds-short-name }} (см. [тарифы {{ yds-full-name }}](../pricing.md));
* плата за количество вызовов функции, вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик (см. [тарифы {{ sf-name }}](../../functions/pricing.md));
* плата за использование {{ postbox-full-name }} (см. [тарифы {{ postbox-name }}](../../postbox/pricing.md));
* плата за тариф {{ datalens-short-name }} (см. [тарифы {{ datalens-full-name }}](../../datalens/pricing.md)).


## Создайте сервисные аккаунты {#service-accounts}

Создайте два [сервисных аккаунта](../../iam/concepts/users/service-accounts.md):

* `yds-functions` — от его имени будет вызываться [функция](../../functions/concepts/function.md) {{ sf-name }} и будут записываться данные в [базу данных](../../ydb/concepts/resources.md#database) {{ ydb-short-name }};
* `postbox-user` — от его имени будут отправляться письма через {{ postbox-name }}.

1. Создайте сервисный аккаунт `yds-functions`:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы будете создавать инфраструктуру.
      1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}** и нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. В поле **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** укажите имя `yds-functions`.
      1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите [роли](../../iam/concepts/access-control/roles.md) `yds.editor` и `{{ roles-functions-invoker }}`.
      1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

    {% endlist %}

1. Аналогичным образом создайте сервисный аккаунт `postbox-user` и назначьте ему [роль](../../postbox/security/index.md#postbox-sender) `postbox.sender`.

## Создайте статический ключ доступа {#static-key}

Создайте [статический ключ доступа](../../iam/concepts/authorization/access-key.md), который будет использоваться для отправки писем:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}** и в списке сервисных аккаунтов выберите `postbox-user`. В открывшемся окне:

      1. На панели сверху нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
      1. Сохраните идентификатор и секретный ключ.

          {% note alert %}

          После закрытия диалога значение ключа будет недоступно.

          {% endnote %}

{% endlist %}


## Настройте базу данных {{ ydb-name }} {#ydb}

В качестве хранилища событий может использоваться любая подходящая для задач аналитики СУБД. В данном руководстве используется [бессерверная база данных](../../ydb/concepts/resources.md#serverless) {{ ydb-name }}. Для других СУБД SQL-запрос создания таблицы и код функции загрузки событий в нее могут отличаться.


### Создайте базу данных {#create-db}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}** и нажмите кнопку **{{ ui-key.yacloud.ydb.databases.button_create }}**.
  1. В поле **{{ ui-key.yacloud.ydb.forms.label_field_name }}** укажите `postbox-events-ydb`.
  1. В поле **{{ ui-key.yacloud.ydb.forms.label_field_database-type }}** выберите `{{ ui-key.yacloud.ydb.forms.label_serverless-type_pB7Wx }}`.
  1. Другие параметры базы данных оставьте без изменений и нажмите кнопку **{{ ui-key.yacloud.ydb.forms.button_create-database }}**.

  Дождитесь запуска БД. В процессе создания база данных будет находиться в статусе `Provisioning`, а когда станет готова к использованию, ее статус изменится на `Running`.

{% endlist %}


### Создайте таблицу {#create-table}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице **{{ ui-key.yacloud.ydb.databases.label_title }}** выберите вновь созданную БД `postbox-events-ydb`.
  1. Чтобы открыть корневую директорию БД, перейдите на вкладку ![image](../../_assets/console-icons/folder.svg) **{{ ui-key.yacloud.ydb.database.switch_browse }}**.
  1. Чтобы создать запрос к БД, в правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.ydb.browse.button_sql-query }}**.
  1. В открывшемся поле **{{ ui-key.yacloud.ydb.sql.label_query }}** введите:

      ```sql
      CREATE TABLE postbox_events
      (
          saved_datetime Datetime NOT NULL,
          eventid String NOT NULL,
          eventtype String,
          mail_timestamp Timestamp,
          mail_messageid String,
          mail_ch_from String,
          mail_ch_to String, 
          mail_ch_messageid String,
          mail_ch_subject String,
          delivery_timestamp Timestamp,
          delivery_time_ms Uint64,
          delivery_recipients String,
          bounce_bounceType String,
          bounce_bounceSubType String,
          bounce_bouncedRecipients String,
          bounce_timestamp Timestamp,
          -- message Json,
          PRIMARY KEY (saved_datetime, eventid)
      )
      ```

  1. Нажмите кнопку ![image](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yacloud.ydb.sql.button_run }}**.

      В результате выполнения запроса в базе данных появится новая таблица `postbox_events`.

{% endlist %}


## Создайте поток данных {{ yds-name }} {#stream}

Создайте [поток данных](../concepts/glossary.md#stream-concepts), в котором будут регистрироваться события {{ postbox-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-streams }}** и нажмите кнопку **{{ ui-key.yacloud.data-streams.button_create-stream }}**.
  1. В поле **{{ ui-key.yacloud.data-streams.label_database }}** выберите созданную ранее базу данных `postbox-events-ydb`.
  1. В поле **{{ ui-key.yacloud.common.name }}** укажите имя потока данных `postbox-events-stream`.
  1. В поле **{{ ui-key.yacloud.data-streams.label_meter-mode }}** выберите `{{ ui-key.yacloud.data-streams.label_request-units }}`.
  1. Другие параметры потока данных оставьте без изменений и нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

Дождитесь запуска потока данных. Когда поток станет готов к использованию, его статус изменится с `Creating` на `Active`.


## Подготовьте ресурсы {{ postbox-name }} {#postbox}

В сервисе {{ postbox-name }} настройте [конфигурацию](../../postbox/concepts/glossary.md#subscription) для регистрации событий в {{ yds-name }}, создайте [адрес](../../postbox/concepts/glossary.md#adress) для отправки писем и [пройдите](../../postbox/operations/check-domain.md) проверку прав на домен.


### Создайте конфигурацию {{ postbox-name }} {#config}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/list-ul.svg) **{{ ui-key.yacloud.postbox.label_configuration-sets }}** и нажмите кнопку **{{ ui-key.yacloud.postbox.button_create-configuration-set }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** укажите имя конфигурации `postbox-events-config`.
  1. В блоке **{{ ui-key.yacloud.postbox.label_event-destinations }}** нажмите кнопку **{{ ui-key.yacloud.common.add }}** и в появившейся форме:

      1. В поле **{{ ui-key.yacloud.postbox.label_name }}** укажите название [подписки](../../postbox/concepts/glossary.md#subscription) `postbox-events-subscribe`.
      1. В поле **{{ ui-key.yacloud.postbox.label_data-stream }}** выберите [поток данных](../concepts/glossary.md#stream-concepts) `postbox-events-stream`.
      1. Включите опцию **{{ ui-key.yacloud.common.enabled }}**, чтобы активировать подписку.

  1. Другие параметры конфигурации оставьте без изменений и нажмите кнопку **{{ ui-key.yacloud.postbox.button_create-configuration-set }}**.

{% endlist %}


### Создайте адрес {{ postbox-name }} {#address}

1. На вашем компьютере сгенерируйте ключ `privatekey.pem` для создания DKIM-подписи. Для этого в терминале выполните команду:

    ```bash
    openssl genrsa -out privatekey.pem 2048
    ```

    {% note info %}

    В операционных системах Linux и macOS утилита `openssl` предустановлена. В Windows эту утилиту необходимо предварительно установить. Подробнее см. на [сайте](https://openssl-library.org/) проекта.

    {% endnote %}

1. Создайте адрес {{ postbox-name }}:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
      1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
      1. На панели слева выберите ![at](../../_assets/console-icons/at.svg) **{{ ui-key.yacloud.postbox.label_identities }}** и нажмите кнопку **{{ ui-key.yacloud.postbox.button_create-identity }}**.
      1. В поле **{{ ui-key.yacloud.postbox.label_address }}** укажите домен, с которого вы будете отправлять письма. Домен может быть любого уровня и должен принадлежать вам.
      1. В поле **{{ ui-key.yacloud.postbox.label_selector }}** укажите селектор, например `postbox`. Указанный селектор должен использоваться только в одной ресурсной записи — той, которую необходимо создать при прохождении [проверки прав на домен](#domain).
      1. В поле **{{ ui-key.yacloud.postbox.label_configuration-set }}** выберите созданную ранее конфигурацию `postbox-events-config`.
      1. В поле **{{ ui-key.yacloud.postbox.label_private-key }}** вставьте содержимое файла приватного ключа `privatekey.pem`, созданного на предыдущем шаге.
      1. Другие параметры адреса оставьте без изменений и нажмите кнопку **{{ ui-key.yacloud.postbox.button_create-identity }}**.
      1. В открывшемся списке адресов нажмите на строку с вновь созданным адресом.
      1. На странице с информацией об адресе в блоке **Подтверждение подписи** из поля **{{ ui-key.yacloud.postbox.label_dns-record-value }}** скопируйте и сохраните значение [TXT-записи](../../dns/concepts/resource-record.md#txt).

    {% endlist %}


### Пройдите проверку владения доменом {#domain}

Чтобы отправлять письма, подтвердите владение доменом. После создания адреса на его странице сформируются настройки DKIM-подписи. Их нужно указать в качестве значений [ресурсных записей](../../glossary/dns.md#dns-server), которые необходимо добавить в вашу доменную зону. Вы можете добавить записи у вашего регистратора или в сервисе [{{ dns-full-name }}](../../dns/index.md), если вы делегировали ваш домен {{ yandex-cloud }}.

{% list tabs group=dkim %}

- Простая настройка {#easy}

    При простой настройке {{ postbox-name }} самостоятельно генерирует ключи DKIM. На странице адреса в блоке **{{ ui-key.yacloud.postbox.section_dkim }}** отображаются две CNAME-записи, которые нужно добавить в DNS-провайдер.

    **Пример создания ресурсных записей в {{ dns-full-name }}**

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находятся адрес и ваша доменная зона.
    
       Если у вас еще нет [публичной зоны](../../dns/concepts/dns-zone.md#public-zones) DNS, [создайте](../../dns/operations/zone-create-public.md) ее.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
    1. Выберите созданный адрес и откройте блок **{{ ui-key.yacloud.postbox.section_dkim }}**.
    1. Для каждой из двух CNAME-записей выполните следующие шаги:
    
        1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
        1. Выберите вашу доменную зону.
        1. Нажмите кнопку **{{ ui-key.yacloud.dns.button_record-set-create }}**.
        1. В поле **{{ ui-key.yacloud.common.type }}** выберите `CNAME`.
        1. В поле **{{ ui-key.yacloud.common.name }}** скопируйте имя записи из блока **{{ ui-key.yacloud.postbox.section_dkim }}** на странице адреса (без домена).
    
           {% note info %}
    
           Для других DNS-сервисов может потребоваться скопировать имя записи целиком, включая домен.
    
           {% endnote %}
    
        1. В поле **{{ ui-key.yacloud.dns.label_records }}** скопируйте значение записи из блока **{{ ui-key.yacloud.postbox.section_dkim }}** на странице адреса.
        1. В поле **{{ ui-key.yacloud.dns.label_form-ttl }}** укажите время жизни записи.
        1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
    1. Выберите созданный адрес.
    1. Дождитесь, когда {{ postbox-name }} проверит настройки DKIM-подписи. Если записи верны, статус проверки на странице адреса изменится на `Success`.

- Расширенная настройка {#advanced}

    При расширенной настройке вы самостоятельно [генерируете ключ](../../postbox/operations/create-address.md) для создания DKIM-подписи. На странице адреса в блоке **{{ ui-key.yacloud.postbox.section_dkim }}** отображается одна TXT-запись, которую нужно добавить в DNS-провайдер.

    **Пример создания ресурсных записей в {{ dns-full-name }}**
    
    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находятся адрес и ваша доменная зона.

        Если у вас еще нет [публичной зоны](../../dns/concepts/dns-zone.md#public-zones) DNS, [создайте](../../dns/operations/zone-create-public.md) ее.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
    1. Выберите вашу доменную зону.
    1. Нажмите кнопку **{{ ui-key.yacloud.dns.button_record-set-create }}**.
    1. В поле **{{ ui-key.yacloud.common.name }}** укажите часть имени, сгенерированного при создании адреса, без домена в формате `<селектор>._domainkey`. Например `postbox._domainkey`.

        {% note info %}

        Для других DNS-сервисов может потребоваться скопировать запись целиком. Итоговая запись должна иметь вид `<селектор>._domainkey.<домен>.`, например `postbox._domainkey.example.com.`.

        {% endnote %}

    1. В поле **{{ ui-key.yacloud.common.type }}** выберите `TXT`.
    1. В поле **{{ ui-key.yacloud.dns.label_records }}** скопируйте содержимое поля **{{ ui-key.yacloud.postbox.label_dns-record-value }}** из блока **{{ ui-key.yacloud.postbox.section_dkim }}** необходимого адреса. Обратите внимание, что значение записи нужно взять в кавычки, например:

        ```text
        "v=DKIM1;h=sha256;k=rsa;p=M1B...aCA8"
        ```

        {% note info %}

        В других DNS-сервисах могут быть другие требования к оформлению ресурсных записей. Подробнее читайте в документации того DNS-сервиса, в котором создаете ресурсную запись.

        {% endnote %}

    1. В поле **{{ ui-key.yacloud.dns.label_form-ttl }}** укажите время жизни записи.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
    1. Выберите созданный адрес.
    1. Дождитесь, когда {{ postbox-name }} проверит настройки DKIM-подписи. Если запись верна, статус проверки на странице адреса изменится на `Success`.

{% endlist %}

Ответы DNS-сервера кешируются, поэтому возможны задержки при обновлении ресурсной записи. Если статус проверки не изменится в течение 24 часов, нажмите кнопку **{{ ui-key.yacloud.postbox.button_run-verification }}**.


## Подготовьте ресурсы {{ sf-name }} {#serverless-functions}

Создайте [функцию](../../functions/concepts/function.md) для отправки данных из потока данных в БД, а также [триггер](../../functions/concepts/trigger/index.md), который будет вызывать функцию при регистрации событий в потоке данных.


### Получите код функции {#code}

{% list tabs %}

- Архив

  [Скачайте](https://github.com/yandex-cloud-examples/yc-postbox-events/raw/main/build/postbox-events.zip) архив `postbox-events.zip` на свой компьютер. В архиве находятся файлы `index.py` и `requirements.txt`, содержащие код функции.

- Репозиторий

  На своем компьютере выполните следующие операции:

  1. Склонируйте [репозиторий](https://github.com/yandex-cloud-examples/yc-postbox-events/tree/main) с кодом функции:

      ```bash
      git clone https://github.com/yandex-cloud-examples/yc-postbox-events/blob/main/build/postbox-events.git
      ```

      Перейдите в директорию с репозиторием. В ней должны появиться файлы `index.py` и `requirements.txt`, содержащие код функции.

  1. Создайте архив с именем `postbox-events.zip` и добавьте в него файлы `index.py` и `requirements.txt`.

{% endlist %}


### Получите реквизиты для подключения к БД {#db-details}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
  1. Выберите базу данных, для которой нужно получить эндпоинт и путь.

      * Эндпоинт БД указан в блоке **{{ ui-key.yacloud.ydb.overview.section_connection }}** в первой части значения поля **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** (часть до вхождения `/?database=`):

          >Например, эндпоинт для БД в режиме Serverless — `{{ ydb.ep-serverless }}`.

      * Путь БД указан в блоке **{{ ui-key.yacloud.ydb.overview.section_connection }}** во второй части значения поля **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** (часть после вхождения `/?database=`).

          >Пример пути БД: `{{ ydb.path-serverless }}`.

{% endlist %}


### Создайте функцию {#function}

Для создания функции вам потребуется код функции и реквизиты для подключения к БД.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Создайте функцию:

      1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
      1. В поле **{{ ui-key.yacloud.common.name }}** введите имя функции. Например, `postbox-events-function`.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

  1. Создайте версию функции:

      1. В открывшемся окне **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}** выберите `{{ python-full-ver }}`.
      1. Отключите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
      1. В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_code-source }}** выберите `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}`.
      1. Нажмите кнопку **Прикрепить файл** и выберите архив `postbox-events.zip`.
      1. В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** укажите `index.handler`.

      1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}** укажите:

          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** — `10 {{ ui-key.yacloud_billing.common.units.label_time-sec_many }}`.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}** — `128 {{ ui-key.yacloud.common.units.label_megabyte }}`.
          * **{{ ui-key.yacloud.forms.label_service-account-select }}** — `yds-functions`.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**:

              Ключ | Описание | Пример значения
              :--- | :--- | :---
              `YDB_DATABASE` | Путь БД     | `/{{ region-id }}/b1go123e9vjq********/etnu15kr22********`
              `YDB_ENDPOINT` | Эндпоинт БД | `grpcs://ydb.serverless.yandexcloud.net:2135`
              `YDB_TABLE`    | Имя таблицы | `postbox_events`

      1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

{% endlist %}


### Создайте триггер {#trigger}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}** и нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
  1. В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_name }}** введите имя триггера `postbox-events-trigger`.
  1. В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_data-streams }}`.
  1. В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}`.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_data-streams }}** выберите поток данных `postbox-events-stream` и сервисный аккаунт `yds-functions`.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}** выберите функцию `postbox-events-function` и сервисный аккаунт `yds-functions`.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

{% endlist %}


## Отправьте письма {#send-letters}

1. Удобным вам способом [отправьте](../../postbox/operations/send-email.md#send-email) несколько тестовых писем с использованием адреса {{ postbox-name }} и статического ключа доступа, созданных ранее.
1. Убедитесь, что письма доставлены. Для этого проверьте почту, на которую вы отправляли эти письма.
1. Убедитесь, что данные об отправке писем поступают в сервисы:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      * Проверьте поток данных:

          1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
          1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-streams }}**.
          1. Выберите поток данных `postbox-events-stream`.
          1. Перейдите на вкладку ![text-align-justify](../../_assets/console-icons/text-align-justify.svg) **{{ ui-key.yacloud.data-streams.label_data-introspection }}**.
          
              На графиках должны отобразиться события отправки писем.

      * Проверьте БД:

          1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
          1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
          1. Выберите базу данных `postbox-events-ydb`.
          1. Перейдите на вкладку ![image](../../_assets/console-icons/folder.svg) **{{ ui-key.yacloud.ydb.database.switch_browse }}**
          1. Выберите таблицу `postbox_events`.

              В таблице должны появиться записи. В некоторых столбцах может быть значение `NULL` — это зависит от [типа уведомления](../../postbox/concepts/notification.md#types), которое было получено от сервиса {{ postbox-name }}.

    {% endlist %}


## Настройте визуализацию в {{ datalens-name }} {#datalens}

Чтобы наблюдать за отправкой писем, настройте [подключение](../../datalens/concepts/connection/index.md), создайте [датасет](../../datalens/dataset/index.md), [чарты](../../datalens/concepts/chart/index.md) и [дашборд](../../datalens/concepts/dashboard.md).


### Создайте подключение {#connection}

{% list tabs group=instructions %}

- Интерфейс {{ datalens-short-name }} {#console}

  1. Перейдите на [главную страницу]({{ link-datalens-main-skip-promo }}) {{ datalens-short-name }}.
  1. На панели слева выберите ![thunderbolt](../../_assets/console-icons/thunderbolt.svg) **Подключения** и нажмите кнопку **Создать подключение**.
  1. Выберите коннектор **{{ ydb-short-name }}**.
  1. Укажите параметры подключения:

      * **Облако и каталог** — выберите каталог, в котором выполняете руководство.
      * **Сервисный аккаунт** — `yds-functions`.
      * **База данных** — `postbox-events-ydb`.
      * **Время жизни кеша в секундах** — `По умолчанию`.
      * Включите опцию **Уровень доступа SQL запросов** и выберите `Разрешить подзапросы в датасетах`.

  1. Нажмите кнопку **Создать подключение**.
  1. В открывшемся окне выберите воркбук, в котором будет создано подключение, и нажмите кнопку **Создать**.
  1. Введите имя подключения `postbox-events-connection` и нажмите **Создать**.

{% endlist %}


### Создайте датасет {#dataset}

{% list tabs group=instructions %}

- Интерфейс {{ datalens-short-name }} {#console}

  1. Перейдите на [главную страницу]({{ link-datalens-main-promo }}) {{ datalens-short-name }}.
  1. Нажмите **Начать в облаке**.
  1. На панели слева выберите ![circles-intersection](../../_assets/console-icons/circles-intersection.svg) **Датасеты** и нажмите кнопку **Создать датасет**.
  1. В открывшемся окне выберите воркбук, в котором вы создали подключение, и нажмите кнопку **Создать**.
  1. В блоке **Подключения** нажмите ![plus](../../_assets/console-icons/plus.svg) **Добавить** и выберите созданное ранее подключение `postbox-events-connection`.
  1. В блоке **Таблицы** выберите таблицу `postbox-events` и перетащите ее вправо.
  1. Нажмите кнопку **Сохранить**.
  1. В открывшемся окне укажите имя датасета `postbox-events-dataset` и нажмите **Создать**.

{% endlist %}


### Создайте чарты {#charts}

В качестве примера приведено создание чартов [Количество событий по дням](#events-by-days) и [Список событий](#events-list). Аналогичным способом вы можете создать и другие чарты.


#### Количество событий по дням {#events-by-days}

{% list tabs group=instructions %}

- Интерфейс {{ datalens-short-name }} {#console}

  1. Перейдите на [главную страницу]({{ link-datalens-main-skip-promo }}) {{ datalens-short-name }}.
  1. На панели слева выберите ![chart-column](../../_assets/console-icons/chart-column.svg) **Чарты**, нажмите кнопку **Создать чарт** и выберите **Чарт в Wizard**.
  1. В открывшемся окне выберите воркбук, в котором вы создали подключение, и нажмите кнопку **Создать**.
  1. В секции слева нажмите ![circles-intersection](../../_assets/console-icons/circles-intersection.svg) **Выберите датасет** и выберите `postbox-events-dataset`.
  1. Выберите [тип чарта](../../datalens/visualization-ref/line-chart.md) **Столбчатая диаграмма**.
  1. Перетащите измерения:

      * `delivery_timestamp` в секцию **X** — по оси X будут расположены даты;
      * `eventid` в секцию **Y** — значение по оси Y будет соответствовать количеству событий;
      * `eventtype` в секцию **Цвета** — типы событий будут выделены на диаграмме разными цветами.

  1. Нажмите кнопку **Сохранить**.
  1. В открывшемся окне укажите имя чарта `Количество событий по дням` и нажмите **Сохранить**.

{% endlist %}


#### Список событий {#events-list}

{% list tabs group=instructions %}

- Интерфейс {{ datalens-short-name }} {#console}

  1. Перейдите на [главную страницу]({{ link-datalens-main-skip-promo }}) {{ datalens-short-name }}.
  1. На панели слева выберите ![chart-column](../../_assets/console-icons/chart-column.svg) **Чарты**, нажмите кнопку **Создать чарт** и выберите **Чарт в Wizard**.
  1. В открывшемся окне выберите воркбук, в котором вы создали подключение, и нажмите кнопку **Создать**.
  1. В секции слева нажмите ![image](../../_assets/console-icons/circles-intersection.svg) **Выберите датасет** и выберите `postbox-events-dataset`.
  1. Выберите [тип чарта](../../datalens/visualization-ref/line-chart.md) **Таблица**.
  1. Перетащите следующие измерения в секцию **Столбцы**:

      * `saved_datetime` — дата и время сохранения события;
      * `eventid` — тип события;
      * `mail_ch_to` — адрес получателя;
      * `delivery_timestamp` — дата и время доставки письма;
      * `delivery_time_ms` — время доставки в миллисекундах;
      * `mail_ch_subject` — тема письма;
      * `bounce_bounceType` — тип ошибки доставки;
      * `bounce_bounceSubType` — сообщение недоставки.

  1. Перетащите измерение `delivery_timestamp` в секцию **Сортировка**, чтобы отсортировать таблицу по времени доставки.
  1. Нажмите кнопку **Сохранить**.
  1. В открывшемся окне укажите имя чарта `Список событий` и нажмите **Сохранить**.

{% endlist %}


### Создайте дашборд {#dashboard}

{% list tabs group=instructions %}

- Интерфейс {{ datalens-short-name }} {#console}

  1. Перейдите на [главную страницу]({{ link-datalens-main-skip-promo }}) {{ datalens-short-name }}.
  1. На панели слева выберите ![layout-cells-large](../../_assets/console-icons/layout-cells-large.svg) **Дашборды** и нажмите кнопку **Создать дашборд**.
  1. В открывшемся окне выберите воркбук, в котором вы создали подключение, и нажмите кнопку **Создать**.
  1. Добавьте на дашборд чарты `Количество событий по дням`, `Список событий` и другие, которые вы создали ранее:

      1. На нижней панели нажмите **Чарт**.
      1. В открывшемся окне нажмите кнопку **Выбрать** и выберите чарт `Количество событий по дням`.
      1. Нажмите кнопку **Добавить**.
      1. Повторите действия, чтобы добавить на дашборд чарт `Список событий` и (при необходимости) другие чарты.

  1. С помощью мыши измените размер и положение чартов.
  1. Нажмите кнопку **Сохранить**.
  1. В открывшемся окне введите название дашборда `postbox-events-dashboard`.
  1. Нажмите кнопку **Создать**.

{% endlist %}

В результате выполнения руководства вы сможете анализировать события на графиках и в таблицах.


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../functions/operations/trigger/trigger-delete.md) триггер для вызова функции {{ sf-name }}.
1. [Удалите](../../functions/operations/function/function-delete.md) функцию {{ sf-name }}.
1. [Удалите](../../ydb/operations/manage-databases.md#delete-db) базу данных {{ ydb-name }}.
1. [Удалите](../operations/manage-streams.md#delete-data-stream) поток данных {{ yds-name }}.
1. [Удалите](../../postbox/operations/index.md) адрес и конфигурацию {{ postbox-name }}.
1. При необходимости [удалите](../../iam/operations/sa/delete.md) созданные сервисные аккаунты.
1. При необходимости удалите [ресурсную запись](../../dns/operations/resource-record-delete.md) и [публичную зону DNS](../../dns/operations/zone-delete.md).