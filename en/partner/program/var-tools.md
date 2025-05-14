---
title: VAR program tools
description: In this article, you will learn about the VAR program tools.
---

# VAR program tools


The VAR program participants have access to the following tools:

* [Deal registration](#deal-reg)
* [Deal registration as part of a scheduled procurement](#tender)
* [Project registration](#project-reg)
* [Presale assistance](#presale)
* [Quickstart program](#acceleration)
* [Co-marketing program](#co-marketing)
* [Partner catalog](#catalog)
* [Professional services](#pro)
* [{{ marketplace-full-name }}](#marketplace)
* [Telegram channel for partners](#tg-channel)
* [Partner Kit](#kit)

## Deal registration {#deal-reg}

Deal registration is a partner protection tool that rewards the partner for generating a deal for {{ yandex-cloud }}. You register a deal with a customer who has never worked with {{ yandex-cloud }} before. For registering a deal, you will get up to 15% on top of your [partner bonus](./var.md#premium) for as long as the customer remains linked to you.


### Deal registration conditions for the Russia region {#deal-reg-conditions}



{% include [pricing-diff-regions](../../_includes/pricing-diff-regions.md) %}


{% list tabs group=pricing %}

- Cost in RUB {#prices-rub}

  * Deal target consumption starts from 30,000 RUB per month.
  * Deal is registered with a new {{ yandex-cloud }} customer.

  {% note info %}
  
  For up-to-date conditions, see the [offer](https://yandex.ru/legal/cloud_partnership_deal_registration/).
  
  {% endnote %}

- Cost in KZT {#prices-kzt}

  * Deal target consumption starts from 150,000 KZT per month.
  * Deal is registered with a new {{ yandex-cloud }} customer.

  {% note info %}
  
  For up-to-date conditions, see the [offer](https://yandex.com/legal/deal_reg_kz/).
  
  {% endnote %}

{% endlist %}



To register a deal:

1. Log in to the [partner portal]({{ link-cloud-partners }}).
1. In the left-hand panel, select ![image](../../_assets/console-icons/folder-tree.svg) **Partner tools**.
1. Click the **Partner deal/project application form** link.
1. Fill out the form. Under **Application data**, in the **Request type** field, select `New customer`.
1. Click **Submit** and wait for the application to be approved: this may take up to 20 business days.

   {% note info %}

   After your application is approved, you will have 60 days to create a [subaccount](../terms.md#sub-account) and a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) for your customer.

   {% endnote %}

1. Create a customer record on the partner portal:

   1. Log in to the [partner portal]({{ link-cloud-partners }}).
   1. In the top-right corner, click **Add customer**.
   1. Complete the **New customers** form with your customer's information.
   1. Click **Add**. A new customer record with the `Verification required` status will appear in the list of customers on the partner portal.

      After the [partnership is verified](./var-pin-client.md#confirm-partnership), a subaccount will be created for the customer. The target consumption amount is calculated from the date of subaccount creation.

1. Create a new cloud for your customer:

   1. In the left-hand panel, select ![icon](../../_assets/console-icons/layout-header-side-content.svg) **Dashboard**.
   1. Select the customer's account from the list and click it.
   1. In the window that opens, click ![image](../../_assets/plus-sign.svg) **Create cloud**. You will be redirected to the customer's billing account page in {{ billing-name }}.
   1. Under **{{ ui-key.yacloud_billing.billing.account.dashboard-resources.title_clouds }}**, click **{{ ui-key.yacloud.common.create }}**.
   1. Enter a name for the cloud.
   1. In the **{{ ui-key.yacloud_billing.iam.cloud.create.popup-create-cloud_label_organization }}** field, select the [organization](../../organization/quickstart.md) named `For subaccount 'Customer_name'`.
   1. Click **{{ ui-key.yacloud_billing.iam.cloud.create.popup-create-cloud_button_add }}**.

      You can also [link](../operations/pin-cloud.md) an existing cloud to the customer's subaccount.

## Deal registration as part of a scheduled procurement {#tender}

You can also register a deal if you have entered into a contract or agreement with your customer as part of a scheduled procurement under Federal Law 44-FZ or 223-FZ. For registering such a deal you will get up to 15% on top of your [partner bonus](./var.md#premium) for the duration of your contract or agreement.


### Deal registration conditions for the Russia region {#tender-conditions}



{% include [pricing-diff-regions](../../_includes/pricing-diff-regions.md) %}


{% list tabs group=pricing %}

- Cost in RUB {#prices-rub}

  * Deal target consumption starts from 30,000 RUB per month.
  * The customer has not been brought in through a [referral program](../program/referral.md).
  * You already participated in a {{ yandex-cloud }} partner program at the time you won the scheduled procurement.

  {% note info %}
  
  For up-to-date conditions, see the [offer](https://yandex.ru/legal/cloud_partnership_procurement/).
  
  {% endnote %}

- Cost in KZT {#prices-kzt}

  * Deal target consumption starts from 150,000 KZT per month.
  * The customer has not been brought in through a [referral program](../program/referral.md).
  * You already participated in a {{ yandex-cloud }} partner program at the time you won the scheduled procurement.

  {% note info %}
  
  For up-to-date conditions, see the [offer](https://yandex.com/legal/cloud_partnership_procurement_kz/).
  
  {% endnote %}

{% endlist %}



You can register a deal taking place as part of a scheduled procurement just like a [regular deal](#deal-reg). When filling out your application, put in the **Deal is part of a procurement under 44-FZ/223-FZ** field under **Application data** `Yes`.

## Project registration {#project-reg}

Project registration is used to link a new project in the existing {{ yandex-cloud }} customer's account to you, through which the customer increases their consumption of services. In this case, you are working in the account of a direct customer who has signed an agreement directly with {{ yandex-cloud }}. For registering a project, you will get up to 15% of the customer's consumption growth in the registered cloud or folder in the form of a [rebate](../terms.md#rebate) credited within 12 months.

Project registration conditions:

* Target consumption for a project starts from 30,000 rubles per month. You can link projects with any target consumption, but rebates are only paid for projects with a minimum monthly consumption of 30,000 rubles.
* You are registering a project in the existing {{ yandex-cloud }} customer account.
* Customer's cloud or folder shows zero consumption at the time of application submission.


  {% note info %}
  
  For up-to-date conditions, see the [offer](https://yandex.ru/legal/cloud_partnership_project_protect/).
  
  {% endnote %}

To register a project:

1. Log in to the [partner portal]({{ link-cloud-partners }}).
1. In the left-hand panel, select ![image](../../_assets/console-icons/folder-tree.svg) **Partner tools**.
1. Click the **Partner deal/project application form** link.
1. Fill out the form. Under **Application data**, in the **Request type** field, select `Customer project`.
1. Click **Submit** and wait for the application to be approved: this may take up to 20 business days.

## Presale request {#presale}

You can involve {{ yandex-cloud }} experts to work with your customer by submitting a presale request. You customer can be either a new {{ yandex-cloud }} customer or an existing one.

To submit a presale request:

1. Log in to the [partner portal]({{ link-cloud-partners }}).
1. In the left-hand panel, select ![image](../../_assets/console-icons/folder-tree.svg) **Partner tools**.
1. Click the **Presale request form** link.
1. Complete the form and click **Submit**. A customer manager will contact you within 3 business days.

## Quickstart program {#acceleration}

Our step-by-step acceleration program helps partners achieve their first sales with {{ yandex-cloud }}. Your participation in the program will considerably advance your knowledge of {{ yandex-cloud }} services, generate new deals, and contribute to successful implementation of your projects based on {{ yandex-cloud }} services, plus get you a [technology specialization](../specializations/index.md).

The program is split between the two key areas: sales and technology. In each one, you will have a dedicated manager assigned. The manager will guide you through every step of the program and provide support with:

* Training your employees on effective sales techniques.
* Getting [grants](../../billing/concepts/bonus-account.md).
* Support throughout all stages of sales, assistance with case study analysis.
* Engaging an architect for technical support of complex projects.
* Nomination for participation in the [co-marketing program](#co-marketing).

Requirements for program participants:

* You have an employee responsible for partner relationships.
* You have a ready list of 10-20 loyal customers ready to start using {{ yandex-cloud }}.
* To participate in the technology area: an employee who has completed the [Cloud Service Engineer](https://practicum.yandex.ru/ycloud/) course.
* To participate in the sales area: a dedicated sales manager.


## Co-marketing program {#co-marketing}

The co-marketing program is designed to strengthen the relationship between {{ yandex-cloud }} and its partners. It enables companies to expand their market presence and improve their sales figures through a joint marketing effort.

The program's main goals and benefits:

* Increased recognition through association with Russia's largest technology brand.
* Optimizing marketing expenditure through joint funding of marketing activities, including:
  
  * Events: conferences, business dinners, breakfast meetings.
  * Webinars.
  * Success stories.
  * Guided tours to Yandex data center for partner's customers.

* Increased sales and expanded customer base.

Requirements for program participants:

* You have a partner agreement signed.
* You have obtained one of the [technology specializations](../specializations/index.md).
* You have covered 50% of marketing costs related to acquiring new customers, generating new projects with current ones, as well as bringing in brand new customers for {{ yandex-cloud }}.
* You guarantee in-depth study and analysis of the results of the marketing activities.
* You comply with all the established {{ yandex-cloud }} policies and requirements.


## Partner catalog {#catalog}

[Partner catalog]({{ link-cloud-partners-landing }}catalogue) is a showcase of {{ yandex-cloud }}-based partner solutions and services built around customer needs. The catalog features companies {{ yandex-cloud }} recommends for implementing turnkey projects of various complexity levels. Each one of them has a track of record of completed projects based on cloud technologies, as well as a team of certified experts.

Benefits of being listed in the catalog:

* Acquisition of new customers: You can make a statement as a reliable {{ yandex-cloud }} partner with an added benefit of gaining the attention of potential customers.
* Acknowledgment of competence: Being listed in the catalog is a seal of excellence for your potential customers, and a confirmation of your expertise with {{ yandex-cloud }} solutions.

To be eligible for the partner catalog, your company must satisfy the following criteria:

* You have a partner agreement signed.
* There is at least one technical specialist who has completed the [**Cloud services engineer**](https://practicum.yandex.ru/ycloud/) course.
* There are at least two completed projects and/or subaccounts in {{ yandex-cloud }}.

If you meet all the requirements and want your company in the partner catalog, contact your partner manager or write to [yc-partners@yandex-team.ru](mailto:yc-partners@yandex-team.ru).

## Professional services {#pro}

You can bring in a team of experienced {{ yandex-cloud }} architects and engineers for joint implementation of complex and ambitious projects based on the platform. You will thus unlock the team's advanced knowledge and expertise, which will help you avoid common mistakes and find the most effective solutions for your every need.

We offer two main lines of support: active and proactive assistance.

Active assistance is aimed at resolving already existing issues and challenges:

* **Validation of project solutions**: We will measure your solution against best practices and the objectives you have set for yourself.
* **Answers to specific questions**: If you cannot find the answer to your question in the {{ yandex-cloud }} [documentation](../../index.yaml), our team is ready to help.
* **Assistance with solution issues**: If you get issues after validating your solution, we will help resolve them.
* **Handling objections**: We will help you respond to objections you may get from your customers or within your team.
* **{{ yandex-cloud }} side errors**: We will help resolve issues directly related to the platform's operation.

Proactive assistance is aimed at preventing potential issues and optimizing your project:

* **Creating custom solutions**: We will assist you in developing and implementing unique solutions to effectively address your objectives.
* **Defining technical development**: We assist in planning further development of your projects in terms of technologies and tools.
* **Business development tools**: We advise on the {{ yandex-cloud }} tools that can be used to expand your business.
* **Technology learning tracks**: We organize educational events for partners on key {{ yandex-cloud }} technologies and products.

## {{ marketplace-full-name }} {#marketplace}

[{{ marketplace-full-name }}]({{ link-cloud-marketplace }}) is an online store offering a wide range of out-of-the-box tools for development and analysis of {{ yandex-cloud }} partners' data. On {{ marketplace-full-name }}, you can easily purchase the tools you need with just one click, greatly accelerating the process of implementing and integrating new technologies into your projects.

{{ marketplace-short-name }} benefits:

* Preparation and implementation of custom images

  {{ marketplace-short-name }} enables partners and vendors to prepare and implement their own images of tools and solutions. Thus you can offer unique products to large numbers of {{ yandex-cloud }} customers.

* Supporting your customers in {{ yandex-cloud }}
  
  Thanks to integration with {{ yandex-cloud }}, {{ marketplace-short-name }} effectively supports your products for all the platform customers. This includes access to an extensive {{ yandex-cloud }} database and resources, which streamlines supporting and updating your products.

* Listing in the partner catalog
  
  The development of your own products will make you eligible for the {{ yandex-cloud }} [partner catalog](#catalog), which will help you attract potential customers and boost successful sales.

{{ marketplace-short-name }} supports various products, including:

* Out-of-the-box images for [{{ compute-full-name }}](../../compute/index.yaml): Images for virtual machines that provide a deployment-ready environment for applications and services.
* Applications for [{{ managed-k8s-full-name }}](../../managed-kubernetes/index.yaml): Specialized solutions optimized to operate in managed {{ k8s }} clusters.
* [{{ cloud-apps-full-name }}](../../cloud-apps/index.yaml): Multi-component applications based on {{ yandex-cloud }} services.

## Telegram channel for partners {#tg-channel}

[Subscribe](https://t.me/YandexCloudPartners) to receive partner program news and announcements, study interesting cases, and be the first to discover new business opportunities with {{ yandex-cloud }}.

## Partner Kit {#kit}

Partner Kit is an exclusive package of materials you get with your welcome letter. It contains all the tools and information you need to successfully begin and continue with the partner program.

The Partner Kit contains:

* Videos from the partner program training course prior to getting a partner status.
  
  These videos will help you better understand the principles and basics of working with {{ yandex-cloud }}, and speed up your partner program onboarding.

* Excel calculator.
  
  The tool is designed to calculate detailed project specifications for customers and assists in preparation of commercial offers. Enter the required parameters and the calculator will automatically make the calculations for a much shorter document preparation time.

* Commercial offer templates in old and new formats.
  
  Use these to create commercial offers that meet current requirements and standards.

* Customer agreement templates.
  
  Standard agreement forms that can be customized to suit your needs.

* Statement of Conformity of {{ yandex-cloud }} Services to Federal Law No. 152-FZ (On personal data).
  
  Critical document confirming the conformity of {{ yandex-cloud }} services to Russian laws and regulations on personal data.

* Partner Badges.
  
  Icons and logos to use on your website, confirming your company's status as a {{ yandex-cloud }} partner.

* Partner Marketing Kit.
  
  Marketing materials including the essentials for creating advertisements and a partner [co-marketing](#co-marketing) presentation. These materials will help you promote your services and reinforce your brand.

* Technical specification writer tutorial.
  
  A detailed guide for the technical specification writer – indispensable when preparing your project documentation.

* Presentation for {{ yandex-cloud }} partners.
  
  The presentation will help you effectively showcase the {{ yandex-cloud }} capabilities to potential customers and partners.

* Training webinars on {{ marketplace-name }} products.
  
  A series of webinars for insight into the products presented on [{{ marketplace-name }}]({{ link-cloud-marketplace }}). Improve your customer consultations and go for optimal solutions.
