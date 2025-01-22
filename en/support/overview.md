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


| Channel                                                                  | Basic                                       | Business                                                                | Premium                                                               |
|----------------------------------------------------------------------------------|-----------------------------------------------|-----------------------------------------------------------------------|-----------------------------------------------------------------------|
|                                                                                  | For personal and research projects     | For professional projects                                                   | For business projects with stringent fault tolerance requirements.   |
| Request to [Support Center](support-center.md)                                   | Standard: 24 hours<br>Increase quotas: 30 minutes | Standard: 4 hours<br>Critical: 30 minutes<br>Increase quotas: 30 minutes | Standard: 2 hours<br>Critical: 15 minutes<br>Increase quotas: 30 minutes |
| Chat, [Telegram](tg-chat.md)                                                      | 15 minutes                                      | 5 minutes                                                               | 5 minutes, a messenger of your choice                                         |



Only a {{ yandex-cloud }} [user](../overview/roles-and-resources.md#users) can create a request in the support center. [Make sure](./support-center.md#before-you-begin) you are making a request on behalf of the right organization. If you have an issue with your infrastructure's production environment, specify _{{ ui-key.support-center.tickets.common.label_ticket-type-critical }}_ as the request type.

Regardless of your service plan, you can request the following:

* [Service logs](request.md#logs) related to your resources and actions in {{ yandex-cloud }}.
* [Your personal data](request.md#personal) stored by Yandex.

## Types of requests to support {#request-types}

The types of requests available depend on the selected plan and are shown in the table below.


{% note info %}

The list of services offered under the Premium plan is not exhaustive and may be updated on a case-by-case basis.

{% endnote %}

| Request type                                                                                                                                                             | Basic                             | Business                              | Premium                             |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------|-------------------------------------|-------------------------------------|
| Restore access to the management console                                                                                                                               | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Provide links to documentation                                                                                                                                     | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Diagnose errors in {{ yandex-cloud }} services and fix problems not related to third-party software                                  | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Ask questions related to payments for resources                                                                                                                    | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Address FAQs (including general ones like _How does it work?_ and _What is it?_) about {{ yandex-cloud }} services and features. | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Consult and provide assistance configuring {{ yandex-cloud }} services                                                                                                  | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Inquire about your data in {{ yandex-cloud }}, including personal data                                                                                       | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Provide recommendations for service recovery in the event of a critical incident                                                                                 | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Provide general recommendations about the architecture                                                                                                                                         |                                     | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Address questions configuring third-party software and troubleshooting compatibility issues (provide reference to open sources of information)                                                 |                                     | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Provide recommendations for fixing problems with operating systems and their components                                                                                            |                                     | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Provide recommendations for troubleshooting third-party software compatibility issues (direct help solving)                                               |                                     |                                     | ![image](../_assets/common/yes.svg) |
| Directly consult with a dedicated support engineer on architecture-related tasks based on your {{ yandex-cloud }} service usage scenario                                           |                                     |                                     | ![image](../_assets/common/yes.svg) |
| Personal technical manager                                                                                                                                         |                                     |                                     | ![image](../_assets/common/yes.svg) |



{{ yandex-cloud }} technical support engineers do not address the following issues:
* Software code development.
* Debugging your proprietary software.

Technical support includes diagnosing issues in third-party software used in conjunction with the cloud infrastructure and limited assistance in solving the identified problems. Technical support engineers can help you with the installation, basic setup, and diagnostics of the following software:

- [Operating systems](https://yandex.cloud/en/marketplace?categories=os) on {{ yandex-cloud }} VM instances created from public images provided by {{ yandex-cloud }}.
- Databases and cluster management systems created in:
    - [{{ maf-full-name }}](../managed-airflow)
    - [{{ mkf-full-name }}](../managed-kafka/index.yaml)
    - [{{ mch-full-name }}](../managed-clickhouse/index.yaml)
    - [{{ mgp-full-name }}](../managed-greenplum/index.yaml)
    - [{{ managed-k8s-full-name }}](../managed-kubernetes/index.yaml)
    - [{{ mmg-full-name }}](../managed-mongodb/index.yaml)
    - [{{ mmy-full-name }}](../managed-mysql/index.yaml)
    - [{{ mos-full-name }}](../managed-opensearch/index.yaml)
    - [{{ mrd-full-name }}](../managed-redis/index.yaml)
    - [{{ mpg-full-name }}](../managed-postgresql/index.yaml)

{% include [end-of-life](../_includes/compute/end-of-life.md) %}

If the technical support cannot resolve your third-party software issue, contact the software vendor's support service. In some cases, contacting the vendor's support service requires a valid technical support contract with the vendor or its partners.

## How to change your service plan {#change-service-plan}

{% include [change-tariff](../_includes/support/change-pricing.md) %}

{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}
