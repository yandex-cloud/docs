---
title: Electronic document management
description: Electronic document management is used for the electronic exchange of documents that are signed with a qualified electronic signature (advanced e-signature). Electronic documents carry the same weight as their paper versions and are accepted by tax and judicial authorities over the internet. The EDM service can be used by businesses and individual entrepreneurs that are residents of Russia.
---

# Electronic document management

{% note info %}

Electronic document management (EDM) is only available to residents of Russia. Processing of incoming documents from Yandex contractors is not supported.

{% endnote %}


Electronic document management is used for the electronic exchange of documents that are signed with a qualified electronic signature (advanced e-signature). Electronic documents carry the same weight as their paper versions and are accepted by tax and judicial authorities over the internet. The EDM service can be used by businesses and individual entrepreneurs that are residents of Russia.

{{ yandex-cloud }} sends unilateral [reports](./act.md) using electronic document management. Once you sign the notice of document receipt in the EDM system, the document flow is considered completed.

## Electronic document management operators {#operator}

Documents are exchanged through electronic document management operators. They confirm that a document has been issued or received. {{ yandex-cloud }} works with the following providers:
* [Kontur.Diadoc (SKB Kontur)](https://www.diadoc.ru/)
* [SBIS (Tensor)](https://sbis.ru/)

{{ yandex-cloud }} does not support roaming. If you change the operator, cooperation via electronic document management is terminated automatically and the document flow returns to the standard method.

## What documents can be received via electronic document management {#document}

You can receive the following closing documents via electronic document management:

* PDF report (non-formalized electronic document, NED) and XML report (formalized electronic document, FED) as per the Order of the Federal Tax Service of Russia dated November 30, 2015, No. MMB-7-10/552@ "On the approval of the format of the document certifying the transfer of the results of works (document on provision of services) in electronic format".
* In Kontur.Diadoc (SKB Kontur): Invoice (signatory's authority domain 6, status 1) in UTD (Universal Transfer Document) format with the invoice (FED) function as per the Order of the Federal Tax Service of Russia dated December 19, 2018, No. MMB-7-15/820@ "On the approval of the format of the invoice, the format of the document certifying the shipment of goods (execution of works), transfer of property rights (document on provision of services), which comprises the invoice, and the format of the document certifying the shipment of goods (execution of works), transfer of property rights (document on provision of services) in electronic format".
* In SBIS (Tensor): Invoice (signatory's authority domain 6, status 1) in invoice format, presented as an invoice exchange file with additional information (seller information) comprising data stipulated for invoices by Article 169 of the Russian Tax Code and Resolution No. 1137, signed by an authorized invoice signatory.

{% include [get-invoice-notice](../../_includes/billing/get-invoice-notice.md) %}

#### See also {#see-also}

[{#T}](../operations/edo.md)
