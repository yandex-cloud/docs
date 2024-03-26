# VAR program tools

The VAR program participants have access to the following tools:

* [Order registration](#deal-reg)
* [Project registration](#reg)
* [Presale assistance](#presale)

## Order registration {#deal-reg}

Order registration is a partner protection tool to reward a partner for bringing an order to {{ yandex-cloud }}. An order should be registered with a customer who has never worked with {{ yandex-cloud }} before. For registering an order, you will get up to 15% in addition to your [partner bonus](./var.md#premium) for as long as the customer remains linked to you.

Order registration conditions:

* Target consumption for an order starts from 30,000 rubles per month.
* You are registering an order with a new {{ yandex-cloud }} customer.

   {% note info %}

   To learn more about the current conditions, see the [offer](https://yandex.ru/legal/cloud_partnership_deal_registration/).

   {% endnote %}

To register an order:

1. Log in to the [partner portal]({{ link-cloud-partners }}).
1. In the left-hand panel, select ![icon](../../_assets/console-icons/wrench.svg) **Partner tools**.
1. Click the **Partner's order/project application form** link.
1. Fill out the form. Under **Application data**, in the **Request type** field, select `New customer`.
1. Click **Submit** and wait for the application to be approved: this may take up to 20 business days.

   {% note info %}

   After your application is approved, you will have 60 days to create a [subaccount](../terms.md#subaccount) and a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) for your customer.

   {% endnote %}

1. Create a customer record on the partner portal:

   1. Log in to the [partner portal]({{ link-cloud-partners }}).
   1. In the top-right corner, click **Add customer**.
   1. Complete the **New customers** form with your customer's information.
   1. Click **Add**. A new customer record with the `Verification required` status will appear in the list of customers on the partner portal.

      After the [partnership is verified](../operations/pin-client.md#apply), a subaccount will be created for the customer. The target consumption amount is calculated from the date of subaccount creation.

1. Create a new cloud for your customer:

   1. In the left-hand panel, select ![icon](../../_assets/console-icons/layout-header-side-content.svg) **Dashboard**.
   1. Select the customer's account from the list and click it.
   1. In the window that opens, click ![image](../../_assets/plus-sign.svg) **Create cloud**. You will be redirected to the customer's billing account page in {{ billing-name }}.
   1. Under **{{ ui-key.yacloud.billing.account.dashboard-resources.section_resources }}**, click **{{ ui-key.yacloud.common.create }}**.
   1. Enter a name for the cloud.
   1. In the **{{ ui-key.yacloud.iam.cloud.create.popup-create-cloud_label_organization }}** field, select the [organization](../../organization/quickstart.md) named `For subaccount 'Customer_name'`.
   1. Click **{{ ui-key.yacloud.iam.cloud.create.popup-create-cloud_button_add }}**.

      You can also [link](../operations/pin-client.md#bing) an existing cloud to the customer's subaccount.

## Project registration {#project-reg}

Project registration is used to link a new project in the existing {{ yandex-cloud }} customer's account to you, through which the customer increases their consumption of services. In this case, you are working in the account of a direct customer who has signed an agreement directly with {{ yandex-cloud }}. For registering a project, you will get up to 15% of the customer's consumption growth in the registered cloud or folder in the form of a [rebate](../terms.md#rebate) credited within 12 months.

Project registration conditions:

* Target consumption for a project starts from 30,000 rubles per month. You can link projects with any target consumption, but rebates are only paid for projects with a minimum monthly consumption of 30,000 rubles.
* You are registering a project in the existing {{ yandex-cloud }} customer account.
* Customer's cloud or folder shows zero consumption at the time of application submission.

   {% note info %}

   To learn more about the current conditions, see the [offer](https://yandex.ru/legal/cloud_partnership_project_protect/).

   {% endnote %}

To register a project:

1. Log in to the [partner portal]({{ link-cloud-partners }}).
1. In the left-hand panel, select ![icon](../../_assets/console-icons/wrench.svg) **Partner tools**.
1. Click the **Partner's order/project application form** link.
1. Fill out the form. Under **Application data**, in the **Request type** field, select `Customer project`.
1. Click **Submit** and wait for the application to be approved: this may take up to 20 business days.

## Presale request {#presale}

You can involve {{ yandex-cloud }} experts to work with your customer by submitting a presale request. You customer can be either a new {{ yandex-cloud }} customer or an existing one.

To submit a presale request:

1. Log in to the [partner portal]({{ link-cloud-partners }}).
1. In the left-hand panel, select ![icon](../../_assets/console-icons/wrench.svg) **Partner tools**.
1. Click the **Presale request form** link.
1. Fill out the form and click **Submit**. A customer manager will contact you within 3 business days.
