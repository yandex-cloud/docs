[Документация Yandex Cloud](../../index.md) > [Yandex SmartCaptcha](../index.md) > Концепции > Ограниченный режим

# Ограниченный режим SmartCaptcha

SmartCaptcha будет работать в ограниченном режиме, если ваш платежный аккаунт не находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`.

В ограниченном режиме все [запросы на валидацию](../quickstart.md#check-answer) получат ответ `ok`, а виджет SmartCaptcha может отображаться с сообщением **Работа Yandex SmartCaptcha на странице ограничена**.

SmartCaptcha автоматически восстановит работу в полнофункциональном режиме, когда ваш аккаунт перейдет в статус `ACTIVE` или `TRIAL_ACTIVE`.