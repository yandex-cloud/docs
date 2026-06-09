# Правила тарификации для {{ mgl-full-name }}



{% note tip %}


Чтобы рассчитать стоимость использования сервиса, воспользуйтесь [калькулятором](https://yandex.cloud/ru/prices?state=7d620c0eb35d#calculator) на сайте {{ yandex-cloud }} или ознакомьтесь с тарифами в этом разделе.




{% endnote %}

Цены на продукты сервиса также доступны в [Прайс-листе](https://yandex.cloud/ru/price-list).


Все цены в рублях и тенге указаны с НДС, все цены в долларах — без НДС.

## Из чего складывается стоимость использования {{ mgl-name }} {#rules}

При работе с {{ mgl-name }} вы оплачиваете:
* Вычислительные ресурсы инстанса (виртуальной машины).
* Объем хранилища (диск) данных инстанса.

Дополнительно оплачиваются следующие потребляемые ресурсы:
* Место, занятое в сервисе {{ objstorage-full-name }}, для хранения резервных копий.
* Объем исходящего трафика из {{ yandex-cloud }} в интернет.

Во всех расчетах 1 ГБ = 2<sup>10</sup> МБ = 2<sup>20</sup> КБ = 2<sup>30</sup> байт.

### Использование вычислительных ресурсов {#rules-hosts-uptime}

Стоимость начисляется за каждый час работы ВМ.

Цена вычислительных ресурсов зависит от выбранной конфигурации [правил ревью кода](concepts/approval-rules.md).

Минимальная единица тарификации — час (например, стоимость 1,5 часа работы ВМ равна стоимости 2 часов).

### Использование дискового пространства {#rules-storage}

Оплачивается:
* Объем хранилища, выделенный для хранения данных инстанса.
* Объем резервных копий, которые хранятся в {{ objstorage-name }}.

Цена указывается за 1 месяц использования. Минимальная единица тарификации — 1 ГБ в час (например, стоимость хранения 1 ГБ в течение 1,5 часа равна стоимости хранения в течение 2 часов).

### Пример расчета стоимости инстанса {#example}

Стоимость использования инстанса со следующими параметрами в течение 30 дней:

* **Тип инстанса**: `s2.micro` (2 vCPU Intel Cascade Lake, 8 ГБ RAM).
* **Хранилище**: 30 ГБ.
* **Резервные копии**: объем каждой копии — 20 ГБ, срок хранения — 7 дней.
* **Правила ревью кода**: отключены.

Расчет стоимости вычислительных ресурсов:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  > 720 × (2 × {{ sku|RUB|gitlab.instance.free.cpu|string }} + 8 × {{ sku|RUB|gitlab.instance.free.ram|string }}) = {% calc [currency=RUB] 720 × (2 × {{ sku|RUB|gitlab.instance.free.cpu|number }} + 8 × {{ sku|RUB|gitlab.instance.free.ram|number }}) %}
    
    Где:
  
    * 720 — количество часов в 30 днях.
    * 2 — количество vCPU.
    * {{ sku|RUB|gitlab.instance.free.cpu|string }} — стоимость часа использования vCPU.
    * 8 — объем RAM (в гигабайтах).
    * {{ sku|RUB|gitlab.instance.free.ram|string }} — стоимость часа использования 1 ГБ RAM.

- Расчет в тенге {#prices-kzt}

  > 720 × (2 × {{ sku|KZT|gitlab.instance.free.cpu|string }} + 8 × {{ sku|KZT|gitlab.instance.free.ram|string }}) = {% calc [currency=KZT] 720 × (2 × {{ sku|KZT|gitlab.instance.free.cpu|number }} + 8 × {{ sku|KZT|gitlab.instance.free.ram|number }}) %}
  
    Где:
  
    * 720 — количество часов в 30 днях.
    * 2 — количество vCPU.
    * {{ sku|KZT|gitlab.instance.free.cpu|string }} — стоимость часа использования vCPU.
    * 8 — объем RAM (в гигабайтах).
    * {{ sku|KZT|gitlab.instance.free.ram|string }} — стоимость часа использования 1 ГБ RAM.

{% endlist %}



Расчет стоимости хранилища и резервных копий:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  > 30 × {{ sku|RUB|gitlab.instance.disk|month|string }} + 20 × 7 × {{ sku|RUB|gitlab.backup|month|string }} = {% calc [currency=RUB] 30 × {{ sku|RUB|gitlab.instance.disk|month|number }} + 20 × 7 × {{ sku|RUB|gitlab.backup|month|number }} %}
  
    Где:
  
    * 30 — объем хранилища (в гигабайтах).
    * {{ sku|RUB|gitlab.instance.disk|month|string }} — стоимость месяца использования 1 ГБ хранилища.
    * 20 — объем каждой резервной копии.
    * 7 — срок хранения резервных копий.
    * {{ sku|RUB|gitlab.backup|month|string }} — стоимость хранения 1 ГБ резервных копий.

- Расчет в тенге {#prices-kzt}

  > 30 × {{ sku|KZT|gitlab.instance.disk|month|string }} + 20 × 7 × {{ sku|KZT|gitlab.backup|month|string }} = {% calc [currency=KZT] 30 × {{ sku|KZT|gitlab.instance.disk|month|number }} + 20 × 7 × {{ sku|KZT|gitlab.backup|month|number }} %}
  
    Где:
  
    * 30 — объем хранилища (в гигабайтах).
    * {{ sku|KZT|gitlab.instance.disk|month|string }} — стоимость месяца использования 1 ГБ хранилища.
    * 20 — объем каждой резервной копии.
    * 7 — срок хранения резервных копий.
    * {{ sku|KZT|gitlab.backup|month|string }} — стоимость хранения 1 ГБ резервных копий.

{% endlist %}



Расчет итоговой стоимости инстанса:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  > {% calc [currency=RUB] 720 × (2 × {{ sku|RUB|gitlab.instance.free.cpu|number }} + 8 × {{ sku|RUB|gitlab.instance.free.ram|number }}) %} + {% calc [currency=RUB] 30 × {{ sku|RUB|gitlab.instance.disk|month|number }} + 20 × 7 × {{ sku|RUB|gitlab.backup|month|number }} %} = {% calc [currency=RUB] (720 × (2 × {{ sku|RUB|gitlab.instance.free.cpu|number }} + 8 × {{ sku|RUB|gitlab.instance.free.ram|number }})) + (30 × {{ sku|RUB|gitlab.instance.disk|month|number }} + 20 × 7 × {{ sku|RUB|gitlab.backup|month|number }}) %}
  
    Где {% calc [currency=RUB] (720 × (2 × {{ sku|RUB|gitlab.instance.free.cpu|number }} + 8 × {{ sku|RUB|gitlab.instance.free.ram|number }})) + (30 × {{ sku|RUB|gitlab.instance.disk|month|number }} + 20 × 7 × {{ sku|RUB|gitlab.backup|month|number }}) %} — стоимость использования инстанса в течение 30 дней.

- Расчет в тенге {#prices-kzt}

  > {% calc [currency=KZT] 720 × (2 × {{ sku|KZT|gitlab.instance.free.cpu|number }} + 8 × {{ sku|KZT|gitlab.instance.free.ram|number }}) %} + {% calc [currency=KZT] 30 × {{ sku|KZT|gitlab.instance.disk|month|number }} + 20 × 7 × {{ sku|KZT|gitlab.backup|month|number }} %} = {% calc [currency=KZT] (720 × (2 × {{ sku|KZT|gitlab.instance.free.cpu|number }} + 8 × {{ sku|KZT|gitlab.instance.free.ram|number }})) + (30 × {{ sku|KZT|gitlab.instance.disk|month|number }} + 20 × 7 × {{ sku|KZT|gitlab.backup|month|number }}) %}
  
    Где {% calc [currency=KZT] (720 × (2 × {{ sku|KZT|gitlab.instance.free.cpu|number }} + 8 × {{ sku|KZT|gitlab.instance.free.ram|number }})) + (30 × {{ sku|KZT|gitlab.instance.disk|month|number }} + 20 × 7 × {{ sku|KZT|gitlab.backup|month|number }}) %} — стоимость использования инстанса в течение 30 дней.

{% endlist %}



## Цены для региона Россия {#prices}

{% note info %}

Цены на ресурсы {{ yandex-cloud }} в разных регионах различаются. Подробнее о доступных регионах см. [{#T}](../overview/concepts/region.md).

Валюта, которой можно оплачивать ресурсы, зависит от юридического лица, с которым пользователь заключил договор. Подробнее о регистрации аккаунта см. [{#T}](../billing/quickstart/index.md).

{% endnote %}

Цена вычислительных ресурсов зависит от выбранной конфигурации [правил ревью кода](concepts/approval-rules.md).


| Услуга | Цена | Ед. тарификации | Действует с | Действует до |
| ------ | ---- | --------------- | ----------- | ------------ |




### Исходящий трафик {#prices-traffic}

При использовании сервиса оплачивается исходящий трафик из {{ yandex-cloud }} в интернет. Передача трафика между сервисами {{ yandex-cloud }} по внутренним адресам, как и входящий трафик из интернета, не тарифицируется.

Каждый месяц не тарифицируются первые 100 ГБ исходящего трафика.

Минимальная единица тарификации — 1 МБ.


| Услуга | Цена | Ед. тарификации | Действует с | Действует до |
| ------ | ---- | --------------- | ----------- | ------------ |

## Лицензии {#license}

По умолчанию {{ mgl-name }} использует Community Edition версию {{ GL }}. Если у вас есть оплаченная [лицензия](https://about.gitlab.com/pricing/) {{ GL }} (`Premium` или `Ultimate`) — обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру, чтобы воспользоваться ею в {{ mgl-name }}.