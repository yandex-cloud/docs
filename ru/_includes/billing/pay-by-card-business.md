Списание средств с банковской карты, привязанной к платежному аккаунту, происходит автоматически в начале следующего отчетного периода, если итоговая сумма списания больше нуля.

 {% note info %}

 {{ yandex-cloud }} оставляет за собой право автоматически списать средства в течение текущего отчетного периода, если баланс вашего лицевого счета превысит установленный размер [порога оплаты](../concepts/credit-limit.md).

 {% endnote %}

Обычно платеж зачисляется в течение 15‒20 минут. Историю платежей вы можете [посмотреть здесь](../operations/check-bill-history.md).

Если в день списания на банковской карте окажется недостаточно средств, попытка списания будет проведена повторно. Если списать средства не удастся в течение одного дня, {{ yandex-cloud }} оставляет за собой право поменять статус вашего платежного аккаунта на [Приостановлен](../concepts/billing-account.md#conditions).