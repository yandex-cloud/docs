---
title: Enabling electronic document management
description: Follow this guide to enable electronic document management.
---

# Enabling electronic document management


Businesses and individual entrepreneurs that are residents of Russia can use electronic document management (EDM) in {{ yandex-cloud }} by integrating third-party EDM operators.

With EDM, you can get [closing reporting documents](../concepts/edo.md#document).

{% note warning %}

If you enable EDM, you will no longer receive digital copies of closing documents to your email address and their original copies to your mailing address.
However, you will be able to download closing documents in {{ billing-name }}. For more information, see [{#T}](download-reporting-docs.md).

{% endnote %}


## Enable EDM {#connect}

To start using EDM in {{ yandex-cloud }}:

1. Connect to a supported EDM [operator](../concepts/edo.md#operator), such as [Kontur.Diadoc (SKB Kontur)](https://promo.diadoc.ru/yandexfd?p=z05983&utm_abtest=order-lightbox) or [SBIS (Tensor)](https://sbis.ru/edo/telecoms/yandex). For onboarding instructions, refer to the respective operator's website.

1. Sign the {{ yandex-cloud }} agreement. Navigate to your [Kontur.Diadoc (SKB Kontur)](https://promo.diadoc.ru/yandexfd?p=z05983&utm_abtest=order-lightbox) or [SBIS (Tensor)](https://sbis.ru/edo/telecoms/yandex) personal account and sign the Yandex.Cloud LLC agreement. The EDM agreement is delivered as an attachment to your invitation requiring your signature.

    {{ yandex-cloud }} automatically and unilaterally sends agreements to both EDM operators if:
    * A new payer is registered.
    * A payment invoice is issued.
    * An agreement is signed.

{% note info %}

Roaming is only supported in Kontur.Diadoc (SKB Kontur). To enable roaming, submit a request to [docs-project@yandex-team.ru](mailto:docs-project@yandex-team.ru).

How it works:
1. You submit a request to enable roaming.
1. {{ yandex-cloud }} sends an invitation to your operator via Kontur.Diadoc (SKB Kontur) roaming (without attachments).
1. After you accept the invitation, {{ yandex-cloud }} sends you an agreement to sign and tracks the signing process.

Once EDM is configured, document management via roaming is identical to direct exchange.

{% endnote %}

After you sign the agreement, you will start receiving documents from {{ yandex-cloud }}. These are documents generated no earlier than the date of delivery of the signed agreement to the EDM internal IT service. They will be automatically sent to you via EDM before the deadline stipulated in the service agreement.

The originals of the documents generated before you sign the agreement are only sent to your physical address by Russian Post.

You can find the details of the receiving party's signatories of the agreement in your profile on the operator's website. If no information is available, contact the operator's technical support.

{{ yandex-cloud }} does not handle issues reported through user profiles on the operator's website. If you have any questions or connection issues, email our support at [docs-project@yandex-team.ru](mailto:docs-project@yandex-team.ru).
