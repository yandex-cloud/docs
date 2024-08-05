# Suspending services to customers

{% note warning %}

The maximum post-suspension data storage period is 60 calendar days. During that time, you can be charged for using resources of certain services. Such resources may include snapshots and disks of stopped instances and unused public IP addresses. After this period, all data will be permanently deleted.

{% endnote %}

Before you effect a suspension, check with the customer if they are going to continue using {{ yandex-cloud }} services:

* If the customer chooses to continue using {{ yandex-cloud }} services, make sure all the active clouds are moved to the customer's another account from which they will pay for the services either directly or through another partner.
* If the customer is not going to use {{ yandex-cloud }} services anymore, stop each service manually. Otherwise, you will have to pay for the consumption of these services.

{% list tabs group=instructions %}

- Partner portal {#partner}

  1. Log in to the [partner portal]({{ link-cloud-partners }}) with the Yandex ID to which your partner account in {{ yandex-cloud }} is linked. If you have no access, it means the account you use to log in has no partner status assigned.
  1. In the left-hand panel, select ![icon](../../_assets/console-icons/layout-header-side-content.svg) **Dashboard**.
  1. Select the customer's account from the list and click it.
  1. Go to the **Overview** tab and click **Stop services**.
  1. In the window that opens, click **Stop services**. The subaccount will get the `Suspended` status.

     If you need to resume working with the customer, click **Resume services** and the subaccount will get its `Active` status again.

{% endlist %}
