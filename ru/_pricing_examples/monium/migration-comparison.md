#|
|| | **{{ cloud-logging-name }}** | **{{ monium-name }}** ||
|| **Запись** | {{ sku|RUB|logging.ingested.traffic|pricingRate.5|string }} или {{ sku|KZT|logging.ingested.traffic|pricingRate.5|string }} (ГБ в месяц) | {{ sku|RUB|monium.logs.ingested.traffic|string }} или {{ sku|KZT|monium.logs.ingested.traffic|string }} (ГБ в месяц) ||
|| **Хранение** | Тарифицируется | Не тарифицируется, [TTL](../../monium/concepts/common-ttl.md#ttl-logs) — 31 день ||
|| **Чтение и аналитика** | Базовый поиск по логам | Агрегации, единый язык запросов для логов, метрик и трейсов ||
|| **Миграция** | — | Сменить формат (OTEL) и эндпоинт ||
|#
