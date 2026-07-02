[Документация Yandex Cloud](../index.md) > Yandex DataLens > DataLens

# Yandex DataLens

Yandex DataLens — это сервис бизнес-аналитики для визуализации ваших данных. Подключайтесь к различным источникам и визуализируйте данные, собирайте дашборды и формируйте отчеты в виде интерактивных презентаций.

Отслеживайте ключевые продуктовые и бизнес-метрики в реальном времени, делитесь результатами с командой и принимайте обоснованные решения.

Используйте Нейроаналитика для автоматического анализа данных, получения инсайтов, создания и редактирования визуализаций.

# Yandex DataLens

## Знакомство с сервисом

 - [Обзор сервиса](concepts/index.md)

 - [Начало работы](quickstart.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Обучающие курсы](training.md)

## Воркбуки и коллекции

 - [Обзор](workbooks-collections/index.md)

 - [Работа с воркбуком](workbooks-collections/workbooks-operations.md)

 - [Работа с коллекцией](workbooks-collections/collections-operations.md)

 - [Миграция объектов в воркбуки из папок](workbooks-collections/migrations.md)

 - [Экспорт и импорт воркбуков](workbooks-collections/export-and-import.md)

 - [Ошибки и предупреждения при экспорте и импорте](workbooks-collections/export-import-notifications.md)

 - [Нейроаналитик DataLens](concepts/neuroanalyst.md)

## Практические руководства

 - [Обзор](tutorials/index.md)

### Знакомство с DataLens

 - [Простой дашборд из CSV-файла](tutorials/data-from-csv-visualization.md)

 - [Публичный чарт с картой Москвы из CSV-файла](tutorials/data-from-csv-to-public-visualization.md)

 - [Дашборд сети магазинов из БД ClickHouse®](tutorials/data-from-ch-visualization.md)

### Работа с геоданными

 - [Анализ открытых данных ДТП на дорогах России](tutorials/data-from-csv-geo-visualization.md)

 - [Анализ продаж и локаций пиццерий на данных из БД ClickHouse® и Галереи DataLens](tutorials/data-from-ch-to-geolayers-visualization.md)

 - [Геокодинг с помощью API Яндекс Карт для визуализации в DataLens](tutorials/data-from-ch-geocoder.md)

 - [Визуализация данных с использованием инструмента Тепловые карты](tutorials/data-on-heat-map-dashboard.md)

 - [Мониторинг состояния географически распределенных устройств](tutorials/datalens.md)

### Аналитика сервисов

 - [Яндекс Метрика: прямое подключение](tutorials/data-from-metrica-visualization.md)

 - [Яндекс Метрика: экспорт, постобработка и визуализация данных](tutorials/data-from-metrica-yc-visualization.md)

 - [AppMetrica: прямое подключение](tutorials/data-from-appmetrica-visualization.md)

 - [AppMetrica: экспорт, постобоработка и визуализация данных](tutorials/data-from-appmetrica-yc-visualization.md)

 - [Битрикс24: прямое подключение](tutorials/data-from-bitrix24-visualization.md)

 - [Яндекс Трекер: экспорт и визуализация данных](tutorials/data-from-tracker.md)

 - [Анализ логов Object Storage при помощи DataLens](tutorials/storage-logs-analysis.md)

 - [Подкасты Яндекс Музыки: статистика](tutorials/data-from-podcasts.md)

 - [Визуализация данных Yandex Query](tutorials/data-from-yandex-query-visualization.md)

 - [Визуализация данных Yandex Monitoring](tutorials/data-from-monitoring-visualization.md)

 - [Визуализация данных из YTsaurus CHYT](tutorials/data-from-ch-over-yt.md)

 - [Передача событий Yandex Cloud Postbox в Yandex Data Streams и их анализ с помощью Yandex DataLens](tutorials/events-from-postbox-to-yds.md)

#### Поставка данных из Яндекс Формы в Yandex DataLens с использованием Yandex Cloud Functions и Yandex Query

 - [Обзор](tutorials/forms-and-datalens-integration/index.md)

 - [Консоль управления](tutorials/forms-and-datalens-integration/console.md)

 - [Terraform](tutorials/forms-and-datalens-integration/terraform.md)

 - [Миграция базы данных из Google BigQuery в Managed Service for ClickHouse®](tutorials/bigquery-to-clickhouse.md)

### Функциональные

 - [Использование параметров в вычисляемых полях](tutorials/data-from-ch-with-parameters.md)

 - [Параметризация источников](tutorials/data-from-ch-dataset-parametrization.md)

 - [Примеры создания QL-чартов](tutorials/data-from-ch-to-sql-chart.md)

 - [Примеры создания чартов в Editor](tutorials/create-chart-editor.md)

 - [Пример использования вкладки Activities в Editor](tutorials/create-editor-activities.md)

## Подключения

 - [Обзор](concepts/connection/index.md)

 - [Версионирование](concepts/connection/versioning.md)

 - [Кеширование](concepts/caching.md)

 - [Объединение данных](concepts/data-join.md)

 - [Добавление информации о подключении](operations/connection/add-description.md)

### Базы данных

 - [Создание подключения к ClickHouse®](operations/connection/create-clickhouse.md)

 - [Создание подключения к PostgreSQL](operations/connection/create-postgresql.md)

 - [Создание подключения к MySQL®](operations/connection/create-mysql.md)

 - [Создание подключения к YDB](operations/connection/create-ydb.md)

#### Создание подключения к YTsaurus CHYT

 - [Подключение](operations/connection/chyt/create-chyt.md)

 - [Особенности JOIN](operations/connection/chyt/chyt-global-join.md)

 - [Рекомендации](operations/connection/chyt/chyt-recommendations.md)

 - [Создание подключения к Greenplum®](operations/connection/create-greenplum.md)

 - [Создание подключения к SQL Server](operations/connection/create-mssql-server.md)

 - [Создание подключения к Oracle Database](operations/connection/create-oracle.md)

 - [Создание подключения к StarRocks](operations/connection/create-starrocks.md)

 - [Создание подключения к Prometheus](operations/connection/create-prometheus.md)

 - [Создание подключения к Snowflake](operations/connection/create-snowflake.md)

 - [Создание подключения к Trino](operations/connection/create-trino.md)

### Файлы и сервисы

 - [Создание подключения к файлам](operations/connection/create-file.md)

 - [Создание подключения к Яндекс Документам](operations/connection/create-yadocs.md)

 - [Создание подключения к Google Sheets](operations/connection/create-google-sheets.md)

 - [Создание подключения к Yandex Query](operations/connection/create-yandex-query.md)

 - [Создание подключения к Metrica API](operations/connection/create-metrica-api.md)

 - [Создание подключения к AppMetrica](operations/connection/create-appmetrica.md)

 - [Создание подключения к Yandex Cloud Billing](operations/connection/create-cloud-billing.md)

 - [Создание подключения к Yandex Monitoring](operations/connection/create-monitoring.md)

