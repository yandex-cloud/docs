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

* Report in PDF (non-formalized electronic document, NED) and XML (formalized electronic document, FED) formats with the DOP (FED) function in 5.03 format. These changes were introduced by order of the Federal Tax Service No. 1032 dated November 15, 2024, which clarifies the format approved by order of the Federal Tax Service No. 970 dated December 19, 2023.
* In Kontur.Diadoc (SKB Kontur): Invoice (signatory's authority domain 6, status 1) in UTD (Universal Transfer Document) format with the invoice (FED) function in 5.03 format as per order of the Federal Tax Service No. 1032 dated November 15, 2024, which updates the format established earlier by order of the Federal Tax Service No. 970 dated 19.12.2023 as per order of the Federal Tax Service dated December 19, 2018, No. MMB-7-15/820@ "On the approval of the invoice format, the format of the document certifying shipment of goods (execution of works), transfer of property rights (document on provision of services), which comprises an invoice, and the format of the document certifying shipment of goods (execution of works), transfer of property rights (document on provision of services) in electronic format".
* In SBIS (Tensor): Invoice (signatory's authority domain 6, status 1) in invoice format, presented as an invoice exchange file with additional information (seller information) comprising data stipulated for invoices by Article 169 of the Russian Tax Code and Resolution No. 1137, signed by an authorized invoice signatory.

{% include [get-invoice-notice](../../_includes/billing/get-invoice-notice.md) %}

#### See also {#see-also}

[{#T}](../operations/edo.md)
