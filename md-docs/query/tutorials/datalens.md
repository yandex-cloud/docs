# Визуализация данных из Yandex Object Storage в Yandex DataLens


С помощью интеграции Yandex Query и Yandex DataLens можно визуализировать данные, хранимые в Yandex Object Storage. DataLens формирует запрос на языке YQL, Yandex Query исполняет запрос и возвращает результаты, которые визуализируются с помощью чартов.

Ниже приведена архитектура решения.

![datalens-architecture](../../_assets/datalens/data-lens-architecture.png)

Рассмотрим визуализацию зависимости количества и средней стоимости поездок Нью-Йоркского желтого такси от времени суток. Данные заранее размещены в Yandex Object Storage в общедоступном бакете `yq-sample-data` в каталоге `nyc_taxi_csv`.

{% note info %}

Yandex Cloud предоставляет набор данных — **поездки Нью-Йоркского такси** — на условиях “как есть” (as is). Yandex Cloud не дает никаких заверений, явных или подразумеваемых, гарантий или условий в отношении использования вами указанного датасета (набора данных). В пределах, разрешенных вашим местным законодательством, Yandex Cloud не несет никакой ответственности за любые убытки или ущерб, включая прямые, побочные, специальные, косвенные, случайные или штрафные, возникшие в результате использования вами датасета.

NYC Taxi and Limousine Commission (TLC):

Данные были собраны и предоставлены NYC Taxi and Limousine Commission (TLC) поставщиками технологий, уполномоченными в рамках Taxicab & Livery Passenger Enhancement Programs (TPEP/LPEP). Данные о поездке не были созданы TLC, и TLC не делает никаких заявлений относительно точности этих данных.

