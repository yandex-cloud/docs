---
title: '{{ yandex-cloud }} partner portal release notes'
description: This section contains the {{ yandex-cloud }} partner portal release notes.
---

# Partner portal release notes

## Q4 2025 {#q4-2025}

1. Updated the partner portal appearance.

1. Added the all-new [partner details](../operations/get-client-stat.md) to track consumption by partner subaccount and billing account. You can now view your own and your customers' consumption figures broken down by subaccount, including discounts and bonuses.

1. Changed the procedure for [creating a subaccount](../operations/create-account.md). Now you create a subaccount only after a partner account is created. You can create a subaccount from a new or existing partner account.

1. Improved [user experience for the list of subaccounts](../portal.md#subaccounts) by adding pagination, filters, and search.


1. The partner portal can now be used to manage your Yandex 360 service plans. Use the **Quotas and instances** section for your subaccount to:

    * Track your linked Yandex 360 organizations.
    * View your service plan history.
    * Create, update, and delete service plans.

   {% note warning %}

   Access to Yandex 360 service plan management is for direct partners only. Partners operating through a distributor should use the tools provided by the distributor.

   {% endnote %}


## Q3 2025 {#q3-2025}

Updated partner portal navigation.

1. The following sections are now available:

   * **Search documentation**: Opens a search bar where you can enter a query and get a generative response based on the [partner program](../quickstart.md) documentation. The response is generated in {{ search-api }}.

   * **Accounts**: Tool for managing your customer base. In this section, you can maintain a list of all potential and current customers as well as their associated subaccounts. For convenience, we added the ability to apply filters and save filter parameters. It is also now possible to create subaccounts from accounts without having to duplicate account data.

   * **Finances**: Section for tracking commissions, accrual balances, and partner bonuses. Improved usage details: now you can break down data by subaccounts, products, services, clouds, and folders.

   * **Partner profile**: Section with information about the master account and specializations. Here, you can also manage your profile and products in the partner catalog.

1. Updated the **Subaccounts** section with a new section, **Quotas and instances**. In this section, you can view instances associated with your subaccount: clouds and individual {{ yandex-cloud }} services, such as {{ datalens-name }}, {{ tracker-name }}, etc. Additionally, you can manage resource availability by setting cloud quotas. To set up limitations for individual services and subaccounts, contact [support](../../support/).

1. Removed the **Dashboard** section. Its former subsections, **Subaccounts** and **Access management**, are now standalone sections.
