# Интеграция {{ postbox-full-name }} с внешними системами с помощью вебхуков


В этом руководстве вы настроите передачу событий [{{ postbox-full-name }}](../../postbox/index.yaml) в [{{ yds-full-name }}](../../data-streams/index.yaml) и вызов [вебхуков](https://ru.wikipedia.org/wiki/Webhook) во внешних системах. Для обработки и хранения данных будут использоваться сервисы [{{ sf-full-name }}](../../functions/index.yaml) и [{{ ydb-full-name }}](../../ydb/index.yaml).

Реализовать предлагаемое решение можно с помощью [консоли управления]({{ link-console-main }}) {{ yandex-cloud }}, даже не имея навыков разработки.

Чтобы настроить передачу событий и их обработку:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте сервисные аккаунты](#service-accounts).
1. [Создайте статический ключ доступа](#static-key).
1. [Создайте базу данных {{ ydb-name }}](#ydb).
1. [Создайте поток данных {{ yds-name }}](#stream).
1. [Подготовьте ресурсы {{ postbox-name }}](#postbox).
1. [Подготовьте ресурсы {{ sf-name }}](#serverless-functions).
1. [Протестируйте работу решения](#test-solution).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за операции с {{ ydb-short-name }} и хранение данных (см. [тарифы {{ ydb-full-name }}](../../ydb/pricing/serverless.md));
* плата за хранение данных {{ yds-short-name }} (см. [тарифы {{ yds-full-name }}](../../data-streams/pricing.md));
* плата за количество вызовов функции, вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик (см. [тарифы {{ sf-name }}](../../functions/pricing.md));
* плата за использование {{ postbox-name }} (см. [тарифы {{ postbox-full-name }}](../../postbox/pricing.md)).


## Создайте сервисные аккаунты {#service-accounts}

Создайте два [сервисных аккаунта](../../iam/concepts/users/service-accounts.md):

* `yds-functions` — от его имени будет вызываться [функция](../../functions/concepts/function.md) {{ sf-name }} и будут записываться события в [поток данных](../../data-streams/concepts/glossary.md#stream-concepts) {{ yds-short-name }};
* `postbox-user` — от его имени будут отправляться письма через {{ postbox-name }}.

1. Создайте сервисный аккаунт `yds-functions`:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы будете создавать инфраструктуру.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}** и нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
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
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}** и в списке сервисных аккаунтов выберите `postbox-user`. В открывшемся окне:

      1. На панели сверху нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
      1. Сохраните идентификатор и секретный ключ.

          {% note alert %}

          После закрытия диалога значение ключа будет недоступно.

          {% endnote %}

{% endlist %}


## Создайте базу данных {{ ydb-name }} {#ydb}

Чтобы создать поток данных, в который будут отправляться события {{ postbox-name }}, потребуется база данных {{ ydb-name }}. Создайте [бессерверную базу данных](../../ydb/concepts/resources.md#serverless) {{ ydb-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}** и нажмите кнопку **{{ ui-key.yacloud.ydb.databases.button_create }}**.
  1. В поле **{{ ui-key.yacloud.ydb.forms.label_field_name }}** укажите `postbox-events-ydb`.
  1. В поле **{{ ui-key.yacloud.ydb.forms.label_field_database-type }}** выберите `{{ ui-key.yacloud.ydb.forms.label_serverless-type_pB7Wx }}`.
  1. Другие параметры базы данных оставьте без изменений и нажмите кнопку **{{ ui-key.yacloud.ydb.forms.button_create-database }}**.

  Дождитесь запуска БД. В процессе создания база данных будет находиться в статусе `Provisioning`, а когда станет готова к использованию, ее статус изменится на `Running`.

{% endlist %}


## Создайте поток данных {{ yds-name }} {#stream}

Создайте [поток данных](../../data-streams/concepts/glossary.md#stream-concepts), в котором будут регистрироваться события {{ postbox-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_data-streams }}** и нажмите кнопку **{{ ui-key.yacloud.data-streams.button_create-stream }}**.
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
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/list-ul.svg) **{{ ui-key.yacloud.postbox.label_configuration-sets }}** и нажмите кнопку **{{ ui-key.yacloud.postbox.button_create-configuration-set }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** укажите имя конфигурации `postbox-events-config`.
  1. В блоке **{{ ui-key.yacloud.postbox.label_event-destinations }}** нажмите кнопку **{{ ui-key.yacloud.common.add }}** и в появившейся форме:

      1. В поле **{{ ui-key.yacloud.postbox.label_name }}** укажите название [подписки](../../postbox/concepts/glossary.md#subscription) `postbox-events-subscribe`.
      1. В поле **{{ ui-key.yacloud.postbox.label_data-stream }}** выберите [поток данных](../../data-streams/concepts/glossary.md#stream-concepts) `postbox-events-stream`.
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
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
      1. На панели слева выберите ![at](../../_assets/console-icons/at.svg) **{{ ui-key.yacloud.postbox.label_identities }}** и нажмите кнопку **{{ ui-key.yacloud.postbox.button_create-identity }}**.
      1. В поле **{{ ui-key.yacloud.postbox.label_address }}** укажите домен, с которого вы будете отправлять письма. Домен может быть любого уровня и должен принадлежать вам.
      1. В поле **{{ ui-key.yacloud.postbox.label_selector }}** укажите селектор, например `postbox`. Указанный селектор должен использоваться только в одной ресурсной записи — той, которую необходимо создать при прохождении [проверки прав на домен](#domain).
      1. В поле **{{ ui-key.yacloud.postbox.label_configuration-set }}** выберите созданную ранее конфигурацию `postbox-events-config`.
      1. В поле **{{ ui-key.yacloud.postbox.label_private-key }}** вставьте содержимое файла приватного ключа `privatekey.pem`, созданного на предыдущем шаге.
      1. Другие параметры адреса оставьте без изменений и нажмите кнопку **{{ ui-key.yacloud.postbox.button_create-identity }}**.
      1. В открывшемся списке адресов нажмите на строку с вновь созданным адресом.
      1. На странице с информацией об адресе в блоке **{{ ui-key.yacloud.postbox.label_signature-verification }}** из поля **{{ ui-key.yacloud.postbox.label_dns-record-value }}** скопируйте и сохраните значение [TXT-записи](../../dns/concepts/resource-record.md#txt).

    {% endlist %}


### Пройдите проверку прав на домен {#domain}

{% include [check-domain](../../_includes/postbox/check-domain.md) %}


## Подготовьте ресурсы {{ sf-name }} {#serverless-functions}

Создайте [функцию](../../functions/concepts/function.md), которая будет отправлять вебхук, а также [триггер](../../functions/concepts/trigger/index.md), который будет вызывать эту функцию при регистрации событий в потоке данных.


### Создайте функцию {#function}

{% list tabs group=programming_language %}

- Python {#python}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Создайте функцию:

      1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
      1. В поле **{{ ui-key.yacloud.common.name }}** укажите имя функции `postbox-webhook`.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Создайте версию функции:

      1. В открывшемся окне **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}** выберите `{{ python-full-ver }}`.
      1. Отключите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
      1. В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}** выберите `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-editor }}`.
      1. Создайте 2 файла:
      
          * файл `requirements.txt`, содержащий список необходимых зависимостей:

              ```text
              requests
              ```
          * файл `index.py`, содержащий код функции:
  
              ```python
              import requests

              # Адрес webhook'а который будет вызван
              WEBHOOK_URL = "<URL_вебхука>"


              def handler(event, context):
                  requests.post(WEBHOOK_URL, json=event)

                  return {
                      "statusCode": 200,
                  }
              ```
              
              Где `WEBHOOK_URL` — адрес вебхука, на который будет отправлен запрос.
      1. В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** укажите `index.handler`.
      1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}** укажите:

          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** — `10 {{ ui-key.yacloud_billing.common.units.label_time-sec_many }}`.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}** — `128 {{ ui-key.yacloud.common.units.label_megabyte }}`.

      1. Другие параметры версии функции оставьте без изменений и нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- JavaScript {#node}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Создайте функцию:

      1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
      1. В поле **{{ ui-key.yacloud.common.name }}** укажите имя функции `postbox-webhook`.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Создайте версию функции:

      1. В открывшемся окне **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}** выберите `{{ nodejs-full-ver }}`.
      1. Отключите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
      1. В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}** выберите `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-editor }}`.
      1. Создайте файл `index.js` с кодом функции:

          ```js
          // Адрес webhook'а который будет вызван
          const WEBHOOK_URL = '<URL_вебхука>'

          module.exports.handler = async function (event, context) {
              await fetch(WEBHOOK_URL, {
                  method: 'POST',
                  headers: {
                      'Content-Type': 'application/json',
                  },
                  body: JSON.stringify(event),
              });
 
              return {
                  statusCode: 200,
              };
          };
          ```

          Где `WEBHOOK_URL` — адрес вебхука, на который будет отправлен запрос.
      1. В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** укажите `index.handler`.
      1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}** укажите:

          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** — `10 {{ ui-key.yacloud_billing.common.units.label_time-sec_many }}`.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}** — `128 {{ ui-key.yacloud.common.units.label_megabyte }}`.

      1. Другие параметры версии функции оставьте без изменений и нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

{% endlist %}


### Создайте триггер {#trigger}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}** и нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
  1. В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_name }}** введите имя триггера `postbox-events-trigger`.
  1. В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_data-streams }}`.
  1. В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}`.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_data-streams }}** выберите поток данных `postbox-events-stream` и сервисный аккаунт `yds-functions`.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}** выберите функцию `postbox-webhook` и сервисный аккаунт `yds-functions`.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

