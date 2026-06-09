# Активировать промокод

Яндекс регулярно проводит маркетинговые кампании, в рамках которых пользователям могут приходить [промокоды](../concepts/promo-code.md). Чтобы воспользоваться промокодом, его необходимо активировать в сервисе Yandex Cloud Billing или в консоли управления.

{% note info %}

Действие доступно пользователям с [ролью](../security/index.md#billing-accounts-editor) `billing.accounts.editor` или выше на платежном аккаунте.

Для доступа к консоли управления необходима [роль](../../resource-manager/security/index.md#resource-manager-clouds-member) `resource-manager.clouds.member` или выше на [облако](../../resource-manager/operations/cloud/set-access-bindings.md).

{% endnote %}

Для активации:

{% list tabs group=instructions %}

- Интерфейс Yandex Cloud Billing {#billing}

  1. Перейдите в сервис [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts).
  1. Выберите аккаунт на странице **Платёжные аккаунты**.
  1. На панели слева выберите ![image](../../_assets/console-icons/flag.svg) **Аккаунт** и нажмите кнопку **Активировать промокод**. Эта кнопка появляется только, когда промокод стал доступен.
  1. Введите промокод и нажмите кнопку **Активировать**.

  Вся информация о добавленном промокоде будет доступна в [сервисе Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts) в блоке **Гранты**.

- Консоль управления {#console}

    1. Откройте [консоль управления](https://console.yandex.cloud).
    1. В правом верхнем углу нажмите ![credit-card](../../_assets/console-icons/credit-card.svg).
    1. В открывшемся виджете нажмите **Активировать промокод**.
    1. Введите промокод и нажмите кнопку **Активировать**.

    В виджете отобразится информация о добавленном промокоде.

    Для изменения видимости приватных данных используйте кнопки ![image](../../_assets/console-icons/eye-slash.svg) и ![image](../../_assets/console-icons/eye.svg).

{% endlist %}