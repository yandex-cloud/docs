Cost of processing 100 events (for MTS subscribers):

> {{ sku|USD|cns.notification_events.mts_marketing_event|string }} × 100 = {% calc [currency=USD] {{ sku|USD|cns.notification_events.mts_marketing_event|number }} × 100 %}

Where:

* {{ sku|USD|cns.notification_events.mts_marketing_event|string }}: Cost of processing one advertising event for MTS subscribers, up to 400,000 events.
* 100: Number of notifications.

Cost of processing 70 events (for different Beeline subscribers):

> {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|string }} × 70 = {% calc [currency=USD] {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|number }} × 70 %}

Where:

* {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|string }}: Cost of processing one advertising event for Beeline subscribers, under the _up to two events per subscriber_ plan.
* 70: Number of notifications.

Cost of processing 30 events (for a one Beeline subscriber):

> * First event processing: {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|string }}.
> * Second event processing: {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|string }}.
> * When processing the third event, the package is activated. The _3 to 4 events per subscriber_ package will cost {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_3_to_4|string }}. Events 3 and 4 are included in this package.
> * Starting event 5, each event will cost {{ sku|USD|cns.notification_events.vimpelcom_marketing_from_5|string }}.
> 
>   Total cost of processing 30 events for a single subscriber:
>   {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|string }} × 2 + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_3_to_4|string }} + {{ sku|USD|cns.notification_events.vimpelcom_marketing_from_5|string }} × 25 = {% calc [currency=USD] {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|number }} × 2 + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_3_to_4|number }} + {{ sku|USD|cns.notification_events.vimpelcom_marketing_from_5|number }} × 25 %}

Total cost of processing all 200 SMS send events:

> {% calc [currency=USD] {{ sku|USD|cns.notification_events.mts_marketing_event|number }} × 100 %} + {% calc [currency=USD] {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|number }} × 70 %} + {% calc [currency=USD] {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|number }} × 2 + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_3_to_4|number }} + {{ sku|USD|cns.notification_events.vimpelcom_marketing_from_5|number }} × 25 %} = {% calc [currency=USD] ({{ sku|USD|cns.notification_events.mts_marketing_event|number }} × 100) + ({{ sku|USD|cns.notification_events.vimpelcom_marketing_1|number }} × 70) + ({{ sku|USD|cns.notification_events.vimpelcom_marketing_1|number }} × 2 + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_3_to_4|number }} + {{ sku|USD|cns.notification_events.vimpelcom_marketing_from_5|number }} × 25) %}
> 
> Total: {% calc [currency=USD] {{ sku|USD|cns.notification_events.mts_marketing_event|number }} × 100 + ({{ sku|USD|cns.notification_events.vimpelcom_marketing_1|number }} × 70) + ({{ sku|USD|cns.notification_events.vimpelcom_marketing_1|number }} × 2 + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_3_to_4|number }} + {{ sku|USD|cns.notification_events.vimpelcom_marketing_from_5|number }} × 25) %}

Where:

* {% calc [currency=USD] {{ sku|USD|cns.notification_events.mts_marketing_event|number }} × 100 %}: Cost of 100 messages for MTS subscribers.
* {% calc [currency=USD] {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|number }} × 70 %}: Cost of 70 messages for different Beeline subscribers.
* {% calc [currency=USD] {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|number }} × 2 + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_3_to_4|number }} + {{ sku|USD|cns.notification_events.vimpelcom_marketing_from_5|number }} × 25 %}: Charge per 30 SMS messages for one Beeline subscriber.
