[Документация Yandex Cloud](../../index.md) > [Партнерская программа B2B Tech](../index.md) > Партнерский портал > Управление доступом

# Управление доступом

{% note warning %}

Участие в реферальной программе новых партнеров остановлено. Партнеры, получившие статус реферального партнера ранее, продолжают свое участие в программе без изменений.

{% endnote %}

## Какие роли действуют в сервисе {#roles-list}

### Сервисные роли {#service-roles}

#### billing.accounts.owner {#billing-accounts-owner}

Роль `billing.accounts.owner` автоматически выдается при создании платежного аккаунта. Любой пользователь с ролью `billing.accounts.owner` может отозвать эту роль у создателя платежного аккаунта и изменить владельца.

{% cut "В сервисе Yandex Cloud Billing пользователи с этой ролью могут:" %}

* показывать [платежные аккаунты](../../billing/concepts/billing-account.md) в списке всех аккаунтов;
* просматривать данные платежных аккаунтов;
* просматривать [коммерческие предложения](../../billing/concepts/glossary.md#client-offer);
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к платежным аккаунтам и изменять такие права доступа;
* подключать, отключать, изменять тарифный план [технической поддержки](../../support/overview.md), а также изменять платежный аккаунт, с которого будет списываться плата по тарифу;
* просматривать и скачивать [отчетные (закрывающие) документы](../../billing/payment/documents.md);
* генерировать новые [акты сверки](../../billing/concepts/act.md#reconciliation-report);
* просматривать и скачивать сгенерированные акты сверки;
* получать и просматривать уведомления о потреблении;
* проверять расходы;
* [просматривать детализацию](../../billing/operations/check-charges.md);
* создавать [экспорт детализации](../../billing/operations/get-folder-report.md);
* создавать [бюджеты](../../billing/concepts/budget.md);
* [резервировать потребление ресурсов](../../billing/concepts/cvos.md);
* пополнять [лицевой счет](../../billing/concepts/personal-account.md) с помощью расчетного счета;
* пополнять лицевой счет с помощью банковской карты;
* привязывать [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud) к платежному аккаунту;
* переименовывать платежные аккаунты;
* изменять контакты плательщика;
* изменять платежные реквизиты;
* [изменять](../../billing/operations/pin-card.md#change_card) банковскую карту;
* [изменять](../../billing/operations/change-payment-method.md) способ оплаты;
* активировать промокоды;
* активировать [пробный период](../../billing/concepts/trial-period.md);
* активировать [платную версию](../../getting-started/free-trial/concepts/upgrade-to-paid.md);
* [удалять](../../billing/operations/delete-account.md) платежные аккаунты.

{% endcut %}

{% cut "На партнерском портале Yandex Cloud пользователи с этой ролью могут:" %}

* [создавать](../operations/pin-client.md#client-entry) записи о клиентах ([сабаккаунты](../terms.md#sub-account));
* просматривать список и данные сабаккаунтов, в т.ч. персональные данные;
* обновлять данные записей о сабаккаунтах;
* активировать сабаккаунты;
* приостанавливать работу сабаккаунтов;
* возобновлять работу сабаккаунтов;
* удалять сабаккаунты (до подтверждения клиентом);
* привязывать [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud) к сабаккаунтам;
* [управлять](../operations/access/partners-account.md) назначенными правами доступа к сабаккаунтам;
* [просматривать](../operations/get-client-stat.md) потребление сервисов клиентами;
* просматривать историю начисления [рибейта](../terms.md#rebate);
* выводить рибейт;
* просматривать присвоенные [специализации](../specializations/index.md);
* просматривать историю начисления вознаграждений по [реферальной программе](../program/referral.md);
* выводить [вознаграждение](../program/referral.md#premium) по реферальной программе;
* просматривать статус расчетов с [компанией-реферером](../terms.md#referral-partner);
* просматривать список реферальных ссылок;
* создавать реферальные ссылки;
* активировать реферальные ссылки;
* изменять реферальные ссылки;
* просматривать список [партнерских премий](../portal.md#premium) и информацию о них.

{% endcut %}

Включает разрешения, предоставляемые ролями `billing.accounts.admin` и `billing.accounts.varWithoutDiscounts`.

#### billing.accounts.viewer {#billing-accounts-viewer}

Роль `billing.accounts.viewer` назначается на платежный аккаунт. Позволяет просматривать данные платежного аккаунта, получать информацию о потреблении ресурсов, проверять расходы, выгружать акты сверки и отчетные документы.

{% cut "В сервисе Yandex Cloud Billing пользователи с этой ролью могут:" %}

* показывать [платежные аккаунты](../../billing/concepts/billing-account.md) в списке всех аккаунтов;
* просматривать данные платежных аккаунтов;
* просматривать и скачивать [отчетные (закрывающие) документы](../../billing/payment/documents.md);
* просматривать и скачивать сгенерированные акты сверки;
* получать и просматривать уведомления о потреблении;
* проверять расходы;
* [просматривать детализацию](../../billing/operations/check-charges.md).

{% endcut %}


{% cut "На партнерском портале Yandex Cloud пользователи с этой ролью могут:" %}

* просматривать присвоенные [специализации](../specializations/index.md);
* просматривать историю начисления вознаграждений по [реферальной программе](../program/referral.md);
* просматривать статус расчетов с [компанией-реферером](../terms.md#referral-partner);
* просматривать список реферальных ссылок.

{% endcut %}

#### billing.accounts.accountant {#billing-accounts-accountant}

Роль `billing.accounts.accountant` назначается на платежный аккаунт. Позволяет просматривать данные платежного аккаунта, получать информацию о потреблении ресурсов, проверять расходы, выгружать акты сверки и отчетные документы, создавать новый акт сверки, пополнять лицевой счет с помощью расчетного счета.

{% cut "В сервисе Yandex Cloud Billing пользователи с этой ролью могут:" %}

* показывать [платежные аккаунты](../../billing/concepts/billing-account.md) в списке всех аккаунтов;
* просматривать данные платежных аккаунтов;
* просматривать и скачивать [отчетные (закрывающие) документы](../../billing/payment/documents.md);
* генерировать новые [акты сверки](../../billing/concepts/act.md#reconciliation-report);
* просматривать и скачивать сгенерированные акты сверки;
* получать и просматривать уведомления о потреблении;
* проверять расходы;
* [просматривать детализацию](../../billing/operations/check-charges.md);
* пополнять [лицевой счет](../../billing/concepts/personal-account.md) с помощью расчетного счета.

{% endcut %}


{% cut "На партнерском портале Yandex Cloud пользователи с этой ролью могут:" %}

* просматривать присвоенные [специализации](../specializations/index.md);
* просматривать историю начисления вознаграждений по [реферальной программе](../program/referral.md);
* просматривать статус расчетов с [компанией-реферером](../terms.md#referral-partner);
* просматривать список реферальных ссылок;
* просматривать историю начисления [рибейта](../terms.md#rebate).

{% endcut %}

Включает разрешения, предоставляемые ролью `billing.accounts.viewer`.

#### billing.accounts.editor {#billing-accounts-editor}

Роль `billing.accounts.editor` назначается на платежный аккаунт. Позволяет получать счета на оплату, активировать промокоды, привязывать облака и сервисы к платежному аккаунту, создавать экспорт детализации, создавать бюджеты, генерировать акты сверки и резервировать ресурсы.

{% cut "В сервисе Yandex Cloud Billing пользователи с этой ролью могут:" %}

* показывать [платежные аккаунты](../../billing/concepts/billing-account.md) в списке всех аккаунтов;
* просматривать данные платежных аккаунтов;
* просматривать [коммерческие предложения](../../billing/concepts/glossary.md#client-offer);
* просматривать и скачивать [отчетные (закрывающие) документы](../../billing/payment/documents.md);
* генерировать новые [акты сверки](../../billing/concepts/act.md#reconciliation-report);
* просматривать и скачивать сгенерированные акты сверки;
* получать и просматривать уведомления о потреблении;
* проверять расходы;
* [просматривать детализацию](../../billing/operations/check-charges.md);
* создавать [экспорт детализации](../../billing/operations/get-folder-report.md);
* создавать [бюджеты](../../billing/concepts/budget.md);
* [резервировать потребление ресурсов](../../billing/concepts/cvos.md);
* пополнять [лицевой счет](../../billing/concepts/personal-account.md) с помощью расчетного счета;
* привязывать [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud) к платежному аккаунту;
* переименовывать платежные аккаунты;
* активировать промокоды.

{% endcut %}

{% cut "На партнерском портале Yandex Cloud пользователи с этой ролью могут:" %}

* просматривать историю начисления [рибейта](../terms.md#rebate);
* просматривать присвоенные [специализации](../specializations/index.md);
* просматривать историю начисления вознаграждений по [реферальной программе](../program/referral.md);
* выводить [вознаграждение](../program/referral.md#premium) по реферальной программе;
* просматривать статус расчетов с [компанией-реферером](../terms.md#referral-partner);
* просматривать список реферальных ссылок;
* создавать реферальные ссылки;
* активировать реферальные ссылки;
* изменять реферальные ссылки;
* привязывать [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud) к [сабаккаунтам](../terms.md#sub-account).

{% endcut %}

Включает разрешения, предоставляемые ролью `billing.accounts.viewer`.

#### billing.accounts.varWithoutDiscounts {#billing-accounts-var-without-discounts}

Роль `billing.accounts.varWithoutDiscounts` назначается на платежный аккаунт. Предоставляет партнерским аккаунтам все права администратора, кроме возможности получать информацию о скидках.

{% cut "В сервисе Yandex Cloud Billing пользователи с этой ролью могут:" %}

* показывать [платежные аккаунты](../../billing/concepts/billing-account.md) в списке всех аккаунтов;
* просматривать данные платежных аккаунтов;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к платежным аккаунтам;
* просматривать и скачивать [отчетные (закрывающие) документы](../../billing/payment/documents.md);
* генерировать новые [акты сверки](../../billing/concepts/act.md#reconciliation-report);
* просматривать и скачивать сгенерированные акты сверки;
* получать и просматривать уведомления о потреблении;
* проверять расходы;
* [просматривать детализацию](../../billing/operations/check-charges.md);
* создавать [экспорт детализации](../../billing/operations/get-folder-report.md);
* создавать [бюджеты](../../billing/concepts/budget.md);
* [резервировать потребление ресурсов](../../billing/concepts/cvos.md);
* пополнять [лицевой счет](../../billing/concepts/personal-account.md) с помощью расчетного счета;
* привязывать [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud) к платежному аккаунту;
* переименовывать платежные аккаунты;
* активировать промокоды.

{% endcut %}

{% cut "На партнерском портале Yandex Cloud пользователи с этой ролью могут:" %}

* [создавать](../operations/pin-client.md#client-entry) записи о клиентах ([сабаккаунты](../terms.md#sub-account));
* просматривать список и данные сабаккаунтов;
* активировать сабаккаунты;
* приостанавливать работу сабаккаунтов;
* возобновлять работу сабаккаунтов;
* привязывать [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud) к сабаккаунтам;
* [управлять](../operations/access/partners-account.md) назначенными правами доступа к сабаккаунтам;
* просматривать историю начисления [рибейта](../terms.md#rebate);
* выводить рибейт;
* просматривать историю начисления вознаграждений по [реферальной программе](../program/referral.md);
* выводить [вознаграждение](../program/referral.md#premium) по реферальной программе;
* просматривать статус расчетов с [компанией-реферером](../terms.md#referral-partner);
* создавать реферальные ссылки;
* активировать реферальные ссылки;
* изменять реферальные ссылки;
* [просматривать](../operations/get-client-stat.md) потребление сервисов клиентами.

{% endcut %}

Включает разрешения, предоставляемые ролью `billing.partners.editor`.

#### billing.accounts.admin {#billing-accounts-admin}

Роль `billing.accounts.admin` назначается на платежный аккаунт и позволяет управлять доступами к платежному аккаунту (кроме роли `billing.accounts.owner`).

{% cut "В сервисе Yandex Cloud Billing пользователи с этой ролью могут:" %}

* показывать [платежные аккаунты](../../billing/concepts/billing-account.md) в списке всех аккаунтов;
* просматривать данные платежных аккаунтов;
* просматривать [коммерческие предложения](../../billing/concepts/glossary.md#client-offer);
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к платежным аккаунтам и изменять такие права доступа (за исключением назначения и отзыва роли `billing.accounts.owner`);
* подключать, отключать, изменять тарифный план [технической поддержки](../../support/overview.md), а также изменять платежный аккаунт, с которого будет списываться плата по тарифу;
* просматривать и скачивать [отчетные (закрывающие) документы](../../billing/payment/documents.md);
* генерировать новые [акты сверки](../../billing/concepts/act.md#reconciliation-report);
* просматривать и скачивать сгенерированные акты сверки;
* получать и просматривать уведомления о потреблении;
* проверять расходы;
* [просматривать детализацию](../../billing/operations/check-charges.md);
* создавать [экспорт детализации](../../billing/operations/get-folder-report.md);
* создавать [бюджеты](../../billing/concepts/budget.md);
* [резервировать потребление ресурсов](../../billing/concepts/cvos.md);
* пополнять [лицевой счет](../../billing/concepts/personal-account.md) с помощью расчетного счета;
* привязывать [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud) к платежному аккаунту;
* переименовывать платежные аккаунты;
* активировать промокоды.

{% endcut %}

{% cut "На партнерском портале Yandex Cloud пользователи с этой ролью могут:" %}

* [создавать](../operations/pin-client.md#client-entry) записи о клиентах ([сабаккаунты](../terms.md#sub-account));
* просматривать список и данные сабаккаунтов, включая персональные данные;
* активировать сабаккаунты;
* приостанавливать работу сабаккаунтов;
* возобновлять работу сабаккаунтов;
* привязывать [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud) к сабаккаунтам;
* [управлять](../operations/access/partners-account.md) назначенными правами доступа к сабаккаунтам;
* [просматривать](../operations/get-client-stat.md) потребление сервисов клиентами;
* просматривать историю начисления [рибейта](../terms.md#rebate);
* выводить рибейт;
* просматривать присвоенные [специализации](../specializations/index.md);
* просматривать историю начисления вознаграждений по [реферальной программе](../program/referral.md);
* выводить [вознаграждение](../program/referral.md#premium) по реферальной программе;
* просматривать статус расчетов с [компанией-реферером](../terms.md#referral-partner);
* просматривать список реферальных ссылок;
* создавать реферальные ссылки;
* активировать реферальные ссылки;
* изменять реферальные ссылки;
* просматривать список [партнерских премий](../portal.md#premium) и информацию о них.

{% endcut %}

Включает разрешения, предоставляемые ролями `billing.accounts.editor`, `billing.accounts.partnerAdmin` и `billing.partners.editor`.

#### billing.accounts.partnerViewer {#billing-accounts-partnerViewer}

Роль `billing.accounts.partnerViewer` назначается на платежный аккаунт и позволяет просматривать данные партнера, за исключением персональных данных.

На партнерском портале Yandex Cloud пользователи с этой ролью могут:
* просматривать список [сабаккаунтов](../terms.md#sub-account) и информацию о них (кроме персональных данных);
* просматривать список [партнерских премий](../terms.md#partner-award);
* просматривать страницу с [инструментами партнера](../program/var-tools.md);
* просматривать список аккаунтов и информацию о них (кроме персональных данных);
* просматривать список контактов и информацию о них (кроме персональных данных);
* просматривать список [партнерских сделок](../terms.md#deal-reg) и информацию о них (кроме персональных данных).

#### billing.accounts.piiPartnerViewer {#billing-accounts-piiPartnerViewer}

Роль `billing.accounts.piiPartnerViewer` назначается на платежный аккаунт и позволяет просматривать данные сабаккаунта и партнера, включая персональные данные.

На партнерском портале Yandex Cloud пользователи с этой ролью могут:
* просматривать информацию о балансе, начислениях и выводе [рибейта](../terms.md#rebate) партнера;
* [просматривать](../operations/get-client-stat.md) детализацию потребления партнера, в т.ч. в его [сабаккаунтах](../terms.md#sub-account);
* просматривать список [партнерских премий](../terms.md#partner-award);
* просматривать страницу с [инструментами партнера](../program/var-tools.md);
* просматривать список аккаунтов и информацию о них, в т.ч. персональные данные;
* просматривать список сабаккаунтов и информацию о них, в т.ч. персональные данные;
* просматривать список контактов и информацию о них, в т.ч. персональные данные;
* просматривать список [партнерских сделок](../terms.md#deal-reg) и информацию о них, в т.ч. персональные данные.

Включает разрешения, предоставляемые ролью `billing.accounts.partnerViewer`.

#### billing.accounts.partnerEditor {#billing-accounts-partnerEditor}

Роль `billing.accounts.partnerEditor` назначается на платежный аккаунт и позволяет управлять аккаунтами, сабаккаунтами, контактами и партнерскими сделками. Роль не предоставляет доступа к персональным данным.

На партнерском портале Yandex Cloud пользователи с этой ролью могут:
* управлять [сабаккаунтами](../terms.md#sub-account) в обход [прав доступа](../../iam/concepts/access-control/index.md), назначенных на уровне [организации](../../organization/concepts/organization.md), за исключением подтверждения права на работу с партнером;
* просматривать список сабаккаунтов и информацию о них (кроме персональных данных);
* создавать новые и обновлять данные в существующих сабаккаунтах, а также приостанавливать и возобновлять работу сабаккаунтов и удалять их;
* просматривать список аккаунтов и информацию о них (кроме персональных данных), изменять информацию об аккаунтах;
* просматривать список контактов и информацию о них (кроме персональных данных), изменять данные контактов;
* просматривать список [партнерских сделок](../terms.md#deal-reg) и информацию о них (кроме персональных данных), а также изменять данные о партнерских сделках;
* просматривать список [партнерских премий](../terms.md#partner-award);
* просматривать страницу с [инструментами партнера](../program/var-tools.md).

Включает разрешения, предоставляемые ролью `billing.accounts.partnerViewer`.

#### billing.accounts.piiPartnerEditor {#billing-accounts-piiPartnerEditor}

Роль `billing.accounts.piiPartnerEditor` назначается на платежный аккаунт и позволяет управлять выводом рибейта партнера, а также просматривать данные сабаккаунтов и партнеров, включая персональные данные.

На партнерском портале Yandex Cloud пользователи с этой ролью могут:
* просматривать информацию о балансе, начислениях и выводе [рибейта](../terms.md#rebate) партнера;
* создавать расходные договоры для рибейтов и выводить начисленный рибейт партнера;
* [просматривать](../operations/get-client-stat.md) детализацию потребления партнера, в т.ч. в его [сабаккаунтах](../terms.md#sub-account);
* просматривать список [партнерских премий](../terms.md#partner-award);
* просматривать страницу с [инструментами партнера](../program/var-tools.md);
* просматривать список аккаунтов и информацию о них, в т.ч. персональные данные;
* просматривать список сабаккаунтов и информацию о них, в т.ч. персональные данные;
* просматривать список контактов и информацию о них, в т.ч. персональные данные;
* просматривать список [партнерских сделок](../terms.md#deal-reg) и информацию о них, в т.ч. персональные данные.

Включает разрешения, предоставляемые ролью `billing.accounts.piiPartnerViewer`.

#### billing.accounts.partnerAdmin {#billing-accounts-partnerAdmin}

Роль `billing.accounts.partnerAdmin` назначается на платежный аккаунт и предоставляет полный доступ ко всем инструментам партнерского портала и всей информации, хранящейся на партнерском портале, включая персональные данные.

На партнерском портале Yandex Cloud пользователи с этой ролью могут:
* управлять [сабаккаунтами](../terms.md#sub-account) в обход [прав доступа](../../iam/concepts/access-control/index.md), назначенных на уровне [организации](../../organization/concepts/organization.md), за исключением подтверждения права на работу с партнером;
* просматривать список сабаккаунтов и информацию о них, включая персональные данные;
* создавать новые и обновлять данные в существующих сабаккаунтах, а также приостанавливать и возобновлять работу сабаккаунтов и удалять их;
* просматривать список аккаунтов и информацию о них, включая персональные данные, изменять информацию об аккаунтах;
* просматривать список контактов и информацию о них, включая персональные данные, изменять данные контактов;
* просматривать список [партнерских сделок](../terms.md#deal-reg) и информацию о них, включая персональные данные, а также изменять данные о партнерских сделках;
* просматривать информацию о балансе, начислениях и выводе [рибейта](../terms.md#rebate) партнера;
* создавать расходные договоры для рибейтов и выводить начисленный рибейт партнера;
* [просматривать](../operations/get-client-stat.md) детализацию потребления партнера, в т.ч. в его сабаккаунтах;
* просматривать список [партнерских премий](../terms.md#partner-award);
* просматривать страницу с [инструментами партнера](../program/var-tools.md).

Включает разрешения, предоставляемые ролями `billing.accounts.partnerEditor` и `billing.accounts.piiPartnerEditor`.

### Примитивные роли {#primitive-roles}

Примитивные роли — роли агрегаторы, определяющие разрешения пользователя для доступа к сервисам. В Yandex Cloud Billing эти роли соответствуют ролям `billing.accounts.*`:

* `auditor` — аналогична роли `billing.accounts.viewer` с ограничениями.
* `viewer` — аналогична роли `billing.accounts.viewer`.
* `editor` — аналогична роли `billing.accounts.editor`.
* `admin` — аналогична роли `billing.accounts.admin`.

Примитивные роли могут назначаться только пользователям, добавленным в список **Пользователи**.

## Доступные операции для партнерского аккаунта {#partner-available-operations}

Список доступных операций для ролей каждого типа представлен в таблицах ниже. Полные названия ролей из таблицы начинаются с `billing.accounts.*`.

### Общие операции для аккаунта {#general}

#|
|| **Операции** |
`owner` |
`viewer` |
`accountant` |
`editor` |
`admin` |
`varWithoutDiscounts` ||
|| Посмотреть данные платежного аккаунта |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Привязать облако к аккаунту |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Управлять правами доступа к платежному аккаунту |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Активировать платную версию |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) ||
|| Удалить платежный аккаунт |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) ||
|#

### Операции для программы прямого партнерства {#var-operations}

#|
|| **Операции** |
`owner` |
`viewer` |
`accountant` |
`editor` |
`admin` |
`varWithoutDiscounts` ||
|| Просмотреть список клиентов (сабаккаунтов) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Посмотреть потребление сервисов клиентом |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Посмотреть историю начисления рибейта |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Вывести рибейт |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Создать запись о клиенте (сабаккаунт) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Приостановить сабаккаунт |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Возобновить работу сабаккаунта |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Посмотреть присвоенные специализации |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) ||
|| Посмотреть список партнерских премий и информацию о них |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) ||
|| Обновить данные записи о клиенте (сабаккаунта) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) ||
|#


## Операции для реферальной программы {#referral-operations}

#|
|| **Операции** |
`owner` |
`viewer` |
`accountant` |
`editor` |
`admin` |
`varWithoutDiscounts` ||
|| Посмотреть историю начисления вознаграждений по реферальной программе |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Посмотреть статус расчетов с компанией-реферером: начислено, выведено, и остаток |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Создать реферальную ссылку |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Изменить реферальную ссылку |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Активировать реферальную ссылку |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Вывести вознаграждение по реферальной программе |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Посмотреть список реферальных ссылок |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) ||
|#


## Доступные операции для сабаккаунта {#subaccount-available-operations}

Список доступных операций для ролей каждого типа представлен в таблице ниже. Полные названия ролей из таблицы начинаются с `billing.accounts.*`.

#|
|| **Операции** |
`customer`&nbsp;^1^ |
`owner` |
`viewer` |
`accountant` |
`editor` |
`admin` |
`varWithoutDiscounts` ||
|| Посмотреть данные сабаккаунта |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Привязать облако к аккаунту |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Активировать сабаккаунт |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Управлять правами доступа к сабаккаунту |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/yes.svg) ||
|| Удалить сабаккаунт (до подтверждения клиентом) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) ||
|| Принять приглашение от партнера |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) ||
|| Отклонить приглашение от партнера |
![image](../../_assets/common/yes.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) |
![image](../../_assets/common/no.svg) ||
|#

^1^ Роль `billing.accounts.customer` выдается пользователю автоматически при создании сабаккаунта. Назначить ее вручную нельзя.