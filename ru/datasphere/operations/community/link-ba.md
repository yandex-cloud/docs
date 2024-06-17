# Привязать платежный аккаунт

[Платежный аккаунт](../../../billing/concepts/billing-account.md) используется для идентификации пользователя, оплачивающего вычисления, работу [нод](../../concepts/deploy/index.md#node) и хранение ресурсов всех проектов сообщества. 

Вы можете заранее [создать платежный аккаунт](../../../billing/operations/create-new-account.md) {{ yandex-cloud }} и привязать его при [создании сообщества](./create.md). Также вы можете создать новый платежный аккаунт в интерфейсе {{ ml-platform-name }} при выборе платежного аккаунта сообщества. 

{% note warning %}

Если выбранный платежный аккаунт имеет задолженность или приостановлен, его будет невозможно привязать к сообществу {{ ml-platform-name }}. В этом случае перейдите в сервис [{{ billing-name }}]({{ link-console-billing }}), выберите ваш аккаунт и следуйте подсказкам в интерфейсе. После того как платежный аккаунт станет активным, снова попытайтесь привязать его к {{ ml-platform-name }}. Подробнее о статусах [платежных аккаунтов](../../../billing/concepts/billing-account-statuses.md).

{% endnote %}

Привязать к сообществу платежный аккаунт может только пользователь сообщества с минимальной ролью `datasphere.communities.editor`. Для операций с платежным аккаунтом также [необходима роль](../../../billing/security/) `billing.accounts.editor` или выше. Если вы — администратор сообщества, но не можете работать с платежными аккаунтами своей организации, обратитесь к администратору вашей организации в {{ yandex-cloud }}.

{% note tip %}

Управлять платежным аккаунтом могут только пользователи с [аккаунтом на Яндексе](../../../iam/concepts/users/accounts.md#passport). Если вы работаете с {{ yandex-cloud }} через [федерацию удостоверений](../../../organization/concepts/add-federation.md), [обратитесь]({{ link-console-support }}) в техническую поддержку.

{% endnote %}

## Изменить платежный аккаунт сообщества {#change-ba}

Пользователи с ролями `Editor` или `Admin` в сообществе могут изменить платежный аккаунт, который используется для оплаты проектов и ресурсов сообщества.

1. {% include [ui-find-community](../../../_includes/datasphere/ui-find-community.md) %}
1. Выберите необходимое сообщество и перейдите на вкладку **{{ ui-key.yc-ui-datasphere.project-page.tab.settings }}**.
1. В разделе **{{ ui-key.yc-ui-datasphere.common.billing }}**, нажмите **![pencil](../../../_assets/console-icons/pencil.svg) {{ ui-key.yc-ui-datasphere.common.edit }}**.
1. Выберите существующий платежный аккаунт или создайте новый, следуя подсказкам в интерфейсе.
1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.link }}**.

### Кто оплачивает ресурсы при совместном использовании {#who-pays}

{% include [pay-for-resources](../../../_includes/datasphere/pay-for-resources.md) %}

#### См. также {#see-also}

* [{#T}](../../pricing.md)
* [{#T}](../../concepts/community.md)
* [{#T}](../../../billing/concepts/billing-account.md)
* [{#T}](../../../billing/concepts/billing-account-statuses.md)