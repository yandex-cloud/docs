---
title: Как создать новый платежный аккаунт в {{ billing-name }}
description: Следуя данной инструкции, вы сможете создать новый платежный аккаунт.
---

# Создать новый платежный аккаунт

{% include [individual-nonresidents](../../_includes/billing/individual-nonresidents.md) %}

Участник любого облака может создать один или несколько [платежных аккаунтов](../concepts/billing-account.md).

{% list tabs group=customers %}

- Физические лица {#individuals}

   {% include [start-for-individuals](../../_includes/billing/billing-account-create-individual.md) %}

- Юридические лица, ИП или нерезидент Российской Федерации и Республики Казахстан {#businesses-entrepreneurs}

   {% include [start-for-legal-entities](../../_includes/billing/billing-account-create-legal-entities.md) %}

{% endlist %}

{% include [account-resources-note](../_includes/account-resources-note.md) %}

## Что дальше? {#what-is-next}

После создания платежного аккаунта вы можете начинать работу с сервисами {{ yandex-cloud }}. К платежному аккаунту можно привязать одно или несколько облаков. Привязывать можно как новые облака, так и уже существующие. Отвязать облако от платежного аккаунта нельзя, но вместо этого можно перепривязать его к другому платежному аккаунту.
Для дальнейшей работы с платежным аккаунтом см. инструкции:

* [{#T}](change-data.md)
* [{#T}](get-data.md)
* [{#T}](pin-cloud.md)
* [{#T}](change-organization.md)
* [{#T}](delete-account.md)
