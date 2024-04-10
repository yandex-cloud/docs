---
editable: false
---

# Правила тарификации для {{ sf-name }}




## Из чего складывается стоимость использования {{ sf-name }} {#rules}

В рамках сервиса {{ sf-name }} тарифицируется количество вызовов функции, вычислительные ресурсы, выделенные для выполнения функции, время простоя [подготовленных экземпляров](concepts/function.md#provisioned-instances) и исходящий трафик.

При тарификации вычислительных ресурсов (ГБ×час) учитывается объем памяти, выделенный для функции, и время выполнения функции:
* Объем памяти, указанный при [создании версии](operations/function/version-manage.md), измеряется в ГБ.
* Время выполнения для каждого вызова функции, измеряется в часах, и округляется в большую сторону до ближайшего значения, кратного 100 мс.

{% note warning %}

Тарифицируются только [вызовы функции](concepts/function-invoke.md), которые привели к запуску вашего кода.

{% endnote %}


### Формула расчета стоимости {#price-formula}

Стоимость в месяц = 5,47 ₽ × Объем памяти (Гб) × Время обработки вызовов (Часы) + 16 ₽ × Количество миллионов вызовов

{% include [not-charged-functions.md](../_includes/pricing/price-formula/not-charged-functions.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}




### Пример расчета стоимости {#price-example}

{% include [prices-example](../_includes/functions/prices-example.md) %}

## Использование триггеров {#triggers}

Использование [триггеров](concepts/trigger/index.md) не тарифицируется. Вы можете создавать и использовать триггеры в рамках доступных [квот и лимитов](concepts/limits.md).



## Навыки Алисы

Функции {{ sf-name }}, которые используются для навыков Алисы, не тарифицируются и не расходуют [нетарифицируемый объем услуг](../billing/concepts/serverless-free-tier.md#sf), если:
* функцию вызывает [платформа Яндекс Диалоги](https://yandex.ru/dev/dialogs/);
* навык Алисы создан по [инструкции](https://yandex.ru/dev/dialogs/alice/doc/deploy-ycloud-function.html#deploy-ycloud-function__register).

При этом если функция использует другие ресурсы {{ yandex-cloud }}, они тарифицируются. Например, если функция делает запросы к очереди {{ message-queue-name }}, за них взимается плата в соответствии с [тарифами](../message-queue/pricing.md#requests-to-queues).



## Цены {#prices}


### Вызов функции {#invoke}


{% include [rub.md](../_pricing/functions/rub-invocations.md) %}

Оплачивается фактическое количество вызовов. Например, 1000 вызовов сверх нетарифицируемого объема стоит 0,016 ₽, если 1 миллион запросов стоит 16 ₽.




### Время выполнения функции {#execution}


{% include [rub.md](../_pricing/functions/rub-compute.md) %}






### Подготовленные экземпляры {#provisioned-instances}


{% include [rub.md](../_pricing/functions/rub-compute-provisioned-instances.md) %}






### Исходящий трафик {#prices-traffic}


{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}



