---
title: '{{ cns-full-name }} pricing policy'
description: This article covers the {{ cns-name }} pricing policy.
editable: false
---


# {{ cns-full-name }} pricing policy



{% note warning %}

The below prices for the {{ cns-name }} resources are effective as of November 20, 2025.

{% endnote %}


## What goes into the cost of using {{ cns-name }} {#rules}

When using {{ cns-name }}, you are charged for the following:

* Processing push notification sending events (for both [mobile](concepts/push.md) and [browser](concepts/browser.md) notifications).
* Processing registration requests and supporting the registration of [individual sender names](concepts/sms.md#individual-sender) for SMS text messaging with Beeline, MegaFon, MTS, and T2.
* Processing [text message notification](concepts/sms.md) sending events within Russia.

{% note info %}

By default, {{ cns-name }} has limits on sending notifications. For more information, see [{#T}](concepts/limits.md).

{% endnote %}

{% include [vat](../_includes/vat.md) %}


### Push notification sending events {#push}

Push notifications are sent to both mobile platforms, such as Google Android and Apple iOS, and to browsers through WebPush.

Mobile and browser push notifications are added up when billing.

#### Cost calculation example {#push-example}

Let’s assume 1,500 push notifications were processed as sent to mobile and 700 more, to browser, over a month.

This means the total billable events are 1,500 + 700 = 2,200. The first 1,000 events are free of charge. For the rest 1,200, you will pay:



{% include [usd-push](../_pricing_examples/notifications/usd-push.md) %}



### Registering individual sender names {#registration}

With an [individual sender name](concepts/sms.md#individual-sender), one can process text message notification sending events on behalf of a user other than {{ yandex-cloud }} ([shared sender](concepts/sms.md#common-sender)). The name is registered with Russian mobile operators: Beeline, MegaFon, MTS, and T2.

Registering an individual sender name is billed monthly, until such a name is unregistered upon the customer’s request.

The monthly cost is fixed and does not depend on the number of days of use, processed notifications, or sent text messages. This amount will be charged to you even if no notifications were sent.


#### Cost calculation example {#registration-example}

Let’s assume you registered an individual sender name for processing text message sending events on January 20, and then unregistered it on March 5.

This means three months are billable: January, February, and March.

Cost calculation of using a registered name:



{% include [usd-registration](../_pricing_examples/notifications/usd-registration.md) %}



### Text message notification sending events {#sms}

You can only send text messages across Russia. You pay for each processed message sending event. A message over 140 B (160 Latin characters or 70 Cyrillic characters) is broken down into a few parts, each of which is billable.

The cost of processing an event depends on the text message’s type: whether it is a commercial, authentication, service, or transaction message. All text messages are considered commercial by default. If you want your messages billed as another event type, you need to create a template first. Currently, to do this, you need to send examples of your messages to [our support]({{ link-console-support }}). We will then determine whether creating a template and registering it is available for your case.

For some operators, billing may be done in packages. The cost of such packages is calculated individually for each subscriber that gets text messages. See the [cost calculation example](#sms-example) below for more information.

Sandbox messages (those sent when the text message notification channel is in the `Sandbox` status) are charged as per the relevant pricing.

#### Cost calculation example {#sms-example}

Let’s assume that, under a shared sender name, there are 100 messages sent to MTS subscribers, and 100 more, to Beeline subscribers (out of those, 30 were sent to the same subscriber, and 70 more, to different subscribers), for processing.

Since you do not have any registered templates, all events are deemed commercial.



{% include [usd-sms](../_pricing_examples/notifications/usd-sms.md) %}



## Prices for the Russia region {#prices}


{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


### Push notifications {#prices-push}

You are charged for push notifications sent to mobile devices and through browsers.



{% include [usd-push](../_pricing/notifications/usd-push.md) %}



### Registering individual sender names {#prices-registration}



{% include [usd-registration](../_pricing/notifications/usd-registration.md) %}



### Text message notifications {#prices-sms}

The cost for sending text messages depends on the mobile network provider and message type.


#### Beeline {#sms-beeline}



{% include [usd-sms-beeline](../_pricing/notifications/usd-sms-beeline.md) %}



#### MegaFon {#sms-megafon}



{% include [usd-sms-megafon](../_pricing/notifications/usd-sms-megafon.md) %}



#### MTS {#sms-mts}



{% include [usd-sms-mts](../_pricing/notifications/usd-sms-mts.md) %}


#### T2 {#sms-tele2}



{% include [usd-sms-tele2](../_pricing/notifications/usd-sms-tele2.md) %}



#### Other providers {#sms-others}



{% include [usd-sms-others](../_pricing/notifications/usd-sms-others.md) %}


{% note info %}

If you want to send more notifications, contact [our support]({{ link-console-support }}).

{% endnote %}


