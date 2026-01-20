---
title: Technical support procedure
description: This article covers the technical support procedure.
---


# Technical support procedure

{{ yandex-cloud }} provides technical support under different service plans. You can choose the one that best suits you. The cost of paid technical support plans includes two components: fixed and supplemental. The supplemental part is calculated as a percentage of the cost of resources consumed during the month. For more information about the plans, see the [Pricing policy](pricing.md).

## Contacting support {#response-time}

Depending on your service plan, you can contact technical support using one of these methods:

{% include [support-channels](../_includes/support/channels.md) %}

The expected response time is shown in the table below.


| Channel | Basic | Business | Premium |
| --------------- | ------- | ------ | ------- |
|  | For personal and research projects | For business projects | For business projects with increased fault tolerance requirements |
| Request to [Support Center](cloud-center.md) | Question: 24 hours<br>Issue: 24 hours<br>Quotas: 24 hours<br>Supply: 5 work days | Question: 4 hours<br>Issue,_medium_ priority: 4 hours<br>Issue, _important_ priority: 4 hours<br>Issue, _critical_ priority: 30 minutes<br>Quotas: 24 hours<br>Supply: 5 work days | Question: 2 hours<br>Issue,_medium_ priority: 2 hours<br>Issue, _important_ priority: 2 hours<br>Issue, _critical_ priority: 15 minutes<br>Quotas: 24 hours<br>Supply: 5 work days |
| Increasing quotas in the [Quotas](https://console.yandex.cloud/cloud?section=quotas) section | 30 minutes within the specified [limits](../overview/concepts/quotas-limits.md) | 30 minutes within the specified [limits](../overview/concepts/quotas-limits.md) | 30 minutes within the specified [limits](../overview/concepts/quotas-limits.md) |
| Chat in the {{ yandex-cloud }} interface,<br>[Telegram chat](tg-chat.md) | 15 minutes | 5 minutes | 5 minutes |
| Email | 24 hours | 24 hours | 24 hours |



Only a {{ yandex-cloud }} [user](../overview/roles-and-resources.md#users) can create a request in the support center. [Make sure](./cloud-center.md#before-you-begin) you are making a request on behalf of the right organization. If your infrastructure has a production environment issue, select the ![image](../_assets/console-icons/hand-stop.svg) **{{ ui-key.yacloud_org.support.tickets.common.label_ticket-type-v2-high-problem }}** request type with the _{{ ui-key.support-center.tariff-plans.info.context_response-critical }}_ priority.

We recommend creating a separate ticket for each issue. If your ticket describes multiple issues, technical support may create separate tickets for each one.

For more information on finding your request in {{ yandex-cloud }}, see [How do I find my request in {{ yandex-cloud }}](../support/qa.md#how-to-find-request).

## Types of requests to support {#request-types}

The types of requests available depend on the selected plan and are shown in the table below.


| Request type | Basic | Business | Premium |
| ------------- | ------- | ------ | ------- |
| Restoring access to the management console | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Advice on billing-related issues | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Request for links to documents | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Inquiries about your {{ yandex-cloud }} data, including personal data | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Diagnostics of errors in {{ yandex-cloud }} services and fixes to problems unrelated to third-party software | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| FAQ (including general ones like _How does it work?_ and _What is it?_) about {{ yandex-cloud }} services and features | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Ideas on how to improve the services in terms of functionality and feedback | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Assistance in recovering the services in the event of critical issues | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Advice on how to set up {{ yandex-cloud }} services | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Possibility to upgrade the request's priority level on demand | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Basic recommendations for building a fault-tolerant cloud infrastructure | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Preparing an RCA for _critical_ priority requests | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| HA/DR tests | ![image](../_assets/common/no.svg) | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) |
| Infrastructure checkup | ![image](../_assets/common/no.svg) | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) |
| Support for maintenance and updates of your cloud resource architecture | ![image](../_assets/common/no.svg) | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) |
| Video conferences with support experts on demand | ![image](../_assets/common/no.svg) | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) |



## What is not covered by technical support {#not-supported}

{{ yandex-cloud }} support engineers do not address the following:

* Software code development.
* Third-party software debugging.
* Support for [{{ marketplace-full-name }}](../marketplace/operations/users/quickstart.md#support) products published by vendors other than {{ yandex-cloud }}.
* Use of {{ adv-ddos-protection }}.
* {{ tracker-full-name }}, {{ forms-full-name }}, {{ wiki-full-name }}.
* Operations with the MDB services within the [{{ yandex-cloud }} customer control zone](../overview/concepts/mdb-responsibilities.md#customer-responsibilities).

If the technical support cannot resolve your third-party software issue, contact the software vendor's support service. In some cases, contacting the vendor's support service requires a valid technical support contract with the vendor or its partners.

## How to change your service plan {#change-service-plan}

{% include [change-tariff](../_includes/support/change-pricing.md) %}