#### Создание подключения к DataLens Usage Analytics

 - [Обзор](concepts/datalens-usage-analytics.md)

 - [Подключение](operations/connection/create-usage-tracking.md)

 - [Создание подключения API Connector](operations/connection/create-api-connector.md)

 - [Создание подключения к SpeechSense](operations/connection/create-speechsense.md)

### Партнерские подключения

 - [Создание подключения к Экстрактору 1С](operations/connection/create-extractor1c.md)

 - [Создание подключения к Битрикс24](operations/connection/create-bitrix24.md)

 - [Создание подключения к подкастам Яндекс Музыки](operations/connection/create-podcasts.md)

 - [Предложить свой партнерский коннектор](operations/marketplace/create-connector-for-partners.md)

## Датасеты

 - [Обзор](dataset/index.md)

 - [Работа с датасетом](dataset/create-dataset.md)

 - [Модель данных](dataset/data-model.md)

 - [Настройки датасета](dataset/settings.md)

 - [Версионирование](dataset/versioning.md)

 - [Добавление информации о датасете](dataset/add-description.md)

 - [Параметризация источников](dataset/parametrization.md)

 - [Инвалидация кешей](dataset/cache-invalidation.md)

 - [Типы данных](dataset/data-types.md)

 - [Соответствие типов данных](dataset/types-lookup-table.md)

## Вычисляемые поля

 - [Обзор](concepts/calculations/index.md)

 - [Синтаксис формул](concepts/calculations/formula-syntax.md)

 - [Нейроаналитик для создания вычисляемых полей](concepts/calculations/formulas-helper.md)

### Справочник функций

 - [Все функции](function-ref/all.md)

#### Агрегатные функции

 - [Обзор](function-ref/aggregation-functions.md)

 - [ALL_CONCAT](function-ref/ALL_CONCAT.md)

 - [ANY](function-ref/ANY.md)

 - [ARG_MAX](function-ref/ARG_MAX.md)

 - [ARG_MIN](function-ref/ARG_MIN.md)

 - [AVG](function-ref/AVG.md)

 - [AVG_IF](function-ref/AVG_IF.md)

 - [COUNT](function-ref/COUNT.md)

 - [COUNTD](function-ref/COUNTD.md)

 - [COUNTD_APPROX](function-ref/COUNTD_APPROX.md)

 - [COUNTD_IF](function-ref/COUNTD_IF.md)

 - [COUNT_IF](function-ref/COUNT_IF.md)

 - [MAX](function-ref/MAX.md)

 - [MEDIAN](function-ref/MEDIAN.md)

 - [MIN](function-ref/MIN.md)

 - [QUANTILE](function-ref/QUANTILE.md)

 - [QUANTILE_APPROX](function-ref/QUANTILE_APPROX.md)

 - [STDEV](function-ref/STDEV.md)

 - [STDEVP](function-ref/STDEVP.md)

 - [SUM](function-ref/SUM.md)

 - [SUM_IF](function-ref/SUM_IF.md)

 - [TOP_CONCAT](function-ref/TOP_CONCAT.md)

 - [VAR](function-ref/VAR.md)

 - [VARP](function-ref/VARP.md)

#### Логические функции

 - [Обзор](function-ref/logical-functions.md)

 - [CASE](function-ref/CASE.md)

 - [IF](function-ref/IF.md)

 - [IFNULL](function-ref/IFNULL.md)

 - [ISNULL](function-ref/ISNULL.md)

 - [ZN](function-ref/ZN.md)

#### Математические функции

 - [Обзор](function-ref/numeric-functions.md)

 - [ABS](function-ref/ABS.md)

 - [ACOS](function-ref/ACOS.md)

 - [ASIN](function-ref/ASIN.md)

 - [ATAN](function-ref/ATAN.md)

 - [ATAN2](function-ref/ATAN2.md)

 - [CEILING](function-ref/CEILING.md)

 - [COMPARE](function-ref/COMPARE.md)

 - [COS](function-ref/COS.md)

 - [COT](function-ref/COT.md)

 - [DEGREES](function-ref/DEGREES.md)

 - [DIV](function-ref/DIV.md)

 - [DIV_SAFE](function-ref/DIV_SAFE.md)

 - [EXP](function-ref/EXP.md)

 - [FDIV_SAFE](function-ref/FDIV_SAFE.md)

 - [FLOOR](function-ref/FLOOR.md)

 - [GREATEST](function-ref/GREATEST.md)

 - [LEAST](function-ref/LEAST.md)

 - [LN](function-ref/LN.md)

 - [LOG](function-ref/LOG.md)

 - [LOG10](function-ref/LOG10.md)

 - [PI](function-ref/PI.md)

 - [POWER](function-ref/POWER.md)

 - [RADIANS](function-ref/RADIANS.md)

 - [ROUND](function-ref/ROUND.md)

 - [SIGN](function-ref/SIGN.md)

 - [SIN](function-ref/SIN.md)

 - [SQRT](function-ref/SQRT.md)

 - [SQUARE](function-ref/SQUARE.md)

 - [TAN](function-ref/TAN.md)

#### Нативные функции

 - [Обзор](function-ref/native-functions.md)

 - [DB_CALL_AGG_FLOAT](function-ref/DB_CALL_AGG_FLOAT.md)

 - [DB_CALL_AGG_INT](function-ref/DB_CALL_AGG_INT.md)

 - [DB_CALL_AGG_STRING](function-ref/DB_CALL_AGG_STRING.md)

 - [DB_CALL_ARRAY_FLOAT](function-ref/DB_CALL_ARRAY_FLOAT.md)

 - [DB_CALL_ARRAY_INT](function-ref/DB_CALL_ARRAY_INT.md)

 - [DB_CALL_ARRAY_STRING](function-ref/DB_CALL_ARRAY_STRING.md)

 - [DB_CALL_BOOL](function-ref/DB_CALL_BOOL.md)

 - [DB_CALL_FLOAT](function-ref/DB_CALL_FLOAT.md)

 - [DB_CALL_INT](function-ref/DB_CALL_INT.md)

 - [DB_CALL_STRING](function-ref/DB_CALL_STRING.md)

