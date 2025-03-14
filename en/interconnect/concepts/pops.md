# Points of presence

A point of presence is where the {{ yandex-cloud }} equipment is located. The {{ yandex-cloud }} equipment is installed across multiple points of presence. 

The customer equipment can connect to the {{ yandex-cloud }} equipment directly through a cross-connect.

The customer equipment can connect to the telecom provider equipment which, in its turn, will connect to the {{ yandex-cloud }} equipment directly through a cross-connect.

To ensure fault tolerance, we recommend setting up connections at two points of presence.

The following points of presence host {{ yandex-cloud }} equipment:

{% include [pops](../../_includes/interconnect/pops.md) %}


## Agreement letter {#letter}

To have a cross-connect set up at a point of presence, you need to sign an agreement letter, one per cross-connect.

You can find the agreement letter templates for each point of presence below:

* `M9`: [Agreement letter template for M9 (Level 10)](https://{{ s3-storage-host }}/doc-files/Interconnect-agreement-M9-L10.docx).
* `M9`: [Agreement letter template for M9 (Level 7)](https://{{ s3-storage-host }}/doc-files/Interconnect-agreement-M9-L7.docx).
* `NORD`: [Agreement letter template for NORD](https://{{ s3-storage-host }}/doc-files/Interconnect-agreement-NORD.docx).
* `OST`: [Agreement letter template for OST](https://{{ s3-storage-host }}/doc-files/Interconnect-agreement-OST.docx).
* `TEHNO`: [Agreement letter template for TEHNO](https://{{ s3-storage-host }}/doc-files/Interconnect-agreement-TEHNO.docx).

{% note alert %}

A cross-connect to a {{ yandex-cloud }} equipment port is set up solely **by the maintenance staff at the point of presence**, without engaging {{ yandex-cloud }} engineers.

If required, the maintenance staff at the point of presence may request additional approval from {{ yandex-cloud }} duty engineers for cross-connecting the client equipment to the {{ yandex-cloud }} equipment port.

{% endnote %}
