Нажмите кнопку **{{ ui-key.yacloud.billing.accounts.button_empty-billing-create }}**.

Платежный аккаунт будет создан в одном из [статусов](../concepts/billing-account-statuses.md):
* `NEW` — для резидентов РФ или РК со способом оплаты **{{ ui-key.yacloud.billing.account.create-new.payment-type_label_card }}**.
* `PAYMENT_NOT_CONFIRMED` — для ИП и организаций, являющихся резидентами РФ или РК, со способом оплаты **{{ ui-key.yacloud.billing.account.create-new.payment-type_label_invoice }}**, и организаций — нерезидентов РФ и РК с любым способом оплаты. На почту, указанную в аккаунте Яндекса или {{ yandex-360 }}, будет отправлено письмо с описанием дальнейших действий. Активация платежного аккаунта может занять до трех рабочих дней.