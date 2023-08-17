# Настроить платежный аккаунт

Платежный аккаунт {{ yandex-cloud }} потребуется для оплаты счетов за использование {{ tracker-name }} в случае, если [полный доступ](access.md) к сервису получат шесть или более пользователей. Платежи за сервис будут [списываться ежемесячно](pay-the-bill.md#charge) с платежного аккаунта, привязанного к {{ tracker-name }}. Информацию о тарифах и пример расчета ежемесячного платежа вы найдете в разделе [Правила тарификации](pricing.md).

Ответы на распространенные вопросы об оплате услуг вы найдете в разделе [{#T}](payment.md).

Платежными аккаунтами управляет администратор. В качестве платежного аккаунта можно использовать существующий из {{ yandex-cloud }} или создать новый, специально для {{ tracker-name }}.

## Привязать платежный аккаунт {{ yandex-cloud }} {#bind}

Если вы пользуетесь сервисами {{ yandex-cloud }} и хотите использовать тот же платежный аккаунт для оплаты услуг {{ tracker-name }}, привяжите этот аккаунт к {{ tracker-name }}.

Привязка не доступна для платежных аккаунтов с задолженностью или со [статусом](../billing/concepts/billing-account-statuses.md) `Приостановлен`.

Если вы привязываете платежный аккаунт с действующим [пробным периодом](../getting-started/free-trial/concepts/quickstart.md), для него автоматически будет активирована платная версия. Средства начнут списываться после израсходования стартового гранта или завершения пробного периода. 

Чтобы привязать платежный аккаунт:
1. Откройте [страницу {{ tracker-name }}]({{ link-tracker }}) и [войдите в аккаунт администратора](user/login.md).
1. Перейдите в раздел **{{ ui-key.startrek.blocks-desktop_page-admin.breadcrumbs-title }}** → **{{ ui-key.startrek.blocks-desktop_b-head.cloud-burger-billing }}**. На странице отображаются все ваши платежные аккаунты из {{ yandex-cloud }}.
1. Рядом с нужным аккаунтом нажмите **{{ ui-key.startrek.ui_components_page-admin_BillingAccountList.bind }}**.

## Создать платежный аккаунт {#create}

1. Откройте [страницу {{ tracker-name }}]({{ link-tracker }}) и [войдите в аккаунт администратора](user/login.md).

1. Перейдите в раздел **{{ ui-key.startrek.blocks-desktop_page-admin.breadcrumbs-title }}** → **{{ ui-key.startrek.blocks-desktop_b-head.cloud-burger-billing }}** и нажмите **+ {{ ui-key.startrek.ui_components_page-admin_BillingAccountList.create-account }}**.

1. Выберите страну, резидентом которой является плательщик.

1. {% include [choose-name-step](../_includes/billing/choose-name-step.md) %}

1. Если у вас уже есть платежные аккаунты, в блоке **{{ ui-key.yacloud_billing_account.cloud-billing-account.section_persons }}** вы можете выбрать одного из доступных плательщиков. Чтобы добавить нового плательщика, выберите **{{ ui-key.yacloud_billing_account.cloud-billing-account.account_label_new }}**.

1. Если вы добавляете нового плательщика:

   1. {% include [choose-type-step](../_includes/billing/choose-type-step.md) %}

   1. Укажите ваши личные данные или реквизиты вашей организации.

   {% include [contacts-note](../_includes/billing/contacts-note.md) %}

1. Для юридического лица или ИП выберите способ оплаты (банковская карта или банковский перевод). При выборе банковского перевода будьте готовы предоставить подтверждающие документы. Подробности будут в письме с описанием дальнейших действий.

1. Если вы будете оплачивать услуги от имени физического лица или выбрали оплату банковской картой для юридического лица или ИП, привяжите банковскую карту:

   {% include [pin-card-data](../_includes/billing/pin-card-data.md) %}

   {% include [payment-card-types](../_includes/billing/payment-card-types.md) %}

   {% note info %}

   Средства с привязанной карты могут быть списаны только после [активации платной версии](#activate) и использования сервисов {{ yandex-cloud }}.

   {% endnote %}

   {% include [payment-card-validation](../_includes/billing/payment-card-validation.md) %}

1. Нажмите кнопку **{{ ui-key.startrek.ui_components_page-admin_BillingScreen.create-account }}**.

   {% note info %}

   Нажимая кнопку **{{ ui-key.startrek.ui_components_page-admin_BillingScreen.create-account }}**, вы принимаете [оферту {{yandex-cloud}}]({{ link-cloud-oferta }}).

   {% endnote %}

   Платежный аккаунт будет создан в одном из [статусов](../billing/concepts/billing-account-statuses.md):

   * `NEW` — для физических лиц-резидентов РФ или РК с любым способом оплаты и юридических лиц-резидентов РФ или РК со способом оплаты **{{ ui-key.yacloud_billing_account.cloud-billing-account.payment-type_label_card }}**.

   * `PAYMENT_NOT_CONFIRMED` — для ИП и организаций, являющихся резидентами РФ или РК, со способом оплаты **{{ ui-key.yacloud_billing_account.cloud-billing-account.payment-type_label_invoice }}**, и организаций-нерезидентов РФ и РК с любым способом оплаты. На почту, указанную в аккаунте Яндекса, будет отправлено письмо с описанием дальнейших действий. Активация платежного аккаунта может занять до трех рабочих дней.


После создания платежного аккаунта [привяжите его к {{ tracker-name }}](#bind). Также вы можете использовать стартовый грант для ознакомления с сервисами {{ yandex-cloud }}, если не активировали пробный период и не приобретали платные услуги ранее. Подробнее о стартовом гранте читайте в документе [Начало работы в {{ yandex-cloud }}](../getting-started/).


## Редактировать платежный аккаунт {#edit}

1. Чтобы открыть раздел для редактирования платежного аккаунта, перейдите [по ссылке](http://billing.cloud.yandex.ru/) в раздел **{{ ui-key.startrek.blocks-desktop_b-head.cloud-burger-billing }}** {{ yandex-cloud }}. На странице список всех ваших платежных аккаунтов.

1. Выберите платежный аккаунт, который хотите отредактировать.

   * Чтобы переименовать аккаунт, в блоке с названием аккаунта нажмите значок ![image](../_assets/horizontal-ellipsis.svg) и выберите **Переименовать**.

   * Чтобы привязать другую банковскую карту для оплаты, в блоке **{{ ui-key.yacloud.billing.account.overview.section_card }}** нажмите кнопку **{{ ui-key.yacloud.billing.account.overview.card_label_edit }}**.

   * Чтобы изменить способ оплаты для юридического лица или ИП, обратитесь в [техническую поддержку]({{ link-tracker-support}}).

   * Чтобы изменить данные плательщика, внизу страницы нажмите кнопку **Редактировать в Яндекс&#160;Балансе**, затем на странице Баланса выберите раздел **{{ ui-key.yacloud.billing.account.create-new.section_persons }}**.

   {% note info %}

   Чтобы изменить название юридического лица или ИНН, [создайте новый платежный аккаунт](#create).

   {% endnote %}

## Заменить платежный аккаунт {#change}

Чтобы заменить платежный аккаунт:
1. Перейдите в раздел **{{ ui-key.startrek.blocks-desktop_page-admin.breadcrumbs-title }}** → **{{ ui-key.startrek.blocks-desktop_b-head.cloud-burger-billing }}**. На странице отображается платежный аккаунт, привязанный к {{ tracker-name }}.
2. Перейдите по ссылке **{{ ui-key.startrek.ui_components_page-admin_BillingAccountInfo.rebind-account }}** в верхнем правом углу. Выберите платежный аккаунт, на который хотите заменить текущий, или нажмите **+ {{ ui-key.startrek.ui_components_page-admin_BillingAccountList.create-account }}**. 
   Если вы решили создать новый аккаунт, воспользуйтесь [инструкцией](#create).

Переключение на выбранный или созданный платежный аккаунт произойдет в начале следующего месяца.

{% note tip %}

Убедитесь, что после переключения в старом аккаунте не останется задолженности.

{% endnote %}