#### Оконные функции

 - [Обзор](function-ref/window-functions.md)

 - [AVG](function-ref/AVG_WINDOW.md)

 - [AVG_IF](function-ref/AVG_IF_WINDOW.md)

 - [COUNT](function-ref/COUNT_WINDOW.md)

 - [COUNT_IF](function-ref/COUNT_IF_WINDOW.md)

 - [FIRST](function-ref/FIRST.md)

 - [LAG](function-ref/LAG.md)

 - [LAST](function-ref/LAST.md)

 - [MAVG](function-ref/MAVG.md)

 - [MAX](function-ref/MAX_WINDOW.md)

 - [MCOUNT](function-ref/MCOUNT.md)

 - [MIN](function-ref/MIN_WINDOW.md)

 - [MMAX](function-ref/MMAX.md)

 - [MMIN](function-ref/MMIN.md)

 - [MSUM](function-ref/MSUM.md)

 - [RANK](function-ref/RANK.md)

 - [RANK_DENSE](function-ref/RANK_DENSE.md)

 - [RANK_PERCENTILE](function-ref/RANK_PERCENTILE.md)

 - [RANK_UNIQUE](function-ref/RANK_UNIQUE.md)

 - [RAVG](function-ref/RAVG.md)

 - [RCOUNT](function-ref/RCOUNT.md)

 - [RMAX](function-ref/RMAX.md)

 - [RMIN](function-ref/RMIN.md)

 - [RSUM](function-ref/RSUM.md)

 - [SUM](function-ref/SUM_WINDOW.md)

 - [SUM_IF](function-ref/SUM_IF_WINDOW.md)

#### Операторы

 - [Обзор](function-ref/operator-functions.md)

 - [AND](function-ref/AND.md)

 - [BETWEEN](function-ref/BETWEEN.md)

 - [IN](function-ref/IN.md)

 - [IS FALSE](function-ref/ISFALSE.md)

 - [IS TRUE](function-ref/ISTRUE.md)

 - [LIKE](function-ref/LIKE.md)

 - [NOT](function-ref/OP_NOT.md)

 - [OR](function-ref/OR.md)

 - [Вычитание (-)](function-ref/OP_MINUS.md)

 - [Деление (/)](function-ref/OP_DIV.md)

 - [Остаток (%)](function-ref/OP_MOD.md)

 - [Отрицание (-)](function-ref/OP_NEGATION.md)

 - [Сложение и конкатенация (+)](function-ref/OP_PLUS.md)

 - [Сравнение](function-ref/OP_COMPARISON.md)

 - [Степень (^)](function-ref/OP_POWER.md)

 - [Умножение (*)](function-ref/OP_MULT.md)

#### Строковые функции

 - [Обзор](function-ref/string-functions.md)

 - [ASCII](function-ref/ASCII.md)

 - [CHAR](function-ref/CHAR.md)

 - [CONCAT](function-ref/CONCAT.md)

 - [CONTAINS](function-ref/CONTAINS.md)

 - [ENDSWITH](function-ref/ENDSWITH.md)

 - [FIND](function-ref/FIND.md)

 - [ICONTAINS](function-ref/ICONTAINS.md)

 - [IENDSWITH](function-ref/IENDSWITH.md)

 - [ISTARTSWITH](function-ref/ISTARTSWITH.md)

 - [LEFT](function-ref/LEFT.md)

 - [LEN](function-ref/LEN.md)

 - [LOWER](function-ref/LOWER.md)

 - [LTRIM](function-ref/LTRIM.md)

 - [REGEXP_EXTRACT](function-ref/REGEXP_EXTRACT.md)

 - [REGEXP_EXTRACT_ALL](function-ref/REGEXP_EXTRACT_ALL.md)

 - [REGEXP_EXTRACT_NTH](function-ref/REGEXP_EXTRACT_NTH.md)

 - [REGEXP_MATCH](function-ref/REGEXP_MATCH.md)

 - [REGEXP_REPLACE](function-ref/REGEXP_REPLACE.md)

 - [REPLACE](function-ref/REPLACE.md)

 - [RIGHT](function-ref/RIGHT.md)

 - [RTRIM](function-ref/RTRIM.md)

 - [SPACE](function-ref/SPACE.md)

 - [SPLIT](function-ref/SPLIT.md)

 - [STARTSWITH](function-ref/STARTSWITH.md)

 - [SUBSTR](function-ref/SUBSTR.md)

 - [TRIM](function-ref/TRIM.md)

 - [UPPER](function-ref/UPPER.md)

 - [UTF8](function-ref/UTF8.md)

#### Функции даты и времени

 - [Обзор](function-ref/date-functions.md)

 - [DATEADD](function-ref/DATEADD.md)

 - [DATEPART](function-ref/DATEPART.md)

 - [DATETRUNC](function-ref/DATETRUNC.md)

 - [DAY](function-ref/DAY.md)

 - [DAYOFWEEK](function-ref/DAYOFWEEK.md)

 - [HOUR](function-ref/HOUR.md)

 - [MINUTE](function-ref/MINUTE.md)

 - [MONTH](function-ref/MONTH.md)

 - [NOW](function-ref/NOW.md)

 - [QUARTER](function-ref/QUARTER.md)

 - [SECOND](function-ref/SECOND.md)

 - [TODAY](function-ref/TODAY.md)

 - [WEEK](function-ref/WEEK.md)

 - [YEAR](function-ref/YEAR.md)

#### Функции для работы с временными рядами

 - [Обзор](function-ref/time-series-functions.md)

 - [AGO](function-ref/AGO.md)

 - [AT_DATE](function-ref/AT_DATE.md)

#### Функции для работы с массивами

 - [Обзор](function-ref/array-functions.md)

 - [ARRAY](function-ref/ARRAY.md)

 - [ARR_AVG](function-ref/ARR_AVG.md)

 - [ARR_DISTINCT](function-ref/ARR_DISTINCT.md)

 - [ARR_INDEX_OF](function-ref/ARR_INDEX_OF.md)

 - [ARR_INTERSECT](function-ref/ARR_INTERSECT.md)

 - [ARR_MAX](function-ref/ARR_MAX.md)

 - [ARR_MIN](function-ref/ARR_MIN.md)

 - [ARR_PRODUCT](function-ref/ARR_PRODUCT.md)

 - [ARR_REMOVE](function-ref/ARR_REMOVE.md)

 - [ARR_STR](function-ref/ARR_STR.md)

 - [ARR_SUM](function-ref/ARR_SUM.md)

 - [CAST_ARR_FLOAT](function-ref/CAST_ARR_FLOAT.md)

 - [CAST_ARR_INT](function-ref/CAST_ARR_INT.md)

 - [CAST_ARR_STR](function-ref/CAST_ARR_STR.md)

 - [CONTAINS](function-ref/CONTAINS_ARRAY.md)

 - [CONTAINS_ALL](function-ref/CONTAINS_ALL.md)

 - [CONTAINS_ANY](function-ref/CONTAINS_ANY.md)

 - [CONTAINS_SUBSEQUENCE](function-ref/CONTAINS_SUBSEQUENCE.md)

 - [COUNT_ITEM](function-ref/COUNT_ITEM.md)

 - [GET_ITEM](function-ref/GET_ITEM.md)

 - [LEN](function-ref/LEN_ARRAY.md)

 - [REPLACE](function-ref/REPLACE_ARRAY.md)

 - [SLICE](function-ref/SLICE.md)

 - [STARTSWITH](function-ref/STARTSWITH_ARRAY.md)

 - [UNNEST](function-ref/UNNEST.md)

