# Правила тарификации для {{ load-testing-full-name }}

{% note warning %}

С 1 июля 2026 года сервис {{ load-testing-name }} прекращает работу. Подробнее на странице [Закрытие сервиса Yandex Load Testing](sunset.md).

{% endnote %}




Чтобы рассчитать стоимость использования сервиса, ознакомьтесь с тарифами в этом разделе.

Цены на продукты сервиса также доступны в [Прайс-листе](https://yandex.cloud/ru/price-list).


Все цены в рублях и тенге указаны с НДС, все цены в долларах — без НДС.

Плата за использование вычислительных ресурсов [агентов](concepts/agent.md) взимается по тарифам [{{ compute-full-name }}](../compute/pricing.md).

Тарификация посекундная.

Тесты, запущенные с нескольких агентов, тарифицируются как сумма тестов, запущенных каждым из агентов.

## Цены для региона Россия {#prices}

{% note info %}

Цены на ресурсы {{ yandex-cloud }} в разных регионах различаются. Подробнее о доступных регионах см. [{#T}](../overview/concepts/region.md).

Валюта, которой можно оплачивать ресурсы, зависит от юридического лица, с которым пользователь заключил договор. Подробнее о регистрации аккаунта см. [{#T}](../billing/quickstart/index.md).

{% endnote %}

Оплачивается:
* продолжительность выполнения тестов;
* продолжительность тестов, результаты которых будут храниться.


| Услуга | Цена | Ед. тарификации | Действует с | Действует до |
| ------ | ---- | --------------- | ----------- | ------------ |



## Примеры расчета стоимости {#amount-example}

В приведенных примерах цена за месяц использования указывается для справки из расчета 720 часов в месяц. 

### Время выполнения тестов {#test-time}


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  Например, выполнение тестов суммарной продолжительностью 60 часов будет стоить:
  
  > (50 × {% calc [currency=RUB]{{ sku|RUB|load_testing.test_execution.v1|number }} %}) + (10 × {% calc [currency=RUB]{{ sku|RUB|load_testing.test_execution.v1|pricingRate.180000|number }} × 3600 %}) = {% calc [currency=RUB] 50 × {{ sku|RUB|load_testing.test_execution.v1|number }} + 10 × {{ sku|RUB|load_testing.test_execution.v1|pricingRate.180000|number }} × 3600 %}

- Расчет в тенге {#prices-kzt}

  Например, выполнение тестов суммарной продолжительностью 60 часов будет стоить:
  
  > (50 × {% calc [currency=KZT] {{ sku|KZT|load_testing.test_execution.v1|number }} %}) + (10 × {% calc [currency=KZT] {{ sku|KZT|load_testing.test_execution.v1|pricingRate.180000|number }} × 3600 %}) = {% calc [currency=KZT] 50 × {{ sku|KZT|load_testing.test_execution.v1|number }} + 10 × {{ sku|KZT|load_testing.test_execution.v1|pricingRate.180000|number }} × 3600 %}

{% endlist %}



### Хранение результатов тестов {#test-results-storage}


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  Например, месяц хранения результатов тестов суммарной продолжительностью 640 часов будет стоить:
  
  > (600 × {% calc [currency=RUB] {{ sku|RUB|load_testing.storage.test_results.v1|number }} %}) + (40 × {% calc [currency=RUB] {{ sku|RUB|load_testing.storage.test_results.v1|pricingRate.2160000|number }} × 3600 %}) = {% calc [currency=RUB] 600 × {{ sku|RUB|load_testing.storage.test_results.v1|number }} + 40 × {{ sku|RUB|load_testing.storage.test_results.v1|pricingRate.2160000|number }} × 3600 %}

- Расчет в тенге {#prices-kzt}

  Например, месяц хранения результатов тестов суммарной продолжительностью 640 часов будет стоить:
  
  > (600 × {% calc [currency=KZT] {{ sku|KZT|load_testing.storage.test_results.v1|number }} %}) + (40 × {% calc [currency=KZT] {{ sku|KZT|load_testing.storage.test_results.v1|pricingRate.2160000|number }} × 3600 %}) = {% calc [currency=KZT] 600 × {{ sku|KZT|load_testing.storage.test_results.v1|number }} + 40 × {{ sku|KZT|load_testing.storage.test_results.v1|pricingRate.2160000|number }} × 3600 %}

{% endlist %}