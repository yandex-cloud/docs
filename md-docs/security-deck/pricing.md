# Правила тарификации {{ sd-full-name }}




Все цены в рублях и тенге указаны с НДС, все цены в долларах — без НДС.

В {{ sd-name }} каждый модуль тарифицируется отдельно. Доступен стартовый пакетный тариф, включающий несколько модулей.

Ниже представлены правила тарификации для следующих модулей и тарифов:

* [Стартовый пакетный тариф](#starter-rules).
* [Модуль контроля данных ({{ dspm-name }})](concepts/dspm.md).
* [{{ atr-name }}](concepts/access-transparency.md).
* [Модуль контроля {{ k8s }}® ({{ kspm-name }})](concepts/kspm.md).
* [Модуль контроля конфигурации ({{ cspm-name }})](concepts/cspm.md).

{% note info %}

[Модуль диагностики доступов ({{ ciem-name }})](concepts/ciem.md) и [AI-ассистент](concepts/ai-assistant.md) не тарифицируются.

{% endnote %}


## Из чего складывается стоимость использования {{ sd-name }} {#rules}

### Стартовый пакетный тариф {#starter-rules}

Тариф включает [модуль контроля конфигурации](concepts/cspm.md) и [модуль обнаружения угроз](concepts/threat-detector.md).

Цены на тарифы подписки приведены за 1 календарный месяц.
Календарный месяц определяется как период с 00:00 первого числа месяца до 23:59 последнего числа того же месяца по московскому времени (UTC+3).

Цены за количество ресурсов в месяц фиксированы и не зависят от количества дней в месяце.

### {{ atr-name }} {#atr-rules}

Стоимость использования модуля {{ atr-name }} рассчитывается ежемесячно и зависит от совокупного потребления ресурсов за предшествующий месяц в организации, для которой подключается {{ atr-name }}. Чтобы рассчитать потребление ресурсов для вашей организации, проанализируйте [детализацию по всем сервисам](../billing/operations/check-charges.md#services_1) для каждого [платежного аккаунта](../billing/concepts/billing-account.md), привязанного к этой организации.

Цена рассчитывается в начале календарного месяца и не изменяется в течение месяца. Цена также не зависит от продолжительности календарного месяца при использовании {{ atr-name }} с первого числа месяца.

При использовании {{ atr-name }} со второго числа месяца и далее будет тарифицироваться только время, оставшееся до конца месяца по принципу почасовой оплаты.

Если вы отмените подписку {{ atr-name }} в [консоли управления]({{ link-console-main }}), оплата за нее перестанет начисляться с первого числа следующего календарного месяца.

### Модуль контроля данных ({{ dspm-name }}) {#dspm-rules}

При [сканировании данных](operations/dspm/create-scan.md) модуль контроля данных ({{ dspm-name }}) выполняет запросы к файлам в бакетах {{ objstorage-full-name }}. Запросы тарифицируются по [правилам тарификации](../storage/pricing.md) {{ objstorage-name }}. Использование модуля тарифицируется дополнительно.

### Модуль контроля {{ k8s }} ({{ kspm-name }}) {#kspm-rules}

Стоимость использования модуля контроля {{ k8s }} ({{ kspm-name }}) рассчитывается ежемесячно исходя из количества рабочих узлов в кластерах [{{ managed-k8s-full-name }}](../managed-kubernetes/index.md), которые подключены к сканированию.

### Модуль контроля конфигурации ({{ cspm-name }}) {#cspm-rules}

Стоимость использования модуля {{ cspm-name }} рассчитывается ежемесячно и зависит от выбранного в окружении стандарта для проверки инфраструктуры и количества ресурсов, включенных в проверку. Тарифицируются все стандарты, кроме [базовых правил безопасности облачной платформы {{ yandex-cloud }}](concepts/standard-compliance/yc-security-baseline.md).

Каждое окружение тарифицируется отдельно, даже если ресурсы в них пересекаются.

Неактивные ресурсы также тарифицируются.

Цена не зависит от продолжительности календарного месяца.


## Цены для региона Россия {#prices}

{% note info %}

Цены на ресурсы {{ yandex-cloud }} в разных регионах различаются. Подробнее о доступных регионах см. [{#T}](../overview/concepts/region.md).

Валюта, которой можно оплачивать ресурсы, зависит от юридического лица, с которым пользователь заключил договор. Подробнее о регистрации аккаунта см. [{#T}](../billing/quickstart/index.md).

{% endnote %}

### Стартовый пакетный тариф {#starter-pricing}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  | Тариф | Стоимость в месяц, вкл. НДС |
  | ------------------- | ------------------------------- |
  | Security Deck. Стартовый пакетный тариф, от 1 до 50 ресурсов | 25 960 ₽ |
  | Security Deck. Стартовый пакетный тариф, от 51 до 100 ресурсов | 51 920 ₽ |
  | Security Deck. Стартовый пакетный тариф, от 101 до 250 ресурсов | 127 145 ₽ |
  | Security Deck. Стартовый пакетный тариф, от 251 до 500 ресурсов | 247 800 ₽ |

- Цены в тенге {#prices-kzt}

  | Тариф | Стоимость в месяц, вкл. НДС |
  | ------------------- | ------------------------------- |
  | Security Deck. Стартовый пакетный тариф, от 1 до 50 ресурсов | 129 800 ₸ |
  | Security Deck. Стартовый пакетный тариф, от 51 до 100 ресурсов | 259 600 ₸ |
  | Security Deck. Стартовый пакетный тариф, от 101 до 250 ресурсов | 635 725 ₸ |
  | Security Deck. Стартовый пакетный тариф, от 251 до 500 ресурсов | 1 239 000 ₸ |

{% endlist %}



### {{ atr-name }} {#atr-pricing}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  | Совокупное потребление ресурсов в организации<br>за предыдущий месяц | Стоимость подписки на месяц, вкл. НДС |
  | -------------------------------------------------------------------- | --------------------------------------------------------|
  | Менее 1 000 000 ₽ | {{ sku|RUB|security_deck.access_transparency.subscription.v1|string }} |
  | От 1 000 000 до 5 000 000 ₽ | 122 000 ₽ |
  | От 5 000 000 до 10 000 000 ₽ | 183 000 ₽ |
  | От 10 000 000 до 20 000 000 ₽ | 366 000 ₽ |
  | Более 20 000 000 ₽ | 457 500 ₽ |

- Цены в тенге {#prices-kzt}

  | Совокупное потребление ресурсов в организации<br>за предыдущий месяц | Стоимость подписки на месяц, вкл. НДС |
  | -------------------------------------------------------------------- | ------------------------------------------------------- |
  | Менее 5 000 000 ₸ | 355 835 ₸ |
  | От 5 000 000 до 25 000 000 ₸ | 610 000 ₸ |
  | От 25 000 000 до 50 000 000 ₸ | 915 000 ₸ |
  | От 50 000 000 до 100 000 000 ₸ | 1 830 000 ₸ |
  | Более 100 000 000 ₸ | 2 287 500 ₸ |

{% endlist %}



### Модуль контроля данных ({{ dspm-name }}) {#dspm-pricing}


| Услуга | Цена | Ед. тарификации | Действует с | Действует до |
| ------ | ---- | --------------- | ----------- | ------------ |




#### Пример расчета стоимости {#amount-example}

Например, вы настроили сканирование бакета, в котором хранится 50 текстовых файлов общим объемом 5 ГБ. Все файлы были просканированы. Итоговая стоимость одного сканирования составит:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  5 × {{ sku|RUB|security_deck.dspm.scanned.text.v1|string }} + ({{ sku|RUB|security_deck.dspm.scanned.files.v1|string }} × 50 / 10 000) = {% calc [currency=RUB] 5 × {{ sku|RUB|security_deck.dspm.scanned.text.v1|number }} + ({{ sku|RUB|security_deck.dspm.scanned.files.v1|number }} × 50 / 10 000) %}

- Расчет в тенге {#prices-kzt}

  5 × {{ sku|KZT|security_deck.dspm.scanned.text.v1|string }} + ({{ sku|KZT|security_deck.dspm.scanned.files.v1|string }} × 50 / 10 000) = {% calc [currency=KZT] 5 × {{ sku|KZT|security_deck.dspm.scanned.text.v1|number }} + ({{ sku|KZT|security_deck.dspm.scanned.files.v1|number }} × 50 / 10 000) %}

{% endlist %}



### Модуль контроля {{ k8s }} ({{ kspm-name }}) {#kspm-pricing}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  | Услуга | Стоимость использования в месяц, вкл. НДС |
  | --- | --- |
  | 1 рабочий узел {{ kspm-name }} | {{ sku|RUB|security_deck.kspm.nodes|pricingRate.2|string }} |

- Цены в тенге {#prices-kzt}

  | Услуга | Стоимость использования в месяц, вкл. НДС |
  | --- | --- |
  | 1 рабочий узел {{ kspm-name }} | {{ sku|KZT|security_deck.kspm.nodes|pricingRate.2|string }} |

{% endlist %}



### Модуль контроля конфигурации ({{ cspm-name }}) {#cspm-pricing}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  | Сервис | Проверяемый ресурс | Стоимость проверки одного ресурса,<br/>вкл. НДС |
  | --- | --- | --- |
  | {{ compute-full-name }} | Виртуальная машина | {{ sku|RUB|security_deck.cspm.resources|string }} |
  | {{ objstorage-full-name }} | Бакет | {{ sku|RUB|security_deck.cspm.resources|string }} |
  | {{ mch-full-name }} | Кластер баз данных | {{ sku|RUB|security_deck.cspm.resources|string }} |
  | {{ mgp-full-name }} | Кластер баз данных | {{ sku|RUB|security_deck.cspm.resources|string }} |
  | {{ mkf-full-name }} | Кластер баз данных | {{ sku|RUB|security_deck.cspm.resources|string }} |
  | {{ mmy-full-name }} | Кластер баз данных | {{ sku|RUB|security_deck.cspm.resources|string }} |
  | {{ mmg-full-name }} | Кластер баз данных | {{ sku|RUB|security_deck.cspm.resources|string }} |
  | {{ mos-full-name }} | Кластер баз данных | {{ sku|RUB|security_deck.cspm.resources|string }} |
  | {{ mpg-full-name }} | Кластер баз данных | {{ sku|RUB|security_deck.cspm.resources|string }} |
  | {{ mrd-full-name }} | Кластер баз данных | {{ sku|RUB|security_deck.cspm.resources|string }} |
  | {{ managed-k8s-full-name }} | Кластер {{ k8s }} | {{ sku|RUB|security_deck.cspm.resources|string }} |
  | {{ vpc-full-name }} | Облачная сеть | {{ sku|RUB|security_deck.cspm.resources|string }} |

- Цены в тенге {#prices-kzt}

  | Сервис | Проверяемый ресурс | Стоимость проверки одного ресурса,<br/>вкл. НДС |
  | --- | --- | --- |
  | {{ compute-full-name }} | Виртуальная машина | {{ sku|KZT|security_deck.cspm.resources|string }} |
  | {{ objstorage-full-name }} | Бакет | {{ sku|KZT|security_deck.cspm.resources|string }} |
  | {{ mch-full-name }} | Кластер баз данных | {{ sku|KZT|security_deck.cspm.resources|string }} |
  | {{ mgp-full-name }} | Кластер баз данных | {{ sku|KZT|security_deck.cspm.resources|string }} |
  | {{ mkf-full-name }} | Кластер баз данных | {{ sku|KZT|security_deck.cspm.resources|string }} |
  | {{ mmy-full-name }} | Кластер баз данных | {{ sku|KZT|security_deck.cspm.resources|string }} |
  | {{ mmg-full-name }} | Кластер баз данных | {{ sku|KZT|security_deck.cspm.resources|string }} |
  | {{ mos-full-name }} | Кластер баз данных | {{ sku|KZT|security_deck.cspm.resources|string }} |
  | {{ mpg-full-name }} | Кластер баз данных | {{ sku|KZT|security_deck.cspm.resources|string }} |
  | {{ mrd-full-name }} | Кластер баз данных | {{ sku|KZT|security_deck.cspm.resources|string }} |
  | {{ managed-k8s-full-name }} | Кластер {{ k8s }} | {{ sku|KZT|security_deck.cspm.resources|string }} |
  | {{ vpc-full-name }} | Облачная сеть | {{ sku|KZT|security_deck.cspm.resources|string }} |

{% endlist %}