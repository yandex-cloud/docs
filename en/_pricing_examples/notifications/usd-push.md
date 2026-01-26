> (1,500 + 700 - 1,000) / 1,000 × {{ sku|USD|cns.notification_events.push_event.v2|pricingRate.1|string }} = 1,200 / 1,000 × {{ sku|USD|cns.notification_events.push_event.v2|pricingRate.1|string }} = {% calc [currency=USD] (1500 + 700 - 1000) / 1000 × {{ sku|USD|cns.notification_events.push_event.v2|pricingRate.1|number }} %}
> 
> {% calc [currency=USD] (1500 + 700 - 1000) / 1000 × {{ sku|USD|cns.notification_events.push_event.v2|pricingRate.1|number }} %}: Total cost of sending 2,200 push notifications per month.

Where:

* 1,500: Mobile push notifications.
* 700: In-browser push notifications.
* 1,000: Non-billable events.
* {{ sku|USD|cns.notification_events.push_event.v2|pricingRate.1|string }}: The cost of processing 1,000 {{ cns-short-name }} push notification events, from 1,000 to 500,000 notifications per month.