#### Функции преобразования типов

 - [Обзор](function-ref/type-conversion-functions.md)

 - [BOOL](function-ref/BOOL.md)

 - [DATE](function-ref/DATE.md)

 - [DATETIME](function-ref/DATETIME.md)

 - [DATETIME_PARSE](function-ref/DATETIME_PARSE.md)

 - [DATE_PARSE](function-ref/DATE_PARSE.md)

 - [DB_CAST](function-ref/DB_CAST.md)

 - [FLOAT](function-ref/FLOAT.md)

 - [GEOPOINT](function-ref/GEOPOINT.md)

 - [GEOPOLYGON](function-ref/GEOPOLYGON.md)

 - [INT](function-ref/INT.md)

 - [STR](function-ref/STR.md)

 - [TREE](function-ref/TREE.md)

#### Функции разметки

 - [Обзор](function-ref/markup-functions.md)

 - [BOLD](function-ref/BOLD.md)

 - [BR](function-ref/BR.md)

 - [COLOR](function-ref/COLOR.md)

 - [IMAGE](function-ref/IMAGE.md)

 - [ITALIC](function-ref/ITALIC.md)

 - [MARKUP](function-ref/MARKUP.md)

 - [SIZE](function-ref/SIZE.md)

 - [TOOLTIP](function-ref/TOOLTIP.md)

 - [URL](function-ref/URL.md)

 - [USER_INFO](function-ref/USER_INFO.md)

#### Хеш-функции

 - [Обзор](function-ref/hash-functions.md)

 - [CITYHASH64](function-ref/CITYHASH64.md)

 - [INTHASH64](function-ref/INTHASH64.md)

 - [MD5](function-ref/MD5.md)

 - [MURMURHASH2_64](function-ref/MURMURHASH2_64.md)

 - [SHA1](function-ref/SHA1.md)

 - [SHA256](function-ref/SHA256.md)

 - [SIPHASH64](function-ref/SIPHASH64.md)

 - [Поддержка функций](function-ref/availability.md)

### Примеры использования функций

 - [Агрегатные функции](concepts/aggregation-tutorial.md)

 - [Оконные функции](concepts/window-function-tutorial.md)

 - [LOD-выражения и управление фильтрацией в агрегатных функциях](concepts/lod-aggregation.md)

 - [Функции для работы с временными рядами](concepts/time-series-functions.md)

 - [Параметры](concepts/parameters.md)

## Чарты

 - [Обзор](concepts/chart/index.md)

### Чарты в визарде

 - [Обзор](concepts/chart/dataset-based-charts.md)

 - [Настройки чарта](concepts/chart/settings.md)

 - [Measure Values и Measure Names](concepts/chart/measure-values.md)

 - [Мультидатасетные чарты](concepts/chart/multidataset-chart.md)

#### Пошаговые инструкции

 - [Создание чарта](operations/chart/create-chart.md)

 - [Замена датасета в чарте](operations/chart/replace-dataset.md)

 - [Создание мультидатасетного чарта](operations/chart/create-multidataset-chart.md)

 - [Добавление иерархии](operations/chart/add-hierarchy.md)

 - [Настройка навигатора](operations/chart/config-chart-navigator.md)

 - [Настройка отображения пустых (null) значений](operations/chart/chart-null-settings.md)

 - [Настройка цветовой палитры](operations/chart/create-palette.md)

### QL-чарты

 - [Обзор](concepts/chart/ql-charts.md)

 - [Создание QL-чарта](operations/chart/create-sql-chart.md)

### Чарты в Editor

 - [Обзор](charts/editor/index.md)

#### Быстрый старт в Editor

 - [Обзор](charts/editor/quickstart/index.md)

 - [Создание таблицы на основе датасета](charts/editor/quickstart/from-dataset.md)

 - [Создание таблицы на основе SQL-запроса](charts/editor/quickstart/from-database.md)

 - [Создание таблицы через API](charts/editor/quickstart/from-api-connector.md)

 - [Нейроаналитик в Editor](charts/editor/code-helper.md)

 - [Вкладки](charts/editor/tabs.md)

 - [Источники](charts/editor/sources.md)

 - [Доступные методы](charts/editor/methods.md)

 - [Уведомления](charts/editor/notifications.md)

 - [Связи чарта в дашбордах и отчетах](charts/editor/links.md)

 - [Кросс-фильтрация](charts/editor/cross-filtration.md)

 - [Отладка чартов](charts/editor/debug.md)

#### Типы визуализаций

 - [Обзор](charts/editor/widgets/index.md)

 - [Таблица](charts/editor/widgets/table.md)

 - [График (Gravity UI Charts)](charts/editor/widgets/gravity-ui.md)

 - [Markdown](charts/editor/widgets/markdown.md)

 - [Advanced-чарт](charts/editor/widgets/advanced.md)

 - [Селектор](charts/editor/widgets/controls.md)

### Справочник визуализаций

 - [Все визуализации](visualization-ref/index.md)

 - [Линейная диаграмма](visualization-ref/line-chart.md)

 - [Диаграмма с областями](visualization-ref/area-chart.md)

 - [Нормированная диаграмма с областями](visualization-ref/normalized-area-chart.md)

 - [Столбчатая диаграмма](visualization-ref/column-chart.md)

 - [Нормированная столбчатая диаграмма](visualization-ref/normalized-column-chart.md)

 - [Линейчатая диаграмма](visualization-ref/bar-chart.md)

 - [Нормированная линейчатая диаграмма](visualization-ref/normalized-bar-chart.md)

 - [Точечная диаграмма](visualization-ref/scatter-chart.md)

 - [Круговая диаграмма](visualization-ref/pie-chart.md)

 - [Комбинированная диаграмма](visualization-ref/combined-chart.md)

 - [Древовидная диаграмма](visualization-ref/tree-chart.md)

 - [Кольцевая диаграмма](visualization-ref/ring-chart.md)

 - [Таблица](visualization-ref/table-chart.md)

 - [Сводная таблица](visualization-ref/pivot-table-chart.md)

 - [Индикатор](visualization-ref/indicator-chart.md)

