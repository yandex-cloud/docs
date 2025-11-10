---
title: '{{ cns-full-name }} pricing policy'
description: This article covers the {{ cns-name }} pricing policy.
editable: false
---

# {{ cns-full-name }} pricing policy



{% note warning %}

Prices for {{ cns-name }} resources apply starting November 20, 2025.

{% endnote %}


## What goes into the cost of using {{ cns-name }} {#rules}

The following services are charged when using the service:

* Processing push notification sending events — mobile push notifications and browser push notifications.
* Processing SMS notification sending events within the Russian Federation.
* Processing requests for transferring to the operator to register individual sender names for sending SMS — a monthly fee for registering and using individual sender names with four operators: Beeline, MegaFon, MTS, and t2.

{% note info %}

By default, {{ cns-name }} has limits on sending notifications. For more information, see [{#T}](concepts/limits.md).

{% endnote %}

{% include [vat](../_includes/vat.md) %}


### Push notification sending events {#push}

Push notifications are sent to mobile platforms (Google Android, Apple iOS, etc.) and browsers (via the WebPush protocol). Payment is made for every 1,000 sent events (notifications).

The sending of mobile push notifications and browser notifications is summed up during billing.


#### Cost calculation example {#push-example}

During the month, 1,500 events of sending mobile push notifications and 700 browser push notifications were received.

2200 events are subject to billing. No fee is charged for the first 1000 events. The cost of the next 1200 will be:



{% include [usd-push](../_pricing_examples/notifications/usd-push.md) %}



### Registration of individual sender names {#registration}

An individual sender name allows you to process SMS notification delivery events on behalf of a name other than {{ yandex-cloud }}. The name is registered with the following operators in the Russian Federation: Beeline, MegaFon, MTS, and t2.

A fee for registering an individual sender name is charged monthly until the name is deregistered at the customer's request.

The cost does not depend on how many days the name was registered in the month. The cost also does not depend on the number of processed notifications and SMS sent from this name. It is charged even if no notifications were sent.


#### Cost calculation example {#registration-example}

An individual sender for processing SMS sending events was registered on January 20 and deregistered on March 5.

3 months of using this sender are billed: January, February, March.

Calculation of the cost of using the registered name:



{% include [usd-registration](../_pricing_examples/notifications/usd-registration.md) %}



### SMS notification sending events {#sms}

Messages can only be sent within the Russian Federation. Payment is made for each sent event (message). If a message is split into several parts when sending (due to exceeding the size of 140 bytes — 70 Cyrillic characters or 160 Latin characters), each part is subject to payment.

The cost of sending an event to send a message depends on its type (promotional/authorization/service/transactional). By default, all processed events (messages) are considered promotional. To have an event billed with a different type, a template must be pre-registered. At the moment, to register a template, you need to create a request to support and provide examples of templated messages to determine the possibility of templating and further template registration.

For sending SMS notification events to subscribers of some operators, billing can be implemented in packages. Packages are calculated individually for each subscriber who receives an SMS notification sending event. More details are in the [calculation example](#sms-example).

Notifications sent in the sandbox (when the SMS notification channel is in the Sandbox state) are billed according to the service prices.


#### Cost calculation example {#sms-example}

From a common sender name, there were 100 events of sending SMS notifications to MTS subscribers and 100 events to Beeline subscribers (of which 30 were sent to the same subscriber, and the remaining 70 to different subscribers).

If templates were not registered, all events are considered promotional.



{% include [usd-sms](../_pricing_examples/notifications/usd-sms.md) %}



## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


### Push notification billing {#prices-push}

Payment is charged for sending push notifications to mobile devices and browsers.



{% include [usd-push](../_pricing/notifications/usd-push.md) %}



### Registration of individual sender names billing {#prices-registration}



{% include [usd-registration](../_pricing/notifications/usd-registration.md) %}



### SMS notification billing {#prices-sms}

The cost of sending SMS depends on the mobile operator and the type of SMS.


#### Beeline {#sms-beeline}



{% include [usd-sms-beeline](../_pricing/notifications/usd-sms-beeline.md) %}



#### MegaFon {#sms-megafon}



{% include [usd-sms-megafon](../_pricing/notifications/usd-sms-megafon.md) %}



#### MTS {#sms-mts}



{% include [usd-sms-mts](../_pricing/notifications/usd-sms-mts.md) %}



#### t2 {#sms-tele2}



{% include [usd-sms-tele2](../_pricing/notifications/usd-sms-tele2.md) %}



#### Other operators {#sms-others}



{% include [usd-sms-others](../_pricing/notifications/usd-sms-others.md) %}


{% note info %}

If you want to send more notifications, contact [support]({{ link-console-support }}).

{% endnote %}

