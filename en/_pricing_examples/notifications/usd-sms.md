Cost of processing 100 events (for MTS subscribers):

> {{ sku|USD|cns.notification_events.mts_marketing_event|string }} × 100 = {% calc [currency=USD] {{ sku|USD|cns.notification_events.mts_marketing_event|number }} × 100 %}

Where:

* {{ sku|USD|cns.notification_events.mts_marketing_event|string }} is the cost of processing one advertising event for MTS subscribers, up to 400,000 in number.
* 100: Number of notifications.

Cost of processing 70 events (for different Beeline subscribers):

> {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|string }} × 70 = {% calc [currency=USD] {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|number }} × 70 %}

Where:

* {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|string }}: Cost of processing one advertising event for Beeline subscribers, up to two events per subscriber.
* 70: Number of notifications.

Cost of processing 30 events (for a one Beeline subscriber):

> * Processing of the first event: {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|string }}.
> * Processing of the second event: {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|string }}.
> * When processing the third event, the package is activated. The cost of a package of 3 to 5 events per subscriber: {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_1|string }}. The forth and fifth events are included in this package.
> * When processing the sixth event, the package is activated. The cost of a package of 6 to 10 events per subscriber: {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_2|string }}.
> * When processing the eleventh event, the package is activated. The cost of a package of 11 to 20 events per subscriber: {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_3|string }}.
> * Starting from the 21st event, each event is billed at this price: {{ sku|USD|cns.notification_events.vimpelcom_marketing_2|string }}.
> 
>   Total cost of processing 30 events for a single subscriber:
>   {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|string }} × 2 + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_1|string }} + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_2|string }} + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_3|string }} + {{ sku|USD|cns.notification_events.vimpelcom_marketing_2|string }} × 10 = {% calc [currency=USD] {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|number }} × 2 + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_1|number }} + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_2|number }} + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_3|number }} + {{ sku|USD|cns.notification_events.vimpelcom_marketing_2|number }} × 10 %}

Total cost of processing all 200 text message sending events:

> {% calc [currency=USD] {{ sku|USD|cns.notification_events.mts_marketing_event|number }} × 100 %} + {% calc [currency=USD] {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|number }} × 70 %} + {% calc [currency=USD] {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|number }} × 2 + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_1|number }} + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_2|number }} + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_3|number }} + {{ sku|USD|cns.notification_events.vimpelcom_marketing_2|number }} × 10 %} = {% calc [currency=USD] {{ sku|USD|cns.notification_events.mts_marketing_event|number }} × 100 + {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|number }} × 70 + ({{ sku|USD|cns.notification_events.vimpelcom_marketing_1|number }} × 2 + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_1|number }} + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_2|number }} + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_3|number }} + {{ sku|USD|cns.notification_events.vimpelcom_marketing_2|number }} × 10) %}
> 
> Total: {% calc [currency=USD] {{ sku|USD|cns.notification_events.mts_marketing_event|number }} × 100 + {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|number }} × 70 + ({{ sku|USD|cns.notification_events.vimpelcom_marketing_1|number }} × 2 + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_1|number }} + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_2|number }} + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_3|number }} + {{ sku|USD|cns.notification_events.vimpelcom_marketing_2|number }} × 10) %}

Where:

* {% calc [currency=USD] {{ sku|USD|cns.notification_events.mts_marketing_event|number }} × 100 %}: Cost of 100 messages for MTS subscribers.
* {% calc [currency=USD] {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|number }} × 70 %}: Cost of 70 messages for different Beeline subscribers.
* {% calc [currency=USD] {{ sku|USD|cns.notification_events.vimpelcom_marketing_1|number }} × 2 + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_1|number }} + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_2|number }} + {{ sku|USD|cns.notifications_packet_events.vimpelcom_marketing_3|number }} + {{ sku|USD|cns.notification_events.vimpelcom_marketing_2|number }} × 10 %}: Cost of 30 messages for a single Beeline subscriber.
