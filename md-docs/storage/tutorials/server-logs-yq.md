# Получение статистики запросов к объектам Object Storage с использованием Yandex Query

# Получение статистики запросов к объектам Yandex Object Storage с использованием Yandex Query


Из этого руководства вы узнаете, как получить статистику запросов к объектам [Yandex Object Storage](../index.md) с использованием [Yandex Query](../../query/index.md). Вы создадите бакет и настроите логирование в Object Storage, создадите соединение в Query и получите статистику с помощью SQL-запросов.

Чтобы получить статистику:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте бакеты](#create-buckets).
1. [Включите механизм логирования](#enable-logging).
1. [Настройте подключения в Query](#create-connection).
1. [Получите статистику запросов](#get-statistics).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за хранение данных (см. [тарифы Yandex Object Storage](../pricing.md));
* плата за объем считанных данных (см. [тарифы Yandex Query](../../query/pricing.md)).

### Создайте сервисный аккаунт {#create-sa}

С помощью сервисного аккаунта Query сможет отправлять запросы к Object Storage.

[Создайте](../../iam/operations/sa/create.md) сервисный аккаунт с именем `yq-sa` и [назначьте](../../iam/operations/roles/grant.md) ему роли `storage.viewer` и `yq.editor`.

## Создайте бакеты {#create-buckets}

Создайте два бакета: `object-bucket` и `logs-bucket`. Один бакет будет служить источником данных, другой — хранилищем логов. 

Чтобы создать бакет:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать бакет.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Object Storage**.
  1. Справа сверху нажмите кнопку **Создать бакет**.
  1. В поле **Имя** укажите имя бакета `object-bucket`.
  1. Нажмите кнопку **Создать бакет**.

  Аналогичным образом создайте бакет с именем `logs-bucket`.

{% endlist %}

## Включите механизм логирования {#enable-logging}

Чтобы получать информацию о запросах к объектам, включите [механизм логирования действий с бакетом](../concepts/server-logs.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создали бакеты.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Object Storage**.
  1. Выберите бакет `object-bucket`.
  1. [Включите механизм логирования](../operations/buckets/enable-logging.md#enable):

      1. На панели слева выберите ![image](../../_assets/console-icons/wrench.svg) **Настройки**.
      1. Перейдите на вкладку **Логирование**.
      1. Включите опцию **Запись логов**.
      1. В поле **Бакет для хранения логов** выберите бакет `logs-bucket`.
      1. Нажмите кнопку **Сохранить**.

  1. На панели слева выберите ![image](../../_assets/console-icons/folder-tree.svg) **Объекты** и [загрузите](../operations/objects/upload.md) объекты. Например, пару простых текстовых файлов.

{% endlist %}

## Настройте подключения в Query {#create-connection}

Чтобы получать данные из Object Storage, создайте [соединение](../../query/concepts/glossary.md#connection) и [привязку](../../query/concepts/glossary.md#binding):

{% list tabs group=instructions %}

- Интерфейс Yandex Query {#console}

  1. Перейдите в сервис [Query](https://yq.yandex.cloud/).
  1. На панели слева выберите **Соединения**.
  1. Нажмите кнопку ![info](../../_assets/console-icons/plus.svg) **Создать**.
  1. Введите имя соединения, например `bucket-logs-connection`.
  1. Выберите тип соединения **Object Storage** и укажите **Параметры типа соединения**.
  1. В поле **Аутентификация бакета** выберите `Приватный` и задайте параметры:

      * **Облако и каталог** — выберите облако и каталог, в которых вы создали бакеты.
      * **Бакет** — `logs-bucket`.
      * **Сервисный аккаунт** — `yq-sa`.

  1. Нажмите кнопку **Проверить**. После успешной проверки нажмите кнопку **Создать**.
  1. Нажмите кнопку **Автоматически заполнить настройки для** и в выпадающем списке выберите **Object Storage Access Logs**.

      1. Введите имя привязки, например `bucket-logs-binding`.
      1. В поле **Путь** укажите путь к данным статистики внутри бакета. Если данные статистики хранятся в корневой директории бакета, укажите `/`.
      1. Нажмите кнопку **Предпросмотр** для проверки правильности настроек.
      1. Нажмите кнопку **Создать** для завершения создания привязки.

{% endlist %}

## Получите статистику запросов {#get-statistics}

Используйте соединение, чтобы создать SQL-запросы и получить статистику запросов к объектам Object Storage:

{% list tabs group=instructions %}

- Интерфейс Yandex Query {#console}

  1. Перейдите в сервис [Query](https://yq.yandex.cloud/).
  1. На панели слева выберите **Соединения**.
  1. Выберите соединение `bucket-logs-connection`.
  1. В редакторе справа введите запрос:

      ```sql
      SELECT `timestamp`, request_id, handler, object_key, status, request_time
      FROM `bucket-logs-binding`
      LIMIT 100;
      ```

      Такой запрос вернет 100 записей со статистикой запросов к объектам Object Storage. Лимит записей можно снять, а результаты фильтровать с помощью `WHERE`.

  1. Нажмите кнопку ![image](../../_assets/console-icons/play-fill.svg) **Выполнить** и посмотрите результат.

{% endlist %}

### Примеры запросов {#examples}

#### Поиск запросов по коду ответа {#request-code}

```sql
SELECT `timestamp`, request_id, handler, object_key, status, request_time
FROM `bucket-logs-binding`
WHERE status >= 400
```

#### Поиск долго обрабатываемых запросов {#request-long}

```sql
SELECT `timestamp`, request_id, handler, object_key, status, request_time
FROM `bucket-logs-binding`
WHERE request_time >= 1000
```

#### Среднее время обработки запросов {#request-average}

В примере используется агрегатная функция `AVG`.

```sql
SELECT AVG(request_time) AS `avg` FROM `bucket-logs-binding`
```

## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить работу инфраструктуры и перестать платить за созданные ресурсы:

1. [Удалите](../../query/operations/binding.md#delete) привязку.
1. [Удалите](../../query/operations/connection.md#delete) соединение.
1. [Удалите](../operations/objects/delete.md) объекты в бакетах.
1. [Удалите](../operations/buckets/delete.md) бакеты.