---
title: Правила тарификации для {{ sws-full-name }}
description: В статье содержатся правила тарификации сервиса {{ sws-name }}.
editable: false
---

# Правила тарификации для {{ sws-full-name }}

::: page-constructor
blocks:
  - type: card-layout-block
    animated: false
    colSizes:
      all: 12
      md: 4
    indent:
      top: '0'
      bottom: '0'
    children:
      - type: basic-card
        title: Калькулятор цен
        text: Рассчитайте стоимость использования сервиса, исходя из ваших потребностей
        gravityIcon: Calculator
        urlTitle: Калькулятор цен
        url: https://yandex.cloud/ru/prices?state=04eae1045339#calculator
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Прайс-лист
        text: Актуальные тарифы на все наши услуги
        gravityIcon: CircleRuble
        urlTitle: Прайс-лист
        url: https://yandex.cloud/ru/price-list?services=dn2hj22hpe85kloqo6ag
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Акции и free tier
        text: Гранты, специальные условия и программы поддержки
        gravityIcon: Flame
        urlTitle: Акции и free tier
        url: https://yandex.cloud/ru/all-offers
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
:::





{% include [vat](../_includes/vat.md) %}

#| || [**Запросить подписку или тестирование**](https://yandex.cloud/ru/services/smartwebsecurity#contact-form) || |#

## Из чего складывается стоимость использования {{ sws-name }} {#rules}

В {{ sws-name }} доступны два способа тарификации:

