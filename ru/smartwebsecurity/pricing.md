---
title: Правила тарификации для {{ sws-full-name }}
description: В статье содержатся правила тарификации сервиса {{ sws-name }}.
editable: false
---

# Правила тарификации для {{ sws-full-name }}




{% include [vat](../_includes/vat.md) %}

## Из чего складывается стоимость использования {{ sws-name }} {#rules}

Стоимость зависит от способа тарификации:

* [По подписке](#subscription) — подходит для больших объемов входящего трафика.
  
* [По количеству запросов](#requests) — подходит для небольшого объема входящего трафика.

Оба способа учитывают количество запросов по всем [облакам](../resource-manager/concepts/resources-hierarchy.md#cloud), привязанным к одному [платежному аккаунту](../billing/concepts/billing-account.md).

В тарификации учитываются только [легитимные запросы](concepts/rules.md#rule-action). Это запросы, которые были разрешены всеми правилами и пропущены к защищаемому ресурсу.

При этом есть особенности тарификации в режиме Dry run:

* Если правило заблокировало запрос, в режиме Dry run запросы не блокируются и достигают целевого назначения. Такие запросы учитываются в потреблении. 

* Если режим Dry run был установлен только для одного типа правил (например, правил профиля безопасности), а запрос заблокирован правилом WAF или ARL без режима Dry run, такой запрос не учитывается в потреблении.

Обработка запроса правилами из профилей ARL не учитываются в потреблении. Заблокированные запросы также не учитываются, независимо от того, на каком этапе и каким правилом они были заблокированы.

При использовании [доменов](concepts/domain-protect.md) дополнительно к стоимости обработанных запросов [взимается плата](#proxy-resources) за трафик, проходящий через прокси-сервер, и защиту от DDoS-атак на уровнях L3–L4 модели [OSI](https://wikipedia.org/wiki/OSI_model).

## Цены для региона Россия {#prices}

{% include [prices-nds-note](../_includes/prices-nds-note.md) %}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Тарификация по подписке {#subscription}

#| || [**Запросить подписку или тестирование**](https://yandex.cloud/ru/services/smartwebsecurity#contact-form) || |#

Оплачиваются пакеты легитимных запросов. В каждый пакет включено определенное количество запросов. Пакет WAF можно приобрести только вместе с пакетом AntiDDoS.

Цены на различные тарифы подписки приведены за 1 календарный месяц.

{% include [calendar-month](../_includes/smartcaptcha/calendar-month.md) %}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-subscription](../_pricing/smartwebsecurity/rub-subscription.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-subscription](../_pricing/smartwebsecurity/kzt-subscription.md) %}

{% endlist %}



Тарифы указаны для годовой подписки, подписка на месяц не предусмотрена.

Если выбранного тарифа окажется недостаточно, вы можете перейти на следующий с пропорциональным пересчетом уже потребленных ресурсов.

### Тарификация по запросам {#requests}

{% note tip %}


Чтобы рассчитать стоимость использования сервиса, воспользуйтесь [калькулятором](https://yandex.cloud/ru/prices?state=3f9244f089f5#calculator) на сайте {{ yandex-cloud }} или ознакомьтесь с тарифами в этом разделе.




{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

Период тарификации — календарный месяц. 
  
{% include [calendar-month](../_includes/smartcaptcha/calendar-month.md) %}

Оплачивается фактическое количество легитимных запросов. При этом для каждого запроса оплачивается:

* Обработка правилами профиля безопасности: [базовыми](concepts/rules.md#base-rules) и [Smart Protection](concepts/rules.md#smart-protection-rules).
  
* Обработка [правилами WAF](concepts/rules.md#waf-rules). Запрос, последовательно обработанный сначала правилами профиля безопасности, а затем правилами WAF, оплачивается за обе обработки.
  
* Обработка правилами в режиме Dry run, если запрос достиг защищаемого ресурса.

#### Запросы, обработанные правилами профиля безопасности {#requests-smart}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-requests](../_pricing/smartwebsecurity/rub-requests.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-requests](../_pricing/smartwebsecurity/kzt-requests.md) %}

{% endlist %}



#### Запросы, обработанные правилами WAF {#requests-waf}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-requests](../_pricing/smartwebsecurity/rub-requests-waf.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-requests](../_pricing/smartwebsecurity/kzt-requests-waf.md) %}

{% endlist %}



Чтобы дополнительно использовать защиту от DDoS-атак на уровнях 3 и 4 модели OSI, подключите [{{ ddos-protection-full-name }}](../vpc/ddos-protection/index.md). При этом будет взиматься оплата за [публичный IP-адрес](../vpc/pricing.md#prices-public-ip) и [{{ ddos-protection-full-name }}](../vpc/pricing.md#prices-ddos-protection).


#### Ресурсы прокси-сервера {#proxy-resources}

При использовании доменов вы платите за фактическое использование вычислительных ресурсов каждого активного прокси-сервера и за защиту трафика от DDoS-атак на уровнях L3–L4.

Объем использованных ресурсов прокси-сервера определяется как количество [ресурсных единиц](../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling) — внутренних виртуальных машин, создаваемых для работы прокси-сервера в каждой его зоне доступности.

Одна ресурсная единица рассчитана на следующие максимальные показатели (пороговые значения для автоматического масштабирования):

* 1000 запросов в секунду (RPS);
* 4000 одновременно активных соединений;
* 300 новых соединений в секунду;
* 22 МБ (176 Мбит) трафика в секунду (учитывается входящий и исходящий трафик).

Группа ресурсных единиц автоматически масштабируется в зависимости от внешней нагрузки на узлы прокси-сервера. Размер группы вычисляется таким образом, чтобы на каждую единицу приходилась нагрузка, не превышающая пороговых значений.

Минимальное количество ресурсных единиц прокси-сервера по умолчанию — 6 (по 2 в каждой зоне доступности). При необходимости количество ресурсных единиц прокси-сервера может быть увеличено по запросу.

Тарификация за использование прокси-сервера почасовая. Плата берется за минимальное количество ресурсных единиц, работавших в течение часа.

Защита трафика от DDoS-атак на уровнях L3–L4 тарифицируется по объему [легитимного](concepts/rules.md#rule-action) трафика в ГБ.

{% note warning %}

Цены на ресурсы прокси-сервера действуют с 10 ноября 2025 года.

{% endnote %}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-domain](../_pricing/smartwebsecurity/rub-domain.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-domain](../_pricing/smartwebsecurity/kzt-domain.md) %}

{% endlist %}




#### Пример расчета стоимости {{ sws-name }} по запросам {#price-example}

{% cut "Готовые расчеты стоимости запросов" %}

Чтобы оценить порядок стоимости запросов, в таблице ниже представлены расчеты цен за определенное количество запросов в месяц. В это количество не включен нетарифицируемый лимит — 10 000 запросов.
Стоимость приведена для ориентира, использование {{ sws-name }} вашими сервисами будет рассчитываться по фактическому количеству запросов.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-smartwebsecurity-pack](../_pricing_examples/smartwebsecurity/rub-smartwebsecurity-pack.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-smartwebsecurity-pack](../_pricing_examples/smartwebsecurity/kzt-smartwebsecurity-pack.md) %}

{% endlist %}



{% endcut %}


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-smartwebsecurity](../_pricing_examples/smartwebsecurity/rub-smartwebsecurity.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-smartwebsecurity](../_pricing_examples/smartwebsecurity/kzt-smartwebsecurity.md) %}

{% endlist %}



