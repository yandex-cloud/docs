{% if audience != "internal" %}

# Requesting technical support

{% if product == "cloud-il" %}

At the [Preview](../overview/concepts/launch-stages.md) stage, {{ yandex-cloud }} support is provided for free.

{% endif %}

{% if product == "yandex-cloud" %}

{{ yandex-cloud }} provides technical support under different service plans. You can choose the plan that's best for you. The cost of paid technical support plans includes two components: fixed and supplemental. The fixed portion only depends on the selected plan, while the supplemental portion is calculated as a fraction of the cost of the resources used over the month. For more information about plans, see the [Pricing policy](pricing.md).

{% endif %}

## Contacting support {#response-time}

{% if product == "cloud-il" %}

{% include [arrangements](../_includes/support/arrangements.md) %}

{% include [mail](../_includes/support/mail.md) %}

{% endif %}

{% if product == "yandex-cloud" %}

Depending on your pricing plan, you can [contact technical support]({{ link-console-support }}) using one of the methods below:

{% include [support-channels](../_includes/support/channels.md) %}

If there is a problem with your infrastructure's production environment, specify _Critical issue_ as your request type.

{% endif %}

{% if product == "yandex-cloud" %}

The expected support specialist response time is shown in the table below. A dash in a table cell means the corresponding communication channel is not available for the selected service plan.

| Channel | Basic | Standard | Business | Premium |
--- | --- | --- | --- | ---
| For personal and research projects | For development and pilot projects | For professional projects |
| Request in console | Normal: 24 hours<br>Increase quotas: 30 minutes | Normal: 8 hours<br>Critical: 2 hours<br>Increase quotas: 30 minutes | Normal: 4 hours<br>Critical: 30 minutes<br>Increase quotas: 30 minutes | Normal: 2 hours<br>Critical: 15 minutes<b>Increase quotas: 30 minutes |
| Chat | - | 15 minutes | 5 minutes | Immediate |
| Phone | - | - | On additional request | On additional request |

{% endif %}

## Types of requests to {#request-types} support

{% if product == "cloud-il" %}

You can contact support with the following issues:
* Restore access to the management console.
* Provide links to documentation.
* Diagnose errors in {{ yandex-cloud }} services and fix identified problems not related to third-party software
* Address frequently asked questions (including general questions like How does this work? and What is it?) about {{ yandex-cloud }} services and features.
* Address questions or provide assistance when setting up services of {{ yandex-cloud }}.
* Address requests about your data in {{ yandex-cloud }}, including requests for personal data
* To request recommendations for service recovery in the event of a critical incident.
* Address questions configuring third-party software and troubleshooting compatibility issues (provide reference to open sources of information).
* Provide recommendations for fixing problems with operating systems and their components.
* Provide recommendations for troubleshooting third-party software compatibility issues (direct help solving).
* Directly consult with a dedicated support engineer on how to solve architecture-related tasks based on your {{ yandex-cloud }} service usage scenario
* Personal technical manager.

{% endif %}

{% if product == "yandex-cloud" %}

The types of requests available depend on the selected plan and are shown in the table below.

{% note info %}

The list of services offered under the "Premium" plan isn't fixed and can updated on a case-by-case basis.

{% endnote %}

| Request type | Basic | Standard | Business | Premium |
--- | --- | --- | --- | ---
| Restore access to the management console | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Provide links to documentation | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Diagnose errors in {{ yandex-cloud }} services and fix identified problems not related to third-party software | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Address questions issues related to billing | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Address frequently asked questions (including general questions like How does this work? and What is it?) about {{ yandex-cloud }} services and features | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Address questions or provide assistance when setting up {{ yandex-cloud }} services | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Address requests about your data in {{ yandex-cloud }}, including requests for personal data | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Provide recommendations for service recovery in the event of a critical incident | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Provide general recommendations about architecture | | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Address questions configuring third-party software and troubleshooting compatibility issues (provide reference to open sources of information) | | | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Provide recommendations for fixing problems with operating systems and their components | | | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Provide recommendations for troubleshooting third-party software compatibility issues (direct help solving) | | | | ![image](../_assets/common/yes.svg) |
| Directly consult with a dedicated support engineer on how to solve architecture-related tasks based on your {{ yandex-cloud }} service usage scenario | | | | ![image](../_assets/common/yes.svg) |
| Personal technical manager | | | | ![image](../_assets/common/yes.svg) |
| Additional {{ yandex-cloud }} services (case-by-case basis) | | | | ![image](../_assets/common/yes.svg) |

{% endif %}

{{ yandex-cloud }} technical support engineers don't address the following issues:
* Develop software code.
* Debug your own software.

{% if product == "yandex-cloud" %}

## How to change your service plan {#change-service-plan}

Only the service account's owner can change the service plan. To change your service plan:

1. In the [management console]({{ link-console-support }}), go to the **Pricing plan** tab.
1. Select a service plan and click **Switch**.
1. To change to:
   * Any service plan except Premium, click **Confirm**.
   * Premium plan, complete the form and click **Send**.

Service plan upgrades are activated immediately, while downgrades are applied on the first day of the following month.

{% endif %}

{% else %}

# Getting technical support

## Managed Databases (MDB) {#mdb}

{% include [internal-mdb](../_includes/support/internal-mdb.md) %}

## Other services {#other-services}

To get support for other services, go to their dedicated Telegram chats or Tracker queues:
* {{ ydb-full-name }}: a [{{ ydb-short-name }} for {{ yandex-cloud }} (NDA)](https://t.me/joinchat/DmVJUQy61Ehm9ZwPOpVK5Q) chat (person on duty: `/duty ydb`).
* {{ data-transfer-full-name }}: [DTSUPPORT](https://st.yandex-team.ru/createTicket?queue=DTSUPPORT&_form=56921) queue, the [{{ data-transfer-name }}/Transfer Manager Support/DTSUPPORT](https://t.me/joinchat/AqxpCBURpBhW79Uwq6Pcjw) chat.
* {{ objstorage-full-name }}: [MDSSUPPORT](https://st.yandex-team.ru/createTicket?queue=MDSSUPPORT) queue, [MDS/Avatars/S3/Yarl support](https://t.me/joinchat/Bbsak0DREDckUOGhK-m3aw) chat (person on duty: `/onduty@YaIncBot s3`).

{% endif %}