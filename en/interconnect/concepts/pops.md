# Points of presence

A point of presence is where the {{ yandex-cloud }} equipment is located. The {{ yandex-cloud }} equipment is installed across multiple points of presence. 

The client equipment can connect to the {{ yandex-cloud }} equipment directly via a cross connection.

The client equipment can connect to the telecom provider equipment which, in its turn, will connect to the {{ yandex-cloud }} equipment directly via a cross connection.

To ensure fault tolerance when providing the service, you may want to set up connections at two points of presence.

{{ yandex-cloud }} equipment is located at the following points of presence:

{% include [pops](../../_includes/interconnect/pops.md) %}


## Agreement letter {#letter}

To have a cross connection enabled at a point of presence, you need to sign an agreement letter, one per each cross connection.

You can find the agreement letter forms for each point of presence below:

* `M9`: [Agreement letter template for M9 (Level 10)](https://{{ s3-storage-host }}/doc-files/Interconnect-agreement-M9-L10.docx)
* `M9`: [Agreement letter template for M9 (Level 7)](https://{{ s3-storage-host }}/doc-files/Interconnect-agreement-M9-L7.docx)
* `NORD`: [Agreement letter template for NORD](https://{{ s3-storage-host }}/doc-files/Interconnect-agreement-NORD.docx)
* `OST`: [Agreement letter template for OST](https://{{ s3-storage-host }}/doc-files/Interconnect-agreement-OST.docx)
* `TEHNO`: [Agreement letter template for TEHNO](https://{{ s3-storage-host }}/doc-files/Interconnect-agreement-TEHNO.docx)

{% note alert %}

A cross connection to a {{ yandex-cloud }} equipment port can only be enabled **by the maintenance crew at the point of presence**, without engaging the {{ yandex-cloud }} engineers.

If required, the maintenance crew at the point of presence may request additional approval from {{ yandex-cloud }} duty engineers for cross-connecting the client equipment to the {{ yandex-cloud }} equipment port.

{% endnote %}