#### Карта

 - [Обзор](visualization-ref/map-chart.md)

 - [Точечная карта](visualization-ref/point-map-chart.md)

 - [Точечная карта с кластеризацией](visualization-ref/cluster-point-map-chart.md)

 - [Полилинейная карта](visualization-ref/polyline-map-chart.md)

 - [Фоновая карта](visualization-ref/choropleth-map-chart.md)

 - [Тепловая карта](visualization-ref/heat-map-chart.md)

### Параметры в чартах

 - [Добавление параметров в настройках чарта на дашборде](operations/chart/add-parameters.md)

 - [Добавление ID в качестве параметра](operations/chart/add-guid.md)

 - [Добавление параметра в чарт](operations/chart/add-parameter-chart.md)

 - [Добавление информации о чарте](operations/chart/add-description.md)

 - [Открытие чарта как таблицы](operations/chart/open-as-table.md)

 - [Сохранение чарта как изображения](operations/chart/save-as-image.md)

 - [Версионирование](concepts/chart/versioning.md)

 - [Экспорт данных из чартов](concepts/chart/data-export.md)

 - [Инспектор чартов](concepts/chart/inspector.md)

 - [Управление доступом](concepts/chart/access-management.md)

## Дашборды

 - [Обзор](concepts/dashboard.md)

 - [Виджеты](dashboard/widget.md)

 - [Связь](dashboard/link.md)

 - [Селекторы](dashboard/selector.md)

 - [Фильтрация чартов чартами](dashboard/chart-chart-filtration.md)

 - [Настройки дашборда](dashboard/settings.md)

 - [Рассылки](operations/dashboard/add-maillists.md)

 - [Версионирование](dashboard/versioning.md)

 - [Параметры](dashboard/dashboard_parameters.md)

 - [Нейроаналитик на дашборде](dashboard/insights.md)

 - [Тренды и сглаживания в чартах на дашборде](dashboard/trends-and-smoothing.md)

 - [Markdown](dashboard/markdown.md)

### Пошаговые инструкции

 - [Создание дашборда](operations/dashboard/create.md)

#### Виджеты на дашборде

 - [Добавление чарта на дашборд](operations/dashboard/add-chart.md)

 - [Добавление селектора на дашборд](operations/dashboard/add-selector.md)

 - [Добавление текста на дашборд](operations/dashboard/add-text.md)

 - [Добавление заголовка на дашборд](operations/dashboard/add-title.md)

 - [Добавление селектора JS на дашборд](charts/editor/add-js-selector.md)

 - [Добавление виджета с инсайтом на дашборд](operations/dashboard/add-ai.md)

 - [Копирование виджетов на дашборде](operations/dashboard/copying-widgets.md)

 - [Добавление информации о дашборде](operations/dashboard/add-description.md)

#### Настройки дашборда

 - [Изменение настроек дашборда](operations/dashboard/dash-settings.md)

 - [Добавление сообщения при обращении в поддержку](operations/dashboard/add-support-message.md)

 - [Добавление сообщения при ошибке доступа](operations/dashboard/add-access-message.md)

 - [Добавление параметров на дашборд](operations/dashboard/add-parameters.md)

 - [Автообновление дашборда](operations/dashboard/auto-update.md)

 - [Запрет Нейроаналитика на дашборде](operations/dashboard/dashboard-neuroanalyst-off.md)

#### Настройки связей

 - [Настройка связей на дашборде](operations/dashboard/dashboard-links.md)

 - [Создание алиаса](operations/dashboard/create-alias.md)

 - [Удаление алиаса](operations/dashboard/edit-alias.md)

#### Настройки внешнего вида

 - [Настройка фона дашборда](operations/dashboard/add-dashboard-background.md)

 - [Настройка фона и прозрачности виджетов на дашборде](operations/dashboard/add-widget-background.md)

 - [Настройка скругления на дашборде](operations/dashboard/add-rounding.md)

 - [Настройка отступов на дашборде](operations/dashboard/add-margins.md)

 - [Настройка заголовка дашборда](operations/dashboard/add-title-dashboard.md)

 - [Добавление оглавления на дашборд](operations/dashboard/add-contents.md)

#### Управление вкладками дашборда

 - [Настройка вкладок дашборда](operations/dashboard/dashboard-tabs.md)

 - [Изменить отображение вкладок](operations/dashboard/dashboard-hide-tabs.md)

 - [Эталонная вкладка для AI](operations/dashboard/dashboard-ai-reference-tab.md)

 - [Порядок отображения виджетов на мобильном устройстве](operations/dashboard/display-modes.md)

 - [Настройка фильтрации чартами](operations/dashboard/add-filtration.md)

 - [Управление доступом к дашборду](operations/dashboard/manage-access.md)

## Отчеты

 - [Обзор](reports/index.md)

 - [Работа с отчетами](reports/report-operations.md)

 - [Селекторы в отчетах](reports/add-selector.md)

 - [Версионирование](reports/versioning.md)

 - [Нейроаналитик в отчетах](reports/insights.md)

## Публикация и встраивание

 - [Обзор](concepts/publishing-and-embedding.md)

 - [Публикация объектов](concepts/datalens-public.md)

 - [Публичное встраивание](security/embedded-objects.md)

 - [Поделиться объектом в организации](concepts/datalens-sharing.md)

 - [Встраивание через JWT](security/private-embedded-objects.md)

## Управление доступом

 - [Обзор](security/index.md)

 - [Роли в DataLens](security/roles.md)

### Организации в DataLens

 - [Обзор](concepts/organizations.md)

 - [Переключение между экземплярами DataLens](operations/organizations/change-organization.md)

### Доступ к объектам в воркбуках и коллекциях

 - [Обзор](security/workbooks-access.md)

 - [Базовая настройка](security/workbooks-access-basic.md)

 - [Продвинутая настройка (общие объекты)](security/workbooks-access-advanced.md)

### Доступ к объектам в папках

 - [Права доступа](security/manage-access.md)

 - [Назначение и изменение прав доступа](operations/permission/grant.md)

 - [Удаление прав доступа](operations/permission/revoke.md)

 - [Запрос прав доступа](operations/permission/request.md)

 - [Доступ к строкам данных](security/row-level-security.md)

## Настройки сервиса

 - [Обзор](settings/index.md)

 - [Рабочие места](settings/seats.md)

 - [Пользователи](security/add-new-user.md)

 - [Тарифы и оплата](settings/service-plan.md)

 - [Оформление](settings/appearance.md)

 - [Безопасность](settings/restrictions.md)

 - [Навигация](settings/navigation.md)

 - [Галерея в DataLens](concepts/gallery.md)

