# Публичные материалы

## Обзорные материалы {#overview}

- [Yandex Database Whitepaper](https://storage.yandexcloud.net/ydb-public-talks/yandex-database-a4.pdf).

### 2021: Webinar YDB 2021-01-21 {#webinar20210121}

- Тема: Практический пример использования serverless: интеграция сервисов Yandex.Cloud с голосовыми технологиями компании Voximplant.
  - [О мероприятии](https://cloud.yandex.ru/events/298).
  - [Запись трансляции](https://youtu.be/mB0Wpn2473U).
  - Описание:
    1. Интеграция Voximplant Kit с Yandex SpeechKit — сервисом распознавания и синтеза речи.
    2. Настройка и автоматизация обработки диалога с помощью Voximplant Kit.
    3. CRM-система, построенная с помощью serverless API Gateway, Yandex Cloud Functions и Yandex Database (serverless).
    4. [Пример приложения на Go](https://github.com/yandex-cloud/examples/tree/master/serverless/serverless_voximplant).

### 2020: Webinar YDB 2020-04-23 {#webinar20200423}

- Тема: Новости Yandex Database.
  - [Запись трансляции](https://youtu.be/6LMH4Q4uGBU).
  - Описание:
    1. Пример приложения на Node.js.
    1. Поддержка JSON в YDB.
    1. База YDB в {{ yandex-cloud }} доступная через Internet ("белые" IP).

### 2019: YaTalks Москва {#yatalks-moscow-2019}

- Тема: Yandex Database — как выжать 10K IOPS из HDD и вставить в таблицу 50K записей на одном ядре.
  - [Презентация](https://storage.yandexcloud.net/ydb-public-talks/yatalks-ydb.pptx).
  - [Запись трансляции](https://youtu.be/hXH_tRBxFnA?t=11283).
  - Описание:
    1. Рассказ об успешном использовании Yandex Database в качестве бэкэнда для распределенной трассировки Jaeger от представителей [Auto.ru](https://auto.ru) и [Яндекс.Недвижимости](https://realty.yandex.ru/).
    1. Рассказ об архитектуре распределенного сетевого хранилища в Yandex Database.

### 2019: Yandex Scale {#scale}

- Тема: Yandex Database — эффективная альтернатива традиционным noSQL-решениям.
  - [Презентация](https://storage.yandexcloud.net/ydb-public-talks/08-20190905_yscale_fomichev.pptx).
  - [Запись трансляции](https://youtu.be/MlSdUq5RIN8).
  - Описание: как и зачем была создана Yandex Database, чем она отличается от других БД и для каких задач она лучше всего подходит.

- Тема: Yandex Database at Scale: опыт применения в высоконагруженных сервисах Яндекса.
  - [Презентация](https://storage.yandexcloud.net/ydb-public-talks/242-olegbondar.pptx).
  - [Запись трансляции](https://youtu.be/kubFwIKJjBY).
  - Описание: представители [Auto.ru](https://auto.ru), [Яндекс.Репетитора](https://yandex.ru/tutor/), [Алисы](https://yandex.ru/alice) и [Condé Nast](https://www.condenast.ru/) расскажут, почему они выбрали Yandex Database и как эта СУБД помогает развивать их продукты.

### 2019: Webinar YDB {#webinar}

- Тема: Опыт использования Yandex Database на примере продуктов Яндекса.
  - [Презентация](https://storage.yandexcloud.net/ydb-public-talks/2019-webinar.pptx).
  - [Запись трансляции](https://youtu.be/qWqU-R-X3Dc).
  - Описание: опыт использования Yandex Database на примере продуктов Яндекса.

### 2018: about:cloud {#about-cloud}

- Тема: Yandex Database: платформа распределённых систем хранения данных, критичных к задержкам.
  - [Запись трансляции](https://youtu.be/Kr6WIYPts8I?t=8558).
  - Описание: рассказ о YDB, как о платформе, на которой можно строить различные системы хранения и обработки данных.

- Тема: Yandex Database: Distributed SQL база данных. Рассказ собственно о YDB как базе данных.
  - [Запись трансляции](https://youtu.be/Kr6WIYPts8I?t=10550).
  - Описание: о YDB как о базе данных.

- Тема: Yandex Database: сетевое блочное устройство.
  - [Запись трансляции](https://youtu.be/Kr6WIYPts8I?t=12861).
  - Описание: рассказ о Network Block Store — сервисе виртуальных дисков, на которых работают все виртуальные машины {{ yandex-cloud }}.

## Материалы для углубленного изучения YDB {#internals}

### 2019: HighLoad++ Москва {#highloadmoscow2019}

- Тема: Распределенные транзакции в YDB.
  - [Тезисы и презентация](https://www.highload.ru/moscow/2019/abstracts/5324).
  - [Запись трансляции](https://youtu.be/8AR1u5OZIm8).
  - Описание: механизм выполнения распределенных транзакций в YDB.

### 2019: DevZen Podcast {#devzen}

- Тема: Устройство Yandex Database.
  - [Запись подкаста](https://devzen.ru/episode-0272/).
  - Описание: подробный рассказ об устройстве YDB и ответы на вопросы.

### 2019: YaTalks Екатеринбург {#yatalks}

- Тема: Yandex Database: Distributed SQL база данных Яндекса.
  - [Презентация](https://storage.yandexcloud.net/ydb-public-talks/YdbInCloud_2.pptx).
  - [Запись трансляции](https://youtu.be/tzANIAbc99o?t=3012).
  - Описание: основные моменты, связанные с выполнением распределенных запросов в YDB:
    1. Модель транзакций и уровни изоляции.
    1. Особенности SQL-диалекта Yandex Query Language (YQL).
    1. Многошаговые транзакции и механизм оптимистичных блокировок.
    1. Эффективное выполнение запросов к распределённым БД в целом.
    1. Основные факторы, влияющие на производительность запросов
    1. Стандартные практики работы с YDB, в том числе инструменты для разработчика.

### 2019: BackendConf {#backendconf}

- Тема: Yandex Database: распределенные запросы в облаках.
  - [Запись трансляции](https://youtu.be/V95bBGB-89Y?t=15514).
  - Описание: как YDB выполняет YQL запросы.

### 2019: HighLoad++ Siberia {#highload}

- Тема: Yandex Database — как мы обеспечиваем отказоустойчивость.
  - [Запись трансляции](https://youtu.be/-GlRSxG4JQU?t=10779).
  - Описание: как YDB хранит данные с избыточностью и как YDB решает задачу распределенного консенсуса.

{% if audience != "external" %}
### 2019: HydraConf {#hydraconf}

- Тема: Yandex Database — how we guarantee fault tolerance.
  - [Презентация](https://storage.yandexcloud.net/ydb-public-talks/Hydra_2019_Vladislav_Kuznetsov_Yandex_Database__kak_my_obespechivayem_otkazoustoychivost.pptx).
  - [Запись трансляции](https://youtu.be/_7FAeeWAhT4).
  - Описание: как YDB хранит данные с избыточностью и как YDB решает задачу распределенного консенсуса.
- Тема: Distributed transactions in YDB.
  - [Презентация](https://storage.yandexcloud.net/ydb-public-talks/Hydra_2019_Semen_Checherinda_Raspredelennyye_tranzaktsii_v_YDB%20(2).pptx).
  - [Запись трансляции](https://youtu.be/85GIFpG3zx4).
  - Описание: механизм выполнения распределенных транзакций в YDB.
{% endif %}