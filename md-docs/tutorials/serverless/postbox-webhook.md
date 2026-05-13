# Интеграция Yandex Cloud Postbox с внешними системами с помощью вебхуков


В этом руководстве вы настроите передачу событий [Yandex Cloud Postbox](../../postbox/index.md) в [Yandex Data Streams](../../data-streams/index.md) и вызов [вебхуков](https://ru.wikipedia.org/wiki/Webhook) во внешних системах. Для обработки и хранения данных будут использоваться сервисы [Yandex Cloud Functions](../../functions/index.md) и [Yandex Managed Service for YDB](../../ydb/index.md).

Реализовать предлагаемое решение можно с помощью [консоли управления](https://console.yandex.cloud) Yandex Cloud, даже не имея навыков разработки.

Чтобы настроить передачу событий и их обработку:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте сервисные аккаунты](#service-accounts).
1. [Создайте статический ключ доступа](#static-key).
1. [Создайте базу данных Managed Service for YDB](#ydb).
1. [Создайте поток данных Data Streams](#stream).
1. [Подготовьте ресурсы Yandex Cloud Postbox](#postbox).
1. [Подготовьте ресурсы Cloud Functions](#serverless-functions).
1. [Протестируйте работу решения](#test-solution).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за операции с YDB и хранение данных (см. [тарифы Yandex Managed Service for YDB](../../ydb/pricing/serverless.md));
* плата за хранение данных Data Streams (см. [тарифы Yandex Data Streams](../../data-streams/pricing.md));
* плата за количество вызовов функции, вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик (см. [тарифы Cloud Functions](../../functions/pricing.md));
* плата за использование Yandex Cloud Postbox (см. [тарифы Yandex Cloud Postbox](../../postbox/pricing.md)).


## Создайте сервисные аккаунты {#service-accounts}

Создайте два [сервисных аккаунта](../../iam/concepts/users/service-accounts.md):

* `yds-functions` — от его имени будет вызываться [функция](../../functions/concepts/function.md) Cloud Functions и будут записываться события в [поток данных](../../data-streams/concepts/glossary.md#stream-concepts) Data Streams;
* `postbox-user` — от его имени будут отправляться письма через Yandex Cloud Postbox.

1. Создайте сервисный аккаунт `yds-functions`:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы будете создавать инфраструктуру.
      1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Identity and Access Management** и нажмите кнопку **Создать сервисный аккаунт**.
      1. В поле **Имя** укажите имя `yds-functions`.
      1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите [роли](../../iam/concepts/access-control/roles.md) `yds.editor` и `functions.functionInvoker`.
      1. Нажмите кнопку **Создать**.

    {% endlist %}

1. Аналогичным образом создайте сервисный аккаунт `postbox-user` и назначьте ему [роль](../../postbox/security/index.md#postbox-sender) `postbox.sender`.


## Создайте статический ключ доступа {#static-key}

Создайте [статический ключ доступа](../../iam/concepts/authorization/access-key.md), который будет использоваться для отправки писем:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете инфраструктуру.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Identity and Access Management** и в списке сервисных аккаунтов выберите `postbox-user`. В открывшемся окне:

      1. На панели сверху нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **Создать новый ключ** и выберите **Создать статический ключ доступа**.
      1. Нажмите кнопку **Создать**.
      1. Сохраните идентификатор и секретный ключ.

          {% note alert %}

          После закрытия диалога значение ключа будет недоступно.

          {% endnote %}

{% endlist %}


## Создайте базу данных Managed Service for YDB {#ydb}

Чтобы создать поток данных, в который будут отправляться события Yandex Cloud Postbox, потребуется база данных Managed Service for YDB. Создайте [бессерверную базу данных](../../ydb/concepts/resources.md#serverless) Managed Service for YDB:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете инфраструктуру.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;YDB** и нажмите кнопку **Создать базу данных**.
  1. В поле **Имя** укажите `postbox-events-ydb`.
  1. В поле **Тип базы данных** выберите `Serverless`.
  1. Другие параметры базы данных оставьте без изменений и нажмите кнопку **Создать базу данных**.

  Дождитесь запуска БД. В процессе создания база данных будет находиться в статусе `Provisioning`, а когда станет готова к использованию, ее статус изменится на `Running`.

{% endlist %}


## Создайте поток данных Data Streams {#stream}

Создайте [поток данных](../../data-streams/concepts/glossary.md#stream-concepts), в котором будут регистрироваться события Yandex Cloud Postbox:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете инфраструктуру.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Data Streams** и нажмите кнопку **Создать поток**.
  1. В поле **База данных** выберите созданную ранее базу данных `postbox-events-ydb`.
  1. В поле **Имя** укажите имя потока данных `postbox-events-stream`.
  1. В поле **Режим тарификации** выберите `По фактическому использованию`.
  1. Другие параметры потока данных оставьте без изменений и нажмите кнопку **Создать**.

{% endlist %}

Дождитесь запуска потока данных. Когда поток станет готов к использованию, его статус изменится с `Creating` на `Active`.


## Подготовьте ресурсы Yandex Cloud Postbox {#postbox}

В сервисе Yandex Cloud Postbox настройте [конфигурацию](../../postbox/concepts/glossary.md#subscription) для регистрации событий в Data Streams, создайте [адрес](../../postbox/concepts/glossary.md#adress) для отправки писем и [пройдите](../../postbox/operations/check-domain.md) проверку прав на домен.


### Создайте конфигурацию Yandex Cloud Postbox {#config}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете инфраструктуру.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Postbox**.
  1. На панели слева выберите ![image](../../_assets/console-icons/list-ul.svg) **Конфигурации** и нажмите кнопку **Создать конфигурацию**.
  1. В поле **Имя** укажите имя конфигурации `postbox-events-config`.
  1. В блоке **Подписки** нажмите кнопку **Добавить** и в появившейся форме:

      1. В поле **Название** укажите название [подписки](../../postbox/concepts/glossary.md#subscription) `postbox-events-subscribe`.
      1. В поле **Поток данных** выберите [поток данных](../../data-streams/concepts/glossary.md#stream-concepts) `postbox-events-stream`.
      1. Включите опцию **Включено**, чтобы активировать подписку.

  1. Другие параметры конфигурации оставьте без изменений и нажмите кнопку **Создать конфигурацию**.

{% endlist %}


### Создайте адрес Yandex Cloud Postbox {#address}

1. На вашем компьютере сгенерируйте ключ `privatekey.pem` для создания DKIM-подписи. Для этого в терминале выполните команду:

    ```bash
    openssl genrsa -out privatekey.pem 2048
    ```

    {% note info %}

    В операционных системах Linux и macOS утилита `openssl` предустановлена. В Windows эту утилиту необходимо предварительно установить. Подробнее см. на [сайте](https://openssl-library.org/) проекта.

    {% endnote %}

1. Создайте адрес Yandex Cloud Postbox:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете инфраструктуру.
      1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Postbox**.
      1. На панели слева выберите ![at](../../_assets/console-icons/at.svg) **Адреса** и нажмите кнопку **Создать адрес**.
      1. В поле **Домен** укажите домен, с которого вы будете отправлять письма. Домен может быть любого уровня и должен принадлежать вам.
      1. В поле **Селектор** укажите селектор, например `postbox`. Указанный селектор должен использоваться только в одной ресурсной записи — той, которую необходимо создать при прохождении [проверки прав на домен](#domain).
      1. В поле **Конфигурация** выберите созданную ранее конфигурацию `postbox-events-config`.
      1. В поле **Приватный ключ** вставьте содержимое файла приватного ключа `privatekey.pem`, созданного на предыдущем шаге.
      1. Другие параметры адреса оставьте без изменений и нажмите кнопку **Создать адрес**.
      1. В открывшемся списке адресов нажмите на строку с вновь созданным адресом.
      1. На странице с информацией об адресе в блоке **Подтверждение подписи** из поля **Значение** скопируйте и сохраните значение [TXT-записи](../../dns/concepts/resource-record.md#txt).

    {% endlist %}


### Пройдите проверку владения доменом {#domain}

Чтобы отправлять письма, подтвердите владение доменом. После создания адреса на его странице сформируются настройки DKIM-подписи. Их нужно указать в качестве значений [ресурсных записей](../../glossary/dns.md#dns-server), которые необходимо добавить в вашу доменную зону. Вы можете добавить записи у вашего регистратора или в сервисе [Yandex Cloud DNS](../../dns/index.md), если вы делегировали ваш домен Yandex Cloud.

{% list tabs group=dkim %}

- Простая настройка {#easy}

    При простой настройке Yandex Cloud Postbox самостоятельно генерирует ключи DKIM. На странице адреса в блоке **Настройка подписи писем (DKIM)** отображаются две CNAME-записи, которые нужно добавить в DNS-провайдер.

    **Пример создания ресурсных записей в Yandex Cloud DNS**

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находятся адрес и ваша доменная зона.
    
       Если у вас еще нет [публичной зоны](../../dns/concepts/dns-zone.md#public-zones) DNS, [создайте](../../dns/operations/zone-create-public.md) ее.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Postbox**.
    1. Выберите созданный адрес и откройте блок **Настройка подписи писем (DKIM)**.
    1. Для каждой из двух CNAME-записей выполните следующие шаги:
    
        1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud DNS**.
        1. Выберите вашу доменную зону.
        1. Нажмите кнопку **Создать запись**.
        1. В поле **Тип** выберите `CNAME`.
        1. В поле **Имя** скопируйте имя записи из блока **Настройка подписи писем (DKIM)** на странице адреса (без домена).
    
           {% note info %}
    
           Для других DNS-сервисов может потребоваться скопировать имя записи целиком, включая домен.
    
           {% endnote %}
    
        1. В поле **Значение** скопируйте значение записи из блока **Настройка подписи писем (DKIM)** на странице адреса.
        1. В поле **TTL (в секундах)** укажите время жизни записи.
        1. Нажмите кнопку **Создать**.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Postbox**.
    1. Выберите созданный адрес.
    1. Дождитесь, когда Yandex Cloud Postbox проверит настройки DKIM-подписи. Если записи верны, статус проверки на странице адреса изменится на `Success`.

- Расширенная настройка {#advanced}

    При расширенной настройке вы самостоятельно [генерируете ключ](../../postbox/operations/create-address.md) для создания DKIM-подписи. На странице адреса в блоке **Настройка подписи писем (DKIM)** отображается одна TXT-запись, которую нужно добавить в DNS-провайдер.

    **Пример создания ресурсных записей в Yandex Cloud DNS**
    
    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находятся адрес и ваша доменная зона.

        Если у вас еще нет [публичной зоны](../../dns/concepts/dns-zone.md#public-zones) DNS, [создайте](../../dns/operations/zone-create-public.md) ее.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud DNS**.
    1. Выберите вашу доменную зону.
    1. Нажмите кнопку **Создать запись**.
    1. В поле **Имя** укажите часть имени, сгенерированного при создании адреса, без домена в формате `<селектор>._domainkey`. Например `postbox._domainkey`.

        {% note info %}

        Для других DNS-сервисов может потребоваться скопировать запись целиком. Итоговая запись должна иметь вид `<селектор>._domainkey.<домен>.`, например `postbox._domainkey.example.com.`.

        {% endnote %}

    1. В поле **Тип** выберите `TXT`.
    1. В поле **Значение** скопируйте содержимое поля **Значение** из блока **Настройка подписи писем (DKIM)** необходимого адреса. Обратите внимание, что значение записи нужно взять в кавычки, например:

        ```text
        "v=DKIM1;h=sha256;k=rsa;p=M1B...aCA8"
        ```

        {% note info %}

        В других DNS-сервисах могут быть другие требования к оформлению ресурсных записей. Подробнее читайте в документации того DNS-сервиса, в котором создаете ресурсную запись.

        {% endnote %}

    1. В поле **TTL (в секундах)** укажите время жизни записи.
    1. Нажмите кнопку **Создать**.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Postbox**.
    1. Выберите созданный адрес.
    1. Дождитесь, когда Yandex Cloud Postbox проверит настройки DKIM-подписи. Если запись верна, статус проверки на странице адреса изменится на `Success`.

{% endlist %}

Ответы DNS-сервера кешируются, поэтому возможны задержки при обновлении ресурсной записи. Если статус проверки не изменится в течение 24 часов, нажмите кнопку **Запустить проверку**.


## Подготовьте ресурсы Cloud Functions {#serverless-functions}

Создайте [функцию](../../functions/concepts/function.md), которая будет отправлять вебхук, а также [триггер](../../functions/concepts/trigger/index.md), который будет вызывать эту функцию при регистрации событий в потоке данных.


### Создайте функцию {#function}

{% list tabs group=programming_language %}

- Python {#python}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете инфраструктуру.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Functions**.
  1. Создайте функцию:

      1. Нажмите кнопку **Создать функцию**.
      1. В поле **Имя** укажите имя функции `postbox-webhook`.
      1. Нажмите кнопку **Создать**.
  1. Создайте версию функции:

      1. В открывшемся окне **Редактор** выберите `Python 3.12`.
      1. Отключите опцию **Добавить файлы с примерами кода**.
      1. Нажмите кнопку **Продолжить**.
      1. В поле **Источник кода** выберите `Редактор кода`.
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
      1. В поле **Точка входа** укажите `index.handler`.
      1. В блоке **Параметры** укажите:

          * **Таймаут** — `10 секунд`.
          * **Память** — `128 МБ`.

      1. Другие параметры версии функции оставьте без изменений и нажмите кнопку **Сохранить изменения**.

- JavaScript {#node}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете инфраструктуру.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Functions**.
  1. Создайте функцию:

      1. Нажмите кнопку **Создать функцию**.
      1. В поле **Имя** укажите имя функции `postbox-webhook`.
      1. Нажмите кнопку **Создать**.
  1. Создайте версию функции:

      1. В открывшемся окне **Редактор** выберите `Node.js 22`.
      1. Отключите опцию **Добавить файлы с примерами кода**.
      1. Нажмите кнопку **Продолжить**.
      1. В поле **Источник кода** выберите `Редактор кода`.
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
      1. В поле **Точка входа** укажите `index.handler`.
      1. В блоке **Параметры** укажите:

          * **Таймаут** — `10 секунд`.
          * **Память** — `128 МБ`.

      1. Другие параметры версии функции оставьте без изменений и нажмите кнопку **Сохранить изменения**.

{% endlist %}


### Создайте триггер {#trigger}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете инфраструктуру.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Functions**.
  1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **Триггеры** и нажмите кнопку **Создать триггер**.
  1. В поле **Имя** введите имя триггера `postbox-events-trigger`.
  1. В поле **Тип** выберите `Data Streams`.
  1. В поле **Запускаемый ресурс** выберите `Функция`.
  1. В блоке **Настройки Data Streams** выберите поток данных `postbox-events-stream` и сервисный аккаунт `yds-functions`.
  1. В блоке **Настройки функции** выберите функцию `postbox-webhook` и сервисный аккаунт `yds-functions`.
  1. Нажмите кнопку **Создать триггер**.

{% endlist %}


## Протестируйте работу решения {#test-solution}

1. Удобным вам способом [отправьте](../../postbox/operations/send-email.md#send-email) несколько тестовых писем с использованием адреса Yandex Cloud Postbox и статического ключа доступа, созданных ранее.
1. Убедитесь, что письма доставлены. Для этого проверьте почту, на которую вы отправляли эти письма.
1. Убедитесь, что данные об отправке писем поступают в сервисы:

    * Проверьте поток данных:

        {% list tabs group=instructions %}

        - Консоль управления {#console}

            1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете инфраструктуру.
            1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Data Streams**.
            1. Выберите поток данных `postbox-events-stream`.
            1. Перейдите на вкладку ![text-align-justify](../../_assets/console-icons/text-align-justify.svg) **Просмотр данных**.
            
                На графиках должны отобразиться события отправки писем.

        {% endlist %}

    * Посмотрите [логи функции](../../functions/operations/function/function-logs.md) и [графики мониторинга триггера](../../functions/operations/trigger/trigger-monitoring.md).
    * Убедитесь, что во внешней системе были вызваны вебхуки с данными о событиях по отправленным письмам.

В результате выполнения руководства вы сможете вызывать вебхуки внешней системы в ответ на события, связанные с отправкой писем через Yandex Cloud Postbox.


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../functions/operations/trigger/trigger-delete.md) триггер для вызова функции Cloud Functions.
1. [Удалите](../../functions/operations/function/function-delete.md) функцию Cloud Functions.
1. [Удалите](../../data-streams/operations/manage-streams.md#delete-data-stream) поток данных Data Streams.
1. [Удалите](../../ydb/operations/manage-databases.md#delete-db) базу данных Managed Service for YDB.
1. Удалите адрес и конфигурацию Yandex Cloud Postbox.
1. При необходимости [удалите](../../iam/operations/sa/delete.md) созданные сервисные аккаунты.
1. При необходимости удалите [ресурсную запись](../../dns/operations/resource-record-delete.md) и [публичную зону DNS](../../dns/operations/zone-delete.md).