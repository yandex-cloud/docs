# Points of presence



A point of presence is where the {{ yandex-cloud }} equipment is located. The {{ yandex-cloud }} equipment is installed across multiple points of presence. 

The customer equipment can connect to the {{ yandex-cloud }} equipment directly through a cross-connect.

The customer equipment can connect to the telecom provider equipment which, in its turn, will connect to the {{ yandex-cloud }} equipment directly through a cross-connect.

To ensure fault tolerance, we recommend setting up connections at two points of presence.

The following points of presence host {{ yandex-cloud }} equipment:



{% include [pops](../../_includes/interconnect/pops-int.md) %}



## Agreement letter {#letter}

To have a cross-connect set up at a point of presence, you need to sign an agreement letter, one per cross-connect.

Contact [support]({{ link-console-support }}) to request the agreement letter template and the equipment placement details for the selected point of presence.

{% note alert %}

A cross connection, linking your equipment to a {{ yandex-cloud }} port, is performed by the **point of presence personnel**, with no {{ yandex-cloud }} engineers involved.

If required, the maintenance staff at the point of presence may request additional approval from {{ yandex-cloud }} duty engineers for cross-connecting the client equipment to the {{ yandex-cloud }} equipment port.

{% endnote %}


