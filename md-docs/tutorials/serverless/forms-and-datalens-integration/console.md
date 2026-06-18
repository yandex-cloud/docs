# Поставка данных из Яндекс Формы в Yandex DataLens с использованием Yandex Cloud Functions и Yandex Query при помощи консоли управления

# Поставка данных из Яндекс Формы в Yandex DataLens с использованием Yandex Cloud Functions и Yandex Query при помощи консоли управления


Чтобы настроить интеграцию Формы и DataLens через консоль управления:

1. [Подготовьте инфраструктуру](#prepare-infrastructure).
1. [Создайте функцию Yandex Cloud Functions](#create-function).
1. [Создайте форму в Формы](#create-form).
1. [Настройте подключение и привязку к данным в сервисе Yandex Query](#yq-integration).
1. [Настройте получение данных в DataLens](#set-up-datalens).
1. [Протестируйте интеграцию созданных ресурсов](#test-forms-integration).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#prepare-cloud}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за использование бакета Yandex Object Storage ([тарифы Object Storage](../../../storage/pricing.md));
* плата за хранение и запросы секретов Yandex Lockbox ([тарифы Yandex Lockbox](../../../lockbox/pricing.md));
* плата за вызовы функций и вычислительные ресурсы, выделенные для выполнения функций ([тарифы Cloud Functions](../../../functions/pricing.md));
* плата за объем считанных из источников данных при исполнении запросов Query ([тарифы Query](../../../query/pricing.md));
* плата за использование DataLens в соответствии с тарифным планом ([тарифы DataLens](../../../datalens/pricing.md)).

## Подготовьте инфраструктуру {#prepare-infrastructure}

### Создайте сервисный аккаунт {#create-service-account}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите нужный каталог.
  1. Перейдите в сервис **Identity and Access Management**.
  1. Нажмите кнопку **Создать сервисный аккаунт**.
  1. Введите имя [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md): `forms-integration-sa`.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роли: 
      * [lockbox.payloadViewer](../../../iam/roles-reference.md#lockbox-payloadViewer) — для чтения секретов Yandex Lockbox.
      * [functions.functionInvoker](../../../iam/roles-reference.md#functions-functionInvoker) — для вызова функции Cloud Functions.
      * [storage.editor](../../../iam/roles-reference.md#storage-editor) — для чтения и записи данных в бакет Object Storage.
      * [yq.viewer](../../../iam/roles-reference.md#query-viewer) и [yq.invoker](../../../iam/roles-reference.md#query-invoker) — для интеграции DataLens и Query.
  1. Нажмите кнопку **Создать**.

{% endlist %}

### Создайте бакет Object Storage {#create-s3-bucket}

В [бакете](../../../storage/concepts/bucket.md) Object Storage будут сохраняться данные из Формы. 

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите нужный каталог.
  1. Перейдите в сервис **Object Storage**.
  1. Нажмите кнопку **Создать бакет**.
  1. Введите **Имя** бакета.
  1. Нажмите кнопку **Создать бакет**.

{% endlist %}

### Назначьте сервисному аккаунту права доступа на бакет {#assign-access-rights-for-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите нужный каталог.
  1. Перейдите в сервис **Object Storage**.
  1. Откройте [созданный ранее](#create-s3-bucket) бакет.
  1. Перейдите в раздел **Объекты**.
  1. Нажмите на кнопку ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Настроить ACL**.
  1. В открывшемся окне **Редактирование ACL**:

      1. Начните вводить имя сервисного аккаунта `forms-integration` и выберите его из выпадающего списка.
      1. Выберите права доступа READ и WRITE .
      1. Нажмите кнопку **Добавить**.
      1. Нажмите кнопку **Сохранить**.

{% endlist %}

### Создайте статический ключ для сервисного аккаунта {#create-static-key-for-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите нужный каталог.
  1. Перейдите в сервис **Identity and Access Management**.
  1. Выберите сервисный аккаунт `forms-integration`.
  1. Перейдите в раздел **Обзор**.
  1. Нажмите кнопку **Создать новый ключ** и выберите **Создать статический ключ доступа**.  
  1. Нажмите кнопку **Создать**.
  1. В открывшемся окне **Новый ключ** отобразятся **Идентификатор ключа** и **Ваш секретный ключ**. Сохраните их — они понадобятся в дальнейшем.

{% endlist %}

### Создайте секрет Yandex Lockbox для статического ключа {#create-lockbox-secret}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите нужный каталог.
  1. Перейдите в сервис **Lockbox**.
  1. Нажмите кнопку **Создать секрет**.
  1. Введите **Имя** секрета — `static-key`.
  1. В блоке **Данные секрета**:
      1. Выберите **Тип секрета** — **Пользовательский**.
      1. Создайте следующие пары ключ-значение:
          * Идентификатор статического ключа:

              * **Ключ** — `static-key-id`.
              * **Значение** — выберите **Текст** и введите идентификатор статического ключа, созданного ранее.

          * Значение статического ключа:

              * **Ключ** — `static-key-value`.
              * **Значение** — выберите **Текст** и введите значение статического ключа, созданного ранее.

{% endlist %}

## Создайте и настройте функцию Cloud Functions {#set-up-function}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите нужный каталог.
  1. Перейдите в сервис **Cloud Functions**.
  1. Создайте функцию:
      1. Нажмите кнопку **Создать функцию** в правом верхнем углу.
      1. Введите **Имя** функции — `forms-function`.  
      1. Нажмите кнопку **Создать**.

  1. Создайте версию функции:  
      1. В открывшемся окне **Редактор** выберите среду исполнения — **Python**.
      1. Отключите опцию **Добавить файлы с примерами кода**.
      1. Нажмите кнопку **Продолжить**.
      1. Выберите **Источник кода** создания функции — **Редактор кода**.
      1. В окне редактора функции нажмите кнопку **Создать файл**.
      1. В открывшемся окне введите **Имя** файла — `forms-integration.py` и нажмите кнопку **Создать**.
      1. Вставьте в созданный файл `forms-integration.py` код функции:
          
          ```python
          import boto3
          import os
          import json
          from botocore.config import Config

          def get_answers(raw_answers: json) -> json:
              result = {}
              for name, value in raw_answers.get('answer').get('data').items():
                  if name.startswith('answer_choices_'):
                      choices = []
                      for c in value.get('value'):
                          choices.append(c.get('text'))
                      result[name] = ','.join(choices)
                  else:
                      result[name] = value.get('value')
              return result

          def handler(event, context):
              headers = event.get('headers')
              form_id = headers.get('X-Form-Id')
              answer_id = headers.get('X-Form-Answer-Id')

              body_json = json.loads(event.get('body'))
              answers_json = get_answers(body_json)

              aws_access_key_id = os.environ['KEY']
              aws_secret_access_key = os.environ['SECRET_KEY']
              bucket_name = os.environ['BUCKET']

              s3 = boto3.client(service_name='s3',
                                aws_access_key_id=aws_access_key_id,aws_secret_access_key=aws_secret_access_key,
                                endpoint_url='https://storage.yandexcloud.net', region_name='ru-central1',
                                config=Config(request_checksum_calculation="when_required"))

              s3.put_object(Bucket=bucket_name, Key=f"{form_id}/{answer_id}.json", Body=json.dumps(answers_json))

              return {
                  'statusCode': 200,
                  'body': "OK",
                  'headers': {
                      'Content-Type': 'text/plain',
                  }
              }

          ```
          
      1. В окне редактора функции нажмите кнопку **Создать файл**.
      1. В открывшемся окне введите **Имя** файла — `requirements.txt` и нажмите кнопку **Создать**.

      1. Укажите в созданном файле `requirements.txt` библиотеку `boto3` для работы с Object Storage из функции:

         ```
         boto3
         ```

      1. В поле **Точка входа** укажите `forms-integration.handler`.

      1. В поле **Сервисный аккаунт** выберите созданный ранее аккаунт `forms-integration-sa`.

      1. В блоке **Переменные окружения** создайте переменную с названием бакета, в который будут сохраняться результаты выполнения функции:

          1. **Ключ** — `BUCKET`.
          1. **Значение** — имя [созданного ранее](#create-s3-bucket) бакета.

      1. В блоке **Секреты Lockbox**:

          1. Создайте переменную `KEY` для идентификатора статического ключа со следующими параметрами:

              * **Переменная окружения** — `KEY`.
              * **Идентификатор секрета** — выберите секрет `static-key-id`.
              * **Идентификатор версии** — выберите версию с пометкой `latest`.
              * **Ключ секрета** — выберите `static-key-id`.

          1. Создайте переменную `SECRET_KEY` для идентификатора статического ключа со следующими параметрами:

              * **Переменная окружения** — `SECRET_KEY`.
              * **Идентификатор секрета** — выберите секрет `static-key-value`.
              * **Идентификатор версии** — выберите версию с пометкой `latest`.
              * **Ключ секрета** — выберите `static-key-value`.  

      1. После создания функции на вкладке **Обзор** включите опцию **Публичная функция**.
          

{% endlist %}

## Создайте и настройте форму Формы {#set-up-form}

### Создайте API-ключ {#create-api-key}

[API-ключ](../../../iam/concepts/authorization/api-key.md) нужен для настройки интеграции с Формы.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите нужный каталог.
  1. Перейдите в сервис **Identity and Access Management**.
  1. Выберите сервисный аккаунт `forms-integration`.
  1. Перейдите в раздел **Обзор**.
  1. Нажмите кнопку **Создать новый ключ** и выберите **Создать API-ключ**.  
  1. Нажмите кнопку **Создать**.
  1. В открывшемся окне **Новый ключ** отобразятся **Идентификатор ключа** и **Ваш секретный ключ**. Сохраните их — они понадобятся в дальнейшем.

{% endlist %}

### Создайте форму {#create-form}

{% list tabs group=instructions %}

- Интерфейс Формы {#forms}

  1. Перейдите в сервис [Формы](https://forms.yandex.ru/cloud/admin).

  1. Нажмите кнопку **Создать форму**.

  1. Добавьте в форму хотя бы два любых поля и настройте произвольные вопросы в них.

  1. Нажмите кнопку **Опубликовать**.

  1. Сохраните ссылку на опубликованную форму — она понадобится позднее.

{% endlist %}

### Настройте интеграцию с функцией Cloud Functions {#set-up-integration}

{% list tabs group=instructions %}

- Интерфейс Формы {#forms}

  1. Перейдите в сервис [Формы](https://forms.yandex.ru/cloud/admin).

  1. Откройте созданную ранее форму.

  1. Перейдите на вкладку **Настройки**.

  1. Откройте раздел **Дополнительно**.

  1. В блоке **Ключ для запуска облачных функций** введите данные [созданного ранее API-ключа](#create-api-key) и нажмите кнопку **Сохранить**.

  1. Откройте вкладку **Интеграции**.

  1. Нажмите кнопку **Cloud Functions**, чтобы добавить условие для интеграции.

  1. В поле **Код функции** введите идентификатор функции Cloud Functions. Вы можете скопировать идентификатор в разделе **Обзор** функции Cloud Functions в [консоли управления](https://console.yandex.cloud).

  1. В поле **Показывать сообщение о результате действия** выберите **Показывать**.

  1. Нажмите кнопку **Сохранить**.

{% endlist %}

### Проверьте работу созданной интеграции {#test-integration}

1. Перейдите по публичной ссылке созданной ранее формы.

1. Заполните форму и нажмите кнопку **Отправить**.

1. Перейдите в сервис [Формы](https://forms.yandex.ru/cloud/admin).

1. Откройте созданную ранее форму.

1. Откройте вкладку **Интеграции**.

1. Перейдите на страницу **Выполненные интеграции**.

1. Откройте запись о выполненном действии и убедитесь, что в разделе **Ответ** получен HTTP-ответ `200 — ОК`.

1. Перейдите в [консоль управления](https://console.yandex.cloud) и откройте [созданный ранее бакет](#create-s3-bucket). Убедитесь, что в нем появился JSON-файл с данными из заполненной формы.

   Название папки, в которой будет расположен файл, соответствует внутреннему идентификатору формы. Сохраните этот идентификатор — он понадобится для следующих шагов.

   Все последующие результаты заполнения формы будут сохраняться в этой папке.

1. Заполните форму еще несколько раз, причем одно из полей заполните одинаково хотя бы в двух формах. В дальнейшем это увеличит наглядность при тестировании интеграции.

## Настройте подключение и привязку к данным в сервисе Query {#yq-integration}

{% list tabs group=instruction %}

- Интерфейс Query {#yquery}

  1. Откройте [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Yandex Query**.
  1. На вкладке **Соединения** нажмите кнопку ![info](../../../_assets/console-icons/plus.svg) **Создать**.
  1. Создайте соединение со следующими параметрами:
      * **Имя** — `forms-connection`.
      * **Тип** — `Object Storage`.
      * **Бакет** — имя [созданного ранее](#create-s3-bucket) бакета.
      * **Сервисный аккаунт** — `forms-integration-sa`.
  1. В открывшемся окне задайте параметры привязки к данным:
      * **Тип** — `Object Storage`.
      * **Соединение** — `forms-connection`.
      * **Путь** — `/<идентификатор_формы>/`.
        Вы можете скопировать идентификатор:
          * В разделе **Объекты** бакета Object Storage. Название папки, в которой расположен файл с результатами заполнения формы, соответствует ее идентификатору.
          * В адресной строке [интерфейса Формы](https://forms.yandex.ru/cloud/admin) на странице просмотра или редактирования формы.        
      * **Формат** — `json_each-row`.
      * **Колонки** — создайте колонки для полей, которые вы задали в форме.
        Чтобы Query определил колонки самостоятельно, нажмите кнопку **Автоопределить колонки**.

{% endlist %}

## Настройте получение данных в DataLens {#set-up-datalens}

{% list tabs group=instructions %}

- Интерфейс DataLens {#datalens}

  1. Перейдите в [сервис DataLens](https://datalens.ru/promo).
  1. Нажмите **Начать в облаке**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/thunderbolt.svg) **Подключения** и нажмите кнопку **Создать подключение**.
  1. Перейдите в сервис **Yandex Query** и задайте в открывшемся окне следующие параметры:
      * **Облако и каталог** — выберите облако и каталог, в котором вы создали остальные ресурсы.
      * **Сервисный аккаунт** — `forms-integration-sa`.
  1. Нажмите кнопку **Сохранить изменения** и в открывшемся окне задайте имя подключения — `forms-datalens-connection`, затем нажмите кнопку **Создать**.
  1. Вернитесь на главную страницу [сервиса DataLens](https://datalens.ru/?skipPromo=true) и нажмите кнопку **Создать датасет**.
  1. На панели подключений нажмите ![icon](../../../_assets/console-icons/plus.svg) **Добавить** и выберите подключение `forms-datalens-connection`.
  1. В блоке **Таблицы** выберите нужную таблицу и перетащите ее в рабочую область DataLens.
      После загрузки данные из таблицы появятся на панели **Предпросмотр**.
  1. Нажмите кнопку **Сохранить** и введите имя датасета — `forms-integration-dataset`, затем нажмите кнопку **Создать**.

{% endlist %}

## Протестируйте интеграцию созданных ресурсов {#test-forms-integration}

Чтобы проверить совместную работу созданных ресурсов, откройте датасет `forms-integration-dataset` и нажмите кнопку **Создать чарт**. В открывшемся окне создайте произвольный чарт с данными, полученными из формы. Для большей наглядности постройте чарт по тому полю, в котором есть повторяющиеся значения.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. Чарт DataLens.
1. Датасет DataLens.
1. Подключение DataLens.
1. [Привязку Query](../../../query/operations/binding.md#delete).
1. [Соединение Query](../../../query/operations/connection.md#delete).
1. [Функцию Cloud Functions](../../../functions/operations/function/function-delete.md).
1. [Секрет Yandex Lockbox](../../../lockbox/operations/secret-delete.md).
1. [Бакеты Object Storage](../../../storage/operations/buckets/delete.md).