---
title: Managing access in the {{ yandex-cloud }} partner program
description: In this article, you will learn about the service roles and primitive roles in the {{ yandex-cloud }} partner program as well as take a look at the operations available for each role type.
---

# Access management


{% include [referral-program-closure](../../_includes/partner/referral-program-closure.md) %}

## Roles existing in this service {#roles-list}

### Service roles {#service-roles}

#### billing.accounts.owner {#billing-accounts-owner}


{% include [billing.accounts.owner](../../_roles/billing/accounts/owner.md) %}


#### billing.accounts.viewer {#billing-accounts-viewer}


{% include [billing.accounts.viewer](../../_roles/billing/accounts/viewer.md) %}


#### billing.accounts.accountant {#billing-accounts-accountant}


{% include [billing.accounts.accountant](../../_roles/billing/accounts/accountant.md) %}


#### billing.accounts.editor {#billing-accounts-editor}


{% include [billing.accounts.editor](../../_roles/billing/accounts/editor.md) %}


#### billing.accounts.varWithoutDiscounts {#billing-accounts-var-without-discounts}


{% include [billing.accounts.varwithoutdiscounts](../../_roles/billing/accounts/varWithoutDiscounts.md) %}


#### billing.accounts.admin {#billing-accounts-admin}


{% include [billing.accounts.admin](../../_roles/billing/accounts/admin.md) %}


#### billing.accounts.partnerViewer {#billing-accounts-partnerViewer}

{% include [billing.accounts.partnerViewer](../../_roles/billing/accounts/partnerViewer.md) %}

#### billing.accounts.piiPartnerViewer {#billing-accounts-piiPartnerViewer}

{% include [billing.accounts.piiPartnerViewer](../../_roles/billing/accounts/piiPartnerViewer.md) %}

#### billing.accounts.partnerEditor {#billing-accounts-partnerEditor}

{% include [billing.accounts.partnerEditor](../../_roles/billing/accounts/partnerEditor.md) %}

#### billing.accounts.piiPartnerEditor {#billing-accounts-piiPartnerEditor}

{% include [billing.accounts.piiPartnerEditor](../../_roles/billing/accounts/piiPartnerEditor.md) %}

#### billing.accounts.partnerAdmin {#billing-accounts-partnerAdmin}

{% include [billing.accounts.partnerAdmin](../../_roles/billing/accounts/partnerAdmin.md) %}

### Primitive roles {#primitive-roles}

Primitive roles are aggregator roles that define user permissions to access services. In {{ billing-name }}, these roles match the following `billing.accounts.*` roles:

* `auditor`: Same as `billing.accounts.viewer` with some limitations.
* `viewer`: Same as `billing.accounts.viewer`.
* `editor`: Same as `billing.accounts.editor`.
* `admin`: Same as `billing.accounts.admin`.

Primitive roles can only be assigned to users in the **{{ ui-key.yacloud_components.notify-subs.label_users }}** list.

## Available operations for a partner account {#partner-available-operations}

The tables below provide a list of operations available to each role type. Full names of the listed roles start with `billing.accounts.*`.

### General operations for an account {#general}

#|
|| **Operations** |
`owner` |
`viewer` |
`accountant` |
`editor` |
`admin` |
`varWithoutDiscounts` ||
|| View billing account details |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Link a cloud to an account |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Manage billing account access permissions |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Activate the paid version |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) ||
|| Deleting a billing account |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) ||
|#

### Operations for the VAR program {#var-operations}

#|
|| **Operations** |
`owner` |
`viewer` |
`accountant` |
`editor` |
`admin` |
`varWithoutDiscounts` ||
|| View a list of customers (subaccounts) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| View the customer service usage |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| View the rebate credit history |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Withdraw rebate |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Create a customer record (subaccount) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Suspend a subaccount |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Reactivate a subaccount |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| View assigned specializations |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) ||
|| View the list of partner bonuses and info on them |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) ||
|| Update customer record (subaccount) data |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) ||
|#


## Operations for the referral program {#referral-operations}

#|
|| **Operations** |
`owner` |
`viewer` |
`accountant` |
`editor` |
`admin` |
`varWithoutDiscounts` ||
|| View the history of crediting referral program commissions |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| View the status of settlements with the referrer company: accrued, withdrawn, and balance |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Create a referral link |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Modify a referral link |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Activate a referral link |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Withdraw referral program commissions |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| View the list of referral links |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) ||
|#


## Available operations for a subaccount {#subaccount-available-operations}

The table below provides a list of operations available to each role type. Full names of the listed roles start with `billing.accounts.*`.

#|
|| **Operations** |
`customer`&nbsp;^1^ |
`owner` |
`viewer` |
`accountant` |
`editor` |
`admin` |
`varWithoutDiscounts` ||
|| View subaccount details |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Link a cloud to an account |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Activate a subaccount |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Manage subaccount access permissions |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Delete a subaccount (without customer confirmation) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) ||
|| Accept partner invitation |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) ||
|| Decline partner invitation |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) ||
|#

^1^ The `billing.accounts.customer` role is assigned to a user automatically when you create their subaccount. You cannot assign it manually.
