{% list tabs %}

{% if region == "ru" %}

- Example 1

   <br>The personal account balance at the beginning of the reporting period is 0 rubles.
   <br>The grant amount is 1000 rubles.
   <br>The billing threshold is not enabled.
   <br>At the end of the reporting period, the amount for consumed resources is 800 rubles.
   <br>No funds from the personal account have been used. The grant amount at the end of the reporting period is 0 rubles.
   <br>Neither a report nor invoice will be generated at the beginning of the next reporting period, since the amount actually used from the personal account is 0 rubles.

- Example 2

   <br>The personal account balance at the beginning of the reporting period is 0 rubles.
   <br>The grant amount is 200 rubles.
   <br>The billing threshold is 1000 rubles.
   <br>At the end of the reporting period, the amount for consumed resources is 1000 rubles.
   <br>The grant amount at the end of the reporting period is 0 rubles. The personal account balance is negative 800 rubles.
   <br>At the beginning of the next reporting month, a payment invoice, report and invoice will be generated for the amount that has actually been used (800 rubles).

- Example 3

   <br>The personal account balance at the beginning of the reporting period is 0 rubles.
   <br>During the reporting period, the balance was topped up for 1200 rubles.
   <br>The grant amount is 200 rubles.
   <br>At the end of the reporting period, the amount for consumed resources is 1000 rubles.
   <br>The grant amount at the end of the reporting period is 0 rubles. The personal account balance is positive and amounts to 400 rubles.
   <br>At the beginning of the next reporting month, a report and invoice will be generated for the amount that has actually been used (1000 rubles).

{% endif %}

{% if region == "kz" %}

- Example 1

   <br>The balance of the personal account at the beginning of the reporting period is 0 tenge.
   <br>The grant amount is 1000 tenge.
   <br>The billing threshold is not enabled.
   <br>At the end of the reporting period, the amount for consumed resources is 800 tenge.
   <br>No funds from the personal account have been used. The grant amount at the end of the reporting period is 200 tenge.
   <br>Neither a report nor invoice is generated at the beginning of the next reporting period, since the amount actually used from the personal account is 0 tenge.

- Example 2

   <br>The balance of the personal account at the beginning of the reporting period is 0 tenge.
   <br>The grant amount is 200 tenge.
   <br>The billing threshold is 1000 tenge.
   <br>At the end of the reporting period, the amount for consumed resources is 800 tenge.
   <br>The grant amount at the end of the reporting period is 0 tenge. The personal account balance is negative 800 tenge.
   <br>At the beginning of the next reporting month, an invoice, report, and invoice are generated for the amount actually used (800 tenge).

- Example 3

   <br>The balance of the personal account at the beginning of the reporting period is 0 tenge.
   <br>During the reporting period, the balance was topped up for 1200 tenge.
   <br>The grant amount is 200 tenge.
   <br>At the end of the reporting period, the amount for consumed resources is 800 tenge.
   <br>The grant amount at the end of the reporting period is 0 tenge. The personal account balance is positive 400 tenge.
   <br>At the beginning of the next reporting month, a report and invoice are generated for the amount actually used (1000 tenge).

{% endif %}

{% endlist %}