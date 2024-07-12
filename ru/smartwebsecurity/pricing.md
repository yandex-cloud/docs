---
editable: false
---

# Правила тарификации для {{ sws-full-name }}



Чтобы рассчитать стоимость использования сервиса {{ sws-name }}, ознакомьтесь с тарифами в этом разделе.

## Из чего складывается стоимость использования {{ sws-name }} {#rules}

Стоимость {{ sws-name }} зависит от следующих параметров:
* количество запросов к защищаемому ресурсу;
* количество [профилей безопасности](./concepts/profiles.md);
* суммарное количество [правил безопасности](./concepts/rules.md) во всех профилях.

## Цены для региона Россия {#prices}


{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


### Запросы {#requests}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-requests](../_pricing/smartwebsecurity/rub-requests.md) %}
  
  {% include [sum-cloud-account](../_includes/smartwebsecurity/sum-cloud-account.md) %}
  
  {% include [rub-smartwebsecurity](../_pricing_examples/smartwebsecurity/rub-smartwebsecurity.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-requests](../_pricing/smartwebsecurity/kzt-requests.md) %}
  
  {% include [sum-cloud-account](../_includes/smartwebsecurity/sum-cloud-account.md) %}
  
  {% include [kzt-smartwebsecurity](../_pricing_examples/smartwebsecurity/kzt-smartwebsecurity.md) %}

{% endlist %}



### Профили и правила безопасности {#profiles-and-rules}

Минимальные единицы тарификации — 1 профиль безопасности в месяц, 1 правило безопасности в месяц.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-profiles-and-rules](../_pricing/smartwebsecurity/rub-profiles-and-rules.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-profiles-and-rules](../_pricing/smartwebsecurity/kzt-profiles-and-rules.md) %}

{% endlist %}


