---
title: "Questions and answers about {{ yandex-cloud }} technical support"
description: "This page presents questions and answers about {{ yandex-cloud }} technical support."
---

# FAQ about {{ yandex-cloud }} technical support

{% note info %}

This section offers tips and recommendations on contacts with the technical support team. For problems related to {{ yandex-cloud }} services, visit the [Support Center]({{ link-console-support }}).

{% endnote %}

#### How do I contact technical support? {#support-channels}

You can contact technical support in the [Support]({{ link-console-support }}) section of the management console.


#### How do I contact technical support if I cannot log in to the management console? {#requesting-support-without-ui}

If you are unable to access your Yandex account, see our [troubleshooting guide](https://yandex.com/support/passport/troubleshooting/problems.html) in the Yandex ID Help.

If you successfully logged in to your Yandex account but are unable to connect to the {{ yandex-cloud }} management console, contact technical support at [{{ link-support-mail }}](mailto:{{ link-support-mail }}).


#### What kinds of issues and cases does technical support resolve? {#support-cases-types}


Depending on your service plan, you can contact support for various issues. For more information about service plans, see [{#T}](overview.md).

Regardless of your service plan, you can request the following from technical support:

* [Service logs](request.md#logs) related to your resources and actions in {{ yandex-cloud }}.
* [Your personal data](request.md#personal) stored by Yandex.


#### How quickly does technical support respond? {#reaction-time}


Technical support is there 24/7.

The response time depends on your service plan. For more information about service plans, see [{#T}](overview.md).



#### How quickly can technical support solve an identified problem? {#resolution-time}

The resolution time will vary case by case depending on the nature of the problem. Problems with apps and services can have various causes. This makes it difficult to estimate how long it will take. The technical support team will work closely with you to troubleshoot your issues as quickly as possible.

#### How many times can I contact technical support? {#support-requests-limit}

There is no limit to the number of times you can contact technical support.


#### How can I get help with architecture-related tasks? {#help-with-arch-tasks}

To get help with architecture-related tasks, use the feedback form on the technical support page in the [support center]({{ link-console-support }}).

#### What third-party software is covered by {{ yandex-cloud }} technical support? {#supported-third-party-sw}

Technical support includes troubleshooting third-party software that is used in conjunction with the cloud infrastructure and limited assistance in solving identified problems. Technical support engineers can help you with the installation, basic setup, and diagnostics of the following software:

- [Operating systems](https://yandex.cloud/en/marketplace?categories=os) on {{ yandex-cloud }} VM instances created from public images provided by {{ yandex-cloud }}.
- Databases and cluster management systems created in:
   - [{{ mkf-full-name }}](../managed-kafka/index.yaml)
   - [{{ mch-full-name }}](../managed-clickhouse/index.yaml)
   - [{{ mgp-full-name }}](../managed-greenplum/index.yaml)
   - [{{ managed-k8s-full-name }}](../managed-kubernetes/index.yaml)
   - [{{ mmg-full-name }}](../managed-mongodb/index.yaml)
   - [{{ mmy-full-name }}](../managed-mysql/index.yaml)
   - [{{ mos-full-name }}](../managed-opensearch/index.yaml)
   - [{{ mrd-full-name }}](../managed-redis/index.yaml)
   - [{{ mpg-full-name }}](../managed-postgresql/index.yaml)

#### What happens if you cannot solve my third-party software problems? {#unresolved-third-party-issues}

If the technical support team cannot resolve your third-party software issue, contact the support service of the software vendor. In some cases, contacting the vendor's support service requires a valid technical support contract with the vendor or its partners.

#### How do I change my technical support service plan? {#change-pricing-plan}

Only the organization owner or administrator can change the technical support service plan. See [Changing your service plan](support-center.md#change-pricing) for details.

See [Requesting technical support](overview.md). Service plan upgrades are effective immediately; downgrades take effect on the first day of the following month.

{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}
