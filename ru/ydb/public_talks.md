# Публичные материалы 

## Обзорные материалы {#overview}

- [{{ ydb-full-name }} Whitepaper](https://storage.yandexcloud.net/ydb-public-talks/yandex-database-a4.pdf).
    
### 2019: YaTalks Москва {#yatalks-moscow-2019}

- Тема: {{ ydb-full-name }} — как выжать 10K IOPS из HDD и вставить в таблицу 50K записей на одном ядре.
    - [Презентация](https://storage.yandexcloud.net/ydb-public-talks/yatalks-ydb.pptx).
    - [Запись трансляции](https://youtu.be/hXH_tRBxFnA?t=11283).
    - Описание: 
        1. Рассказ об успешном использовании {{ ydb-full-name }} в качестве бэкэнда для распределенной трассировки Jaeger от представителей Auto.ru и [Яндекс.Недвижимости](https://realty.yandex.ru/).
        1. Рассказ про архитектуру распределенного сетевого хранилища в {{ ydb-full-name }}.

### 2019: Yandex Scale {#scale}

- Тема: {{ ydb-full-name }} — эффективная альтернатива традиционным noSQL-решениям. 
    - [Презентация](https://storage.yandexcloud.net/ydb-public-talks/08-20190905_yscale_fomichev.pptx).
    - [Запись трансляции](https://youtu.be/MlSdUq5RIN8).
    - Описание: как и зачем была создана {{ ydb-full-name }}, чем она отличается от других БД и для каких задач она лучше всего подходит.
- Тема: {{ ydb-full-name }} at Scale: опыт применения в высоконагруженных сервисах Яндекса.
    - [Презентация](https://storage.yandexcloud.net/ydb-public-talks/242-olegbondar.pptx).
    - [Запись трансляции](https://youtu.be/kubFwIKJjBY).
    - Описание: представители Auto.ru, [Яндекс.Репетитора](https://yandex.ru/tutor/), [Алисы](https://yandex.ru/alice) и [Condé Nast](https://www.condenast.ru/) расскажут, почему они выбрали {{ ydb-full-name }} и как эта СУБД помогает развивать их продукты.

### 2019: Webinar YDB {#webinar}

- Тема: {{ ydb-full-name }} at Scale: опыт применения в высоконагруженных сервисах Яндекса.
    - [Презентация](https://storage.yandexcloud.net/ydb-public-talks/2019-webinar.pptx).
    - [Запись трансляции](https://youtu.be/qWqU-R-X3Dc).
    - Описание: опыт использования {{ ydb-full-name }} на примере продуктов Яндекса.

### 2018: about:cloud {#about-cloud}

- Тема: {{ ydb-full-name }}: платформа распределённых систем хранения данных, критичных к задержкам.  
    - [Запись трансляции](https://youtu.be/Kr6WIYPts8I?t=8558).    
    - Описание: рассказ про YDB, как про платформу, на которой можно строить различные системы хранения и обработки данных.
- Тема: {{ ydb-full-name }}: newSQL база данных. Рассказ собственно про YDB как базу данных.
    - [Запись трансляции](https://youtu.be/Kr6WIYPts8I?t=10550).    
    - Описание: о YDB как о базе данных.
- Тема: {{ ydb-full-name }}: сетевое блочное устройство. 
    - [Запись трансляции](https://youtu.be/Kr6WIYPts8I?t=12861).
    - Описание: рассказ про Network Block Store — сервис виртуальных дисков, на которых работают все виртуальные машины {{ yandex-cloud }}.

## Материалы для углубленного изучения YDB {#internals}

### 2019: DevZen Podcast {#devzen}

- Тема: Устройство {{ ydb-full-name }}.
    - [Запись подкаста](https://devzen.ru/episode-0272/).    
    - Описание: подробный рассказ про устройство YDB и ответы на вопросы.
    
### 2019: YaTalks Екатеринбург {#yatalks-ekb-2019}

- Тема: {{ ydb-full-name }}: newSQL-база данных Яндекса.
    - [Презентация](https://storage.yandexcloud.net/ydb-public-talks/YdbInCloud_2.pptx).
    - [Запись трансляции](https://youtu.be/tzANIAbc99o?t=3012).
    - Описание: основные моменты, связанные с выполнением распределенных запросов в YDB:
        1. Модель транзакций и уровни изоляции.
        1. Особенности SQL-диалекта Yandex Query Language (YQL).
        1. Многошаговые транзакции и механизм оптимистичных блокировок.
        1. Эффективное выполнение запросов к распределённым БД в целом.
        1. Основные факторы, влияющие на производительность запросов.
        1. Стандартные практики работы с YDB, в том числе инструменты для разработчика.
        
### 2019: BackendConf {#backendconf}

- Тема: {{ ydb-full-name }}: распределенные запросы в облаках.
    - [Запись трансляции](https://youtu.be/V95bBGB-89Y?t=15514).
    - Описание: как YDB выполняет YQL запросы.

### 2019: HighLoad++ Siberia {#highload}

- Тема: {{ ydb-full-name }} — как мы обеспечиваем отказоустойчивость.
    - [Запись трансляции](https://youtu.be/-GlRSxG4JQU?t=10779).
    - Описание: как YDB хранит данные с избыточностью и как YDB решает задачу распределенного консенсуса.
        
### 2019: HydraConf {#hydraconf}

- Тема: Yandex Database — how we guarantee fault tolerance.
    - [Презентация](https://storage.yandexcloud.net/ydb-public-talks/Hydra_2019_Vladislav_Kuznetsov_Yandex_Database__kak_my_obespechivayem_otkazoustoychivost.pptx).
    - Описание: как YDB хранит данные с избыточностью и как YDB решает задачу распределенного консенсуса.
- Тема: Distributed transactions in YDB.
    - [Презентация](https://storage.yandexcloud.net/ydb-public-talks/Hydra_2019_Semen_Checherinda_Raspredelennyye_tranzaktsii_v_YDB%20(2).pptx).
    - Описание: механизм выполнения распределенных транзакций в YDB. 
    
## Решения на базе YDB {#solutions}

### 2019: HighLoad++ Siberia {#highload}
     
- Тема: Реализация геораспределенной персистентной очереди сообщений.
    - [Запись трансляции](https://www.youtube.com/watch?v=IZ7qxPVyasc).
    - [Презентация](https://storage.yandexcloud.net/ydb-public-talks/ymq.pdf).
    - Описание: рассказ про {{ monitoring-full-name }} — сервис для сбора, хранения и отображения метрик.
- Тема: Архитектура высокопроизводительной и высокодоступной системы мониторинга.
    - [Запись трансляции](https://www.youtube.com/watch?v=Qnw7s8290Cs).
    - [Презентация](https://storage.yandexcloud.net/ydb-public-talks/monitoring.pdf).
    - Описание: рассказ про {{ message-queue-full-name }} — универсальное масштабируемое решение для обмена сообщениями между приложениями.