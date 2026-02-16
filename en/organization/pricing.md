---
title: '{{ org-full-name }} pricing policy'
description: This article covers the {{ org-name }} pricing policy.
---

# {{ org-full-name }} pricing policy



The fee for {{ org-full-name }} is included in the charge for paid services. Only fees for connections to external apps are charged separately.

## What goes into the cost of using {{ org-name }} {#rules}

The amount for the selected number of users is debited at the beginning of each month.

When you buy a limit for a specific number of users, the amount is debited immediately.

You can [manage](#pricing-management) {{ org-name }} billing through the [{{ cloud-center }} interface]({{ link-org-cloud-center }}). For more information, see [{#T}](./operations/manage-billing.md).

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}



<MDX>
  <PriceList
    serviceIds={['{{ pcs|identity-hub }}']}
    installationCode="ru"
    currency="USD"
    sortBy="price"
    sortOrder="desc"
  />
</MDX>



## {{ org-full-name }} billing management {#pricing-management}

With [SAML](./concepts/applications.md#saml) and [OIDC](./concepts/applications.md#oidc) apps, {{ org-name }} users can authenticate in [external applications](./tutorials/single-sign-on/index.md), such as [Grafana Cloud](https://grafana.com/products/cloud/), [Zabbix](https://www.zabbix.com), etc. Connecting {{ org-name }} users to external applications is [billable](#rules). You can [manage](./operations/manage-billing.md) {{ org-name }} billing through the [{{ cloud-center }} interface]({{ link-org-cloud-center }}).

To manage {{ org-name }} billing and use its billable features, link a [billing account](../billing/concepts/billing-account.md) to {{ org-name }}.

{% include [idp-org-to-ba-linking-role](../_includes/organization/idp-org-to-ba-linking-role.md) %}

### Monthly connection limit {#monthly-limit}

On their first login to an external application, an {{ org-name }} user starts consuming their [organization’s](./concepts/organization.md) monthly _connection limit_. Then, until the month ends, this user can log in to any external applications without limitations.

By default, an organization has a non-billable limit of 15 users per month who can authenticate to external applications. After that limit is reached, no new users will be able to log in to external apps.

You can [view](./operations/manage-billing.md#view-stats) information about users consuming this month’s connection limit at any moment. When a new month begins, the data on connection limit consumption is reset.

{% include [idp-connection-limit-viewing-role](../_includes/organization/idp-connection-limit-viewing-role.md) %}

### Changing the connection limit {#modify-limit}

You can [increase](./operations/manage-billing.md#modify-limit) the connection limit at any time. Still, extra users above the non-billable limit will be [billed](#rules). The connection limit is increased immediately after payment.

You can also reduce the connection limit. In this case, the already paid connections will remain valid until the end of the current month, and the changes will take effect starting from the first day of the next month. The minimum value is 15 connections.

{% include [idp-connection-limit-modifying-role](../_includes/organization/idp-connection-limit-modifying-role.md) %}



## Cost calculation examples {#examples}

### Example 1 {#example-1}

Your organization has 10 users who need access to external applications.

By default, the organization has a non-billable limit of 15 users per month who can authenticate to external applications. This means you will not be charged for using {{ org-name }}.


### Example 2 {#example-2}

At the beginning of the month, your organization had 15 users who needed access to external applications. Now, you need to increase the user limit to 130.



{% include [usd-example-2](../_pricing_examples/organization/usd-example-2.md) %}



### Example 3 {#example-3}

At the beginning of the month, your organization had 130 users who needed access to external applications. Now, you need to increase the user limit to 600.



{% include [usd-example-3](../_pricing_examples/organization/usd-example-3.md) %}



### Example 4 {#example-4}

At the beginning of the month, your organization had 600 users who needed access to external applications. Now, you need to reduce the user limit to 400.



{% include [usd-example-4](../_pricing_examples/organization/usd-example-4.md) %}




#### See also {#see-also}

* [{#T}](./operations/manage-billing.md)
