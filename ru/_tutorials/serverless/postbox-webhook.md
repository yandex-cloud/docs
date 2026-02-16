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

{% include [create-service-accounts](../_tutorials_includes/events-from-postbox-to-yds/create-service-accounts.md) %}


## Создайте статический ключ доступа {#static-key}

{% include [create-static-key](../_tutorials_includes/events-from-postbox-to-yds/create-static-key.md) %}


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

{% include [create-yds-stream](../_tutorials_includes/events-from-postbox-to-yds/create-yds-stream.md) %}


## Подготовьте ресурсы {{ postbox-name }} {#postbox}

{% include [create-pb-resources-intro](../_tutorials_includes/events-from-postbox-to-yds/create-pb-resources-intro.md) %}


### Создайте конфигурацию {{ postbox-name }} {#config}

{% include [create-pb-resources-config](../_tutorials_includes/events-from-postbox-to-yds/create-pb-resources-config.md) %}


### Создайте адрес {{ postbox-name }} {#address}

{% include [create-pb-resources-address](../_tutorials_includes/events-from-postbox-to-yds/create-pb-resources-address.md) %}


### Пройдите проверку владения доменом {#domain}

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

            {% include [test-function-machinery-check-yds](../_tutorials_includes/events-from-postbox-to-yds/test-function-machinery-check-yds.md) %}

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