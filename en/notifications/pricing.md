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

* Processing push notification sending events (for both mobile and browser notifications).
* Processing requests and sending them to mobile network providers for registering individual sender names for sending text messages. This includes monthly payment for registering and using individual sender names with four mobile providers: Beeline, MegaFon, MTS, and T2.
* Processing text message notification sending events within Russia.

{% note info %}

By default, {{ cns-name }} has limits on sending notifications. For more information, see [{#T}](concepts/limits.md).

{% endnote %}

{% include [vat](../_includes/vat.md) %}


### Push notification sending events {#push}

Push notifications are sent to both mobile platforms, such as Google Android and Apple iOS, and to browsers through WebPush. You are charged for every 1,000 notification sending events that were processed.

Mobile and browser push notification sending events are billed together.


#### Cost calculation example {#push-example}

Let’s assume 1,500 push notifications were sent to mobile and 700 more, to browser, over a month.

This means 2,200 events are billable. The first 1,000 events are free of charge. For the rest 1,200, you will pay:



{% include [usd-push](../_pricing_examples/notifications/usd-push.md) %}



### Registering individual sender names {#registration}

With an individual sender name, one can process text message notification delivery events on behalf of a user other than {{ yandex-cloud }}. One can only register such a name with one of the following Russian mobile network providers: Beeline, MegaFon, MTS, and T2.

Registering an individual sender name is billed monthly, until such a name is unregistered upon the customer’s request.

The cost does not depend on the number of days in the month over which such name has been registered. It does not depend on the number of processed notifications and text messages sent on behalf of such name either. You are charged even though you did not send any notifications.


#### Cost calculation example {#registration-example}

Let’s assume you registered an individual sender name for processing text message sending events on January 20, and then unregistered it on March 5.

This means three months are billable: January, February, and March.

Cost calculation of using a registered name:



{% include [usd-registration](../_pricing_examples/notifications/usd-registration.md) %}



### Text message notification sending events {#sms}

You can only send text messages across Russia. Each event (sent text message) is billable. A message over 140 B (160 Latin characters or 70 Cyrillic characters) is broken down into a few parts, each of which is billable.

The cost of processing an event for sending a text message depends on such message’s type: whether it is a commercial, authentication, service, or transaction message. By default, all processed events (messages) are deemed commercial. If you want your messages billed as another type, you need to create a template first. Currently, to register a template, you need to sendexamples of your messages to [our support]({{ link-console-support }}). We will then determine whether creating a template and registering it is available for your case.

Processing the events of sending of text messages to subscribers of certain mobile providers can be charged per package. The cost of such packages is calculated individually for each subscriber that gets a text message. See the [cost calculation example](#sms-example) below for more information.

Sandbox notifications (those sent when the text message notification channel is in the `Sandbox` status) are charged as per the {{ cns-name }} pricing.


#### Cost calculation example {#sms-example}

Let’s assume that, under a general sender name, you sent 100 messages to MTS subscribers, and 100 more, to Beeline subscribers (out of those, 30 were sent to the same subscriber, and 70 more, to different subscribers).

Since you do not have any registered templates, all events are deemed commercial.



{% include [usd-sms](../_pricing_examples/notifications/usd-sms.md) %}



## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


### Push notifications {#create-channel}

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


#### Т2 {#sms-tele2}



{% include [usd-sms-tele2](../_pricing/notifications/usd-sms-tele2.md) %}



#### Other providers {#sms-others}



{% include [usd-sms-others](../_pricing/notifications/usd-sms-others.md) %}


{% note info %}

If you want to send more notifications, contact [our support]({{ link-console-support }}).

{% endnote %}

