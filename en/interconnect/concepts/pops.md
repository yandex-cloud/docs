# Points of presence

A point of presence is a communication object where the {{ yandex-cloud }} equipment is placed. The {{ yandex-cloud }} equipment is located at multiple points of presence.

The client equipment can connect to the {{ yandex-cloud }} equipment directly via a cross connection.

The client equipment can connect to the telecom provider equipment which, in its turn, will connect to the {{ yandex-cloud }} equipment directly via a cross connection.

To ensure fault tolerance when providing the service, set up communication channels at two points of presence.

{{ yandex-cloud }} equipment is located at the following points of presence:

{% include [pops](../../_includes/interconnect/pops.md) %}

## Agreement letter {#letter}

To have a cross connection enabled at a point of presence, write an agreement letter. A separate agreement letter should be written for each cross connection.

You can find agreement letter forms for each point of presence below:

* `M9`: [Agreement letter for M9 form](https://storage.yandexcloud.net/doc-files/interconnect-agreement-M9-example.docx)
* `NORD`: [Agreement letter for NORD form](https://storage.yandexcloud.net/doc-files/interconnect-agreement-Nord-example.docx)
* `OST`: [Agreement letter for OST form](https://storage.yandexcloud.net/doc-files/interconnect-agreement-Ost-example.docx)
* `STD`: No agreement letter required. The technical staff at a point of presence works with {{ yandex-cloud }} directly.

