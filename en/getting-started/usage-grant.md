# Initial grant for individual and business accounts

{% include [grant-amount](_includes/grant-amount.md) %}

{% if product == "yandex-cloud" %}

The initial grant terms of use differ for individual and business accounts.

{% endif %}

{% if product == "yandex-cloud" %}

## Individual account {#personal}

{% if region == "ru" %}

The grant is provisionally divided into two parts and distributed among services as follows:

* _The first part_: ₽1000 from the total grant amount. It can be used to pay for [{{ compute-full-name }}](/services/compute) services, [{{ marketplace-full-name }}](/marketplace) tools, and [support](../support) services.
* _The second part_: ₽3000 from the total grant amount. It can be used to pay for [other services in](../overview/concepts/services.md) {{ yandex-cloud }}.

{% endif %}

{% if region == "kz" %}

The grant is provisionally divided into two parts and distributed among services as follows:

* _The first part_: ₸6000 from the total grant amount. It can be used to pay for [{{ compute-full-name }}](/services/compute) services, [{{ marketplace-full-name }}](/marketplace) tools, and [support](../support) services.
* _The second part_: ₸18000 from the total grant amount. It can be used to pay for [other services in](../overview/concepts/services.md) {{ yandex-cloud }}.

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

The grant is provisionally divided into two parts and distributed among services as follows:

* _The first part_: ₪100 from the total grant amount. It can be used to pay for services [{{ compute-full-name }}](/services/compute) and [{{ marketplace-full-name }}](/marketplace) tools.
* _The second part_: ₪250 from the total grant amount. It can be used to pay for [other services in](../overview/concepts/services.md) {{ yandex-cloud }}.


{% endif %}

Both parts can be used simultaneously.

{% if product == "yandex-cloud" %}

## Business account {#business}

Grant terms of use depend on:
* Your country of residence.
* The payment method you select when registering and [creating your billing account](../billing/quickstart/index.md).

### Grant terms of use {#terms-august}

{% list tabs %}

- For residents of Russia

   Payment method | Using the grant
   --- | ---
   Bank card | The grant is provisionally divided into two parts and distributed among services as follows:<br>_Part 1_: ₽1000 from the total grant amount. It can be used to pay for {{ compute-full-name }} services, {{ marketplace-full-name }} tools, and support services.<br>_Part 2_: ₽3000 from the total grant amount. It can be used to pay for other {{ yandex-cloud }} services. 
   Bank transfer | The total grant in the amount of ₽4000 can be used to pay for any {{ yandex-cloud }} services. 

- For residents of Kazakhstan

   Payment method | Using the grant
   --- | ---
   Bank card | The grant is provisionally divided into two parts and distributed among services as follows:<br>_Part 1_: ₸6000 from the total grant amount. It can be used to pay for {{ compute-full-name }} services, {{ marketplace-full-name }} tools, and support services.<br>_Part 2_: ₸18000 from the total grant amount. It can be used to pay for other {{ yandex-cloud }} services. 
   Bank transfer | The total grant in the amount of ₸24,000 can be used to pay for any {{ yandex-cloud }} services.

- For non-residents of Russia and Kazakhstan

   Payment method | Using the grant
   --- | ---
   Bank card | The grant is provisionally divided into two parts and distributed among services as follows:<br>_Part 1_: $15 of the total grant amount. It can be used to pay for {{ compute-full-name }} services, {{ marketplace-full-name }} tools, and support services.<br>_Part 2_: $35 from the total grant amount. It can be used to pay for other {{ yandex-cloud }} services.
   Bank transfer | The total grant in the amount of $50 can be used to pay for any {{ yandex-cloud }} services.

{% endlist %}

{% endif %}

For more information about [billing accounts](../billing/concepts/billing-account.md) {% if product == "yandex-cloud" %}and the [terms and conditions for non-residents of the Russian Federation](../billing/qa/non-resident.md), {% endif %}see the Billing documentation.

{% if product == "yandex-cloud" %}

### Grant for managed databases {#mdb}

{% include [mdb-grant-amount](_includes/mdb-grant-amount.md) %}

{% endif %}
