---
title: Правила тарификации для {{ vpc-full-name }}
description: В статье содержатся правила тарификации сервиса {{ vpc-name }}.
editable: false
---

# Правила тарификации для {{ vpc-name }}

{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}


{% include [vat](../_includes/vat.md) %}

## Из чего складывается стоимость использования {{ vpc-short-name }} {#rules}

В рамках {{ vpc-short-name }} оплачивается почасовое использование публичных IP-адресов.

{% include [not-charged-vpc.md](../_includes/pricing/price-formula/not-charged-vpc.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

После удаления или остановки ресурсов, публичные зарезервированные IP-адреса продолжат тарифицироваться. Если IP-адреса не нужны, удалите их.


## Цены для региона Россия {#prices}




{% include [prices-nds-note](../_includes/prices-nds-note.md) %}


{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### {{ vpc-short-name }} {#vpc-prices}

#### Публичные IP-адреса {#prices-public-ip}

Публичный IP-адрес может находиться в двух состояниях:

1. **Активном** — когда _динамический_ или _статический_ публичный IP-адрес привязан к запущенному облачному ресурсу.
1. **Неактивном** — когда _статический_ публичный IP-адрес не привязан к облачному ресурсу или привязан к остановленному ресурсу.

Стоимость неактивного публичного статического адреса складывается из стоимости публичного IP-адреса и стоимости резервирования неактивного публичного статического IP-адреса.

{% include [prices-difference](../_includes/prices-difference.md) %}

Например, стоимость неактивного публичного статического адреса составит:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [examples-rub-hour](../_pricing_examples/vpc/rub-hour.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [examples-kzt-hour](../_pricing_examples/vpc/kzt-hour.md) %}

{% endlist %}




#### NAT-шлюзы {#nat-gateways}

При использовании NAT-шлюзов тарифицируются почасовое использование шлюза и исходящий через шлюз трафик. Тарификация начинается с добавления шлюза в таблицу маршрутизации.

#### {{ ddos-protection-full-name }} {#prices-ddos-protection}

Полезный трафик — это входящий трафик, который система фильтрации DDoS Protection допускает к облачным ресурсам пользователя. Тарифицируется только полезный трафик.

Например, на [виртуальную машину](../glossary/vm.md) пользователя была проведена типовая DDoS-атака в 10 Гбит/с, которая сгенерировала 75 ГБ входящего трафика. Во время атаки пользователь загрузил из интернета на виртуальную машину 2 ГБ полезных файлов. Когда атака закончилась, пользователь загрузил еще 2 ГБ полезных файлов. 

В этом случае тарифицируются только 4 ГБ полезного трафика: 2 ГБ, который система DDoS Protection допустила к облачным ресурсам во время атаки, и 2 ГБ, которые были загружены, когда атака не велась. Вредоносный трафик отфильтровывается и не тарифицируется.


<MDX>
  <PriceList
    serviceIds={['{{ pcs|cloud_network }}']}
    excludeSkuIds={['{{ pc|storage.api.network.inet.egress }}', '{{ pc|network.egress.nat }}', '{{ pc|network.public_fips.lb.deallocated }}', '{{ pc|network.public_fips.lb-key-value }}', '{{ pc|network.egress.inet }}']}
    installationCode="ru"
    currency="RUB"
  />
</MDX>





#### Использование групп безопасности {#prices-security-groups}

Использование функциональности [групп безопасности](concepts/security-groups.md) не тарифицируется.

#### Исходящий трафик {#prices-traffic}

{% include notitle [note-public-ip-traffic.md](../_includes/pricing/note-public-ip-traffic.md) %}

{% include notitle [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}




### {{ adv-ddos-protection }} {#prices-ddos-advanced}

Услуга {{ adv-ddos-protection }} подключается по запросу через [форму](https://forms.yandex.ru/surveys/13203262.d03e905cf02195bec1093aa2b032802fe13caac0/).

{% note warning "Важно" %}

Обратите внимание, что абонентская плата за услуги {{ adv-ddos-protection }} и Managed Web Application Firewall списывается сразу за весь месяц и не рассчитывается пропорционально дням. Например, если вы подключили или отключили услуги в середине месяца, абонентская плата все равно спишется полностью.

Оплата услуг сверх абонентской платы происходит в следующем отчетном месяце. Например, услуги, потребленные в июле, учитываются в потреблении августа.

{% endnote %}

Полоса превалирующего трафика за расчетный период рассчитывается как среднее за 1 минуту значение наибольшего трафика между очищенным сетью фильтрации входящим и исходящим трафиком сайта. По итогам расчетного периода 90 учтенных максимальных значений трафика отбрасывается, а максимальное оставшееся значение округляется в меньшую сторону до целого числа Мбит/c. Полученное число является полосой превалирующего трафика для целей расчета платы за трафик.

Расчет превышения производится путем умножения 1 Мбит/с трафика на полосу превалирующего трафика.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-advanced-ddos](../_pricing/vpc/rub-advanced-ddos.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-advanced-ddos](../_pricing/vpc/kzt-advanced-ddos.md) %}

{% endlist %}



{% cut "**Характеристики тарифов:**" %}

| Наименование тарифного плана | Professional<br/>(Pro) | Business<br/>(Bsns) | Corporate<br/>(Corp) | Enterprise<br/>(ENT) |
| --- | --- | --- | --- | --- |
| Включенные объемы фильтрации вредоносного (нежелательного) трафика, до | 10&nbsp;Гбит/с | 50&nbsp;Гбит/с | 500&nbsp;Гбит/с | не ограничена |
| Гарантированная доступность информационных ресурсов/сайтов в месяц (SLA) | не менее 97% | не менее 99% | не менее 99,5% | более 99,5% |
| Тарифицируемый трафик | легитимный | легитимный | легитимный | легитимный |
| Фильтрация HTTPS-трафика с использованием приватных ключей клиента | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Предоставление сертификатов Let's Encrypt® | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Активная проверка доступности площадок клиента | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Фильтрация HTTPS без использования приватных ключей | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Доступ к API | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |

{% endcut %}

К тарифу {{ adv-ddos-protection }} можно дополнительно подключить следующие услуги:


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-advanced-ddos-services](../_pricing/vpc/rub-advanced-ddos-services.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-advanced-ddos-services](../_pricing/vpc/kzt-advanced-ddos-services.md) %}

{% endlist %}



### Managed Web Application Firewall {#prices-waf}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-waf](../_pricing/vpc/rub-waf.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-waf](../_pricing/vpc/kzt-waf.md) %}

{% endlist %}



В тариф Managed Web Application Firewall включены следующие услуги:

{% include [waf-services](../_pricing/vpc/waf-services.md) %}

