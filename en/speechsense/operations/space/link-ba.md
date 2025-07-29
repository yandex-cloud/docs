---
title: Linking a billing account to work with {{ speechsense-name }}
description: The {{ yandex-cloud }} billing account is used to identify the user who pays for the {{ speechsense-name }} service.
---

# Linking a billing account

The {{ yandex-cloud }} [billing account](../../../billing/concepts/billing-account.md) is used to identify the user who pays for the {{ speechsense-name }} service. To get started in the new [space](../../concepts/resources-hierarchy.md#space), link a billing account to it. You can use one account to [pay for resources](../../pricing.md) in multiple spaces, or link a separate account to each space.

{% include [manage-ba-note](../../../_includes/speechsense/manage-ba-note.md) %}

## Getting started {#before-you-begin}

1. [Create](create.md) a {{ speechsense-name }} space.
1. [Create](../../../billing/operations/create-new-account.md) a {{ yandex-cloud }} billing account. You can also create a billing account in the {{ speechsense-name }} interface when you select a billing account for a space.

## How to link a billing account {#how-to}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space of your choice.
1. Under **{{ ui-key.yc-ui-talkanalytics.spaces.error.billing.title }}**, click **{{ ui-key.yc-ui-talkanalytics.common.bind }}**.

   The **Create billing account** window will open. If you already created an account, it will automatically appear in the **Billing account** field in the window that opens.

1. If you have multiple billing accounts, specify the required one in the **Billing account** field.
1. In the **Contact details** section, provide your email and phone number.
1. Click **Link**.

After that, the warning that you need to link your billing account will disappear. The information about the linked billing account is available in the **{{ ui-key.yc-ui-talkanalytics.common.settings }}** tab on the space page.

## What's next {#whats-next}

* [Add users to the space](add-user-to-space.md)
* [Create connections](../connection/create.md)
* [Create projects](../project/create.md)
* [Upload audio data](../data/upload-data.md) or [text messages](../data/upload-chat-text.md)
