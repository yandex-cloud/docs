---
title: Персональные предложения в {{ marketplace-name }}
description: Из статьи вы узнаете, как принять персональное предложение в {{ marketplace-name }}.
---

# Принятие персонального предложения

Принять персональное предложение необходимо до его истечения (даты в поле **{{ ui-key.yacloud.marketplace.privateOfferOverviewScreen.field_acceptance-deadline }}**).

{% note warning %}

Предложение, которое истекло или которое вы отклонили, больше нельзя принять.

{% endnote %}

Для принятия персонального предложения необходимы права на просмотр платежного аккаунта, например [роль](../../../billing/security/index.md#billing-accounts-viewer) `billing.accounts.viewer`.

Чтобы принять персональное предложение:

1. Войдите в [консоль управления]({{ link-console-main }}).
1. [Перейдите]({{ link-console-main }}/link/marketplace) в {{ marketplace-short-name }}.
1. Перейдите на вкладку **{{ ui-key.yacloud.marketplace-v2.label_private-offers }}**.
1. Выберите персональное предложение в статусе `{{ ui-key.yacloud.marketplace.privateOfferStatusInfo.label_status-pending }}`.
1. Изучите условия персонального предложения и убедитесь, что собираетесь принять его на нужный платежный аккаунт.
1. Нажмите **{{ ui-key.yacloud.marketplace.privateOfferCardFooter.action_accept }}**.

Вам станет доступна покупка подписки по персональным условиям. Вы можете приобрести ее:
* на странице принятого персонального предложения в консоли управления;
* на странице продукта на сайте {{ marketplace-name }}.

Доступные подписки отобразятся на вкладке **{{ ui-key.yacloud.marketplace.productDetailView.tab_personal-terms }}**.

При покупке подписки, доступной по персональным условиям, необходимо выбрать еще одну подписку — ту, на которую вы автоматически перейдете, когда закончится действие персонального предложения. Подробнее о [покупке подписки](buy-subscription.md).
