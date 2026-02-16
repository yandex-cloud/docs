---
title: Как создать новый платежный аккаунт в {{ billing-name }}
description: Следуя данной инструкции, вы сможете создать новый платежный аккаунт.
---

# Создать новый платежный аккаунт

Участник любого облака может создать один или несколько [платежных аккаунтов](../concepts/billing-account.md).

{% list tabs group=customers %}

- Физические лица {#individuals}

   {% include [start-for-individuals](../../_includes/billing/billing-account-create-individual.md) %}

- Юридические лица и ИП {#businesses-entrepreneurs}

   {% include [start-for-legal-entities](../../_includes/billing/billing-account-create-legal-entities.md) %}

   {% note info %}
   
   Юридическим лицам также доступен [сабаккаунт](../../partner/terms.md#sub-account), зарегистрированный через [партнерский портал](../../partner/operations/pin-cloud.md) как аккаунт их клиента. Счета за потребление сабаккаунта всегда выставляются партнеру.
   
   {% endnote %}

{% endlist %}

{% include [account-resources-note](../_includes/account-resources-note.md) %}

## Что дальше? {#what-is-next}

После создания платежного аккаунта вы можете начинать работу с сервисами {{ yandex-cloud }}. К платежному аккаунту можно привязать одно или несколько облаков. Привязывать можно как новые облака, так и уже существующие. Отвязать облако от платежного аккаунта нельзя, но вместо этого можно перепривязать его к другому платежному аккаунту.
Для дальнейшей работы с платежным аккаунтом см. инструкции:

* [{#T}](change-data.md)
* [{#T}](get-data.md)
* [{#T}](pin-cloud.md)
* [{#T}](change-organization.md)
* [{#T}](../../partner/operations/pin-cloud.md)
* [{#T}](delete-account.md)
