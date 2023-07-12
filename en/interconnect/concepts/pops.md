# Points of presence

A point of presence is a communication object where the {{ yandex-cloud }} equipment is placed. The {{ yandex-cloud }} equipment is installed at multiple points of presence. 

The client equipment can connect to the {{ yandex-cloud }} equipment directly via a cross connection.

The client equipment can connect to the telecom provider equipment which, in its turn, will connect to the {{ yandex-cloud }} equipment directly via a cross connection.


To ensure fault tolerance when providing the service, you may want to set up connections at two points of presence.


{{ yandex-cloud }} equipment is located at the following points of presence:

{% include [pops](../../_includes/interconnect/pops.md) %}



## Agreement letter {#letter}

To have a cross connection enabled at a point of presence, write an agreement letter. You need a separate agreement letter for each cross connection.

You can find agreement letter forms for each point of presence below:

* `M9`: [Agreement letter form for M9 (floor 10)](https://{{ s3-storage-host }}/doc-files/Interconnect-agreement-M9-L10.docx).
* `M9`: [Agreement letter form for M9 (floor 7)](https://{{ s3-storage-host }}/doc-files/Interconnect-agreement-M9-L7.docx).
* `NORD`: [Agreement letter form for NORD](https://{{ s3-storage-host }}/doc-files/Interconnect-agreement-NORD.docx).
* `OST`: [Agreement letter form for OST](https://{{ s3-storage-host }}/doc-files/Interconnect-agreement-OST.docx).
* `TEHNO`: [Agreement letter form for TEHNO](https://{{ s3-storage-host }}/doc-files/Interconnect-agreement-TEHNO.docx).

{% note alert %}

A cross-connect to a port of the {{ yandex-cloud }} equipment is enabled **only by the technical staff at the point of presence**, without engaging the {{ yandex-cloud }} technical specialists.

If required, the technical staff at the point of presence may request additional approval from {{ yandex-cloud }} duty engineers for cross-connecting the client's equipment to the {{ yandex-cloud }} equipment port.

{% endnote %}