Ознакомьтесь с [Источником датасета](https://www1.nyc.gov/site/tlc/about/tlc-trip-record-data.page) и [Правилами его использования](https://www1.nyc.gov/home/terms-of-use.page).

{% endnote %}

Для визуализации и исследования данных [подготовьте облако к работе](#before-you-begin), затем выполните следующие шаги:

1. [Подключитесь к данным в Object Storage](#create_connection).
1. [Создайте подключение в Yandex DataLens](#create_connection_lens).
1. [Настройте поля датасета](#create_dataset).
1. [Настройте визуализацию](#create_comdo_chart).

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

{% note info %}

Для создания в DataLens подключения к Yandex Query требуется [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с [ролью](../../iam/operations/sa/assign-role-for-sa.md) `editor` на каталог, в котором будет [создано соединение](#create_connection) с [бакетом](../../storage/concepts/bucket.md) Object Storage.

{% endnote %}

## Подключитесь к данным в Object Storage {#create_connection}

1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно создать [соединение](../concepts/glossary.md#connection).

   ![select-catalog](../../_assets/datalens/yandex-query-visualization/select-catalog.png)

1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex Query**.

   ![select-yq](../../_assets/datalens/yandex-query-visualization/select-yq.png)

1. На панели слева выберите ![study](../../_assets/console-icons/graduation-cap.svg) **Учебник**.
1. Нажмите кнопку **Создать соединение**. В блоке создания соединения все поля ввода параметров уже заполнены — введите описание (опционально) и нажмите кнопку **Создать**. Вы перейдете на экран создания [привязки](../concepts/glossary.md#binding) к данным.
1. Введите описание привязки к данным (опционально) и нажмите кнопку **Создать**. Будут созданы нужные для обучения ресурсы.

## Создайте подключение в Yandex DataLens {#create_connection_lens}

Чтобы создать подключение к Yandex Query:

1. Перейдите на [главную страницу](https://datalens.ru/?skipPromo=true) DataLens.
1. На панели слева выберите ![image](../../_assets/console-icons/thunderbolt.svg) **Подключения** и нажмите кнопку **Создать подключение**.
1. Выберите подключение **Yandex Query**.
1. Укажите параметры подключения:

   * **Облако и каталог**. Выберите каталог, в котором находится ваш сервисный аккаунт.
   * **Сервисный аккаунт**. Выберите существующий [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) или создайте новый.
   * **Время жизни кеша в секундах**. Укажите время жизни кеша или оставьте значение по умолчанию.
   * **Уровень доступа SQL запросов**. Выберите вариант **Разрешить подзапросы из датасетов и запросы из чартов**.

1. Нажмите кнопку **Создать подключение**.
1. Введите имя подключения `yq-connect` и нажмите **Создать**.

## Настройте поля датасета {#create_dataset}

1. На странице создания подключения в правом верхнем углу нажмите кнопку **Создать датасет**.

   ![create-dataset](../../_assets/datalens/yandex-query-visualization/create-dataset.png)

1. В открывшемся окне введите текст запроса, указанный ниже, и нажмите кнопку **Создать**.

   ```sql
   SELECT 
       *
   FROM 
       bindings.`tutorial-analytics`
   ```

   Если все настроено правильно, то в нижней части экрана в блоке **Предпросмотр** появятся данные следующего вида:

   ![dataset-results](../../_assets/datalens/yandex-query-visualization/datalens-dataset-results.png)

1. Создайте вычисляемое поле, содержащее данные часа посадки:

   1. Перейдите на вкладку **Поля** и нажмите кнопку **Добавить поле**.

      ![create-field](../../_assets/datalens/yandex-query-visualization/create-field.png)

   1. В поле **Название поля** укажите `hour_trip`.
   1. В строке формул введите:

      ```sql
      HOUR([tpep_pickup_datetime])
      ```

   1. Нажмите кнопку **Создать**. Новое поле `hour_trip` отобразится в списке полей датасета.

1. В столбце **Агрегация** для поля `total_amount` выберите тип агрегации **Среднее**.

   ![field-agg](../../_assets/datalens/yandex-query-visualization/field-agg.png)

1. В правом верхнем углу нажмите кнопку **Сохранить**. Введите имя датасета `yellow-taxi-dataset` и нажмите **Создать**.
1. После сохранения датасета в правом верхнем углу нажмите **Создать чарт**.

   ![create-chart](../../_assets/datalens/yandex-query-visualization/create-chart.png)

## Настройте визуализацию {#create_comdo_chart}

Для визуализации и исследования используйте [чарт](../../datalens/concepts/chart/index.md) типа [комбинированная диаграмма](../../datalens/visualization-ref/combined-chart.md).

1. Выберите тип визуализации **Комбинированная диаграмма**.

   ![chart-type](../../_assets/datalens/yandex-query-visualization/chart-type.png)

1. Перетащите измерение `hour_trip` в секцию **X**. Измерение в секции **X** будет общим для всех слоев.
1. Для первого слоя выберите тип **Столбчатая диаграмма**.

   ![select-layer-column](../../_assets/datalens/yandex-query-visualization/select-layer-column.png)

1. Перетащите показатель `total_amount` в секцию **Y**. В области визуализации отобразится столбчатая диаграмма.
1. Добавьте слой. Для этого нажмите значок ![plus](../../_assets/console-icons/plus.svg) справа от названия первого слоя.
1. Для второго слоя выберите тип **Линейная диаграмма**.

   ![select-layer-line](../../_assets/datalens/yandex-query-visualization/select-layer-line.png)

1. Добавьте в чарт поле:

   1. Вверху слева нажмите ![plus](../../_assets/console-icons/plus.svg) и выберите **Поле**.

      ![chart-add-field](../../_assets/datalens/yandex-query-visualization/chart-add-field.png)

   1. В открывшемся окне введите:

      * В поле **Название поля** — `count_trip`.
      * В строке формул — `COUNT()`.

        ![chart-field-create](../../_assets/datalens/yandex-query-visualization/chart-field-create.png)

   1. Нажмите кнопку **Создать**.

1. Перетащите новый показатель `count_trip` в секцию **Y2**. В области визуализации поверх первой диаграммы отобразится линейная диаграмма.
1. В правом верхнем углу нажмите кнопку **Сохранить**. Введите имя чарта `yellow-taxi-combo-chart` и нажмите **Сохранить**.

В созданном чарте прослеживается зависимость количества поездок (линейная диаграмма) и средней стоимости поездок (столбчатая диаграмма) от времени суток.

![datalens-yq-combo-chart](../../_assets/datalens/yandex-query-visualization/datalens-yq-combo-chart.png)

Аналогичным образом вы можете построить дополнительные [чарты](../../datalens/operations/chart/create-chart.md) и [дашборды](../../datalens/operations/dashboard/create.md) и [поделиться результатом](../../datalens/concepts/datalens-public.md) с коллегами.

Визуализация данных из Yandex Object Storage с помощью Yandex Query:


<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvsneufm7vvvqjtec2?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

[Смотреть видео на YouTube](https://www.youtube.com/watch?v=17cAGgG2YFU).