{% endlist %}


## Протестируйте работу решения {#test-solution}

1. Удобным вам способом [отправьте](../../postbox/operations/send-email.md#send-email) несколько тестовых писем с использованием адреса {{ postbox-name }} и статического ключа доступа, созданных ранее.
1. Убедитесь, что письма доставлены. Для этого проверьте почту, на которую вы отправляли эти письма.
1. Убедитесь, что данные об отправке писем поступают в сервисы:

    * Проверьте поток данных:

        {% list tabs group=instructions %}

        - Консоль управления {#console}

          1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
          1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_data-streams }}**.
          1. Выберите поток данных `postbox-events-stream`.
          1. Перейдите на вкладку ![text-align-justify](../../_assets/console-icons/text-align-justify.svg) **{{ ui-key.yacloud.data-streams.label_data-introspection }}**.

              На графиках должны отобразиться события отправки писем.

        {% endlist %}

    * Посмотрите [логи функции](../../functions/operations/function/function-logs.md) и [графики мониторинга триггера](../../functions/operations/trigger/trigger-monitoring.md).
    * Убедитесь, что во внешней системе были вызваны вебхуки с данными о событиях по отправленным письмам.

В результате выполнения руководства вы сможете вызывать вебхуки внешней системы в ответ на события, связанные с отправкой писем через {{ postbox-full-name }}.


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../functions/operations/trigger/trigger-delete.md) триггер для вызова функции {{ sf-name }}.
1. [Удалите](../../functions/operations/function/function-delete.md) функцию {{ sf-name }}.
1. [Удалите](../../data-streams/operations/manage-streams.md#delete-data-stream) поток данных {{ yds-name }}.
1. [Удалите](../../ydb/operations/manage-databases.md#delete-db) базу данных {{ ydb-name }}.
1. Удалите адрес и конфигурацию {{ postbox-name }}.
1. При необходимости [удалите](../../iam/operations/sa/delete.md) созданные сервисные аккаунты.
1. При необходимости удалите [ресурсную запись](../../dns/operations/resource-record-delete.md) и [публичную зону DNS](../../dns/operations/zone-delete.md).