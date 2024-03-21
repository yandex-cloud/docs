# Привязать другую карту к платежному аккаунту

Владелец платежного аккаунта с типом **{{ ui-key.yacloud.billing.account.create-new.account-type_label_individual }}** или **{{ ui-key.yacloud.billing.account.create-new.account-type_label_company }}** может привязывать к нему различные банковские карты.
Одновременно к платежному аккаунту может быть привязана только одна карта, но вы можете изменить ее в настройках платежного аккаунта. 
Средства за потребленные ресурсы списываются только с той карты, которая указана на странице платежного аккаунта.

{% include [payment-card-types](../../_includes/billing/payment-card-types.md) %}

{% note info %}

Если у выбранный карты закончится срок действия, привязка перестанет работать. Если вы уже получили новую карту, добавьте ее или выберите одну из ранее добавленных карт. Изменить реквизиты ранее добавленной карты невозможно.

{% endnote %}

## Изменить банковскую карту для оплаты {#change_card}

Чтобы указать другую карту:

{% list tabs group=instructions %}

- Интерфейс {{ billing-name }} {#billing}

  1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
  1. Выберите платежный аккаунт.
  1. Нажмите ссылку **{{ ui-key.yacloud.billing.account.overview.card_label_edit }}** в блоке **{{ ui-key.yacloud.billing.account.create-new.payment-type_label_card }}**.
  1. Укажите данные карты: 16-значный номер, срок действия и код CVV (с обратной стороны карты).
  1. Нажмите кнопку **{{ ui-key.yacloud.billing.account.bind-cloud.button_bind }}**.

  {% include [yandex-account](../_includes/payment-card-validation.md) %}

{% endlist %}

## Удалить банковскую карту {#remove-card}

Отвязать карту можно только у неактивного платежного аккаунта. 
Для инактивации аккаунта и удаления карты из личного кабинета обратитесь в [службу технической поддержки]({{ link-console-support }}).
