# Устранение ошибки `PROHIBITED_BILLING_ACCOUNT_USAGE_STATUS`


## Описание проблемы {#issue-description}

При попытке привязать облако, {{ tracker-full-name}} или {{ ml-platform-full-name }} возникает ошибка `PROHIBITED_BILLING_ACCOUNT_USAGE_STATUS`.

## Решение {#issue-resolution}

Ошибка вызвана тем, что нельзя выполнить перепривязку с платежного аккаунта, находящегося на платном потреблении, на аккаунт, который находится в пробном периоде.

Необходимо перейти на платную версию по [этой инструкции](../../../getting-started/free-trial/concepts/upgrade-to-paid.md) в вашем аккаунте и повторить привязку.