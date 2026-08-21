---
title: Как отправить заявку на доступ к продукту в {{ marketplace-full-name }}
description: В этой статье вы узнаете, как отправить заявку на доступ к продукту в {{ marketplace-full-name }}.
---

# Запрос доступа к продукту

Чтобы начать работу с некоторыми продуктами {{ marketplace-name }}, необходимо подать заявку на доступ к продукту и дождаться ее одобрения. Это связано с требованиями стандартов безопасности.

Отправить заявку на доступ может только пользователь, у которого есть роль `marketplace.productAccessRequests.editor` на организацию. Подробнее о назначении роли на организацию читайте в разделе [{#T}](../../../iam/operations/roles/grant.md#organization).

## Отправка заявки {#sending}

### На сайте {{ marketplace-name }} {#marketplace}

1. На главной странице [{{ marketplace-name }}](/marketplace) выберите продукт, к которому хотите получить доступ.
1. Нажмите **{{ ui-key.yacloud.marketplace-v2.button_request-access }}**.
1. {% include [access-request-steps](../../../_includes/marketplace/access-request-steps.md) %}

### На странице Доступные продукты в консоли управления {#console}

1. Войдите в [консоль управления]({{ link-console-main }}).
1. [Перейдите]({{ link-console-main }}/link/marketplace) в {{ marketplace-short-name }}.
1. Выберите продукт, к которому хотите получить доступ.
1. Нажмите **{{ ui-key.yacloud.marketplace-v2.button_request-access-from-publisher }}**.
1. {% include [access-request-steps](../../../_includes/marketplace/access-request-steps.md) %}

## Чат с издателем {#publisher-chat}

Издателю может потребоваться уточнить у вас дополнительную информацию, прежде чем выдать доступ к продукту. Все вопросы будут отображаться в заявке. Чтобы ответить издателю или задать ему свой вопрос:

1. Войдите в [консоль управления]({{ link-console-main }}).
1. [Перейдите]({{ link-console-main }}/link/marketplace) в {{ marketplace-short-name }}.
1. На панели слева нажмите **{{ ui-key.yacloud.marketplace-v2.label_product-access-request }}**.
1. Выберите нужную заявку и введите сообщение в поле **{{ ui-key.yacloud.marketplace-v2.title_product-request-messages }}**.
1. Нажмите **{{ ui-key.yacloud.marketplace-v2.action_send-msg }}**.

Когда статус заявки изменится на `{{ ui-key.yacloud.marketplace-v2.label_product-access-request-status-approved }}`, вы сможете начать использовать продукт.