## Правила тарификации

 - [Действующие правила](pricing.md)

### Архив

 - [Изменения в правилах тарификации 1 декабря](pricing-changes.md)

 - [Правила тарификации до 1 декабря 2025](pricing-old.md)

 - [Тарифные планы до 1 декабря 2025](concepts/service-plans-comparison.md)

## DataLens Public API

 - [Как пользоваться Public API](operations/api-start.md)

### DataLens API (англ.)

 - [Overview](openapi-ref/index.md)

 - [createCollection](openapi-ref/createCollection.md)

 - [deleteCollection](openapi-ref/deleteCollection.md)

 - [deleteCollections](openapi-ref/deleteCollections.md)

 - [getCollectionBreadcrumbs](openapi-ref/getCollectionBreadcrumbs.md)

 - [getCollection](openapi-ref/getCollection.md)

 - [getCollectionContent](openapi-ref/getCollectionContent.md)

 - [getRootCollectionPermissions](openapi-ref/getRootCollectionPermissions.md)

 - [moveCollection](openapi-ref/moveCollection.md)

 - [moveCollections](openapi-ref/moveCollections.md)

 - [updateCollection](openapi-ref/updateCollection.md)

 - [getConnection](openapi-ref/getConnection.md)

 - [createConnection](openapi-ref/createConnection.md)

 - [updateConnection](openapi-ref/updateConnection.md)

 - [deleteConnection](openapi-ref/deleteConnection.md)

 - [getDashboard](openapi-ref/getDashboard.md)

 - [createDashboard](openapi-ref/createDashboard.md)

 - [updateDashboard](openapi-ref/updateDashboard.md)

 - [deleteDashboard](openapi-ref/deleteDashboard.md)

 - [getDataset](openapi-ref/getDataset.md)

 - [createDataset](openapi-ref/createDataset.md)

 - [updateDataset](openapi-ref/updateDataset.md)

 - [deleteDataset](openapi-ref/deleteDataset.md)

 - [validateDataset](openapi-ref/validateDataset.md)

 - [getEntriesRelations](openapi-ref/getEntriesRelations.md)

 - [getEntries](openapi-ref/getEntries.md)

 - [getQLChart](openapi-ref/getQlChart.md)

 - [deleteQLChart](openapi-ref/deleteQlChart.md)

 - [updateQLChart](openapi-ref/updateQlChart.md)

 - [createQLChart](openapi-ref/createQlChart.md)

 - [getWizardChart](openapi-ref/getWizardChart.md)

 - [deleteWizardChart](openapi-ref/deleteWizardChart.md)

 - [updateWizardChart](openapi-ref/updateWizardChart.md)

 - [createWizardChart](openapi-ref/createWizardChart.md)

 - [createWorkbook](openapi-ref/createWorkbook.md)

 - [deleteWorkbook](openapi-ref/deleteWorkbook.md)

 - [deleteWorkbooks](openapi-ref/deleteWorkbooks.md)

 - [getWorkbook](openapi-ref/getWorkbook.md)

 - [getWorkbooksList](openapi-ref/getWorkbooksList.md)

 - [moveWorkbook](openapi-ref/moveWorkbook.md)

 - [moveWorkbooks](openapi-ref/moveWorkbooks.md)

 - [updateWorkbook](openapi-ref/updateWorkbook.md)

 - [getWorkbookEntries](openapi-ref/getWorkbookEntries.md)

 - [getEditorChart](openapi-ref/getEditorChart.md)

 - [deleteEditorChart](openapi-ref/deleteEditorChart.md)

 - [createEditorChart](openapi-ref/createEditorChart.md)

 - [updateEditorChart](openapi-ref/updateEditorChart.md)

 - [createEmbed](openapi-ref/createEmbed.md)

 - [listEmbeds](openapi-ref/listEmbeds.md)

 - [deleteEmbed](openapi-ref/deleteEmbed.md)

 - [updateEmbed](openapi-ref/updateEmbed.md)

 - [getEntriesPermissions](openapi-ref/getEntriesPermissions.md)

 - [createEmbeddingSecret](openapi-ref/createEmbeddingSecret.md)

 - [listEmbeddingSecrets](openapi-ref/listEmbeddingSecrets.md)

 - [deleteEmbeddingSecret](openapi-ref/deleteEmbeddingSecret.md)

 - [getEmbeddingSecret](openapi-ref/getEmbeddingSecret.md)

 - [getAuditEntriesUpdates](openapi-ref/getAuditEntriesUpdates.md)

 - [updateCollectionAccessBindings](openapi-ref/updateCollectionAccessBindings.md)

 - [createFolder](openapi-ref/createFolder.md)

 - [listDirectory](openapi-ref/listDirectory.md)

 - [updateWorkbookAccessBindings](openapi-ref/updateWorkbookAccessBindings.md)

 - [Аудитные логи Audit Trails](at-ref.md)

## История изменений

 - [Май 2026](release-notes/index.md)

 - [Апрель 2026](release-notes/2604.md)

 - [Март 2026](release-notes/2603.md)

 - [Февраль 2026](release-notes/2602.md)

 - [Январь 2026](release-notes/2601.md)

 - [Декабрь 2025](release-notes/2512.md)

### Архив

 - [Ноябрь 2025](release-notes/2511.md)

 - [Октябрь 2025](release-notes/2510.md)

 - [Сентябрь 2025](release-notes/2509.md)

 - [Август 2025](release-notes/2508.md)

 - [Июль 2025](release-notes/2507.md)

 - [Июнь 2025](release-notes/2506.md)

 - [Май 2025](release-notes/2505.md)

 - [Апрель 2025](release-notes/2504.md)

 - [Март 2025](release-notes/2503.md)

 - [Февраль 2025](release-notes/2502.md)

 - [Январь 2025](release-notes/2501.md)

 - [Декабрь 2024](release-notes/2412.md)

 - [Ноябрь 2024](release-notes/2411.md)

 - [Октябрь 2024](release-notes/2410.md)

 - [Сентябрь 2024](release-notes/2409.md)

 - [Август 2024](release-notes/2408.md)

 - [Июль 2024](release-notes/2407.md)

 - [Июнь 2024](release-notes/2406.md)

 - [Май 2024](release-notes/2405.md)

 - [Апрель 2024](release-notes/2404.md)

 - [Март 2024](release-notes/2403.md)

 - [Февраль 2024](release-notes/2402.md)

 - [Январь 2024](release-notes/2401.md)

