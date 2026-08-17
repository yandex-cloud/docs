---
title: Enabling electronic document management
description: Follow this guide to enable electronic document management.
---

# Enabling electronic document management


Businesses and individual entrepreneurs that are residents of Russia can use electronic document management (EDM) in {{ yandex-cloud }} by integrating third-party EDM operators.

You can connect directly to a supported EDM [operator](../concepts/edo.md#operator), such as Kontur.Diadoc (SKB Kontur) or SBIS (Tensor). To exchange documents with other operators, [configure](#roaming) roaming.

With EDM, you can get [closing reporting documents](../concepts/edo.md#document).

{% note warning %}

If you enable EDM, you will no longer receive digital copies of closing documents to your email address and their original copies to your mailing address.
However, you will be able to download closing documents in {{ billing-name }}. For more information, see [{#T}](download-reporting-docs.md).

{% endnote %}

## Enable EDM {#connect}

To start using EDM in {{ yandex-cloud }}:

1. Connect to a supported EDM operator, such as [Kontur.Diadoc (SKB Kontur)](https://promo.diadoc.ru/yandexfd?p=z05983&utm_abtest=order-lightbox) or [SBIS (Tensor)](https://sbis.ru/edo/telecoms/yandex). For how to connect, refer to the operator's website.

1. Make sure you qualify for an automatic invitation:

   1. You have the same tax registration reason code (KPP) and taxpayer ID number (INN) in your EDM operator account and in [Yandex Balance](https://balance.yandex.ru/) payer's card.

   1. You did not send an invitation to EDM for {{ yandex-cloud }} from your operator by yourself.

        {{ yandex-cloud }} does not work with incoming requests. To cancel an invitation, contact support or write to [bo-b2btech@yandex-team.ru](mailto:bo-b2btech@yandex-team.ru).

   1. Your legal entity (with your INN and KPP) has never had any agreements or [EDM connections](../concepts/edo.md#check) via {{ yandex-cloud }}.

1. Sign the {{ yandex-cloud }} agreement. Navigate to your [Kontur.Diadoc (SKB Kontur)](https://promo.diadoc.ru/yandexfd?p=z05983&utm_abtest=order-lightbox) or [SBIS (Tensor)](https://sbis.ru/edo/telecoms/yandex) personal account and sign the Yandex.Cloud LLC agreement. The EDM agreement is delivered as an attachment to your invitation requiring your signature.

    {{ yandex-cloud }} automatically and unilaterally sends agreements to both EDM operators if:
    * A new payer is registered.
    * A payment invoice is issued.
    * An agreement is signed.

After you sign the agreement, you will start receiving documents from {{ yandex-cloud }}. They will be automatically sent to you via EDM before the deadline stipulated in the service agreement.

Documents generated before the delivery date of the signed agreement will not be displayed. Their originals will be mailed to the physical address by Russian Post.

You can find the details of the receiving party's signatories of the agreement in your profile on the operator's website. If no information is available, contact the operator's technical support.

{{ yandex-cloud }} does not handle issues reported through user profiles on the operator's website. If you have any questions or connection issues, contact support at [bo-b2btech@yandex-team.ru](mailto:bo-b2btech@yandex-team.ru).

## Activate roaming {#roaming}

To exchange documents through other operators, activate roaming. Roaming is only available in [Kontur.Diadoc (SKB Kontur)](https://www.diadoc.ru/).

To start using EDM in {{ yandex-cloud }}:

1. Submit a connection request to [bo-b2btech@yandex-team.ru](mailto:bo-b2btech@yandex-team.ru).

    Once you do that, {{ yandex-cloud }} will send an invitation to your operator via Kontur.Diadoc (SKB Kontur) roaming (without attachments). As soon as your operator accepts the invitation, {{ yandex-cloud }} will send you an agreement to sign.

1. Sign the agreement.

After you sign the agreement, you follow the same procedure to receive the documents as when connecting to the EDM system directly.
