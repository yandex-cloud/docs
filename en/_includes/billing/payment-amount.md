The total amount debited depends on whether you used up your [grant](../concepts/bonus-account.md) and topped up your [personal account](../concepts/personal-account.md#balance) during the reporting period.

The amount charged is calculated using the formula: ![image](../_assets/formula.png)

{% list tabs %}

{% if region == "ru" %}

- Example 1

  <br/>The personal account balance at the beginning of the reporting period is 0 rubles.
  <br/>The personal account was never topped up during the reporting period (0 rubles).
  <br/>The grant amount is 1000 rubles.
  <br/>The credit limit is 2000 rubles.
  <br/>In the middle of the reporting period, the established credit limit was reached and the amount for resources consumed was 3000 rubles.
  <br/>Total amount: 3000 - (0 + 0 + 1000) = 2000 rubles.
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
  <br/>The credit limit is 2000 rubles.
  <br/>At the end of the reporting period, the amount for consumed resources is 2300 rubles. The credit limit has not been reached and the grant has been fully spent.
  <br/>Total amount: 2300 - (0 + 0 + 1000) = 1300 rubles.
  <br/>At the beginning of the next reporting period, 1300 rubles are debited from the linked bank card.

{% endif %}

{% if region == "kz" %}

- Example 1

  <br/>The personal account balance at the beginning of the reporting period is 0 tenge.
  <br/>The personal account was never topped up during the reporting period (0 tenge).
  <br/>The grant amount is 1000 tenge.
  <br/>The credit limit is 2000 tenge.
  <br/>In the middle of the reporting period, the established credit limit was reached and the amount for resources consumed was 3000 tenge.
  <br/>Total amount: 3000 - (0 + 0 + 1000) = 2000 tenge.
  <br/>In the middle of the reporting period, 2000 tenge could be debited from the linked bank card.

- Example 2

  <br/>The personal account balance at the beginning of the reporting period is 0 tenge.
  <br/>The personal account was never topped up during the reporting period (0 tenge).
  <br/>The grant amount is 1000 tenge.
  <br/>At the end of the reporting period, the amount for consumed resources is 800 tenge.
  <br/>The grant amount at the end of the reporting period is 200 tenge. The personal account balance has not changed.
  <br/>At the beginning of the next reporting month, no funds are debited from the linked bank card.

- Example 3

  <br/>The personal account balance at the beginning of the reporting period is 0 tenge.
  <br/>The personal account was never topped up during the reporting period (0 tenge).
  <br/>The grant amount is 1000 tenge.
  <br/>The credit limit is 2000 tenge.
  <br/>At the end of the reporting period, the amount for consumed resources is 2300 tenge. The credit limit has not been reached and the grant has been fully spent.
  <br/>Total amount: 2300 - (0 + 0 + 1000) = 1300 tenge.
  <br/>At the beginning of the next reporting period, 1300 tenge are debited from the linked bank card.

{% endif %}

{% endlist %}