* [По подписке](#subscription) — для обработки больших объемов трафика правилами профиля безопасности и Cloud WAF.
* [По количеству запросов](#requests) — для подключения [внешних доменов](#domain-protection-charges), использования [SolidWall WAF](#requests-solidwall-waf) и для обработки небольших объемов трафика правилами профиля безопасности и Cloud WAF. Для SolidWall WAF, [ресурсов прокси-сервера](#proxy-resources) и [Network Protection](#network-protection) действуют отдельные тарифы.

При обоих способах тарификации для профиля безопасности и Cloud WAF учитываются только [легитимные запросы](concepts/rules.md#rule-action) — те, которые сервис пропустил к защищаемому ресурсу. Сервис суммирует их за календарный месяц по всем [облакам](../resource-manager/concepts/resources-hierarchy.md#cloud), привязанным к одному [платежному аккаунту](../billing/concepts/billing-account.md).

{% include [calendar-month](../_includes/smartcaptcha/calendar-month.md) %}

Режим [«Только логирование»](concepts/rules.md#dry-run) (Dry run) включается для отдельных правил. Такое правило записывает срабатывание в лог без блокировки. Учет запроса зависит от результата остальных проверок.

* **Запрос дошел до ресурса.** По подписке он входит в месячный объем. При оплате по запросам он учитывается для профиля безопасности и отдельно для Cloud WAF, если тот проверил запрос. Для каждого вида обработки оплачиваются запросы сверх [бесплатного объема](#security-profile-cloud-waf).
* **Другое правило заблокировало запрос**, например правило [Advanced Rate Limiter](concepts/arl.md) (ARL) при превышении лимита запросов. Такой запрос не учитывается ни по подписке, ни при оплате по запросам.

За проверку правилами ARL отдельной платы нет.

Если используется [Network Protection](#network-protection-traffic), трафик, пропущенный узлами очистки, учитывается при расчете стоимости этой защиты даже в случае последующей блокировки запроса на уровне L7.

## Тарификация по подписке {#subscription}

Подписка действует год. [Выберите тариф](#subscription-prices) по ожидаемому количеству легитимных запросов за календарный месяц. Для профиля безопасности вы ежемесячно оплачиваете пакет AntiDDoS, а при подключении Cloud WAF — оба пакета, AntiDDoS и WAF.

Если запросов больше, чем входит в тариф, вы можете перейти на следующий тариф с пропорциональным пересчетом стоимости уже использованных ресурсов.

## Тарификация по количеству запросов {#requests}

### Профиль безопасности и Cloud WAF {#security-profile-cloud-waf}

Для профиля безопасности учитываются запросы, которые обработали [базовые правила](concepts/rules.md#base-rules) или [правила Smart Protection](concepts/rules.md#smart-protection-rules). Если запрос также проверили [правила Cloud WAF](concepts/rules.md#waf-rules), он учитывается и при расчете платы за Cloud WAF.

Для каждого вида обработки первые 10 000 запросов за календарный месяц бесплатны. Остальные оплачиваются по диапазонам. К числу запросов в каждом диапазоне применяется своя цена за миллион.

Например, за месяц профиль безопасности обработал 12 000 легитимных запросов по платежному аккаунту, а Cloud WAF проверил 8 000 из них. Вы заплатите только за обработку 2 000 запросов профилем безопасности. Для больших объемов приведены [примеры расчета по диапазонам](#price-example).

### Дополнительная защита L7-балансировщика {#load-balancer-ddos-protection}

Если профиль безопасности подключен к [L7-балансировщику {{ alb-name }}](../application-load-balancer/), для защиты от DDoS-атак на уровнях L3–L4 можно использовать [{{ ddos-protection-full-name }}](../vpc/ddos-protection/index.md). В этом случае [публичный IP-адрес](../vpc/pricing.md#prices-public-ip) и [защита от DDoS-атак](../vpc/pricing.md#prices-ddos-protection) оплачиваются отдельно.

### Защита доменов {#domain-protection-charges}

При [защите доменов](concepts/domain-protect.md) к стоимости обработки запросов добавляется плата за [ресурсы прокси-сервера](#proxy-resources) и [Network Protection](#network-protection). Если вы подключили [SolidWall WAF](#requests-solidwall-waf), его стоимость также рассчитывается отдельно.

#### Ресурсы прокси-сервера {#proxy-resources}

При активации защиты домена для прокси-сервера резервируется минимум шесть [ресурсных единиц](../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling), по две в каждой зоне доступности. Этот минимум можно увеличить по запросу.

Плата начисляется с момента активации, даже если прокси-сервер не получает трафик. За каждый час работы прокси-сервера оплачивается минимальное число ресурсных единиц, работавших в течение этого часа.

Ресурсная единица — внутренняя виртуальная машина, на которой работает прокси-сервер в зоне доступности. Сервис автоматически масштабирует группу таких машин, чтобы нагрузка на каждую из них оставалась в следующих пределах.

* 1 000 запросов в секунду (RPS).
* 4 000 одновременно активных соединений.
* 300 новых соединений в секунду.
* 22 МБ (176 Мбит) входящего и исходящего трафика в секунду суммарно.

#### Network Protection {#network-protection}

[Network Protection](concepts/network-protection.md) защищает прокси-сервер от DDoS-атак на уровнях L3–L4. Защита каждого прокси-сервера оплачивается по [единой цене за 1 Мбит/с](#network-protection-prices) при любой ширине полосы. Минимальной платы, минимальной оплачиваемой полосы и минимального срока использования нет.

##### Учет входящего трафика {#network-protection-traffic}

Учитывается входящий трафик, который узлы очистки пропустили на любой порт прокси-сервера, даже если запрос затем был заблокирован на уровне L7. Отброшенный узлами очистки трафик и исходящие ответы клиентам в расчет не входят. Если за расчетный период узлы очистки не пропустили входящего трафика, плата за Network Protection равна нулю.

##### Период защиты {#network-protection-period}

Защита адреса включается автоматически при создании прокси-сервера и действует до его удаления. Время остановки входит в период защиты. При расчете p95 и средней скорости пятиминутные интервалы без трафика учитываются с нулевой скоростью, поэтому остановка может не уменьшить стоимость.

При повторном запуске прокси-сервера сохраняется его статистика за месяц. Если вместо него создать новый, не удалив прежний, плата за защиту рассчитывается для обоих. Как это влияет на стоимость, показано в [примерах расчета Network Protection](#network-protection-price-example).

##### Расчет стоимости за месяц {#network-protection-formula}

Для каждого прокси-сервера тарифицируемая полоса равна большему из двух показателей скорости входящего трафика за время подключения к защите. Оба показателя измеряются в Мбит/с.

* **p95** — 95-й перцентиль средних скоростей за пятиминутные интервалы. Он снижает влияние кратковременных пиков нагрузки.
* **Средняя скорость** — суммарный объем учтенного трафика, деленный на длительность подключения. Кратковременный пик может увеличить среднюю скорость и стоимость защиты, даже если p95 не изменился.


**Стоимость за месяц = тариф × max(p95, средняя скорость) × T / M**.



`T` — суммарное время подключения за расчетный месяц, включая интервалы без трафика. `M` — длительность календарного месяца в тех же единицах времени. Месяц начинается первого числа в 00:00 UTC+3. За неполный месяц плата пропорциональна времени подключения. Если подключений не было, плата равна нулю.

##### Проверка начислений {#network-protection-billing}

В разделе [Детализация](../billing/operations/check-charges.md) сервиса {{ billing-name }} видны начисления с начала месяца. При изменении нагрузки сумма может расти неравномерно. Итоговую стоимость сервис рассчитывает по [формуле](#network-protection-formula) после окончания месяца. Для проверки используйте [данные {{ monium-full-name }}](operations/monitoring.md#network-protection) о пропущенном входящем трафике за тот же месяц для того же прокси-сервера.

#### SolidWall WAF {#requests-solidwall-waf}

Для SolidWall WAF нужен [профиль безопасности с правилом Smart Protection](operations/solidwall-waf-profile-create.md#setup). В дополнение к защите домена и [обработке запросов](#security-profile-cloud-waf) вы оплачиваете легитимный трафик и дополнительные приложения каждого профиля SolidWall WAF.

Плата за профиль начисляется с момента появления первого трафика, в том числе в режиме мониторинга, но не ранее 00:00 UTC+3 1 декабря 2026 года. За календарный месяц без трафика плата равна нулю.

##### Тариф и полоса RPS {#solidwall-waf-bandwidth}

[Тариф](concepts/solidwall-waf.md#tariffs) определяет, какие проверки выполняет SolidWall WAF.

* **{{ ui-key.yacloud.smart-web-security.solidWallBasicTariff_hB5xS }}** — проверяет запросы по сигнатурам атак при нагрузке до 1 000 RPS.
* **{{ ui-key.yacloud.smart-web-security.solidWallAdvancedTariff_6mLtW }}** — дополнительно анализирует ответы и пользовательские сессии с учетом логики приложения.

Полосу RPS выбирайте по ожидаемой пиковой нагрузке на все приложения профиля в сумме. Например, для пика в 600 запросов в секунду подойдет полоса 700 RPS. Тариф и полоса определяют [цену за один RPS в месяц](#solidwall-waf-prices). После появления первого трафика изменения тарифа и полосы вступают в силу с первого числа следующего месяца.

##### Стоимость легитимного трафика {#solidwall-waf-traffic}

В месяце с трафиком оплачивается как минимум выбранная полоса RPS. Если фактическая нагрузка выше, превышение оплачивается по ставке выбранной полосы. Фактическая нагрузка — 95-й перцентиль (p95) средних значений легитимного RPS за пятиминутные интервалы. Верхние 5 % значений в расчет не входят.

**Стоимость легитимного трафика за месяц = max(выбранная полоса RPS, p95 легитимного RPS) × ставка выбранной полосы × доля месяца**

В первом месяце p95 рассчитывается с момента появления первого трафика. Чтобы получить долю месяца, разделите число дней со дня первого трафика до конца месяца включительно на число календарных дней в месяце. В последующих месяцах с трафиком доля равна единице. Удаление профиля не сокращает оплачиваемый период. Эти случаи разобраны в [примерах расчета SolidWall WAF](#solidwall-waf-price-example).

##### Стоимость дополнительных приложений {#solidwall-waf-applications}

Для расчета используется максимальное число одновременно активных приложений за календарный месяц. Активным считается приложение с подключенным доменом, через которое проходит трафик. Первое приложение входит в тариф, каждое следующее оплачивается по цене дополнительного приложения. Удаление приложения не уменьшает уже учтенный максимум.

Общий расчет с учетом ресурсов прокси-сервера и обработки запросов профилем безопасности приведен в [примере для прокси-сервера и SolidWall WAF](#proxy-solidwall-waf-price-example).

## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Цены по подписке {#subscription-prices}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-subscription](../_pricing/smartwebsecurity/rub-subscription.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-subscription](../_pricing/smartwebsecurity/kzt-subscription.md) %}

{% endlist %}



### Цены при тарификации по запросам {#request-prices}

#### Network Protection {#network-protection-prices}

{% note warning %}

Тарифы Network Protection действуют с 1 декабря 2026 года.

{% endnote %}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-network-protection-pricing](../_pricing/smartwebsecurity/rub-network-protection-pricing.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-network-protection-pricing](../_pricing/smartwebsecurity/kzt-network-protection-pricing.md) %}

{% endlist %}



#### SolidWall WAF {#solidwall-waf-prices}

{% note warning %}

Тарифы SolidWall WAF действуют с 1 декабря 2026 года.

{% endnote %}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-solidwall-waf-pricing](../_pricing/smartwebsecurity/rub-solidwall-waf-pricing.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-solidwall-waf-pricing](../_pricing/smartwebsecurity/kzt-solidwall-waf-pricing.md) %}

{% endlist %}



#### Калькулятор и прайс-лист {#calculator-price-list}

<MDX>
  <Calculator
    services={['smartwebsecurity']} collapsible
  />
</MDX>


<MDX>
  <PriceList
    serviceIds={['{{ pcs|sws }}']}
    installationCode="ru"
    currency="RUB"
  />
</MDX>



## Примеры расчета стоимости {#price-examples}

### Пример расчета стоимости {{ sws-name }} по запросам {#price-example}

{% cut "Готовые расчеты стоимости запросов" %}

В таблице приведена стоимость обработки легитимных запросов за календарный месяц с учетом бесплатных первых 10 000 запросов. Количество запросов указано суммарно по всем облакам платежного аккаунта. В последнем столбце предполагается, что каждый запрос обработан и профилем безопасности, и Cloud WAF.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-smartwebsecurity-pack](../_pricing_examples/smartwebsecurity/rub-smartwebsecurity-pack.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-smartwebsecurity-pack](../_pricing_examples/smartwebsecurity/kzt-smartwebsecurity-pack.md) %}

{% endlist %}



{% endcut %}

В примерах ниже предполагается, что других запросов по платежному аккаунту в этом месяце нет.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-requests-pricing-examples](../_includes/smartwebsecurity/rub-requests-pricing-examples.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-requests-pricing-examples](../_includes/smartwebsecurity/kzt-requests-pricing-examples.md) %}

{% endlist %}



### Примеры расчета стоимости Network Protection {#network-protection-price-example}


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-network-protection](../_pricing_examples/smartwebsecurity/rub-network-protection.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-network-protection](../_pricing_examples/smartwebsecurity/kzt-network-protection.md) %}

{% endlist %}



### Примеры расчета стоимости SolidWall WAF {#solidwall-waf-price-example}

Рассчитаем стоимость за месяц, в котором 31 день (744 часа), на примере декабря.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-solidwall-waf](../_pricing_examples/smartwebsecurity/rub-solidwall-waf.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-solidwall-waf](../_pricing_examples/smartwebsecurity/kzt-solidwall-waf.md) %}

{% endlist %}



### Пример расчета стоимости прокси-сервера и SolidWall WAF {#proxy-solidwall-waf-price-example}

Рассчитаем стоимость ресурсов прокси-сервера, обработки запросов профилем безопасности и SolidWall WAF за календарный месяц (30 дней, 720 часов) при следующих условиях:

* Один прокси-сервер использует шесть ресурсных единиц в течение всего месяца без масштабирования.
* В SolidWall WAF выбран тариф **{{ ui-key.yacloud.smart-web-security.solidWallBasicTariff_hB5xS }}** с полосой 300 RPS. Фактическая нагрузка не превышает 300 RPS.
* В профиле SolidWall WAF весь месяц активны два приложения. Первое включено в тариф, за второе взимается плата.
* К доменам подключен профиль безопасности с правилом Smart Protection. За месяц он обработал 10 млн легитимных запросов. Других запросов по платежному аккаунту в этом месяце нет.

При расчете платы за обработку правилами профиля безопасности первые 10 000 запросов бесплатны. Для остальных 9,99 млн запросов применяются цены за миллион из соответствующих диапазонов.

При использовании Cloud WAF обработка запросов его правилами оплачивается дополнительно.

Плата за [Network Protection](#network-protection) рассчитывается отдельно по скорости пропущенного входящего трафика и длительности подключения к защите. Порядок расчета показан в [примерах для Network Protection](#network-protection-price-example).


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-proxy-solidwall-waf](../_pricing_examples/smartwebsecurity/rub-proxy-solidwall-waf.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-proxy-solidwall-waf](../_pricing_examples/smartwebsecurity/kzt-proxy-solidwall-waf.md) %}

{% endlist %}



