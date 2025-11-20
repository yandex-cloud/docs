---
title: Enabling electronic document management
description: Follow this guide to enable electronic document management.
---

# Enabling electronic document management


Businesses and individual entrepreneurs that are residents of Russia can use the electronic document management (EDM) service in {{ yandex-cloud }}. 
With EDM, you can get [closing reporting documents](../concepts/edo.md#document). 

{% note warning %}

If you enable EDM, you will no longer receive electronic versions of closing documents to your e-mail address and their original copies to your mailing address.
However, you will be able to download closing documents in {{ billing-name }}. See [this guide](download-reporting-docs.md).

{% endnote %}

## Enable EDM {#connect}

To start working with {{ yandex-cloud }} via EDM:

1. Connect to an EDM [operator](../concepts/edo.md#operator): [Diadoc (SKB Kontur)](https://promo.diadoc.ru/yandexfd?p=z05983&utm_abtest=order-lightbox) or [SBIS (Tensor)](https://sbis.ru/edo/telecoms/yandex). For connection instructions, visit the operator's website. {{ yandex-cloud }} does not partner with other operators or support roaming.

1. Sign the {{ yandex-cloud }} agreement. Navigate to your [Diadoc (SKB Kontur)](https://promo.diadoc.ru/yandexfd?p=z05983&utm_abtest=order-lightbox) or [SBIS (Tensor)](https://sbis.ru/edo/telecoms/yandex) personal account and sign the Yandex.Cloud LLC agreement. The EDM agreement comes together with your invitation as an attachment requiring your signature.

    {{ yandex-cloud }} automatically and unilaterally sends agreements to two EDM operators if:
    * A new payer is registered.
    * A payment invoice is issued.
    * An agreement is entered into.

{% note info %}

{{ yandex-cloud }} does not partner with other operators and does not support roaming because they do not allow you to:
* Set up "EDM friendships" at the time of signing the EDM agreement.
* Sign documents based on templates and configure the signing procedure as required.
* Exchange unilateral documents and track their delivery status through your information system.
* Cancel signed documents through our information system's integration solution.

{% endnote %}

After you sign the agreement, you will start receiving documents from {{ yandex-cloud }}. These are documents generated no earlier than the date of delivery of the signed agreement to the EDM internal IT service. They will be automatically sent to you via EDM before the deadline stipulated in the service agreement.

The originals of the documents generated before you sign the agreement are only sent to your physical address by Russian Post.

You can find the details of the receiving party's signatories of the agreement in your profile on the operator's website. If no information is available, contact the operator's technical support.

{{ yandex-cloud }} does not handle issues reported through user profiles on the operator's website. If you have any questions or connection issues, email our support at [docs-project@yandex-team.ru](mailto:docs-project@yandex-team.ru).