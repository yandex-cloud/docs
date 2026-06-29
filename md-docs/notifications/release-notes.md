# История изменений в Cloud Notification Service

## II квартал 2026 {#q2-2026}

* Добавлена пакетная тарификация SMS разных типов для операторов МТС, МегаФон и Т2. Подробнее в разделе [Правила тарификации](pricing.md#sms).
* Cloud Notification Service перешел в стадию [General Availability](../overview/concepts/launch-stages.md). Для сервиса действует [Соглашение об уровне обслуживания (SLA)](https://yandex.ru/legal/cloud_terms_cns/ru/).

## I квартал 2026 {#q1-2026}

Добавлена возможность создавать шаблоны SMS для каналов с индивидуальным отправителем. Шаблоны определяют тип SMS-уведомления — транзакционное, авторизационное или сервисное. Если текст сообщения не соответствует ни одному шаблону, оно считается рекламным. Тип уведомления влияет на [стоимость отправки](pricing.md). В Cloud Notification Service можно создать шаблон SMS и зарегистрировать его у операторов связи.

Подробнее — [Шаблоны SMS](concepts/sms.md#templates).

## III квартал 2025 {#q3-2025}

Реализована возможность работать с [топиками](concepts/topics.md), чтобы централизованно отправлять уведомления во множество эндпоинтов.

Формат работы с топиками в Cloud Notification Service совместим с [Amazon SNS API](https://docs.aws.amazon.com/sns/latest/api/welcome.html).

Примеры команд для работы с топиками приведены в [консоли управления](https://console.yandex.cloud) и в разделах с [пошаговыми инструкциями](operations/index.md#topics).

## I квартал 2025 {#q1-2025}

* Добавлена возможность отправлять push-уведомления в браузеры и прогрессивные веб-приложения [PWA](https://ru.wikipedia.org/wiki/Прогрессивное_веб-приложение). Интеграция с браузерами доступна в консоли управления, CLI, API, SDK.

   Подробнее в разделе [Push-уведомления в браузере](concepts/browser.md).

* Реализована настройка push-уведомлений для платформы [RuStore](https://www.rustore.ru/help/users/about-rustore) в консоли управления. Ранее были доступны интерфейсы CLI, API, SDK.

  Подробнее в разделе [Как начать работать с push-уведомлениями в Yandex Cloud Notification Service](quickstart-push.md).

* Добавлена возможность записывать и просматривать логи сервиса в Yandex Cloud Logging.
  
   Подробнее в разделе [Логи Cloud Logging](concepts/logging.md).

* Добавлена возможность строить графики по метрикам уведомлений в Yandex Monitoring.

   Подробнее в разделе [Справочник метрик Yandex Monitoring](metrics.md).

* Реализована поддержка AWS SDK для [C++](tools/sdk-cpp.md), [Go](tools/sdk-go.md), [Java](tools/sdk-java.md), [JavaScript](tools/sdk-javascript.md), [Kotlin](tools/sdk-kotlin.md), [.NET](tools/sdk-dot-net.md). В консоли управления добавлены примеры для этих SDK:
  
  * Создание эндпоинта для устройства.
  * Отправка сообщения в эндпоинт.

  Примеры доступны после создания канала на странице его настроек.

## IV квартал 2024 {#q4-2024}

* Добавлена возможность отправлять push-уведомления на мобильные устройства с приложением RuStore. Интеграция с [платформой RuStore](https://www.rustore.ru/help/users/about-rustore) доступна в интерфейсах CLI, API, SDK.
* Реализована поддержка [AWS SDK для PHP](https://docs.aws.amazon.com/sdk-for-php).
* В [консоли управления](https://console.yandex.cloud) добавлены примеры для AWS CLI, Python, PHP:
  * Создание эндпоинта для устройства.
  * Отправка сообщения в эндпоинт.

  Примеры доступны после создания канала на странице его настроек.

## III квартал 2024 {#q3-2024}
Сервис доступен по запросу на стадии [Preview](../overview/concepts/launch-stages.md).