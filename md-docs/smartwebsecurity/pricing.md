# Правила тарификации для {{ sws-full-name }}




Все цены в рублях и тенге указаны с НДС, все цены в долларах — без НДС.

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

При использовании [доменов](concepts/domain-protect.md) дополнительно к стоимости обработанных запросов [взимается плата](#proxy-resources) за трафик, проходящий через прокси-сервер, и защиту от DDoS-атак на уровнях L3–L4 модели [OSI](https://wikipedia.org/wiki/OSI_model). Защиту доменов можно включить только при тарификации по количеству запросов — в подписку она не включена.

## Цены для региона Россия {#prices}

{% note info %}

Цены на ресурсы {{ yandex-cloud }} в разных регионах различаются. Подробнее о доступных регионах см. [{#T}](../overview/concepts/region.md).

Валюта, которой можно оплачивать ресурсы, зависит от юридического лица, с которым пользователь заключил договор. Подробнее о регистрации аккаунта см. [{#T}](../billing/quickstart/index.md).

{% endnote %}

### Тарификация по подписке {#subscription}

#| || [**Запросить подписку или тестирование**](https://yandex.cloud/ru/services/smartwebsecurity#contact-form) || |#

Оплачиваются пакеты легитимных запросов. В каждый пакет включено определенное количество запросов. Пакет WAF можно приобрести только вместе с пакетом AntiDDoS.

Цены на различные тарифы подписки приведены за 1 календарный месяц.

Календарный месяц определяется как период с 00:00 первого числа месяца до 23:59 последнего числа того же месяца по московскому времени (UTC+3). Цены за количество запросов в месяц фиксированы и не зависят от количества дней в месяце.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  #|
  || | **Start, вкл. НДС** | **Pro, вкл. НДС** | **Business, вкл. НДС**| **Enterprise** ||
  
  || Количество легитимных запросов в месяц, включенных в абонентскую плату, в миллионах
  | 100 {align="center"}| 500 {align="center"} | 1 000 {align="center"}| Рассчитывается индивидуально ||
  
  || Абонентская плата за пакет AntiDDoS, ежемесячно. Пакет включает обработку запросов правилами [профиля безопасности](concepts/profiles.md):
  * [базовыми](concepts/rules.md#base-rules)
  * [Smart Protection](concepts/rules.md#smart-protection-rules)
  | 50&nbsp;833&nbsp;₽ {align="center"}
  | 160&nbsp;633&nbsp;₽ {align="center"}
  | 259&nbsp;250&nbsp;₽ {align="center"}
  | Рассчитывается индивидуально ||
  
  || Абонентская плата за пакет WAF, ежемесячно. Пакет включает анализ запросов [правилами WAF](concepts/rules.md#waf-rules)
  | 40&nbsp;667&nbsp;₽ {align="center"}
  | 76&nbsp;250&nbsp;₽ {align="center"}
  | 152&nbsp;500&nbsp;₽ {align="center"}
  | Рассчитывается индивидуально ||
  |#

- Цены в тенге {#prices-kzt}

  #|
  || | **Start, вкл. НДС** | **Pro, вкл. НДС** | **Business, вкл. НДС**| **Enterprise** ||
  
  || Количество легитимных запросов в месяц, включенных в абонентскую плату, в миллионах
  | 100 {align="center"}| 500 {align="center"} | 1 000 {align="center"}| Рассчитывается индивидуально ||
  
  || Абонентская плата за пакет AntiDDoS, ежемесячно. Пакет включает обработку запросов правилами [профиля безопасности](concepts/profiles.md):
  * [базовыми](concepts/rules.md#base-rules)
  * [Smart Protection](concepts/rules.md#smart-protection-rules)
  | 254&nbsp;165&nbsp;₸ {align="center"}
  | 803&nbsp;165&nbsp;₸ {align="center"}
  | 1&nbsp;296&nbsp;250&nbsp;₸ {align="center"}
  | Рассчитывается индивидуально ||
  
  || Абонентская плата за пакет WAF, ежемесячно. Пакет включает анализ запросов [правилами WAF](concepts/rules.md#waf-rules)
  | 203&nbsp;335&nbsp;₸ {align="center"}
  | 381&nbsp;250&nbsp;₸ {align="center"}
  | 762&nbsp;500&nbsp;₸ {align="center"}
  | Рассчитывается индивидуально ||
  |#

{% endlist %}



Тарифы указаны для годовой подписки, подписка на месяц не предусмотрена.

Если выбранного тарифа окажется недостаточно, вы можете перейти на следующий с пропорциональным пересчетом уже потребленных ресурсов.

### Тарификация по запросам {#requests}

{% note tip %}


Чтобы рассчитать стоимость использования сервиса, воспользуйтесь [калькулятором](https://yandex.cloud/ru/prices?state=3f9244f089f5#calculator) на сайте {{ yandex-cloud }} или ознакомьтесь с тарифами в этом разделе.




{% endnote %}

Цены на продукты сервиса также доступны в [Прайс-листе](https://yandex.cloud/ru/price-list).

Период тарификации — календарный месяц. 
  
Календарный месяц определяется как период с 00:00 первого числа месяца до 23:59 последнего числа того же месяца по московскому времени (UTC+3). Цены за количество запросов в месяц фиксированы и не зависят от количества дней в месяце.

Оплачивается фактическое количество легитимных запросов. При этом для каждого запроса оплачивается:

* Обработка правилами профиля безопасности: [базовыми](concepts/rules.md#base-rules) и [Smart Protection](concepts/rules.md#smart-protection-rules).
  
* Обработка [правилами WAF](concepts/rules.md#waf-rules). Запрос, последовательно обработанный сначала правилами профиля безопасности, а затем правилами WAF, оплачивается за обе обработки.
  
* Обработка правилами в режиме Dry run, если запрос достиг защищаемого ресурса.

Чтобы дополнительно использовать защиту от DDoS-атак на уровнях 3 и 4 модели OSI, подключите [{{ ddos-protection-full-name }}](../vpc/ddos-protection/index.md). При этом будет взиматься оплата за [публичный IP-адрес](../vpc/pricing.md#prices-public-ip) и [{{ ddos-protection-full-name }}](../vpc/pricing.md#prices-ddos-protection).

#### Ресурсы прокси-сервера {#proxy-resources}

При использовании доменов вы платите за фактическое использование вычислительных ресурсов каждого активного прокси-сервера и за защиту трафика от DDoS-атак на уровнях L3–L4.

При активации защиты домена автоматически резервируется минимальный объем ресурсов прокси-сервера — 6 [ресурсных единиц](../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling), по 2 в каждой зоне доступности. Их тарификация начинается сразу, независимо от того, получает ли домен трафик.

Ресурсная единица — это внутренняя виртуальная машина, которая создается для работы прокси-сервера в зоне доступности.

Одна ресурсная единица рассчитана на следующие максимальные показатели (пороговые значения для автоматического масштабирования):

* 1000 запросов в секунду (RPS);
* 4000 одновременно активных соединений;
* 300 новых соединений в секунду;
* 22 МБ (176 Мбит) трафика в секунду (учитывается входящий и исходящий трафик).

Группа ресурсных единиц автоматически масштабируется в зависимости от внешней нагрузки на узлы прокси-сервера. Размер группы вычисляется таким образом, чтобы на каждую единицу приходилась нагрузка, не превышающая пороговых значений.

Минимальное количество ресурсных единиц по умолчанию — 6, его можно увеличить по запросу.

Тарификация за использование прокси-сервера почасовая. Плата берется за минимальное количество ресурсных единиц, работавших в течение часа.

Защита трафика от DDoS-атак на уровнях L3–L4 тарифицируется по объему [легитимного](concepts/rules.md#rule-action) трафика в ГБ.


| Услуга | Цена | Ед. тарификации | Действует с | Действует до |
| ------ | ---- | --------------- | ----------- | ------------ |





#### Пример расчета стоимости {{ sws-name }} по запросам {#price-example}

{% cut "Готовые расчеты стоимости запросов" %}

Чтобы оценить порядок стоимости запросов, в таблице ниже представлены расчеты цен за определенное количество запросов в месяц. В это количество не включен нетарифицируемый лимит — 10 000 запросов.
Стоимость приведена для ориентира, использование {{ sws-name }} вашими сервисами будет рассчитываться по фактическому количеству запросов.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  | Количество запросов в месяц, млн | Стоимость запросов, разрешенных профилем безопасности, вкл. НДС | Стоимость запросов, разрешенных профилями безопасности и WAF, вкл. НДС |
  | --- | --- | --- |
  | 1 | {{ sku|RUB|sws.requests.v1|pricingRate.0.01|string }} | {% calc [currency=RUB] {{ sku|RUB|sws.requests.v1|pricingRate.0.01|number }} + {{ sku|RUB|sws.waf.requests.v1|pricingRate.0.01|number }} %} |
  | 10 | {% calc [currency=RUB] {{ sku|RUB|sws.requests.v1|pricingRate.0.01|number }} + {{ sku|RUB|sws.requests.v1|pricingRate.1|number }} × 9 %} | {% calc [currency=RUB] ({{ sku|RUB|sws.requests.v1|pricingRate.0.01|number }} + {{ sku|RUB|sws.requests.v1|pricingRate.1|number }} × 9) + ({{ sku|RUB|sws.waf.requests.v1|pricingRate.0.01|number }} + {{ sku|RUB|sws.waf.requests.v1|pricingRate.1|number }} × 9) %} |
  | 100 | {% calc [currency=RUB] {{ sku|RUB|sws.requests.v1|pricingRate.0.01|number }} + {{ sku|RUB|sws.requests.v1|pricingRate.1|number }} × 9 + {{ sku|RUB|sws.requests.v1|pricingRate.10|number }} × 90 %} | {% calc [currency=RUB] ({{ sku|RUB|sws.requests.v1|pricingRate.0.01|number }} + {{ sku|RUB|sws.requests.v1|pricingRate.1|number }} × 9 + {{ sku|RUB|sws.requests.v1|pricingRate.10|number }} × 90) + ({{ sku|RUB|sws.waf.requests.v1|pricingRate.0.01|number }} + {{ sku|RUB|sws.waf.requests.v1|pricingRate.1|number }} × 9 + {{ sku|RUB|sws.waf.requests.v1|pricingRate.10|number }} × 90) %} |
  | 1 000 | {% calc [currency=RUB] {{ sku|RUB|sws.requests.v1|pricingRate.0.01|number }} + {{ sku|RUB|sws.requests.v1|pricingRate.1|number }} × 9 + {{ sku|RUB|sws.requests.v1|pricingRate.10|number }} × 90 + {{ sku|RUB|sws.requests.v1|pricingRate.100|number }} × 900 %} | {% calc [currency=RUB] ({{ sku|RUB|sws.requests.v1|pricingRate.0.01|number }} + {{ sku|RUB|sws.requests.v1|pricingRate.1|number }} × 9 + {{ sku|RUB|sws.requests.v1|pricingRate.10|number }} × 90 + {{ sku|RUB|sws.requests.v1|pricingRate.100|number }} × 900) + ({{ sku|RUB|sws.waf.requests.v1|pricingRate.0.01|number }} + {{ sku|RUB|sws.waf.requests.v1|pricingRate.1|number }} × 9 + {{ sku|RUB|sws.waf.requests.v1|pricingRate.10|number }} × 90 + {{ sku|RUB|sws.waf.requests.v1|pricingRate.100|number }} × 900) %} |
  | 10 000 | {% calc [currency=RUB] {{ sku|RUB|sws.requests.v1|pricingRate.0.01|number }} + {{ sku|RUB|sws.requests.v1|pricingRate.1|number }} × 9 + {{ sku|RUB|sws.requests.v1|pricingRate.10|number }} × 90 + {{ sku|RUB|sws.requests.v1|pricingRate.100|number }} × 900 + {{ sku|RUB|sws.requests.v1|pricingRate.1000|number }} × 9000 %} | {% calc [currency=RUB] ({{ sku|RUB|sws.requests.v1|pricingRate.0.01|number }} + {{ sku|RUB|sws.requests.v1|pricingRate.1|number }} × 9 + {{ sku|RUB|sws.requests.v1|pricingRate.10|number }} × 90 + {{ sku|RUB|sws.requests.v1|pricingRate.100|number }} × 900 + {{ sku|RUB|sws.requests.v1|pricingRate.1000|number }} × 9000) + ({{ sku|RUB|sws.waf.requests.v1|pricingRate.0.01|number }} + {{ sku|RUB|sws.waf.requests.v1|pricingRate.1|number }} × 9 + {{ sku|RUB|sws.waf.requests.v1|pricingRate.10|number }} × 90 + {{ sku|RUB|sws.waf.requests.v1|pricingRate.100|number }} × 900 + {{ sku|RUB|sws.waf.requests.v1|pricingRate.1000|number }} × 9000) %} |

- Расчет в тенге {#prices-kzt}

  | Количество запросов в месяц, млн | Стоимость запросов, разрешенных профилем безопасности, вкл. НДС | Стоимость запросов, разрешенных профилями безопасности и WAF, вкл. НДС |
  | --- | --- | --- |
  | 1 | {{ sku|KZT|sws.requests.v1|pricingRate.0.01|string }} | {% calc [currency=KZT] {{ sku|KZT|sws.requests.v1|pricingRate.0.01|number }} + {{ sku|KZT|sws.waf.requests.v1|pricingRate.0.01|number }} %} |
  | 10 | {% calc [currency=KZT] {{ sku|KZT|sws.requests.v1|pricingRate.0.01|number }} + {{ sku|KZT|sws.requests.v1|pricingRate.1|number }} × 9 %} | {% calc [currency=KZT] ({{ sku|KZT|sws.requests.v1|pricingRate.0.01|number }} + {{ sku|KZT|sws.requests.v1|pricingRate.1|number }} × 9) + ({{ sku|KZT|sws.waf.requests.v1|pricingRate.0.01|number }} + {{ sku|KZT|sws.waf.requests.v1|pricingRate.1|number }} × 9) %} |
  | 100 | {% calc [currency=KZT] {{ sku|KZT|sws.requests.v1|pricingRate.0.01|number }} + {{ sku|KZT|sws.requests.v1|pricingRate.1|number }} × 9 + {{ sku|KZT|sws.requests.v1|pricingRate.10|number }} × 90 %} | {% calc [currency=KZT] ({{ sku|KZT|sws.requests.v1|pricingRate.0.01|number }} + {{ sku|KZT|sws.requests.v1|pricingRate.1|number }} × 9 + {{ sku|KZT|sws.requests.v1|pricingRate.10|number }} × 90) + ({{ sku|KZT|sws.waf.requests.v1|pricingRate.0.01|number }} + {{ sku|KZT|sws.waf.requests.v1|pricingRate.1|number }} × 9 + {{ sku|KZT|sws.waf.requests.v1|pricingRate.10|number }} × 90) %} |
  | 1 000 | {% calc [currency=KZT] {{ sku|KZT|sws.requests.v1|pricingRate.0.01|number }} + {{ sku|KZT|sws.requests.v1|pricingRate.1|number }} × 9 + {{ sku|KZT|sws.requests.v1|pricingRate.10|number }} × 90 + {{ sku|KZT|sws.requests.v1|pricingRate.100|number }} × 900 %} | {% calc [currency=KZT] ({{ sku|KZT|sws.requests.v1|pricingRate.0.01|number }} + {{ sku|KZT|sws.requests.v1|pricingRate.1|number }} × 9 + {{ sku|KZT|sws.requests.v1|pricingRate.10|number }} × 90 + {{ sku|KZT|sws.requests.v1|pricingRate.100|number }} × 900) + ({{ sku|KZT|sws.waf.requests.v1|pricingRate.0.01|number }} + {{ sku|KZT|sws.waf.requests.v1|pricingRate.1|number }} × 9 + {{ sku|KZT|sws.waf.requests.v1|pricingRate.10|number }} × 90 + {{ sku|KZT|sws.waf.requests.v1|pricingRate.100|number }} × 900) %} |
  | 10 000 | {% calc [currency=KZT] {{ sku|KZT|sws.requests.v1|pricingRate.0.01|number }} + {{ sku|KZT|sws.requests.v1|pricingRate.1|number }} × 9 + {{ sku|KZT|sws.requests.v1|pricingRate.10|number }} × 90 + {{ sku|KZT|sws.requests.v1|pricingRate.100|number }} × 900 + {{ sku|KZT|sws.requests.v1|pricingRate.1000|number }} × 9000 %} | {% calc [currency=KZT] ({{ sku|KZT|sws.requests.v1|pricingRate.0.01|number }} + {{ sku|KZT|sws.requests.v1|pricingRate.1|number }} × 9 + {{ sku|KZT|sws.requests.v1|pricingRate.10|number }} × 90 + {{ sku|KZT|sws.requests.v1|pricingRate.100|number }} × 900 + {{ sku|KZT|sws.requests.v1|pricingRate.1000|number }} × 9000) + ({{ sku|KZT|sws.waf.requests.v1|pricingRate.0.01|number }} + {{ sku|KZT|sws.waf.requests.v1|pricingRate.1|number }} × 9 + {{ sku|KZT|sws.waf.requests.v1|pricingRate.10|number }} × 90 + {{ sku|KZT|sws.waf.requests.v1|pricingRate.100|number }} × 900 + {{ sku|KZT|sws.waf.requests.v1|pricingRate.1000|number }} × 9000) %} |

{% endlist %}



{% endcut %}


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  ##### Профиль безопасности
  
  > Рассчитаем стоимость 315,04 млн легитимных запросов в месяц, обработанных правилами профиля безопасности:
  > 0,01 × {{ sku|RUB|sws.requests.v1|number }} ₽ + 0,99 × {{ sku|RUB|sws.requests.v1|pricingRate.0.01|string }} + 9 × {{ sku|RUB|sws.requests.v1|pricingRate.1|string }} + 90 × {{ sku|RUB|sws.requests.v1|pricingRate.10|string }} + 215,04 × {{ sku|RUB|sws.requests.v1|pricingRate.100|string }} = {% calc [currency=RUB] 0,01 × {{ sku|RUB|sws.requests.v1|number }} + 0,99 × {{ sku|RUB|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|RUB|sws.requests.v1|pricingRate.1|number }} + 90 × {{ sku|RUB|sws.requests.v1|pricingRate.10|number }} + 215,04 × {{ sku|RUB|sws.requests.v1|pricingRate.100|number }} %}, вкл. НДС.
  
  Где:
  
  * 0,01 × {{ sku|RUB|sws.requests.v1|number }} ₽ — нетарифицируемый порог, первые 0,01 млн запросов.
  * 0,99 × {{ sku|RUB|sws.requests.v1|pricingRate.0.01|string }} — стоимость последующих 0,99 млн запросов.
  * 9 × {{ sku|RUB|sws.requests.v1|pricingRate.1|string }} — стоимость последующих 9 млн запросов.
  * 90 × {{ sku|RUB|sws.requests.v1|pricingRate.10|string }} — стоимость последующих 90 млн запросов.
  * 215,04 × {{ sku|RUB|sws.requests.v1|pricingRate.100|string }} — стоимость оставшихся 215,04 млн запросов.
  
  Профиль WAF можно подключить только при использовании профиля безопасности. Стоимость будет складываться из обработки запросов правилами обоих профилей — безопасности и WAF. Так как цены для профиля безопасности и WAF равны, общая стоимость будет в два раза выше, чем при использовании только профиля безопасности.
  
  ##### Профиль безопасности и WAF
  
  > Рассчитаем стоимость 315,04 млн легитимных запросов в месяц, обработанных правилами профиля безопасности и WAF: 
  > {% calc [currency=RUB] 0,01 × {{ sku|RUB|sws.requests.v1|number }} + 0,99 × {{ sku|RUB|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|RUB|sws.requests.v1|pricingRate.1|number }} + 90 × {{ sku|RUB|sws.requests.v1|pricingRate.10|number }} + 215,04 × {{ sku|RUB|sws.requests.v1|pricingRate.100|number }} %} × 2 = {% calc [currency=RUB] (0,01 × {{ sku|RUB|sws.requests.v1|number }} + 0,99 × {{ sku|RUB|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|RUB|sws.requests.v1|pricingRate.1|number }} + 90 × {{ sku|RUB|sws.requests.v1|pricingRate.10|number }} + 215,04 × {{ sku|RUB|sws.requests.v1|pricingRate.100|number }}) × 2 %}, вкл. НДС.
  
  Где:
  
  * {% calc [currency=RUB] 0,01 × {{ sku|RUB|sws.requests.v1|number }} + 0,99 × {{ sku|RUB|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|RUB|sws.requests.v1|pricingRate.1|number }} + 90 × {{ sku|RUB|sws.requests.v1|pricingRate.10|number }} + 215,04 × {{ sku|RUB|sws.requests.v1|pricingRate.100|number }} %} — стоимость 315,04 млн легитимных запросов в месяц, обработанных правилами профиля безопасности.
  * × 2 — стоимость умножается на `2`, поскольку цены для профиля безопасности и WAF равны.
  
  ##### Профиль безопасности и прокси-сервер
  
  > Рассчитаем стоимость 315,04 млн легитимных запросов в месяц при использовании прокси-сервера и правил профиля безопасности:
  > {% calc [currency=RUB] 0,01 × {{ sku|RUB|sws.requests.v1|number }} + 0,99 × {{ sku|RUB|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|RUB|sws.requests.v1|pricingRate.1|number }} + 90 × {{ sku|RUB|sws.requests.v1|pricingRate.10|number }} + 215,04 × {{ sku|RUB|sws.requests.v1|pricingRate.100|number }} %} + 6 × 720 × {{ sku|RUB|sws.proxy-server.v1|string }} + 7 × {{ sku|RUB|sws.antiddos.traffic|string }} = {% calc [currency=RUB] (0,01 × {{ sku|RUB|sws.requests.v1|number }} + 0,99 × {{ sku|RUB|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|RUB|sws.requests.v1|pricingRate.1|number }} + 90 × {{ sku|RUB|sws.requests.v1|pricingRate.10|number }} + 215,04 × {{ sku|RUB|sws.requests.v1|pricingRate.100|number }}) + 6 × 720 × {{ sku|RUB|sws.proxy-server.v1|number }} + 7 × {{ sku|RUB|sws.antiddos.traffic|number }} %}, вкл. НДС.
  
  Где: 
  
  * {% calc [currency=RUB] 0,01 × {{ sku|RUB|sws.requests.v1|number }} + 0,99 × {{ sku|RUB|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|RUB|sws.requests.v1|pricingRate.1|number }} + 90 × {{ sku|RUB|sws.requests.v1|pricingRate.10|number }} + 215,04 × {{ sku|RUB|sws.requests.v1|pricingRate.100|number }} %} — стоимость 315,04 млн легитимных запросов в месяц, обработанных правилами профиля безопасности.
  * 6 — минимальное количество ресурсных единиц прокси-сервера. 
  * 720 — количество часов в 30 днях.
  * {{ sku|RUB|sws.proxy-server.v1|string }} — стоимость 1 ресурсной единицы прокси-сервера за 1 час.
  * 7 — объем входящего трафика (в гигабайтах).
  * {{ sku|RUB|sws.antiddos.traffic|string }} — стоимость защиты 1 ГБ входящего трафика от DDoS-атак.

- Расчет в тенге {#prices-kzt}

  > Рассчитаем стоимость 315,04 млн легитимных запросов в месяц, обработанных правилами профиля безопасности:
  > 0,01 × {{ sku|KZT|sws.requests.v1|number }} ₸ + 0,99 × {{ sku|KZT|sws.requests.v1|pricingRate.0.01|string }} + 9 × {{ sku|KZT|sws.requests.v1|pricingRate.1|string }} + 90 × {{ sku|KZT|sws.requests.v1|pricingRate.10|string }} + 215,04 × {{ sku|KZT|sws.requests.v1|pricingRate.100|string }} = {% calc [currency=KZT] 0,01 × {{ sku|KZT|sws.requests.v1|number }} + 0,99 × {{ sku|KZT|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|KZT|sws.requests.v1|pricingRate.1|number }} + 90 × {{ sku|KZT|sws.requests.v1|pricingRate.10|number }} + 215,04 × {{ sku|KZT|sws.requests.v1|pricingRate.100|number }} %}, вкл. НДС.
  
  Где:
  
  * 0,01 × {{ sku|KZT|sws.requests.v1|number }} ₸ — нетарифицируемый порог, первые 0,01 млн запросов.
  * 0,99 × {{ sku|KZT|sws.requests.v1|pricingRate.0.01|string }} — стоимость последующих 0,99 млн запросов.
  * 9 × {{ sku|KZT|sws.requests.v1|pricingRate.1|string }} — стоимость последующих 9 млн запросов.
  * 90 × {{ sku|KZT|sws.requests.v1|pricingRate.10|string }} — стоимость последующих 90 млн запросов.
  * 215,04 × {{ sku|KZT|sws.requests.v1|pricingRate.100|string }} — стоимость оставшихся 215,04 млн запросов.
  
  Профиль WAF можно подключить только при использовании профиля безопасности. Стоимость будет складываться из обработки запросов правилами обоих профилей — безопасности и WAF. Так как цены для профиля безопасности и WAF равны, общая стоимость будет в два раза выше, чем при использовании только профиля безопасности.
  
  > Рассчитаем стоимость 315,04 млн легитимных запросов в месяц, обработанных правилами профиля безопасности и WAF: 
  > {% calc [currency=KZT] 0,01 × {{ sku|KZT|sws.requests.v1|number }} + 0,99 × {{ sku|KZT|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|KZT|sws.requests.v1|pricingRate.1|number }} + 90 × {{ sku|KZT|sws.requests.v1|pricingRate.10|number }} + 215,04 × {{ sku|KZT|sws.requests.v1|pricingRate.100|number }} %} × 2 = {% calc [currency=KZT] (0,01 × {{ sku|KZT|sws.requests.v1|number }} + 0,99 × {{ sku|KZT|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|KZT|sws.requests.v1|pricingRate.1|number }} + 90 × {{ sku|KZT|sws.requests.v1|pricingRate.10|number }} + 215,04 × {{ sku|KZT|sws.requests.v1|pricingRate.100|number }}) × 2 %}, вкл. НДС.
  
  Где:
  
  * {% calc [currency=KZT] 0,01 × {{ sku|KZT|sws.requests.v1|number }} + 0,99 × {{ sku|KZT|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|KZT|sws.requests.v1|pricingRate.1|number }} + 90 × {{ sku|KZT|sws.requests.v1|pricingRate.10|number }} + 215,04 × {{ sku|KZT|sws.requests.v1|pricingRate.100|number }} %} — стоимость 315,04 млн легитимных запросов в месяц, обработанных правилами профиля безопасности.
  * × 2 — стоимость умножается на `2`, поскольку цены для профиля безопасности и WAF равны.
  
  > Рассчитаем стоимость 315,04 млн легитимных запросов в месяц при использовании прокси-сервера и правил профиля безопасности:
  > {% calc [currency=KZT] 0,01 × {{ sku|KZT|sws.requests.v1|number }} + 0,99 × {{ sku|KZT|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|KZT|sws.requests.v1|pricingRate.1|number }} + 90 × {{ sku|KZT|sws.requests.v1|pricingRate.10|number }} + 215,04 × {{ sku|KZT|sws.requests.v1|pricingRate.100|number }} %} + 6 × 720 × {{ sku|KZT|sws.proxy-server.v1|string }} + 7 × {{ sku|KZT|sws.antiddos.traffic|string }} = {% calc [currency=KZT] (0,01 × {{ sku|KZT|sws.requests.v1|number }} + 0,99 × {{ sku|KZT|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|KZT|sws.requests.v1|pricingRate.1|number }} + 90 × {{ sku|KZT|sws.requests.v1|pricingRate.10|number }} + 215,04 × {{ sku|KZT|sws.requests.v1|pricingRate.100|number }}) + 6 × 720 × {{ sku|KZT|sws.proxy-server.v1|number }} + 7 × {{ sku|KZT|sws.antiddos.traffic|number }} %}, вкл. НДС.
  
  Где: 
  
  * {% calc [currency=KZT] 0,01 × {{ sku|KZT|sws.requests.v1|number }} + 0,99 × {{ sku|KZT|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|KZT|sws.requests.v1|pricingRate.1|number }} + 90 × {{ sku|KZT|sws.requests.v1|pricingRate.10|number }} + 215,04 × {{ sku|KZT|sws.requests.v1|pricingRate.100|number }} %} — стоимость 315,04 млн легитимных запросов в месяц, обработанных правилами профиля безопасности.
  * 6 — минимальное количество ресурсных единиц прокси-сервера. 
  * 720 — количество часов в 30 днях.
  * {{ sku|KZT|sws.proxy-server.v1|string }} — стоимость 1 ресурсной единицы прокси-сервера за 1 час.
  * 7 — объем входящего трафика (в гигабайтах).
  * {{ sku|KZT|sws.antiddos.traffic|string }} — стоимость защиты 1 ГБ входящего трафика от DDoS-атак.

{% endlist %}