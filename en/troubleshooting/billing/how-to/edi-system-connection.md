# How to connect to an Electronic Document Management system



## Issue description {#case-description}

You need to receive closing documents using the services of an Electronic Document Management operator.

## Solution {#case-resolution}

To work with Electronic Document Management, you need to connect to an Electronic Document Management [operator](../../../billing/concepts/edo.md#operator).
Currently, we support two Electronic Document Management operators:

* [Diadoc (SKB Kontur)](https://promo.diadoc.ru/yandexfd?p=z05983&utm_abtest=order-lightbox)
* [SBIS (Tensor)](https://sbis.ru/edo/telecoms/yandex)

Connecting to other Electronic Document Management operators and roaming between operators is not supported at the moment.

Yandex Cloud automatically sends agreements to the specified Electronic Document Management operators in the following order:

1. Registration of a new payer
2. Issuance of invoice
3. Conclusion of a service agreement for Electronic Document Management.

After switching to electronic document management, you will receive the service acceptance certificate in PDF format (non-electronic document) and XML (electronic document format), and the [invoice in the form of a universal transfer document with invoice function (electronic document format)](../../../billing/concepts/edo.md#document)

Please note: when you enable Electronic Document Management, Yandex Cloud will stop sending you electronic versions of closing documents by e-mail and original closing documents by Russian Post to your postal address.
A document obtained via an Electronic Document Management system is considered legally equivalent to paper.

{% note alert %}

You can only receive documents through Electronic Document Management (EDM) that were issued after the date of EDM connection.
You will have to use the Billing section to manually download the documents you previously generated in the Management console.

{% endnote %}

## If nothing helped {#if-issue-still-persists}

If something went wrong when connecting to the EDM and the recommendations provided here did not help, [create a request for technical support]({{ link-console-support }}).
When creating the request, make sure to specify:

1. Billing account ID.
You can find this ID on the [page with billing account details]({{ link-console-support }}).
2. Problem description.
