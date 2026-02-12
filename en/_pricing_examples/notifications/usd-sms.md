Cost of processing 100 events (for MTS subscribers):

> {{ sku|USD|cns.notification_events.mts_marketing_event|string }} × 100 = {% calc [currency=USD] {{ sku|USD|cns.notification_events.mts_marketing_event|number }} × 100 %}

Where:

* {{ sku|USD|cns.notification_events.mts_marketing_event|string }} is the cost of processing one advertising event for MTS subscribers, up to 400,000 events.
* 100: Number of notifications.

Cost of processing 70 events (for different Beeline subscribers):

> {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|string }} × 70 = {% calc [currency=USD] {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|number }} × 70 %}

Where:

* {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|string }}: Cost of processing one advertising event for Beeline subscribers, under the "up to two events per subscriber" plan.
* 70: Number of notifications.

Cost of processing 30 events (for a one Beeline subscriber):

> * First event processing: {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|string }}.
> * Second event processing: {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|string }}.
> * When processing the third event, the package is activated. The "3 to 5 events per subscriber" package will cost {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_1|string }}. The forth and fifth events are included in this package.
> * When processing the sixth event, the package is activated. The "6 to 10 events per subscriber" package will cost {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_2|string }}.
> * When processing the eleventh event, the package is activated. The "11 to 20 events per subscriber" package will cost {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_3|string }}.
> * Starting from the 21st event, each event will cost {{ sku|USD|cns.notification_events.vimpelcom_marketing_2|string }}.
> 
>   Total cost of processing 30 events for a single subscriber:
>   {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|string }} × 2 + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_1|string }} + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_2|string }} + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_3|string }} + {{ sku|USD|cns.notification_events.vimpelcom_marketing_2|string }} × 10 = {% calc [currency=USD] {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|number }} × 2 + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_1|number }} + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_2|number }} + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_3|number }} + {{ sku|USD|cns.notification_events.vimpelcom_marketing_2|number }} × 10 %}

Total cost of processing all 200 SMS send events:

> {% calc [currency=USD] {{ sku|USD|cns.notification_events.mts_marketing_event|number }} × 100 %} + {% calc [currency=USD] {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|number }} × 70 %} + {% calc [currency=USD] {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|number }} × 2 + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_1|number }} + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_2|number }} + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_3|number }} + {{ sku|USD|cns.notification_events.vimpelcom_marketing_2|number }} × 10 %} = {% calc [currency=USD] {{ sku|USD|cns.notification_events.mts_marketing_event|number }} × 100 + {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|number }} × 70 + ({{ sku|USD|cns.notification_events.vimpelcom_marketing_1|number }} × 2 + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_1|number }} + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_2|number }} + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_3|number }} + {{ sku|USD|cns.notification_events.vimpelcom_marketing_2|number }} × 10) %}
> 
> Total: {% calc [currency=USD] {{ sku|USD|cns.notification_events.mts_marketing_event|number }} × 100 + {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|number }} × 70 + ({{ sku|USD|cns.notification_events.vimpelcom_marketing_1|number }} × 2 + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_1|number }} + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_2|number }} + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_3|number }} + {{ sku|USD|cns.notification_events.vimpelcom_marketing_2|number }} × 10) %}

Where:

* {% calc [currency=USD] {{ sku|USD|cns.notification_events.mts_marketing_event|number }} × 100 %}: Charge per 100 SMS messages for MTS subscribers.
* {% calc [currency=USD] {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|number }} × 70 %}: Charge per 70 SMS messages for different Beeline subscribers.
* {% calc [currency=USD] {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|number }} × 2 + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_1|number }} + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_2|number }} + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_3|number }} + {{ sku|USD|cns.notification_events.vimpelcom_marketing_2|number }} × 10 %}: Charge per 30 SMS messages for one Beeline subscriber.
