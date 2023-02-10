The total amount debited depends on whether you used up your [grant](../concepts/bonus-account.md) {% if product == "yandex-cloud" %}and topped up your [personal account](../concepts/personal-account.md#balance) {% endif %}during the reporting period.

{% if product == "yandex-cloud" %}

The amount charged is calculated using the formula:
![image](../../_assets/billing/formula.png)

{% if region == "ru" %}

{% list tabs %}

- Example 1

  <br/>The personal account balance at the beginning of the reporting period is 0 rubles.
  <br/>The personal account was never topped up during the reporting period (0 rubles).
  <br/>The grant amount is 1000 rubles.
  <br/>The billing threshold is 2000 rubles.
  <br/>In the middle of the reporting period, the established billing threshold was reached and the amount for resources consumed was 3000 rubles.
  <br/>Total amount: 3000 - (0 + 0 + 1000) = 2000 (rubles).
  <br/>In the middle of the reporting period, 2000 rubles could be debited from the linked bank card.

- Example 2

  <br/>The personal account balance at the beginning of the reporting period is 0 rubles.
  <br/>The personal account was never topped up during the reporting period (0 rubles).
  <br/>The grant amount is 1000 rubles.
  <br/>At the end of the reporting period, the amount for consumed resources is 800 rubles.
  <br/>The grant amount at the end of the reporting period is 0 rubles. The personal account balance has not changed.
  <br/>At the beginning of the next reporting month, no funds are debited from the linked bank card.

- Example 3

  <br/>The personal account balance at the beginning of the reporting period is 0 rubles.
  <br/>The personal account was never topped up during the reporting period (0 rubles).
  <br/>The grant amount is 1000 rubles.
  <br/>The billing threshold is 2000 rubles.
  <br/>At the end of the reporting period, the amount for consumed resources is 2300 rubles. The billing threshold has not been reached and the grant has been fully spent.
  <br/>Total amount: 2300 - (0 + 0 + 1000) = 1300 (rubles).
  <br/>At the beginning of the next reporting period, 1300 rubles are debited from the linked bank card.
  
{% endlist %}

{% endif %}

{% endif %}