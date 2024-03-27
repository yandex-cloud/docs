# Viewing details of service usage by customers

You can view details of how customers use services:

* In the management console
* On the partner portal

{% list tabs group=instructions %}

- Management console {#console}

   To view charts and tables with information about {{ yandex-cloud }} service usage:

   1. In the [management console]({{ link-console-main }}), click ![image](../../_assets/console-icons/dots-9.svg) **All services**.
   1. Select ![image](../../_assets/console-icons/credit-card.svg) [**{{ billing-name }}**]({{ link-console-billing }}).
   1. Click the appropriate account name and select ![image](../../_assets/console-icons/layout-cells-large.svg) **Usage details**.

   For more information about the settings of the **Usage details** page, see the [{{ billing-name }} documentation](../../billing/operations/check-charges.md).

- Partner portal {#partner}

   Log in to the [partner portal]({{ link-cloud-partners }}) with the Yandex ID to which your partner account in {{ yandex-cloud }} is linked. There are several ways to check details of service usage by customers:

   * **Dashboard** section

      1. In the left-hand panel, select ![icon](../../_assets/console-icons/layout-header-side-content.svg) **Dashboard**.
      1. Select the appropriate customer account from the list and click it.
      1. Go to the **Service usage** tab.

   * **Rewards** section

      1. In the left-hand panel, select ![icon](../../_assets/console-icons/medal.svg) **Rewards**.
      1. Specify the statistics period. The chart will display the total consumption by month for all customers.

         {% note info %}

         The maximum statistics period is 92 days.

         {% endnote %}

         You can download a `.csv` file with detailed statistics by customer. To do this, click **Download CSV**.

{% endlist %}