## Решение проблем

 - [Рекомендации по оптимизации](concepts/optimization_recommendations.md)

 - [Ошибки DataLens](troubleshooting/errors/all.md)

### Вопросы и ответы

 - [Все вопросы](qa/index.md)

 - [Пользователи и управление доступом](qa/permissions.md)

 - [Тарификация и оплата](qa/pricing.md)

 - [Подключения](qa/connections.md)

 - [Датасеты](qa/datasets.md)

 - [Чарты](qa/charts.md)

 - [Вычисляемые поля](qa/calculation-fields.md)

 - [Дашборды](qa/dashboards.md)

 - [Воркбуки и коллекции](qa/workbooks-collections.md)

 - [Отчеты](qa/reports.md)

 - [Непубличное встраивание](qa/embedded.md)

 - [Другое](qa/other.md)

 - [Access denied](troubleshooting/errors/ERR-DS_API-US-ACCESS_DENIED.md)

 - [Access to table was denied](troubleshooting/errors/ERR-DS_API-DB-CHYT-TABLE_ACCESS_DENIED.md)

 - [Authentication failed](troubleshooting/errors/ERR-DS_API-DB-CHYT-AUTH_FAILED.md)

 - [Backend app request timeout exceeded](troubleshooting/errors/ERR-DS_API-REQUEST_TIMEOUT.md)

 - [Blocks have different column count](troubleshooting/errors/ERR-DS_API-BLOCK-UNEVEN_COLUMN_COUNT.md)

 - [Cannot join a concatenation of tables with another table](troubleshooting/errors/ERR-DS_API-DB-CHYT-INVALID_SORTED_JOIN-MORE_THAN_ONE_TABLE.md)

 - [Cannot parse](troubleshooting/errors/ERR-DS_API-DB-CANNOT_PARSE.md)

 - [Cannot parse datetime](troubleshooting/errors/ERR-DS_API-DB-CANNOT_PARSE-DATETIME.md)

 - [Cannot parse number](troubleshooting/errors/ERR-DS_API-DB-CANNOT_PARSE-NUMBER.md)

 - [Column used in join expression is not a key column](troubleshooting/errors/ERR-DS_API-DB-CHYT-INVALID_SORTED_JOIN-NOT_A_KEY_COLUMN.md)

 - [ROUND with precision parameter is not supported for double precision data type in PostgreSQL](troubleshooting/errors/ERR-DS_API-DB-INVALID_FUNCTION-PG_DOUBLE_PRECISION_ROUND.md)

 - [Columns in JOIN have different types](troubleshooting/errors/ERR-DS_API-DB-JOIN_COLUMN_TYPE_MISMATCH.md)

 - [Data source is unavailable](troubleshooting/errors/ERR-DS_API-DATABASE_UNAVAILABLE.md)

 - [Data source (table) does not exist](troubleshooting/errors/ERR-DS_API-DB-SOURCE_DOES_NOT_EXIST.md)

 - [Data source refused connection](troubleshooting/errors/ERR-DS_API-DB-SOURCE_CONNECT_ERROR.md)

 - [Data source timed out](troubleshooting/errors/ERR-DS_API-DB-SOURCE_ERROR-TIMEOUT.md)

 - [Database authentication failed](troubleshooting/errors/ERR-DS_API-DB-AUTHENTICATION_FAILED.md)

 - [Division by zero](troubleshooting/errors/ERR-DS_API-DB-ZERO_DIVISION.md)

 - [Field title conflicts with another field](troubleshooting/errors/ERR-DS_API-FIELD-TITLE-CONFLICT.md)

 - [File check failed](troubleshooting/errors/ERR-FILE-UNSUPPORTED_DOCUMENT.md)

 - [Неверный формат ссылки на Яндекс Документы](troubleshooting/errors/ERR-FILE-INVALID_LINK-YADOCS_INVALID_PUBLIC_LINK_PREFIX.md)

 - [Incompatible dimensions](troubleshooting/errors/ERR-DS_API-FORMULA-VALIDATION-LOD-INCOMPATIBLE_DIMENSIONS.md)

 - [Inconsistent aggregation among operands](troubleshooting/errors/ERR-DS_API-FORMULA-VALIDATION-AGG-INCONSISTENT.md)

 - [Inconsistent aggregation status among SELECT items](troubleshooting/errors/ERR-DS_API-INVALID_QUERY_STRUCTURE-INCONSISTENT_AGGREGATION.md)

 - [Изменение источника данных недоступно](troubleshooting/errors/ERR-DS_API-PREVIEW_SOURCE_MODIFICATION_NOT_ALLOWED.md)

 - [Internal server error](troubleshooting/errors/ERR-DS_API.md)

 - [Не удалось распарсить название клики](troubleshooting/errors/ERR-DS_API-DB-CHYT-CLIQUE-INVALID_GUID.md)

 - [Invalid clique specification. Probably, clique does not exists](troubleshooting/errors/ERR-DS_API-DB-CHYT-CLIQUE-INVALID_SPECIFICATION.md)

 - [Invalid grouping configuration](troubleshooting/errors/ERR-DS_API-INVALID_GROUP_BY_CONFIGURATION.md)

 - [Invalid top-level LOD dimension found in expression](troubleshooting/errors/ERR-DS_API-FORMULA-VALIDATION-LOD-INVALID_TOPLEVEL_DIMENSIONS.md)

 - [Invalid user token](troubleshooting/errors/ERR-DS_API-SOURCE_ACCESS_DENIED-INVALID_TOKEN.md)

 - [Joined columns should form prefix of joined table key columns](troubleshooting/errors/ERR-DS_API-DB-CHYT-INVALID_SORTED_JOIN-NOT_KEY_PREFIX_COLUMN.md)

 - [Measure filter is unsupported for this type of query](troubleshooting/errors/ERR-DS_API-FILTER-MEASURE_UNSUPPORTED.md)

 - [Подготовка данных еще не завершилась](troubleshooting/errors/ERR-DS_API-DB-MATERIALIZATION_NOT_FINISHED.md)

 - [Memory limit has been exceeded during query execution](troubleshooting/errors/ERR-DS_API-DB-MEMORY_LIMIT_EXCEEDED.md)

 - [Received too many result data rows](troubleshooting/errors/ERR-DS_API-ROW_COUNT_LIMIT.md)

 - [Referenced connection <идентификатор_подключения> cannot be loaded access denied](troubleshooting/errors/ERR-DS_API-REFERENCED_ENTRY_ACCESS_DENIED.md)

 - [Request size limit exceeded](troubleshooting/errors/ERR-CHARTS-REQUEST_SIZE_LIMIT_EXCEEDED.md)

 - [Response processing timeout](troubleshooting/errors/ERR-CHARTS-RUNTIME_TIMEOUT.md)

 - [Requested database column does not exist](troubleshooting/errors/ERR-DS_API-DB-COLUMN_DOES_NOT_EXIST.md)

 - [Подготовка данных еще не завершилась](troubleshooting/errors/ERR-DS_API-DB-DATA_PREPARATION_NOT_FINISHED.md)

 - [Subquery exceeds data weight limit](troubleshooting/errors/ERR-DS_API-DB-CHYT-SUBQ_WEIGHT_LIMIT_EXCEEDED.md)

 - [Использование QL-чартов запрещено на уровне подключения](troubleshooting/errors/ERR-DS_API-CONNECTION_CONFIG-DASHSQL_NOT_ALLOWED.md)

 - [Subquery source is disallowed in the connection settings](troubleshooting/errors/ERR-DS_API-CONNECTION_CONFIG-SUBSELECT_NOT_ALLOWED.md)

 - [Нарушена конфигурация таблицы](troubleshooting/errors/ERR-DS_API-SOURCE_CONFIG-TABLE_NOT_CONFIGURED.md)

 - [Empty document](troubleshooting/errors/ERR-DS_API-SOURCE-FILE-NO_DATA.md)

 - [Too many series on the chart](troubleshooting/errors/ERR-CK_TOO_MANY_LINES.md)

 - [Unknown field](troubleshooting/errors/ERR-DS_API-FIELD-NOT_FOUND.md)

 - [Unknown field found in formula](troubleshooting/errors/ERR-DS_API-FORMULA-UNKNOWN_FIELD_IN_FORMULA.md)

 - [Unknown referenced source column](troubleshooting/errors/ERR-DS_API-FORMULA-UNKNOWN_SOURCE_COLUMN.md)

 - [Unknown dimension for window](troubleshooting/errors/ERR-DS_API-FORMULA-UNKNOWN_WINDOW_DIMENSION.md)

 - [Window function has unselected dimension](troubleshooting/errors/ERR-DS_API-FORMULA-VALIDATION-WIN_FUNC-BFB_UNSELECTED_DIMENSION.md)

 - [Window function has no aggregated expressions among its arguments](troubleshooting/errors/ERR-DS_API-FORMULA-VALIDATION-WIN_FUNC-NO_AGG.md)

 - [YT table has no schema. Only schematized tables are supported](troubleshooting/errors/ERR-DS_API-DB-CHYT-TABLE_HAS_NO_SCHEMA.md)

 - [Не удалось создать <тип_объекта>](troubleshooting/errors/ERR-DS_API-DB-DB_OPERATIONAL_ERROR.md)

 - [Неверный формат файла](troubleshooting/errors/ERR-FILE-PARSE_FAILED-INVALID_EXCEL.md)

 - [Невозможно обновить данные](troubleshooting/errors/ERR-FILE-CANNOT_UPDATE_DATA.md)

 - [Ошибка в запросе к объекту](troubleshooting/errors/ERR-DS_API-US-BAD_REQUEST.md)

 - [Ошибка выполнения запроса в источнике данных](troubleshooting/errors/ERR-DS_API-DB.md)

 - [Ошибка на стороне БД](troubleshooting/errors/ERR-US-BAD_REQUEST-ALREADY_EXISTS.md)

 - [Access to the connection was denied](troubleshooting/errors/ERR-DS_API-US-ACCESS_DENIED-CONNECTION.md)

 - [Connection not found](troubleshooting/errors/ERR-DS_API-US-OBJ_NOT_FOUND-CONNECTION.md)

 - [Invalid input data: validation failed](troubleshooting/errors/ERR-DS_API-US-VALIDATION_FAILED.md)

 - [Invalid connection ID](troubleshooting/errors/ERR-DS_API-US-VALIDATION_FAILED-CONNECTION.md)

 - [Ошибка при обработке ответа](troubleshooting/errors/SDK_REQUEST_ERROR.md)

 - [Ошибка в синтаксисе формулы](troubleshooting/errors/ERR-DS_API-FORMULA-PARSE-UNEXPECTED_TOKEN.md)

 - [Ошибка преобразования типа данных](troubleshooting/errors/ERR-DS_API-TYPE_CAST-FAILED.md)

 - [Обращение к несуществующему объекту](troubleshooting/errors/ERR-DS_API-REFERENCED_ENTRY_NOT_FOUND.md)

 - [Got an unexpected response from an external API](troubleshooting/errors/ERR-AUTH_API-UNEXPECTED_RESPONSE.md)

 - [Internal Server Error](troubleshooting/errors/ERR-DS_API-ACTION_NOT_ALLOWED.md)

 - [Field references an unknown source avatar](troubleshooting/errors/ERR-DS_API-AVATAR-NOT_FOUND-FIELD_REF.md)

 - [Source avatar not found](troubleshooting/errors/ERR-DS_API-AVATAR-NOT_FOUND.md)

 - [Source avatar title conflicts with another avatar](troubleshooting/errors/ERR-DS_API-AVATAR-TITLE-CONFLICT.md)

 - [Invalid connection type value](troubleshooting/errors/ERR-DS_API-BAD_CONN_TYPE.md)

 - [Got items with incompatible roles in block](troubleshooting/errors/ERR-DS_API-BLOCK-ITEM_COMPATIBILITY.md)

 - [Got more than one block with root placement](troubleshooting/errors/ERR-DS_API-BLOCK-MULTIPLE_ROOTS.md)

 - [This API does not support multiple query blocks](troubleshooting/errors/ERR-DS_API-BLOCK-MULTIPLE_UNSUPPORTED.md)

 - [Got no blocks with root placement](troubleshooting/errors/ERR-DS_API-BLOCK-NO_ROOT.md)

 - [Failed to load description of table columns](troubleshooting/errors/ERR-DS_API-COLUMN_SCHEMA_FAILED.md)

 - [Internal server error](troubleshooting/errors/ERR-DS_API-CONNECTION_CONFIG.md)

 - [Internal server error](troubleshooting/errors/ERR-DS_API-DASHSQL-PARAMETER.md)

 - [Internal server error](troubleshooting/errors/ERR-DS_API-DASHSQL.md)

 - [There are too many fields in the dataset](troubleshooting/errors/ERR-DS_API-DATASET-TOO_MANY_FIELDS.md)

 - [Dataset version mismatch. Refresh the page to continue](troubleshooting/errors/ERR-DS_API-DATASET_REVISION_MISMATCH.md)

 - [Ошибка при блокировке всплывающего окна](troubleshooting/errors/ERR-CLIENT-POPUP_BLOCKED.md)