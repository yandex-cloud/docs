# Справочник ролей {{ yandex-cloud }}


{% note warning %}

Даже если [операция](../api-design-guide/concepts/about-async.md) с ресурсами [сервисов](../overview/concepts/services.md) {{ yandex-cloud }} разрешена [ролью](concepts/access-control/roles.md), ее выполнение может быть заблокировано, если на [организацию](../organization/concepts/organization.md), [облако](../resource-manager/concepts/resources-hierarchy.md#cloud) или [каталог](../resource-manager/concepts/resources-hierarchy.md#folder) назначена [политика авторизации](concepts/access-control/access-policies.md), запрещающая эту операцию.

{% endnote %}

## Примитивные роли {#primitive-roles}

На диаграмме показано, какие примитивные роли есть в {{ yandex-cloud }} и как они наследуют разрешения друг друга. Например, в роль `{{ roles-editor }}` входят все разрешения роли `{{ roles-viewer }}`. После диаграммы дано описание каждой роли.

![image](../_assets/iam/security/primitive-roles-hierarchy.svg)

Примитивные роли позволяют пользователям совершать действия во [всех сервисах](../overview/concepts/services.md) {{ yandex-cloud }}.

#### {{ roles-auditor }} {#auditor}

Роль `auditor` предоставляет разрешения на чтение конфигурации и метаданных любых ресурсов Yandex Cloud без возможности доступа к данным.

Например, пользователи с этой ролью могут:
* просматривать информацию о [ресурсе]({{ link-docs }}/resource-manager/concepts/resources-hierarchy);
* просматривать метаданные ресурса;
* просматривать список операций с ресурсом.

Роль `auditor` — наиболее безопасная роль, исключающая доступ к данным [сервисов]({{ link-docs }}/overview/concepts/services). Роль подходит для пользователей, которым необходим минимальный уровень доступа к ресурсам Yandex Cloud.

#### {{ roles-viewer }} {#viewer}

Роль `viewer` предоставляет разрешения на чтение информации о любых [ресурсах]({{ link-docs }}/resource-manager/concepts/resources-hierarchy) Yandex Cloud.

Включает разрешения, предоставляемые ролью `auditor`.

В отличие от роли `auditor`, роль `viewer` предоставляет доступ к данным [сервисов]({{ link-docs }}/overview/concepts/services) в режиме чтения.

#### {{ roles-editor }} {#editor}

Роль `editor` предоставляет разрешения на управление любыми [ресурсами]({{ link-docs }}/resource-manager/concepts/resources-hierarchy) Yandex Cloud, кроме назначения ролей другим пользователям, передачи прав владения [организацией]({{ link-docs }}/organization/concepts/organization) и ее удаления, а также удаления [ключей шифрования]({{ link-docs }}/kms/concepts/) Key Management Service.

Например, пользователи с этой ролью могут создавать, изменять и удалять ресурсы.

Включает разрешения, предоставляемые ролью `viewer`.

#### {{ roles-admin }} {#admin}

Роль `admin` позволяет назначать любые роли, кроме `resource-manager.clouds.owner` и `organization-manager.organizations.owner`, а также предоставляет разрешения на управление любыми [ресурсами]({{ link-docs }}/resource-manager/concepts/resources-hierarchy) Yandex Cloud, кроме передачи прав владения [организацией]({{ link-docs }}/organization/concepts/organization) и ее удаления.

Прежде чем назначить роль `admin` на организацию, [облако]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#cloud) или [платежный аккаунт]({{ link-docs }}/billing/concepts/billing-account), ознакомьтесь с информацией о защите [привилегированных аккаунтов]({{ link-docs }}/security/standard/all#privileged-users).

Включает разрешения, предоставляемые ролью `editor`.

Вместо примитивных ролей мы рекомендуем использовать роли сервисов. Такой подход позволит более гранулярно управлять доступом и обеспечить соблюдение [принципа минимальных привилегий](../security/standard/all.md#min-privileges).


## Служебные роли {#auxiliary-roles}

#### quota-manager.viewer {#quota-manager-viewer}

Роль `quota-manager.viewer` позволяет просматривать информацию о [квотах](../overview/concepts/quotas-limits.md) сервисов Yandex Cloud и о запросах на увеличение таких квот, а также об [облаках](../resource-manager/concepts/resources-hierarchy.md#cloud).

#### quota-manager.requestOperator {#quota-manager-requestoperator}

Роль `quota-manager.requestOperator` позволяет создавать запросы на новые [квоты](../overview/concepts/quotas-limits.md) для сервисов Yandex Cloud. Это разрешение также входит в роли `admin` и `editor`.


## Сервисы искусственного интеллекта {#ai-services}

#### ai.auditor {#ai-auditor}

Роль `ai.auditor` позволяет просматривать информацию о квотах сервисов [{{ translate-full-name }}]({{ link-docs-ai }}translate/concepts/limits#translate-quotas), [{{ vision-full-name }}]({{ link-docs-ai }}vision/concepts/limits#vision-quotas), [{{ speechkit-full-name }}]({{ link-docs-ai }}speechkit/concepts/limits#speechkit-quotas) и [{{ ai-studio-full-name }}]({{ link-docs-ai }}ai-studio/concepts/limits#yandexgpt-quotas), о загруженных [файлах]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore#file-uploading), [поисковых индексах]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore) {{ vector-store-name }}, [датасетах]({{ link-docs-ai }}ai-studio/concepts/resources/dataset) и [моделях генерации текста]({{ link-docs-ai }}ai-studio/concepts/generation/models) {{ ai-studio-full-name }}, просматривать метаданные [правил модерации]({{ link-docs-ai }}ai-studio/concepts/security/guardrails#rules) ответов моделей, а также информацию об [облаке]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#cloud) и [каталоге]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#folder).

Включает разрешения, предоставляемые ролями `ai.assistants.auditor`, `ai.datasets.auditor`, `ai.models.auditor` и `ai.guardrails.auditor`.

#### ai.viewer {#ai-viewer}

Роль `ai.viewer` позволяет просматривать информацию о квотах сервисов [{{ translate-full-name }}]({{ link-docs-ai }}translate/concepts/limits#translate-quotas), [{{ vision-full-name }}]({{ link-docs-ai }}vision/concepts/limits#vision-quotas), [{{ speechkit-full-name }}]({{ link-docs-ai }}speechkit/concepts/limits#speechkit-quotas) и [{{ ai-studio-full-name }}]({{ link-docs-ai }}ai-studio/concepts/limits#yandexgpt-quotas), о [моделях генерации текста]({{ link-docs-ai }}ai-studio/concepts/generation/models), о [правилах модерации]({{ link-docs-ai }}ai-studio/concepts/security/guardrails#rules) ответов моделей, о [датасетах]({{ link-docs-ai }}ai-studio/concepts/resources/dataset), загруженных [файлах]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore#file-uploading) и [поисковых индексах]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore) {{ vector-store-name }} в {{ ai-studio-full-name }}, выполнять чтение таких файлов и поиск по таким индексам, а также просматривать информацию об [облаке]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#cloud) и [каталоге]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#folder).

Включает разрешения, предоставляемые ролями `ai.auditor`, `ai.assistants.viewer`, `ai.datasets.viewer`, `ai.models.viewer` и `ai.guardrails.viewer`.

#### ai.editor {#ai-editor}

Роль `ai.editor` позволяет использовать сервисы {{ translate-full-name }}, {{ vision-full-name }}, {{ speechkit-full-name }} и {{ ai-studio-full-name }}.

Пользователи с этой ролью могут:
* использовать сервис {{ translate-full-name }} для [перевода текста]({{ link-docs-ai }}translate/quickstart);
* использовать сервис {{ vision-full-name }} для [анализа изображений]({{ link-docs-ai }}vision/concepts/ocr/);
* использовать сервис {{ speechkit-full-name }} для [распознавания]({{ link-docs-ai }}speechkit/stt/) и [синтеза]({{ link-docs-ai }}speechkit/tts/) речи;
* просматривать информацию о [моделях генерации текста]({{ link-docs-ai }}ai-studio/concepts/generation/models) {{ ai-studio-full-name }};
* просматривать информацию о [правилах модерации]({{ link-docs-ai }}ai-studio/concepts/security/guardrails#rules) ответов моделей, а также создавать, применять, изменять и удалять такие правила;
* использовать [AI-агентов]({{ link-docs-ai }}ai-studio/concepts/agents/), а также модели генерации текста и изображений, модели [векторного представления текста]({{ link-docs-ai }}ai-studio/concepts/embeddings#yandexgpt-embeddings) и [классификаторов]({{ link-docs-ai }}ai-studio/concepts/classifier/models) в сервисе {{ ai-studio-full-name }};
* просматривать информацию о загруженных [файлах]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore#file-uploading), а также загружать, изменять, просматривать и удалять такие файлы;
* просматривать информацию о [поисковых индексах]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore) {{ vector-store-name }}, создавать, изменять и удалять поисковые индексы, а также выполнять поиск по ним;
* [дообучать]({{ link-docs-ai }}ai-studio/concepts/tuning/#fm-tuning) модели {{ ai-studio-full-name }}, а также создавать, изменять и удалять дообученные модели;
* просматривать информацию о [датасетах]({{ link-docs-ai }}ai-studio/dataset/api-ref/grpc/), использовать их для дообучения моделей, а также создавать, изменять и удалять датасеты;
* просматривать информацию об [облаке]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#cloud) и [каталоге]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#folder);
* просматривать информацию о квотах сервисов [{{ translate-full-name }}]({{ link-docs-ai }}translate/concepts/limits#translate-quotas), [{{ vision-full-name }}]({{ link-docs-ai }}vision/concepts/limits#vision-quotas), [{{ speechkit-full-name }}]({{ link-docs-ai }}speechkit/concepts/limits#speechkit-quotas) и [{{ ai-studio-full-name }}]({{ link-docs-ai }}ai-studio/concepts/limits#yandexgpt-quotas).

Включает разрешения, предоставляемые ролями `ai.viewer`, `ai.translate.user`, `ai.vision.user`, `ai.speechkit-stt.user`, `ai.speechkit-tts.user`, `ai.languageModels.user`, `ai.imageGeneration.user`, `ai.assistants.editor`, `ai.datasets.editor`, `ai.models.editor` и `ai.guardrails.editor`.

#### ai.admin {#ai-admin}

Роль `ai.admin` позволяет использовать сервисы {{ translate-full-name }}, {{ vision-full-name }}, {{ speechkit-full-name }} и {{ ai-studio-full-name }}.

Пользователи с этой ролью могут:
* использовать сервис {{ translate-full-name }} для [перевода текста]({{ link-docs-ai }}translate/quickstart);
* использовать сервис {{ vision-full-name }} для [анализа изображений]({{ link-docs-ai }}vision/concepts/ocr/);
* использовать сервис {{ speechkit-full-name }} для [распознавания]({{ link-docs-ai }}speechkit/stt/) и [синтеза]({{ link-docs-ai }}speechkit/tts/) речи;
* просматривать информацию о [моделях генерации текста]({{ link-docs-ai }}ai-studio/concepts/generation/models) {{ ai-studio-full-name }};
* просматривать информацию о [правилах модерации]({{ link-docs-ai }}ai-studio/concepts/security/guardrails#rules) ответов моделей, а также создавать, применять, изменять и удалять такие правила;
* использовать [AI-агентов]({{ link-docs-ai }}ai-studio/concepts/agents/), а также модели генерации текста и изображений, модели [векторного представления текста]({{ link-docs-ai }}ai-studio/concepts/embeddings#yandexgpt-embeddings) и [классификаторов]({{ link-docs-ai }}ai-studio/concepts/classifier/models) в сервисе {{ ai-studio-full-name }};
* просматривать информацию о загруженных [файлах]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore#file-uploading), а также загружать, изменять, просматривать и удалять такие файлы;
* просматривать информацию о [поисковых индексах]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore) {{ vector-store-name }}, создавать, изменять и удалять поисковые индексы, а также выполнять поиск по ним;
* [дообучать]({{ link-docs-ai }}ai-studio/concepts/tuning/#fm-tuning) модели {{ ai-studio-full-name }}, а также создавать, изменять и удалять дообученные модели;
* просматривать информацию о [датасетах]({{ link-docs-ai }}ai-studio/dataset/api-ref/grpc/), использовать их для дообучения моделей, а также создавать, изменять и удалять датасеты;
* просматривать информацию об [облаке]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#cloud) и [каталоге]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#folder);
* просматривать информацию о квотах сервисов [{{ translate-full-name }}]({{ link-docs-ai }}translate/concepts/limits#translate-quotas), [{{ vision-full-name }}]({{ link-docs-ai }}vision/concepts/limits#vision-quotas), [{{ speechkit-full-name }}]({{ link-docs-ai }}speechkit/concepts/limits#speechkit-quotas) и [{{ ai-studio-full-name }}]({{ link-docs-ai }}ai-studio/concepts/limits#yandexgpt-quotas).

Включает разрешения, предоставляемые ролями `ai.editor`, `ai.assistants.admin`, `ai.datasets.admin`, `ai.models.admin` и `ai.guardrails.admin`.


## Партнерская программа {{ yandex-cloud }} {#partner-program}

#### billing.accounts.owner {#billing-accounts-owner}

Роль `billing.accounts.owner` автоматически выдается при создании платежного аккаунта. Любой пользователь с ролью `billing.accounts.owner` может отозвать эту роль у создателя платежного аккаунта и изменить владельца.

{% cut "В сервисе Yandex Cloud Billing пользователи с этой ролью могут:" %}

* показывать [платежные аккаунты](../billing/concepts/billing-account.md) в списке всех аккаунтов;
* просматривать данные платежных аккаунтов;
* просматривать [коммерческие предложения](../billing/concepts/glossary.md#client-offer);
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к платежным аккаунтам и изменять такие права доступа;
* подключать, отключать, изменять тарифный план [технической поддержки](../support/overview.md), а также изменять платежный аккаунт, с которого будет списываться плата по тарифу;
* просматривать и скачивать [отчетные (закрывающие) документы](../billing/payment/documents.md);
* генерировать новые [акты сверки](../billing/concepts/act.md#reconciliation-report);
* просматривать и скачивать сгенерированные акты сверки;
* получать и просматривать уведомления о потреблении;
* проверять расходы;
* [просматривать детализацию](../billing/operations/check-charges.md);
* создавать [экспорт детализации](../billing/operations/get-folder-report.md);
* создавать [бюджеты](../billing/concepts/budget.md);
* [резервировать потребление ресурсов](../billing/concepts/cvos.md);
* пополнять [лицевой счет](../billing/concepts/personal-account.md) с помощью расчетного счета;
* пополнять лицевой счет с помощью банковской карты;
* привязывать [облака](../resource-manager/concepts/resources-hierarchy.md#cloud) к платежному аккаунту;
* переименовывать платежные аккаунты;
* изменять контакты плательщика;
* изменять платежные реквизиты;
* [изменять](../billing/operations/pin-card.md#change_card) банковскую карту;
* [изменять](../billing/operations/change-payment-method.md) способ оплаты;
* активировать промокоды;
* активировать [пробный период](../billing/concepts/trial-period.md);
* активировать [платную версию](../getting-started/free-trial/concepts/upgrade-to-paid.md);
* [удалять](../billing/operations/delete-account.md) платежные аккаунты.

{% endcut %}

{% cut "На партнерском портале Yandex Cloud пользователи с этой ролью могут:" %}

* [создавать](../partner/operations/pin-client.md#client-entry) записи о клиентах ([сабаккаунты](../partner/terms.md#sub-account));
* просматривать список и данные сабаккаунтов, в т.ч. персональные данные;
* обновлять данные записей о сабаккаунтах;
* активировать сабаккаунты;
* приостанавливать работу сабаккаунтов;
* возобновлять работу сабаккаунтов;
* удалять сабаккаунты (до подтверждения клиентом);
* привязывать [облака](../resource-manager/concepts/resources-hierarchy.md#cloud) к сабаккаунтам;
* [управлять](../partner/operations/access/partners-account.md) назначенными правами доступа к сабаккаунтам;
* [просматривать](../partner/operations/get-client-stat.md) потребление сервисов клиентами;
* просматривать историю начисления [рибейта](../partner/terms.md#rebate);
* выводить рибейт;
* просматривать присвоенные [специализации](../partner/specializations/index.md);
* просматривать историю начисления вознаграждений по [реферальной программе](../partner/program/referral.md);
* выводить [вознаграждение](../partner/program/referral.md#premium) по реферальной программе;
* просматривать статус расчетов с [компанией-реферером](../partner/terms.md#referral-partner);
* просматривать список реферальных ссылок;
* создавать реферальные ссылки;
* активировать реферальные ссылки;
* изменять реферальные ссылки;
* просматривать список [партнерских премий](../partner/portal.md#premium) и информацию о них.

{% endcut %}

Включает разрешения, предоставляемые ролями `billing.accounts.admin` и `billing.accounts.varWithoutDiscounts`.

#### billing.accounts.viewer {#billing-accounts-viewer}

Роль `billing.accounts.viewer` назначается на платежный аккаунт. Позволяет просматривать данные платежного аккаунта, получать информацию о потреблении ресурсов, проверять расходы, выгружать акты сверки и отчетные документы.

{% cut "В сервисе Yandex Cloud Billing пользователи с этой ролью могут:" %}

* показывать [платежные аккаунты](../billing/concepts/billing-account.md) в списке всех аккаунтов;
* просматривать данные платежных аккаунтов;
* просматривать и скачивать [отчетные (закрывающие) документы](../billing/payment/documents.md);
* просматривать и скачивать сгенерированные акты сверки;
* получать и просматривать уведомления о потреблении;
* проверять расходы;
* [просматривать детализацию](../billing/operations/check-charges.md).

{% endcut %}


{% cut "На партнерском портале Yandex Cloud пользователи с этой ролью могут:" %}

* просматривать присвоенные [специализации](../partner/specializations/index.md);
* просматривать историю начисления вознаграждений по [реферальной программе](../partner/program/referral.md);
* просматривать статус расчетов с [компанией-реферером](../partner/terms.md#referral-partner);
* просматривать список реферальных ссылок.

{% endcut %}

#### billing.accounts.accountant {#billing-accounts-accountant}

Роль `billing.accounts.accountant` назначается на платежный аккаунт. Позволяет просматривать данные платежного аккаунта, получать информацию о потреблении ресурсов, проверять расходы, выгружать акты сверки и отчетные документы, создавать новый акт сверки, пополнять лицевой счет с помощью расчетного счета.

{% cut "В сервисе Yandex Cloud Billing пользователи с этой ролью могут:" %}

* показывать [платежные аккаунты](../billing/concepts/billing-account.md) в списке всех аккаунтов;
* просматривать данные платежных аккаунтов;
* просматривать и скачивать [отчетные (закрывающие) документы](../billing/payment/documents.md);
* генерировать новые [акты сверки](../billing/concepts/act.md#reconciliation-report);
* просматривать и скачивать сгенерированные акты сверки;
* получать и просматривать уведомления о потреблении;
* проверять расходы;
* [просматривать детализацию](../billing/operations/check-charges.md);
* пополнять [лицевой счет](../billing/concepts/personal-account.md) с помощью расчетного счета.

{% endcut %}


{% cut "На партнерском портале Yandex Cloud пользователи с этой ролью могут:" %}

* просматривать присвоенные [специализации](../partner/specializations/index.md);
* просматривать историю начисления вознаграждений по [реферальной программе](../partner/program/referral.md);
* просматривать статус расчетов с [компанией-реферером](../partner/terms.md#referral-partner);
* просматривать список реферальных ссылок;
* просматривать историю начисления [рибейта](../partner/terms.md#rebate).

{% endcut %}

Включает разрешения, предоставляемые ролью `billing.accounts.viewer`.

#### billing.accounts.editor {#billing-accounts-editor}

Роль `billing.accounts.editor` назначается на платежный аккаунт. Позволяет получать счета на оплату, активировать промокоды, привязывать облака и сервисы к платежному аккаунту, создавать экспорт детализации, создавать бюджеты, генерировать акты сверки и резервировать ресурсы.

{% cut "В сервисе Yandex Cloud Billing пользователи с этой ролью могут:" %}

* показывать [платежные аккаунты](../billing/concepts/billing-account.md) в списке всех аккаунтов;
* просматривать данные платежных аккаунтов;
* просматривать [коммерческие предложения](../billing/concepts/glossary.md#client-offer);
* просматривать и скачивать [отчетные (закрывающие) документы](../billing/payment/documents.md);
* генерировать новые [акты сверки](../billing/concepts/act.md#reconciliation-report);
* просматривать и скачивать сгенерированные акты сверки;
* получать и просматривать уведомления о потреблении;
* проверять расходы;
* [просматривать детализацию](../billing/operations/check-charges.md);
* создавать [экспорт детализации](../billing/operations/get-folder-report.md);
* создавать [бюджеты](../billing/concepts/budget.md);
* [резервировать потребление ресурсов](../billing/concepts/cvos.md);
* пополнять [лицевой счет](../billing/concepts/personal-account.md) с помощью расчетного счета;
* привязывать [облака](../resource-manager/concepts/resources-hierarchy.md#cloud) к платежному аккаунту;
* переименовывать платежные аккаунты;
* активировать промокоды.

{% endcut %}

{% cut "На партнерском портале Yandex Cloud пользователи с этой ролью могут:" %}

* просматривать историю начисления [рибейта](../partner/terms.md#rebate);
* просматривать присвоенные [специализации](../partner/specializations/index.md);
* просматривать историю начисления вознаграждений по [реферальной программе](../partner/program/referral.md);
* выводить [вознаграждение](../partner/program/referral.md#premium) по реферальной программе;
* просматривать статус расчетов с [компанией-реферером](../partner/terms.md#referral-partner);
* просматривать список реферальных ссылок;
* создавать реферальные ссылки;
* активировать реферальные ссылки;
* изменять реферальные ссылки;
* привязывать [облака](../resource-manager/concepts/resources-hierarchy.md#cloud) к [сабаккаунтам](../partner/terms.md#sub-account).

{% endcut %}

Включает разрешения, предоставляемые ролью `billing.accounts.viewer`.

#### billing.accounts.varWithoutDiscounts {#billing-accounts-var-without-discounts}

Роль `billing.accounts.varWithoutDiscounts` назначается на платежный аккаунт. Предоставляет партнерским аккаунтам все права администратора, кроме возможности получать информацию о скидках.

{% cut "В сервисе Yandex Cloud Billing пользователи с этой ролью могут:" %}

* показывать [платежные аккаунты](../billing/concepts/billing-account.md) в списке всех аккаунтов;
* просматривать данные платежных аккаунтов;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к платежным аккаунтам;
* просматривать и скачивать [отчетные (закрывающие) документы](../billing/payment/documents.md);
* генерировать новые [акты сверки](../billing/concepts/act.md#reconciliation-report);
* просматривать и скачивать сгенерированные акты сверки;
* получать и просматривать уведомления о потреблении;
* проверять расходы;
* [просматривать детализацию](../billing/operations/check-charges.md);
* создавать [экспорт детализации](../billing/operations/get-folder-report.md);
* создавать [бюджеты](../billing/concepts/budget.md);
* [резервировать потребление ресурсов](../billing/concepts/cvos.md);
* пополнять [лицевой счет](../billing/concepts/personal-account.md) с помощью расчетного счета;
* привязывать [облака](../resource-manager/concepts/resources-hierarchy.md#cloud) к платежному аккаунту;
* переименовывать платежные аккаунты;
* активировать промокоды.

{% endcut %}

{% cut "На партнерском портале Yandex Cloud пользователи с этой ролью могут:" %}

* [создавать](../partner/operations/pin-client.md#client-entry) записи о клиентах ([сабаккаунты](../partner/terms.md#sub-account));
* просматривать список и данные сабаккаунтов;
* активировать сабаккаунты;
* приостанавливать работу сабаккаунтов;
* возобновлять работу сабаккаунтов;
* привязывать [облака](../resource-manager/concepts/resources-hierarchy.md#cloud) к сабаккаунтам;
* [управлять](../partner/operations/access/partners-account.md) назначенными правами доступа к сабаккаунтам;
* просматривать историю начисления [рибейта](../partner/terms.md#rebate);
* выводить рибейт;
* просматривать историю начисления вознаграждений по [реферальной программе](../partner/program/referral.md);
* выводить [вознаграждение](../partner/program/referral.md#premium) по реферальной программе;
* просматривать статус расчетов с [компанией-реферером](../partner/terms.md#referral-partner);
* создавать реферальные ссылки;
* активировать реферальные ссылки;
* изменять реферальные ссылки;
* [просматривать](../partner/operations/get-client-stat.md) потребление сервисов клиентами.

{% endcut %}

Включает разрешения, предоставляемые ролью `billing.partners.editor`.

#### billing.accounts.admin {#billing-accounts-admin}

Роль `billing.accounts.admin` назначается на платежный аккаунт и позволяет управлять доступами к платежному аккаунту (кроме роли `billing.accounts.owner`).

{% cut "В сервисе Yandex Cloud Billing пользователи с этой ролью могут:" %}

* показывать [платежные аккаунты](../billing/concepts/billing-account.md) в списке всех аккаунтов;
* просматривать данные платежных аккаунтов;
* просматривать [коммерческие предложения](../billing/concepts/glossary.md#client-offer);
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к платежным аккаунтам и изменять такие права доступа (за исключением назначения и отзыва роли `billing.accounts.owner`);
* подключать, отключать, изменять тарифный план [технической поддержки](../support/overview.md), а также изменять платежный аккаунт, с которого будет списываться плата по тарифу;
* просматривать и скачивать [отчетные (закрывающие) документы](../billing/payment/documents.md);
* генерировать новые [акты сверки](../billing/concepts/act.md#reconciliation-report);
* просматривать и скачивать сгенерированные акты сверки;
* получать и просматривать уведомления о потреблении;
* проверять расходы;
* [просматривать детализацию](../billing/operations/check-charges.md);
* создавать [экспорт детализации](../billing/operations/get-folder-report.md);
* создавать [бюджеты](../billing/concepts/budget.md);
* [резервировать потребление ресурсов](../billing/concepts/cvos.md);
* пополнять [лицевой счет](../billing/concepts/personal-account.md) с помощью расчетного счета;
* привязывать [облака](../resource-manager/concepts/resources-hierarchy.md#cloud) к платежному аккаунту;
* переименовывать платежные аккаунты;
* активировать промокоды.

{% endcut %}

{% cut "На партнерском портале Yandex Cloud пользователи с этой ролью могут:" %}

* [создавать](../partner/operations/pin-client.md#client-entry) записи о клиентах ([сабаккаунты](../partner/terms.md#sub-account));
* просматривать список и данные сабаккаунтов, включая персональные данные;
* активировать сабаккаунты;
* приостанавливать работу сабаккаунтов;
* возобновлять работу сабаккаунтов;
* привязывать [облака](../resource-manager/concepts/resources-hierarchy.md#cloud) к сабаккаунтам;
* [управлять](../partner/operations/access/partners-account.md) назначенными правами доступа к сабаккаунтам;
* [просматривать](../partner/operations/get-client-stat.md) потребление сервисов клиентами;
* просматривать историю начисления [рибейта](../partner/terms.md#rebate);
* выводить рибейт;
* просматривать присвоенные [специализации](../partner/specializations/index.md);
* просматривать историю начисления вознаграждений по [реферальной программе](../partner/program/referral.md);
* выводить [вознаграждение](../partner/program/referral.md#premium) по реферальной программе;
* просматривать статус расчетов с [компанией-реферером](../partner/terms.md#referral-partner);
* просматривать список реферальных ссылок;
* создавать реферальные ссылки;
* активировать реферальные ссылки;
* изменять реферальные ссылки;
* просматривать список [партнерских премий](../partner/portal.md#premium) и информацию о них.

{% endcut %}

Включает разрешения, предоставляемые ролями `billing.accounts.editor`, `billing.accounts.partnerAdmin` и `billing.partners.editor`.

#### billing.accounts.partnerViewer {#billing-accounts-partnerViewer}

Роль `billing.accounts.partnerViewer` назначается на платежный аккаунт и позволяет просматривать данные партнера, за исключением персональных данных.

На партнерском портале Yandex Cloud пользователи с этой ролью могут:
* просматривать список [сабаккаунтов](../partner/terms.md#sub-account) и информацию о них (кроме персональных данных);
* просматривать список [партнерских премий](../partner/terms.md#partner-award);
* просматривать страницу с [инструментами партнера](../partner/program/var-tools.md);
* просматривать список аккаунтов и информацию о них (кроме персональных данных);
* просматривать список контактов и информацию о них (кроме персональных данных);
* просматривать список [партнерских сделок](../partner/terms.md#deal-reg) и информацию о них (кроме персональных данных).

#### billing.accounts.piiPartnerViewer {#billing-accounts-piiPartnerViewer}

Роль `billing.accounts.piiPartnerViewer` назначается на платежный аккаунт и позволяет просматривать данные сабаккаунта и партнера, включая персональные данные.

На партнерском портале Yandex Cloud пользователи с этой ролью могут:
* просматривать информацию о балансе, начислениях и выводе [рибейта](../partner/terms.md#rebate) партнера;
* [просматривать](../partner/operations/get-client-stat.md) детализацию потребления партнера, в т.ч. в его [сабаккаунтах](../partner/terms.md#sub-account);
* просматривать список [партнерских премий](../partner/terms.md#partner-award);
* просматривать страницу с [инструментами партнера](../partner/program/var-tools.md);
* просматривать список аккаунтов и информацию о них, в т.ч. персональные данные;
* просматривать список сабаккаунтов и информацию о них, в т.ч. персональные данные;
* просматривать список контактов и информацию о них, в т.ч. персональные данные;
* просматривать список [партнерских сделок](../partner/terms.md#deal-reg) и информацию о них, в т.ч. персональные данные.

Включает разрешения, предоставляемые ролью `billing.accounts.partnerViewer`.

#### billing.accounts.partnerEditor {#billing-accounts-partnerEditor}

Роль `billing.accounts.partnerEditor` назначается на платежный аккаунт и позволяет управлять аккаунтами, сабаккаунтами, контактами и партнерскими сделками. Роль не предоставляет доступа к персональным данным.

На партнерском портале Yandex Cloud пользователи с этой ролью могут:
* управлять [сабаккаунтами](../partner/terms.md#sub-account) в обход [прав доступа](concepts/access-control/index.md), назначенных на уровне [организации](../organization/concepts/organization.md), за исключением подтверждения права на работу с партнером;
* просматривать список сабаккаунтов и информацию о них (кроме персональных данных);
* создавать новые и обновлять данные в существующих сабаккаунтах, а также приостанавливать и возобновлять работу сабаккаунтов и удалять их;
* просматривать список аккаунтов и информацию о них (кроме персональных данных), изменять информацию об аккаунтах;
* просматривать список контактов и информацию о них (кроме персональных данных), изменять данные контактов;
* просматривать список [партнерских сделок](../partner/terms.md#deal-reg) и информацию о них (кроме персональных данных), а также изменять данные о партнерских сделках;
* просматривать список [партнерских премий](../partner/terms.md#partner-award);
* просматривать страницу с [инструментами партнера](../partner/program/var-tools.md).

Включает разрешения, предоставляемые ролью `billing.accounts.partnerViewer`.

#### billing.accounts.piiPartnerEditor {#billing-accounts-piiPartnerEditor}

Роль `billing.accounts.piiPartnerEditor` назначается на платежный аккаунт и позволяет управлять выводом рибейта партнера, а также просматривать данные сабаккаунтов и партнеров, включая персональные данные.

На партнерском портале Yandex Cloud пользователи с этой ролью могут:
* просматривать информацию о балансе, начислениях и выводе [рибейта](../partner/terms.md#rebate) партнера;
* создавать расходные договоры для рибейтов и выводить начисленный рибейт партнера;
* [просматривать](../partner/operations/get-client-stat.md) детализацию потребления партнера, в т.ч. в его [сабаккаунтах](../partner/terms.md#sub-account);
* просматривать список [партнерских премий](../partner/terms.md#partner-award);
* просматривать страницу с [инструментами партнера](../partner/program/var-tools.md);
* просматривать список аккаунтов и информацию о них, в т.ч. персональные данные;
* просматривать список сабаккаунтов и информацию о них, в т.ч. персональные данные;
* просматривать список контактов и информацию о них, в т.ч. персональные данные;
* просматривать список [партнерских сделок](../partner/terms.md#deal-reg) и информацию о них, в т.ч. персональные данные.

Включает разрешения, предоставляемые ролью `billing.accounts.piiPartnerViewer`.

#### billing.accounts.partnerAdmin {#billing-accounts-partnerAdmin}

Роль `billing.accounts.partnerAdmin` назначается на платежный аккаунт и предоставляет полный доступ ко всем инструментам партнерского портала и всей информации, хранящейся на партнерском портале, включая персональные данные.

На партнерском портале Yandex Cloud пользователи с этой ролью могут:
* управлять [сабаккаунтами](../partner/terms.md#sub-account) в обход [прав доступа](concepts/access-control/index.md), назначенных на уровне [организации](../organization/concepts/organization.md), за исключением подтверждения права на работу с партнером;
* просматривать список сабаккаунтов и информацию о них, включая персональные данные;
* создавать новые и обновлять данные в существующих сабаккаунтах, а также приостанавливать и возобновлять работу сабаккаунтов и удалять их;
* просматривать список аккаунтов и информацию о них, включая персональные данные, изменять информацию об аккаунтах;
* просматривать список контактов и информацию о них, включая персональные данные, изменять данные контактов;
* просматривать список [партнерских сделок](../partner/terms.md#deal-reg) и информацию о них, включая персональные данные, а также изменять данные о партнерских сделках;
* просматривать информацию о балансе, начислениях и выводе [рибейта](../partner/terms.md#rebate) партнера;
* создавать расходные договоры для рибейтов и выводить начисленный рибейт партнера;
* [просматривать](../partner/operations/get-client-stat.md) детализацию потребления партнера, в т.ч. в его сабаккаунтах;
* просматривать список [партнерских премий](../partner/terms.md#partner-award);
* просматривать страницу с [инструментами партнера](../partner/program/var-tools.md).

Включает разрешения, предоставляемые ролями `billing.accounts.partnerEditor` и `billing.accounts.piiPartnerEditor`.

Подробнее см. [Управление доступом в партнерской программе {{ yandex-cloud }}](../partner/security/index.md).


## {{ ai-studio-full-name }} {#fm-roles}

#### ai.playground.user {#ai-playground-user}

Роль `ai.playground.user` позволяет создавать эксперименты, получать список всех доступных моделей и использовать их в {{ ai-playground }} в консоли управления {{ yandex-cloud }}. Для работы с поисковыми индексами в консоли управления дополнительно необходима роль `ai.assistants.editor`.

#### ai.languageModels.user {#languageModels-user}

Роль `ai.languageModels.user` позволяет использовать модели [генерации текста]({{ link-docs-ai }}ai-studio/concepts/generation/models), [векторного представления текста]({{ link-docs-ai }}ai-studio/concepts/embeddings#yandexgpt-embeddings) и [классификаторов]({{ link-docs-ai }}ai-studio/concepts/classifier/models) в сервисе {{ ai-studio-full-name }}, а также просматривать информацию об [облаке]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#cloud), [каталоге]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#folder) и [квотах]({{ link-docs-ai }}ai-studio/concepts/limits#yandexgpt-quotas) сервиса.

#### ai.imageGeneration.user {#imageGeneration-user}

Роль `ai.imageGeneration.user` позволяет использовать модели генерации изображений YandexART в сервисе {{ ai-studio-full-name }}, а также просматривать информацию об [облаке]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#cloud), [каталоге]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#folder) и [квотах]({{ link-docs-ai }}ai-studio/concepts/limits#yandexgpt-quotas) сервиса.

#### ai.assistants.auditor {#ai-assistants-auditor}

Роль `ai.assistants.auditor` позволяет просматривать информацию о загруженных [файлах]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore#file-uploading) и [поисковых индексах]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore) {{ vector-store-name }}, а также о [квотах]({{ link-docs-ai }}ai-studio/concepts/limits#yandexgpt-quotas) сервиса {{ ai-studio-full-name }}, об [облаке]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#cloud) и [каталоге]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#folder).

#### ai.assistants.viewer {#ai-assistants-viewer}

Роль `ai.assistants.viewer` позволяет просматривать информацию о файлах и поисковых индексах {{ vector-store-name }}, а также выполнять поиск по таким индексам.

Пользователи с этой ролью могут:
* просматривать информацию о загруженных [файлах]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore#file-uploading) и содержимое таких файлов;
* просматривать информацию о [поисковых индексах]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore) {{ vector-store-name }}, а также выполнять поиск по таким индексам;
* просматривать информацию о [квотах]({{ link-docs-ai }}ai-studio/concepts/limits#yandexgpt-quotas) сервиса {{ ai-studio-full-name }};
* просматривать информацию об [облаке]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#cloud);
* просматривать информацию о [каталоге]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#folder).

Включает разрешения, предоставляемые ролью `ai.assistants.auditor`.

#### ai.assistants.editor {#ai-assistants-editor}

Роль `ai.assistants.editor` позволяет использовать AI-агентов, а также управлять файлами и поисковыми индексами {{ vector-store-name }}.

Пользователи с этой ролью могут:
* использовать [AI-агентов]({{ link-docs-ai }}ai-studio/concepts/agents/);
* просматривать информацию о загруженных [файлах]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore#file-uploading), а также загружать, изменять, просматривать и удалять такие файлы;
* просматривать информацию о [поисковых индексах]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore) {{ vector-store-name }}, создавать, изменять и удалять поисковые индексы, а также выполнять поиск по ним;
* просматривать информацию о [квотах]({{ link-docs-ai }}ai-studio/concepts/limits#yandexgpt-quotas) сервиса {{ ai-studio-full-name }};
* просматривать информацию об [облаке]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#cloud);
* просматривать информацию о [каталоге]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#folder).

Включает разрешения, предоставляемые ролью `ai.assistants.viewer`.

#### ai.assistants.admin {#ai-assistants-admin}

Роль `ai.assistants.admin` позволяет использовать AI-агентов, а также управлять файлами и поисковыми индексами {{ vector-store-name }}.

Пользователи с этой ролью могут:
* использовать [AI-агентов]({{ link-docs-ai }}ai-studio/concepts/agents/);
* просматривать информацию о загруженных [файлах]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore#file-uploading), а также загружать, изменять, просматривать и удалять такие файлы;
* просматривать информацию о [поисковых индексах]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore) {{ vector-store-name }}, создавать, изменять и удалять поисковые индексы, а также выполнять поиск по ним;
* просматривать информацию о [квотах]({{ link-docs-ai }}ai-studio/concepts/limits#yandexgpt-quotas) сервиса {{ ai-studio-full-name }};
* просматривать информацию об [облаке]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#cloud);
* просматривать информацию о [каталоге]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#folder).

Включает разрешения, предоставляемые ролью `ai.assistants.editor`.

#### ai.datasets.auditor {#ai-datasets-auditor}

Роль `ai.datasets.auditor` позволяет просматривать метаданные [датасетов]({{ link-docs-ai }}ai-studio/dataset/api-ref/grpc/).

#### ai.datasets.viewer {#ai-datasets-viewer}

Роль `ai.datasets.viewer` позволяет просматривать информацию о [датасетах]({{ link-docs-ai }}ai-studio/dataset/api-ref/grpc/).

Включает разрешения, предоставляемые ролью `ai.datasets.auditor`.

#### ai.datasets.user {#ai-datasets-user}

Роль `ai.datasets.user` позволяет просматривать информацию о [датасетах]({{ link-docs-ai }}ai-studio/dataset/api-ref/grpc/) и использовать их для [дообучения]({{ link-docs-ai }}ai-studio/concepts/tuning/#fm-tuning) моделей в {{ ai-studio-name }}.

Включает разрешения, предоставляемые ролью `ai.datasets.viewer`.

#### ai.datasets.editor {#ai-datasets-editor}

Роль `ai.datasets.editor` позволяет просматривать информацию о [датасетах]({{ link-docs-ai }}ai-studio/dataset/api-ref/grpc/), создавать, изменять и удалять датасеты, а также использовать их для [дообучения]({{ link-docs-ai }}ai-studio/concepts/tuning/#fm-tuning) моделей в {{ ai-studio-name }}.

Включает разрешения, предоставляемые ролью `ai.datasets.user`.

#### ai.datasets.admin {#ai-datasets-admin}

Роль `ai.datasets.admin` позволяет просматривать информацию о [датасетах]({{ link-docs-ai }}ai-studio/dataset/api-ref/grpc/), создавать, изменять и удалять датасеты, а также использовать их для [дообучения]({{ link-docs-ai }}ai-studio/concepts/tuning/#fm-tuning) моделей в {{ ai-studio-name }}.

Включает разрешения, предоставляемые ролью `ai.datasets.editor`.

#### ai.models.auditor {#ai-models-auditor}

Роль `ai.models.auditor` позволяет просматривать метаданные [моделей генерации текста]({{ link-docs-ai }}ai-studio/concepts/generation/models) {{ ai-studio-full-name }}.

#### ai.models.viewer {#ai-models-viewer}

Роль `ai.models.viewer` позволяет просматривать информацию о [моделях генерации текста]({{ link-docs-ai }}ai-studio/concepts/generation/models) {{ ai-studio-full-name }}.

Включает разрешения, предоставляемые ролью `ai.models.auditor`.

#### ai.models.user {#ai-models-user}

Роль `ai.models.user` позволяет использовать AI-агентов и модели генерации текста и изображений, векторного представления текста и классификаторов в {{ ai-studio-full-name }}, а также использовать сервисы {{ translate-full-name }}, {{ vision-full-name }} и {{ speechkit-full-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о [моделях генерации текста]({{ link-docs-ai }}ai-studio/concepts/generation/models) {{ ai-studio-full-name }};
* использовать [AI-агентов]({{ link-docs-ai }}ai-studio/concepts/agents/), а также модели генерации текста и изображений, модели [векторного представления текста]({{ link-docs-ai }}ai-studio/concepts/embeddings#yandexgpt-embeddings) и [классификаторов]({{ link-docs-ai }}ai-studio/concepts/classifier/models) в сервисе {{ ai-studio-full-name }};
* использовать сервис {{ translate-full-name }} для [перевода текста]({{ link-docs-ai }}translate/quickstart);
* использовать сервис {{ vision-full-name }} для [анализа изображений]({{ link-docs-ai }}vision/concepts/ocr/);
* использовать сервис {{ speechkit-full-name }} для [распознавания]({{ link-docs-ai }}speechkit/stt/) и [синтеза]({{ link-docs-ai }}speechkit/tts/) речи.

Включает разрешения, предоставляемые ролью `ai.models.viewer`.

#### ai.models.editor {#ai-models-editor}

Роль `ai.models.editor` позволяет управлять дообучением моделей {{ ai-studio-full-name }}, а также использовать сервисы {{ translate-full-name }}, {{ vision-full-name }}, {{ speechkit-full-name }} и {{ ai-studio-full-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о [моделях генерации текста]({{ link-docs-ai }}ai-studio/concepts/generation/models) {{ ai-studio-full-name }};
* [дообучать]({{ link-docs-ai }}ai-studio/concepts/tuning/#fm-tuning) модели {{ ai-studio-full-name }}, а также создавать, изменять и удалять дообученные модели;
* использовать [AI-агентов]({{ link-docs-ai }}ai-studio/concepts/agents/), а также модели генерации текста и изображений, модели [векторного представления текста]({{ link-docs-ai }}ai-studio/concepts/embeddings#yandexgpt-embeddings) и [классификаторов]({{ link-docs-ai }}ai-studio/concepts/classifier/models) в сервисе {{ ai-studio-full-name }};
* использовать сервис {{ translate-full-name }} для [перевода текста]({{ link-docs-ai }}translate/quickstart);
* использовать сервис {{ vision-full-name }} для [анализа изображений]({{ link-docs-ai }}vision/concepts/ocr/);
* использовать сервис {{ speechkit-full-name }} для [распознавания]({{ link-docs-ai }}speechkit/stt/) и [синтеза]({{ link-docs-ai }}speechkit/tts/) речи.

Включает разрешения, предоставляемые ролью `ai.models.user`.

#### ai.models.admin {#ai-models-admin}

Роль `ai.models.admin` позволяет управлять дообучением моделей {{ ai-studio-full-name }}, а также использовать сервисы {{ translate-full-name }}, {{ vision-full-name }}, {{ speechkit-full-name }} и {{ ai-studio-full-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о [моделях генерации текста]({{ link-docs-ai }}ai-studio/concepts/generation/models) {{ ai-studio-full-name }};
* [дообучать]({{ link-docs-ai }}ai-studio/concepts/tuning/#fm-tuning) модели {{ ai-studio-full-name }}, а также создавать, изменять и удалять дообученные модели;
* использовать [AI-агентов]({{ link-docs-ai }}ai-studio/concepts/agents/), а также модели генерации текста и изображений, модели [векторного представления текста]({{ link-docs-ai }}ai-studio/concepts/embeddings#yandexgpt-embeddings) и [классификаторов]({{ link-docs-ai }}ai-studio/concepts/classifier/models) в сервисе {{ ai-studio-full-name }};
* использовать сервис {{ translate-full-name }} для [перевода текста]({{ link-docs-ai }}translate/quickstart);
* использовать сервис {{ vision-full-name }} для [анализа изображений]({{ link-docs-ai }}vision/concepts/ocr/);
* использовать сервис {{ speechkit-full-name }} для [распознавания]({{ link-docs-ai }}speechkit/stt/) и [синтеза]({{ link-docs-ai }}speechkit/tts/) речи.

Включает разрешения, предоставляемые ролью `ai.models.editor`.

#### ai.guardrails.auditor {#ai-guardrails-auditor}

Роль `ai.guardrails.auditor` позволяет просматривать метаданные [правил модерации]({{ link-docs-ai }}ai-studio/concepts/security/guardrails#rules) ответов моделей.

#### ai.guardrails.viewer {#ai-guardrails-viewer}

Роль `ai.guardrails.viewer` позволяет просматривать информацию о [правилах модерации]({{ link-docs-ai }}ai-studio/concepts/security/guardrails#rules) ответов моделей.

Включает разрешения, предоставляемые ролью `ai.guardrails.auditor`.

#### ai.guardrails.user {#ai-guardrails-user}

Роль `ai.guardrails.user` позволяет применять [правила модерации]({{ link-docs-ai }}ai-studio/concepts/security/guardrails#rules) ответов моделей и просматривать метаданные таких правил.

#### ai.guardrails.editor {#ai-guardrails-editor}

Роль `ai.guardrails.editor` позволяет просматривать информацию о [правилах модерации]({{ link-docs-ai }}ai-studio/concepts/security/guardrails#rules) ответов моделей, а также создавать, применять, изменять и удалять такие правила.

Включает разрешения, предоставляемые ролями `ai.guardrails.viewer` и `ai.guardrails.user`.

#### ai.guardrails.admin {#ai-guardrails-admin}

Роль `ai.guardrails.admin` позволяет просматривать информацию о [правилах модерации]({{ link-docs-ai }}ai-studio/concepts/security/guardrails#rules) ответов моделей, а также создавать, применять, изменять и удалять такие правила.

Включает разрешения, предоставляемые ролью `ai.guardrails.editor`.

#### serverless.mcpGateways.auditor {#serverless-mcpGateways-auditor}

Роль `serverless.mcpGateways.auditor` позволяет просматривать информацию об [MCP-серверах]({{ link-docs-ai }}ai-studio/concepts/mcp-hub/#servers) и назначенных [правах доступа]({{ link-docs }}/iam/concepts/access-control/roles) к ним.

#### serverless.mcpGateways.viewer {#serverless-mcpGateways-viewer}

Роль `serverless.mcpGateways.viewer` позволяет просматривать информацию об [MCP-серверах]({{ link-docs-ai }}ai-studio/concepts/mcp-hub/#servers) и назначенных [правах доступа]({{ link-docs }}/iam/concepts/access-control/roles) к ним.

Включает разрешения, предоставляемые ролью `serverless.mcpGateways.auditor`.

#### serverless.mcpGateways.invoker {#serverless-mcpGateways-invoker}

Роль `serverless.mcpGateways.invoker` позволяет обращаться к [MCP-серверам]({{ link-docs-ai }}ai-studio/concepts/mcp-hub/#servers), в том числе через MCP Hub.

#### serverless.mcpGateways.anonymousInvoker {#serverless-mcpGateways-anonymousInvoker}

Роль `serverless.mcpGateways.anonymousInvoker` позволяет обращаться к [MCP-серверам]({{ link-docs-ai }}ai-studio/concepts/mcp-hub/#servers), в том числе через MCP Hub.

#### serverless.mcpGateways.editor {#serverless-mcpGateways-editor}

Роль `serverless.mcpGateways.editor` позволяет создавать, изменять и удалять [MCP-серверы]({{ link-docs-ai }}ai-studio/concepts/mcp-hub/#servers), просматривать информацию о них и назначенных [правах доступа]({{ link-docs }}/iam/concepts/access-control/roles) к ним.

Включает разрешения, предоставляемые ролью `serverless.mcpGateways.viewer`.

#### serverless.mcpGateways.admin {#serverless-mcpGateways-admin}

Роль `serverless.mcpGateways.admin` позволяет управлять MCP-серверами и доступом к ним.

Пользователи с этой ролью могут:
* просматривать информацию об [MCP-серверах]({{ link-docs-ai }}ai-studio/concepts/mcp-hub/#servers), а также создавать, изменять и удалять их;
* просматривать информацию о назначенных [правах доступа]({{ link-docs }}/iam/concepts/access-control/roles) к MCP-серверам, а также изменять такие права доступа;
* обращаться через MCP Hub к MCP-серверам, в том числе внешним.

Включает разрешения, предоставляемые ролями `serverless.mcpGateways.editor`, `serverless.mcpGateways.invoker` и `serverless.mcpGateways.anonymousInvoker`.

Подробнее см. [Управление доступом в {{ ai-studio-full-name }}]({{ link-docs-ai }}ai-studio/security/index).


## {{ api-gw-full-name }} {#api-gateway-roles}

#### api-gateway.auditor {#api-gateway-auditor}

Роль `api-gateway.auditor` позволяет просматривать список [API-шлюзов](../api-gateway/concepts/index.md) и информацию о назначенных [правах доступа](concepts/access-control/index.md) к ним, а также метаинформацию [каталога](../resource-manager/concepts/resources-hierarchy.md#folder).

#### api-gateway.viewer {#api-gateway-viewer}

Роль `api-gateway.viewer` позволяет просматривать список [API-шлюзов](../api-gateway/concepts/index.md), информацию о них и о назначенных [правах доступа](concepts/access-control/index.md) к ним, а также информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `api-gateway.auditor`.

#### api-gateway.editor {#api-gateway-editor}

Роль `api-gateway.editor` позволяет просматривать информацию об API-шлюзах и управлять ими, а также работать с API WebSocket.

Пользователи с этой ролью могут:
* просматривать список [API-шлюзов](../api-gateway/concepts/index.md), информацию о них и о назначенных [правах доступа](concepts/access-control/index.md) к ним, а также создавать, изменять и удалять API-шлюзы;
* использовать ограничение [скорости обработки запросов](../api-gateway/concepts/extensions/rate-limit.md);
* просматривать информацию о соединениях [WebSocket](../api-gateway/concepts/index.md#websocket) и закрывать их, а также отправлять данные через такие соединения;
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `api-gateway.websocketWriter`.

#### api-gateway.websocketWriter {#api-gateway-websocketwriter}

Роль `api-gateway.websocketWriter` позволяет работать с API WebSocket, а также просматривать список API-шлюзов, информацию о них и о назначенных правах доступа к ним.

Пользователи с этой ролью могут:
* просматривать информацию о соединениях [WebSocket](../api-gateway/concepts/index.md#websocket) и закрывать их, а также отправлять данные через такие соединения;
* просматривать список [API-шлюзов](../api-gateway/concepts/index.md), информацию о них и о назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `api-gateway.viewer`.

#### api-gateway.websocketBroadcaster {#api-gateway-websocketBroadcaster}

Роль `api-gateway.websocketBroadcaster` позволяет отправлять данные через соединения WebSocket, в том числе одновременно нескольким клиентам, а также просматривать список API-шлюзов, информацию о них и о назначенных правах доступа к ним.

Пользователи с этой ролью могут:
* просматривать информацию о соединениях [WebSocket](../api-gateway/concepts/index.md#websocket) и закрывать их, а также отправлять данные через соединения WebSocket, в том числе одновременно нескольким клиентам;
* просматривать список [API-шлюзов](../api-gateway/concepts/index.md), информацию о них и о назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `api-gateway.websocketWriter`.

#### api-gateway.admin {#api-gateway-admin}

Роль `api-gateway.admin` позволяет управлять API-шлюзами и доступом к ним, просматривать информацию об API-шлюзах, а также работать с API WebSocket.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к API-шлюзам и изменять такие права доступа;
* просматривать список [API-шлюзов](../api-gateway/concepts/index.md) и информацию о них, а также создавать, изменять и удалять API-шлюзы;
* просматривать информацию о соединениях [WebSocket](../api-gateway/concepts/index.md#websocket) и закрывать их, а также отправлять данные через такие соединения;
* использовать ограничение [скорости обработки запросов](../api-gateway/concepts/extensions/rate-limit.md);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `api-gateway.editor`.

Подробнее см. [{#T}](../api-gateway/security/index.md).


## {{ alb-full-name }} {#alb-roles}

#### alb.auditor {#alb-auditor}

Роль `alb.auditor` позволяет просматривать информацию о ресурсах и квотах сервиса {{ alb-name }}.

Пользователи с этой ролью могут:
* просматривать список [L7-балансировщиков](../application-load-balancer/concepts/application-load-balancer.md) и информацию о них;
* просматривать список [HTTP-роутеров](../application-load-balancer/concepts/http-router.md) и информацию о них;
* просматривать список [виртуальных хостов](../application-load-balancer/concepts/http-router.md#virtual-host) и информацию о них;
* просматривать список [групп бэкендов](../application-load-balancer/concepts/backend-group.md) и информацию о них;
* просматривать список [целевых групп](../application-load-balancer/concepts/target-group.md) и информацию о них;
* просматривать информацию о [квотах](../application-load-balancer/concepts/limits.md#quotas) сервиса {{ alb-name }}.

#### alb.viewer {#alb-viewer}

Роль `alb.viewer` позволяет просматривать список ресурсов {{ alb-name }} и информацию о них и о квотах сервиса. 

Пользователи с этой ролью могут:
* просматривать список [L7-балансировщиков](../application-load-balancer/concepts/application-load-balancer.md) и информацию о них;
* просматривать список [HTTP-роутеров](../application-load-balancer/concepts/http-router.md) и информацию о них;
* просматривать список [виртуальных хостов](../application-load-balancer/concepts/http-router.md#virtual-host) и информацию о них;
* просматривать список [групп бэкендов](../application-load-balancer/concepts/backend-group.md) и информацию о них;
* просматривать список [целевых групп](../application-load-balancer/concepts/target-group.md) и информацию о них;
* просматривать информацию о [квотах](../application-load-balancer/concepts/limits.md#quotas) сервиса {{ alb-name }}.

Включает разрешения, предоставляемые ролью `alb.auditor`.

#### alb.user {#alb-user}

Роль `alb.user` позволяет использовать L7-балансировщики, HTTP-роутеры, группы бэкендов и целевые группы, а также просматривать информацию о ресурсах сервиса {{ alb-name }}. 

Пользователи с этой ролью могут:
* просматривать список [L7-балансировщиков](../application-load-balancer/concepts/application-load-balancer.md) и информацию о них, а также использовать L7-балансировщики;
* просматривать список [HTTP-роутеров](../application-load-balancer/concepts/http-router.md) и информацию о них, а также использовать HTTP-роутеры;
* просматривать список [виртуальных хостов](../application-load-balancer/concepts/http-router.md#virtual-host) и информацию о них;
* просматривать список [групп бэкендов](../application-load-balancer/concepts/backend-group.md) и информацию о них, а также использовать группы бэкендов;
* просматривать список [целевых групп](../application-load-balancer/concepts/target-group.md) и информацию о них, а также использовать целевые группы;
* просматривать информацию о [квотах](../application-load-balancer/concepts/limits.md#quotas) сервиса {{ alb-name }}.

Роль можно назначить на каталог.

#### alb.editor {#alb-editor}

Роль `alb.editor` позволяет управлять ресурсами сервиса {{ alb-name }} и внутренними сетевыми балансировщиками нагрузки, а также просматривать информацию о них и об облачных сетях, подсетях, таблицах маршрутизации, шлюзах, группах безопасности и IP-адресах.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать список [L7-балансировщиков](../application-load-balancer/concepts/application-load-balancer.md) и информацию о них, а также создавать L7-балансировщики, изменять, удалять и использовать их;
* просматривать список [HTTP-роутеров](../application-load-balancer/concepts/http-router.md) и информацию о них, а также создавать, изменять, удалять и использовать HTTP-роутеры;
* просматривать список [виртуальных хостов](../application-load-balancer/concepts/http-router.md#virtual-host) и информацию о них, а также изменять виртуальные хосты;
* просматривать список [групп бэкендов](../application-load-balancer/concepts/backend-group.md) и информацию о них, а также создавать, изменять, удалять и использовать группы бэкендов;
* просматривать список целевых групп L7-балансировщиков и [сетевых балансировщиков](../network-load-balancer/concepts/target-resources.md) и информацию о них, а также создавать, изменять, удалять и использовать целевые группы;
* просматривать список [сетевых балансировщиков](../network-load-balancer/concepts/index.md) и информацию о них, а также создавать внутренние сетевые балансировщики (в т.ч. с UDP-обработчиком), изменять, удалять, запускать и останавливать их;
* просматривать список [облачных сетей](../vpc/concepts/network.md#network) и информацию о них, а также использовать облачные сети;
* просматривать список [подсетей](../vpc/concepts/network.md#subnet) и информацию о них, а также использовать подсети;
* просматривать список [адресов облачных ресурсов](../vpc/concepts/address.md) и информацию о них, а также использовать адреса;
* просматривать список [таблиц маршрутизации](../vpc/concepts/routing.md#rt-vpc) и информацию о них, а также использовать таблицы маршрутизации;
* просматривать список [групп безопасности](../vpc/concepts/security-groups.md) и информацию о них, а также использовать группы безопасности;
* просматривать информацию о [NAT-шлюзах](../vpc/concepts/gateways.md) и подключать их к таблицам маршрутизации;
* просматривать информацию об использованных IP-адресах в подсетях, а также создавать [внутренние адреса](../vpc/concepts/address.md#internal-addresses);
* просматривать информацию об операциях с ресурсами сервисов {{ vpc-name }} и {{ compute-name }};
* просматривать список операций с ресурсами сервиса {{ network-load-balancer-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder);
* просматривать информацию о квотах сервисов [{{ alb-name }}](../application-load-balancer/concepts/limits.md#quotas), [{{ network-load-balancer-name }}](../network-load-balancer/concepts/limits.md#load-balancer-quotas) и [{{ vpc-name }}](../vpc/concepts/limits.md#vpc-quotas).

{% endcut %}

Включает разрешения, предоставляемые ролями `load-balancer.privateAdmin` и `vpc.user`.

Для подключения публичного IP-адреса к новому или существующему L7-балансировщику дополнительно необходима [роль](../vpc/security/index.md#vpc-public-admin) `vpc.publicAdmin` на сеть, в которой находится балансировщик.

#### alb.admin {#alb-admin}

Роль `alb.admin` позволяет управлять ресурсами сервиса {{ alb-name }} и внутренними сетевыми балансировщиками нагрузки, а также просматривать информацию об облачных сетях, подсетях, таблицах маршрутизации, шлюзах, группах безопасности, IP-адресах и квотах.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать список [L7-балансировщиков](../application-load-balancer/concepts/application-load-balancer.md) и информацию о них, а также создавать L7-балансировщики, изменять, удалять и использовать их;
* просматривать список [HTTP-роутеров](../application-load-balancer/concepts/http-router.md) и информацию о них, а также создавать, изменять, удалять и использовать HTTP-роутеры;
* просматривать список [виртуальных хостов](../application-load-balancer/concepts/http-router.md#virtual-host) и информацию о них, а также изменять виртуальные хосты;
* просматривать список [групп бэкендов](../application-load-balancer/concepts/backend-group.md) и информацию о них, а также создавать, изменять, удалять и использовать группы бэкендов;
* просматривать список целевых групп L7-балансировщиков и [сетевых балансировщиков](../network-load-balancer/concepts/target-resources.md) и информацию о них, а также создавать, изменять, удалять и использовать целевые группы;
* просматривать список [сетевых балансировщиков](../network-load-balancer/concepts/index.md) и информацию о них, а также создавать внутренние сетевые балансировщики (в т.ч. с UDP-обработчиком), изменять, удалять, запускать и останавливать их;
* просматривать список [облачных сетей](../vpc/concepts/network.md#network) и информацию о них, а также использовать облачные сети;
* просматривать список [подсетей](../vpc/concepts/network.md#subnet) и информацию о них, а также использовать подсети;
* просматривать список [адресов облачных ресурсов](../vpc/concepts/address.md) и информацию о них, а также использовать адреса;
* просматривать список [таблиц маршрутизации](../vpc/concepts/routing.md#rt-vpc) и информацию о них, а также использовать таблицы маршрутизации;
* просматривать список [групп безопасности](../vpc/concepts/security-groups.md) и информацию о них, а также использовать группы безопасности;
* просматривать информацию о [NAT-шлюзах](../vpc/concepts/gateways.md) и подключать их к таблицам маршрутизации;
* просматривать информацию об использованных IP-адресах в подсетях, а также создавать [внутренние адреса](../vpc/concepts/address.md#internal-addresses);
* просматривать информацию об операциях с ресурсами сервисов {{ vpc-name }} и {{ compute-name }};
* просматривать список операций с ресурсами сервиса {{ network-load-balancer-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder);
* просматривать информацию о квотах сервисов [{{ alb-name }}](../application-load-balancer/concepts/limits.md#quotas), [{{ network-load-balancer-name }}](../network-load-balancer/concepts/limits.md#load-balancer-quotas) и [{{ vpc-name }}](../vpc/concepts/limits.md#vpc-quotas).

{% endcut %}

Включает разрешения, предоставляемые ролью `alb.editor`.

Для подключения публичного IP-адреса к новому или существующему L7-балансировщику дополнительно необходима [роль](../vpc/security/index.md#vpc-public-admin) `vpc.publicAdmin` на сеть, в которой находится балансировщик.

Подробнее см. [{#T}](../application-load-balancer/security/index.md).


## {{ at-full-name }} {#at-roles}

#### audit-trails.auditor {#at-auditor}

Роль `audit-trails.auditor` позволяет просматривать список [трейлов](../audit-trails/concepts/trail.md) и информацию о них, а также об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud), [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder) и [квотах](../audit-trails/concepts/limits.md#audit-trails-quotas) сервиса {{ at-name }}.

#### audit-trails.viewer {#at-viewer}

Роль `audit-trails.viewer` позволяет читать [аудитные логи](../audit-trails/concepts/index.md), а также просматривать список [трейлов](../audit-trails/concepts/trail.md) и информацию о трейлах, [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud), [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder) и [квотах](../audit-trails/concepts/limits.md#audit-trails-quotas) сервиса {{ at-name }}.

Включает разрешения, предоставляемые ролью `audit-trails.auditor`.

#### audit-trails.editor {#at-editor}

Роль `audit-trails.editor` позволяет управлять трейлами и читать аудитные логи.

Пользователи с этой ролью могут:
* просматривать список [трейлов](../audit-trails/concepts/trail.md) и информацию о них, а также создавать, изменять и удалять трейлы;
* читать [аудитные логи](../audit-trails/concepts/index.md);
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder);
* просматривать информацию о [квотах](../audit-trails/concepts/limits.md#audit-trails-quotas) сервиса {{ at-name }}.

Включает разрешения, предоставляемые ролью `audit-trails.viewer`.

#### audit-trails.admin {#at-admin}

Роль `audit-trails.admin` позволяет управлять трейлами и доступом к ним, а также читать аудитные логи.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к [трейлам](../audit-trails/concepts/trail.md), а также изменять такие права доступа;
* просматривать список трейлов и информацию о них, а также создавать, изменять и удалять трейлы;
* читать [аудитные логи](../audit-trails/concepts/index.md);
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder);
* просматривать информацию о [квотах](../audit-trails/concepts/limits.md#audit-trails-quotas) сервиса {{ at-name }}.

Включает разрешения, предоставляемые ролью `audit-trails.editor`.

#### audit-trails.configViewer {#at-configviewer}

Роль `audit-trails.configViewer` позволяет просматривать список трейлов и информацию о них, а также об облаке, каталоге и квотах сервиса {{ at-name }}.

Эта роль недоступна. Используйте роль `audit-trails.auditor`.

Подробнее см. [{#T}](../audit-trails/security/index.md).


## {{ baremetal-full-name }} {#baremetal-roles}

#### baremetal.auditor {#baremetal-auditor}

Роль `baremetal.auditor` позволяет просматривать метаданные ресурсов сервиса {{ baremetal-full-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о [серверах](../baremetal/concepts/servers.md) {{ baremetal-name }}, в том числе об их [конфигурации](../baremetal/concepts/server-configurations.md);
* просматривать информацию о [приватных подсетях](../baremetal/concepts/private-network.md#private-subnet) и [виртуальных сегментах сети (VRF)](../baremetal/concepts/private-network.md#vrf-segment);
* просматривать информацию о загруженных образах операционных систем серверов {{ baremetal-name }};
* просматривать информацию о [квотах](../baremetal/concepts/limits.md#baremetal-quotas) сервиса {{ baremetal-full-name }};
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

#### baremetal.viewer {#baremetal-viewer}

Роль `baremetal.viewer` позволяет просматривать информацию о ресурсах сервиса{{ baremetal-full-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о [серверах](../baremetal/concepts/servers.md) {{ baremetal-name }}, в том числе об их [конфигурации](../baremetal/concepts/server-configurations.md);
* просматривать информацию о [приватных подсетях](../baremetal/concepts/private-network.md#private-subnet) и [виртуальных сегментах сети (VRF)](../baremetal/concepts/private-network.md#vrf-segment);
* просматривать информацию о загруженных образах операционных систем серверов {{ baremetal-name }};
* просматривать информацию о [квотах](../baremetal/concepts/limits.md#baremetal-quotas) сервиса {{ baremetal-full-name }};
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `baremetal.auditor`.

#### baremetal.operator {#baremetal-operator}

Роль `baremetal.operator` позволяет работать на серверах {{ baremetal-name }}, а также просматривать информацию о ресурсах сервиса {{ baremetal-full-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о [серверах](../baremetal/concepts/servers.md) {{ baremetal-name }}, в том числе об их [конфигурации](../baremetal/concepts/server-configurations.md);
* [использовать KVM-консоль](../baremetal/operations/servers/server-kvm.md) серверов;
* использовать [IPMI](https://en.wikipedia.org/wiki/Intelligent_Platform_Management_Interface) для управления питанием серверов — включать, выключать и перезагружать их;
* просматривать информацию о [приватных подсетях](../baremetal/concepts/private-network.md#private-subnet) и [виртуальных сегментах сети (VRF)](../baremetal/concepts/private-network.md#vrf-segment);
* просматривать информацию о загруженных образах операционных систем серверов;
* просматривать информацию о [квотах](../baremetal/concepts/limits.md#baremetal-quotas) сервиса {{ baremetal-full-name }};
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `baremetal.viewer`.

#### baremetal.editor {#baremetal-editor}

Роль `baremetal.editor` позволяет управлять серверами {{ baremetal-name }}, приватными подсетями, виртуальными сегментами сети (VRF) и образами операционных систем серверов.

Пользователи с этой ролью могут:
* просматривать информацию о [серверах](../baremetal/concepts/servers.md) {{ baremetal-name }}, в том числе об их [конфигурации](../baremetal/concepts/server-configurations.md);
* арендовать сервера {{ baremetal-name }} и отказываться от их аренды, а также изменять настройки серверов {{ baremetal-name }};
* просматривать информацию о [приватных подсетях](../baremetal/concepts/private-network.md#private-subnet), а также создавать, изменять и удалять приватные подсети;
* просматривать информацию о [виртуальных сегментах сети (VRF)](../baremetal/concepts/private-network.md#vrf-segment), а также создавать, изменять и удалять VRF;
* просматривать информацию о загруженных образах операционных систем серверов {{ baremetal-name }}, а также загружать, изменять и удалять такие образы;
* переустанавливать операционные системы серверов {{ baremetal-name }};
* [использовать KVM-консоль](../baremetal/operations/servers/server-kvm.md) серверов;
* использовать [IPMI](https://en.wikipedia.org/wiki/Intelligent_Platform_Management_Interface) для управления питанием серверов — включать, выключать и перезагружать их;
* просматривать информацию о [квотах](../baremetal/concepts/limits.md#baremetal-quotas) сервиса {{ baremetal-full-name }};
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `baremetal.operator`.

{% note warning %}

С 1 августа 2026 года роль `baremetal.editor` получает новый набор разрешений, позволяющий подключать серверы к сервису [{{ backup-full-name }}](../backup/index.md), а также привязывать и отвязывать их от [политик резервного копирования](../backup/concepts/policy.md).

Если вы не планируете подключать ваши ресурсы к {{ backup-name }} и не хотите предоставлять вашим пользователям такие разрешения, вы можете заблаговременно отключить эти возможности с помощью [политики авторизации](concepts/access-control/access-policies.md#backup-denyActivation) `backup.denyActivation`, назначенной на каталог, облако или организацию. Подробнее о том, как создать политику авторизации, читайте в разделе [{#T}](operations/access-policies/assign.md).

{% endnote %}

#### baremetal.admin {#baremetal-admin}

Роль `baremetal.admin` позволяет управлять серверами {{ baremetal-name }}, приватными подсетями, виртуальными сегментами сети (VRF) и образами операционных систем серверов.

Пользователи с этой ролью могут:
* просматривать информацию о [серверах](../baremetal/concepts/servers.md) {{ baremetal-name }}, в том числе об их [конфигурации](../baremetal/concepts/server-configurations.md);
* арендовать сервера {{ baremetal-name }} и отказываться от их аренды, а также изменять настройки серверов {{ baremetal-name }};
* просматривать информацию о [приватных подсетях](../baremetal/concepts/private-network.md#private-subnet), а также создавать, изменять и удалять приватные подсети;
* просматривать информацию о [виртуальных сегментах сети (VRF)](../baremetal/concepts/private-network.md#vrf-segment), а также создавать, изменять и удалять VRF;
* просматривать информацию о загруженных образах операционных систем серверов {{ baremetal-name }}, а также загружать, изменять и удалять такие образы;
* переустанавливать операционные системы серверов {{ baremetal-name }};
* [использовать KVM-консоль](../baremetal/operations/servers/server-kvm.md) серверов;
* использовать [IPMI](https://en.wikipedia.org/wiki/Intelligent_Platform_Management_Interface) для управления питанием серверов — включать, выключать и перезагружать их;
* просматривать информацию о [квотах](../baremetal/concepts/limits.md#baremetal-quotas) сервиса {{ baremetal-full-name }};
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `baremetal.editor`.

{% note warning %}

С 1 августа 2026 года роль `baremetal.admin` получает новый набор разрешений, позволяющий подключать серверы к сервису [{{ backup-full-name }}](../backup/index.md), а также привязывать и отвязывать их от [политик резервного копирования](../backup/concepts/policy.md).

Если вы не планируете подключать ваши ресурсы к {{ backup-name }} и не хотите предоставлять вашим пользователям такие разрешения, вы можете заблаговременно отключить эти возможности с помощью [политики авторизации](concepts/access-control/access-policies.md#backup-denyActivation) `backup.denyActivation`, назначенной на каталог, облако или организацию. Подробнее о том, как создать политику авторизации, читайте в разделе [{#T}](operations/access-policies/assign.md).

{% endnote %}

Подробнее см. [{#T}](../baremetal/security/index.md).


## {{ certificate-manager-full-name }} {#certificate-manager-roles}

#### certificate-manager.auditor {#certificate-manager-auditor}

Роль `certificate-manager.auditor` позволяет просматривать информацию о сертификатах и назначенных правах доступа к ним.

Пользователи с этой ролью могут:
* просматривать список [сертификатов](../certificate-manager/concepts/index.md#types) и [зависимых](../certificate-manager/concepts/services.md) ресурсов, а также информацию о сертификатах и о назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о [квотах](../certificate-manager/concepts/limits.md#certificate-manager-quotas) сервиса {{ certificate-manager-name }}.

#### certificate-manager.viewer {#certificate-manager-viewer}

Роль `certificate-manager.viewer` позволяет просматривать информацию о сертификатах и назначенных правах доступа к ним.

Пользователи с этой ролью могут:
* просматривать список [сертификатов](../certificate-manager/concepts/index.md#types) и [зависимых](../certificate-manager/concepts/services.md) ресурсов, а также информацию о сертификатах и о назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о [квотах](../certificate-manager/concepts/limits.md#certificate-manager-quotas) сервиса {{ certificate-manager-name }}.

Включает разрешения, предоставляемые ролью `certificate-manager.auditor`.

#### certificate-manager.editor {#certificate-manager-editor}

Роль `certificate-manager.editor` позволяет управлять сертификатами, просматривать информацию о них, о назначенных правах доступа к ним и о квотах сервиса {{ certificate-manager-name }}.

Пользователи с этой ролью могут:
* просматривать список [сертификатов](../certificate-manager/concepts/index.md#types) и [зависимых](../certificate-manager/concepts/services.md) ресурсов, а также информацию о сертификатах и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* добавлять, изменять, обновлять и удалять сертификаты;
* просматривать информацию о [квотах](../certificate-manager/concepts/limits.md#certificate-manager-quotas) сервиса {{ certificate-manager-name }}.

Включает разрешения, предоставляемые ролью `certificate-manager.viewer`.

#### certificate-manager.admin {#certificate-manager-admin}

Роль `certificate-manager.admin` позволяет управлять сертификатами и доступом к ним, а также получать содержимое сертификатов.

Пользователи с этой ролью могут:
* просматривать список [сертификатов](../certificate-manager/concepts/index.md#types) и [зависимых](../certificate-manager/concepts/services.md) ресурсов, а также информацию о сертификатах;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к сертификатам и изменять такие права доступа;
* добавлять, изменять, обновлять и удалять сертификаты;
* получать содержимое сертификатов;
* просматривать информацию о [квотах](../certificate-manager/concepts/limits.md#certificate-manager-quotas) сервиса {{ certificate-manager-name }};
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `certificate-manager.editor`.

#### certificate-manager.certificates.downloader {#certificate-manager-certificates-downloader}

Роль `certificate-manager.certificates.downloader` позволяет просматривать список [сертификатов](../certificate-manager/concepts/index.md#types) и информацию о них, а также получать содержимое сертификатов.

Подробнее см. [{#T}](../certificate-manager/security/index.md).


## {{ cloud-apps-full-name }} {#cloud-apps-roles}

#### cloudapps.auditor {#cloudapps-auditor}

Роль `cloudapps.auditor` позволяет просматривать метаданные установленных приложений {{ cloud-apps-name }}.

#### cloudapps.viewer {#cloudapps-viewer}

Роль `cloudapps.viewer` позволяет просматривать информацию об установленных приложениях {{ cloud-apps-name }}.

Включает разрешения, предоставляемые ролью `cloudapps.auditor`.

#### cloudapps.editor {#cloudapps-editor}

Роль `cloudapps.editor` позволяет просматривать информацию об установленных приложениях {{ cloud-apps-name }}, а также создавать, изменять и удалять такие приложения.

Включает разрешения, предоставляемые ролью `cloudapps.viewer`.

#### cloudapps.admin {#cloudapps-admin}

Роль `cloudapps.admin` позволяет просматривать информацию об установленных приложениях {{ cloud-apps-name }}, а также создавать, изменять и удалять такие приложения.

Включает разрешения, предоставляемые ролью `cloudapps.editor`.

Подробнее см. [{#T}](../cloud-apps/security/index.md).


## {{ backup-full-name }} {#backup-roles}

#### backup.auditor {#backup-auditor}

Роль `backup.auditor` позволяет просматривать информацию о виртуальных машинах и серверах {{ baremetal-name }}, подключенных к сервису {{ backup-name }}, о политиках резервного копирования и квотах сервиса, а также об облаке и каталоге.

Пользователи с этой ролью могут:
* просматривать информацию о подключенных [провайдерах](../backup/concepts/index.md#providers) резервного копирования;
* просматривать информацию о [политиках резервного копирования](../backup/concepts/policy.md) и привязанных к ним виртуальных машинах и серверах {{ baremetal-name }};
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к политикам резервного копирования;
* просматривать информацию о [подключенных](../backup/concepts/vm-connection.md) к сервису виртуальных машинах и серверах {{ baremetal-name }};
* просматривать информацию о [квотах](../backup/concepts/limits.md#backup-quotas) сервиса {{ backup-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder) и его статистику.

Назначить роль `backup.auditor` может пользователь с ролью `admin` в облаке или `backup.admin` в каталоге.

#### backup.viewer {#backup-viewer}

Роль `backup.viewer` позволяет просматривать информацию о виртуальных машинах и серверах {{ baremetal-name }}, подключенных к сервису {{ backup-name }}, о политиках резервного копирования и резервных копиях, а также о квотах сервиса, облаке и каталоге.

Пользователи с этой ролью могут:
* просматривать информацию о подключенных [провайдерах](../backup/concepts/index.md#providers) резервного копирования;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к политикам резервного копирования;
* просматривать информацию о [политиках резервного копирования](../backup/concepts/policy.md) и привязанных к ним виртуальных машинах и серверах {{ baremetal-name }};
* просматривать информацию о [подключенных](../backup/concepts/vm-connection.md) к сервису виртуальных машинах и серверах {{ baremetal-name }};
* просматривать информацию о [резервных копиях](../backup/concepts/backup.md);
* просматривать информацию о [квотах](../backup/concepts/limits.md#backup-quotas) сервиса {{ backup-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder) и его статистику.

Включает разрешения, предоставляемые ролью `backup.auditor`.

Назначить роль `backup.viewer` может пользователь с ролью `admin` в облаке или `backup.admin` в каталоге.

#### backup.user {#backup-user}

Роль `backup.user` позволяет подключать провайдеров резервного копирования, подключать к сервису виртуальные машины и серверы {{ baremetal-name }}, привязывать политики резервного копирования к виртуальным машинам и серверам {{ baremetal-name }} и отвязывать их, а также просматривать информацию о ресурсах и квотах сервиса, об облаке и каталоге.

Пользователи с этой ролью могут:
* просматривать информацию о подключенных [провайдерах](../backup/concepts/index.md#providers) резервного копирования, а также подключать провайдеров, доступных в {{ backup-name }};
* просматривать информацию о [подключенных](../backup/concepts/vm-connection.md) к {{ backup-name }} виртуальных машинах и серверах {{ baremetal-name }}, а также подключать виртуальные машины и серверы {{ baremetal-name }} к сервису;
* просматривать информацию о [политиках резервного копирования](../backup/concepts/policy.md) и привязанных к ним виртуальных машинах и серверах {{ baremetal-name }};
* привязывать политики резервного копирования к виртуальным машинам и серверам {{ baremetal-name }}, а также отвязывать их;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к политикам резервного копирования;
* просматривать информацию о [квотах](../backup/concepts/limits.md#backup-quotas) сервиса {{ backup-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder) и его статистику.

Включает разрешения, предоставляемые ролью `backup.auditor`.

Назначить роль `backup.user` может пользователь с ролью `admin` в облаке или `backup.admin` в каталоге.

#### backup.editor {#backup-editor}

Роль `backup.editor` позволяет управлять подключением виртуальных машин и серверов {{ baremetal-name }} к сервису {{ backup-name }}, управлять политиками резервного копирования, выполнять резервное копирование, восстанавливать ВМ и серверы {{ baremetal-name }} из резервных копий.

Пользователи с этой ролью могут:
* просматривать информацию о подключенных [провайдерах](../backup/concepts/index.md#providers) резервного копирования, а также подключать провайдеров, доступных в {{ backup-name }};
* просматривать информацию о [политиках резервного копирования](../backup/concepts/policy.md) и привязанных к ним виртуальных машинах и серверах {{ baremetal-name }};
* создавать, изменять и удалять политики резервного копирования, а также привязывать, отвязывать и запускать их на виртуальных машинах и серверах {{ baremetal-name }};
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к политикам резервного копирования;
* просматривать информацию о [подключенных](../backup/concepts/vm-connection.md) к {{ backup-name }} виртуальных машинах и серверах {{ baremetal-name }}, а также подключать и отключать виртуальные машины и серверы {{ baremetal-name }} от сервиса;
* просматривать информацию о [резервных копиях](../backup/concepts/backup.md), а также удалять их и восстанавливать из них виртуальные машины и серверы {{ baremetal-name }};
* просматривать информацию о [квотах](../backup/concepts/limits.md#backup-quotas) сервиса {{ backup-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder) и его статистику.

Включает разрешения, предоставляемые ролями `backup.viewer` и `backup.user`.

Назначить роль `backup.editor` может пользователь с ролью `admin` в облаке или `backup.admin` в каталоге.

#### backup.admin {#backup-admin}

Роль `backup.admin` позволяет управлять политиками резервного копирования и доступом к ним, управлять подключением виртуальных машин и серверов {{ baremetal-name }} к сервису {{ backup-name }}, выполнять резервное копирование, восстанавливать ВМ и серверы {{ baremetal-name }} из резервных копий.

Пользователи с этой ролью могут:
* просматривать информацию о подключенных [провайдерах](../backup/concepts/index.md#providers) резервного копирования, а также подключать провайдеров, доступных в {{ backup-name }};
* просматривать информацию о [политиках резервного копирования](../backup/concepts/policy.md) и привязанных к ним виртуальных машинах и серверах {{ baremetal-name }};
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к политикам резервного копирования и изменять такие права доступа;
* создавать, изменять и удалять политики резервного копирования, а также привязывать, отвязывать и запускать их на виртуальных машинах и серверах {{ baremetal-name }};
* просматривать информацию о [подключенных](../backup/concepts/vm-connection.md) к {{ backup-name }} виртуальных машинах и серверах {{ baremetal-name }}, а также подключать и отключать виртуальные машины и серверы {{ baremetal-name }} от сервиса;
* просматривать информацию о [резервных копиях](../backup/concepts/backup.md), а также удалять их и восстанавливать из них виртуальные машины и серверы {{ baremetal-name }};
* просматривать информацию о [квотах](../backup/concepts/limits.md#backup-quotas) сервиса {{ backup-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder) и его статистику.

Включает разрешения, предоставляемые ролью `backup.editor`.

Назначить роль `backup.admin` может пользователь с ролью `admin` в облаке.

Подробнее см. [{#T}](../backup/security/index.md).


## {{ billing-name }} {#billing-roles}

#### billing.accounts.member {#billing-accounts-member}

Роль `billing.accounts.member` автоматически выдается при добавлении пользователя в сервисе. Она необходима для показа выбранного [платежного аккаунта](../billing/concepts/billing-account.md) в списке всех аккаунтов пользователя.

#### billing.accounts.owner {#billing-accounts-owner}

Роль `billing.accounts.owner` автоматически выдается при создании платежного аккаунта. Любой пользователь с ролью `billing.accounts.owner` может отозвать эту роль у создателя платежного аккаунта и изменить владельца.

{% cut "В сервисе Yandex Cloud Billing пользователи с этой ролью могут:" %}

* показывать [платежные аккаунты](../billing/concepts/billing-account.md) в списке всех аккаунтов;
* просматривать данные платежных аккаунтов;
* просматривать [коммерческие предложения](../billing/concepts/glossary.md#client-offer);
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к платежным аккаунтам и изменять такие права доступа;
* подключать, отключать, изменять тарифный план [технической поддержки](../support/overview.md), а также изменять платежный аккаунт, с которого будет списываться плата по тарифу;
* просматривать и скачивать [отчетные (закрывающие) документы](../billing/payment/documents.md);
* генерировать новые [акты сверки](../billing/concepts/act.md#reconciliation-report);
* просматривать и скачивать сгенерированные акты сверки;
* получать и просматривать уведомления о потреблении;
* проверять расходы;
* [просматривать детализацию](../billing/operations/check-charges.md);
* создавать [экспорт детализации](../billing/operations/get-folder-report.md);
* создавать [бюджеты](../billing/concepts/budget.md);
* [резервировать потребление ресурсов](../billing/concepts/cvos.md);
* пополнять [лицевой счет](../billing/concepts/personal-account.md) с помощью расчетного счета;
* пополнять лицевой счет с помощью банковской карты;
* привязывать [облака](../resource-manager/concepts/resources-hierarchy.md#cloud) к платежному аккаунту;
* переименовывать платежные аккаунты;
* изменять контакты плательщика;
* изменять платежные реквизиты;
* [изменять](../billing/operations/pin-card.md#change_card) банковскую карту;
* [изменять](../billing/operations/change-payment-method.md) способ оплаты;
* активировать промокоды;
* активировать [пробный период](../billing/concepts/trial-period.md);
* активировать [платную версию](../getting-started/free-trial/concepts/upgrade-to-paid.md);
* [удалять](../billing/operations/delete-account.md) платежные аккаунты.

{% endcut %}

{% cut "На партнерском портале Yandex Cloud пользователи с этой ролью могут:" %}

* [создавать](../partner/operations/pin-client.md#client-entry) записи о клиентах ([сабаккаунты](../partner/terms.md#sub-account));
* просматривать список и данные сабаккаунтов, в т.ч. персональные данные;
* обновлять данные записей о сабаккаунтах;
* активировать сабаккаунты;
* приостанавливать работу сабаккаунтов;
* возобновлять работу сабаккаунтов;
* удалять сабаккаунты (до подтверждения клиентом);
* привязывать [облака](../resource-manager/concepts/resources-hierarchy.md#cloud) к сабаккаунтам;
* [управлять](../partner/operations/access/partners-account.md) назначенными правами доступа к сабаккаунтам;
* [просматривать](../partner/operations/get-client-stat.md) потребление сервисов клиентами;
* просматривать историю начисления [рибейта](../partner/terms.md#rebate);
* выводить рибейт;
* просматривать присвоенные [специализации](../partner/specializations/index.md);
* просматривать историю начисления вознаграждений по [реферальной программе](../partner/program/referral.md);
* выводить [вознаграждение](../partner/program/referral.md#premium) по реферальной программе;
* просматривать статус расчетов с [компанией-реферером](../partner/terms.md#referral-partner);
* просматривать список реферальных ссылок;
* создавать реферальные ссылки;
* активировать реферальные ссылки;
* изменять реферальные ссылки;
* просматривать список [партнерских премий](../partner/portal.md#premium) и информацию о них.

{% endcut %}

Включает разрешения, предоставляемые ролями `billing.accounts.admin` и `billing.accounts.varWithoutDiscounts`.

#### billing.accounts.viewer {#billing-accounts-viewer}

Роль `billing.accounts.viewer` назначается на платежный аккаунт. Позволяет просматривать данные платежного аккаунта, получать информацию о потреблении ресурсов, проверять расходы, выгружать акты сверки и отчетные документы.

{% cut "В сервисе Yandex Cloud Billing пользователи с этой ролью могут:" %}

* показывать [платежные аккаунты](../billing/concepts/billing-account.md) в списке всех аккаунтов;
* просматривать данные платежных аккаунтов;
* просматривать и скачивать [отчетные (закрывающие) документы](../billing/payment/documents.md);
* просматривать и скачивать сгенерированные акты сверки;
* получать и просматривать уведомления о потреблении;
* проверять расходы;
* [просматривать детализацию](../billing/operations/check-charges.md).

{% endcut %}


{% cut "На партнерском портале Yandex Cloud пользователи с этой ролью могут:" %}

* просматривать присвоенные [специализации](../partner/specializations/index.md);
* просматривать историю начисления вознаграждений по [реферальной программе](../partner/program/referral.md);
* просматривать статус расчетов с [компанией-реферером](../partner/terms.md#referral-partner);
* просматривать список реферальных ссылок.

{% endcut %}

#### billing.accounts.accountant {#billing-accounts-accountant}

Роль `billing.accounts.accountant` назначается на платежный аккаунт. Позволяет просматривать данные платежного аккаунта, получать информацию о потреблении ресурсов, проверять расходы, выгружать акты сверки и отчетные документы, создавать новый акт сверки, пополнять лицевой счет с помощью расчетного счета.

{% cut "В сервисе Yandex Cloud Billing пользователи с этой ролью могут:" %}

* показывать [платежные аккаунты](../billing/concepts/billing-account.md) в списке всех аккаунтов;
* просматривать данные платежных аккаунтов;
* просматривать и скачивать [отчетные (закрывающие) документы](../billing/payment/documents.md);
* генерировать новые [акты сверки](../billing/concepts/act.md#reconciliation-report);
* просматривать и скачивать сгенерированные акты сверки;
* получать и просматривать уведомления о потреблении;
* проверять расходы;
* [просматривать детализацию](../billing/operations/check-charges.md);
* пополнять [лицевой счет](../billing/concepts/personal-account.md) с помощью расчетного счета.

{% endcut %}


{% cut "На партнерском портале Yandex Cloud пользователи с этой ролью могут:" %}

* просматривать присвоенные [специализации](../partner/specializations/index.md);
* просматривать историю начисления вознаграждений по [реферальной программе](../partner/program/referral.md);
* просматривать статус расчетов с [компанией-реферером](../partner/terms.md#referral-partner);
* просматривать список реферальных ссылок;
* просматривать историю начисления [рибейта](../partner/terms.md#rebate).

{% endcut %}

Включает разрешения, предоставляемые ролью `billing.accounts.viewer`.

#### billing.accounts.editor {#billing-accounts-editor}

Роль `billing.accounts.editor` назначается на платежный аккаунт. Позволяет получать счета на оплату, активировать промокоды, привязывать облака и сервисы к платежному аккаунту, создавать экспорт детализации, создавать бюджеты, генерировать акты сверки и резервировать ресурсы.

{% cut "В сервисе Yandex Cloud Billing пользователи с этой ролью могут:" %}

* показывать [платежные аккаунты](../billing/concepts/billing-account.md) в списке всех аккаунтов;
* просматривать данные платежных аккаунтов;
* просматривать [коммерческие предложения](../billing/concepts/glossary.md#client-offer);
* просматривать и скачивать [отчетные (закрывающие) документы](../billing/payment/documents.md);
* генерировать новые [акты сверки](../billing/concepts/act.md#reconciliation-report);
* просматривать и скачивать сгенерированные акты сверки;
* получать и просматривать уведомления о потреблении;
* проверять расходы;
* [просматривать детализацию](../billing/operations/check-charges.md);
* создавать [экспорт детализации](../billing/operations/get-folder-report.md);
* создавать [бюджеты](../billing/concepts/budget.md);
* [резервировать потребление ресурсов](../billing/concepts/cvos.md);
* пополнять [лицевой счет](../billing/concepts/personal-account.md) с помощью расчетного счета;
* привязывать [облака](../resource-manager/concepts/resources-hierarchy.md#cloud) к платежному аккаунту;
* переименовывать платежные аккаунты;
* активировать промокоды.

{% endcut %}

{% cut "На партнерском портале Yandex Cloud пользователи с этой ролью могут:" %}

* просматривать историю начисления [рибейта](../partner/terms.md#rebate);
* просматривать присвоенные [специализации](../partner/specializations/index.md);
* просматривать историю начисления вознаграждений по [реферальной программе](../partner/program/referral.md);
* выводить [вознаграждение](../partner/program/referral.md#premium) по реферальной программе;
* просматривать статус расчетов с [компанией-реферером](../partner/terms.md#referral-partner);
* просматривать список реферальных ссылок;
* создавать реферальные ссылки;
* активировать реферальные ссылки;
* изменять реферальные ссылки;
* привязывать [облака](../resource-manager/concepts/resources-hierarchy.md#cloud) к [сабаккаунтам](../partner/terms.md#sub-account).

{% endcut %}

Включает разрешения, предоставляемые ролью `billing.accounts.viewer`.

#### billing.accounts.admin {#billing-accounts-admin}

Роль `billing.accounts.admin` назначается на платежный аккаунт и позволяет управлять доступами к платежному аккаунту (кроме роли `billing.accounts.owner`).

{% cut "В сервисе Yandex Cloud Billing пользователи с этой ролью могут:" %}

* показывать [платежные аккаунты](../billing/concepts/billing-account.md) в списке всех аккаунтов;
* просматривать данные платежных аккаунтов;
* просматривать [коммерческие предложения](../billing/concepts/glossary.md#client-offer);
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к платежным аккаунтам и изменять такие права доступа (за исключением назначения и отзыва роли `billing.accounts.owner`);
* подключать, отключать, изменять тарифный план [технической поддержки](../support/overview.md), а также изменять платежный аккаунт, с которого будет списываться плата по тарифу;
* просматривать и скачивать [отчетные (закрывающие) документы](../billing/payment/documents.md);
* генерировать новые [акты сверки](../billing/concepts/act.md#reconciliation-report);
* просматривать и скачивать сгенерированные акты сверки;
* получать и просматривать уведомления о потреблении;
* проверять расходы;
* [просматривать детализацию](../billing/operations/check-charges.md);
* создавать [экспорт детализации](../billing/operations/get-folder-report.md);
* создавать [бюджеты](../billing/concepts/budget.md);
* [резервировать потребление ресурсов](../billing/concepts/cvos.md);
* пополнять [лицевой счет](../billing/concepts/personal-account.md) с помощью расчетного счета;
* привязывать [облака](../resource-manager/concepts/resources-hierarchy.md#cloud) к платежному аккаунту;
* переименовывать платежные аккаунты;
* активировать промокоды.

{% endcut %}

{% cut "На партнерском портале Yandex Cloud пользователи с этой ролью могут:" %}

* [создавать](../partner/operations/pin-client.md#client-entry) записи о клиентах ([сабаккаунты](../partner/terms.md#sub-account));
* просматривать список и данные сабаккаунтов, включая персональные данные;
* активировать сабаккаунты;
* приостанавливать работу сабаккаунтов;
* возобновлять работу сабаккаунтов;
* привязывать [облака](../resource-manager/concepts/resources-hierarchy.md#cloud) к сабаккаунтам;
* [управлять](../partner/operations/access/partners-account.md) назначенными правами доступа к сабаккаунтам;
* [просматривать](../partner/operations/get-client-stat.md) потребление сервисов клиентами;
* просматривать историю начисления [рибейта](../partner/terms.md#rebate);
* выводить рибейт;
* просматривать присвоенные [специализации](../partner/specializations/index.md);
* просматривать историю начисления вознаграждений по [реферальной программе](../partner/program/referral.md);
* выводить [вознаграждение](../partner/program/referral.md#premium) по реферальной программе;
* просматривать статус расчетов с [компанией-реферером](../partner/terms.md#referral-partner);
* просматривать список реферальных ссылок;
* создавать реферальные ссылки;
* активировать реферальные ссылки;
* изменять реферальные ссылки;
* просматривать список [партнерских премий](../partner/portal.md#premium) и информацию о них.

{% endcut %}

Включает разрешения, предоставляемые ролями `billing.accounts.editor`, `billing.accounts.partnerAdmin` и `billing.partners.editor`.

#### billing.accounts.varWithoutDiscounts {#billing-accounts-var-without-discounts}

Роль `billing.accounts.varWithoutDiscounts` назначается на платежный аккаунт. Предоставляет партнерским аккаунтам все права администратора, кроме возможности получать информацию о скидках.

{% cut "В сервисе Yandex Cloud Billing пользователи с этой ролью могут:" %}

* показывать [платежные аккаунты](../billing/concepts/billing-account.md) в списке всех аккаунтов;
* просматривать данные платежных аккаунтов;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к платежным аккаунтам;
* просматривать и скачивать [отчетные (закрывающие) документы](../billing/payment/documents.md);
* генерировать новые [акты сверки](../billing/concepts/act.md#reconciliation-report);
* просматривать и скачивать сгенерированные акты сверки;
* получать и просматривать уведомления о потреблении;
* проверять расходы;
* [просматривать детализацию](../billing/operations/check-charges.md);
* создавать [экспорт детализации](../billing/operations/get-folder-report.md);
* создавать [бюджеты](../billing/concepts/budget.md);
* [резервировать потребление ресурсов](../billing/concepts/cvos.md);
* пополнять [лицевой счет](../billing/concepts/personal-account.md) с помощью расчетного счета;
* привязывать [облака](../resource-manager/concepts/resources-hierarchy.md#cloud) к платежному аккаунту;
* переименовывать платежные аккаунты;
* активировать промокоды.

{% endcut %}

{% cut "На партнерском портале Yandex Cloud пользователи с этой ролью могут:" %}

* [создавать](../partner/operations/pin-client.md#client-entry) записи о клиентах ([сабаккаунты](../partner/terms.md#sub-account));
* просматривать список и данные сабаккаунтов;
* активировать сабаккаунты;
* приостанавливать работу сабаккаунтов;
* возобновлять работу сабаккаунтов;
* привязывать [облака](../resource-manager/concepts/resources-hierarchy.md#cloud) к сабаккаунтам;
* [управлять](../partner/operations/access/partners-account.md) назначенными правами доступа к сабаккаунтам;
* просматривать историю начисления [рибейта](../partner/terms.md#rebate);
* выводить рибейт;
* просматривать историю начисления вознаграждений по [реферальной программе](../partner/program/referral.md);
* выводить [вознаграждение](../partner/program/referral.md#premium) по реферальной программе;
* просматривать статус расчетов с [компанией-реферером](../partner/terms.md#referral-partner);
* создавать реферальные ссылки;
* активировать реферальные ссылки;
* изменять реферальные ссылки;
* [просматривать](../partner/operations/get-client-stat.md) потребление сервисов клиентами.

{% endcut %}

Включает разрешения, предоставляемые ролью `billing.partners.editor`.

#### billing.partners.editor {#billing-partners-editor}

Роль `billing.partners.editor` назначается на [платежный аккаунт](../billing/concepts/billing-account.md) и дает право редактировать информацию о [партнере](../partner/program/var.md) и его продуктах в [партнерском каталоге](../partner/program/var-tools.md#catalog).

Подробнее см. [{#T}](../billing/security/index.md).


## {{ cdn-full-name }} {#cdn-roles}

#### cdn.viewer {#cdn-viewer}

Роль `cdn.viewer` позволяет просматривать информацию о каталоге, [группах источников](../cdn/concepts/origins.md), [CDN-ресурсах](../cdn/concepts/resource.md) и [квотах](../cdn/concepts/limits.md#cdn-quotas) сервиса {{ cdn-name }}.

#### cdn.editor {#cdn-editor}

Роль `cdn.editor` позволяет управлять ресурсами сервиса {{ cdn-name }}, а также просматривать информацию о квотах сервиса и каталоге.

Пользователи с этой ролью могут:
* просматривать информацию о [группах источников](../cdn/concepts/origins.md), а также создавать, изменять и удалять их;
* просматривать информацию о [CDN-ресурсах](../cdn/concepts/resource.md), а также создавать, изменять и удалять их;
* управлять [выгрузкой логов](../cdn/concepts/logs.md) запросов к CDN-серверам;
* управлять [экранированием источников](../cdn/concepts/origins-shielding.md);
* просматривать информацию о [квотах](../cdn/concepts/limits.md#cdn-quotas) сервиса {{ cdn-name }};
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `cdn.viewer`.

#### cdn.admin {#cdn-admin}

Роль `cdn.admin` позволяет управлять ресурсами сервиса {{ cdn-name }}, а также просматривать информацию о квотах сервиса и каталоге.

Пользователи с этой ролью могут:
* просматривать информацию о [группах источников](../cdn/concepts/origins.md), а также создавать, изменять и удалять их;
* просматривать информацию о [CDN-ресурсах](../cdn/concepts/resource.md), а также создавать, изменять и удалять их;
* управлять [выгрузкой логов](../cdn/concepts/logs.md) запросов к CDN-серверам;
* управлять [экранированием источников](../cdn/concepts/origins-shielding.md);
* просматривать информацию о [квотах](../cdn/concepts/limits.md#cdn-quotas) сервиса {{ cdn-name }};
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `cdn.editor`.

Позже роль получит дополнительные возможности.

Подробнее см. [{#T}](../cdn/security/index.md).


## {{ cloud-desktop-full-name }} {#desktop-roles}

#### vdi.viewer {#vdi-viewer}

Роль `vdi.viewer` позволяет просматривать информацию о рабочих столах и группах рабочих столов.

Пользователи с этой ролью могут:
* просматривать информацию о группах рабочих столов и назначенных [правах доступа](concepts/access-control/index.md) к таким группам;
* просматривать информацию о [рабочих столах](../cloud-desktop/concepts/desktops-and-groups.md);
* просматривать информацию о [квотах](../cloud-desktop/concepts/limits.md#quotas) сервиса {{ cloud-desktop-name }}.

Включает разрешения, предоставляемые ролью `vdi.auditor`.

#### vdi.desktopGroups.maintainer {#vdi-desktopGroups-maintainer}

Роль `vdi.desktopGroups.maintainer` позволяет использовать любые рабочие столы в группе рабочих столов.

Пользователи с этой ролью могут:
* закрепить за собой один [рабочий стол](../cloud-desktop/concepts/desktops-and-groups.md) в каждой группе рабочих столов;
* подключаться к своим рабочим столам;
* запускать, перезапускать и останавливать любые рабочие столы в группе;
* сбрасывать пароль на любых рабочих столах в группе.

Включает разрешения, предоставляемые ролью `vdi.desktopGroups.user`.

#### vdi.desktopGroups.user {#vdi-desktopGroups-user}

Роль `vdi.desktopGroups.user` позволяет использовать свои рабочие столы.

Пользователи с этой ролью могут:
* закрепить за собой один [рабочий стол](../cloud-desktop/concepts/desktops-and-groups.md) в каждой группе рабочих столов;
* подключаться к своим рабочим столам;
* запускать, перезапускать и останавливать свои рабочие столы;
* сбрасывать пароль на своих рабочих столах.

#### vdi.editor {#vdi-editor}

Роль `vdi.editor` позволяет управлять группами рабочих столов и рабочими столами, а также использовать свои рабочие столы.

Пользователи с этой ролью могут:
* просматривать информацию о [группах рабочих столов](../cloud-desktop/concepts/desktops-and-groups.md), а также создавать, изменять и удалять такие группы; при этом в число пользователей группы рабочих столов пользователь с этой ролью может либо добавить только себя, либо оставить это поле пустым;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к группам рабочих столов;
* просматривать информацию о [рабочих столах](../cloud-desktop/concepts/desktops-and-groups.md), а также создавать, изменять и удалять их;
* закреплять за собой любое количество рабочих столов в группе;
* подключаться к своим рабочим столам;
* запускать, перезапускать и останавливать свои рабочие столы;
* сбрасывать пароль на своих рабочих столах;
* просматривать информацию о [квотах](../cloud-desktop/concepts/limits.md#quotas) сервиса {{ cloud-desktop-name }}.

Включает разрешения, предоставляемые ролями `vdi.viewer` и `vdi.desktopGroups.user`.

#### vdi.admin {#vdi-admin}

Роль `vdi.admin` позволяет управлять группами рабочих столов и доступом к ним, а также управлять рабочими столами и использовать их.

Пользователи с этой ролью могут:
* просматривать информацию о [группах рабочих столов](../cloud-desktop/concepts/desktops-and-groups.md), а также создавать, изменять и удалять такие группы;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к группам рабочих столов, а также изменять такие права доступа;
* просматривать информацию о [рабочих столах](../cloud-desktop/concepts/desktops-and-groups.md), а также создавать, изменять и удалять их;
* закреплять как за собой, так и за любым пользователем любое количество рабочих столов в группе рабочих столов;
* подключаться к своим рабочим столам;
* запускать, перезапускать и останавливать любые рабочие столы в группе;
* сбрасывать пароль на любых рабочих столах в группе;
* просматривать информацию о [квотах](../cloud-desktop/concepts/limits.md#quotas) сервиса {{ cloud-desktop-name }};
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролями `vdi.editor` и `vdi.desktopGroups.maintainer`.

Подробнее см. [{#T}](../cloud-desktop/security/index.md).


## {{ ycdr-full-name }} {#ycdr-roles}

#### ycdr.admin {#ycdr-admin}

Роль `ycdr.admin` позволяет просматривать дашборды и управлять ресурсами {{ ycdr-name }} в рамках SIEM-инстанса, включая запросы, расследования и датасеты.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать информацию о URL-адресах для встраивания дашбордов {{ ycdr-name }};
* просматривать информацию о [расследованиях](../yandex-siem/concepts/investigations.md), а также создавать, обновлять, удалять и выполнять расследования;
* просматривать информацию о [датасетах](../yandex-siem/concepts/investigations.md#datasets-schema), а также создавать, обновлять и удалять датасеты;
* просматривать информацию о [запросах](../yandex-siem/concepts/queries.md), а также создавать, обновлять, удалять и выполнять запросы;
* просматривать информацию об инстансах [{{ yandex-siem-full-name }}](../yandex-siem/concepts/index.md) и [{{ ycdr-name }}](../ycdr/concepts/index.md).

{% endcut %}

Роль должна быть выдана на уровне организации.

Чтобы сервис {{ ycdr-full-name }} мог обрабатывать алерты из модуля {{ sd-name }} Алерты, пользователю также нужно назначить роль `security-deck.editor` на уровне каталога, с которого собираются алерты.

Включает разрешения, предоставляемые ролью `ycem.inspector`.


## {{ dns-full-name }} {#dns-roles}

#### dns.auditor {#dns-auditor}

Роль `dns.auditor` позволяет просматривать информацию о [DNS-зонах](../dns/concepts/dns-zone.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder) и [квотах](../dns/concepts/limits.md#cloud-dns-quotas) сервиса {{ dns-name }}. Роль не дает доступа к [ресурсным записям](../dns/concepts/resource-record.md).

#### dns.viewer {#dns-viewer}

Роль `dns.viewer` позволяет просматривать информацию о [DNS-зонах](../dns/concepts/dns-zone.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о [ресурсных записях](../dns/concepts/resource-record.md), а также о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder) и [квотах](../dns/concepts/limits.md#cloud-dns-quotas) сервиса {{ dns-name }}.

Включает разрешения, предоставляемые ролью `dns.auditor`.

#### dns.editor {#dns-editor}

Роль `dns.editor` позволяет управлять DNS-зонами и ресурсными записями, а также просматривать информацию о каталоге и квотах сервиса {{ dns-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о [DNS-зонах](../dns/concepts/dns-zone.md), а также создавать, использовать, изменять и удалять их;
* просматривать информацию о [ресурсных записях](../dns/concepts/resource-record.md), а также создавать, изменять и удалять их;
* создавать вложенные публичные DNS-зоны;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к DNS-зонам;
* просматривать информацию о [квотах](../dns/concepts/limits.md#cloud-dns-quotas) сервиса {{ dns-name }};
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `dns.viewer`.

#### dns.firewallUser {#dns-firewallUser}

Роль `dns.firewallUser` позволяет использовать облака, каталоги и облачные сети в качестве ресурсов для DNS-фильтров, а также просматривать информацию о ресурсах и квотах сервиса Cloud DNS.

Пользователи с этой ролью могут:
* просматривать информацию о DNS-фильтрах и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* использовать [облака](../resource-manager/concepts/resources-hierarchy.md#cloud), [каталоги](../resource-manager/concepts/resources-hierarchy.md#folder) и [облачные сети](../vpc/concepts/network.md#network) в качестве ресурсов для DNS-фильтров;
* просматривать информацию о [DNS-зонах](../dns/concepts/dns-zone.md) и назначенных правах доступа к ним;
* просматривать информацию о [квотах](../dns/concepts/limits.md#cloud-dns-quotas) сервиса Cloud DNS;
* просматривать информацию о каталоге.

Включает разрешения, предоставляемые ролью `dns.auditor`.

#### dns.firewallEditor {#dns-firewallEditor}

Роль `dns.firewallEditor` позволяет управлять DNS-фильтрами и использовать облака, каталоги и облачные сети в качестве ресурсов для них.

Пользователи с этой ролью могут:
* просматривать информацию о DNS-фильтрах и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* создавать, изменять и удалять DNS-фильтры;
* использовать [облака](../resource-manager/concepts/resources-hierarchy.md#cloud), [каталоги](../resource-manager/concepts/resources-hierarchy.md#folder) и [облачные сети](../vpc/concepts/network.md#network) в качестве ресурсов для DNS-фильтров;
* просматривать информацию о [DNS-зонах](../dns/concepts/dns-zone.md) и назначенных правах доступа к ним;
* просматривать информацию о [квотах](../dns/concepts/limits.md#cloud-dns-quotas) сервиса Cloud DNS;
* просматривать информацию о каталоге.

Включает разрешения, предоставляемые ролью `dns.firewallUser`.

#### dns.admin {#dns-admin}

Роль `dns.admin` позволяет управлять ресурсами сервиса {{ dns-name }} и доступом к ним.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к [DNS-зонам](../dns/concepts/dns-zone.md) и DNS-фильтрам, а также изменять такие права доступа;
* просматривать информацию о DNS-зонах, а также создавать, использовать, изменять и удалять их;
* создавать вложенные публичные DNS-зоны;
* просматривать информацию о DNS-фильтрах, а также создавать, изменять и удалять их;
* использовать [облака](../resource-manager/concepts/resources-hierarchy.md#cloud), [каталоги](../resource-manager/concepts/resources-hierarchy.md#folder) и [облачные сети](../vpc/concepts/network.md#network) в качестве ресурсов для DNS-фильтров;
* просматривать информацию о [ресурсных записях](../dns/concepts/resource-record.md), а также создавать, изменять и удалять их;
* просматривать информацию о [квотах](../dns/concepts/limits.md#cloud-dns-quotas) сервиса {{ dns-name }};
* просматривать информацию о каталоге.

Включает разрешения, предоставляемые ролями `dns.editor` и `dns.firewallEditor`.

Подробнее см. [{#T}](../dns/security/index.md).


## {{ sf-full-name }} {#functions-roles}

#### functions.auditor {#functions-auditor}

Роль `functions.auditor` позволяет просматривать информацию о функциях, триггерах и подключениях к управляемым БД.

Пользователи с этой ролью могут:
* просматривать список [функций](../functions/concepts/function.md) и информацию о них;
* просматривать список [триггеров](../functions/concepts/trigger/index.md) и информацию о них;
* просматривать список подключений к БД и информацию о таких подключениях;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к ресурсам сервиса Cloud Functions.

#### functions.viewer {#functions-viewer}

Роль `functions.viewer` позволяет просматривать информацию о функциях, триггерах и подключениях к управляемым БД, а также о квотах сервиса Cloud Functions.

Пользователи с этой ролью могут:
* просматривать список [функций](../functions/concepts/function.md) и информацию о них;
* просматривать список [триггеров](../functions/concepts/trigger/index.md) и информацию о них;
* просматривать список подключений к БД и информацию о таких подключениях;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к ресурсам сервиса Cloud Functions;
* просматривать информацию о [квотах](../functions/concepts/limits.md#functions-quotas) сервиса Cloud Functions;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `functions.auditor`.

#### functions.functionInvoker {#functions-functionInvoker}

Роль `functions.functionInvoker` позволяет вызывать [функции](../functions/concepts/function.md).

#### functions.editor {#functions-editor}

Роль `functions.editor` позволяет управлять функциями, триггерами, API-шлюзами и подключениями к управляемым БД.

Пользователи с этой ролью могут:
* просматривать список [функций](../functions/concepts/function.md) и информацию о них, а также создавать функции и их [версии](../functions/concepts/function.md#version), изменять, вызывать и удалять функции;
* просматривать переменные [окружения](../functions/concepts/runtime/environment-variables.md) и программный код версий функций;
* просматривать список [триггеров](../functions/concepts/trigger/index.md) и информацию о них, а также создавать, останавливать, запускать, изменять и удалять триггеры;
* просматривать список подключений к базам данных и информацию о таких подключениях, а также создавать, изменять и удалять подключения к БД и подключаться к БД из функций;
* создавать, изменять и удалять [API-шлюзы](../api-gateway/concepts/index.md);
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к ресурсам сервиса Cloud Functions;
* просматривать информацию о [квотах](../functions/concepts/limits.md#functions-quotas) сервиса Cloud Functions;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `functions.viewer`.

#### functions.mdbProxiesUser {#functions-mdbProxiesUser}

Роль `functions.mdbProxiesUser` позволяет подключаться к управляемым БД из [функций](../functions/concepts/function.md).

#### functions.admin {#functions-admin}

Роль `functions.admin` позволяет управлять функциями, триггерами, API-шлюзами и подключениями к управляемым БД, а также доступом к ним.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к ресурсам сервиса Cloud Functions и изменять права доступа;
* просматривать список [функций](../functions/concepts/function.md) и информацию о них, а также создавать функции и их [версии](../functions/concepts/function.md#version), изменять, вызывать и удалять функции;
* просматривать переменные [окружения](../functions/concepts/runtime/environment-variables.md) и программный код версий функций;
* просматривать список [триггеров](../functions/concepts/trigger/index.md) и информацию о них, а также создавать, останавливать, запускать, изменять и удалять триггеры;
* просматривать список подключений к базам данных и информацию о таких подключениях, а также создавать, изменять и удалять подключения к БД и подключаться к БД из функций;
* создавать, изменять и удалять [API-шлюзы](../api-gateway/concepts/index.md);
* просматривать информацию о [квотах](../functions/concepts/limits.md#functions-quotas) сервиса Cloud Functions;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `functions.editor`.

#### serverless.mdbProxies.user {#serverless-mdbProxies-user}

Роль `serverless.mdbProxies.user` позволяет подключаться к управляемым БД из функций Cloud Functions.

Эта роль недоступна. Используйте роль `functions.mdbProxiesUser`.

#### serverless.functions.invoker {#serverless-functions-invoker}

Роль `serverless.functions.invoker` позволяет вызывать функции.

Эта роль недоступна. Используйте роль `functions.functionInvoker`.

#### serverless.functions.admin {#serverless-functions-admin}

Роль `serverless.functions.admin` позволяет управлять функциями, триггерами, API-шлюзами и подключениями к управляемым БД, а также доступом к ним.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных правах доступа к ресурсам сервиса Cloud Functions и изменять права доступа;
* просматривать список функций и информацию о них, а также создавать функции и их версии, изменять, вызывать и удалять функции;
* просматривать переменные окружения и программный код версий функций;
* просматривать список триггеров и информацию о них, а также создавать, останавливать, запускать, изменять и удалять триггеры;
* просматривать список подключений к базам данных и информацию о таких подключениях, а также создавать, изменять и удалять подключения к БД и подключаться к БД из функций;
* просматривать список API-шлюзов и информацию о них, а также создавать, изменять и удалять API-шлюзы;
* просматривать информацию о квотах сервиса Cloud Functions;
* просматривать информацию об облаке;
* просматривать информацию о каталоге.

Эта роль недоступна. Используйте роль `functions.admin`.

Подробнее см. [{#T}](../functions/security/index.md).


## {{ interconnect-full-name }} {#interconnect-roles}

#### cic.auditor {#cic-auditor}

Роль `cic.auditor` позволяет просматривать информацию о ресурсах сервиса {{ interconnect-name }}.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать информацию о [точках присутствия](../interconnect/concepts/pops.md);
* просматривать информацию о [партнерах CIC](../interconnect/concepts/partners.md);
* просматривать информацию о [транковых подключениях](../interconnect/concepts/trunk.md);
* просматривать информацию о [приватных соединениях](../interconnect/concepts/priv-con.md);
* просматривать информацию о [публичных соединениях](../interconnect/concepts/pub-con.md);
* просматривать информацию о [квотах](../interconnect/concepts/limits.md#interconnect-quotas) сервиса {{ interconnect-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

#### cic.viewer {#cic-viewer}

Роль `cic.viewer` позволяет просматривать информацию о ресурсах сервиса {{ interconnect-name }}.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать информацию о [точках присутствия](../interconnect/concepts/pops.md);
* просматривать информацию о [партнерах CIC](../interconnect/concepts/partners.md);
* просматривать информацию о [транковых подключениях](../interconnect/concepts/trunk.md);
* просматривать информацию о [приватных соединениях](../interconnect/concepts/priv-con.md);
* просматривать информацию о [публичных соединениях](../interconnect/concepts/pub-con.md);
* просматривать информацию о [квотах](../interconnect/concepts/limits.md#interconnect-quotas) сервиса {{ interconnect-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролью `cic.auditor`.

#### cic.editor {#cic-editor}

Роль `cic.editor` позволяет управлять транковыми подключениями, приватными и публичными соединениями, а также просматривать информацию о квотах и ресурсах сервиса {{ interconnect-name }}.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать информацию о [транковых подключениях](../interconnect/concepts/trunk.md), а также создавать, изменять и удалять их;
* просматривать информацию о [приватных соединениях](../interconnect/concepts/priv-con.md), а также создавать, изменять и удалять их;
* просматривать информацию о [публичных соединениях](../interconnect/concepts/pub-con.md), а также создавать, изменять и удалять их;
* просматривать информацию о [точках присутствия](../interconnect/concepts/pops.md);
* просматривать информацию о [партнерах CIC](../interconnect/concepts/partners.md);
* просматривать информацию о [квотах](../interconnect/concepts/limits.md#interconnect-quotas) сервиса {{ interconnect-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролью `cic.viewer`.

#### cic.admin {#cic-admin}

Роль `cic.admin` позволяет управлять ресурсами сервиса {{ interconnect-name }}.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать информацию о [транковых подключениях](../interconnect/concepts/trunk.md), а также создавать, изменять и удалять их;
* просматривать информацию о [приватных соединениях](../interconnect/concepts/priv-con.md), а также создавать, изменять и удалять их;
* просматривать информацию о [публичных соединениях](../interconnect/concepts/pub-con.md), а также создавать, изменять и удалять их;
* просматривать информацию о [точках присутствия](../interconnect/concepts/pops.md);
* просматривать информацию о [партнерах CIC](../interconnect/concepts/partners.md);
* просматривать информацию о [квотах](../interconnect/concepts/limits.md#interconnect-quotas) сервиса {{ interconnect-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролью `cic.editor`.

#### cic.secretViewer {#cic-secretviewer}

Роль `cic.secretViewer` позволяет получать секреты [приватных](../interconnect/concepts/priv-con.md) и [публичных](../interconnect/concepts/pub-con.md) соединений {{ interconnect-name }}.

#### cic.secretEditor {#cic-secreteditor}

Роль `cic.secretEditor` позволяет получать и изменять секреты [приватных](../interconnect/concepts/priv-con.md) и [публичных](../interconnect/concepts/pub-con.md) соединений {{ interconnect-name }}.

Включает разрешения, предоставляемые ролью `cic.secretViewer`.

Подробнее см. [{#T}](../interconnect/security/index.md).


## {{ cloud-logging-full-name }} {#logging-roles}

#### logging.viewer {#logging-viewer}

Роль `logging.viewer` позволяет просматривать информацию о лог-группах, приемниках логов и назначенных правах доступа к ним, а также об облаке и каталоге.

Пользователи с этой ролью могут:
* просматривать информацию о [лог-группах](../logging/concepts/log-group.md);
* просматривать информацию о приемниках логов;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к ресурсам сервиса Cloud Logging;
* просматривать информацию о выгрузках логов;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

#### logging.editor {#logging-editor}

Роль `logging.editor` позволяет просматривать информацию о ресурсах сервиса и управлять ими.

Пользователи с этой ролью могут:
* просматривать информацию о [лог-группах](../logging/concepts/log-group.md), а также создавать, изменять, удалять и использовать их;
* просматривать информацию о приемниках логов, а также создавать, изменять, удалять и использовать их;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к ресурсам сервиса Cloud Logging;
* просматривать информацию о выгрузках логов, запускать выгрузку, а также создавать, изменять и удалять файлы выгрузки;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `logging.viewer`.

#### logging.reader {#logging-reader}

Роль `logging.reader` позволяет просматривать записи в лог-группах и информацию о ресурсах сервиса, а также метаинформацию облака и каталога.

Пользователи с этой ролью могут:
* просматривать записи в [лог-группах](../logging/concepts/log-group.md);
* просматривать информацию о лог-группах;
* просматривать информацию о приемниках логов;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к ресурсам сервиса Cloud Logging;
* просматривать информацию о выгрузках логов;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `logging.viewer`.

#### logging.writer {#logging-writer}

Роль `logging.writer` позволяет добавлять записи в лог-группы и просматривать информацию о ресурсах сервиса, а также об облаке и каталоге.

Пользователи с этой ролью могут:
* добавлять записи в [лог-группы](../logging/concepts/log-group.md);
* просматривать информацию о лог-группах;
* просматривать информацию о приемниках логов;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к ресурсам сервиса Cloud Logging;
* просматривать информацию о выгрузках логов;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `logging.viewer`.

#### logging.admin {#logging-admin}

Роль `logging.admin` позволяет управлять ресурсами сервиса и доступом к ним, а также просматривать и добавлять записи в лог-группы.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к ресурсам сервиса Cloud Logging и изменять такие права доступа;
* просматривать информацию о [лог-группах](../logging/concepts/log-group.md), а также создавать, изменять, удалять и использовать их;
* просматривать информацию о приемниках логов, а также создавать, изменять, удалять и использовать их;
* просматривать информацию о выгрузках логов, запускать выгрузку, а также создавать, изменять и удалять файлы выгрузки;
* просматривать и добавлять записи в лог-группы;
* просматривать информацию о [квотах](../logging/concepts/limits.md#logging-quotas) сервиса Cloud Logging.
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролями `logging.editor`, `logging.reader` и `logging.writer`.

Подробнее см. [{#T}](../logging/security/index.md).


## {{ marketplace-full-name }} {#marketplace-roles}

### Роли партнера {#marketplace-partner-roles}

#### marketplace.meteringAgent {#marketplace-meteringagent}

Роль `marketplace.meteringAgent` позволяет регистрировать потребление [продуктов](../marketplace/concepts/product.md) Marketplace.

Роль позволяет [партнеру](../marketplace/quickstart.md):
* авторизовывать приложения в Metering API;
* отслеживать установленные [метрики приложений](../marketplace/concepts/api-usage.md#guidelines), чтобы [тарифицировать](../marketplace/concepts/tariff.md) их потребление.

Роль можно назначить на [сервисный аккаунт](concepts/users/service-accounts.md), от имени которого отправляются метрики потребления.

#### license-manager.saasSubscriptionSupervisor {#license-manager-saasSubscriptionSupervisor}

Роль `license-manager.saasSubscriptionSupervisor` позволяет просматривать информацию о [подписках](../marketplace/concepts/users/subscription.md) и их привязках к ресурсам, приложениям или сервисам, а также создавать такие привязки.

Роль предназначена для продуктов SaaS и может быть назначена на [сервисный аккаунт](concepts/users/service-accounts.md), от имени которого будут создаваться привязки к ресурсам, приложениям или сервисам.

#### marketplace.productInstances.saasSupervisor {#marketplace-productInstances-saasSupervisor}

Роль `marketplace.productInstances.saasSupervisor` позволяет просматривать информацию об установленных SaaS-[продуктах](../marketplace/concepts/product.md) Marketplace и активировать такие продукты.

#### marketplace.product.creator {#marketplace-product-creator}

Роль `marketplace.product.creator` позволяет создавать [продукты Marketplace](../marketplace/concepts/product.md) в [профиле партнера](../marketplace/quickstart.md#registration) и управлять доступом к таким продуктам.

#### marketplace.product.admin {#marketplace-product-admin}

Роль `marketplace.product.admin` позволяет управлять продуктами Marketplace и доступом к ним, а также их версиями, тарифами, пробными периодами, формами и заявками на модерацию.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных правах доступа к продуктам, а также изменять такие права доступа;
* просматривать информацию о [продуктах](../marketplace/concepts/product.md), а также создавать и изменять их;
* просматривать список [версий](../marketplace/concepts/version.md) продуктов и информацию о них, а также создавать, изменять и удалять версии продуктов;
* просматривать список [тарифов](../marketplace/concepts/tariff.md) на продукты и информацию о тарифах, а также создавать и редактировать тарифы;
* просматривать информацию о [пробных периодах](../marketplace/concepts/trial-period.md) продуктов, а также создавать, изменять и удалять пробные периоды;
* просматривать список заявок на модерацию продуктов и информацию о таких заявках, а также создавать, изменять, применять и удалять их;
* просматривать список форм продуктов и информацию о них, а также создавать, изменять и удалять формы продуктов;
* просматривать список категорий продуктов.

#### marketplace.publishers.reportViewer {#marketplace-publishers-reportViewer}

Роль `marketplace.publishers.reportViewer` позволяет просматривать отчеты по [продуктам Marketplace](../marketplace/concepts/product.md) в [профиле партнера](../marketplace/quickstart.md#registration).

#### marketplace.publishers.viewer {#marketplace-publishers-viewer}

Роль `marketplace.publishers.viewer` позволяет просматривать информацию о профиле партнера и продуктах Marketplace в нем, а также обращаться в техническую поддержку.

Пользователи с этой ролью могут:
* просматривать список доступных [профилей партнера](../marketplace/quickstart.md#registration), информацию о них и о назначенных правах доступа к ним;
* просматривать список [версий](../marketplace/concepts/version.md) продуктов партнера и информацию о таких версиях;
* просматривать список заявок на модерацию продуктов партнера и информацию о таких заявках;
* создавать [обращения](../support/overview.md) в техническую поддержку, просматривать их и оставлять в них комментарии, а также закрывать такие обращения.

Включает разрешения, предоставляемые ролью `marketplace.publishers.member`.

#### marketplace.publishers.editor {#marketplace-publishers-editor}

Роль `marketplace.publishers.editor` позволяет управлять продуктами Marketplace и доступом к ним, их версиями, тарифами, пробными периодами, формами и заявками на модерацию, а также обращаться в техническую поддержку.

Пользователи с этой ролью могут:
* просматривать список доступных [профилей партнера](../marketplace/quickstart.md#registration), информацию о них и о назначенных правах доступа к ним;
* просматривать информацию о назначенных правах доступа к продуктам, а также изменять такие права доступа;
* просматривать информацию о [продуктах](../marketplace/concepts/product.md), а также создавать и изменять их;
* просматривать список [версий](../marketplace/concepts/version.md) продуктов и информацию о них, а также создавать, изменять и удалять версии продуктов;
* просматривать список [тарифов](../marketplace/concepts/tariff.md) на продукты и информацию о тарифах, а также создавать и редактировать тарифы;
* просматривать список [пробных периодов](../marketplace/concepts/trial-period.md) продуктов и информацию о них, а также создавать, изменять и удалять пробные периоды;
* просматривать список заявок на модерацию продуктов и информацию о таких заявках, а также создавать, изменять, применять и удалять их;
* просматривать список форм продуктов и информацию о них, а также создавать, изменять и удалять формы продуктов;
* просматривать список категорий продуктов;
* создавать [обращения](../support/overview.md) в техническую поддержку, просматривать их и оставлять в них комментарии, а также закрывать такие обращения.

Включает разрешения, предоставляемые ролями `marketplace.publishers.viewer` и `marketplace.product.admin`.

#### marketplace.publishers.admin {#marketplace-publishers-admin}

Роль `marketplace.publishers.admin` позволяет управлять доступом к профилю партнера, управлять продуктами Marketplace и доступом к ним, их версиями, тарифами, пробными периодами, формами и заявками на модерацию, а также просматривать отчеты по продуктам Marketplace в профиле партнера.

Пользователи с этой ролью могут:
* просматривать список доступных [профилей партнера](../marketplace/quickstart.md#registration), информацию о них и о назначенных правах доступа к ним, а также изменять такие права доступа;
* просматривать информацию о назначенных правах доступа к продуктам, а также изменять такие права доступа;
* просматривать информацию о [продуктах](../marketplace/concepts/product.md), а также создавать и изменять их;
* просматривать список [версий](../marketplace/concepts/version.md) продуктов и информацию о них, а также создавать, изменять и удалять версии продуктов;
* просматривать список [тарифов](../marketplace/concepts/tariff.md) на продукты и информацию о тарифах, а также создавать и редактировать тарифы;
* просматривать информацию о [пробных периодах](../marketplace/concepts/trial-period.md) продуктов, а также создавать, изменять и удалять пробные периоды;
* просматривать список заявок на модерацию продуктов и информацию о таких заявках, а также создавать, изменять, применять и удалять их;
* просматривать список форм продуктов и информацию о них, а также создавать, изменять и удалять формы продуктов;
* просматривать список категорий продуктов;
* просматривать отчеты по продуктам Marketplace в профиле партнера;
* создавать [обращения](../support/overview.md) в техническую поддержку, просматривать их и оставлять в них комментарии, а также закрывать такие обращения.

Включает разрешения, предоставляемые ролями `marketplace.publishers.editor` и `marketplace.publishers.reportViewer`.

#### marketplace.publishers.owner {#marketplace-publishers-owner}

Роль `marketplace.publishers.owner` позволяет управлять доступом к профилю партнера, управлять продуктами Marketplace и доступом к ним, их версиями, тарифами, пробными периодами, формами и заявками на модерацию, а также просматривать отчеты по продуктам Marketplace в профиле партнера.

Роль выдается владельцу платежного аккаунта при создании профиля партнера и не может быть переназначена.

Пользователи с этой ролью могут:
* просматривать список доступных [профилей партнера](../marketplace/quickstart.md#registration), информацию о них и о назначенных правах доступа к ним, а также изменять такие права доступа;
* просматривать информацию о назначенных правах доступа к продуктам, а также изменять такие права доступа;
* просматривать информацию о [продуктах](../marketplace/concepts/product.md), а также создавать и изменять их;
* просматривать список [версий](../marketplace/concepts/version.md) продуктов и информацию о них, а также создавать, изменять и удалять версии продуктов;
* просматривать список [тарифов](../marketplace/concepts/tariff.md) на продукты и информацию о тарифах, а также создавать и редактировать тарифы;
* просматривать список [пробных периодов](../marketplace/concepts/trial-period.md) продуктов и информацию о них, а также создавать, изменять и удалять пробные периоды;
* просматривать список заявок на модерацию продуктов и информацию о таких заявках, а также создавать, изменять, применять и удалять их;
* просматривать список форм продуктов и информацию о них, а также создавать, изменять и удалять формы продуктов;
* просматривать список категорий продуктов;
* просматривать отчеты по продуктам Marketplace в профиле партнера;
* создавать [обращения](../support/overview.md) в техническую поддержку, просматривать их и оставлять в них комментарии, а также закрывать такие обращения.

Включает разрешения, предоставляемые ролью `marketplace.publishers.admin`.

#### marketplace.publishers.member {#marketplace-publishers-member}

Роль `marketplace.publishers.member` предоставляет права участника [профиля партнера](../marketplace/quickstart.md#registration), но не дает доступа к ресурсам профиля. Чтобы предоставить пользователю доступ к [продуктам](../marketplace/concepts/product.md) или отчетам в профиле партнера, дополнительно назначьте ему роль `marketplace.publishers.viewer`, `marketplace.publishers.editor`, `marketplace.publishers.admin` или `marketplace.publishers.owner`.

Подробнее см. [{#T}](../marketplace/security/partners.md).


### Роли пользователя {#marketplace-user-roles}

#### license-manager.auditor {#license-manager-auditor}

Роль `license-manager.auditor` позволяет просматривать информацию о [подписках](../marketplace/concepts/users/subscription.md).

#### license-manager.viewer {#license-manager-viewer}

Роль `license-manager.viewer` позволяет просматривать информацию о [подписках](../marketplace/concepts/users/subscription.md) и их [привязках](../marketplace/operations/users/lock-subscription.md) к ресурсу, приложению или сервису.

Включает разрешения, предоставляемые ролью `license-manager.auditor`.

#### license-manager.user {#license-manager-user}

Роль `license-manager.user` позволяет управлять подписками, а также просматривать информацию о них и их привязках к ресурсам, приложениям или сервисам.

Пользователи с этой ролью могут:
* просматривать информацию о [подписках](../marketplace/concepts/users/subscription.md) и их привязках к ресурсам, приложениям или сервисам; 
* [покупать](../marketplace/operations/users/buy-subscription.md) подписки;
* [отключать](../marketplace/operations/users/cancel-subscription.md) автопродление подписок;
* [привязывать](../marketplace/operations/users/lock-subscription.md) подписки к ресурсам, приложениям или сервисам и [отвязывать](../marketplace/operations/users/unlock-subscription.md) подписки от них;
* [перемещать](../marketplace/operations/users/move-subscription.md) подписки между каталогами.

Включает разрешения, предоставляемые ролью `license-manager.viewer`.

#### license-manager.subscriptionAgent {#license-manager-subscriptionAgent}

Роль `license-manager.subscriptionAgent` позволяет [привязывать](../marketplace/operations/users/lock-subscription.md) подписки к ресурсам, приложениям или сервисам, а также просматривать информацию о [подписках](../marketplace/concepts/users/subscription.md) и их привязках к ресурсам, приложениям или сервисам.

#### marketplace.productInstances.auditor {#marketplace-productInstances-auditor}

Роль `marketplace.productInstances.auditor` позволяет просматривать информацию об установленных [продуктах](../marketplace/concepts/product.md) Marketplace и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также просматривать метаданные [каталога](../resource-manager/concepts/resources-hierarchy.md#folder).

#### marketplace.productInstances.viewer {#marketplace-productInstances-viewer}

Роль `marketplace.productInstances.viewer` позволяет просматривать информацию об установленных [продуктах](../marketplace/concepts/product.md) Marketplace и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `marketplace.productInstances.auditor`.

#### marketplace.productInstances.user {#marketplace-productInstances-user}

Роль `marketplace.productInstances.user` позволяет просматривать информацию об установленных [продуктах](../marketplace/concepts/product.md) Marketplace, активировать и деактивировать их, просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к ним, а также информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `marketplace.productInstances.viewer`.

#### marketplace.productInstances.editor {#marketplace-productInstances-editor}

Роль `marketplace.productInstances.editor` позволяет управлять установленными продуктами Marketplace.

Пользователи с этой ролью могут:
* просматривать информацию об установленных [продуктах](../marketplace/concepts/product.md) Marketplace и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* создавать продукты Marketplace, изменять их метаданные, а также активировать и деактивировать продукты Marketplace;
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `marketplace.productInstances.user`.

#### marketplace.productInstances.admin {#marketplace-productInstances-admin}

Роль `marketplace.productInstances.admin` позволяет управлять установленными продуктами Marketplace и доступом к ним.

Пользователи с этой ролью могут:
* просматривать информацию об установленных [продуктах](../marketplace/concepts/product.md) Marketplace;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к установленным продуктам Marketplace и изменять такие права доступа;
* создавать продукты Marketplace, изменять их метаданные, а также активировать и деактивировать продукты Marketplace;
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `marketplace.productInstances.editor`.

Подробнее см. [{#T}](../marketplace/security/index.md).


## {{ cns-full-name }} {#cns-roles}

#### notifications.auditor {#notifications-auditor}

Роль `notifications.auditor` позволяет просматривать метаданные всех [каналов уведомлений](../notifications/concepts/index.md#channels), метаданные [топиков](../notifications/concepts/topics.md), а также информацию о [квотах](../notifications/concepts/limits.md) сервиса Cloud Notification Service.

#### notifications.viewer {#notifications-viewer}

Роль `notifications.viewer` позволяет просматривать информацию о топиках и каналах уведомлений, а также о квотах сервиса Cloud Notification Service.

Пользователи с этой ролью могут:
* просматривать информацию о [топиках](../notifications/concepts/topics.md) и подписках в них;
* просматривать информацию о каналах [мобильных Push-уведомлений](../notifications/concepts/push.md) и их [эндпоинтах](../notifications/concepts/push.md#mobile-endpoints);
* просматривать информацию о каналах [Push-уведомлений в браузере](../notifications/concepts/browser.md) и их [эндпоинтах](../notifications/concepts/browser.md#create-endpoint);
* просматривать информацию о каналах [SMS-уведомлений](../notifications/concepts/sms.md), [шаблонах](../notifications/concepts/sms.md#templates) SMS и [тестовых](../notifications/concepts/sms.md#sandbox) телефонных номерах;
* просматривать информацию о [квотах](../notifications/concepts/limits.md) сервиса Cloud Notification Service.

Включает разрешения, предоставляемые ролью `notifications.auditor`.

#### notifications.publisher {#notifications-publisher}

Роль `notifications.publisher` позволяет отправлять уведомления во все [каналы](../notifications/concepts/index.md#channels) и [топики](../notifications/concepts/topics.md).

#### notifications.editor {#notifications-editor}

Роль `notifications.editor` позволяет управлять всеми каналами уведомлений и топиками, а также отправлять уведомления во все каналы и топики.

Пользователи с этой ролью могут:
* просматривать информацию о [топиках](../notifications/concepts/topics.md), создавать, изменять и удалять их;
* просматривать информацию о подписках в топиках, а также создавать и удалять их;
* просматривать информацию о каналах [мобильных Push-уведомлений](../notifications/concepts/push.md) и их [эндпоинтах](../notifications/concepts/push.md#mobile-endpoints), а также создавать, изменять и удалять каналы мобильных Push-уведомлений и их эндпоинты;
* просматривать информацию о каналах [Push-уведомлений в браузере](../notifications/concepts/browser.md) и их [эндпоинтах](../notifications/concepts/browser.md#create-endpoint), а также создавать, изменять и удалять каналы Push-уведомлений в браузере и их эндпоинты;
* просматривать информацию о каналах [SMS-уведомлений](../notifications/concepts/sms.md), а также создавать, изменять и удалять их;
* просматривать информацию о [шаблонах](../notifications/concepts/sms.md#templates) SMS и [тестовых](../notifications/concepts/sms.md#sandbox) телефонных номерах, а также изменять их;
* отправлять уведомления во все топики и каналы;
* просматривать информацию о [квотах](../notifications/concepts/limits.md) сервиса Cloud Notification Service.

Включает разрешения, предоставляемые ролями `notifications.viewer` и `notifications.publisher`.

#### notifications.admin {#notifications-admin}

Роль `notifications.admin` позволяет управлять всеми каналами уведомлений и топиками, а также отправлять уведомления во все каналы и топики.

Пользователи с этой ролью могут:
* просматривать информацию о [топиках](../notifications/concepts/topics.md), создавать, изменять и удалять их;
* просматривать информацию о подписках в топиках, а также создавать и удалять их;
* просматривать информацию о каналах [мобильных Push-уведомлений](../notifications/concepts/push.md) и их [эндпоинтах](../notifications/concepts/push.md#mobile-endpoints), а также создавать, изменять и удалять каналы мобильных Push-уведомлений и их эндпоинты;
* просматривать информацию о каналах [Push-уведомлений в браузере](../notifications/concepts/browser.md) и их [эндпоинтах](../notifications/concepts/browser.md#create-endpoint), а также создавать, изменять и удалять каналы Push-уведомлений в браузере и их эндпоинты;
* просматривать информацию о каналах [SMS-уведомлений](../notifications/concepts/sms.md), а также создавать, изменять и удалять их;
* просматривать информацию о [шаблонах](../notifications/concepts/sms.md#templates) SMS и [тестовых](../notifications/concepts/sms.md#sandbox) телефонных номерах, а также изменять их;
* отправлять уведомления во все топики и каналы;
* просматривать информацию о [квотах](../notifications/concepts/limits.md) сервиса Cloud Notification Service.

Включает разрешения, предоставляемые ролью `notifications.editor`.

Подробнее см. [{#T}](../notifications/security/index.md).


## {{ postbox-full-name }} {#postbox-roles}

#### postbox.sender {#postbox-sender}

Роль `postbox.sender` позволяет отправлять письма из Yandex Cloud Postbox.

#### postbox.auditor {#postbox-auditor}

Роль `postbox.auditor` позволяет просматривать информацию об адресах Yandex Cloud Postbox.

Пользователи с этой ролью могут:
* просматривать информацию об [адресах](../postbox/concepts/glossary.md#adress) и их [конфигурациях](../postbox/concepts/glossary.md#configuration);
* получать списки адресов и их конфигураций.

#### postbox.viewer {#postbox-viewer}

Роль `postbox.viewer` позволяет просматривать информацию об адресах Yandex Cloud Postbox.

Пользователи с этой ролью могут:
* просматривать информацию об [адресах](../postbox/concepts/glossary.md#adress) и их [конфигурациях](../postbox/concepts/glossary.md#configuration);
* получать списки адресов и их конфигураций.

Включает разрешения, предоставляемые ролью `postbox.auditor`.

#### postbox.editor {#postbox-editor}

Роль `postbox.editor` позволяет управлять адресами Yandex Cloud Postbox и отправлять письма.

Пользователи с этой ролью могут:
* создавать, изменять и удалять [адреса](../postbox/concepts/glossary.md#adress) и их [конфигурации](../postbox/concepts/glossary.md#configuration);
* просматривать информацию об адресах и их конфигурациях;
* получать список адресов и их конфигураций;
* отправлять письма.

Включает разрешения, предоставляемые ролью `postbox.viewer`.

#### postbox.messages.reader {#postbox-messages-reader}

Роль `postbox.messages.reader` позволяет просматривать в разделе **{{ ui-key.yacloud.postbox.label_messages }}** [консоли управления]({{ link-console-main }}) информацию об отправленных письмах, включая сведения об отправителе, получателях, теме, дате отправки, а также о [метриках](../postbox/concepts/statistics.md#metrics) доставки и вовлеченности, жалобах и отписках.

#### postbox.statistics.reader {#postbox-statistics-reader}

Роль `postbox.statistics.reader` позволяет просматривать [статистику](../postbox/concepts/statistics.md) по отправленным письмам в разделе **{{ ui-key.yacloud.postbox.label_statistics }}** [консоли управления]({{ link-console-main }}).

#### postbox.admin {#postbox-admin}

Роль `postbox.admin` позволяет управлять адресами Yandex Cloud Postbox, отправлять письма, а также просматривать информацию об отправленных письмах и статистику по ним.

Пользователи с этой ролью могут:
* создавать, изменять и удалять [адреса](../postbox/concepts/glossary.md#adress) и их [конфигурации](../postbox/concepts/glossary.md#configuration);
* просматривать информацию об адресах и их конфигурациях;
* получать список адресов и их конфигураций;
* отправлять письма;
* просматривать [статистику](../postbox/concepts/statistics.md) по отправленным письмам в разделе **{{ ui-key.yacloud.postbox.label_statistics }}** [консоли управления]({{ link-console-main }});
* просматривать в разделе **{{ ui-key.yacloud.postbox.label_messages }}** консоли управления информацию об отправленных письмах, включая сведения об отправителе, получателях, теме, дате отправки, а также о [метриках](../postbox/concepts/statistics.md#metrics) доставки и вовлеченности, жалобах и отписках.

Включает разрешения, предоставляемые ролями `postbox.editor`, `postbox.messages.reader` и `postbox.statistics.reader`.

Подробнее см. [{#T}](../postbox/security/index.md).


## {{ cloud-registry-full-name }} {#cloud-registry-roles}

#### cloud-registry.auditor {#cloud-registry-auditor}

Роль `cloud-registry.auditor` позволяет просматривать метаданные артефактов, информацию о реестрах и назначенных правах доступа к ним, а также о квотах сервиса {{ cloud-registry-name }}.

Пользователи с этой ролью могут:
* просматривать метаданные [артефактов](../cloud-registry/concepts/artifacts/index.md);
* просматривать информацию о [реестрах](../cloud-registry/concepts/registry.md);
* просматривать список IP-разрешений реестров;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к реестрам и папкам внутри реестров;
* просматривать информацию о квотах сервиса {{ cloud-registry-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

#### cloud-registry.viewer {#cloud-registry-viewer}

Роль `cloud-registry.viewer` позволяет скачивать артефакты, просматривать информацию об артефактах и реестрах, о назначенных правах доступа к реестрам, а также о квотах сервиса {{ cloud-registry-name }}.

Пользователи с этой ролью могут:
* просматривать информацию об [артефактах](../cloud-registry/concepts/artifacts/index.md) и скачивать их;
* просматривать информацию о [реестрах](../cloud-registry/concepts/registry.md);
* просматривать список IP-разрешений реестров;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к реестрам и папкам внутри реестров;
* просматривать информацию о квотах сервиса {{ cloud-registry-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `cloud-registry.auditor`.

#### cloud-registry.editor {#cloud-registry-editor}

Роль `cloud-registry.editor` позволяет управлять артефактами и реестрами, а также просматривать информацию о назначенных правах доступа к реестрам и квотах сервиса {{ cloud-registry-name }}.

Пользователи с этой ролью могут:
* просматривать информацию об [артефактах](../cloud-registry/concepts/artifacts/index.md), а также создавать, изменять, скачивать и удалять их;
* просматривать информацию о [реестрах](../cloud-registry/concepts/registry.md), а также создавать, изменять и удалять их;
* создавать и удалять папки внутри реестров;
* просматривать список IP-разрешений реестров;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к реестрам и папкам внутри реестров;
* просматривать информацию о квотах сервиса {{ cloud-registry-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролями `cloud-registry.viewer` и `cloud-registry.artifacts.pusher`.

#### cloud-registry.admin {#cloud-registry-admin}

Роль `cloud-registry.admin` позволяет управлять артефактами, реестрами и доступом к реестрам, а также просматривать информацию о квотах сервиса {{ cloud-registry-name }}.

Пользователи с этой ролью могут:
* просматривать информацию об [артефактах](../cloud-registry/concepts/artifacts/index.md), а также создавать, изменять, скачивать и удалять их;
* просматривать информацию о [реестрах](../cloud-registry/concepts/registry.md), а также создавать, изменять и удалять их;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к реестрам и папкам внутри реестров, а также изменять такие права доступа;
* создавать и удалять папки внутри реестров;
* просматривать и изменять список IP-разрешений реестров;
* просматривать информацию о квотах сервиса {{ cloud-registry-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `cloud-registry.editor`.

#### cloud-registry.artifacts.puller {#cloud-registry-artifacts-puller}

Роль `cloud-registry.artifacts.puller` позволяет скачивать [артефакты](../cloud-registry/concepts/artifacts/index.md), а также получать информацию об артефактах и [реестрах](../cloud-registry/concepts/registry.md).

#### cloud-registry.artifacts.pusher {#cloud-registry-artifacts-pusher}

Роль `cloud-registry.artifacts.pusher` позволяет управлять артефактами, а также просматривать информацию о реестрах и управлять папками в них.

Пользователи с этой ролью могут:
* просматривать информацию об [артефактах](../cloud-registry/concepts/artifacts/index.md), а также создавать, изменять, скачивать и удалять их;
* просматривать информацию о [реестрах](../cloud-registry/concepts/registry.md);
* создавать и удалять папки внутри реестров.

Подробнее см. [{#T}](../cloud-registry/security/index.md).



## {{ cr-full-name }} {#cloudrouter-roles}

#### cloud-router.auditor {#cloudrouter-auditor}

Роль `cloud-router.auditor` позволяет просматривать информацию о ресурсах сервиса Cloud Router.

Пользователи с этой ролью могут:
* просматривать информацию о [Routing Instance](../cloud-router/concepts/routing-instance.md);
* просматривать информацию о квотах сервиса Cloud Router;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

#### cloud-router.viewer {#cloudrouter-viewer}

Роль `cloud-router.viewer` позволяет просматривать информацию о ресурсах сервиса Cloud Router.

"Пользователи с этой ролью могут:
* просматривать информацию о [Routing Instance](../cloud-router/concepts/routing-instance.md);
* просматривать информацию о квотах сервиса Cloud Router;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `cloud-router.auditor`.

#### cloud-router.prefixEditor {#cloudrouter-prefixEditor}

Роль `cloud-router.prefixEditor` позволяет управлять IP-префиксами облачных подсетей в Routing Instance, а также просматривать информацию о ресурсах сервиса Cloud Router.

"Пользователи с этой ролью могут:
* просматривать информацию о [Routing Instance](../cloud-router/concepts/routing-instance.md);
* добавлять, изменять и удалять [IP-префиксы](../cloud-router/concepts/announces.md) облачных [подсетей](../vpc/concepts/network.md#subnet) в Routing Instance;
* просматривать информацию о квотах сервиса Cloud Router;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `cloud-router.viewer`.

#### cloud-router.editor {#cloudrouter-editor}

Роль `cloud-router.editor` позволяет управлять Routing Instance, а также просматривать информацию о ресурсах сервиса Cloud Router.

Пользователи с этой ролью могут:
* просматривать информацию о [Routing Instance](../cloud-router/concepts/routing-instance.md), а также создавать, изменять и удалять их;
* добавлять, изменять и удалять [IP-префиксы](../cloud-router/concepts/announces.md) облачных [подсетей](../vpc/concepts/network.md#subnet) в Routing Instance;
* просматривать информацию о квотах сервиса Cloud Router;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `cloud-router.prefixEditor`.

#### cloud-router.admin {#cloudrouter-admin}

Роль `cloud-router.admin` позволяет управлять ресурсами сервиса Cloud Router.

Пользователи с этой ролью могут:
* просматривать информацию о [Routing Instance](../cloud-router/concepts/routing-instance.md), а также создавать, изменять и удалять их;
* добавлять, изменять и удалять [IP-префиксы](../cloud-router/concepts/announces.md) облачных [подсетей](../vpc/concepts/network.md#subnet) в Routing Instance;
* просматривать информацию о квотах сервиса Cloud Router;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `cloud-router.editor`.

Подробнее см. [{#T}](../cloud-router/security/index.md).


## {{ video-full-name }} {#video-roles}

#### video.auditor {#video-auditor}

Роль `video.auditor` позволяет просматривать информацию о ресурсах сервиса {{ video-name }} или отдельного [канала](../video/concepts/index.md#channels), их настройках и назначенных [правах доступа](concepts/access-control/index.md).

#### video.viewer {#video-viewer}

Роль `video.viewer` позволяет просматривать информацию о ресурсах сервиса {{ video-name }} или отдельного канала, их настройках и назначенных правах доступа.

Пользователи с этой ролью могут:
* просматривать информацию о ресурсах сервиса {{ video-name }} и их настройках;
* скачивать исходные файлы [видео](../video/concepts/videos.md) и их [субтитров](../video/concepts/videos.md#subtitles), а также изображения обложек видео;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к [каналам](../video/concepts/index.md#channels) {{ video-name }}.

Включает разрешения, предоставляемые ролью `video.auditor`.

#### video.editor {#video-editor}

Роль `video.editor` позволяет управлять ресурсами сервиса {{ video-name }} или отдельного канала, а также выполнять трансляцию видеопотока.

Пользователи с этой ролью могут:
* просматривать информацию о ресурсах сервиса {{ video-name }} и их настройках, а также создавать, изменять и удалять такие ресурсы;
* выполнять [трансляцию](../video/concepts/streams.md#streams) видеопотока {{ video-name }} в прямом эфире;
* скачивать исходные файлы [видео](../video/concepts/videos.md) и их [субтитров](../video/concepts/videos.md#subtitles), а также изображения обложек видео;
* использовать возможности ИИ, такие как [суммаризация](../video/concepts/videos.md#summarization) и [нейроперевод](../video/concepts/videos.md#stranslation) видео;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к [каналам](../video/concepts/index.md#channels) {{ video-name }}.

Включает разрешения, предоставляемые ролью `video.viewer`.

#### video.admin {#video-admin}

Роль `video.admin` позволяет управлять ресурсами сервиса {{ video-name }} или отдельного канала, назначать права доступа ко всем ресурсам или ресурсам канала.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к [каналам](../video/concepts/index.md#channels) {{ video-name }} и изменять такие права доступа;
* просматривать информацию о ресурсах сервиса {{ video-name }} и их настройках, а также создавать, изменять и удалять такие ресурсы;
* выполнять [трансляцию](../video/concepts/streams.md#streams) видеопотока {{ video-name }} в прямом эфире;
* скачивать исходные файлы [видео](../video/concepts/videos.md) и их [субтитров](../video/concepts/videos.md#subtitles), а также изображения обложек видео;
* использовать возможности ИИ, такие как [суммаризация](../video/concepts/videos.md#summarization) и [нейроперевод](../video/concepts/videos.md#stranslation) видео.

Включает разрешения, предоставляемые ролью `video.editor`.


## {{ compute-full-name }} {#compute-roles}

#### compute.auditor {#compute-auditor}

Роль `compute.auditor` позволяет просматривать информацию о ресурсах сервиса {{ compute-name }} и операциях с ними, а также об объеме использованных ресурсов и квот. Не позволяет получать доступ к последовательному порту или серийной консоли виртуальных машин.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать список [виртуальных машин](../compute/concepts/vm.md) и информацию о них;
* просматривать список [групп виртуальных машин](../compute/concepts/instance-groups/index.md) и информацию о них;
* просматривать список [групп размещения виртуальных машин](../compute/concepts/placement-groups.md) и информацию о них;
* просматривать списки ВМ, входящих в группы размещения;
* просматривать список [групп выделенных хостов](../compute/concepts/dedicated-host.md#host-group-size) и информацию о них;
* просматривать списки [хостов](../compute/concepts/dedicated-host.md) и виртуальных машин, входящих в группы выделенных хостов;
* просматривать информацию о [кластерах GPU](../compute/concepts/gpus.md#gpu-clusters) и виртуальных машинах, входящих в такие кластеры;
* просматривать список [дисков](../compute/concepts/disk.md) и информацию о них;
* просматривать список [файловых хранилищ](../compute/concepts/filesystem.md) и информацию о них;
* просматривать список [групп размещения нереплицируемых дисков](../compute/concepts/disk-placement-group.md) и информацию о них;
* просматривать списки дисков, входящих в группы размещения;
* просматривать информацию о [пулах резервов ВМ](../compute/concepts/reserved-pools.md);
* просматривать список [образов](../compute/concepts/image.md) и информацию о них;
* просматривать информацию о [семействах образов](../compute/concepts/image.md#family), о входящих в семейства образах, о наиболее актуальном образе в семействе, а также о назначенных [правах доступа](concepts/access-control/index.md) к семействам образов;
* просматривать список [снимков дисков](../compute/concepts/snapshot.md) и информацию о них;
* просматривать информацию о [расписаниях](../compute/concepts/snapshot-schedule.md) создания снимков дисков;
* просматривать в консоли управления информацию об объеме потребления ресурсов и [квот](../compute/concepts/limits.md#compute-quotas) сервиса {{ compute-name }}, о [лимитах дисков](../compute/concepts/limits.md#compute-limits-disks);
* просматривать списки операций с ресурсами сервиса {{ compute-name }}, а также информацию об этих операциях;
* просматривать информацию о статусе настройки доступа по [{{ oslogin }}](../organization/concepts/os-login.md) на виртуальных машинах;
* просматривать информацию о доступных [платформах](../compute/concepts/vm-platforms.md);
* просматривать список [зон доступности](../overview/concepts/geo-scope.md) и информацию о них.

{% endcut %}

#### compute.viewer {#compute-viewer}

Роль `compute.viewer` позволяет просматривать информацию о ресурсах сервиса {{ compute-name }} и операциях с ними, а также о назначенных правах доступа к ресурсам сервиса и об объеме использованных ресурсов и квот. Роль также предоставляет доступ к метаданным и выводу последовательного порта виртуальных машин.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать [вывод последовательного порта](../compute/operations/vm-info/get-serial-port-output.md) виртуальной машины;
* просматривать [метаданные](../compute/concepts/vm-metadata.md) виртуальной машины;
* просматривать список [виртуальных машин](../compute/concepts/vm.md), информацию о них и о назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать список [групп виртуальных машин](../compute/concepts/instance-groups/index.md) и информацию о них;
* просматривать список [групп размещения виртуальных машин](../compute/concepts/placement-groups.md), информацию о них и о назначенных правах доступа к ним;
* просматривать списки ВМ, входящих в группы размещения;
* просматривать список [групп выделенных хостов](../compute/concepts/dedicated-host.md#host-group-size), информацию о них и о назначенных правах доступа к ним;
* просматривать списки [хостов](../compute/concepts/dedicated-host.md) и виртуальных машин, входящих в группы выделенных хостов;
* просматривать информацию о [кластерах GPU](../compute/concepts/gpus.md#gpu-clusters) и виртуальных машинах, входящих в кластеры GPU, а также о назначенных правах доступа к таким кластерам;
* просматривать список [дисков](../compute/concepts/disk.md), информацию о них и о назначенных правах доступа к ним;
* просматривать список [файловых хранилищ](../compute/concepts/filesystem.md), информацию о них и о назначенных правах доступа к ним;
* просматривать список [групп размещения нереплицируемых дисков](../compute/concepts/disk-placement-group.md), информацию о них и о назначенных правах доступа к ним;
* просматривать списки дисков, входящих в группы размещения;
* просматривать информацию о [пулах резервов ВМ](../compute/concepts/reserved-pools.md);
* просматривать список [образов](../compute/concepts/image.md), информацию о них и о назначенных правах доступа к ним;
* просматривать информацию о [семействах образов](../compute/concepts/image.md#family), о входящих в семейства образах, о наиболее актуальном образе в семействе, а также о назначенных правах доступа к семействам образов;
* просматривать список [снимков дисков](../compute/concepts/snapshot.md), информацию о них и о назначенных правах доступа к ним;
* просматривать информацию о [расписаниях](../compute/concepts/snapshot-schedule.md) создания снимков дисков и о назначенных правах доступа к расписаниям;
* просматривать в консоли управления информацию об объеме потребления ресурсов и [квот](../compute/concepts/limits.md#compute-quotas) сервиса {{ compute-name }}, о [лимитах дисков](../compute/concepts/limits.md#compute-limits-disks);
* просматривать списки операций с ресурсами сервиса {{ compute-name }}, а также информацию об этих операциях;
* просматривать информацию о статусе настройки доступа по [{{ oslogin }}](../organization/concepts/os-login.md) на виртуальных машинах;
* просматривать информацию о доступных [платформах](../compute/concepts/vm-platforms.md);
* просматривать список [зон доступности](../overview/concepts/geo-scope.md), информацию о них и о назначенных правах доступа к ним.

{% endcut %}

Включает разрешения, предоставляемые ролями `compute.auditor` и `compute.snapshotSchedules.viewer`.

#### compute.editor {#compute-editor}

Роль `compute.editor` позволяет управлять виртуальными машинами, группами виртуальных машин, дисками, образами, кластерами GPU и другими ресурсами сервиса {{ compute-name }}.

{% cut "Пользователи с этой ролью могут:" %}

* создавать, изменять, запускать, перезапускать, останавливать, переносить и удалять [виртуальные машины](../compute/concepts/vm.md);
* просматривать список виртуальных машин, информацию о них и о назначенных [правах доступа](concepts/access-control/index.md) к ним;
* подключать к виртуальным машинам и отключать от них диски, файловые хранилища и сетевые интерфейсы, привязывать [группы безопасности](../vpc/concepts/security-groups.md) к сетевым интерфейсам виртуальных машин;
* создавать виртуальные машины с пользовательскими [FQDN](../vpc/concepts/address.md#fqdn), создавать мультиинтерфейсные виртуальные машины;
* привязывать [сервисные аккаунты](concepts/users/service-accounts.md) к виртуальным машинам, активировать на виртуальных машинах токен AWS v1;
* использовать [последовательный порт](../compute/operations/vm-info/get-serial-port-output.md) виртуальной машины в режиме чтения и записи;
* имитировать события обслуживания виртуальной машины;
* просматривать [метаданные](../compute/concepts/vm-metadata.md) виртуальной машины;
* просматривать информацию о статусе настройки доступа по [{{ oslogin }}](../organization/concepts/os-login.md) на виртуальных машинах и подключаться к виртуальным машинам через {{ oslogin }} с помощью SSH-сертификатов или SSH-ключей;
* просматривать список [групп виртуальных машин](../compute/concepts/instance-groups/index.md), информацию о них и о назначенных правах доступа к ним, а также использовать, создавать, изменять, запускать, останавливать и удалять группы виртуальных машин;
* просматривать список [групп размещения виртуальных машин](../compute/concepts/placement-groups.md), информацию о них и о назначенных правах доступа к ним, а также использовать, создавать, изменять и удалять группы размещения виртуальных машин;
* просматривать списки ВМ, входящих в группы размещения;
* просматривать список [групп выделенных хостов](../compute/concepts/dedicated-host.md#host-group-size), информацию о них и о назначенных правах доступа к ним, а также использовать, создавать, изменять и удалять группы выделенных хостов;
* просматривать списки [хостов](../compute/concepts/dedicated-host.md) и виртуальных машин, входящих в группы выделенных хостов;
* изменять запланированное время обслуживания хостов, входящих в группы выделенных хостов;
* использовать [кластеры GPU](../compute/concepts/gpus.md#gpu-clusters), а также создавать, изменять и удалять их;
* просматривать информацию о кластерах GPU и виртуальных машинах, входящих в кластеры GPU, а также о назначенных правах доступа к таким кластерам;
* просматривать информацию о [пулах резервов ВМ](../compute/concepts/reserved-pools.md), а также создавать, использовать, изменять и удалять их;
* просматривать список [дисков](../compute/concepts/disk.md), информацию о них и о назначенных правах доступа к ним, а также использовать, создавать, изменять, переносить и удалять диски;
* создавать [зашифрованные диски](../compute/concepts/disk.md#encryption);
* просматривать и обновлять ссылки на диски;
* просматривать список [файловых хранилищ](../compute/concepts/filesystem.md), информацию о них и о назначенных правах доступа к ним, а также использовать файловые хранилища и создавать, изменять и удалять их;
* просматривать список [групп размещения нереплицируемых дисков](../compute/concepts/disk-placement-group.md), информацию о них и о назначенных правах доступа к ним, а также использовать, создавать, изменять и удалять группы размещения нереплицируемых дисков;
* просматривать списки дисков, входящих в группы размещения;
* просматривать список [образов](../compute/concepts/image.md), информацию о них и о назначенных правах доступа к ним, а также использовать, создавать, изменять и удалять образы;
* создавать, изменять и удалять [семейства образов](../compute/concepts/image.md#family), обновлять образы в них;
* просматривать информацию о семействах образов, о входящих в семейства образах, о наиболее актуальном образе в семействе, а также о назначенных правах доступа к семействам образов;
* просматривать список [снимков дисков](../compute/concepts/snapshot.md), информацию о них и о назначенных правах доступа к ним, а также использовать, создавать, изменять и удалять снимки дисков;
* просматривать информацию о [расписаниях](../compute/concepts/snapshot-schedule.md) создания снимков дисков и о назначенных правах доступа к расписаниям, а также создавать, изменять и удалять их;
* просматривать информацию об [облачных сетях](../vpc/concepts/network.md#network) и использовать их;
* просматривать информацию о [подсетях](../vpc/concepts/network.md#subnet) и использовать их;
* просматривать информацию об [адресах облачных ресурсов](../vpc/concepts/address.md) и использовать их;
* просматривать информацию о [таблицах маршрутизации](../vpc/concepts/routing.md#rt-vpc) и использовать их;
* просматривать информацию о группах безопасности и использовать их;
* просматривать информацию о [NAT-шлюзах](../vpc/concepts/gateways.md) и подключать их к таблицам маршрутизации;
* просматривать информацию об использованных IP-адресах в подсетях;
* просматривать информацию об операциях с ресурсами сервиса {{ vpc-name }};
* просматривать информацию о [квотах](../vpc/concepts/limits.md#vpc-quotas) сервиса {{ vpc-name }};
* просматривать в консоли управления информацию об объеме потребления ресурсов и [квот](../compute/concepts/limits.md#compute-quotas) {{ compute-name }}, о [лимитах дисков](../compute/concepts/limits.md#compute-limits-disks);
* просматривать списки операций с ресурсами сервиса {{ compute-name }} и информацию об операциях, а также отменять выполнение этих операций;
* просматривать информацию о доступных [платформах](../compute/concepts/vm-platforms.md) и использовать их;
* просматривать список [зон доступности](../overview/concepts/geo-scope.md), информацию о них и о назначенных правах доступа к ним;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролями `compute.operator`, `compute.osLogin`, `compute.snapshotSchedules.editor`, `compute.disks.user` и `vpc.user`.

{% note warning %}

С 1 августа 2026 года роль `compute.editor` получает новый набор разрешений, позволяющий подключать виртуальные машины к сервису [{{ backup-full-name }}](../backup/index.md), а также привязывать и отвязывать их от [политик резервного копирования](../backup/concepts/policy.md).

Если вы не планируете подключать ваши ресурсы к {{ backup-name }} и не хотите предоставлять вашим пользователям такие разрешения, вы можете заблаговременно отключить эти возможности с помощью [политики авторизации](concepts/access-control/access-policies.md#backup-denyActivation) `backup.denyActivation`, назначенной на каталог, облако или организацию. Подробнее о том, как создать политику авторизации, читайте в разделе [{#T}](operations/access-policies/assign.md).

{% endnote %}

#### compute.admin {#compute-admin}

Роль `compute.admin` позволяет управлять виртуальными машинами, группами виртуальных машин, дисками, образами, кластерами GPU и другими ресурсами сервиса {{ compute-name }}, а также доступом к ним.

{% cut "Пользователи с этой ролью могут:" %}

* создавать, изменять, запускать, перезапускать, останавливать, переносить и удалять [виртуальные машины](../compute/concepts/vm.md), а также управлять доступом к ним;
* просматривать список виртуальных машин, информацию о них и о назначенных [правах доступа](concepts/access-control/index.md) к ним;
* подключать к виртуальным машинам и отключать от них диски, файловые хранилища и сетевые интерфейсы, привязывать [группы безопасности](../vpc/concepts/security-groups.md) к сетевым интерфейсам виртуальных машин;
* создавать виртуальные машины с пользовательскими [FQDN](../vpc/concepts/address.md#fqdn), создавать мультиинтерфейсные виртуальные машины;
* привязывать [сервисные аккаунты](concepts/users/service-accounts.md) к виртуальным машинам, активировать на виртуальных машинах токен AWS v1;
* использовать [последовательный порт](../compute/operations/vm-info/get-serial-port-output.md) виртуальной машины в режиме чтения и записи;
* имитировать события обслуживания виртуальной машины;
* просматривать [метаданные](../compute/concepts/vm-metadata.md) виртуальной машины;
* просматривать информацию о статусе настройки доступа по [{{ oslogin }}](../organization/concepts/os-login.md) на виртуальных машинах и подключаться к виртуальным машинам через {{ oslogin }} при помощи SSH-сертификатов или SSH-ключей с возможностью выполнять команды от имени суперпользователя (`sudo`);
* использовать, создавать, изменять, запускать, останавливать и удалять [группы виртуальных машин](../compute/concepts/instance-groups/index.md), а также управлять доступом к группам виртуальных машин;
* просматривать список групп виртуальных машин, информацию о них и о назначенных правах доступа к ним;
* использовать, создавать, изменять и удалять [группы размещения виртуальных машин](../compute/concepts/placement-groups.md), а также управлять доступом к группам размещения виртуальных машин;
* просматривать список групп размещения виртуальных машин, информацию о них и о назначенных правах доступа к ним;
* просматривать списки виртуальных машин, входящих в группы размещения;
* использовать, создавать, изменять и удалять [группы выделенных хостов](../compute/concepts/dedicated-host.md#host-group-size), а также управлять доступом к группам выделенных хостов;
* просматривать список групп выделенных хостов, информацию о них и о назначенных правах доступа к ним;
* просматривать списки [хостов](../compute/concepts/dedicated-host.md) и виртуальных машин, входящих в группы выделенных хостов;
* изменять запланированное время обслуживания хостов, входящих в группы выделенных хостов;
* использовать, создавать, изменять и удалять [кластеры GPU](../compute/concepts/gpus.md#gpu-clusters), а также управлять доступом к ним;
* просматривать информацию о кластерах GPU и виртуальных машинах, входящих в кластеры GPU, а также о назначенных правах доступа к таким кластерам;
* просматривать информацию о [пулах резервов ВМ](../compute/concepts/reserved-pools.md), а также создавать, использовать, изменять и удалять их;
* использовать, создавать, изменять, переносить и удалять [диски](../compute/concepts/disk.md), а также управлять доступом к ним;
* создавать [зашифрованные диски](../compute/concepts/disk.md#encryption);
* просматривать список дисков, информацию о них и о назначенных правах доступа к ним;
* просматривать и обновлять ссылки на диски;
* использовать, создавать, изменять и удалять [файловые хранилища](../compute/concepts/filesystem.md), а также управлять доступом к ним;
* просматривать список файловых хранилищ, информацию о них и о назначенных правах доступа к ним;
* использовать, создавать, изменять и удалять [группы размещения нереплицируемых дисков](../compute/concepts/disk-placement-group.md), а также управлять доступом к группам размещения нереплицируемых дисков;
* просматривать список групп размещения нереплицируемых дисков, информацию о них и о назначенных правах доступа к ним;
* просматривать списки дисков, входящих в группы размещения;
* использовать, создавать, изменять и удалять [образы](../compute/concepts/image.md), а также управлять доступом к ним;
* просматривать список образов, информацию о них и о назначенных правах доступа к ним;
* создавать, изменять, удалять [семейства образов](../compute/concepts/image.md#family) и обновлять образы в них, а также управлять доступом к семействам образов;
* просматривать информацию о семействах образов, о входящих в семейства образах, о наиболее актуальном образе в семействе, а также о назначенных правах доступа к семействам образов;
* использовать, создавать, изменять и удалять [снимки дисков](../compute/concepts/snapshot.md), а также управлять доступом к снимкам дисков;
* просматривать список снимков дисков, информацию о них и о назначенных правах доступа к ним;
* создавать, изменять и удалять [расписания создания снимков дисков](../compute/concepts/snapshot-schedule.md), а также управлять доступом к расписаниям;
* просматривать информацию о расписаниях создания снимков дисков и о назначенных правах доступа к расписаниям;
* просматривать информацию об [облачных сетях](../vpc/concepts/network.md#network) и использовать их;
* просматривать информацию о [подсетях](../vpc/concepts/network.md#subnet) и использовать их;
* просматривать информацию об [адресах облачных ресурсов](../vpc/concepts/address.md) и использовать их;
* просматривать информацию о [таблицах маршрутизации](../vpc/concepts/routing.md#rt-vpc) и использовать их;
* просматривать информацию о группах безопасности и использовать их;
* просматривать информацию о [NAT-шлюзах](../vpc/concepts/gateways.md) и подключать их к таблицам маршрутизации;
* просматривать информацию об использованных IP-адресах в подсетях;
* просматривать информацию об операциях с ресурсами сервиса {{ vpc-name }};
* просматривать информацию о [квотах](../vpc/concepts/limits.md#vpc-quotas) сервиса {{ vpc-name }};
* просматривать в консоли управления информацию об объеме потребления ресурсов и [квот](../compute/concepts/limits.md#compute-quotas) {{ compute-name }}, о [лимитах дисков](../compute/concepts/limits.md#compute-limits-disks);
* просматривать списки операций с ресурсами сервиса {{ compute-name }} и информацию об операциях, а также отменять выполнение этих операций;
* просматривать информацию о доступных [платформах](../compute/concepts/vm-platforms.md) и использовать их;
* просматривать список [зон доступности](../overview/concepts/geo-scope.md), информацию о них и о назначенных правах доступа к ним;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролями `compute.editor` и `compute.osAdminLogin`.

{% note warning %}

С 1 августа 2026 года роль `compute.admin` получает новый набор разрешений, позволяющий подключать виртуальные машины к сервису [{{ backup-full-name }}](../backup/index.md), а также привязывать и отвязывать их от [политик резервного копирования](../backup/concepts/policy.md).

Если вы не планируете подключать ваши ресурсы к {{ backup-name }} и не хотите предоставлять вашим пользователям такие разрешения, вы можете заблаговременно отключить эти возможности с помощью [политики авторизации](concepts/access-control/access-policies.md#backup-denyActivation) `backup.denyActivation`, назначенной на каталог, облако или организацию. Подробнее о том, как создать политику авторизации, читайте в разделе [{#T}](operations/access-policies/assign.md).

{% endnote %}

#### compute.osLogin {#compute-oslogin}

Роль `compute.osLogin` позволяет подключаться к [виртуальным машинам](../compute/concepts/vm.md) через [{{ oslogin }}](../organization/concepts/os-login.md) с помощью SSH-сертификатов или SSH-ключей.

#### compute.osAdminLogin {#compute-osadminlogin}

Роль `compute.osAdminLogin` позволяет подключаться к [виртуальным машинам](../compute/concepts/vm.md) при помощи SSH-сертификатов или SSH-ключей через [{{ oslogin }}](../organization/concepts/os-login.md) с возможностью выполнять команды от имени суперпользователя (`sudo`).

#### compute.disks.user {#compute-disks-user}

Роль `compute.disks.user` позволяет просматривать список [дисков](../compute/concepts/disk.md) и информацию о них, а также использовать диски для создания новых ресурсов, например [виртуальных машин](../compute/concepts/vm.md).

#### compute.images.user {#compute-images-user}

Роль `compute.images.user` позволяет просматривать список [образов](../compute/concepts/image.md) и информацию о них, получать информацию о наиболее актуальном образе в [семействе образов](../compute/concepts/image.md#family), а также использовать образы для создания новых ресурсов, например [виртуальных машин](../compute/concepts/vm.md).

#### compute.operator {#compute-operator}

Роль `compute.operator` позволяет запускать и останавливать виртуальные машины и группы виртуальных машин, а также просматривать информацию о ресурсах сервиса {{ compute-name }} и операциях с ними, а также о назначенных правах доступа к ресурсам сервиса и об объеме использованных ресурсов и квот.

{% cut "Пользователи с этой ролью могут:" %}

* запускать, перезапускать и останавливать [виртуальные машины](../compute/concepts/vm.md);
* просматривать список виртуальных машин, информацию о них и о назначенных [правах доступа](concepts/access-control/index.md) к ним;
* запускать и останавливать [группы виртуальных машин](../compute/concepts/instance-groups/index.md);
* просматривать список групп виртуальных машин и информацию о них;
* просматривать [вывод последовательного порта](../compute/operations/vm-info/get-serial-port-output.md) виртуальной машины;
* просматривать [метаданные](../compute/concepts/vm-metadata.md) виртуальной машины;
* просматривать список [групп размещения виртуальных машин](../compute/concepts/placement-groups.md), информацию о них и о назначенных правах доступа к ним;
* просматривать списки ВМ, входящих в группы размещения;
* просматривать список [групп выделенных хостов](../compute/concepts/dedicated-host.md#host-group-size), информацию о них и о назначенных правах доступа к ним;
* просматривать списки [хостов](../compute/concepts/dedicated-host.md) и виртуальных машин, входящих в группы выделенных хостов;
* просматривать информацию о [кластерах GPU](../compute/concepts/gpus.md#gpu-clusters) и виртуальных машинах, входящих в кластеры GPU, а также о назначенных правах доступа к таким кластерам;
* просматривать список [дисков](../compute/concepts/disk.md), информацию о них и о назначенных правах доступа к ним;
* просматривать список [файловых хранилищ](../compute/concepts/filesystem.md), информацию о них и о назначенных правах доступа к ним;
* просматривать список [групп размещения нереплицируемых дисков](../compute/concepts/disk-placement-group.md), информацию о них и о назначенных правах доступа к ним;
* просматривать списки дисков, входящих в группы размещения;
* просматривать информацию о [пулах резервов ВМ](../compute/concepts/reserved-pools.md);
* просматривать список [образов](../compute/concepts/image.md), информацию о них и о назначенных правах доступа к ним;
* просматривать информацию о [семействах образов](../compute/concepts/image.md#family), о входящих в семейства образах, о наиболее актуальном образе в семействе, а также о назначенных правах доступа к семействам образов;
* просматривать список [снимков дисков](../compute/concepts/snapshot.md), информацию о них и о назначенных правах доступа к ним;
* просматривать информацию о [расписаниях](../compute/concepts/snapshot-schedule.md) создания снимков дисков и о назначенных правах доступа к расписаниям;
* просматривать в консоли управления информацию об объеме потребления ресурсов и [квот](../compute/concepts/limits.md#compute-quotas) сервиса {{ compute-name }}, о [лимитах дисков](../compute/concepts/limits.md#compute-limits-disks);
* просматривать списки операций с ресурсами сервиса {{ compute-name }}, а также информацию об этих операциях;
* просматривать информацию о статусе настройки доступа по [{{ oslogin }}](../organization/concepts/os-login.md) на виртуальных машинах;
* просматривать информацию о доступных [платформах](../compute/concepts/vm-platforms.md);
* просматривать список [зон доступности](../overview/concepts/geo-scope.md), информацию о них и о назначенных правах доступа к ним.

{% endcut %}

Включает разрешения, предоставляемые ролью `compute.viewer`.

#### compute.snapshotSchedules.viewer {#compute-snapshotSchedules-viewer}

Роль `compute.snapshotSchedules.viewer` позволяет просматривать информацию о создании снимков дисков по расписаниям.

Пользователи с этой ролью могут:
* просматривать информацию о [расписаниях](../compute/concepts/snapshot-schedule.md) создания снимков дисков и о назначенных [правах доступа](concepts/access-control/index.md) к расписаниям;
* просматривать списки [дисков](../compute/concepts/disk.md);
* просматривать списки [снимков дисков](../compute/concepts/snapshot.md);
* просматривать список операций со снимками дисков.

#### compute.snapshotSchedules.editor {#compute-snapshotSchedules-editor}

Роль `compute.snapshotSchedules.editor` позволяет создавать, изменять и удалять расписания создания снимков дисков, создавать и удалять снимки дисков, а также просматривать информацию об операциях со снимками дисков.

Пользователи с этой ролью могут:
* просматривать информацию о [расписаниях](../compute/concepts/snapshot-schedule.md) создания снимков дисков и о назначенных [правах доступа](concepts/access-control/index.md) к расписаниям, а также создавать, изменять и удалять расписания;
* просматривать списки [дисков](../compute/concepts/disk.md) и использовать диски для создания снимков;
* просматривать списки [снимков дисков](../compute/concepts/snapshot.md), создавать и удалять снимки;
* просматривать список операций со снимками дисков и информацию об этих операциях.

Включает разрешения, предоставляемые ролью `compute.snapshotSchedules.viewer`.

Подробнее см. [{#T}](../compute/security/index.md).


## {{ connection-manager-full-name }} {#connection-manager-roles}

#### connection-manager.auditor {#connection-manager-auditor}

Роль `connection-manager.auditor` позволяет просматривать несекретную информацию о [подключениях](../metadata-hub/concepts/connection-manager.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним. Если роль выдана на облако, то она позволяет просматривать [квоты](../metadata-hub/concepts/limits.md) сервиса {{ connection-manager-name }}.

#### connection-manager.viewer {#connection-manager-viewer}

Роль `connection-manager.viewer` позволяет просматривать информацию о [подключениях](../metadata-hub/concepts/connection-manager.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также о [квотах](../metadata-hub/concepts/limits.md) сервиса {{ connection-manager-name }}.

Включает разрешения, предоставляемые ролью `connection-manager.auditor`.

#### connection-manager.editor {#connection-manager-editor}

Роль `connection-manager.editor` позволяет управлять подключениями, а также просматривать информацию о них.

Пользователи с этой ролью могут:
* создавать, использовать, изменять и удалять [подключения](../metadata-hub/concepts/connection-manager.md);
* просматривать информацию о подключениях и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о [квотах](../metadata-hub/concepts/limits.md) сервиса {{ connection-manager-name }}.

Включает разрешения, предоставляемые ролью `connection-manager.viewer`.

#### connection-manager.admin {#connection-manager-admin}

Роль `connection-manager.admin` позволяет управлять подключениями и доступом к ним, а также просматривать информацию о подключениях.

Пользователи с этой ролью могут:
* создавать, использовать, изменять и удалять [подключения](../metadata-hub/concepts/connection-manager.md), а также управлять доступом к ним;
* просматривать информацию о подключениях и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о [квотах](../metadata-hub/concepts/limits.md) сервиса {{ connection-manager-name }}.

Включает разрешения, предоставляемые ролью `connection-manager.editor`.

Подробнее см. [Управление доступом в {{ connection-manager-name }}](../metadata-hub/security/index.md).


## {{ container-registry-full-name }} {#cr-roles}

#### container-registry.viewer {#container-registry.viewer}

Роль `container-registry.viewer` позволяет просматривать информацию о реестрах, Docker-образах и репозиториях, а также об облаке, каталоге и квотах сервиса.

Пользователи с этой ролью могут:
* просматривать список [реестров](../container-registry/concepts/registry.md) и информацию о них и о назначенных [правах доступа](concepts/access-control/index.md) к ним, а также о [настройках политик доступа](../container-registry/operations/registry/registry-access.md) для IP-адресов и настройках [сканера уязвимостей](../container-registry/concepts/vulnerability-scanner.md);
* просматривать информацию о [репозиториях](../container-registry/concepts/repository.md) и назначенных правах доступа к ним;
* просматривать список [политик](../container-registry/concepts/lifecycle-policy.md) автоматического удаления [Docker-образов](../container-registry/concepts/docker-image.md) и информацию о таких политиках;
* просматривать список результатов [тестирования](../container-registry/operations/lifecycle-policy/lifecycle-policy-dry-run.md) политик автоматического удаления Docker-образов и информацию о таких результатах;
* просматривать список Docker-образов в реестре и информацию о них, а также скачивать Docker-образы из реестра;
* просматривать историю сканирования Docker-образов на уязвимости и информацию о результатах такого сканирования;
* просматривать информацию о [квотах](../container-registry/concepts/limits.md#container-registry-quotas) сервиса Container Registry;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

#### container-registry.editor {#container-registry.editor}

Роль `container-registry.editor` позволяет управлять реестрами, Docker-образами, репозиториями и их настройками.

Пользователи с этой ролью могут:
* просматривать список [реестров](../container-registry/concepts/registry.md) и информацию о них, а также создавать, изменять и удалять реестры;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к реестрам, а также о [настройках политик доступа](../container-registry/operations/registry/registry-access.md) для IP-адресов;
* просматривать информацию о настройках [сканера уязвимостей](../container-registry/concepts/vulnerability-scanner.md), а также создавать, изменять и удалять правила сканирования;
* просматривать список [Docker-образов](../container-registry/concepts/docker-image.md) в реестре и информацию о них, а также создавать, скачивать, изменять и удалять Docker-образы;
* [запускать](../container-registry/operations/scanning-docker-image.md#manual) и отменять сканирование Docker-образов на уязвимости, а также просматривать историю сканирования и информацию о его результатах;
* просматривать информацию о [репозиториях](../container-registry/concepts/repository.md) и назначенных правах доступа к ним, а также создавать и удалять репозитории;
* просматривать список [политик](../container-registry/concepts/lifecycle-policy.md) автоматического удаления Docker-образов и информацию о таких политиках, а также создавать, изменять и удалять такие политики;
* запускать [тестирование](../container-registry/operations/lifecycle-policy/lifecycle-policy-dry-run.md) политик автоматического удаления Docker-образов, просматривать список результатов тестирования и информацию о таких результатах;
* просматривать информацию о [квотах](../container-registry/concepts/limits.md#container-registry-quotas) сервиса Container Registry;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `container-registry.viewer`.

#### container-registry.admin {#container-registry.admin}

Роль `container-registry.admin` позволяет управлять доступом к реестрам и репозиториям, а также управлять реестрами, Docker-образами, репозиториями и их настройками.

Пользователи с этой ролью могут:
* просматривать список [реестров](../container-registry/concepts/registry.md) и информацию о них, а также создавать, изменять и удалять реестры;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к реестрам и изменять такие права доступа;
* просматривать информацию о [настройках политик доступа](../container-registry/operations/registry/registry-access.md) для IP-адресов и изменять такие настройки;
* просматривать информацию о настройках [сканера уязвимостей](../container-registry/concepts/vulnerability-scanner.md), а также создавать, изменять и удалять правила сканирования;
* просматривать список [Docker-образов](../container-registry/concepts/docker-image.md) в реестре и информацию о них, а также создавать, скачивать, изменять и удалять Docker-образы;
* [запускать](../container-registry/operations/scanning-docker-image.md#manual) и отменять сканирование Docker-образов на уязвимости, а также просматривать историю сканирования и информацию о его результатах;
* просматривать информацию о [репозиториях](../container-registry/concepts/repository.md), а также создавать и удалять репозитории;
* просматривать информацию о назначенных правах доступа к репозиториям и изменять такие права доступа; 
* просматривать список [политик](../container-registry/concepts/lifecycle-policy.md) автоматического удаления Docker-образов и информацию о таких политиках, а также создавать, изменять и удалять такие политики;
* запускать [тестирование](../container-registry/operations/lifecycle-policy/lifecycle-policy-dry-run.md) политик автоматического удаления Docker-образов, просматривать список результатов тестирования и информацию о таких результатах;
* просматривать информацию о [квотах](../container-registry/concepts/limits.md#container-registry-quotas) сервиса Container Registry;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `container-registry.editor`.

#### container-registry.images.pusher {#container-registry-images-pusher}

Роль `container-registry.images.pusher` позволяет управлять Docker-образами и репозиториями, а также просматривать информацию о Docker-образах, репозиториях и реестрах.

Пользователи с этой ролью могут:
* просматривать список [реестров](../container-registry/concepts/registry.md) и информацию о них;
* просматривать список [Docker-образов](../container-registry/concepts/docker-image.md) в реестре и информацию о них, а также загружать, скачивать, обновлять, и удалять Docker-образы;
* создавать и удалять [репозитории](../container-registry/concepts/repository.md).

#### container-registry.images.puller {#container-registry-images-puller}

Роль `container-registry.images.puller` позволяет скачивать [Docker-образы](../container-registry/concepts/docker-image.md) из реестра и просматривать список [реестров](../container-registry/concepts/registry.md) и Docker-образов, а также информацию о них.

#### container-registry.images.scanner {#container-registry-images-scanner}

Роль `container-registry.images.scanner` позволяет сканировать Docker-образы на наличие уязвимостей, а также просматривать информацию о реестрах, Docker-образах и репозиториях, а также об облаке, каталоге и квотах сервиса.

Пользователи с этой ролью могут:
* просматривать список [Docker-образов](../container-registry/concepts/docker-image.md) в реестре и информацию о них, а также скачивать Docker-образы из реестра;
* [запускать](../container-registry/operations/scanning-docker-image.md#manual) и отменять сканирование Docker-образов на уязвимости, а также просматривать историю сканирования и информацию о его результатах;
* просматривать список [реестров](../container-registry/concepts/registry.md) и информацию о них и о назначенных [правах доступа](concepts/access-control/index.md) к ним, а также о [настройках политик доступа](../container-registry/operations/registry/registry-access.md) для IP-адресов и настройках [сканера уязвимостей](../container-registry/concepts/vulnerability-scanner.md);
* просматривать информацию о [репозиториях](../container-registry/concepts/repository.md) и назначенных правах доступа к ним;
* просматривать список [политик](../container-registry/concepts/lifecycle-policy.md) автоматического удаления Docker-образов и информацию о таких политиках;
* просматривать список результатов [тестирования](../container-registry/operations/lifecycle-policy/lifecycle-policy-dry-run.md) политик автоматического удаления Docker-образов и информацию о таких результатах;
* просматривать информацию о [квотах](../container-registry/concepts/limits.md#container-registry-quotas) сервиса Container Registry;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `container-registry.viewer`.

Подробнее см. [{#T}](../container-registry/security/index.md).


## {{ datalens-full-name }} {#datalens-roles}

#### datalens.workbooks.limitedViewer {#datalens-workbooks-limitedViewer}

Роль `datalens.workbooks.limitedViewer` назначается на [воркбук](../datalens/workbooks-collections/index.md) и позволяет просматривать вложенные в него [чарты](../datalens/concepts/chart/index.md), [дашборды](../datalens/concepts/dashboard.md) и [отчеты](../datalens/reports/index.md), а также информацию о назначенных [правах доступа](concepts/access-control/index.md) к нему. В интерфейсе {{ datalens-name }} эта роль называется `Ограниченный просмотр`. Рекомендуем выдавать эту роль только через интерфейс {{ datalens-name }}.

#### datalens.workbooks.viewer {#datalens-workbooks-viewer}

Роль `datalens.workbooks.viewer` назначается на [воркбук](../datalens/workbooks-collections/index.md) и позволяет просматривать все вложенные в него [объекты](../datalens/concepts/index.md#component-interrelation), а также информацию о назначенных [правах доступа](concepts/access-control/index.md) к нему. В интерфейсе {{ datalens-name }} эта роль называется `Просмотр`. Рекомендуем выдавать эту роль только через интерфейс {{ datalens-name }}.

Включает разрешения, предоставляемые ролью `datalens.workbooks.limitedViewer`.

#### datalens.workbooks.editor {#datalens-workbooks-editor}

Роль `datalens.workbooks.editor` назначается на воркбук и позволяет редактировать его и все вложенные в него объекты. В интерфейсе {{ datalens-name }} эта роль называется `Редактирование`. Рекомендуем выдавать эту роль только через интерфейс {{ datalens-name }}.

Пользователи с этой ролью могут:
* редактировать [воркбук](../datalens/workbooks-collections/index.md) и создавать его копии;
* просматривать все вложенные в воркбук [объекты](../datalens/concepts/index.md#component-interrelation) и редактировать их;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к воркбуку.

Включает разрешения, предоставляемые ролью `datalens.workbooks.viewer`.

#### datalens.workbooks.admin {#datalens-workbooks-admin}

Роль `datalens.workbooks.admin` назначается на воркбук и позволяет управлять им, доступом к нему и всеми вложенными в него объектами. В интерфейсе {{ datalens-name }} эта роль называется `Администрирование`. Рекомендуем выдавать эту роль только через интерфейс {{ datalens-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к [воркбуку](../datalens/workbooks-collections/index.md) и изменять такие права доступа;
* редактировать, перемещать воркбук, создавать копии и удалять его;
* просматривать все вложенные в воркбук [объекты](../datalens/concepts/index.md#component-interrelation) и редактировать их;
* [встраивать](../datalens/security/private-embedded-objects.md) вложенные в воркбук непубличные объекты на сайты и в приложения;
* [публиковать](../datalens/concepts/datalens-public.md#how-to-publish) вложенные в воркбук объекты.

Включает разрешения, предоставляемые ролью `datalens.workbooks.editor`.

#### datalens.collections.visitor {#datalens-collections-visitor}

Роль `datalens.collections.visitor` назначается на коллекцию и позволяет просматривать информацию о текущей коллекции без доступа ко вложенным в нее объектам. В интерфейсе {{ datalens-name }} эта роль называется `Посещение коллекции`. Рекомендуем выдавать эту роль только через интерфейс {{ datalens-name }}.

#### datalens.collections.limitedViewer {#datalens-collections-limitedViewer}

Роль `datalens.collections.limitedViewer` назначается на коллекцию и позволяет просматривать информацию о ней и вложенных в нее коллекциях и воркбуках, в том числе просматривать чарты, дашборды и отчеты вложенных воркбуков. В интерфейсе {{ datalens-name }} эта роль называется `Ограниченный просмотр`. Рекомендуем выдавать эту роль только через интерфейс {{ datalens-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о текущей коллекции и вложенных в нее [воркбуках и коллекциях](../datalens/workbooks-collections/index.md);
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к текущей коллекции, а также к вложенным в нее коллекциям и воркбукам;
* просматривать [чарты](../datalens/concepts/chart/index.md), [дашборды](../datalens/concepts/dashboard.md) и [отчеты](../datalens/reports/index.md), вложенные в воркбуки, которые относятся к текущей и вложенным коллекциям.

Включает разрешения, предоставляемые ролью `datalens.workbooks.limitedViewer`.

#### datalens.collections.viewer {#datalens-collections-viewer}

Роль `datalens.collections.viewer` назначается на коллекцию и позволяет просматривать информацию о ней и вложенных в нее коллекциях и воркбуках, а также просматривать все объекты вложенных воркбуков. В интерфейсе {{ datalens-name }} эта роль называется `Просмотр`. Рекомендуем выдавать эту роль только через интерфейс {{ datalens-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о текущей коллекции и вложенных в нее [воркбуках и коллекциях](../datalens/workbooks-collections/index.md);
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к текущей коллекции, а также к вложенным в нее коллекциям и воркбукам;
* просматривать все [объекты](../datalens/concepts/index.md#component-interrelation), вложенные в воркбуки, которые относятся к текущей и вложенным коллекциям.

Включает разрешения, предоставляемые ролями `datalens.collections.limitedViewer` и `datalens.workbooks.viewer`.

#### datalens.collections.limitedEntryBindingCreator {#datalens-collections-limitedEntryBindingCreator}

Роль `datalens.collections.limitedEntryBindingCreator` назначается на коллекцию и позволяет переиспользовать общие объекты из этой коллекции без делегации прав доступа. В интерфейсе {{ datalens-name }} эта роль называется `Привязки без делегаций`. Рекомендуем выдавать эту роль только через интерфейс {{ datalens-name }}.

Включает разрешения, предоставляемые ролью `datalens.sharedEntries.limitedEntryBindingCreator`.

#### datalens.collections.entryBindingCreator {#datalens-collections-entryBindingCreator}

Роль `datalens.collections.entryBindingCreator` назначается на коллекцию и позволяет переиспользовать общие объекты из этой коллекции как без делегации прав доступа, так и с делегацией. В интерфейсе {{ datalens-name }} эта роль называется `Привязки с делегацией`. Рекомендуем выдавать эту роль только через интерфейс {{ datalens-name }}.

Включает разрешения, предоставляемые ролью `datalens.sharedEntries.entryBindingCreator`.

#### datalens.collections.creator {#datalens-collections-creator}

Роль `datalens.collections.creator` назначается на коллекцию и позволяет просматривать коллекцию, а также создавать объекты внутри нее без доступа к другим объектам, существующим внутри коллекции. В интерфейсе {{ datalens-name }} эта роль называется `Создание в коллекции`. Рекомендуем выдавать эту роль только через интерфейс {{ datalens-name }}.

Включает разрешения, предоставляемые ролью `datalens.collections.visitor`.

#### datalens.collections.editor {#datalens-collections-editor}

Роль `datalens.collections.editor` назначается на коллекцию и позволяет редактировать ее и все вложенные в нее коллекции, воркбуки, а также все объекты в таких воркбуках. В интерфейсе {{ datalens-name }} эта роль называется `Редактирование`. Рекомендуем выдавать эту роль только через интерфейс {{ datalens-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о текущей коллекции и вложенных в нее [коллекциях и воркбуках](../datalens/workbooks-collections/index.md);
* редактировать текущую коллекцию и все вложенные в нее коллекции и воркбуки;
* создавать копии воркбуков, вложенных в текущую коллекцию;
* создавать новые коллекции и воркбуки внутри текущей и всех вложенных коллекций;
* просматривать и редактировать все [объекты](../datalens/concepts/index.md#component-interrelation), вложенные в воркбуки, которые относятся к текущей и вложенным коллекциям;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к текущей коллекции, а также к вложенным в нее коллекциям и воркбукам.

Включает разрешения, предоставляемые ролями `datalens.collections.viewer` и `datalens.workbooks.editor`.

#### datalens.collections.admin {#datalens-collections-admin}

Роль `datalens.collections.admin` назначается на коллекцию и позволяет управлять ей, доступом к ней, а также всеми вложенными в нее коллекциями, воркбуками и объектами в таких воркбуках. В интерфейсе {{ datalens-name }} эта роль называется `Администрирование`. Рекомендуем выдавать эту роль только через интерфейс {{ datalens-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к текущей коллекции, к вложенным в нее [коллекциям и воркбукам](../datalens/workbooks-collections/index.md), а также изменять такие права доступа;
* просматривать информацию о текущей коллекции и вложенных в нее коллекциях и воркбуках;
* редактировать текущую коллекцию и все вложенные в нее коллекции и воркбуки;
* создавать копии воркбуков, вложенных в текущую коллекцию;
* перемещать и удалять текущую коллекцию и все вложенные в нее коллекции и воркбуки;
* создавать новые коллекции и воркбуки внутри текущей коллекции;
* просматривать и редактировать все [объекты](../datalens/concepts/index.md#component-interrelation), вложенные в воркбуки, которые относятся к текущей и вложенным коллекциям;
* [встраивать](../datalens/security/private-embedded-objects.md) на сайты и в приложения непубличные объекты, вложенные в воркбуки, которые относятся к текущей и вложенным коллекциям;
* [публиковать](../datalens/concepts/datalens-public.md#how-to-publish) объекты, вложенные в воркбуки, которые относятся к текущей и вложенным коллекциям.

Включает разрешения, предоставляемые ролями `datalens.collections.editor` и `datalens.workbooks.admin`.

#### datalens.visitor {#datalens-visitor}

Роль `datalens.visitor` предоставляет доступ к сервису {{ datalens-name }}. Просмотр или редактирование [воркбуков и коллекций](../datalens/workbooks-collections/index.md) возможны при наличии соответствующих [ролей](#workbooks-collections-roles) для доступа к этим воркбукам и коллекциям.

#### datalens.creator {#datalens-creator}

Роль `datalens.creator` предоставляет доступ к сервису {{ datalens-name }} с правами на создание [воркбуков и коллекций](../datalens/workbooks-collections/index.md) в корне {{ datalens-name }}. Просмотр или редактирование воркбуков и коллекций, созданных другими пользователями, возможны только при наличии [прав доступа](#workbooks-collections-roles) к этим воркбукам и коллекциям.

Включает разрешения, предоставляемые ролью `datalens.visitor`.

#### datalens.admin {#datalens-admin}

Роль `datalens.admin` предоставляет полный доступ к сервису {{ datalens-name }} и всем [воркбукам и коллекциям](../datalens/workbooks-collections/index.md) в нем.

Включает разрешения, предоставляемые ролями `datalens.creator` и `datalens.metaReader`.

#### datalens.instances.user {#datalens-instances-user}

Роль `datalens.instances.user` предоставляет доступ к сервису {{ datalens-name }} в качестве пользователя с правами на создание, чтение и изменение [объектов](../datalens/concepts/index.md#component-interrelation) согласно правам доступа к ним, а также позволяет просматривать информацию о [каталогах](../resource-manager/concepts/resources-hierarchy.md#folder).

После назначения сервисной роли вы можете [назначить](../datalens/operations/permission/grant.md) пользователю права доступа к объектам и папкам в сервисе {{ datalens-name }}.

{% note tip %}

Рекомендуем использовать роль `datalens.creator` вместо `datalens.instances.user`. При аналогичном наборе разрешений она более безопасна, так как предоставляет доступ только к экземпляру {{ datalens-name }} и не дает прав на просмотр всех каталогов в организации.

{% endnote %}

#### datalens.instances.admin {#datalens-instances-admin}

Роль `datalens.instances.admin` предоставляет доступ к сервису {{ datalens-name }} в качестве администратора экземпляра {{ datalens-name }}. Администратор получает полные права на все [объекты](../datalens/concepts/index.md#component-interrelation) и папки в сервисе {{ datalens-name }}, доступ к настройкам {{ datalens-name }}, а также может просматривать информацию о [каталогах](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `datalens.instances.user`.

{% note tip %}

Рекомендуем использовать роль `datalens.admin` вместо `datalens.instances.admin`. При аналогичном наборе разрешений она более безопасна, так как предоставляет доступ только к экземпляру {{ datalens-name }} и не дает прав на просмотр всех каталогов в организации.

{% endnote %}

#### datalens.metaReader {#datalens-metaReader}

Роль `datalens.metaReader` позволяет выполнять запросы в [{{ datalens-name }} Public API](../datalens/operations/api-start.md) из раздела [Audit](https://api.datalens.tech/#/Audit), а также запросы для получения сущностей {{ datalens-name }}.

Доступно получение следующих сущностей:

* подключение — [метод](https://api.datalens.tech/#/Connection/post_rpc_getConnection) `getConnection`;
* датасет — [метод](https://api.datalens.tech/#/Dataset/post_rpc_getDataset) `getDataset`;
* чарт в Wizard — [метод](https://api.datalens.tech/#/Wizard/post_rpc_getWizardChart) `getWizardChart`;
* чарт в Editor — [метод](https://api.datalens.tech/#/Editor/post_rpc_getEditorChart) `getEditorChart`;
* QL-чарт — [метод](https://api.datalens.tech/#/QL/post_rpc_getQLChart) `getQLChart`;
* дашборд — [метод](https://api.datalens.tech/#/Dashboard/post_rpc_getDashboard) `getDashboard`;
* отчет — [метод](https://api.datalens.tech/#/Reports/post_rpc_getReport) `getReport`.

{% note warning %}

Получение сущностей работает, только если в запросе передан заголовок `x-dl-audit-mode` со значением `true`.

{% endnote %}

Подробнее см. [{#T}](../datalens/security/roles.md).


## {{ dataproc-full-name }} {#dataproc-roles}

#### dataproc.agent {#dataproc-agent}

Роль `dataproc.agent` позволяет [сервисному аккаунту](concepts/users/service-accounts.md), привязанному к кластеру {{ dataproc-name }}, сообщать сервису о состоянии хостов кластера. Роль назначается сервисному аккаунту, привязанному к кластеру {{ dataproc-name }}.

Сервисные аккаунты с этой ролью могут:
* сообщать сервису {{ dataproc-name }} о состоянии хостов [кластера](../data-proc/concepts/index.md#resources);
* получать информацию о [заданиях](../data-proc/concepts/jobs.md) и статусах их выполнения;
* получать информацию о [лог-группах](../logging/concepts/log-group.md) и добавлять в них записи.

Сейчас эту роль можно назначить только на каталог или облако.

#### dataproc.auditor {#dataproc-auditor}

Роль `dataproc.auditor` позволяет просматривать информацию о [кластерах](../data-proc/concepts/index.md#resources) {{ dataproc-name }}.

#### dataproc.viewer {#dataproc-viewer}

Роль `dataproc.viewer` позволяет просматривать информацию о [кластерах](../data-proc/concepts/index.md#resources) {{ dataproc-name }} и [заданиях](../data-proc/concepts/jobs.md).

#### dataproc.user {#dataproc-user}

Роль `dataproc.user` предоставляет доступ к веб-интерфейсам компонентов {{ dataproc-name }} и позволяет создавать задания, а также позволяет просматривать информацию о кластерах управляемых баз данных {{ yandex-cloud }}.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать информацию о [кластерах](../data-proc/concepts/index.md#resources) {{ dataproc-name }} и [заданиях](../data-proc/concepts/jobs.md), а также создавать задания;
* использовать веб-интерфейс для доступа к компонентам {{ dataproc-name }};
* просматривать информацию о кластерах [{{ CH }}](../managed-clickhouse/concepts/index.md), [{{ mgp-name }}](../managed-greenplum/concepts/index.md), [{{ KF }}](../managed-kafka/concepts/index.md), [{{ SD }}](../storedoc/concepts/index.md), [{{ MY }}](../managed-mysql/concepts/index.md), [{{ PG }}](../managed-postgresql/concepts/index.md), [{{ VLK }}](../managed-valkey/concepts/index.md), [{{ OS }}](../managed-opensearch/concepts/index.md) и {{ MS }};
* просматривать информацию о хостах кластеров [{{ mgp-name }}](../managed-greenplum/concepts/instance-types.md), [{{ SD }}](../storedoc/concepts/instance-types.md), [{{ MY }}](../managed-mysql/concepts/instance-types.md), [{{ PG }}](../managed-postgresql/concepts/instance-types.md), [{{ VLK }}](../managed-valkey/concepts/instance-types.md) и {{ MS }};
* просматривать информацию о резервных копиях БД кластеров [{{ mgp-name }}](../managed-greenplum/concepts/backup.md), [{{ SD }}](../storedoc/concepts/backup.md), [{{ MY }}](../managed-mysql/concepts/backup.md), [{{ PG }}](../managed-postgresql/concepts/backup.md), [{{ VLK }}](../managed-valkey/concepts/backup.md) и {{ MS }};
* просматривать информацию о пользователях кластеров [{{ SD }}](../storedoc/concepts/users-and-roles.md), [{{ MY }}](../managed-mysql/concepts/user-rights.md), [{{ PG }}](../managed-postgresql/concepts/roles.md) и {{ MS }};
* просматривать информацию о базах данных {{ SD }}, {{ MY }}, {{ PG }} и {{ MS }};
* просматривать информацию об алертах {{ SD }}, {{ MY }}, {{ PG }} и {{ VLK }};
* просматривать информацию о результатах диагностики производительности кластеров {{ mgp-name }}, {{ SD }}, {{ MY }} и {{ PG }};
* просматривать информацию о шардах кластеров [{{ SD }}](../storedoc/concepts/sharding.md) и [{{ VLK }}](../managed-valkey/concepts/sharding.md);
* просматривать логи работы кластеров {{ mgp-name }}, {{ SD }}, {{ MY }}, {{ PG }}, {{ VLK }} и {{ MS }};
* просматривать информацию о квотах сервисов [{{ mch-name }}](../managed-clickhouse/concepts/limits.md#mch-quotas), [{{ mkf-name }}](../managed-kafka/concepts/limits.md#mkf-quotas), [{{ mos-name }}](../managed-opensearch/concepts/limits.md#quotas), [{{ mgp-name }}](../managed-greenplum/concepts/limits.md#quotas), [{{ SD }}](../storedoc/concepts/limits.md#mmg-quotas), [{{ mmy-name }}](../managed-mysql/concepts/limits.md#mmy-quotas), [{{ mpg-name }}](../managed-postgresql/concepts/limits.md#mpg-quotas), [{{ mrd-name }}](../managed-valkey/concepts/limits.md#mrd-quotas) и {{ MS }};
* просматривать информацию об операциях с ресурсами всех сервисов управляемых баз данных {{ yandex-cloud }};
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролями `dataproc.viewer` и `mdb.viewer`.

#### dataproc.provisioner {#dataproc-provisioner}

Роль `dataproc.provisioner` предоставляет доступ к API для создания, изменения и удаления объектов кластеров {{ dataproc-name }}.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать информацию о [DNS-зонах](../dns/concepts/dns-zone.md), а также создавать, использовать, изменять и удалять их;
* просматривать информацию о [ресурсных записях](../dns/concepts/resource-record.md), а также создавать, изменять и удалять их;
* создавать вложенные публичные DNS-зоны;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к DNS-зонам;
* просматривать информацию о доступных [платформах](../compute/concepts/vm-platforms.md) и использовать их;
* создавать, изменять, запускать, перезапускать, останавливать, переносить и удалять [виртуальные машины](../compute/concepts/vm.md);
* просматривать список виртуальных машин, информацию о них и о назначенных правах доступа к ним;
* подключать к виртуальным машинам и отключать от них диски, файловые хранилища и сетевые интерфейсы, привязывать [группы безопасности](../vpc/concepts/security-groups.md) к сетевым интерфейсам виртуальных машин;
* создавать виртуальные машины с пользовательскими [FQDN](../vpc/concepts/address.md#fqdn), создавать мультиинтерфейсные виртуальные машины;
* привязывать [сервисные аккаунты](concepts/users/service-accounts.md) к виртуальным машинам, активировать на виртуальных машинах токен AWS v1;
* просматривать список сервисных аккаунтов и информацию о них, а также выполнять операции от имени сервисного аккаунта;
* использовать [последовательный порт](../compute/operations/vm-info/get-serial-port-output.md) виртуальной машины в режиме чтения и записи;
* имитировать события обслуживания виртуальной машины;
* просматривать [метаданные](../compute/concepts/vm-metadata.md) виртуальной машины;
* просматривать информацию о статусе настройки доступа по [{{ oslogin }}](../organization/concepts/os-login.md) на виртуальных машинах и подключаться к виртуальным машинам через {{ oslogin }} с помощью SSH-сертификатов или SSH-ключей;
* просматривать список [групп виртуальных машин](../compute/concepts/instance-groups/index.md), информацию о них и о назначенных правах доступа к ним, а также использовать, создавать, изменять, запускать, останавливать и удалять группы виртуальных машин;
* просматривать список [групп размещения виртуальных машин](../compute/concepts/placement-groups.md), информацию о них и о назначенных правах доступа к ним, а также использовать, создавать, изменять и удалять группы размещения виртуальных машин;
* просматривать списки ВМ, входящих в группы размещения;
* просматривать список [групп выделенных хостов](../compute/concepts/dedicated-host.md#host-group-size), информацию о них и о назначенных правах доступа к ним, а также использовать, создавать, изменять и удалять группы выделенных хостов;
* просматривать списки [хостов](../compute/concepts/dedicated-host.md) и виртуальных машин, входящих в группы выделенных хостов;
* изменять запланированное время обслуживания хостов, входящих в группы выделенных хостов;
* использовать [кластеры GPU](../compute/concepts/gpus.md#gpu-clusters), а также создавать, изменять и удалять их;
* просматривать информацию о кластерах GPU и виртуальных машинах, входящих в кластеры GPU, а также о назначенных правах доступа к таким кластерам;
* просматривать список [дисков](../compute/concepts/disk.md), информацию о них и о назначенных правах доступа к ним, а также использовать, создавать, изменять, переносить и удалять диски;
* создавать [зашифрованные диски](../compute/concepts/disk.md#encryption);
* просматривать и обновлять ссылки на диски;
* просматривать список [файловых хранилищ](../compute/concepts/filesystem.md), информацию о них и о назначенных правах доступа к ним, а также использовать файловые хранилища и создавать, изменять и удалять их;
* просматривать список [групп размещения нереплицируемых дисков](../compute/concepts/disk-placement-group.md), информацию о них и о назначенных правах доступа к ним, а также использовать, создавать, изменять и удалять группы размещения нереплицируемых дисков;
* просматривать списки дисков, входящих в группы размещения;
* просматривать список [образов](../compute/concepts/image.md), информацию о них и о назначенных правах доступа к ним, а также использовать, создавать, изменять и удалять образы;
* создавать, изменять и удалять [семейства образов](../compute/concepts/image.md#family), обновлять образы в них;
* просматривать информацию о семействах образов, о входящих в семейства образах, о наиболее актуальном образе в семействе, а также о назначенных правах доступа к семействам образов;
* просматривать список [снимков дисков](../compute/concepts/snapshot.md), информацию о них и о назначенных правах доступа к ним, а также использовать, создавать, изменять и удалять снимки дисков;
* просматривать информацию о [расписаниях](../compute/concepts/snapshot-schedule.md) создания снимков дисков и о назначенных правах доступа к расписаниям, а также создавать, изменять и удалять их;
* просматривать список [облачных сетей](../vpc/concepts/network.md#network) и информацию о них, а также использовать облачные сети;
* просматривать список [подсетей](../vpc/concepts/network.md#subnet) и информацию о них, а также использовать подсети;
* просматривать список [адресов облачных ресурсов](../vpc/concepts/address.md) и информацию о них, а также использовать такие адреса;
* просматривать список [таблиц маршрутизации](../vpc/concepts/routing.md#rt-vpc) и информацию о них, а также использовать таблицы маршрутизации;
* просматривать список групп безопасности и информацию о них, а также использовать группы безопасности;
* просматривать информацию о [NAT-шлюзах](../vpc/concepts/gateways.md) и подключать их к таблицам маршрутизации;
* просматривать информацию об использованных IP-адресах в подсетях;
* просматривать информацию о [метриках](../monitoring/concepts/data-model.md#metric) {{ monitoring-name }} и их [метках](../monitoring/concepts/data-model.md#label), а также выгружать метрики;
* просматривать список [дашбордов](../monitoring/concepts/visualization/dashboard.md) и [виджетов](../monitoring/concepts/visualization/widget.md) {{ monitoring-name }}, а также информацию о них;
* просматривать историю [уведомлений](../monitoring/concepts/alerting/notification-channel.md) {{ monitoring-name }};
* просматривать информацию о [лог-группах](../logging/concepts/log-group.md);
* просматривать информацию о приемниках логов;
* просматривать информацию о назначенных правах доступа к ресурсам сервиса {{ cloud-logging-name }};
* просматривать информацию о выгрузках логов;
* просматривать в консоли управления информацию об объеме потребления ресурсов и [квот](../compute/concepts/limits.md#compute-quotas) {{ compute-name }}, о [лимитах дисков](../compute/concepts/limits.md#compute-limits-disks);
* просматривать информацию о квотах сервисов [{{ dns-name }}](../dns/concepts/limits.md#cloud-dns-quotas), 
[{{ vpc-name }}](../vpc/concepts/limits.md#vpc-quotas), и [{{ monitoring-name }}](../monitoring/concepts/limits.md#monitoring-quotas);
* просматривать списки операций с ресурсами сервиса {{ compute-name }} и информацию об операциях, а также отменять выполнение этих операций;
* просматривать информацию об операциях с ресурсами сервиса {{ vpc-name }};
* просматривать список [зон доступности](../overview/concepts/geo-scope.md), информацию о них и о назначенных правах доступа к ним;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролями `iam.serviceAccounts.user`, `dns.editor`, `compute.editor`, `monitoring.viewer` и `logging.viewer`.

#### dataproc.editor {#dataproc-editor}

Роль `dataproc.editor` позволяет управлять кластерами {{ dataproc-name }}, запускать задания и просматривать информацию о них, а также предоставляет доступ к веб-интерфейсам компонентов сервиса.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать информацию о [кластерах](../data-proc/concepts/index.md#resources) {{ dataproc-name }}, а также создавать, изменять, запускать останавливать и удалять такие кластеры;
* просматривать информацию о [заданиях](../data-proc/concepts/jobs.md), а также создавать задания;
* использовать веб-интерфейс для доступа к компонентам {{ dataproc-name }};
* просматривать информацию о кластерах [{{ CH }}](../managed-clickhouse/concepts/index.md), [{{ mgp-name }}](../managed-greenplum/concepts/index.md), [{{ KF }}](../managed-kafka/concepts/index.md), [{{ SD }}](../storedoc/concepts/index.md), [{{ MY }}](../managed-mysql/concepts/index.md), [{{ PG }}](../managed-postgresql/concepts/index.md), [{{ VLK }}](../managed-valkey/concepts/index.md), [{{ OS }}](../managed-opensearch/concepts/index.md) и {{ MS }};
* просматривать информацию о хостах кластеров [{{ mgp-name }}](../managed-greenplum/concepts/instance-types.md), [{{ SD }}](../storedoc/concepts/instance-types.md), [{{ MY }}](../managed-mysql/concepts/instance-types.md), [{{ PG }}](../managed-postgresql/concepts/instance-types.md), [{{ VLK }}](../managed-valkey/concepts/instance-types.md) и {{ MS }};
* просматривать информацию о резервных копиях БД кластеров [{{ mgp-name }}](../managed-greenplum/concepts/backup.md), [{{ SD }}](../storedoc/concepts/backup.md), [{{ MY }}](../managed-mysql/concepts/backup.md), [{{ PG }}](../managed-postgresql/concepts/backup.md), [{{ VLK }}](../managed-valkey/concepts/backup.md) и {{ MS }};
* просматривать информацию о пользователях кластеров [{{ SD }}](../storedoc/concepts/users-and-roles.md), [{{ MY }}](../managed-mysql/concepts/user-rights.md), [{{ PG }}](../managed-postgresql/concepts/roles.md) и {{ MS }};
* просматривать информацию о базах данных {{ SD }}, {{ MY }}, {{ PG }} и {{ MS }};
* просматривать информацию об алертах {{ SD }}, {{ MY }}, {{ PG }} и {{ VLK }};
* просматривать информацию о результатах диагностики производительности кластеров {{ mgp-name }}, {{ SD }}, {{ MY }} и {{ PG }};
* просматривать информацию о шардах кластеров [{{ SD }}](../storedoc/concepts/sharding.md) и [{{ VLK }}](../managed-valkey/concepts/sharding.md);
* просматривать логи работы кластеров {{ mgp-name }}, {{ SD }}, {{ MY }}, {{ PG }}, {{ VLK }} и {{ MS }};
* просматривать информацию о квотах сервисов [{{ mch-name }}](../managed-clickhouse/concepts/limits.md#mch-quotas), [{{ mkf-name }}](../managed-kafka/concepts/limits.md#mkf-quotas), [{{ mos-name }}](../managed-opensearch/concepts/limits.md#quotas), [{{ mgp-name }}](../managed-greenplum/concepts/limits.md#quotas), [{{ SD }}](../storedoc/concepts/limits.md#mmg-quotas), [{{ mmy-name }}](../managed-mysql/concepts/limits.md#mmy-quotas), [{{ mpg-name }}](../managed-postgresql/concepts/limits.md#mpg-quotas), [{{ mrd-name }}](../managed-valkey/concepts/limits.md#mrd-quotas) и {{ MS }};
* просматривать информацию об операциях с ресурсами всех сервисов управляемых баз данных {{ yandex-cloud }};
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролью `dataproc.user`.

#### dataproc.admin {#dataproc-admin}

Роль `dataproc.admin` позволяет управлять кластерами {{ dataproc-name }}, запускать задания и просматривать информацию о них, а также предоставляет доступ к веб-интерфейсам компонентов сервиса.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать информацию о [кластерах](../data-proc/concepts/index.md#resources) {{ dataproc-name }}, а также создавать, изменять, запускать, останавливать и удалять такие кластеры;
* просматривать информацию о [заданиях](../data-proc/concepts/jobs.md), а также создавать задания;
* использовать веб-интерфейс для доступа к компонентам {{ dataproc-name }};
* просматривать информацию о кластерах [{{ CH }}](../managed-clickhouse/concepts/index.md), [{{ mgp-name }}](../managed-greenplum/concepts/index.md), [{{ KF }}](../managed-kafka/concepts/index.md), [{{ SD }}](../storedoc/concepts/index.md), [{{ MY }}](../managed-mysql/concepts/index.md), [{{ PG }}](../managed-postgresql/concepts/index.md), [{{ VLK }}](../managed-valkey/concepts/index.md), [{{ OS }}](../managed-opensearch/concepts/index.md) и {{ MS }};
* просматривать информацию о хостах кластеров [{{ mgp-name }}](../managed-greenplum/concepts/instance-types.md), [{{ SD }}](../storedoc/concepts/instance-types.md), [{{ MY }}](../managed-mysql/concepts/instance-types.md), [{{ PG }}](../managed-postgresql/concepts/instance-types.md), [{{ VLK }}](../managed-valkey/concepts/instance-types.md) и {{ MS }};
* просматривать информацию о резервных копиях БД кластеров [{{ mgp-name }}](../managed-greenplum/concepts/backup.md), [{{ SD }}](../storedoc/concepts/backup.md), [{{ MY }}](../managed-mysql/concepts/backup.md), [{{ PG }}](../managed-postgresql/concepts/backup.md), [{{ VLK }}](../managed-valkey/concepts/backup.md) и {{ MS }};
* просматривать информацию о пользователях кластеров [{{ SD }}](../storedoc/concepts/users-and-roles.md), [{{ MY }}](../managed-mysql/concepts/user-rights.md), [{{ PG }}](../managed-postgresql/concepts/roles.md) и {{ MS }};
* просматривать информацию о базах данных {{ SD }}, {{ MY }}, {{ PG }} и {{ MS }};
* просматривать информацию об алертах {{ SD }}, {{ MY }}, {{ PG }} и {{ VLK }};
* просматривать информацию о результатах диагностики производительности кластеров {{ mgp-name }}, {{ SD }}, {{ MY }} и {{ PG }};
* просматривать информацию о шардах кластеров [{{ SD }}](../storedoc/concepts/sharding.md) и [{{ VLK }}](../managed-valkey/concepts/sharding.md);
* просматривать логи работы кластеров {{ mgp-name }}, {{ SD }}, {{ MY }}, {{ PG }}, {{ VLK }} и {{ MS }};
* просматривать информацию о квотах сервисов [{{ mch-name }}](../managed-clickhouse/concepts/limits.md#mch-quotas), [{{ mkf-name }}](../managed-kafka/concepts/limits.md#mkf-quotas), [{{ mos-name }}](../managed-opensearch/concepts/limits.md#quotas), [{{ mgp-name }}](../managed-greenplum/concepts/limits.md#quotas), [{{ SD }}](../storedoc/concepts/limits.md#mmg-quotas), [{{ mmy-name }}](../managed-mysql/concepts/limits.md#mmy-quotas), [{{ mpg-name }}](../managed-postgresql/concepts/limits.md#mpg-quotas), [{{ mrd-name }}](../managed-valkey/concepts/limits.md#mrd-quotas) и {{ MS }};
* просматривать информацию об операциях с ресурсами всех сервисов управляемых баз данных {{ yandex-cloud }};
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролью `dataproc.editor`.

#### mdb.dataproc.agent {#mdb-dataproc-agent}

Роль `mdb.dataproc.agent` позволяет сервисному аккаунту, привязанному к кластеру {{ dataproc-name }}, сообщать сервису о состоянии хостов кластера.

Сервисные аккаунты с этой ролью могут:
* сообщать сервису {{ dataproc-name }} о состоянии хостов кластера;
* получать информацию о заданиях и статусах их выполнения;
* получать информацию о лог-группах и добавлять в них записи.

Роль назначается сервисному аккаунту, привязанному к кластеру {{ dataproc-name }}.

Эта роль недоступна. Используйте роль `dataproc.agent`.

#### {{ roles.metastore.auditor }} {#managed-metastore-auditor}

Роль `managed-metastore.auditor` позволяет просматривать информацию о [кластерах](../metadata-hub/concepts/metastore.md) {{ metastore-name }} и квотах сервисов управляемых баз данных {{ yandex-cloud }}.

#### {{ roles.metastore.viewer }} {#managed-metastore-viewer}

Роль `managed-metastore.viewer` позволяет просматривать информацию о кластерах {{ metastore-name }} и логи их работы, а также информацию о квотах сервисов управляемых баз данных {{ yandex-cloud }}.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах](../metadata-hub/concepts/metastore.md) {{ metastore-name }};
* просматривать логи кластеров {{ metastore-name }};
* просматривать информацию о квотах сервисов управляемых баз данных {{ yandex-cloud }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `managed-metastore.auditor`.

#### {{ roles.metastore.editor }} {#managed-metastore-editor}

Роль `managed-metastore.editor` позволяет управлять кластерами {{ metastore-name }}, а также просматривать логи их работы и информацию о квотах сервисов управляемых баз данных {{ yandex-cloud }}.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах](../metadata-hub/concepts/metastore.md) {{ metastore-name }}, а также создавать, изменять, запускать, останавливать и удалять такие кластеры;
* [экспортировать и импортировать](../metadata-hub/operations/metastore/export-and-import.md) кластеры {{ metastore-name }};
* просматривать логи кластеров {{ metastore-name }};
* просматривать информацию о квотах сервисов управляемых баз данных {{ yandex-cloud }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `managed-metastore.viewer`.

Для создания кластеров дополнительно необходима [роль](../vpc/security/index.md#vpc-user) `vpc.user`.

#### {{ roles.metastore.admin }} {#managed-metastore-admin}

Роль `managed-metastore.admin` позволяет управлять кластерами {{ metastore-name }}, а также просматривать логи их работы и информацию о квотах сервисов управляемых баз данных {{ yandex-cloud }}.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах](../metadata-hub/concepts/metastore.md) {{ metastore-name }}, а также создавать, изменять, запускать, останавливать и удалять такие кластеры;
* [экспортировать и импортировать](../metadata-hub/operations/metastore/export-and-import.md) кластеры {{ metastore-name }};
* просматривать логи кластеров {{ metastore-name }};
* просматривать информацию о квотах сервисов управляемых баз данных {{ yandex-cloud }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `managed-metastore.editor`.

Для создания кластеров дополнительно необходима [роль](../vpc/security/index.md#vpc-user) `vpc.user`.

#### {{ roles.metastore.integrationProvider }} {#managed-metastore-integrationProvider}

Роль `managed-metastore.integrationProvider` позволяет кластеру {{ metastore-name }} взаимодействовать от имени сервисного аккаунта с пользовательскими ресурсами, необходимыми для работы кластера. Роль назначается сервисному аккаунту, привязанному к кластеру {{ metastore-name }}.

Пользователи с этой ролью могут:
* добавлять записи в [лог-группы](../logging/concepts/log-group.md);
* просматривать информацию о лог-группах;
* просматривать информацию о приемниках логов;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к ресурсам сервиса {{ cloud-logging-name }};
* просматривать информацию о выгрузках логов;
* просматривать информацию о [метриках](../monitoring/concepts/data-model.md#metric) {{ monitoring-name }} и их [метках](../monitoring/concepts/data-model.md#label), а также загружать и выгружать метрики;
* просматривать список [дашбордов](../monitoring/concepts/visualization/dashboard.md) и [виджетов](../monitoring/concepts/visualization/widget.md) {{ monitoring-name }} и информацию о них, а также создавать, изменять и удалять дашборды и виджеты;
* просматривать историю [уведомлений](../monitoring/concepts/alerting/notification-channel.md) {{ monitoring-name }};
* просматривать информацию о [квотах](../monitoring/concepts/limits.md#monitoring-quotas) сервиса {{ monitoring-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролями `logging.writer` и `monitoring.editor`.

Подробнее см. [{#T}](../data-proc/security/index.md).


## {{ ml-platform-full-name }} {#datasphere-roles}

#### datasphere.community-projects.viewer {#datasphere-communityprojects-viewer}

Роль `datasphere.community-projects.viewer` позволяет просматривать информацию о [проектах](../datasphere/concepts/project.md), настройках проектов и закрепленных за ними [ресурсах](../datasphere/concepts/resources.md), а также о назначенных [правах доступа](concepts/access-control/index.md) к проектам.

В интерфейсе {{ ml-platform-name }} пользователи с ролью `datasphere.community-projects.viewer` имеют роль `Viewer` на вкладке **Участники** на странице проекта.

#### datasphere.community-projects.developer {#datasphere-communityprojects-developer}

Роль `datasphere.community-projects.developer` позволяет работать в проектах и управлять ресурсами, которые закреплены за проектами.

Пользователи с этой ролью могут:
* просматривать информацию о [проектах](../datasphere/concepts/project.md), настройках проектов и закрепленных за ними [ресурсах](../datasphere/concepts/resources.md);
* создавать, изменять и удалять ресурсы в проектах;
* запускать IDE и исполнение ячеек с кодом в проектах;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к проектам.

Включает разрешения, предоставляемые ролью `datasphere.community-projects.viewer`.

В интерфейсе {{ ml-platform-name }} пользователи с ролью `datasphere.community-projects.developer` имеют роль `Developer` на вкладке **Участники** на странице проекта.

#### datasphere.community-projects.editor {#datasphere-communityprojects-editor}

Роль `datasphere.community-projects.editor` позволяет работать в проектах, изменять и удалять их, а также управлять ресурсами, которые закреплены за проектами, и делиться такими ресурсами в сообществе.

Пользователи с этой ролью могут:
* просматривать информацию о [проектах](../datasphere/concepts/project.md), настройках проектов и закрепленных за ними ресурсах, а также изменять и удалять проекты;
* создавать, изменять и удалять [ресурсы](../datasphere/concepts/resources.md) в проектах, а также делиться ресурсами этого проекта с сообществами, в которых пользователь имеет права `Developer` (роль `datasphere.communities.developer` и выше);
* запускать IDE и исполнение ячеек с кодом в проектах;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к проектам.

Включает разрешения, предоставляемые ролью `datasphere.community-projects.developer`.

В интерфейсе {{ ml-platform-name }} пользователи с ролью `datasphere.community-projects.editor` имеют роль `Editor` на вкладке **Участники** на странице проекта.

#### datasphere.community-projects.admin {#datasphere-communityprojects-admin}

Роль `datasphere.community-projects.admin` позволяет управлять доступом к проектам, работать в них, изменять и удалять проекты, а также управлять ресурсами, которые закреплены за проектами, и делиться такими ресурсами в сообществе.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к проектам и изменять права доступа;
* просматривать информацию о [проектах](../datasphere/concepts/project.md), настройках проектов и закрепленных за ними ресурсах, а также изменять и удалять проекты;
* создавать, изменять и удалять [ресурсы](../datasphere/concepts/resources.md) в проектах, а также делиться ресурсами этого проекта с сообществами, в которых пользователь имеет роль `Developer` (`datasphere.communities.developer`) и выше;
* запускать IDE и исполнение ячеек с кодом в проектах.

Включает разрешения, предоставляемые ролью `datasphere.community-projects.editor`.

В интерфейсе {{ ml-platform-name }} пользователи с ролью `datasphere.community-projects.admin` имеют роль `Admin` на вкладке **Участники** на странице проекта.

#### datasphere.communities.viewer {#datasphere-communities-viewer}

Роль `datasphere.communities.viewer` позволяет просматривать информацию о сообществах и проектах, а также о назначенных правах доступа к ним.

Пользователи с этой ролью могут:
* просматривать информацию о [сообществах](../datasphere/concepts/community.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о [проектах](../datasphere/concepts/project.md) сообществ, настройках проектов и закрепленных за ними [ресурсах](../datasphere/concepts/resources.md), а также о назначенных правах доступа к проектам;
* просматривать информацию об [организации](../organization/concepts/organization.md).

Включает разрешения, предоставляемые ролью `datasphere.community-projects.viewer`.

В интерфейсе {{ ml-platform-name }} пользователи с ролью `datasphere.communities.viewer` имеют роль `Viewer` на вкладке **Участники** на странице сообщества.

#### datasphere.communities.developer {#datasphere-communities-developer}

Роль `datasphere.communities.developer` позволяет создавать новые проекты и публиковать ресурсы проектов в сообществах, а также просматривать информацию о сообществах и проектах.

Пользователи с этой ролью могут:
* просматривать информацию о [сообществах](../datasphere/concepts/community.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* создавать новые [проекты](../datasphere/concepts/project.md) в сообществах;
* публиковать [ресурсы](../datasphere/concepts/resources.md) проектов в сообществах, в которых пользователь имеет права `Developer` (роль `datasphere.communities.developer`) и выше;
* просматривать информацию о проектах, настройках проектов и закрепленных за ними ресурсах, а также о назначенных правах доступа к проектам;
* просматривать информацию об [организации](../organization/concepts/organization.md).

Включает разрешения, предоставляемые ролью `datasphere.communities.viewer`.

В интерфейсе {{ ml-platform-name }} пользователи с ролью `datasphere.communities.developer` имеют роль `Developer` на вкладке **Участники** на странице сообщества.

#### datasphere.communities.editor {#datasphere-communities-editor}

Роль `datasphere.communities.editor` позволяет привязывать платежный аккаунт к сообществам, удалять сообщества и редактировать их настройки, а также управлять проектами и ресурсами сообществ.

Пользователи с этой ролью могут:
* просматривать информацию о [сообществах](../datasphere/concepts/community.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также изменять и удалять сообщества;
* привязывать [платежный аккаунт](../billing/concepts/billing-account.md) к сообществам;
* создавать новые [проекты](../datasphere/concepts/project.md) в сообществах, а также изменять и удалять проекты;
* просматривать информацию о проектах, настройках проектов и закрепленных за ними ресурсах, а также о назначенных правах доступа к проектам;
* создавать, изменять и удалять [ресурсы](../datasphere/concepts/resources.md) в проектах, а также публиковать ресурсы проектов в сообществах, в которых пользователь имеет права `Developer` (роль `datasphere.communities.developer`) и выше;
* запускать IDE и исполнение ячеек с кодом в проектах;
* просматривать информацию об [организации](../organization/concepts/organization.md).

Включает разрешения, предоставляемые ролями `datasphere.communities.developer` и `datasphere.community-projects.editor`.

В интерфейсе {{ ml-platform-name }} пользователи с ролью `datasphere.communities.editor` имеют роль `Editor` на вкладке **Участники** на странице сообщества.

#### datasphere.communities.admin {#datasphere-communities-admin}

Роль `datasphere.communities.admin` позволяет управлять сообществами и проектами сообществ, а также доступом к ним.

Пользователи с этой ролью могут:
* просматривать информацию о [сообществах](../datasphere/concepts/community.md), а также изменять и удалять сообщества;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к сообществам и изменять права доступа;
* привязывать [платежный аккаунт](../billing/concepts/billing-account.md) к сообществам;
* создавать новые [проекты](../datasphere/concepts/project.md) в сообществах, а также изменять и удалять проекты;
* просматривать информацию о проектах, настройках проектов и закрепленных за ними ресурсах;
* просматривать информацию о назначенных правах доступа к проектам и изменять права доступа;
* создавать, изменять и удалять [ресурсы](../datasphere/concepts/resources.md) в проектах, а также публиковать ресурсы проектов в сообществах, в которых пользователь имеет права `Developer` (роль `datasphere.communities.developer` и выше);
* запускать IDE и исполнение ячеек с кодом в проектах;
* просматривать информацию об [организации](../organization/concepts/organization.md).

Включает разрешения, предоставляемые ролями `datasphere.communities.editor` и `datasphere.community-projects.admin`.

В интерфейсе {{ ml-platform-name }} пользователи с ролью `datasphere.communities.admin` имеют роль `Admin` на вкладке **Участники** на странице сообщества.

#### datasphere.user {#datasphere-user}

Роль `datasphere.user` позволяет запускать в проектах исполнение ячеек с кодом, просматривать информацию о проектах и квотах сервиса {{ ml-platform-name }}, а также об облаке и каталоге.

Роль `datasphere.user` устарела и больше не используется.

#### data-sphere.user {#data-sphere-user}

Роль `data-sphere.user` устарела и больше не используется.

#### datasphere.admin {#datasphere-admin}

Роль `datasphere.admin` позволяет управлять сообществами, проектами сообществ и доступом к ним, а также использовать облачные сети и ресурсы сервиса {{ vpc-name }}.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать информацию о сообществах, а также изменять и удалять сообщества;
* просматривать информацию о назначенных правах доступа к сообществам и изменять права доступа;
* привязывать платежный аккаунт к сообществам;
* создавать новые проекты в сообществах, а также изменять и удалять проекты;
* просматривать информацию о проектах, настройках проектов и закрепленных за ними ресурсах;
* просматривать информацию о назначенных правах доступа к проектам и изменять права доступа;
* создавать, изменять и удалять ресурсы в проектах, а также публиковать ресурсы проектов в сообществах, в которых пользователь имеет права `Developer` (роль `datasphere.communities.developer` и выше);
* запускать IDE и исполнение ячеек с кодом в проектах;
* просматривать список сервисных аккаунтов и использовать их;
* просматривать список облачных сетей и информацию о них, а также использовать облачные сети;
* просматривать список подсетей и информацию о них, а также использовать подсети;
* просматривать список адресов облачных ресурсов и информацию о них, а также использовать такие адреса;
* просматривать список таблиц маршрутизации и информацию о них, а также использовать таблицы маршрутизации;
* просматривать список групп безопасности и информацию о них, а также использовать группы безопасности;
* просматривать информацию о NAT-шлюзах и подключать их к таблицам маршрутизации;
* просматривать информацию об использованных IP-адресах в подсетях;
* просматривать информацию об операциях с ресурсами сервисов {{ vpc-name }} и {{ compute-name }};
* просматривать информацию о квотах сервисов {{ ml-platform-name }} и {{ vpc-name }};
* просматривать информацию об организации, облаке и каталоге.

{% endcut %}


Роль `datasphere.admin` устарела и больше не используется.

#### data-sphere.admin {#data-sphere-admin}

Роль `data-sphere.admin` устарела и больше не используется.

Подробнее см. [{#T}](../datasphere/security/index.md).


## {{ yds-full-name }} {#yds-roles}

#### yds.auditor {#yds-auditor}

Роль `yds.auditor` позволяет просматривать метаданные потоков данных Data Streams, устанавливать соединения c базами данных YDB, просматривать информацию о БД YDB и назначенных правах доступа к ним, а также о схемных объектах и резервных копиях БД YDB.

Пользователи с этой ролью могут:
* просматривать метаданные [потоков данных](../data-streams/concepts/glossary.md#stream-concepts) Data Streams;
* устанавливать соединения c [базами данных YDB](../ydb/concepts/resources.md#database);
* просматривать список баз данных и информацию о них, а также о назначенных [правах доступа](concepts/access-control/index.md) к базам данных YDB;
* просматривать информацию о резервных копиях баз данных YDB и назначенных правах доступа к таким резервным копиям;
* просматривать список схемных объектов БД YDB (таблиц, индексов и каталогов) и информацию о них;
* просматривать информацию о [квотах](../ydb/concepts/limits.md#ydb-quotas) сервиса Managed Service for YDB;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `ydb.auditor`.

#### yds.viewer {#yds-viewer}

Роль `yds.viewer` позволяет читать данные из потоков данных Data Streams и просматривать их настройки, а также устанавливать соединения c БД YDB, выполнять запросы на чтение данных, просматривать информацию о БД YDB и назначенных правах доступа к ним.

Пользователи с этой ролью могут:
* просматривать метаданные [потоков данных](../data-streams/concepts/glossary.md#stream-concepts) Data Streams и читать данные из таких потоков;
* устанавливать соединения c [базами данных YDB](../ydb/concepts/resources.md#database) и выполнять запросы на чтение данных;
* просматривать список баз данных YDB и информацию о них, а также о назначенных [правах доступа](concepts/access-control/index.md) к базам данных YDB;
* просматривать информацию о резервных копиях баз данных YDB и назначенных правах доступа к резервным копиям;
* просматривать список схемных объектов БД YDB (таблиц, индексов и каталогов) и информацию о них;
* просматривать информацию о [квотах](../ydb/concepts/limits.md#ydb-quotas) сервиса Managed Service for YDB;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `ydb.viewer`.

#### yds.writer {#yds-writer}

Роль `yds.writer` позволяет записывать данные в [потоки Data Streams](../data-streams/concepts/glossary.md#stream-concepts), а также устанавливать соединения c [базами данных YDB](../ydb/concepts/resources.md#database).

#### yds.editor {#yds-editor}

Роль `yds.editor` позволяет создавать, изменять и удалять потоки данных Data Streams, а также выполнять чтение и запись данных в потоках.

Пользователи с этой ролью могут:
* просматривать информацию о [потоках данных](../data-streams/concepts/glossary.md#stream-concepts), а также создавать, изменять и удалять потоки данных;
* выполнять чтение и запись данных в потоках Data Streams;
* просматривать список [баз данных YDB](../ydb/concepts/resources.md#database) и информацию о них и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также создавать, запускать, останавливать, изменять и удалять базы данных YDB; 
* устанавливать соединения c базами данных YDB и выполнять запросы на чтение и запись данных;
* просматривать информацию о резервных копиях баз данных YDB и назначенных правах доступа к резервным копиям, а также создавать резервные копии, удалять их и восстанавливать базы данных YDB из резервных копий;
* просматривать список схемных объектов БД YDB (таблиц, индексов и каталогов) и информацию о них, а также создавать, изменять и удалять схемные объекты БД YDB;
* просматривать информацию о [квотах](../ydb/concepts/limits.md#ydb-quotas) сервиса Managed Service for YDB;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролями `ydb.editor` и `yds.writer`.

#### yds.admin {#yds-admin}

Роль `yds.admin` позволяет создавать, изменять и удалять потоки данных Data Streams, а также выполнять чтение и запись данных в потоках.

Пользователи с этой ролью могут:
* просматривать информацию о [потоках данных](../data-streams/concepts/glossary.md#stream-concepts), а также создавать, изменять и удалять потоки данных;
* выполнять чтение и запись данных в потоках Data Streams;
* просматривать список [баз данных YDB](../ydb/concepts/resources.md#database) и информацию о них, а также создавать, запускать, останавливать, изменять и удалять базы данных YDB;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к базам данных YDB и изменять такие права доступа;
* устанавливать соединения c базами данных YDB и выполнять запросы на чтение и запись данных;
* просматривать информацию о резервных копиях баз данных YDB, а также создавать резервные копии, удалять их и восстанавливать базы данных YDB из резервных копий;
* просматривать информацию о назначенных правах доступа к резервным копиям и изменять такие права доступа;
* просматривать список схемных объектов БД YDB (таблиц, индексов и каталогов) и информацию о них, а также создавать, изменять и удалять схемные объекты БД YDB;
* просматривать информацию о [квотах](../ydb/concepts/limits.md#ydb-quotas) сервиса Managed Service for YDB;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `ydb.admin`.

Подробнее см. [{#T}](../data-streams/security/index.md).


## {{ data-transfer-full-name }} {#data-transfer-roles}

#### data-transfer.auditor {#data-transfer-auditor}

Роль `data-transfer.auditor` позволяет просматривать метаданные сервиса, в том числе информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder), [эндпоинтах](../data-transfer/concepts/index.md#endpoint) и [трансферах](../data-transfer/concepts/index.md#transfer), а также о [квотах](../data-transfer/concepts/limits.md#dataproc-quotas) сервиса {{ data-transfer-name }}.

Сейчас эту роль можно назначить только на каталог или облако.

#### data-transfer.viewer {#data-transfer-viewer}

Роль `data-transfer.viewer` позволяет просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder), [эндпоинтах](../data-transfer/concepts/index.md#endpoint) и [трансферах](../data-transfer/concepts/index.md#transfer), а также о [квотах](../data-transfer/concepts/limits.md#dataproc-quotas) сервиса {{ data-transfer-name }}.

Включает разрешения, предоставляемые ролью `data-transfer.auditor`.

Сейчас эту роль можно назначить только на каталог или облако.

#### data-transfer.privateAdmin {#data-transfer-privateadmin}

Роль `data-transfer.privateAdmin` позволяет управлять эндпоинтами и трансферами с передачей данных только в сетях {{ yandex-cloud }}, а также просматривать информацию о каталоге и квотах сервиса {{ data-transfer-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о [трансферах](../data-transfer/concepts/index.md#transfer), а также создавать, изменять, удалять, активировать, использовать и деактивировать трансферы с передачей данных в сетях {{ yandex-cloud }};
* просматривать информацию об [эндпоинтах](../data-transfer/concepts/index.md#endpoint), а также создавать, изменять и удалять эндпоинты в {{ yandex-cloud }};
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder);
* просматривать информацию о [квотах](../data-transfer/concepts/limits.md#dataproc-quotas) сервиса {{ data-transfer-name }}.

Включает разрешения, предоставляемые ролью `data-transfer.viewer`.

Сейчас эту роль можно назначить только на каталог или облако.

#### data-transfer.admin {#data-transfer-admin}

Роль `data-transfer.admin` позволяет управлять эндпоинтами и трансферами с передачей данных в сетях {{ yandex-cloud }} и через интернет, а также просматривать информацию о каталоге и квотах сервиса {{ data-transfer-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о [трансферах](../data-transfer/concepts/index.md#transfer), а также создавать, изменять, удалять, активировать, использовать и деактивировать трансферы с передачей данных как в сетях {{ yandex-cloud }}, так и через интернет;
* просматривать информацию об [эндпоинтах](../data-transfer/concepts/index.md#endpoint), а также создавать, изменять и удалять эндпоинты как в {{ yandex-cloud }}, так и за его пределами;
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder);
* просматривать информацию о [квотах](../data-transfer/concepts/limits.md#dataproc-quotas) сервиса {{ data-transfer-name }}.

Включает разрешения, предоставляемые ролью `data-transfer.privateAdmin`.

Сейчас эту роль можно назначить только на каталог или облако.

Подробнее см. [{#T}](../data-transfer/security/index.md).


## {{ iam-full-name }} {#iam-roles}

#### iam.serviceAccounts.user {#iam-serviceAccounts-user}

Роль `iam.serviceAccounts.user` позволяет пользователю просматривать список сервисных аккаунтов и информацию о них, а также выполнять операции от имени сервисного аккаунта.

Например, если при создании группы виртуальных машин пользователь укажет [сервисный аккаунт](concepts/users/accounts.md#sa), сервис IAM проверяет, что у этого пользователя есть права на использование этого сервисного аккаунта.

#### iam.serviceAccounts.admin {#iam-serviceAccounts-admin}

Роль `iam.serviceAccounts.admin` позволяет управлять сервисными аккаунтами, доступом к ним и их ключами, а также позволяет пользователю получать IAM-токен для сервисного аккаунта.

Пользователи с этой ролью могут:
* просматривать список [сервисных аккаунтов](concepts/users/accounts.md#sa) и информацию о них, а также создавать, использовать, изменять и удалять сервисные аккаунты;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к сервисным аккаунтам и изменять такие права доступа;
* получать [IAM-токен](concepts/authorization/iam-token.md) для сервисного аккаунта;
* просматривать список [API-ключей](concepts/authorization/api-key.md) сервисных аккаунтов и информацию о таких ключах, а также создавать, изменять и удалять их;
* просматривать список [статических ключей доступа](concepts/authorization/access-key.md) сервисных аккаунтов и информацию о таких ключах, а также создавать, изменять и удалять их;
* просматривать информацию об [авторизованных ключах](concepts/authorization/key.md) сервисных аккаунтов, а также создавать, изменять и удалять их;
* создавать [эфемерные ключи доступа](concepts/authorization/ephemeral-keys.md) сервисных аккаунтов;
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder) и его настройки.

#### iam.serviceAccounts.ephemeralAccessKeyAdmin {#iam-serviceAccounts-ephemeralAccessKeyAdmin}

Роль `iam.serviceAccounts.ephemeralAccessKeyAdmin` позволяет создавать [эфемерные ключи доступа](concepts/authorization/ephemeral-keys.md) сервисных аккаунтов.

#### iam.serviceAccounts.accessKeyAdmin {#iam-serviceAccounts-accessKeyAdmin}

Роль `iam.serviceAccounts.accessKeyAdmin` позволяет управлять статическими и эфемерными ключами доступа сервисных аккаунтов.

Пользователи с этой ролью могут:
* просматривать список [статических ключей доступа](concepts/authorization/access-key.md) сервисных аккаунтов и информацию о таких ключах;
* создавать, изменять и удалять статические ключи доступа [сервисных аккаунтов](concepts/users/accounts.md#sa);
* создавать [эфемерные ключи доступа](concepts/authorization/ephemeral-keys.md) сервисных аккаунтов.

Включает разрешения, предоставляемые ролью `iam.serviceAccounts.ephemeralAccessKeyAdmin`.

#### iam.serviceAccounts.apiKeyAdmin {#iam-serviceAccounts-apiKeyAdmin}

Роль `iam.serviceAccounts.apiKeyAdmin` позволяет управлять API-ключами сервисных аккаунтов.

Пользователи с этой ролью могут:
* просматривать список [API-ключей](concepts/authorization/api-key.md) сервисных аккаунтов и информацию о таких ключах;
* создавать, изменять и удалять API-ключи [сервисных аккаунтов](concepts/users/accounts.md#sa).

#### iam.serviceAccounts.authorizedKeyAdmin {#iam-serviceAccounts-authorizedKeyAdmin}

Роль `iam.serviceAccounts.authorizedKeyAdmin` позволяет просматривать информацию об [авторизованных ключах](concepts/authorization/key.md) сервисных аккаунтов, а также создавать, изменять и удалять такие ключи.

#### iam.serviceAccounts.keyAdmin {#iam-serviceAccounts-keyAdmin}

Роль `iam.serviceAccounts.keyAdmin` позволяет управлять ключами доступа сервисных аккаунтов: статическими, эфемерными, авторизованными и API‑ключами.
Пользователи с этой ролью могут:
* просматривать список [статических ключей доступа](concepts/authorization/access-key.md) сервисных аккаунтов и информацию о таких ключах, а также создавать, изменять и удалять статические ключи доступа;
* просматривать список [API-ключей](concepts/authorization/api-key.md) сервисных аккаунтов и информацию о таких ключах, а также создавать, изменять и удалять API-ключи;
* просматривать информацию об [авторизованных ключах](concepts/authorization/key.md) сервисных аккаунтов, а также создавать, изменять и удалять такие ключи;
* создавать [эфемерные ключи доступа](concepts/authorization/ephemeral-keys.md) сервисных аккаунтов.

Включает разрешения, предоставляемые ролями `iam.serviceAccounts.accessKeyAdmin`, `iam.serviceAccounts.apiKeyAdmin` и `iam.serviceAccounts.authorizedKeyAdmin`.

#### iam.serviceAccounts.tokenCreator {#iam-serviceAccounts-tokenCreator}

Роль `iam.serviceAccounts.tokenCreator` позволяет пользователю получать IAM-токен для сервисного аккаунта.

С помощью такого [IAM-токена](concepts/authorization/iam-token.md) пользователь сможет [имперсонироваться](concepts/access-control/impersonation.md) в сервисный аккаунт и выполнять действия, разрешенные для этого [сервисного аккаунта](concepts/users/accounts.md#sa).

Роль не позволяет пользователю изменять права доступа или удалять сервисный аккаунт.

#### iam.serviceAccounts.federatedCredentialViewer {#iam-serviceAccounts-federatedCredentialViewer}

Роль `iam.serviceAccounts.federatedCredentialViewer` позволяет просматривать список [привязок](concepts/workload-identity.md#federated-credentials) в [федерациях сервисных аккаунтов](concepts/workload-identity.md) и информацию о таких привязках.

#### iam.serviceAccounts.federatedCredentialEditor {#iam-serviceAccounts-federatedCredentialEditor}

Роль `iam.serviceAccounts.federatedCredentialEditor` позволяет просматривать список [привязок](concepts/workload-identity.md#federated-credentials) в [федерациях сервисных аккаунтов](concepts/workload-identity.md) и информацию о таких привязках, а также создавать и удалять привязки.

Включает разрешения, предоставляемые ролью `iam.serviceAccounts.federatedCredentialViewer`.

#### iam.workloadIdentityFederations.auditor {#iam-workloadIdentityFederations-auditor}

Роль `iam.workloadIdentityFederations.auditor` позволяет просматривать метаданные [федераций сервисных аккаунтов](concepts/workload-identity.md).

#### iam.workloadIdentityFederations.viewer {#iam-workloadIdentityFederations-viewer}

Роль `iam.workloadIdentityFederations.viewer` позволяет просматривать информацию о [федерациях сервисных аккаунтов](concepts/workload-identity.md).

Включает разрешения, предоставляемые ролью `iam.workloadIdentityFederations.auditor`.

#### iam.workloadIdentityFederations.user {#iam-workloadIdentityFederations-user}

Роль `iam.workloadIdentityFederations.user` позволяет использовать [федерации сервисных аккаунтов](concepts/workload-identity.md).

#### iam.workloadIdentityFederations.editor {#iam-workloadIdentityFederations-editor}

Роль `iam.workloadIdentityFederations.editor` позволяет просматривать информацию о [федерациях сервисных аккаунтов](concepts/workload-identity.md), а также создавать, изменять и удалять такие федерации.

Включает разрешения, предоставляемые ролью `iam.workloadIdentityFederations.viewer`.

#### iam.workloadIdentityFederations.admin {#iam-workloadIdentityFederations-admin}

Роль `iam.workloadIdentityFederations.admin` позволяет просматривать информацию о [федерациях сервисных аккаунтов](concepts/workload-identity.md), а также создавать, изменять, использовать и удалять такие федерации.

Включает разрешения, предоставляемые ролями `iam.workloadIdentityFederations.editor` и `iam.workloadIdentityFederations.user`.

#### iam.userAccounts.refreshTokenViewer {#iam-userAccounts-refreshTokenViewer}

Роль `iam.userAccounts.refreshTokenViewer` позволяет просматривать списки [refresh-токенов](concepts/authorization/refresh-token.md) федеративных пользователей. Роль назначается на [организацию](../organization/concepts/organization.md).

#### iam.userAccounts.refreshTokenRevoker {#iam-userAccounts-refreshTokenRevoker}

Роль `iam.userAccounts.refreshTokenRevoker` позволяет отзывать [refresh-токены](concepts/authorization/refresh-token.md) федеративных пользователей. Роль назначается на [организацию](../organization/concepts/organization.md).

#### iam.auditor {#iam-auditor}

Роль `iam.auditor` позволяет просматривать информацию о сервисных аккаунтах и их ключах, а также об операциях с ресурсами и квотах сервиса.

Пользователи с этой ролью могут:
* просматривать список [сервисных аккаунтов](concepts/users/accounts.md#sa) и информацию о них;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к сервисным аккаунтам;
* просматривать список [API-ключей](concepts/authorization/api-key.md) сервисных аккаунтов и информацию о таких ключах;
* просматривать список [статических ключей доступа](concepts/authorization/access-key.md) сервисных аккаунтов и информацию о таких ключах;
* просматривать информацию об [авторизованных ключах](concepts/authorization/key.md) сервисных аккаунтов;
* просматривать список операций и информацию об операциях с ресурсами сервиса;
* просматривать информацию о [квотах](concepts/limits.md#iam-quotas) сервиса Identity and Access Management;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и его настройки;
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder) и его настройки.

#### iam.viewer {#iam-viewer}

Роль `iam.viewer` позволяет просматривать информацию о сервисных аккаунтах и их ключах, а также об операциях с ресурсами и квотах сервиса.

Пользователи с этой ролью могут:
* просматривать список [сервисных аккаунтов](concepts/users/accounts.md#sa) и информацию о них;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к сервисным аккаунтам;
* просматривать список [API-ключей](concepts/authorization/api-key.md) сервисных аккаунтов и информацию о таких ключах;
* просматривать список [статических ключей доступа](concepts/authorization/access-key.md) сервисных аккаунтов и информацию о таких ключах;
* просматривать информацию об [авторизованных ключах](concepts/authorization/key.md) сервисных аккаунтов;
* просматривать список операций и информацию об операциях с ресурсами сервиса;
* просматривать информацию о [квотах](concepts/limits.md#iam-quotas) сервиса Identity and Access Management;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и его настройки;
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder) и его настройки.

Включает разрешения, предоставляемые ролью `iam.auditor`.

#### iam.editor {#iam-editor}

Роль `iam.editor` позволяет управлять сервисными аккаунтами и их ключами, управлять каталогами, а также просматривать информацию об операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать список [сервисных аккаунтов](concepts/users/accounts.md#sa) и информацию о них, а также создавать, использовать, изменять и удалять их;
* просматривать список [API-ключей](concepts/authorization/api-key.md) сервисных аккаунтов и информацию о таких ключах, а также создавать, изменять и удалять их;
* просматривать список [статических ключей доступа](concepts/authorization/access-key.md) сервисных аккаунтов и информацию о таких ключах, а также создавать, изменять и удалять их;
* просматривать информацию об [авторизованных ключах](concepts/authorization/key.md) сервисных аккаунтов, а также создавать, изменять и удалять их;
* создавать [эфемерные ключи доступа](concepts/authorization/ephemeral-keys.md) сервисных аккаунтов;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к сервисным аккаунтам;
* просматривать список операций и информацию об операциях с ресурсами сервиса;
* просматривать информацию о [квотах](concepts/limits.md#iam-quotas) сервиса Identity and Access Management;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и его настройки;
* просматривать информацию о [каталогах](../resource-manager/concepts/resources-hierarchy.md#folder) и их настройки;
* создавать, изменять, удалять и настраивать каталоги.

Включает разрешения, предоставляемые ролью `iam.viewer`.

#### iam.admin {#iam-admin}

Роль `iam.admin` позволяет управлять сервисными аккаунтами, доступом к ним и их ключами, управлять каталогами, просматривать информацию о квотах и операциях с ресурсами сервиса, а также позволяет пользователю получать IAM-токен для сервисного аккаунта.

Пользователи с этой ролью могут:
* просматривать список [сервисных аккаунтов](concepts/users/accounts.md#sa) и информацию о них, а также создавать, использовать, изменять и удалять их;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к сервисным аккаунтам и изменять такие права доступа;
* получать [IAM-токен](concepts/authorization/iam-token.md) для сервисного аккаунта;
* просматривать список [API-ключей](concepts/authorization/api-key.md) сервисных аккаунтов и информацию о таких ключах, а также создавать, изменять и удалять их;
* просматривать список [статических ключей доступа](concepts/authorization/access-key.md) сервисных аккаунтов и информацию о таких ключах, а также создавать, изменять и удалять их;
* просматривать информацию об [авторизованных ключах](concepts/authorization/key.md) сервисных аккаунтов, а также создавать, изменять и удалять их;
* создавать [эфемерные ключи доступа](concepts/authorization/ephemeral-keys.md) сервисных аккаунтов;
* просматривать информацию о [федерациях удостоверений](concepts/federations.md);
* просматривать список операций и информацию об операциях с ресурсами сервиса;
* просматривать информацию о [квотах](concepts/limits.md#iam-quotas) сервиса Identity and Access Management;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и его настройки;
* просматривать информацию о [каталогах](../resource-manager/concepts/resources-hierarchy.md#folder) и их настройки;
* создавать, изменять, удалять и настраивать каталоги.

Включает разрешения, предоставляемые ролями `iam.editor` и `iam.serviceAccounts.admin`.

Подробнее см. [{#T}](security/index.md).


## {{ org-full-name }} {#organization-roles}

#### organization-manager.auditor {#organization-manager-auditor}

Роль `organization-manager.auditor` позволяет просматривать информацию об организации и ее настройках, о входящих в организацию федерациях удостоверений, пулах пользователей, SAML-приложениях и OIDC-приложениях, а также о пользователях и группах пользователей организации.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать информацию об [организации](../organization/concepts/organization.md) {{ org-full-name }} и ее настройках;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к организации;
* просматривать [политики авторизации](concepts/access-control/access-policies.md), назначенные на организацию;
* просматривать настройки [брендирования](../organization/concepts/branding.md) организации;
* просматривать список [пользователей](../overview/roles-and-resources.md#users) организации и сведения в профилях пользователей (кроме номера телефона), дату последней аутентификации, а также дату последней верификации федеративных и локальных аккаунтов с помощью [двухфакторной аутентификации](../organization/concepts/mfa.md);
* просматривать информацию о правах доступа, назначенных [субъектам](concepts/access-control/index.md#subject) в организации {{ org-full-name }};
* просматривать информацию о [федерациях удостоверений](../organization/concepts/add-federation.md) в организации;
* просматривать информацию о [сертификатах](../organization/concepts/add-federation.md#build-trust) федераций удостоверений;
* просматривать списки [сопоставлений](../organization/concepts/add-federation.md#group-mapping) групп [федеративных пользователей](concepts/users/accounts.md#saml-federation) и информацию о таких сопоставлениях;
* просматривать информацию об атрибутах [федеративных](concepts/users/accounts.md#saml-federation) пользователей;
* просматривать информацию о [пулах пользователей](../organization/concepts/user-pools.md) и назначенных правах доступа к ним;
* просматривать информацию об атрибутах [локальных](concepts/users/accounts.md#local) пользователей, входящих в пулы пользователей;
* просматривать информацию о [доменах](../organization/concepts/domains.md), привязанных к пулам пользователей;
* просматривать информацию о SAML-приложениях и OIDC-приложениях, а также о назначенных правах доступа к ним;
* просматривать список пользователей, добавленных в SAML-приложения и OIDC-приложения;
* получать сертификаты SAML-приложений;
* просматривать список пользователей организации, [подписанных](../organization/operations/subscribe-user-for-notifications.md) на получение технических уведомлений о событиях в организации;
* просматривать информацию о [политиках MFA](../organization/concepts/mfa.md#mfa-policies);
* просматривать информацию о настройках [{{ oslogin }}](../organization/concepts/os-login.md) организации;
* просматривать список [профилей](../organization/concepts/os-login.md#os-login-profiles) {{ oslogin }} пользователей и сервисных аккаунтов;
* просматривать список SSH-ключей пользователей организации, а также информацию об SSH-ключах;
* просматривать информацию о [группах пользователей](../organization/concepts/groups.md) и о назначенных правах доступа к таким группам;
* просматривать список групп, в которые входит тот или иной пользователь, а также список пользователей, которые входят в ту или иную группу;
* просматривать информацию о [refresh-токенах](concepts/authorization/refresh-token.md) пользователей организации, а также о настройках refresh-токенов в организации;
* просматривать информацию о квотах сервиса {{ org-full-name }};
* просматривать информацию о действующем [тарифном плане](../support/pricing.md#effective-plans) технической поддержки;
* просматривать список [обращений](../support/overview.md) в техническую поддержку и информацию о них, а также создавать такие обращения, оставлять в них комментарии и вложения и закрывать их.

{% endcut %}

Включает разрешения, предоставляемые ролями `iam.userAccounts.refreshTokenViewer`, `organization-manager.federations.auditor`, `organization-manager.osLogins.viewer`, `organization-manager.userpools.auditor`, `organization-manager.samlApplications.auditor`, `organization-manager.oauthApplications.auditor` и `organization-manager.groups.viewer`.

#### organization-manager.viewer {#organization-manager-viewer}

Роль `organization-manager.viewer` позволяет просматривать информацию об организации и ее настройках, о входящих в организацию федерациях удостоверений, пулах пользователей, SAML-приложениях и OIDC-приложениях, а также о пользователях и группах пользователей организации.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать информацию об [организации](../organization/concepts/organization.md) {{ org-full-name }} и ее настройках;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к организации;
* просматривать [политики авторизации](concepts/access-control/access-policies.md), назначенные на организацию;
* просматривать настройки [брендирования](../organization/concepts/branding.md) организации;
* просматривать список [пользователей](../overview/roles-and-resources.md#users) организации, информацию о них (включая номер телефона), дату последней аутентификации, а также дату последней верификации федеративных и локальных аккаунтов с помощью [двухфакторной аутентификации](../organization/concepts/mfa.md);
* просматривать информацию о правах доступа, назначенных [субъектам](concepts/access-control/index.md#subject) в организации {{ org-full-name }};
* просматривать информацию о [федерациях удостоверений](../organization/concepts/add-federation.md) в организации;
* просматривать информацию о [сертификатах](../organization/concepts/add-federation.md#build-trust) федераций удостоверений;
* просматривать списки [сопоставлений](../organization/concepts/add-federation.md#group-mapping) групп [федеративных пользователей](concepts/users/accounts.md#saml-federation) и информацию о таких сопоставлениях;
* просматривать информацию об атрибутах [федеративных](concepts/users/accounts.md#saml-federation) пользователей;
* просматривать информацию о [пулах пользователей](../organization/concepts/user-pools.md) и назначенных правах доступа к ним;
* просматривать информацию об атрибутах [локальных](concepts/users/accounts.md#local) пользователей, входящих в пулы пользователей;
* просматривать события аудита пользователя;
* просматривать информацию о [доменах](../organization/concepts/domains.md), привязанных к пулам пользователей;
* просматривать информацию о SAML-приложениях и OIDC-приложениях, а также о назначенных правах доступа к ним;
* просматривать список пользователей, добавленных в SAML-приложения и OIDC-приложения;
* получать сертификаты SAML-приложений;
* просматривать список пользователей организации, [подписанных](../organization/operations/subscribe-user-for-notifications.md) на получение технических уведомлений о событиях в организации;
* просматривать информацию о [политиках MFA](../organization/concepts/mfa.md#mfa-policies);
* просматривать информацию о настройках [{{ oslogin }}](../organization/concepts/os-login.md) организации;
* просматривать список [профилей](../organization/concepts/os-login.md#os-login-profiles) {{ oslogin }} пользователей и сервисных аккаунтов;
* просматривать список SSH-ключей пользователей организации, а также информацию об SSH-ключах;
* просматривать информацию о [группах пользователей](../organization/concepts/groups.md) и о назначенных правах доступа к таким группам;
* просматривать список групп, в которые входит тот или иной пользователь, а также список пользователей, которые входят в ту или иную группу;
* просматривать список и информацию о группах пользователей {{ org-full-name }}, привязанных к федерациям удостоверений и пулам пользователей в процессе синхронизации с пользовательскими группами в каталоге Active Directory или другом внешнем источнике;
* просматривать информацию о подписке на платные возможности сервиса {{ org-full-name }};
* просматривать информацию о статистике использования квот по подписке на платные возможности сервиса {{ org-full-name }};
* просматривать список пользователей, которые в текущем [отчетном периоде](../billing/concepts/reporting-period.md) используют квоту для аутентификации в {{ org-full-name }};
* просматривать информацию о [refresh-токенах](concepts/authorization/refresh-token.md) пользователей организации, а также о настройках refresh-токенов в организации;
* просматривать [сессии](../organization/concepts/sessions.md) федеративных и локальных пользователей;
* просматривать информацию о квотах сервиса {{ org-full-name }};
* просматривать информацию о действующем [тарифном плане](../support/pricing.md#effective-plans) технической поддержки;
* просматривать список [обращений](../support/overview.md) в техническую поддержку и информацию о них, а также создавать такие обращения, оставлять в них комментарии и вложения и закрывать их.

{% endcut %}

Включает разрешения, предоставляемые ролями `organization-manager.auditor`, `organization-manager.federations.viewer`, `organization-manager.users.viewer`, `organization-manager.samlApplications.viewer`, `organization-manager.oauthApplications.viewer`, `organization-manager.userpools.viewer` и `organization-manager.idpInstances.billingViewer`.

#### organization-manager.editor {#organization-manager-editor}

Роль `organization-manager.editor` позволяет управлять настройками организации, федерациями удостоверений, пулами пользователей, SAML-приложениями, OIDC-приложениями, а также пользователями и их группами.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать и изменять информацию об [организации](../organization/concepts/organization.md) {{ org-full-name }};
* просматривать и изменять настройки организации;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к организации;
* просматривать [политики авторизации](concepts/access-control/access-policies.md), назначенные на организацию;
* просматривать и изменять настройки [брендирования](../organization/concepts/branding.md) организации;
* просматривать список [пользователей](../overview/roles-and-resources.md#users) организации, информацию о них (включая номер телефона), дату последней аутентификации, а также дату последней верификации федеративных и локальных аккаунтов с помощью [двухфакторной аутентификации](../organization/concepts/mfa.md);
* просматривать информацию о правах доступа, назначенных [субъектам](concepts/access-control/index.md#subject) в организации {{ org-full-name }};
* просматривать информацию о [федерациях удостоверений](../organization/concepts/add-federation.md) в организации, а также создавать, изменять и удалять федерации удостоверений;
* добавлять и удалять федеративных пользователей;
* просматривать информацию о [сертификатах](../organization/concepts/add-federation.md#build-trust) федераций удостоверений, а также добавлять, изменять и удалять такие сертификаты;
* настраивать [сопоставление](../organization/concepts/add-federation.md#group-mapping) групп [федеративных пользователей](concepts/users/accounts.md#saml-federation);
* просматривать списки сопоставлений групп федеративных пользователей и информацию о таких сопоставлениях, а также создавать, изменять и удалять такие списки сопоставлений;
* просматривать информацию об атрибутах [федеративных](concepts/users/accounts.md#saml-federation) пользователей, а также создавать и удалять такие атрибуты;
* просматривать информацию о [пулах пользователей](../organization/concepts/user-pools.md) и назначенных правах доступа к ним;
* создавать, изменять и удалять пулы пользователей;
* просматривать информацию о [доменах](../organization/concepts/domains.md), привязанных к пулам пользователей, а также добавлять, подтверждать и удалять домены;
* создавать, удалять, активировать и деактивировать [локальных](concepts/users/accounts.md#local) пользователей, входящих в пулы пользователей;
* просматривать информацию об атрибутах локальных пользователей;
* просматривать события аудита пользователя;
* изменять данные пользователей: имя пользователя, пароль, домен, адрес электронной почты, а также ФИО и телефон;
* просматривать информацию о SAML-приложениях и OIDC-приложениях, а также о назначенных правах доступа к ним;
* создавать, деактивировать, активировать, изменять и удалять SAML-приложения и OIDC-приложения;
* просматривать список пользователей, добавленных в SAML-приложения и OIDC-приложения;
* получать сертификаты SAML-приложений, а также создавать, изменять и удалять такие сертификаты;
* просматривать список пользователей организации, [подписанных](../organization/operations/subscribe-user-for-notifications.md) на получение технических уведомлений о событиях в организации, и изменять этот список;
* просматривать информацию о [политиках MFA](../organization/concepts/mfa.md#mfa-policies), а также создавать, изменять, активировать, деактивировать и удалять такие политики;
* удалять [факторы MFA](../organization/concepts/mfa.md#mfa-factors) федеративных и [локальных](concepts/users/accounts.md#local) аккаунтов пользователей;
* сбрасывать дату верификации федеративных и локальных аккаунтов пользователей;
* просматривать информацию о настройках [{{ oslogin }}](../organization/concepts/os-login.md) организации;
* просматривать список [профилей](../organization/concepts/os-login.md#os-login-profiles) {{ oslogin }} пользователей и сервисных аккаунтов;
* просматривать список SSH-ключей пользователей организации, а также информацию об SSH-ключах;
* просматривать информацию о [группах пользователей](../organization/concepts/groups.md), а также создавать, изменять и удалять группы пользователей;
* просматривать информацию о назначенных правах доступа к группам пользователей;
* просматривать список групп, в которые входит тот или иной пользователь, а также список пользователей, которые входят в ту или иную группу;
* просматривать список и информацию о группах пользователей {{ org-full-name }}, привязанных к федерациям удостоверений и пулам пользователей в процессе синхронизации с пользовательскими группами в каталоге Active Directory или другом внешнем источнике;
* просматривать информацию о подписке на платные возможности сервиса {{ org-full-name }};
* просматривать информацию о статистике использования квот по подписке на платные возможности сервиса {{ org-full-name }};
* просматривать список пользователей, которые в текущем [отчетном периоде](../billing/concepts/reporting-period.md) используют квоту для аутентификации в {{ org-full-name }};
* просматривать и изменять настройки [refresh-токенов](concepts/authorization/refresh-token.md) в организации;
* просматривать информацию о refresh-токенах пользователей организации и отзывать такие refresh-токены;
* просматривать и завершать [сессии](../organization/concepts/sessions.md) федеративных и локальных пользователей;
* просматривать информацию о квотах сервиса {{ org-full-name }};
* просматривать информацию о действующем [тарифном плане](../support/pricing.md#effective-plans) технической поддержки;
* просматривать список [обращений](../support/overview.md) в техническую поддержку и информацию о них, а также создавать такие обращения, оставлять в них комментарии и вложения и закрывать их.

{% endcut %}

Включает разрешения, предоставляемые ролями `organization-manager.viewer`, `organization-manager.federations.editor`, `organization-manager.userpools.editor`, `organization-manager.samlApplications.editor`, `organization-manager.oauthApplications.editor` и `organization-manager.groups.editor`.

Для настройки сопоставления групп пользователей роль должна быть назначена на те группы в {{ org-full-name }}, которые вы будете сопоставлять.

#### organization-manager.admin {#organization-manager-admin}

Роль `organization-manager.admin` позволяет управлять настройками организации, федерациями удостоверений, пулами пользователей, SAML-приложениями, OIDC-приложениями, пользователями и их группами, а также правами доступа пользователей к организации и ресурсам в ней.

{% cut "Пользователи с этой ролью могут:" %}

* привязывать [платежный аккаунт](../billing/concepts/billing-account.md) к [организации {{ org-full-name }}](../organization/concepts/organization.md);
* просматривать и изменять информацию об организации {{ org-full-name }};
* просматривать и изменять настройки организации;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к организации и изменять такие права доступа;
* просматривать [политики авторизации](concepts/access-control/access-policies.md), назначенные на организацию, а также назначать и отзывать такие политики;
* просматривать и изменять настройки [брендирования](../organization/concepts/branding.md) организации;
* просматривать список [пользователей](../overview/roles-and-resources.md#users) организации, информацию о них (включая номер телефона), дату последней аутентификации, а также дату последней верификации федеративных и локальных аккаунтов с помощью [двухфакторной аутентификации](../organization/concepts/mfa.md);
* просматривать информацию о правах доступа, назначенных [субъектам](concepts/access-control/index.md#subject) в организации {{ org-full-name }};
* исключать пользователей из организации;
* просматривать информацию об отправленных пользователям приглашениях в организацию, а также [отправлять](../organization/operations/add-account.md#send-invitation) и удалять такие приглашения;
* просматривать информацию о [федерациях удостоверений](../organization/concepts/add-federation.md) в организации, а также создавать, изменять и удалять федерации удостоверений;
* добавлять и удалять федеративных пользователей;
* просматривать информацию о [сертификатах](../organization/concepts/add-federation.md#build-trust) федераций удостоверений, а также добавлять, изменять и удалять такие сертификаты;
* настраивать [сопоставление](../organization/concepts/add-federation.md#group-mapping) групп [федеративных пользователей](concepts/users/accounts.md#saml-federation);
* просматривать списки сопоставлений групп федеративных пользователей и информацию о таких сопоставлениях, а также создавать, изменять и удалять такие списки сопоставлений;
* просматривать информацию об атрибутах [федеративных](concepts/users/accounts.md#saml-federation) пользователей, а также создавать и удалять такие атрибуты;
* просматривать информацию о [пулах пользователей](../organization/concepts/user-pools.md), а также создавать, изменять и удалять их;
* просматривать информацию о назначенных правах доступа к пулам пользователей и изменять такие права доступа;
* просматривать информацию о [доменах](../organization/concepts/domains.md), привязанных к пулам пользователей, а также добавлять, подтверждать и удалять домены;
* создавать, удалять, активировать и деактивировать [локальных](concepts/users/accounts.md#local) пользователей, входящих в пулы пользователей;
* просматривать информацию об атрибутах локальных пользователей;
* просматривать события аудита пользователя;
* изменять данные пользователей: имя пользователя, пароль, домен, адрес электронной почты, а также ФИО и телефон;
* просматривать информацию о SAML-приложениях и OIDC-приложениях, а также создавать, деактивировать, активировать, изменять и удалять их;
* просматривать информацию о назначенных правах доступа к SAML-приложениям и OIDC-приложениям, а также изменять такие права доступа;
* просматривать и изменять список пользователей, добавленных в SAML-приложения и OIDC-приложения;
* получать сертификаты SAML-приложений, а также создавать, изменять и удалять такие сертификаты;
* просматривать список пользователей организации, [подписанных](../organization/operations/subscribe-user-for-notifications.md) на получение технических уведомлений о событиях в организации, и изменять этот список;
* просматривать информацию о [политиках MFA](../organization/concepts/mfa.md#mfa-policies), а также создавать, изменять, активировать, деактивировать и удалять такие политики;
* удалять [факторы MFA](../organization/concepts/mfa.md#mfa-factors) федеративных и [локальных](concepts/users/accounts.md#local) аккаунтов пользователей;
* сбрасывать дату верификации федеративных и локальных аккаунтов пользователей;
* просматривать информацию о настройках [{{ oslogin }}](../organization/concepts/os-login.md) организации и изменять такие настройки;
* просматривать список [профилей](../organization/concepts/os-login.md#os-login-profiles) {{ oslogin }} пользователей и [сервисных аккаунтов](concepts/users/service-accounts.md), а также создавать, изменять и удалять профили {{ oslogin }};
* просматривать список SSH-ключей пользователей организации и информацию об SSH-ключах, а также создавать, изменять и удалять SSH-ключи пользователей;
* просматривать информацию о [группах пользователей](../organization/concepts/groups.md), а также создавать, изменять и удалять группы пользователей;
* добавлять пользователей и сервисные аккаунты в группы пользователей и удалять их из групп;
* просматривать информацию о назначенных правах доступа к группам пользователей и изменять такие права доступа;
* просматривать список групп, в которые входит тот или иной пользователь, а также список пользователей, которые входят в ту или иную группу;
* просматривать список и информацию о группах пользователей {{ org-full-name }}, привязанных к федерациям удостоверений и пулам пользователей в процессе синхронизации с пользовательскими группами в каталоге Active Directory или другом внешнем источнике;
* просматривать состав участников групп пользователей {{ org-full-name }}, связанных с пользовательскими группами в каталоге Active Directory или другом внешнем источнике, а также управлять составом участников таких групп;
* привязывать группы пользователей к федерациям удостоверений и пулам пользователей в процессе синхронизации с пользовательскими группами в каталоге Active Directory или другом внешнем источнике, а также отвязывать их;
* изменять и удалять группы пользователей {{ org-full-name }}, связанные с пользовательскими группами в каталоге Active Directory или другом внешнем источнике;
* привязывать сервис {{ org-full-name }} к платежному аккаунту;
* просматривать информацию о подписке на платные возможности сервиса {{ org-full-name }};
* просматривать информацию о статистике использования квот по подписке на платные возможности сервиса {{ org-full-name }}, а также изменять эти квоты;
* просматривать список пользователей, которые в текущем [отчетном периоде](../billing/concepts/reporting-period.md) используют квоту для аутентификации в {{ org-full-name }};
* просматривать и изменять настройки [refresh-токенов](concepts/authorization/refresh-token.md) в организации;
* просматривать информацию о refresh-токенах пользователей организации и отзывать такие refresh-токены;
* просматривать и завершать [сессии](../organization/concepts/sessions.md) федеративных и локальных пользователей;
* просматривать информацию о квотах сервиса {{ org-full-name }};
* просматривать информацию о действующем [тарифном плане](../support/pricing.md#effective-plans) технической поддержки;
* просматривать список [обращений](../support/overview.md) в техническую поддержку и информацию о них, а также создавать такие обращения, оставлять в них комментарии и вложения и закрывать их;
* просматривать, создавать, изменять и удалять репозитории {{ src-name }};
* читать файлы из репозитория {{ src-name }};
* просматривать, создавать, изменять и удалять предложения изменений в репозиториях {{ src-name }};
* выполнять слияние правок из предложения изменений в репозиториях {{ src-name }};
* вносить изменения в обычные и защищенные ветки репозитория {{ src-name }};
* просматривать, создавать и изменять публичные и приватные задачи (issues) в репозиториях {{ src-name }};
* изменять тип доступа к задачам в репозиториях {{ src-name }};
* оставлять реакции к задачам в репозиториях {{ src-name }};
* просматривать, создавать, изменять, удалять и отмечать выполненными комментарии к предложениям изменений, публичным и приватным задачам в репозиториях {{ src-name }};
* просматривать, создавать, изменять и удалять метки в репозиториях {{ src-name }};
* управлять доступом к репозиторию {{ src-name }};
* просматривать, получать, создавать, изменять и удалять секреты в репозиториях {{ src-name }}.

{% endcut %}

Включает разрешения, предоставляемые ролями `organization-manager.editor`, `organization-manager.federations.admin`, `organization-manager.osLogins.admin`, `organization-manager.userpools.admin`, `organization-manager.samlApplications.admin`, `organization-manager.oauthApplications.admin`, `organization-manager.groups.memberAdmin`, `organization-manager.groups.externalCreator`, `organization-manager.groups.externalManager`, `organization-manager.idpInstances.billingAdmin` и `src.repositories.admin`.

Для настройки сопоставления групп пользователей роль должна быть назначена на те группы в {{ org-full-name }}, которые вы будете сопоставлять.

#### organization-manager.organizations.owner {#organization-manager-organizations-owner}

Роль `organization-manager.organizations.owner` позволяет совершать любые действия с любыми [ресурсами в организации](../organization/concepts/organization.md) и с [платежными аккаунтами](../billing/concepts/billing-account.md), в том числе создавать платежные аккаунты и привязывать их к [облакам](../resource-manager/concepts/resources-hierarchy.md#cloud). Роль также позволяет назначать дополнительных владельцев организации.

Прежде чем назначить эту роль, ознакомьтесь с информацией о защите [привилегированных аккаунтов](../security/standard/all.md#privileged-users).

#### organization-manager.federations.extGroupsViewer {#organization-manager-federations-extGroupsViewer}

Роль `organization-manager.federations.extGroupsViewer` позволяет просматривать список и информацию о [группах пользователей](../organization/concepts/groups.md) {{ org-full-name }}, привязанных к [федерациям удостоверений](../organization/concepts/add-federation.md) в процессе синхронизации с группами пользователей в каталоге Active Directory или другом внешнем источнике.

#### organization-manager.federations.extGroupsManager {#organization-manager-federations-extGroupsManager}

Роль `organization-manager.federations.extGroupsManager` позволяет просматривать список и информацию о [группах пользователей](../organization/concepts/groups.md) {{ org-full-name }}, привязанных к [федерациям удостоверений](../organization/concepts/add-federation.md) в процессе синхронизации с группами пользователей в каталоге Active Directory или другом внешнем источнике, а также привязывать такие группы к федерациям удостоверений.

Включает разрешения, предоставляемые ролью `organization-manager.federations.extGroupsViewer`.

#### organization-manager.federations.extGroupsCleaner {#organization-manager-federations-extGroupsCleaner}

Роль `organization-manager.federations.extGroupsCleaner` позволяет просматривать список и информацию о [группах пользователей](../organization/concepts/groups.md) {{ org-full-name }}, привязанных к [федерациям удостоверений](../organization/concepts/add-federation.md) в процессе синхронизации с группами пользователей в каталоге Active Directory или другом внешнем источнике, а также отвязывать такие группы от федераций удостоверений.

Включает разрешения, предоставляемые ролью `organization-manager.federations.extGroupsViewer`.

#### organization-manager.federations.auditor {#organization-manager-federations-auditor}

Роль `organization-manager.federations.auditor` позволяет просматривать информацию об организации и ее настройках, о федерациях удостоверений и пользователях организации.

Пользователи с этой ролью могут:
* просматривать информацию об [организации](../organization/concepts/organization.md) {{ org-full-name }} и ее настройках;
* просматривать информацию о [федерациях удостоверений](../organization/concepts/add-federation.md);
* просматривать информацию о [сертификатах](../organization/concepts/add-federation.md#build-trust);
* просматривать списки [сопоставлений](../organization/concepts/add-federation.md#group-mapping) групп пользователей и информацию о таких сопоставлениях;
* просматривать список [пользователей](../overview/roles-and-resources.md#users) организации и сведения в профилях пользователей (кроме номера телефона), дату последней аутентификации, а также дату последней верификации федеративных и локальных аккаунтов с помощью [двухфакторной аутентификации](../organization/concepts/mfa.md);
* просматривать список [групп](../organization/concepts/groups.md), в которые входят пользователи;
* просматривать [атрибуты](../organization/operations/setup-federation.md#claims-mapping) федеративных и локальных пользователей.

#### organization-manager.federations.viewer {#organization-manager-federations-viewer}

Роль `organization-manager.federations.viewer` позволяет просматривать информацию об организации и ее настройках, о федерациях удостоверений и пользователях организации.

Пользователи с этой ролью могут:
* просматривать информацию об [организации](../organization/concepts/organization.md) {{ org-full-name }} и ее настройках;
* просматривать информацию о [федерациях удостоверений](../organization/concepts/add-federation.md);
* просматривать информацию о [сертификатах](../organization/concepts/add-federation.md#build-trust);
* просматривать списки [сопоставлений](../organization/concepts/add-federation.md#group-mapping) групп пользователей и информацию о таких сопоставлениях;
* просматривать список [пользователей](../overview/roles-and-resources.md#users) организации, информацию о них (включая номер телефона), дату их последней аутентификации, а также дату последней верификации федеративных и локальных аккаунтов с помощью [двухфакторной аутентификации](../organization/concepts/mfa.md);
* просматривать список [групп](../organization/concepts/groups.md), в которые входят пользователи;
* просматривать список и информацию о группах пользователей {{ org-full-name }}, привязанных к федерациям удостоверений в процессе синхронизации с пользовательскими группами в каталоге Active Directory или другом внешнем источнике;
* просматривать [атрибуты](../organization/operations/setup-federation.md#claims-mapping) федеративных и локальных пользователей.

Включает разрешения, предоставляемые ролями `organization-manager.federations.auditor` и `organization-manager.federations.extGroupsViewer`.

#### organization-manager.federations.editor {#organization-manager-federations-editor}

Роль `organization-manager.federations.editor` позволяет управлять федерациями удостоверений, федеративными пользователями и сертификатами, а также просматривать информацию об организации, ее настройках и пользователях.

Пользователи с этой ролью могут:
* просматривать информацию об [организации](../organization/concepts/organization.md) {{ org-full-name }} и ее настройках;
* просматривать информацию о [федерациях удостоверений](../organization/concepts/add-federation.md), а также создавать, изменять и удалять такие федерации;
* просматривать информацию о [сертификатах](../organization/concepts/add-federation.md#build-trust), а также создавать, изменять и удалять их;
* добавлять и удалять [федеративных пользователей](concepts/users/accounts.md#saml-federation);
* отзывать [refresh-токены](concepts/authorization/refresh-token.md) федеративных пользователей;
* удалять [факторы MFA](../organization/concepts/mfa.md#mfa-factors) федеративных и [локальных](concepts/users/accounts.md#local) аккаунтов пользователей;
* сбрасывать дату верификации федеративных и локальных аккаунтов пользователей;
* настраивать [сопоставление](../organization/concepts/add-federation.md#group-mapping) групп [федеративных пользователей](concepts/users/accounts.md#saml-federation);
* просматривать списки сопоставлений групп федеративных пользователей и информацию о таких сопоставлениях, а также создавать, изменять и удалять такие списки сопоставлений;
* просматривать список [пользователей](../overview/roles-and-resources.md#users) организации, информацию о них (включая номер телефона), дату их последней аутентификации, а также дату последней верификации федеративных и локальных аккаунтов с помощью [двухфакторной аутентификации](../organization/concepts/mfa.md);
* просматривать список [групп](../organization/concepts/groups.md), в которые входят пользователи;
* просматривать список и информацию о группах пользователей {{ org-full-name }}, привязанных к федерациям удостоверений в процессе синхронизации с пользовательскими группами в каталоге Active Directory или другом внешнем источнике;
* просматривать [атрибуты](../organization/operations/setup-federation.md#claims-mapping) федеративных и локальных пользователей;
* просматривать и завершать [сессии](../organization/concepts/sessions.md) федеративных и локальных пользователей.

Включает разрешения, предоставляемые ролями `organization-manager.federations.viewer` и `organization-manager.federations.userAdmin`.

Для настройки сопоставления групп пользователей роль должна быть назначена на те группы в {{ org-full-name }}, которые вы будете сопоставлять.

#### organization-manager.federations.userAdmin {#organization-manager-federations-userAdmin}

Роль `organization-manager.federations.userAdmin` позволяет добавлять федеративных пользователей в организацию и удалять их, отзывать refresh-токены, управлять факторами MFA пользовательских аккаунтов, а также просматривать список пользователей организации и данные их профилей.

Пользователи с этой ролью могут:
* добавлять и удалять [федеративных пользователей](concepts/users/accounts.md#saml-federation);
* отзывать [refresh-токены](concepts/authorization/refresh-token.md) федеративных пользователей;
* удалять [факторы MFA](../organization/concepts/mfa.md#mfa-factors) федеративных и [локальных](concepts/users/accounts.md#local) аккаунтов пользователей;
* сбрасывать дату верификации федеративных и локальных аккаунтов пользователей;
* просматривать список [пользователей](../overview/roles-and-resources.md#users) организации, сведения в профилях пользователей (включая номер телефона), дату их последней аутентификации, а также дату последней верификации федеративных и локальных аккаунтов с помощью [двухфакторной аутентификации](../organization/concepts/mfa.md);
* просматривать список [групп](../organization/concepts/groups.md), в которые входят пользователи;
* просматривать [атрибуты](../organization/operations/setup-federation.md#claims-mapping) федеративных и локальных пользователей;
* просматривать и завершать [сессии](../organization/concepts/sessions.md) федеративных и локальных пользователей.

Включает разрешения, предоставляемые ролью `iam.userAccounts.refreshTokenRevoker`.

#### organization-manager.federations.admin {#organization-manager-federations-admin}

Роль `organization-manager.federations.admin` позволяет управлять федерациями удостоверений, федеративными пользователями и сертификатами, а также просматривать информацию об организации, ее настройках и пользователях.

Пользователи с этой ролью могут:
* просматривать информацию об [организации](../organization/concepts/organization.md) {{ org-full-name }} и ее настройках;
* просматривать информацию о [федерациях удостоверений](../organization/concepts/add-federation.md), а также создавать, изменять и удалять такие федерации;
* просматривать информацию о [сертификатах](../organization/concepts/add-federation.md#build-trust), а также создавать, изменять и удалять их;
* добавлять и удалять [федеративных пользователей](concepts/users/accounts.md#saml-federation);
* отзывать [refresh-токены](concepts/authorization/refresh-token.md) федеративных пользователей;
* удалять [факторы MFA](../organization/concepts/mfa.md#mfa-factors) федеративных и [локальных](concepts/users/accounts.md#local) аккаунтов пользователей;
* сбрасывать дату верификации федеративных и локальных аккаунтов пользователей;
* настраивать [сопоставление](../organization/concepts/add-federation.md#group-mapping) групп [федеративных пользователей](concepts/users/accounts.md#saml-federation);
* просматривать списки сопоставлений групп федеративных пользователей и информацию о таких сопоставлениях, а также создавать, изменять и удалять такие списки сопоставлений;
* просматривать список [пользователей](../overview/roles-and-resources.md#users) организации, информацию о них (включая номер телефона), дату их последней аутентификации, а также дату последней верификации федеративных и локальных аккаунтов с помощью [двухфакторной аутентификации](../organization/concepts/mfa.md);
* просматривать список [групп](../organization/concepts/groups.md), в которые входят пользователи;
* просматривать список и информацию о группах пользователей {{ org-full-name }}, привязанных к федерациям удостоверений в процессе синхронизации с пользовательскими группами в каталоге Active Directory или другом внешнем источнике;
* привязывать группы пользователей к федерациям удостоверений в процессе синхронизации с пользовательскими группами в каталоге Active Directory или другом внешнем источнике, а также отвязывать их;
* просматривать [атрибуты](../organization/operations/setup-federation.md#claims-mapping) федеративных и локальных пользователей;
* просматривать и завершать [сессии](../organization/concepts/sessions.md) федеративных и локальных пользователей.

Включает разрешения, предоставляемые ролями `organization-manager.federations.editor`, `organization-manager.federations.extGroupsManager` и `organization-manager.federations.extGroupsCleaner`.

Для настройки сопоставления групп пользователей роль должна быть назначена на те группы в {{ org-full-name }}, которые вы будете сопоставлять.

#### organization-manager.osLogins.viewer {#organization-manager-osLogins-viewer}

Роль `organization-manager.osLogins.viewer` позволяет просматривать информацию о настройках {{ oslogin }} [организации](../organization/concepts/organization.md) и список [профилей {{ oslogin }}](../organization/concepts/os-login.md#os-login-profiles) пользователей и [сервисных аккаунтов](concepts/users/service-accounts.md), а также просматривать список SSH-ключей [пользователей](../overview/roles-and-resources.md#users) и информацию об SSH-ключах.

#### organization-manager.osLogins.admin {#organization-manager-osLogins-admin}

Роль `organization-manager.osLogins.admin` позволяет управлять настройками {{ oslogin }} организации, а также профилями {{ oslogin }} и SSH-ключами пользователей.

Пользователи с этой ролью могут:
* просматривать информацию о настройках [{{ oslogin }}](../organization/concepts/os-login.md) организации и изменять такие настройки;
* просматривать список [профилей](../organization/concepts/os-login.md#os-login-profiles) {{ oslogin }} пользователей [организации](../organization/concepts/organization.md) и [сервисных аккаунтов](concepts/users/service-accounts.md), а также создавать, изменять и удалять профили {{ oslogin }};
* просматривать список SSH-ключей пользователей организации и информацию об SSH-ключах, а также создавать, изменять и удалять SSH-ключи пользователей.

Включает разрешения, предоставляемые ролью `organization-manager.osLogins.viewer`.

#### organization-manager.groups.externalCreator {#organization-manager-groups-externalCreator}

Роль `organization-manager.groups.externalCreator` позволяет создавать [группы пользователей](../organization/concepts/groups.md) {{ org-full-name }} при выполнении синхронизации с группами пользователей в каталоге Active Directory или другом внешнем источнике.

#### organization-manager.groups.externalConverter {#organization-manager-groups-externalConverter}

Роль `organization-manager.groups.externalConverter` позволяет добавлять в [группы пользователей](../organization/concepts/groups.md) {{ org-full-name }} атрибут с идентификатором внешней группы при выполнении синхронизации с группами пользователей в каталоге Active Directory или другом внешнем источнике.

#### organization-manager.groups.externalManager {#organization-manager-groups-externalManager}

Роль `organization-manager.groups.externalManager` позволяет управлять группами пользователей {{ org-full-name }}, связанными с группами пользователей в каталоге Active Directory или другом внешнем источнике.

Пользователи с этой ролью могут:
* связывать [группы пользователей](../organization/concepts/groups.md) {{ org-full-name }} с пользовательскими группами в каталоге Active Directory или другом внешнем источнике;
* изменять и удалять группы пользователей {{ org-full-name }}, связанные с пользовательскими группами в каталоге Active Directory или другом внешнем источнике;
* просматривать состав участников групп пользователей {{ org-full-name }}, связанных с пользовательскими группами в каталоге Active Directory или другом внешнем источнике, а также управлять составом участников таких групп;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к группам пользователей в {{ org-full-name }}.

#### organization-manager.groups.viewer {#organization-manager-groups-viewer}

Роль `organization-manager.groups.viewer` позволяет просматривать информацию о [группах пользователей](../organization/concepts/groups.md) и о назначенных [правах доступа](concepts/access-control/index.md) к ним, а также просматривать список [пользователей](../overview/roles-and-resources.md#users) и [сервисных аккаунтов](concepts/users/service-accounts.md), входящих в группу.

#### organization-manager.groups.editor {#organization-manager-groups-editor}

Роль `organization-manager.groups.editor` позволяет управлять группами пользователей.

Роль назначается на организацию или группу пользователей.

Пользователи с этой ролью могут:
* просматривать информацию о [группах пользователей](../organization/concepts/groups.md), а также создавать, изменять и удалять такие группы;
* просматривать список [пользователей](../overview/roles-and-resources.md#users) и [сервисных аккаунтов](concepts/users/service-accounts.md), входящих в группы пользователей;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к группам пользователей.

Включает разрешения, предоставляемые ролью `organization-manager.groups.viewer`.

#### organization-manager.groups.memberAdmin {#organization-manager-groups-memberAdmin}

Роль `organization-manager.groups.memberAdmin` позволяет просматривать информацию о [группах пользователей](../organization/concepts/groups.md), а также просматривать и изменять списки [пользователей](../overview/roles-and-resources.md#users) и [сервисных аккаунтов](concepts/users/service-accounts.md), входящих в группы.

#### organization-manager.groups.admin {#organization-manager-groups-admin}

Роль `organization-manager.groups.admin` позволяет управлять группами пользователей и их участниками, а также доступом к ним.

Роль назначается на организацию или группу пользователей.

Пользователи с этой ролью могут:
* просматривать информацию о [группах пользователей](../organization/concepts/groups.md), а также создавать, изменять и удалять такие группы;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к группам пользователей и изменять такие права доступа;
* просматривать список [пользователей](../overview/roles-and-resources.md#users) и [сервисных аккаунтов](concepts/users/service-accounts.md), входящих в группы пользователей;
* добавлять пользователей и сервисные аккаунты в группы пользователей и удалять их из таких групп.

Включает разрешения, предоставляемые ролями `organization-manager.groups.editor` и `organization-manager.groups.memberAdmin`.

#### organization-manager.users.viewer {#organization-manager-users-viewer}

Роль `organization-manager.users.viewer` позволяет просматривать список [пользователей](../overview/roles-and-resources.md#users) организации, информацию о них (включая номер телефона), дату их последней аутентификации, [атрибуты](../organization/operations/setup-federation.md#claims-mapping) и дату последней верификации [федеративных](concepts/users/accounts.md#saml-federation) и [локальных](concepts/users/accounts.md#local) аккаунтов с помощью [двухфакторной аутентификации](../organization/concepts/mfa.md), а также списки [групп](../organization/concepts/groups.md), в которые входят пользователи.

#### organization-manager.passportUserAdmin {#organization-manager-passportUserAdmin}

Роль `organization-manager.passportUserAdmin` позволяет просматривать информацию о пользователях организации, а также приглашать в организацию и исключать из нее пользователей с аккаунтами на Яндексе.

Пользователи с этой ролью могут:
* [приглашать](../organization/operations/add-account.md#send-invitation), в том числе [повторно](../organization/operations/add-account.md#resend-invitation), в организацию новых [пользователей](../organization/concepts/membership.md) с аккаунтами на Яндексе, а также просматривать и [удалять](../organization/operations/add-account.md#delete-invitation) отправленные приглашения;
* [удалять](../organization/operations/edit-account.md) аккаунты пользователей из [организации](../organization/concepts/organization.md);
* просматривать список пользователей организации и сведения в профилях пользователей (кроме номера телефона), дату последней аутентификации, а также дату последней верификации федеративных и локальных аккаунтов с помощью [двухфакторной аутентификации](../organization/concepts/mfa.md);
* просматривать [атрибуты](../organization/operations/setup-federation.md#claims-mapping) [федеративных](concepts/users/accounts.md#saml-federation) и [локальных](concepts/users/accounts.md#local) пользователей организации.

#### organization-manager.oauthApplications.auditor {#organization-manager-oauthApplications-auditor}

Роль `organization-manager.oauthApplications.auditor` позволяет просматривать информацию об OIDC-приложениях и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также просматривать список [пользователей](../overview/roles-and-resources.md#users), добавленных в OIDC-приложения.

#### organization-manager.oauthApplications.viewer {#organization-manager-oauthApplications-viewer}

Роль `organization-manager.oauthApplications.viewer` позволяет просматривать информацию об OIDC-приложениях и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также просматривать список [пользователей](../overview/roles-and-resources.md#users), добавленных в OIDC-приложения.

Включает разрешения, предоставляемые ролью `organization-manager.oauthApplications.auditor`.

#### organization-manager.oauthApplications.editor {#organization-manager-oauthApplications-editor}

Роль `organization-manager.oauthApplications.editor` позволяет управлять OIDC-приложениями и просматривать добавленных в них пользователей.

Пользователи с этой ролью могут:
* просматривать информацию об OIDC-приложениях и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* создавать, деактивировать, активировать, изменять и удалять OIDC-приложения;
* просматривать список [пользователей](../overview/roles-and-resources.md#users), добавленных в OIDC-приложения.

Включает разрешения, предоставляемые ролью `organization-manager.oauthApplications.viewer`.

#### organization-manager.oauthApplications.userAdmin {#organization-manager-oauthApplications-userAdmin}

Роль `organization-manager.oauthApplications.userAdmin` позволяет просматривать и изменять список [пользователей](../overview/roles-and-resources.md#users), добавленных в OIDC-приложение.

#### organization-manager.oauthApplications.admin {#organization-manager-oauthApplications-admin}

Роль `organization-manager.oauthApplications.admin` позволяет управлять OIDC-приложениями и доступом к ним, а также пользователями, добавленными в OIDC-приложения.

Пользователи с этой ролью могут:
* просматривать информацию об OIDC-приложениях, а также создавать, деактивировать, активировать, изменять и удалять их;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к OIDC-приложениям и изменять такие права доступа;
* просматривать и изменять список [пользователей](../overview/roles-and-resources.md#users), добавленных в OIDC-приложения.

Включает разрешения, предоставляемые ролями `organization-manager.oauthApplications.editor` и `organization-manager.oauthApplications.userAdmin`.

#### organization-manager.samlApplications.auditor {#organization-manager-samlApplications-auditor}

Роль `organization-manager.samlApplications.auditor` позволяет просматривать информацию о SAML-приложениях и назначенных [правах доступа](concepts/access-control/index.md) к ним, просматривать список [пользователей](../overview/roles-and-resources.md#users), добавленных в SAML-приложения, а также получать сертификаты SAML-приложений.

#### organization-manager.samlApplications.viewer {#organization-manager-samlApplications-viewer}

Роль `organization-manager.samlApplications.viewer` позволяет просматривать информацию о SAML-приложениях и назначенных [правах доступа](concepts/access-control/index.md) к ним, просматривать список [пользователей](../overview/roles-and-resources.md#users), добавленных в SAML-приложения, а также получать сертификаты SAML-приложений.

Включает разрешения, предоставляемые ролью `organization-manager.samlApplications.auditor`.

#### organization-manager.samlApplications.editor {#organization-manager-samlApplications-editor}

Роль `organization-manager.samlApplications.editor` позволяет управлять SAML-приложениями и просматривать добавленных в них пользователей.

Пользователи с этой ролью могут:
* просматривать информацию о SAML-приложениях и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* создавать, деактивировать, активировать, изменять и удалять SAML-приложения;
* получать сертификаты SAML-приложений, а также создавать, изменять и удалять такие сертификаты;
* просматривать список [пользователей](../overview/roles-and-resources.md#users), добавленных в SAML-приложения;
* просматривать список пользователей, добавленных в OIDC-приложения.

Включает разрешения, предоставляемые ролью `organization-manager.samlApplications.viewer`.

#### organization-manager.samlApplications.userAdmin {#organization-manager-samlApplications-userAdmin}

Роль `organization-manager.samlApplications.userAdmin` позволяет просматривать и изменять список [пользователей](../overview/roles-and-resources.md#users), добавленных в SAML-приложение.

#### organization-manager.samlApplications.admin {#organization-manager-samlApplications-admin}

Роль `organization-manager.samlApplications.admin` позволяет управлять SAML-приложениями и доступом к ним, а также пользователями, добавленными в SAML-приложения.

Пользователи с этой ролью могут:
* просматривать информацию о SAML-приложениях, а также создавать, деактивировать, активировать, изменять и удалять их;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к SAML-приложениям и изменять такие права доступа;
* получать сертификаты SAML-приложений, а также создавать, изменять и удалять такие сертификаты;
* просматривать и изменять список [пользователей](../overview/roles-and-resources.md#users), добавленных в SAML-приложения;
* просматривать список пользователей, добавленных в OIDC-приложения.

Включает разрешения, предоставляемые ролями `organization-manager.samlApplications.editor` и `organization-manager.samlApplications.userAdmin`.

#### organization-manager.userpools.extGroupsViewer {#organization-manager-userpools-extGroupsViewer}

Роль `organization-manager.userpools.extGroupsViewer` позволяет просматривать список и информацию о [группах пользователей](../organization/concepts/groups.md) {{ org-full-name }}, привязанных к [пулам пользователей](../organization/concepts/user-pools.md) в процессе синхронизации с группами пользователей в каталоге Active Directory или другом внешнем источнике.

#### organization-manager.userpools.extGroupsManager {#organization-manager-userpools-extGroupsManager}

Роль `organization-manager.userpools.extGroupsManager` позволяет просматривать список и информацию о [группах пользователей](../organization/concepts/groups.md) {{ org-full-name }}, привязанных к [пулам пользователей](../organization/concepts/user-pools.md) в процессе синхронизации с группами пользователей в каталоге Active Directory или другом внешнем источнике, а также привязывать такие группы к пулам пользователей.

Включает разрешения, предоставляемые ролью `organization-manager.userpools.extGroupsViewer`.

#### organization-manager.userpools.extGroupsCleaner {#organization-manager-userpools-extGroupsCleaner}

Роль `organization-manager.userpools.extGroupsCleaner` позволяет просматривать список и информацию о [группах пользователей](../organization/concepts/groups.md) {{ org-full-name }}, привязанных к [пулам пользователей](../organization/concepts/user-pools.md) в процессе синхронизации с группами пользователей в каталоге Active Directory или другом внешнем источнике, а также отвязывать такие группы от пулов пользователей.

Включает разрешения, предоставляемые ролью `organization-manager.userpools.extGroupsViewer`.

#### organization-manager.userpools.syncAgent {#organization-manager-userpools-syncAgent}

Роль `organization-manager.userpools.syncAgent` позволяет выполнять синхронизацию пользователей и групп {{ org-full-name }} с пользователями и группами в каталоге Active Directory или другом внешнем источнике.

Пользователи с этой ролью могут:
* просматривать информацию о сессиях синхронизации агента {{ ad-sync-agent }} с сервисом {{ org-full-name }}, а также создавать и изменять такие сессии;
* просматривать информацию о [пулах пользователей](../organization/concepts/user-pools.md) и о настройках синхронизации в пулах пользователей;
* просматривать список и информацию о [группах пользователей](../organization/concepts/groups.md) {{ org-full-name }}, привязанных к пулам пользователей в процессе синхронизации с пользовательскими группами в каталоге Active Directory или другом внешнем источнике;
* привязывать группы пользователей к пулам пользователей в процессе синхронизации с пользовательскими группами в каталоге Active Directory или другом внешнем источнике;
* просматривать информацию о пользователях {{ org-full-name }}, создавать, изменять, активировать, деактивировать, удалять пользователей, а также изменять пароли и другие данные пользователей {{ org-full-name }}.

Включает разрешения, предоставляемые ролью `organization-manager.userpools.extGroupsManager`.

#### organization-manager.userpools.auditor {#organization-manager-userpools-auditor}

Роль `organization-manager.userpools.auditor` позволяет просматривать информацию о пулах пользователей и пользователях организации.

Пользователи с этой ролью могут:
* просматривать информацию о [пулах пользователей](../organization/concepts/user-pools.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о [доменах](../organization/concepts/domains.md), привязанных к пулам пользователей;
* просматривать список [пользователей](../overview/roles-and-resources.md#users) организации и сведения в профилях пользователей (кроме номера телефона), дату последней аутентификации, а также дату последней верификации федеративных и локальных аккаунтов с помощью [двухфакторной аутентификации](../organization/concepts/mfa.md);
* просматривать список [групп](../organization/concepts/groups.md), в которые входят пользователи;
* просматривать атрибуты федеративных и локальных пользователей.

#### organization-manager.userpools.viewer {#organization-manager-userpools-viewer}

Роль `organization-manager.userpools.viewer` позволяет просматривать информацию о пулах пользователей, а также список пользователей организации и информацию о них.

Пользователи с этой ролью могут:
* просматривать информацию о [пулах пользователей](../organization/concepts/user-pools.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о [доменах](../organization/concepts/domains.md), привязанных к пулам пользователей;
* просматривать список [пользователей](../overview/roles-and-resources.md#users) организации, информацию о них (включая номер телефона), дату последней аутентификации, а также дату последней верификации федеративных и локальных аккаунтов с помощью [двухфакторной аутентификации](../organization/concepts/mfa.md);
* просматривать события аудита пользователя;
* просматривать список [групп](../organization/concepts/groups.md), в которые входят пользователи;
* просматривать список и информацию о группах пользователей {{ org-full-name }}, привязанных к пулам пользователей в процессе синхронизации с пользовательскими группами в каталоге Active Directory или другом внешнем источнике;
* просматривать атрибуты федеративных и локальных пользователей.

Включает разрешения, предоставляемые ролями `organization-manager.userpools.auditor` и `organization-manager.userpools.extGroupsViewer`.

#### organization-manager.userpools.editor {#organization-manager-userpools-editor}

Роль `organization-manager.userpools.editor` позволяет управлять пулами пользователей и входящими в них пользователями.

Пользователи с этой ролью могут:
* просматривать информацию о [пулах пользователей](../organization/concepts/user-pools.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* создавать, изменять и удалять пулы пользователей;
* просматривать информацию о [доменах](../organization/concepts/domains.md), привязанных к пулам пользователей, а также добавлять, подтверждать и удалять домены;
* просматривать список [пользователей](../overview/roles-and-resources.md#users) организации, информацию о них (включая номер телефона), дату последней аутентификации, а также дату последней верификации федеративных и локальных аккаунтов с помощью [двухфакторной аутентификации](../organization/concepts/mfa.md);
* создавать, удалять, активировать и деактивировать локальных пользователей, входящих в пулы пользователей;
* изменять данные пользователей: имя пользователя, пароль, домен, адрес электронной почты, а также ФИО и телефон;
* удалять [факторы MFA](../organization/concepts/mfa.md#mfa-factors) [федеративных](concepts/users/accounts.md#saml-federation) и [локальных](concepts/users/accounts.md#local) аккаунтов пользователей;
* сбрасывать дату верификации федеративных и локальных аккаунтов пользователей;
* отзывать [refresh-токены](concepts/authorization/refresh-token.md) пользователей;
* просматривать события аудита пользователя;
* просматривать список [групп](../organization/concepts/groups.md), в которые входят пользователи;
* просматривать список и информацию о группах пользователей {{ org-full-name }}, привязанных к пулам пользователей в процессе синхронизации с пользовательскими группами в каталоге Active Directory или другом внешнем источнике;
* просматривать атрибуты федеративных и локальных пользователей;
* просматривать и завершать [сессии](../organization/concepts/sessions.md) федеративных и локальных пользователей.

Включает разрешения, предоставляемые ролями `organization-manager.userpools.userAdmin` и `organization-manager.userpools.viewer`.

#### organization-manager.userpools.userAdmin {#organization-manager-userpools-userAdmin}

Роль `organization-manager.userpools.userAdmin` позволяет управлять локальными пользователями организации, входящими в пулы пользователей.

Пользователи с этой ролью могут:
* просматривать список [пользователей](../overview/roles-and-resources.md#users) организации, информацию о них (включая номер телефона), дату последней аутентификации, а также дату последней верификации федеративных и локальных аккаунтов с помощью [двухфакторной аутентификации](../organization/concepts/mfa.md);
* создавать, удалять, активировать и деактивировать локальных пользователей, входящих в [пулы пользователей](../organization/concepts/user-pools.md);
* изменять данные пользователей: имя пользователя, пароль, домен, адрес электронной почты, а также ФИО и телефон;
* удалять [факторы MFA](../organization/concepts/mfa.md#mfa-factors) [федеративных](concepts/users/accounts.md#saml-federation) и [локальных](concepts/users/accounts.md#local) аккаунтов пользователей;
* сбрасывать дату верификации федеративных и локальных аккаунтов пользователей;
* отзывать [refresh-токены](concepts/authorization/refresh-token.md) пользователей;
* просматривать список [групп](../organization/concepts/groups.md), в которые входят пользователи;
* просматривать атрибуты федеративных и локальных пользователей;
* просматривать и завершать [сессии](../organization/concepts/sessions.md) федеративных и локальных пользователей.

Включает разрешения, предоставляемые ролью `iam.userAccounts.refreshTokenRevoker`.

#### organization-manager.userpools.admin {#organization-manager-userpools-admin}

Роль `organization-manager.userpools.admin` позволяет управлять пулами пользователей и доступом к ним, а также управлять входящими в них пользователями.

Пользователи с этой ролью могут:
* просматривать информацию о [пулах пользователей](../organization/concepts/user-pools.md), а также создавать, изменять и удалять пулы пользователей;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к пулам пользователей и изменять такие права доступа;
* просматривать информацию о [доменах](../organization/concepts/domains.md), привязанных к пулам пользователей, а также добавлять, подтверждать и удалять домены;
* просматривать список [пользователей](../overview/roles-and-resources.md#users) организации, информацию о них (включая номер телефона), дату последней аутентификации, а также дату последней верификации федеративных и локальных аккаунтов с помощью [двухфакторной аутентификации](../organization/concepts/mfa.md);
* создавать, удалять, активировать и деактивировать локальных пользователей, входящих в пулы пользователей;
* изменять данные пользователей: имя пользователя, пароль, домен, адрес электронной почты, а также ФИО и телефон;
* удалять [факторы MFA](../organization/concepts/mfa.md#mfa-factors) [федеративных](concepts/users/accounts.md#saml-federation) и [локальных](concepts/users/accounts.md#local) аккаунтов пользователей;
* сбрасывать дату верификации федеративных и локальных аккаунтов пользователей;
* отзывать [refresh-токены](concepts/authorization/refresh-token.md) пользователей;
* просматривать события аудита пользователя;
* просматривать список [групп](../organization/concepts/groups.md), в которые входят пользователи;
* просматривать список и информацию о группах пользователей {{ org-full-name }}, привязанных к пулам пользователей в процессе синхронизации с пользовательскими группами в каталоге Active Directory или другом внешнем источнике;
* привязывать группы пользователей к пулам пользователей в процессе синхронизации с пользовательскими группами в каталоге Active Directory или другом внешнем источнике, а также отвязывать их;
* просматривать атрибуты федеративных и локальных пользователей;
* просматривать и завершать [сессии](../organization/concepts/sessions.md) федеративных и локальных пользователей.

Включает разрешения, предоставляемые ролями `organization-manager.userpools.editor`, `organization-manager.userpools.extGroupsManager` и `organization-manager.userpools.extGroupsCleaner`.

#### organization-manager.idpInstances.billingViewer {#organization-manager-idpInstances-billingViewer}

Роль `organization-manager.idpInstances.billingViewer` позволяет просматривать список пользователей, которые в текущем [отчетном периоде](../billing/concepts/reporting-period.md) используют квоту для аутентификации в {{ org-full-name }}, а также информацию о подписке на платные возможности сервиса {{ org-full-name }} и статистике использования квот по этой подписке.

#### organization-manager.idpInstances.billingAdmin {#organization-manager-idpInstances-billingAdmin}

Роль `organization-manager.idpInstances.billingAdmin` позволяет управлять подпиской на платные возможности сервиса {{ org-full-name }}.

Пользователи с этой ролью могут:
* привязывать сервис {{ org-full-name }} к [платежному аккаунту](../billing/concepts/billing-account.md);
* просматривать информацию о подписке на платные возможности сервиса {{ org-full-name }};
* просматривать информацию о статистике использования квот по подписке на платные возможности сервиса {{ org-full-name }}, а также изменять эти квоты;
* просматривать список пользователей, которые в текущем [отчетном периоде](../billing/concepts/reporting-period.md) используют квоту для аутентификации в {{ org-full-name }}.

Включает разрешения, предоставляемые ролью `organization-manager.idpInstances.billingViewer`.

Подробнее см. [{#T}](../organization/security/index.md).


## {{ iot-full-name }} {#iot-core-roles}

#### iot.devices.writer {#iot-devices-writer}

Роль `iot.devices.writer` позволяет отправлять [gRPC-сообщения](../iot-core/concepts/mqtt-grpc.md) в Yandex IoT Core от имени [устройства](../iot-core/concepts/index.md#device).

#### iot.registries.writer {#iot-registries-writer}

Роль `iot.registries.writer` позволяет отправлять [gRPC-сообщения](../iot-core/concepts/mqtt-grpc.md) в Yandex IoT Core от имени [реестра](../iot-core/concepts/index.md#registry).

#### iot.auditor {#iot-auditor}

Роль `iot.auditor` позволяет просматривать метаинформацию об [устройствах](../iot-core/concepts/index.md#device) и [реестрах](../iot-core/concepts/index.md#registry) устройств, а также о [брокерах](../iot-core/concepts/index.md#broker) и [квотах](../iot-core/concepts/limits.md#iot-quotas) в Yandex IoT Core.

#### iot.viewer {#iot-viewer}

Роль `iot.viewer` позволяет просматривать все ресурсы Yandex IoT Core.

#### iot.editor {#iot-editor}

Роль `iot.editor` позволяет создавать, редактировать и удалять все ресурсы Yandex IoT Core.

Подробнее см. [{#T}](../iot-core/security/index.md).


## {{ kms-full-name }} {#kms-roles}

#### kms.keys.user {#kms-keys-user}

Роль `kms.keys.user` позволяет просматривать список [симметричных ключей шифрования](../kms/concepts/key.md) и информацию о них, а также использовать такие ключи.

#### kms.keys.encrypter {#kms-keys-encrypter}

Роль `kms.keys.encrypter` позволяет просматривать информацию о [симметричных ключах шифрования](../kms/concepts/key.md) и шифровать данные с помощью таких ключей.

#### kms.keys.decrypter {#kms-keys-decrypter}

Роль `kms.keys.decrypter` позволяет просматривать информацию о [симметричных ключах шифрования](../kms/concepts/key.md) и расшифровывать данные с помощью таких ключей.

#### kms.keys.encrypterDecrypter {#kms-keys-encrypterDecrypter}

Роль `kms.keys.encrypterDecrypter` позволяет просматривать информацию о [симметричных ключах шифрования](../kms/concepts/key.md), а также шифровать и расшифровывать данные с помощью таких ключей.

Включает разрешения, предоставляемые ролями `kms.keys.encrypter` и `kms.keys.decrypter`.

#### kms.asymmetricEncryptionKeys.publicKeyViewer {#kms-asymmetricEncryptionKeys-publicKeyViewer}

Роль `kms.asymmetricEncryptionKeys.publicKeyViewer` позволяет просматривать информацию об [асимметричных ключевых парах шифрования](../kms/concepts/asymmetric-encryption-key.md), а также получать [открытый ключ](../kms/concepts/asymmetric-encryption.md#acquire-public-key) ключевой пары шифрования.

#### kms.asymmetricSignatureKeys.publicKeyViewer {#kms-asymmetricSignatureKeys-publicKeyViewer}

Роль `kms.asymmetricSignatureKeys.publicKeyViewer` позволяет просматривать информацию о [ключевых парах электронной подписи](../kms/concepts/asymmetric-signature-key.md), а также получать открытый ключ ключевой пары электронной подписи.

#### kms.asymmetricSignatureKeys.signer {#kms-asymmetricSignatureKeys-signer}

Роль `kms.asymmetricSignatureKeys.signer` позволяет подписывать данные с помощью закрытого ключа [ключевой пары электронной подписи](../kms/concepts/asymmetric-signature-key.md).

#### kms.asymmetricEncryptionKeys.decrypter {#kms-asymmetricEncryptionKeys-decrypter}

Роль `kms.asymmetricEncryptionKeys.decrypter` позволяет расшифровывать данные с помощью закрытого ключа [асимметричной ключевой пары шифрования](../kms/concepts/asymmetric-encryption-key.md).

#### kms.auditor {#kms-auditor}

Роль `kms.auditor` позволяет просматривать информацию о ключах и ключевых парах шифрования и электронной подписи, а также о назначенных правах доступа к ним.

Пользователи с этой ролью могут:
* просматривать список [симметричных ключей](../kms/concepts/key.md) шифрования, информацию о них и о назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию об [асимметричных ключевых парах шифрования](../kms/concepts/asymmetric-encryption-key.md) и о назначенных правах доступа к ним;
* просматривать информацию о [ключевых парах электронной подписи](../kms/concepts/asymmetric-signature-key.md) и о назначенных правах доступа к ним;
* просматривать информацию о [квотах](../kms/concepts/limits.md#kms-quotas) сервиса {{ kms-name }}.

#### kms.viewer {#kms-viewer}

Роль `kms.viewer` позволяет просматривать информацию о ключах и ключевых парах шифрования и электронной подписи, о назначенных правах доступа к ним, а также о квотах сервиса.

Пользователи с этой ролью могут:
* просматривать список [симметричных ключей](../kms/concepts/key.md) шифрования, информацию о них и о назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию об [асимметричных ключевых парах шифрования](../kms/concepts/asymmetric-encryption-key.md) и о назначенных правах доступа к ним;
* просматривать информацию о [ключевых парах электронной подписи](../kms/concepts/asymmetric-signature-key.md) и о назначенных правах доступа к ним;
* просматривать информацию о [квотах](../kms/concepts/limits.md#kms-quotas) сервиса {{ kms-name }}.

Включает разрешения, предоставляемые ролью `kms.auditor`.

#### kms.editor {#kms-editor}

Роль `kms.editor` позволяет создавать ключи и ключевые пары шифрования и электронной подписи, а также использовать их для шифрования, расшифрования и подписи данных.

Пользователи с этой ролью могут:
* просматривать список [симметричных ключей](../kms/concepts/key.md) шифрования, информацию о них и о назначенных [правах доступа](concepts/access-control/index.md) к ним, а также создавать, ротировать и изменять метаданные симметричных ключей (в т.ч. период их ротации);
* шифровать и расшифровывать данные с помощью симметричных ключей шифрования;
* просматривать информацию об [асимметричных ключевых парах шифрования](../kms/concepts/asymmetric-encryption-key.md) и о назначенных правах доступа к ним, а также создавать ассиметричные ключевые пары шифрования и изменять их метаданные;
* получать [открытый ключ](../kms/concepts/asymmetric-encryption.md#acquire-public-key) и расшифровывать данные с помощью закрытого ключа асимметричной ключевой пары шифрования;
* просматривать информацию о [ключевых парах электронной подписи](../kms/concepts/asymmetric-signature-key.md) и назначенных правах доступа к ним, а также создавать ключевые пары электронной подписи и изменять их метаданные;
* получать открытый ключ и подписывать данные с помощью закрытого ключа ключевой пары электронной подписи;
* просматривать информацию о [квотах](../kms/concepts/limits.md#kms-quotas) сервиса {{ kms-name }}.

#### kms.admin {#kms-admin}

Роль `kms.admin` позволяет управлять ключами и ключевыми парами шифрования и электронной подписи и доступом к ним, а также использовать их для шифрования, расшифрования и подписи данных.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к [симметричным ключам](../kms/concepts/key.md) шифрования, а также изменять такие права доступа;
* просматривать список симметричных ключей шифрования и информацию о них, а также создавать, активировать, деактивировать, ротировать, удалять симметричные ключи шифрования, изменять их основную версию и метаданные (в т.ч. период ротации);
* шифровать и расшифровывать данные с помощью симметричных ключей шифрования;
* просматривать информацию о назначенных правах доступа к [асимметричным ключевым парам шифрования](../kms/concepts/asymmetric-encryption-key.md), а также изменять такие права доступа;
* просматривать информацию об асимметричных ключевых парах шифрования, а также создавать, активировать, деактивировать, удалять ассиметричные ключевые пары шифрования и изменять их метаданные;
* получать [открытый ключ](../kms/concepts/asymmetric-encryption.md#acquire-public-key) и расшифровывать данные с помощью закрытого ключа асимметричной ключевой пары шифрования;
* просматривать информацию о назначенных правах доступа к [ключевым парам электронной подписи](../kms/concepts/asymmetric-signature-key.md), а также изменять такие права доступа;
* просматривать информацию о ключевых парах электронной подписи, а также создавать, активировать, деактивировать, удалять ключевые пары электронной подписи и изменять их метаданные;
* получать открытый ключ и подписывать данные с помощью закрытого ключа ключевой пары электронной подписи;
* просматривать информацию о [квотах](../kms/concepts/limits.md#kms-quotas) сервиса {{ kms-name }};
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `kms.editor`.

Подробнее см. [{#T}](../kms/security/index.md).


## {{ load-testing-full-name }} {#load-testing-roles}

#### loadtesting.viewer {#loadtesting-viewer}

Роль `loadtesting.viewer` позволяет просматривать информацию о генераторах нагрузки и нагрузочных тестах, а также метаданные каталога.

Пользователи с этой ролью могут:
* просматривать информацию о нагрузочных тестах и [отчеты](../load-testing/concepts/reports.md) о результатах их выполнения;
* просматривать информацию о конфигурации нагрузочных тестов;
* просматривать информацию о [дашбордах регрессий](../load-testing/concepts/load-test-regressions.md#dashbordy-regressij) нагрузочных тестов;
* просматривать информацию об [агентах](../load-testing/concepts/agent.md);
* просматривать информацию о [бакетах](../storage/concepts/bucket.md) Yandex Object Storage, использующихся в нагрузочных тестах;
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

#### loadtesting.editor {#loadtesting-editor}

Роль `loadtesting.editor` позволяет управлять агентами, нагрузочными тестами и их конфигурациями, хранилищами данных и дашбордами регрессий, а также регистрировать в сервисе агентов, созданных вне Load Testing.

Пользователи с этой ролью могут:
* просматривать информацию о нагрузочных тестах и [отчеты](../load-testing/concepts/reports.md) о результатах их выполнения;
* создавать, изменять, удалять, запускать и останавливать нагрузочные тесты, а также загружать в них [тестовые данные](../load-testing/concepts/payload.md);
* просматривать информацию о конфигурациях нагрузочных тестов, а также создавать, изменять и удалять такие конфигурации;
* просматривать информацию об [агентах](../load-testing/concepts/agent.md), а также создавать, изменять, удалять, запускать, перезапускать и останавливать их;
* регистрировать в Load Testing [агентов](../load-testing/concepts/agent.md), созданных за пределами сервиса;
* просматривать информацию о [бакетах](../storage/concepts/bucket.md) Yandex Object Storage, использующихся в нагрузочных тестах, загружать в них тестовые данные, а также создавать, изменять и удалять бакеты;
* просматривать информацию о [дашбордах регрессий](../load-testing/concepts/load-test-regressions.md#dashbordy-regressij) нагрузочных тестов, а также создавать, изменять и удалять такие дашборды;
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролями `loadtesting.viewer`, `loadtesting.loadTester` и `loadtesting.externalAgent`.

#### loadtesting.admin {#loadtesting-admin}

Роль `loadtesting.admin` позволяет управлять агентами, нагрузочными тестами и их конфигурациями, хранилищами данных и дашбордами регрессий, а также регистрировать в сервисе агентов, созданных вне Load Testing.

Пользователи с этой ролью могут:
* просматривать информацию о нагрузочных тестах и [отчеты](../load-testing/concepts/reports.md) о результатах их выполнения;
* создавать, изменять, удалять, запускать и останавливать нагрузочные тесты, а также загружать в них [тестовые данные](../load-testing/concepts/payload.md);
* просматривать информацию о конфигурациях нагрузочных тестов, а также создавать, изменять и удалять такие конфигурации;
* просматривать информацию об [агентах](../load-testing/concepts/agent.md), а также создавать, изменять, удалять, запускать, перезапускать и останавливать их;
* регистрировать в Load Testing [агентов](../load-testing/concepts/agent.md), созданных за пределами сервиса;
* просматривать информацию о [бакетах](../storage/concepts/bucket.md) Yandex Object Storage, использующихся в нагрузочных тестах, загружать в них тестовые данные, а также создавать, изменять и удалять бакеты;
* просматривать информацию о [дашбордах регрессий](../load-testing/concepts/load-test-regressions.md#dashbordy-regressij) нагрузочных тестов, а также создавать, изменять и удалять такие дашборды;
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `loadtesting.editor`.

#### loadtesting.loadTester {#loadtesting-loadtester}

Роль `loadtesting.loadTester` позволяет управлять агентами, нагрузочными тестами и их конфигурациями, хранилищами данных и дашбордами регрессий.

Пользователи с этой ролью могут:
* просматривать информацию о нагрузочных тестах и [отчеты](../load-testing/concepts/reports.md) о результатах их выполнения;
* создавать, изменять, удалять, запускать и останавливать нагрузочные тесты, а также загружать в них [тестовые данные](../load-testing/concepts/payload.md);
* просматривать информацию о конфигурациях нагрузочных тестов, а также создавать, изменять и удалять такие конфигурации;
* просматривать информацию об [агентах](../load-testing/concepts/agent.md), а также создавать, изменять, удалять, запускать, перезапускать и останавливать их;
* просматривать информацию о [бакетах](../storage/concepts/bucket.md) Yandex Object Storage, использующихся в нагрузочных тестах, загружать в них тестовые данные, а также создавать, изменять и удалять бакеты;
* просматривать информацию о [дашбордах регрессий](../load-testing/concepts/load-test-regressions.md#dashbordy-regressij) нагрузочных тестов, а также создавать, изменять и удалять такие дашборды;
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

#### loadtesting.generatorClient {#loadtesting-generatorclient}

Роль `loadtesting.generatorClient` позволяет создавать, изменять и выполнять нагрузочные тесты на агенте, а также дает возможность загружать результаты тестов в хранилище.

Пользователи с этой ролью могут:
* создавать, изменять и запускать нагрузочные тесты;
* создавать и изменять конфигурацию нагрузочных тестов;
* загружать данные [результатов](../load-testing/concepts/load-test-results.md) тестов в хранилище.

Роль назначается на [сервисный аккаунт](concepts/users/service-accounts.md), от имени которого создается ВМ с [агентом](../load-testing/concepts/agent.md).

#### loadtesting.externalAgent {#loadtesting-externalagent}

Роль `loadtesting.externalAgent` позволяет регистрировать в сервисе агентов, созданных вне Load Testing, а также создавать, изменять и выполнять нагрузочные тесты на агенте.

Пользователи с этой ролью могут:
* регистрировать в Load Testing [агентов](../load-testing/concepts/agent.md), созданных за пределами сервиса;
* создавать, изменять и запускать нагрузочные тесты;
* создавать и изменять конфигурацию нагрузочных тестов;
* загружать данные [результатов](../load-testing/concepts/load-test-results.md) тестов в хранилище.

Включает разрешения, предоставляемые ролью `loadtesting.generatorClient`.

Роль назначается на [сервисный аккаунт](concepts/users/service-accounts.md), от имени которого создается ВМ с агентом.

Подробнее см. [{#T}](../load-testing/security/index.md).


## {{ lockbox-full-name }} {#lockbox-roles}

#### lockbox.auditor {#lockbox-auditor}

Роль `lockbox.auditor` позволяет просматривать информацию о [секретах](../lockbox/concepts/secret.md#secret) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также информацию о [квотах](../lockbox/concepts/limits.md#quotas) сервиса {{ lockbox-name }} и метаинформацию [каталога](../resource-manager/concepts/resources-hierarchy.md#folder).

#### lockbox.viewer {#lockbox-viewer}

Роль `lockbox.viewer` позволяет просматривать информацию о [секретах](../lockbox/concepts/secret.md#secret) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder) и [квотах](../lockbox/concepts/limits.md#quotas) сервиса {{ lockbox-name }}.

Включает разрешения, предоставляемые ролью `lockbox.auditor`.

#### lockbox.editor {#lockbox-editor}

Роль `lockbox.editor` позволяет управлять секретами и их версиями, а также просматривать информацию о назначенных правах доступа к секретам.

Пользователи с этой ролью могут:
* просматривать информацию о [секретах](../lockbox/concepts/secret.md#secret) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также создавать, активировать, деактивировать и удалять секреты;
* изменять метаданные [версий](../lockbox/concepts/secret.md#version) секретов, создавать и удалять версии секретов, а также изменять текущие версии секретов, планировать удаление и отменять запланированное удаление версий секретов;
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder);
* просматривать информацию о [квотах](../lockbox/concepts/limits.md#quotas) сервиса {{ lockbox-name }}.

Включает разрешения, предоставляемые ролью `lockbox.viewer`.

#### lockbox.admin {#lockbox-admin}

Роль `lockbox.admin` позволяет управлять секретами, их версиями и доступом к ним, а также просматривать содержимое секретов.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к секретам, а также изменять такие права доступа;
* просматривать информацию о [секретах](../lockbox/concepts/secret.md#secret), в том числе содержимое секретов;
* создавать, активировать, деактивировать и удалять секреты;
* изменять метаданные [версий](../lockbox/concepts/secret.md#version) секретов, создавать и удалять версии секретов, а также изменять текущие версии секретов, планировать удаление и отменять запланированное удаление версий секретов;
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder);
* просматривать информацию о [квотах](../lockbox/concepts/limits.md#quotas) сервиса {{ lockbox-name }}.

Включает разрешения, предоставляемые ролями `lockbox.editor` и `lockbox.payloadViewer`.

#### lockbox.payloadViewer {#lockbox-payloadViewer}

Роль `lockbox.payloadViewer` позволяет просматривать содержимое [секретов](../lockbox/concepts/secret.md#secret).

Подробнее см. [{#T}](../lockbox/security/index.md).


## Управляемые базы данных {#mdb}

#### mdb.auditor {#mdb-auditor}

Роль `mdb.auditor` предоставляет минимально необходимые разрешения для просмотра информации о кластерах управляемых баз данных (без доступа к данным и логам работы).

Пользователи с этой ролью могут просматривать информацию о кластерах управляемых баз данных, квотах и операциях с ресурсами сервисов.

Включает разрешения, предоставляемые ролями `managed-opensearch.auditor`, `managed-kafka.auditor`, `managed-mysql.auditor`, `managed-postgresql.auditor`, `managed-spqr.auditor`, `managed-greenplum.auditor`, `managed-clickhouse.auditor`, `managed-redis.auditor` и `managed-mongodb.auditor`.

#### mdb.viewer {#mdb-viewer}

Роль `mdb.viewer` предоставляет доступ к чтению информации из кластеров управляемых баз данных и к логам работы кластеров.

Пользователи с этой ролью могут читать информацию из баз данных и просматривать логи кластеров управляемых баз данных, просматривать информацию о заданиях на техническое обслуживание кластеров, а также информацию о кластерах, квотах и операциях с ресурсами сервисов.

Включает разрешения, предоставляемые ролями `managed-opensearch.viewer`, `managed-kafka.viewer`, `managed-mysql.viewer`, `managed-postgresql.viewer`, `managed-greenplum.viewer`, `managed-clickhouse.viewer`, `managed-redis.viewer`, `managed-mongodb.viewer` и `dataproc.viewer`.

#### mdb.admin {#mdb-admin}

Роль `mdb.admin` предоставляет полный доступ к кластерам управляемых баз данных.

Пользователи с этой ролью могут создавать, изменять, удалять, запускать и останавливать кластеры управляемых баз данных, управлять доступом к кластерам, создавать резервные копии кластеров и восстанавливать кластеры из резервных копий, читать и сохранять информацию в базах данных, а также просматривать информацию о кластерах, просматривать и изменять задания на техническое обслуживание кластеров, просматривать логи работы кластеров, информацию о квотах и операциях с ресурсами сервисов.

Включает разрешения, предоставляемые ролями `mdb.viewer`, `vpc.user`, `managed-opensearch.admin`, `managed-kafka.admin`, `managed-mysql.admin`, `managed-postgresql.admin`, `managed-spqr.admin`, `managed-greenplum.admin`, `managed-clickhouse.admin`, `managed-redis.admin`, `managed-mongodb.admin` и `dataproc.admin`.

#### mdb.restorer {#mdb-restorer}

Роль `mdb.restorer` позволяет восстанавливать кластеры управляемых баз данных из резервных копий, а также предоставляет доступ к чтению информации из кластеров и к логам их работы.

Пользователи с этой ролью могут восстанавливать кластеры управляемых баз данных из резервных копий, читать информацию из баз данных и просматривать логи кластеров, а также просматривать информацию о кластерах, заданиях на их техническое обслуживание, квотах и операциях с ресурсами сервисов.

Включает разрешения, предоставляемые ролями `mdb.viewer`, `managed-opensearch.restorer`, `managed-mysql.restorer`, `managed-postgresql.restorer`, `managed-spqr.restorer`, `managed-greenplum.restorer`, `managed-clickhouse.restorer`, `managed-redis.restorer` и `managed-mongodb.restorer`.

#### mdb.switcher {#mdb-switcher}

Роль `mdb.switcher` позволяет переназначать хост-мастер в кластерах управляемых баз данных, а также предоставляет доступ к информации о кластерах и к логам их работы.

Пользователи с этой ролью могут переназначать хост-мастер в кластерах управляемых баз данных, просматривать информацию о кластерах, хостах, базах данных и пользователях, логи работы кластеров, а также данные о квотах и операциях с ресурсами сервисов.

Включает разрешения, предоставляемые ролями `mdb.viewer`, `managed-mongodb.switcher`, `managed-mysql.switcher`, `managed-postgresql.switcher` и `managed-redis.switcher`.

#### mdb.maintenanceTask.viewer {#mdb-maintenanceTask-viewer}

Роль `mdb.maintenanceTask.viewer` предоставляет доступ к информации о заданиях на техническое обслуживание кластеров управляемых баз данных.

Пользователи с этой ролью могут просматривать информацию о заданиях на техническое обслуживание кластеров управляемых баз данных, а также информацию о таких кластерах и назначенных правах доступа к ним, о хостах и резервных копиях кластеров, о квотах и операциях с ресурсами сервисов.

Включает разрешения, предоставляемые ролями `mdb.auditor`, `managed-clickhouse.maintenanceTask.viewer`, `managed-greenplum.maintenanceTask.viewer`, `managed-kafka.maintenanceTask.viewer`, `managed-mongodb.maintenanceTask.viewer`, `managed-mysql.maintenanceTask.viewer`, `managed-opensearch.maintenanceTask.viewer`, `managed-postgresql.maintenanceTask.viewer`, `managed-redis.maintenanceTask.viewer` и `managed-spqr.maintenanceTask.viewer`.

#### mdb.maintenanceTask.editor {#mdb-maintenanceTask-editor}

Роль `mdb.maintenanceTask.editor` предоставляет доступ к управлению заданиями на техническое обслуживание кластеров управляемых баз данных.

Пользователи с этой ролью могут просматривать информацию о заданиях на техническое обслуживание кластеров управляемых баз данных и изменять такие задания, просматривать информацию о кластерах и назначенных правах доступа к ним, о хостах и резервных копиях кластеров, а также о квотах и операциях с ресурсами сервисов.

Включает разрешения, предоставляемые ролями `mdb.maintenanceTask.viewer`, `managed-clickhouse.maintenanceTask.editor`, `managed-greenplum.maintenanceTask.editor`, `managed-kafka.maintenanceTask.editor`, `managed-mongodb.maintenanceTask.editor`, `managed-mysql.maintenanceTask.editor`, `managed-opensearch.maintenanceTask.editor`, `managed-postgresql.maintenanceTask.editor`, `managed-redis.maintenanceTask.editor` и `managed-spqr.maintenanceTask.editor`.

## {{ maf-full-name }} {#managed-airflow-roles}

#### managed-airflow.auditor {#managed-airflow-auditor}

Роль `managed-airflow.auditor` позволяет просматривать информацию о [кластерах {{ AF }}](../managed-airflow/concepts/index.md#cluster) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также о [квотах](../managed-airflow/concepts/limits.md#quotas) сервиса {{ maf-name }}.

#### managed-airflow.viewer {#managed-airflow-viewer}

Роль `managed-airflow.viewer` позволяет просматривать информацию о [кластерах {{ AF }}](../managed-airflow/concepts/index.md#cluster) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о заданиях на [техническое обслуживание](../managed-airflow/concepts/maintenance.md) таких кластеров, а также о [квотах](../managed-airflow/concepts/limits.md#quotas) сервиса {{ maf-name }}.

Включает разрешения, предоставляемые ролями `managed-airflow.auditor` и `managed-airflow.maintenanceTask.viewer`.

#### managed-airflow.user {#managed-airflow-user}

Роль `managed-airflow.user` позволяет выполнять базовые операции с кластерами {{ AF }}.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах {{ AF }}](../managed-airflow/concepts/index.md#cluster) и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* [использовать веб-интерфейс](../managed-airflow/operations/af-interfaces.md#web-gui) {{ AF }};
* [отправлять запросы](../managed-airflow/operations/af-interfaces.md#rest-api) к API {{ AF }};
* просматривать информацию о заданиях на [техническое обслуживание](../managed-airflow/concepts/maintenance.md) кластеров {{ AF }};
* просматривать информацию о [квотах](../managed-airflow/concepts/limits.md#quotas) сервиса {{ maf-name }}.

Включает разрешения, предоставляемые ролью `managed-airflow.viewer`.

#### managed-airflow.editor {#managed-airflow-editor}

Роль `managed-airflow.editor` позволяет управлять кластерами {{ AF }}.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах {{ AF }}](../managed-airflow/concepts/index.md#cluster), а также создавать, изменять, запускать, останавливать и удалять их;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к кластерам {{ AF }};
* просматривать информацию о заданиях на [техническое обслуживание](../managed-airflow/concepts/maintenance.md) кластеров {{ AF }} и изменять такие задания;
* [использовать веб-интерфейс](../managed-airflow/operations/af-interfaces.md#web-gui) {{ AF }};
* [отправлять запросы](../managed-airflow/operations/af-interfaces.md#rest-api) к API {{ AF }};
* просматривать информацию о [квотах](../managed-airflow/concepts/limits.md#quotas) сервиса {{ maf-name }}.

Включает разрешения, предоставляемые ролями `managed-airflow.user` и `managed-airflow.maintenanceTask.editor`.

Для создания кластеров {{ AF }} дополнительно необходима роль `vpc.user`.

#### managed-airflow.admin {#managed-airflow-admin}

Роль `managed-airflow.admin` позволяет управлять кластерами {{ AF }} и доступом к ним.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к [кластерам {{ AF }}](../managed-airflow/concepts/index.md#cluster) и изменять такие права доступа;
* просматривать информацию о кластерах {{ AF }}, а также создавать, изменять, запускать, останавливать и удалять их;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-airflow/concepts/maintenance.md) кластеров {{ AF }} и изменять такие задания;
* [использовать веб-интерфейс](../managed-airflow/operations/af-interfaces.md#web-gui) {{ AF }};
* [отправлять запросы](../managed-airflow/operations/af-interfaces.md#rest-api) к API {{ AF }};
* просматривать информацию о [квотах](../managed-airflow/concepts/limits.md#quotas) сервиса {{ maf-name }}.

Включает разрешения, предоставляемые ролью `managed-airflow.editor`.

Для создания кластеров {{ AF }} дополнительно необходима роль `vpc.user`.

#### managed-airflow.maintenanceTask.viewer {#managed-airflow-maintenanceTask-viewer}

Роль `managed-airflow.maintenanceTask.viewer` позволяет просматривать информацию о [кластерах {{ AF }}](../managed-airflow/concepts/index.md#cluster) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о заданиях на [техническое обслуживание](../managed-airflow/concepts/maintenance.md) таких кластеров, а также о [квотах](../managed-airflow/concepts/limits.md#quotas) сервиса {{ maf-name }}.

Включает разрешения, предоставляемые ролью `managed-airflow.auditor`.

#### managed-airflow.maintenanceTask.editor {#managed-airflow-maintenanceTask-editor}

Роль `managed-airflow.maintenanceTask.editor` позволяет просматривать информацию о заданиях на [техническое обслуживание](../managed-airflow/concepts/maintenance.md) кластеров {{ AF }} и изменять такие задания, просматривать информацию о [кластерах {{ AF }}](../managed-airflow/concepts/index.md#cluster) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также о [квотах](../managed-airflow/concepts/limits.md#quotas) сервиса {{ maf-name }}.

Включает разрешения, предоставляемые ролью `managed-airflow.maintenanceTask.viewer`.

#### managed-airflow.integrationProvider {#managed-airflow-integrationProvider}

Роль `managed-airflow.integrationProvider` позволяет кластеру {{ AF }} взаимодействовать от имени сервисного аккаунта с пользовательскими ресурсами, необходимыми для работы кластера. Роль назначается сервисному аккаунту, привязанному к кластеру {{ AF }}.

{% cut "Сервисные аккаунты с этой ролью могут:" %}

* добавлять записи в [лог-группы](../logging/concepts/log-group.md);
* просматривать информацию о лог-группах;
* просматривать информацию о приемниках логов;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к ресурсам сервиса {{ cloud-logging-name }};
* просматривать информацию о выгрузках логов;
* просматривать информацию о [метриках](../monitoring/concepts/data-model.md#metric) {{ monitoring-name }} и их [метках](../monitoring/concepts/data-model.md#label), а также загружать и выгружать метрики;
* просматривать список [дашбордов](../monitoring/concepts/visualization/dashboard.md) и [виджетов](../monitoring/concepts/visualization/widget.md) {{ monitoring-name }} и информацию о них, а также создавать, изменять и удалять дашборды и виджеты;
* просматривать историю [уведомлений](../monitoring/concepts/alerting/notification-channel.md) {{ monitoring-name }};
* просматривать список [бакетов](../storage/concepts/bucket.md) и информацию о них, в том числе о регионе размещения, [версионировании](../storage/concepts/versioning.md), [шифровании](../storage/concepts/encryption.md), конфигурации [CORS](../storage/concepts/cors.md), конфигурации [хостинга статических сайтов](../storage/concepts/hosting.md), конфигурации [HTTPS](../storage/concepts/bucket.md#bucket-https), настройках [логирования](../storage/concepts/server-logs.md), назначенных правах доступа, [публичном доступе](../storage/concepts/bucket.md#bucket-access) и [классе хранилища](../storage/concepts/storage-class.md#default-storage-class) по умолчанию;
* просматривать списки [объектов](../storage/concepts/object.md) в бакетах и информацию об объектах, в том числе о конфигурации [жизненных циклов](../storage/concepts/lifecycles.md) объектов, назначенных правах доступа к объектам, текущих [составных загрузках](../storage/concepts/multipart.md), версиях объектов с их [метаданными](../storage/concepts/object.md#metadata), временных и бессрочных [блокировках версий объектов](../storage/concepts/object-lock.md);
* просматривать [метки](../storage/concepts/tags.md) бакетов, объектов и версий объектов, а также статистику сервиса {{ objstorage-name }};
* просматривать информацию о [секретах {{ lockbox-name }}](../lockbox/concepts/secret.md#secret) и назначенных правах доступа к ним;
* просматривать информацию о квотах сервисов [{{ objstorage-name }}](../storage/concepts/limits.md#storage-quotas), [{{ monitoring-name }}](../monitoring/concepts/limits.md#monitoring-quotas) и [{{ lockbox-name }}](../lockbox/concepts/limits.md#quotas);
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролями `logging.writer`, `monitoring.editor`, `storage.viewer` и `lockbox.viewer`.

Роль не разрешает доступ к содержимому секретов {{ lockbox-name }}. Для того чтобы кластер {{ AF }} имел доступ к содержимому секретов в {{ lockbox-name }}, выдайте [сервисному аккаунту](concepts/users/service-accounts.md) дополнительную [роль](../lockbox/security/index.md#lockbox-payloadViewer) `lockbox.payloadViewer` на каталог или на определенные секреты.

Подробнее см. [{#T}](../managed-airflow/security/index.md).


## {{ mkf-full-name }} {#managed-kafka-roles}

#### managed-kafka.auditor {#managed-kafka-auditor}

Роль `managed-kafka.auditor` позволяет просматривать информацию о [кластерах {{ KF }}](../managed-kafka/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также о [квотах](../managed-kafka/concepts/limits.md#mkf-quotas) и операциях с ресурсами сервиса {{ mkf-name }}.

#### managed-kafka.viewer {#managed-kafka-viewer}

Роль `managed-kafka.viewer` позволяет просматривать информацию о кластерах {{ KF }} и логи их работы, а также данные о квотах и операциях с ресурсами сервиса {{ mkf-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах {{ KF }}](../managed-kafka/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-kafka/concepts/maintenance.md) кластеров {{ KF }};
* просматривать логи работы кластеров {{ KF }};
* просматривать информацию о [квотах](../managed-kafka/concepts/limits.md#mkf-quotas) сервиса {{ mkf-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mkf-name }}.

Включает разрешения, предоставляемые ролями `managed-kafka.auditor` и `managed-kafka.maintenanceTask.viewer`.


#### managed-kafka.user {#managed-kafka-user}

Роль `managed-kafka.user` позволяет использовать [кластеры {{ KF }}](../managed-kafka/concepts/index.md).

#### managed-kafka.editor {#managed-kafka-editor}

Роль `managed-kafka.editor` позволяет управлять кластерами {{ KF }}.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах {{ KF }}](../managed-kafka/concepts/index.md), а также создавать, использовать, изменять, удалять, запускать и останавливать их;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к кластерам {{ KF }};
* использовать [веб-интерфейс](../managed-kafka/concepts/kafka-ui.md) Kafka UI для {{ KF }};
* просматривать информацию о заданиях на [техническое обслуживание](../managed-kafka/concepts/maintenance.md) кластеров {{ KF }} и изменять такие задания;
* просматривать логи работы кластеров {{ KF }};
* просматривать информацию о [квотах](../managed-kafka/concepts/limits.md#mkf-quotas) сервиса {{ mkf-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mkf-name }}.

Включает разрешения, предоставляемые ролями `managed-kafka.viewer`, `managed-kafka.user`, `managed-kafka.interfaceUser` и `managed-kafka.maintenanceTask.editor`.

Для создания кластеров {{ KF }} дополнительно необходима роль `vpc.user`.

#### managed-kafka.admin {#managed-kafka-admin}

Роль `managed-kafka.admin` позволяет управлять кластерами {{ KF }} и доступом к ним.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к [кластерам {{ KF }}](../managed-kafka/concepts/index.md) и изменять такие права доступа;
* просматривать информацию о кластерах {{ KF }}, а также создавать, использовать, изменять, удалять, запускать и останавливать их;
* использовать [веб-интерфейс](../managed-kafka/concepts/kafka-ui.md) Kafka UI для {{ KF }};
* просматривать информацию о заданиях на [техническое обслуживание](../managed-kafka/concepts/maintenance.md) кластеров {{ KF }} и изменять такие задания;
* просматривать логи работы кластеров {{ KF }};
* просматривать информацию о [квотах](../managed-kafka/concepts/limits.md#mkf-quotas) сервиса {{ mkf-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mkf-name }}.

Включает разрешения, предоставляемые ролью `managed-kafka.editor`.

Для создания кластеров {{ KF }} дополнительно необходима роль `vpc.user`.

#### managed-kafka.maintenanceTask.viewer {#managed-kafka-maintenanceTask-viewer}

Роль `managed-kafka.maintenanceTask.viewer` позволяет просматривать информацию о [кластерах {{ KF }}](../managed-kafka/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о заданиях на [техническое обслуживание](../managed-kafka/concepts/maintenance.md) таких кластеров, а также о [квотах](../managed-kafka/concepts/limits.md#mkf-quotas) и операциях с ресурсами сервиса {{ mkf-name }}.

Включает разрешения, предоставляемые ролью `managed-kafka.auditor`.

#### managed-kafka.maintenanceTask.editor {#managed-kafka-maintenanceTask-editor}

Роль `managed-kafka.maintenanceTask.editor` позволяет просматривать информацию о заданиях на [техническое обслуживание](../managed-kafka/concepts/maintenance.md) кластеров {{ KF }} и изменять такие задания, просматривать информацию о [кластерах {{ KF }}](../managed-kafka/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также о [квотах](../managed-kafka/concepts/limits.md#mkf-quotas) и операциях с ресурсами сервиса {{ mkf-name }}.

Включает разрешения, предоставляемые ролью `managed-kafka.maintenanceTask.viewer`.

#### managed-kafka.interfaceUser {#managed-kafka-interface-user}

Роль `managed-kafka.interfaceUser` позволяет использовать [веб-интерфейс](../managed-kafka/concepts/kafka-ui.md) Kafka UI для {{ KF }}.

Подробнее см. [{#T}](../managed-kafka/security/index.md).


## {{ msp-full-name }} {#msp-roles}

#### managed-spark.auditor {#managed-spark-auditor}

Роль `managed-spark.auditor` позволяет просматривать информацию о [кластерах {{ SPRK }}](../managed-spark/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также о [квотах](../managed-spark/concepts/limits.md#quotas) сервиса {{ msp-name }}.

#### managed-spark.viewer {#managed-spark-viewer}

Роль `managed-spark.viewer` позволяет просматривать информацию о кластерах {{ SPRK }}, заданиях и квотах сервиса {{ msp-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах {{ SPRK }}](../managed-spark/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-spark/concepts/maintenance.md) кластеров {{ SPRK }};
* просматривать информацию о [заданиях](../managed-spark/operations/index.md#jobs);
* просматривать информацию о [квотах](../managed-spark/concepts/limits.md#quotas) сервиса {{ msp-name }}.

Включает разрешения, предоставляемые ролями `managed-spark.auditor` и `managed-spark.maintenanceTask.viewer`.

#### managed-spark.user {#managed-spark-user}

Роль `managed-spark.user` позволяет выполнять базовые операции с кластерами {{ SPRK }} и заданиями.

Пользователи с этой ролью могут:
* использовать веб-интерфейс {{ SPRK }};
* просматривать информацию о [заданиях](../managed-spark/operations/index.md#jobs), а также создавать, запускать и отменять их;
* просматривать информацию о [кластерах {{ SPRK }}](../managed-spark/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-spark/concepts/maintenance.md) кластеров {{ SPRK }};
* просматривать информацию о [квотах](../managed-spark/concepts/limits.md#quotas) сервиса {{ msp-name }}.

Включает разрешения, предоставляемые ролью `managed-spark.viewer`.

#### managed-spark.editor {#managed-spark-editor}

Роль `managed-spark.editor` позволяет управлять кластерами {{ SPRK }} и заданиями.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах {{ SPRK }}](../managed-spark/concepts/index.md), а также создавать, изменять, запускать, останавливать и удалять их;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к кластерам {{ SPRK }};
* просматривать информацию о заданиях на [техническое обслуживание](../managed-spark/concepts/maintenance.md) кластеров {{ SPRK }} и изменять такие задания;
* использовать веб-интерфейс {{ SPRK }};
* просматривать информацию о [заданиях](../managed-spark/operations/index.md#jobs), а также создавать, запускать и отменять их;
* просматривать информацию о [квотах](../managed-spark/concepts/limits.md#quotas) сервиса {{ msp-name }}.

Включает разрешения, предоставляемые ролями `managed-spark.user` и `managed-spark.maintenanceTask.editor`.

Для создания кластеров {{ SPRK }} дополнительно необходима роль `vpc.user`.

#### managed-spark.admin {#managed-spark-admin}

Роль `managed-spark.admin` позволяет управлять кластерами {{ SPRK }} и доступом к ним.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к [кластерам {{ SPRK }}](../managed-spark/concepts/index.md) и изменять такие права доступа;
* просматривать информацию о кластерах {{ SPRK }}, а также создавать, изменять, запускать, останавливать и удалять их;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-spark/concepts/maintenance.md) кластеров {{ SPRK }} и изменять такие задания;
* использовать веб-интерфейс {{ SPRK }};
* просматривать информацию о [заданиях](../managed-spark/operations/index.md#jobs), а также создавать, запускать и отменять их;
* просматривать информацию о [квотах](../managed-spark/concepts/limits.md#quotas) сервиса {{ msp-name }}.

Включает разрешения, предоставляемые ролью `managed-spark.editor`.

Для создания кластеров {{ SPRK }} дополнительно необходима роль `vpc.user`.

#### managed-spark.maintenanceTask.viewer {#managed-spark-maintenanceTask-viewer}

Роль `managed-spark.maintenanceTask.viewer` позволяет просматривать информацию о [кластерах {{ SPRK }}](../managed-spark/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также о заданиях на [техническое обслуживание](../managed-spark/concepts/maintenance.md) таких кластеров и [квотах](../managed-spark/concepts/limits.md#quotas) сервиса {{ msp-name }}.

Включает разрешения, предоставляемые ролью `managed-spark.auditor`.

#### managed-spark.maintenanceTask.editor {#managed-spark-maintenanceTask-editor}

Роль `managed-spark.maintenanceTask.editor` позволяет просматривать информацию о заданиях на [техническое обслуживание](../managed-spark/concepts/maintenance.md) кластеров {{ SPRK }} и изменять такие задания, просматривать информацию о [кластерах {{ SPRK }}](../managed-spark/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также о [квотах](../managed-spark/concepts/limits.md#quotas) сервиса {{ msp-name }}.

Включает разрешения, предоставляемые ролью `managed-spark.maintenanceTask.viewer`.

#### managed-spark.integrationProvider {#managed-spark-integrationProvider}

Роль `managed-spark.integrationProvider` позволяет кластеру {{ SPRK }} взаимодействовать от имени сервисного аккаунта с пользовательскими ресурсами, необходимыми для работы кластера. Роль назначается сервисному аккаунту, привязанному к кластеру {{ SPRK }}.

Пользователи с этой ролью могут:
* добавлять записи в [лог-группы](../logging/concepts/log-group.md);
* просматривать информацию о лог-группах;
* просматривать информацию о приемниках логов;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к ресурсам сервиса {{ cloud-logging-name }};
* просматривать информацию о выгрузках логов;
* просматривать информацию о [метриках](../monitoring/concepts/data-model.md#metric) и их [метках](../monitoring/concepts/data-model.md#label), а также загружать и выгружать метрики;
* просматривать список [дашбордов](../monitoring/concepts/visualization/dashboard.md) и [виджетов](../monitoring/concepts/visualization/widget.md) и информацию о них, а также создавать, изменять и удалять дашборды и виджеты;
* просматривать историю [уведомлений](../monitoring/concepts/alerting/notification-channel.md);
* просматривать информацию о [квотах](../monitoring/concepts/limits.md#monitoring-quotas) сервиса {{ monitoring-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролями `logging.writer` и `monitoring.editor`.

Подробнее см. [{#T}](../managed-spark/security.md).


## {{ mch-full-name }} {#managed-clickhouse-roles}

#### managed-clickhouse.auditor {#managed-clickhouse-auditor}

Роль `managed-clickhouse.auditor` позволяет просматривать информацию о [кластерах {{ CH }}](../managed-clickhouse/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также о [квотах](../managed-clickhouse/concepts/limits.md#mch-quotas) и операциях с ресурсами сервиса {{ mch-name }}.

#### managed-clickhouse.viewer {#managed-clickhouse-viewer}

Роль `managed-clickhouse.viewer` позволяет просматривать информацию о кластерах {{ CH }} и логи их работы, а также данные о квотах и операциях с ресурсами сервиса {{ mch-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах {{ CH }}](../managed-clickhouse/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-clickhouse/concepts/maintenance.md) кластеров {{ CH }};
* просматривать логи работы кластеров {{ CH }};
* просматривать информацию о результатах диагностики производительности кластеров {{ CH }};
* просматривать информацию о [квотах](../managed-clickhouse/concepts/limits.md#mch-quotas) сервиса {{ mch-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mch-name }}.

Включает разрешения, предоставляемые ролями `managed-clickhouse.auditor` и `managed-clickhouse.maintenanceTask.viewer`.

#### managed-clickhouse.restorer {#managed-clickhouse-restorer}

Роль `managed-clickhouse.restorer` позволяет восстанавливать кластеры {{ CH }} из резервных копий, просматривать информацию о кластерах и логи их работы, а также данные о квотах и операциях с ресурсами сервиса {{ mch-name }}.

Пользователи с этой ролью могут:
* восстанавливать [кластеры {{ CH }}](../managed-clickhouse/concepts/index.md) из резервных копий;
* просматривать информацию о кластерах {{ CH }} и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-clickhouse/concepts/maintenance.md) кластеров {{ CH }};
* просматривать логи работы кластеров {{ CH }};
* просматривать информацию о результатах диагностики производительности кластеров {{ CH }};
* просматривать информацию о [квотах](../managed-clickhouse/concepts/limits.md#mch-quotas) сервиса {{ mch-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mch-name }}.

Включает разрешения, предоставляемые ролью `managed-clickhouse.viewer`.

#### managed-clickhouse.user {#managed-clickhouse-user}

Роль `managed-clickhouse.user` позволяет использовать [кластеры {{ CH }}](../managed-clickhouse/concepts/index.md).

#### managed-clickhouse.editor {#managed-clickhouse-editor}

Роль `managed-clickhouse.editor` позволяет управлять кластерами {{ CH }}.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах {{ CH }}](../managed-clickhouse/concepts/index.md), а также создавать, использовать, изменять, удалять, запускать и останавливать их;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к кластерам {{ CH }};
* просматривать информацию о заданиях на [техническое обслуживание](../managed-clickhouse/concepts/maintenance.md) кластеров {{ CH }} и изменять такие задания;
* восстанавливать кластеры {{ CH }} из резервных копий;
* просматривать логи работы кластеров {{ CH }};
* просматривать информацию о результатах диагностики производительности кластеров {{ CH }};
* просматривать информацию о [квотах](../managed-clickhouse/concepts/limits.md#mch-quotas) сервиса {{ mch-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mch-name }}.

Включает разрешения, предоставляемые ролями `managed-clickhouse.viewer`, `managed-clickhouse.user`, `managed-clickhouse.restorer` и `managed-clickhouse.maintenanceTask.editor`.

Для создания кластеров {{ CH }} дополнительно необходима роль `vpc.user`.

#### managed-clickhouse.admin {#managed-clickhouse-admin}

Роль `managed-clickhouse.admin` позволяет управлять кластерами {{ CH }} и доступом к ним.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к [кластерам {{ CH }}](../managed-clickhouse/concepts/index.md), а также изменять такие права доступа;
* просматривать информацию о кластерах {{ CH }}, а также создавать, использовать, изменять, удалять, запускать и останавливать их;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-clickhouse/concepts/maintenance.md) кластеров {{ CH }} и изменять такие задания;
* восстанавливать кластеры {{ CH }} из резервных копий;
* просматривать логи работы кластеров {{ CH }};
* просматривать информацию о результатах диагностики производительности кластеров {{ CH }};
* просматривать информацию о [квотах](../managed-clickhouse/concepts/limits.md#mch-quotas) сервиса {{ mch-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mch-name }}.

Включает разрешения, предоставляемые ролью `managed-clickhouse.editor`.

Для создания кластеров {{ CH }} дополнительно необходима роль `vpc.user`.

#### managed-clickhouse.maintenanceTask.viewer {#managed-clickhouse-maintenanceTask-viewer}

Роль `managed-clickhouse.maintenanceTask.viewer` позволяет просматривать информацию о заданиях на [техническое обслуживание](../managed-clickhouse/concepts/maintenance.md) кластеров {{ CH }}, о [кластерах {{ CH }}](../managed-clickhouse/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также о [квотах](../managed-clickhouse/concepts/limits.md#mch-quotas) и операциях с ресурсами сервиса {{ mch-name }}.

Включает разрешения, предоставляемые ролью `managed-clickhouse.auditor`.

#### managed-clickhouse.maintenanceTask.editor {#managed-clickhouse-maintenanceTask-editor}

Роль `managed-clickhouse.maintenanceTask.editor` позволяет просматривать информацию о заданиях на [техническое обслуживание](../managed-clickhouse/concepts/maintenance.md) кластеров {{ CH }} и изменять такие задания, просматривать информацию о [кластерах {{ CH }}](../managed-clickhouse/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также о [квотах](../managed-clickhouse/concepts/limits.md#mch-quotas) и операциях с ресурсами сервиса {{ mch-name }}.

Включает разрешения, предоставляемые ролью `managed-clickhouse.maintenanceTask.viewer`.

Подробнее см. [{#T}](../managed-clickhouse/security.md).


## {{ mgl-full-name }} {#managed-gitlab-roles}

#### gitlab.auditor {#gitlab-auditor}

Роль `gitlab.auditor` позволяет просматривать информацию об [инстансах](../managed-gitlab/concepts/index.md#instance) Managed Service for GitLab и [квотах](../managed-gitlab/concepts/limits.md#quotas) сервиса.

#### gitlab.viewer {#gitlab-viewer}

Роль `gitlab.viewer` позволяет просматривать информацию об [инстансах](../managed-gitlab/concepts/index.md#instance) Managed Service for GitLab и [квотах](../managed-gitlab/concepts/limits.md#quotas) сервиса.

Включает разрешения, предоставляемые ролью `gitlab.auditor`.

#### gitlab.editor {#gitlab-editor}

Роль `gitlab.editor` позволяет управлять инстансами Managed Service for GitLab и переносить их в другую зону доступности.

Пользователи с этой ролью могут:
* просматривать информацию об [инстансах](../managed-gitlab/concepts/index.md#instance) Managed Service for GitLab, а также создавать, изменять и удалять инстансы;
* переносить инстансы в другую [зону доступности](../overview/concepts/geo-scope.md);
* просматривать информацию о [квотах](../managed-gitlab/concepts/limits.md#quotas) сервиса Managed Service for GitLab.

Включает разрешения, предоставляемые ролью `gitlab.viewer`.

Для создания инстансов Managed Service for GitLab дополнительно необходима роль `vpc.user`.

#### gitlab.admin {#gitlab-admin}

Роль `gitlab.admin` позволяет управлять инстансами Managed Service for GitLab и переносить их в другую зону доступности.

Пользователи с этой ролью могут:
* просматривать информацию об [инстансах](../managed-gitlab/concepts/index.md#instance) Managed Service for GitLab, а также создавать, изменять и удалять инстансы;
* переносить инстансы в другую [зону доступности](../overview/concepts/geo-scope.md);
* просматривать информацию о [квотах](../managed-gitlab/concepts/limits.md#quotas) сервиса Managed Service for GitLab.

Включает разрешения, предоставляемые ролью `gitlab.editor`.

Для создания инстансов Managed Service for GitLab дополнительно необходима роль `vpc.user`.

Подробнее см. [{#T}](../managed-gitlab/security/index.md).


## {{ mgp-full-name }} {#managed-greenplum-roles}

#### managed-greenplum.clusters.connector {#managed-greenplum-clusters-connector}

Роль `managed-greenplum.clusters.connector` позволяет [пользователям](concepts/users/accounts.md) {{ yandex-cloud }} подключаться к базам данных в [кластерах {{ mgp-name }}](../managed-greenplum/concepts/index.md) в сервисе {{ mgp-full-name }} с помощью механизмов сервиса [{{ iam-full-name }}](index.md).

#### managed-greenplum.auditor {#managed-greenplum-auditor}

Роль `managed-greenplum.auditor` позволяет просматривать информацию о [кластерах {{ mgp-name }}](../managed-greenplum/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о [хостах](../managed-greenplum/concepts/instance-types.md) и [резервных копиях](../managed-greenplum/concepts/backup.md) кластеров, а также о [квотах](../managed-greenplum/concepts/limits.md#quotas) и операциях с ресурсами сервиса {{ mgp-full-name }}.

#### managed-greenplum.viewer {#managed-greenplum-viewer}

Роль `managed-greenplum.viewer` позволяет просматривать информацию о кластерах и хостах {{ mgp-name }} в сервисе {{ mgp-full-name }}, логи их работы, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах {{ mgp-name }}](../managed-greenplum/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-greenplum/concepts/maintenance.md) кластеров {{ mgp-name }};
* просматривать информацию о [хостах](../managed-greenplum/concepts/instance-types.md) кластеров {{ mgp-name }};
* просматривать информацию о [резервных копиях](../managed-greenplum/concepts/backup.md) кластеров {{ mgp-name }};
* просматривать логи работы кластеров {{ mgp-name }};
* просматривать информацию о результатах диагностики производительности кластеров {{ mgp-name }};
* просматривать информацию о [квотах](../managed-greenplum/concepts/limits.md#quotas) сервиса {{ mgp-full-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mgp-full-name }}.

Включает разрешения, предоставляемые ролями `managed-greenplum.auditor` и `managed-greenplum.maintenanceTask.viewer`.

#### managed-greenplum.restorer {#managed-greenplum-restorer}

Роль `managed-greenplum.restorer` позволяет восстанавливать из резервных копий кластеры {{ mgp-name }} в сервисе {{ mgp-full-name }}, просматривать информацию о кластерах и хостах {{ mgp-name }}, логи их работы, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о резервных копиях [кластеров {{ mgp-name }}](../managed-greenplum/concepts/index.md) и восстанавливать кластеры из [резервных копий](../managed-greenplum/concepts/backup.md);
* просматривать информацию о кластерах {{ mgp-name }} и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-greenplum/concepts/maintenance.md) кластеров {{ mgp-name }};
* просматривать информацию о [хостах](../managed-greenplum/concepts/instance-types.md) кластеров {{ mgp-name }};
* просматривать логи работы кластеров {{ mgp-name }};
* просматривать информацию о результатах диагностики производительности кластеров {{ mgp-name }};
* просматривать информацию о [квотах](../managed-greenplum/concepts/limits.md#quotas) сервиса {{ mgp-full-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mgp-full-name }}.

Включает разрешения, предоставляемые ролью `managed-greenplum.viewer`.

#### managed-greenplum.user {#managed-greenplum-user}

Роль `managed-greenplum.user` позволяет использовать [кластеры {{ mgp-name }}](../managed-greenplum/concepts/index.md).

#### managed-greenplum.editor {#managed-greenplum-editor}

Роль `managed-greenplum.editor` позволяет управлять кластерами {{ mgp-name }} в сервисе {{ mgp-full-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах {{ mgp-name }}](../managed-greenplum/concepts/index.md), а также создавать, использовать, изменять, удалять, запускать и останавливать их;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к кластерам {{ mgp-name }};
* просматривать информацию о заданиях на [техническое обслуживание](../managed-greenplum/concepts/maintenance.md) кластеров {{ mgp-name }} и изменять такие задания;
* просматривать информацию о [хостах](../managed-greenplum/concepts/instance-types.md) кластеров {{ mgp-name }}, а также создавать, изменять и удалять их;
* просматривать информацию о [резервных копиях](../managed-greenplum/concepts/backup.md) кластеров {{ mgp-name }}, создавать и удалять резервные копии кластеров, а также восстанавливать кластеры из резервных копий;
* просматривать логи работы кластеров {{ mgp-name }};
* просматривать информацию о результатах диагностики производительности кластеров {{ mgp-name }};
* просматривать информацию о [квотах](../managed-greenplum/concepts/limits.md#quotas) сервиса {{ mgp-full-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mgp-full-name }}.

Включает разрешения, предоставляемые ролями `managed-greenplum.viewer`, `managed-greenplum.user`, `managed-greenplum.restorer` и `managed-greenplum.maintenanceTask.editor`.

Для создания кластеров {{ mgp-name }} в сервисе {{ mgp-full-name }} дополнительно необходима роль `vpc.user`.

#### managed-greenplum.admin {#managed-greenplum-admin}

Роль `managed-greenplum.admin` позволяет управлять кластерами {{ mgp-name }} и доступом к ним в сервисе {{ mgp-full-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к [кластерам {{ mgp-name }}](../managed-greenplum/concepts/index.md) и изменять такие права доступа;
* просматривать информацию о кластерах {{ mgp-name }}, а также создавать, использовать, изменять, удалять, запускать и останавливать их;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-greenplum/concepts/maintenance.md) кластеров {{ mgp-name }} и изменять такие задания;
* просматривать информацию о [хостах](../managed-greenplum/concepts/instance-types.md) кластеров {{ mgp-name }}, а также создавать, изменять и удалять их;
* просматривать информацию о [резервных копиях](../managed-greenplum/concepts/backup.md) кластеров {{ mgp-name }}, создавать и удалять резервные копии кластеров, а также восстанавливать кластеры из резервных копий;
* просматривать логи работы кластеров {{ mgp-name }};
* просматривать информацию о результатах диагностики производительности кластеров {{ mgp-name }};
* просматривать информацию о [квотах](../managed-greenplum/concepts/limits.md#quotas) сервиса {{ mgp-full-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mgp-full-name }}.

Включает разрешения, предоставляемые ролью `managed-greenplum.editor`.

Для создания кластеров {{ mgp-name }} в сервисе {{ mgp-full-name }} дополнительно необходима роль `vpc.user`.

#### managed-greenplum.maintenanceTask.viewer {#managed-greenplum-maintenanceTask-viewer}

Роль `managed-greenplum.maintenanceTask.viewer` позволяет просматривать информацию о заданиях на [техническое обслуживание](../managed-greenplum/concepts/maintenance.md) кластеров {{ mgp-name }}, а также о таких [кластерах](../managed-greenplum/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о [хостах](../managed-greenplum/concepts/instance-types.md) и [резервных копиях](../managed-greenplum/concepts/backup.md) кластеров, о [квотах](../managed-greenplum/concepts/limits.md#quotas) и операциях с ресурсами сервиса {{ mgp-full-name }}.

Включает разрешения, предоставляемые ролью `managed-greenplum.auditor`.

#### managed-greenplum.maintenanceTask.editor {#managed-greenplum-maintenanceTask-editor}

Роль `managed-greenplum.maintenanceTask.editor` позволяет просматривать информацию о заданиях на [техническое обслуживание](../managed-greenplum/concepts/maintenance.md) кластеров {{ mgp-name }} и изменять такие задания, просматривать информацию о [кластерах {{ mgp-name }}](../managed-greenplum/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о [хостах](../managed-greenplum/concepts/instance-types.md) и [резервных копиях](../managed-greenplum/concepts/backup.md) кластеров, а также о [квотах](../managed-greenplum/concepts/limits.md#quotas) и операциях с ресурсами сервиса {{ mgp-full-name }}.

Включает разрешения, предоставляемые ролью `managed-greenplum.maintenanceTask.viewer`.

Подробнее см. [{#T}](../managed-greenplum/security/index.md).


## {{ managed-k8s-full-name }} {#managed-kubernetes-roles}

#### k8s.viewer {#k8s-viewer}

Роль `k8s.viewer` позволяет просматривать информацию о кластерах и группах узлов {{ k8s }}.

Пользователи с этой ролью могут:
* просматривать список [кластеров {{ k8s }}](../managed-kubernetes/concepts/index.md#kubernetes-cluster), информацию о них и настройках их взаимодействия с {{ marketplace-name }}, а также о назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать список [групп узлов](../managed-kubernetes/concepts/index.md#node-group) кластеров {{ k8s }} и информацию о таких группах узлов;
* просматривать информацию о приложениях из {{ marketplace-name }}, а также о назначенных правах доступа к ним;
* просматривать статистику использования ресурсов и информацию о [квотах](../managed-kubernetes/concepts/limits.md#managed-k8s-quotas) сервиса {{ managed-k8s-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

#### k8s.editor {#k8s-editor}

Роль `k8s.editor` позволяет управлять кластерами и группами узлов {{ k8s }}.

Пользователи с этой ролью могут:
* просматривать список [кластеров {{ k8s }}](../managed-kubernetes/concepts/index.md#kubernetes-cluster), информацию о них и о назначенных [правах доступа](concepts/access-control/index.md) к ним;
* создавать, изменять, запускать, останавливать и удалять кластеры Kubernetes;
* просматривать список [групп узлов](../managed-kubernetes/concepts/index.md#node-group) кластеров {{ k8s }} и информацию о таких группах узлов;
* создавать, изменять и удалять группы узлов кластеров Kubernetes;
* просматривать и изменять настройки взаимодействия кластеров {{ k8s }} с {{ marketplace-name }};
* просматривать информацию о приложениях из {{ marketplace-name }} и о назначенных правах доступа к ним, а также устанавливать, обновлять и удалять такие приложения;
* просматривать статистику использования ресурсов и информацию о [квотах](../managed-kubernetes/concepts/limits.md#managed-k8s-quotas) сервиса {{ managed-k8s-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `k8s.viewer`.

#### k8s.admin {#k8s-admin}

Роль `k8s.admin` позволяет управлять кластерами и группами узлов {{ k8s }}, а также доступом к кластерам {{ k8s }}.

Пользователи с этой ролью могут:
* просматривать список [кластеров {{ k8s }}](../managed-kubernetes/concepts/index.md#kubernetes-cluster) и информацию о них, а также создавать, изменять, запускать, останавливать и удалять кластеры {{ k8s }};
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к кластерам {{ k8s }} и изменять такие права доступа;
* просматривать список [групп узлов](../managed-kubernetes/concepts/index.md#node-group) кластеров {{ k8s }} и информацию о таких группах узлов, а также создавать, изменять и удалять группы узлов кластеров {{ k8s }};
* просматривать и изменять настройки взаимодействия кластеров {{ k8s }} с {{ marketplace-name }};
* просматривать информацию о приложениях из {{ marketplace-name }}, а также устанавливать, обновлять и удалять такие приложения;
* просматривать информацию о назначенных правах доступа к приложениям из {{ marketplace-name }} и изменять такие права доступа;
* просматривать статистику использования ресурсов и информацию о [квотах](../managed-kubernetes/concepts/limits.md#managed-k8s-quotas) сервиса {{ managed-k8s-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `k8s.editor`.

#### k8s.cluster-api.viewer {#k8s-cluster-api-viewer}

Пользователь с ролью `k8s.cluster-api.viewer` получает группу `yc:viewer` и роль `view` в {{ k8s }} RBAC для всех пространств имен в кластере.

#### k8s.cluster-api.editor {#k8s-cluster-api-editor}

Пользователь с ролью `k8s.cluster-api.editor` получает группу `yc:editor` и роль `edit` в {{ k8s }} RBAC для всех пространств имен в кластере.

#### k8s.cluster-api.admin {#k8s-cluster-api-admin}

Пользователь с ролью `k8s.cluster-api.admin` получает группу `yc:k8s-core-admin` и роль `admin` в {{ k8s }} RBAC.

#### k8s.cluster-api.cluster-admin {#k8s-cluster-api-cluster-admin}

Пользователь с ролью `k8s.cluster-api.cluster-admin` получает группу `yc:admin` и роль `cluster-admin` в {{ k8s }} RBAC.

#### k8s.tunnelClusters.agent {#k8s-tunnelclusters-agent}

`k8s.tunnelClusters.agent` — специальная роль для создания [кластера {{ k8s }}](../managed-kubernetes/concepts/index.md#kubernetes-cluster) с туннельным режимом. Дает право на создание [групп узлов](../managed-kubernetes/concepts/index.md#node-group), дисков, внутренних балансировщиков. Позволяет использовать заранее созданные [ключи](../kms/concepts/key.md) {{ kms-full-name }} для шифрования и расшифрования секретов.

Включает разрешения, предоставляемые ролями `compute.admin`, `iam.serviceAccounts.user`, `k8s.viewer`, `kms.keys.encrypterDecrypter` и `load-balancer.privateAdmin`.

#### k8s.clusters.agent {#k8s-clusters-agent}

`k8s.clusters.agent` — специальная роль для сервисного аккаунта [кластера {{ k8s }}](../managed-kubernetes/concepts/index.md#kubernetes-cluster). Дает право на создание [групп узлов](../managed-kubernetes/concepts/index.md#node-group), дисков, внутренних балансировщиков. Позволяет использовать заранее созданные [ключи](../kms/concepts/key.md) {{ kms-full-name }} для шифрования и расшифрования секретов, а также подключать заранее созданные [группы безопасности](../vpc/concepts/security-groups.md). В комбинации с [ролью](../network-load-balancer/security/index.md#load-balancer-admin) `load-balancer.admin` позволяет создать [сетевой балансировщик нагрузки](../network-load-balancer/concepts/index.md) с публичным IP-адресом.

Включает разрешения, предоставляемые ролями `k8s.tunnelClusters.agent` и `vpc.privateAdmin`.

Подробнее см. [{#T}](../managed-kubernetes/security/index.md).


## {{ mmy-full-name }} {#managed-mysql-roles}

#### managed-mysql.clusters.connector {#managed-mysql-clusters-connector}

Роль `managed-mysql.clusters.connector` позволяет [пользователям](concepts/users/accounts.md) {{ yandex-cloud }} подключаться к базам данных в [кластерах {{ MY }}](../managed-mysql/concepts/index.md) с помощью механизмов сервиса [{{ iam-full-name }}](index.md).

#### managed-mysql.auditor {#managed-mysql-auditor}

Роль `managed-mysql.auditor` позволяет просматривать информацию о [кластерах {{ MY }}](../managed-mysql/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о [хостах](../managed-mysql/concepts/instance-types.md) и [резервных копиях](../managed-mysql/concepts/backup.md) кластеров, а также о [квотах](../managed-mysql/concepts/limits.md#mmy-quotas) и операциях с ресурсами сервиса {{ mmy-name }}.

#### managed-mysql.viewer {#managed-mysql-viewer}

Роль `managed-mysql.viewer` позволяет просматривать информацию о кластерах, хостах, базах данных и пользователях {{ MY }}, логи работы кластеров, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах](../managed-mysql/concepts/index.md) {{ MY }} и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-mysql/concepts/maintenance.md) кластеров {{ MY }};
* просматривать информацию о [хостах](../managed-mysql/concepts/instance-types.md) кластеров {{ MY }};
* просматривать информацию о базах данных {{ MY }};
* просматривать информацию о [пользователях](../managed-mysql/concepts/user-rights.md) {{ MY }};
* просматривать информацию о [резервных копиях](../managed-mysql/concepts/backup.md) кластеров {{ MY }};
* просматривать информацию об алертах {{ MY }};
* просматривать логи работы кластеров {{ MY }};
* просматривать информацию о результатах диагностики производительности кластеров {{ MY }};
* просматривать информацию о [квотах](../managed-mysql/concepts/limits.md#mmy-quotas) сервиса {{ mmy-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mmy-name }}.

Включает разрешения, предоставляемые ролями `managed-mysql.auditor` и `managed-mysql.maintenanceTask.viewer`.

#### managed-mysql.restorer {#managed-mysql-restorer}

Роль `managed-mysql.restorer` позволяет восстанавливать кластеры {{ MY }} из резервных копий, просматривать информацию о кластерах, хостах, базах данных и пользователях {{ MY }}, логи работы кластеров, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о резервных копиях [кластеров](../managed-mysql/concepts/index.md) {{ MY }} и восстанавливать кластеры из [резервных копий](../managed-mysql/concepts/backup.md);
* просматривать информацию о кластерах {{ MY }} и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-mysql/concepts/maintenance.md) кластеров {{ MY }};
* просматривать информацию о [хостах](../managed-mysql/concepts/instance-types.md) кластеров {{ MY }};
* просматривать информацию о базах данных {{ MY }};
* просматривать информацию о [пользователях](../managed-mysql/concepts/user-rights.md) {{ MY }};
* просматривать информацию об алертах {{ MY }};
* просматривать логи работы кластеров {{ MY }};
* просматривать информацию о результатах диагностики производительности кластеров {{ MY }};
* просматривать информацию о [квотах](../managed-mysql/concepts/limits.md#mmy-quotas) сервиса {{ mmy-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mmy-name }}.

Включает разрешения, предоставляемые ролью `managed-mysql.viewer`.

#### managed-mysql.user {#managed-mysql-user}

Роль `managed-mysql.user` позволяет использовать [кластеры {{ MY }}](../managed-mysql/concepts/index.md).

#### managed-mysql.switcher {#managed-mysql-switcher}

Роль `managed-mysql.switcher` позволяет переназначать хост-мастер в кластерах {{ MY }}, просматривать информацию о кластерах, хостах, базах данных и пользователях {{ MY }}, логи работы кластеров, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* переназначать хост-мастер в [кластерах {{ MY }}](../managed-mysql/concepts/index.md);
* просматривать информацию о кластерах {{ MY }} и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-mysql/concepts/maintenance.md) кластеров {{ MY }};
* просматривать информацию о [хостах](../managed-mysql/concepts/instance-types.md) кластеров {{ MY }};
* просматривать информацию о базах данных {{ MY }};
* просматривать информацию о [пользователях](../managed-mysql/concepts/user-rights.md) {{ MY }};
* просматривать информацию о [резервных копиях](../managed-mysql/concepts/backup.md) кластеров {{ MY }};
* просматривать информацию об алертах {{ MY }};
* просматривать логи работы кластеров {{ MY }};
* просматривать информацию о результатах диагностики производительности кластеров {{ MY }};
* просматривать информацию о [квотах](../managed-mysql/concepts/limits.md#mmy-quotas) сервиса {{ mmy-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mmy-name }}.

Включает разрешения, предоставляемые ролью `managed-mysql.viewer`.

#### managed-mysql.editor {#managed-mysql-editor}

Роль `managed-mysql.editor` позволяет управлять кластерами {{ MY }}.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах](../managed-mysql/concepts/index.md) {{ MY }}, а также создавать, использовать, изменять, удалять, запускать и останавливать их;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к кластерам {{ MY }};
* просматривать информацию о заданиях на [техническое обслуживание](../managed-mysql/concepts/maintenance.md) кластеров {{ MY }} и изменять такие задания;
* просматривать информацию о [хостах](../managed-mysql/concepts/instance-types.md) кластеров {{ MY }}, а также создавать, изменять и удалять их;
* переназначать хост-мастер в кластерах {{ MY }};
* просматривать информацию о базах данных {{ MY }}, а также создавать, изменять и удалять их;
* просматривать информацию о [пользователях](../managed-mysql/concepts/user-rights.md) {{ MY }}, а также создавать, изменять и удалять их;
* просматривать информацию о [резервных копиях](../managed-mysql/concepts/backup.md) кластеров {{ MY }}, создавать и удалять резервные копии, а также восстанавливать кластеры из резервных копий;
* просматривать информацию об алертах {{ MY }}, а также создавать, изменять и удалять их;
* просматривать логи работы кластеров {{ MY }};
* просматривать информацию о результатах диагностики производительности кластеров {{ MY }};
* просматривать информацию о [квотах](../managed-mysql/concepts/limits.md#mmy-quotas) сервиса {{ mmy-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mmy-name }}.

Включает разрешения, предоставляемые ролями `managed-mysql.viewer`, `managed-mysql.restorer`, `managed-mysql.user`, `managed-mysql.switcher` и `managed-mysql.maintenanceTask.editor`.

Для создания кластеров {{ MY }} дополнительно необходима роль `vpc.user`.

#### managed-mysql.admin {#managed-mysql-admin}

Роль `managed-mysql.admin` позволяет управлять кластерами {{ MY }} и доступом к ним.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к [кластерам {{ MY }}](../managed-mysql/concepts/index.md) и изменять такие права доступа;
* просматривать информацию о кластерах {{ MY }}, а также создавать, использовать, изменять, удалять, запускать и останавливать их;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-mysql/concepts/maintenance.md) кластеров {{ MY }} и изменять такие задания;
* просматривать информацию о [хостах](../managed-mysql/concepts/instance-types.md) кластеров {{ MY }}, а также создавать, изменять и удалять их;
* переназначать хост-мастер в кластерах {{ MY }};
* просматривать информацию о базах данных {{ MY }}, а также создавать, изменять и удалять их;
* просматривать информацию о [пользователях](../managed-mysql/concepts/user-rights.md) {{ MY }}, а также создавать, изменять и удалять их;
* просматривать информацию о [резервных копиях](../managed-mysql/concepts/backup.md) кластеров {{ MY }}, создавать и удалять резервные копии, а также восстанавливать кластеры из резервных копий;
* просматривать информацию об алертах {{ MY }}, а также создавать, изменять и удалять их;
* просматривать логи работы кластеров {{ MY }};
* просматривать информацию о результатах диагностики производительности кластеров {{ MY }};
* просматривать информацию о [квотах](../managed-mysql/concepts/limits.md#mmy-quotas) сервиса {{ mmy-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mmy-name }}.

Включает разрешения, предоставляемые ролью `managed-mysql.editor`.

Для создания кластеров {{ MY }} дополнительно необходима роль `vpc.user`.

#### managed-mysql.maintenanceTask.viewer {#managed-mysql-maintenanceTask-viewer}

Роль `managed-mysql.maintenanceTask.viewer` позволяет просматривать информацию о заданиях на [техническое обслуживание](../managed-mysql/concepts/maintenance.md) кластеров {{ MY }}, а также о таких [кластерах](../managed-mysql/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о [хостах](../managed-mysql/concepts/instance-types.md) и [резервных копиях](../managed-mysql/concepts/backup.md) кластеров, о [квотах](../managed-mysql/concepts/limits.md#mmy-quotas) и операциях с ресурсами сервиса {{ mmy-name }}.

Включает разрешения, предоставляемые ролью `managed-mysql.auditor`.

#### managed-mysql.maintenanceTask.editor {#managed-mysql-maintenanceTask-editor}

Роль `managed-mysql.maintenanceTask.editor` позволяет просматривать информацию о заданиях на [техническое обслуживание](../managed-mysql/concepts/maintenance.md) кластеров {{ MY }} и изменять такие задания, просматривать информацию о [кластерах {{ MY }}](../managed-mysql/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о [хостах](../managed-mysql/concepts/instance-types.md) и [резервных копиях](../managed-mysql/concepts/backup.md) кластеров, а также о [квотах](../managed-mysql/concepts/limits.md#mmy-quotas) и операциях с ресурсами сервиса {{ mmy-name }}.

Включает разрешения, предоставляемые ролью `managed-mysql.maintenanceTask.viewer`.

Подробнее см. [{#T}](../managed-mysql/security/index.md).


## {{ mos-full-name }} {#opensearch-roles}

#### managed-opensearch.auditor {#managed-opensearch-auditor}

Роль `managed-opensearch.auditor` позволяет просматривать информацию о [кластерах {{ OS }}](../managed-opensearch/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также о [квотах](../managed-opensearch/concepts/limits.md#quotas) и операциях с ресурсами сервиса {{ mos-name }}.

#### managed-opensearch.viewer {#managed-opensearch-viewer}

Роль `managed-opensearch.viewer` позволяет просматривать информацию о кластерах {{ OS }} и логи их работы, а также информацию о квотах и операциях с ресурсами сервиса {{ mos-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах {{ OS }}](../managed-opensearch/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-opensearch/concepts/maintenance.md) кластеров {{ OS }};
* просматривать логи работы кластеров {{ OS }};
* просматривать информацию о [квотах](../managed-opensearch/concepts/limits.md#quotas) сервиса {{ mos-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mos-name }}.

Включает разрешения, предоставляемые ролями `managed-opensearch.auditor` и `managed-opensearch.maintenanceTask.viewer`.

#### managed-opensearch.restorer {#managed-opensearch-restorer}

Роль `managed-opensearch.restorer` позволяет восстанавливать кластеры {{ OS }} из резервных копий, просматривать информацию о кластерах {{ OS }}, логи их работы, а также информацию о квотах и операциях с ресурсами сервиса {{ mos-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах {{ OS }}](../managed-opensearch/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* восстанавливать кластеры {{ OS }} из резервных копий;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-opensearch/concepts/maintenance.md) кластеров {{ OS }};
* просматривать логи работы кластеров {{ OS }};
* просматривать информацию о [квотах](../managed-opensearch/concepts/limits.md#quotas) сервиса {{ mos-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mos-name }}.

Включает разрешения, предоставляемые ролью `managed-opensearch.viewer`.

#### managed-opensearch.user {#managed-opensearch-user}

Роль `managed-opensearch.user` позволяет использовать [кластеры {{ OS }}](../managed-opensearch/concepts/index.md).

#### managed-opensearch.editor {#managed-opensearch-editor}

Роль `managed-opensearch.editor` позволяет управлять кластерами {{ OS }}.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах {{ OS }}](../managed-opensearch/concepts/index.md), а также создавать, использовать, изменять, удалять, запускать и останавливать их;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к кластерам {{ OS }};
* восстанавливать кластеры {{ OS }} из резервных копий;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-opensearch/concepts/maintenance.md) кластеров {{ OS }} и изменять такие задания;
* просматривать логи работы кластеров {{ OS }};
* просматривать информацию о [квотах](../managed-opensearch/concepts/limits.md#quotas) сервиса {{ mos-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mos-name }}.

Включает разрешения, предоставляемые ролями `managed-opensearch.viewer`, `managed-opensearch.user`, `managed-opensearch.restorer` и `managed-opensearch.maintenanceTask.editor`.

Для создания кластеров {{ OS }} дополнительно необходима роль `vpc.user`.

#### managed-opensearch.admin {#managed-opensearch-admin}

Роль `managed-opensearch.admin` позволяет управлять кластерами {{ OS }} и доступом к ним.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к [кластерам {{ OS }}](../managed-opensearch/concepts/index.md) и изменять такие права доступа;
* просматривать информацию о кластерах {{ OS }}, а также создавать, использовать, изменять, удалять, запускать и останавливать их;
* восстанавливать кластеры {{ OS }} из резервных копий;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-opensearch/concepts/maintenance.md) кластеров {{ OS }} и изменять такие задания;
* просматривать логи работы кластеров {{ OS }};
* просматривать информацию о [квотах](../managed-opensearch/concepts/limits.md#quotas) сервиса {{ mos-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mos-name }}.

Включает разрешения, предоставляемые ролью `managed-opensearch.editor`.

Для создания кластеров {{ OS }} дополнительно необходима роль `vpc.user`.

#### managed-opensearch.maintenanceTask.viewer {#managed-opensearch-maintenanceTask-viewer}

Роль `managed-opensearch.maintenanceTask.viewer` позволяет просматривать информацию о [кластерах {{ OS }}](../managed-opensearch/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о заданиях на [техническое обслуживание](../managed-opensearch/concepts/maintenance.md) таких кластеров, а также о [квотах](../managed-opensearch/concepts/limits.md#quotas) и операциях с ресурсами сервиса {{ mos-name }}.

Включает разрешения, предоставляемые ролью `managed-opensearch.auditor`.

#### managed-opensearch.maintenanceTask.editor {#managed-opensearch-maintenanceTask-editor}

Роль `managed-opensearch.maintenanceTask.editor` позволяет просматривать информацию о заданиях на [техническое обслуживание](../managed-opensearch/concepts/maintenance.md) кластеров {{ OS }} и изменять такие задания, просматривать информацию о [кластерах {{ OS }}](../managed-opensearch/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также о [квотах](../managed-opensearch/concepts/limits.md#quotas) и операциях с ресурсами сервиса {{ mos-name }}.

Включает разрешения, предоставляемые ролью `managed-opensearch.maintenanceTask.viewer`.

Подробнее см. [{#T}](../managed-opensearch/security/index.md).


## {{ mpg-full-name }} {#mpg-roles}

#### managed-postgresql.clusters.connector {#managed-postgresql-clusters-connector}

Роль `managed-postgresql.clusters.connector` позволяет [пользователям](concepts/users/accounts.md) {{ yandex-cloud }} подключаться к базам данных в [кластерах {{ PG }}](../managed-postgresql/concepts/index.md) с помощью механизмов сервиса [{{ iam-full-name }}](index.md).

#### managed-postgresql.auditor {#managed-postgresql-auditor}

Роль `managed-postgresql.auditor` позволяет просматривать информацию о [кластерах {{ PG }}](../managed-postgresql/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о [хостах](../managed-postgresql/concepts/instance-types.md) и [резервных копиях](../managed-postgresql/concepts/backup.md) кластеров, а также о [квотах](../managed-postgresql/concepts/limits.md#mpg-quotas) и операциях с ресурсами сервиса {{ mpg-name }}.

#### managed-postgresql.viewer {#managed-postgresql-viewer}

Роль `managed-postgresql.viewer` позволяет просматривать информацию о кластерах, хостах, базах данных и пользователях {{ PG }}, логи работы кластеров, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах](../managed-postgresql/concepts/index.md) {{ PG }} и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-postgresql/concepts/maintenance.md) кластеров {{ PG }};
* просматривать информацию о [хостах](../managed-postgresql/concepts/instance-types.md) кластеров {{ PG }};
* просматривать информацию о базах данных {{ PG }};
* просматривать информацию о [пользователях](../managed-postgresql/concepts/roles.md) {{ PG }};
* просматривать информацию о [резервных копиях](../managed-postgresql/concepts/backup.md) кластеров {{ PG }};
* просматривать информацию об алертах {{ PG }};
* просматривать логи работы кластеров {{ PG }};
* просматривать информацию о результатах диагностики производительности кластеров {{ PG }};
* просматривать информацию о [квотах](../managed-postgresql/concepts/limits.md#mpg-quotas) сервиса {{ mpg-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mpg-name }}.

Включает разрешения, предоставляемые ролями `managed-postgresql.auditor` и `managed-postgresql.maintenanceTask.viewer`.

#### managed-postgresql.restorer {#managed-postgresql-restorer}

Роль `managed-postgresql.restorer` позволяет восстанавливать кластеры {{ PG }} из резервных копий, просматривать информацию о кластерах, хостах, базах данных и пользователях {{ PG }}, логи работы кластеров, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о резервных копиях [кластеров {{ PG }}](../managed-postgresql/concepts/index.md) и восстанавливать кластеры из [резервных копий](../managed-postgresql/concepts/backup.md);
* просматривать информацию о кластерах {{ PG }} и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-postgresql/concepts/maintenance.md) кластеров {{ PG }};
* просматривать информацию о [хостах](../managed-postgresql/concepts/instance-types.md) кластеров {{ PG }};
* просматривать информацию о базах данных {{ PG }};
* просматривать информацию о [пользователях](../managed-postgresql/concepts/roles.md) {{ PG }};
* просматривать информацию об алертах {{ PG }};
* просматривать логи работы кластеров {{ PG }};
* просматривать информацию о результатах диагностики производительности кластеров {{ PG }};
* просматривать информацию о [квотах](../managed-postgresql/concepts/limits.md#mpg-quotas) сервиса {{ mpg-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mpg-name }}.

Включает разрешения, предоставляемые ролью `managed-postgresql.viewer`.

#### managed-postgresql.user {#managed-postgresql-user}

Роль `managed-postgresql.user` позволяет использовать [кластеры {{ PG }}](../managed-postgresql/concepts/index.md).

#### managed-postgresql.switcher {#managed-postgresql-switcher}

Роль `managed-postgresql.switcher` позволяет переназначать хост-мастер в кластерах {{ PG }}, просматривать информацию о кластерах, хостах, базах данных и пользователях {{ PG }}, логи работы кластеров, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* переназначать хост-мастер в [кластерах {{ PG }}](../managed-postgresql/concepts/index.md);
* просматривать информацию о кластерах {{ PG }} и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-postgresql/concepts/maintenance.md) кластеров {{ PG }};
* просматривать информацию о [хостах](../managed-postgresql/concepts/instance-types.md) кластеров {{ PG }};
* просматривать информацию о базах данных {{ PG }};
* просматривать информацию о [пользователях](../managed-postgresql/concepts/roles.md) {{ PG }};
* просматривать информацию о [резервных копиях](../managed-postgresql/concepts/backup.md) кластеров {{ PG }};
* просматривать информацию об алертах {{ PG }};
* просматривать логи работы кластеров {{ PG }};
* просматривать информацию о результатах диагностики производительности кластеров {{ PG }};
* просматривать информацию о [квотах](../managed-postgresql/concepts/limits.md#mpg-quotas) сервиса {{ mpg-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mpg-name }}.

Включает разрешения, предоставляемые ролью `managed-postgresql.viewer`.

#### managed-postgresql.editor {#managed-postgresql-editor}

Роль `managed-postgresql.editor` позволяет управлять кластерами {{ PG }}.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах](../managed-postgresql/concepts/index.md) {{ PG }}, а также создавать, использовать, изменять, удалять, запускать и останавливать их;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к кластерам {{ PG }};
* просматривать информацию о заданиях на [техническое обслуживание](../managed-postgresql/concepts/maintenance.md) кластеров {{ PG }} и изменять такие задания;
* просматривать информацию о [хостах](../managed-postgresql/concepts/instance-types.md) кластеров {{ PG }}, а также создавать, изменять и удалять их;
* переназначать хост-мастер в кластерах {{ PG }};
* просматривать информацию о базах данных {{ PG }}, а также создавать, изменять и удалять их;
* просматривать информацию о [пользователях](../managed-postgresql/concepts/roles.md) {{ PG }}, а также создавать, изменять и удалять их;
* просматривать информацию о [резервных копиях](../managed-postgresql/concepts/backup.md) кластеров {{ PG }}, создавать и удалять резервные копии, а также восстанавливать кластеры из резервных копий;
* просматривать информацию об алертах {{ PG }}, а также создавать, изменять и удалять их;
* просматривать логи работы кластеров {{ PG }};
* просматривать информацию о результатах диагностики производительности кластеров {{ PG }};
* просматривать информацию о [квотах](../managed-postgresql/concepts/limits.md#mpg-quotas) сервиса {{ mpg-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mpg-name }}.

Включает разрешения, предоставляемые ролями `managed-postgresql.viewer`, `managed-postgresql.restorer`, `managed-postgresql.user`, `managed-postgresql.switcher` и `managed-postgresql.maintenanceTask.editor`.

Для создания кластеров {{ PG }} дополнительно необходима роль `vpc.user`.

#### managed-postgresql.admin {#managed-postgresql-admin}

Роль `managed-postgresql.admin` позволяет управлять кластерами {{ PG }} и доступом к ним.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к [кластерам {{ PG }}](../managed-postgresql/concepts/index.md) и изменять такие права доступа;
* просматривать информацию о кластерах {{ PG }}, а также создавать, использовать, изменять, удалять, запускать и останавливать их;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-postgresql/concepts/maintenance.md) кластеров {{ PG }} и изменять такие задания;
* просматривать информацию о [хостах](../managed-postgresql/concepts/instance-types.md) кластеров {{ PG }}, а также создавать, изменять и удалять их;
* переназначать хост-мастер в кластерах {{ PG }};
* просматривать информацию о базах данных {{ PG }}, а также создавать, изменять и удалять их;
* просматривать информацию о [пользователях](../managed-postgresql/concepts/roles.md) {{ PG }}, а также создавать, изменять и удалять их;
* просматривать информацию о [резервных копиях](../managed-postgresql/concepts/backup.md) кластеров {{ PG }}, создавать и удалять резервные копии, а также восстанавливать кластеры из резервных копий;
* просматривать информацию об алертах {{ PG }}, а также создавать, изменять и удалять их;
* просматривать логи работы кластеров {{ PG }};
* просматривать информацию о результатах диагностики производительности кластеров {{ PG }};
* просматривать информацию о [квотах](../managed-postgresql/concepts/limits.md#mpg-quotas) сервиса {{ mpg-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mpg-name }}.

Включает разрешения, предоставляемые ролью `managed-postgresql.editor`.

Для создания кластеров {{ PG }} дополнительно необходима роль `vpc.user`.

#### managed-postgresql.maintenanceTask.viewer {#managed-postgresql-maintenanceTask-viewer}

Роль `managed-postgresql.maintenanceTask.viewer` позволяет просматривать информацию о заданиях на [техническое обслуживание](../managed-postgresql/concepts/maintenance.md) кластеров {{ PG }}, а также о таких [кластерах](../managed-postgresql/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о [хостах](../managed-postgresql/concepts/instance-types.md) и [резервных копиях](../managed-postgresql/concepts/backup.md), о [квотах](../managed-postgresql/concepts/limits.md#mpg-quotas) и операциях с ресурсами сервиса {{ mpg-name }}.

Включает разрешения, предоставляемые ролью `managed-postgresql.auditor`.

#### managed-postgresql.maintenanceTask.editor {#managed-postgresql-maintenanceTask-editor}

Роль `managed-postgresql.maintenanceTask.editor` позволяет просматривать информацию о заданиях на [техническое обслуживание](../managed-postgresql/concepts/maintenance.md) кластеров {{ PG }} и изменять такие задания, просматривать информацию о [кластерах {{ PG }}](../managed-postgresql/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о [хостах](../managed-postgresql/concepts/instance-types.md) и [резервных копиях](../managed-postgresql/concepts/backup.md) кластеров, а также о [квотах](../managed-postgresql/concepts/limits.md#mpg-quotas) и операциях с ресурсами сервиса {{ mpg-name }}.

Включает разрешения, предоставляемые ролью `managed-postgresql.maintenanceTask.viewer`.

Подробнее см. [{#T}](../managed-postgresql/security/index.md).


## {{ mspqr-full-name }} {#mspqr-roles}

#### managed-spqr.auditor {#managed-spqr-auditor}

Роль `managed-spqr.auditor` позволяет просматривать информацию о [хостах](../managed-spqr/concepts/instance-types.md) и [кластерах](../managed-spqr/concepts/index.md) {{ SPQR }}, назначенных [правах доступа](concepts/access-control/index.md) к кластерам, а также о [квотах](../managed-spqr/concepts/limits.md#mspqr-quotas) и операциях с ресурсами сервиса {{ mspqr-name }}.

#### managed-spqr.viewer {#managed-spqr-viewer}

Роль `managed-spqr.viewer` позволяет просматривать информацию о кластерах, хостах, базах данных и пользователях в кластерах {{ SPQR }}, логи работы кластеров, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах](../managed-spqr/concepts/index.md) {{ SPQR }} и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на техническое обслуживание кластеров {{ SPQR }};
* просматривать информацию о [хостах](../managed-spqr/concepts/instance-types.md) кластеров {{ SPQR }};
* просматривать информацию о базах данных в кластерах {{ SPQR }};
* просматривать информацию о пользователях в кластерах {{ SPQR }};
* просматривать информацию о резервных копиях кластеров {{ SPQR }};
* просматривать логи работы кластеров {{ SPQR }};
* просматривать информацию о [квотах](../managed-spqr/concepts/limits.md#mspqr-quotas) сервиса {{ mspqr-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mspqr-name }}.

Включает разрешения, предоставляемые ролями `managed-spqr.auditor` и `managed-spqr.maintenanceTask.viewer`.

#### managed-spqr.restorer {#managed-spqr-restorer}

Роль `managed-spqr.restorer` позволяет восстанавливать кластеры {{ SPQR }} из резервных копий, а также просматривать информацию о кластерах, хостах, базах данных и пользователях в кластерах {{ SPQR }}, логи работы кластеров, данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о резервных копиях [кластеров](../managed-spqr/concepts/index.md) {{ SPQR }}, а также восстанавливать кластеры из резервных копий;
* просматривать информацию о кластерах {{ SPQR }} и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на техническое обслуживание кластеров {{ SPQR }};
* просматривать информацию о [хостах](../managed-spqr/concepts/instance-types.md) кластеров {{ SPQR }};
* просматривать информацию о базах данных в кластерах {{ SPQR }};
* просматривать информацию о пользователях в кластерах {{ SPQR }};
* просматривать логи работы кластеров {{ SPQR }};
* просматривать информацию о [квотах](../managed-spqr/concepts/limits.md#mspqr-quotas) сервиса {{ mspqr-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mspqr-name }}.

Включает разрешения, предоставляемые ролью `managed-spqr.viewer`.

#### managed-spqr.editor {#managed-spqr-editor}

Роль `managed-spqr.editor` позволяет управлять кластерами {{ SPQR }}.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах](../managed-spqr/concepts/index.md) {{ SPQR }} и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* создавать, изменять, удалять, запускать и останавливать кластеры {{ SPQR }};
* просматривать информацию о заданиях на техническое обслуживание кластеров {{ SPQR }} и изменять такие задания;
* просматривать информацию о [хостах](../managed-spqr/concepts/instance-types.md) кластеров {{ SPQR }}, а также создавать, изменять и удалять такие хосты;
* просматривать информацию о базах данных в кластерах {{ SPQR }}, а также создавать, изменять и удалять такие базы данных;
* просматривать информацию о пользователях в кластерах {{ SPQR }}, а также создавать, изменять и удалять таких пользователей;
* просматривать информацию о резервных копиях кластеров {{ SPQR }}, создавать и удалять резервные копии, а также восстанавливать кластеры из резервных копий;
* просматривать логи работы кластеров {{ SPQR }};
* просматривать информацию о [квотах](../managed-spqr/concepts/limits.md#mspqr-quotas) сервиса {{ mspqr-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mspqr-name }}.

Включает разрешения, предоставляемые ролями `managed-spqr.viewer`, `managed-spqr.restorer` и `managed-spqr.maintenanceTask.editor`.

#### managed-spqr.admin {#managed-spqr-admin}

Роль `managed-spqr.admin` позволяет управлять кластерами {{ SPQR }} и доступом к ним.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к [кластерам {{ SPQR }}](../managed-spqr/concepts/index.md) и изменять такие права доступа;
* просматривать информацию о кластерах {{ SPQR }}, а также создавать, изменять, удалять, запускать и останавливать их;
* просматривать информацию о заданиях на техническое обслуживание кластеров {{ SPQR }} и изменять такие задания;
* просматривать информацию о [хостах](../managed-spqr/concepts/instance-types.md) кластеров {{ SPQR }}, а также создавать, изменять и удалять такие хосты;
* просматривать информацию о базах данных в кластерах {{ SPQR }}, а также создавать, изменять и удалять такие базы данных;
* просматривать информацию о пользователях в кластерах {{ SPQR }}, а также создавать, изменять и удалять таких пользователей;
* просматривать информацию о резервных копиях кластеров {{ SPQR }}, создавать и удалять резервные копии, а также восстанавливать кластеры из резервных копий;
* просматривать логи работы кластеров {{ SPQR }};
* просматривать информацию о [квотах](../managed-spqr/concepts/limits.md#mspqr-quotas) сервиса {{ mspqr-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mspqr-name }}.

Включает разрешения, предоставляемые ролью `managed-spqr.editor`.

#### managed-spqr.maintenanceTask.viewer {#managed-spqr-maintenanceTask-viewer}

Роль `managed-spqr.maintenanceTask.viewer` позволяет просматривать информацию о заданиях на техническое обслуживание кластеров {{ SPQR }}, а также о таких [кластерах](../managed-spqr/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о [хостах](../managed-spqr/concepts/instance-types.md) кластеров, [квотах](../managed-spqr/concepts/limits.md#mspqr-quotas) и операциях с ресурсами сервиса {{ mspqr-name }}.

Включает разрешения, предоставляемые ролью `managed-spqr.auditor`.

#### managed-spqr.maintenanceTask.editor {#managed-spqr-maintenanceTask-editor}

Роль `managed-spqr.maintenanceTask.editor` позволяет просматривать информацию о заданиях на техническое обслуживание [кластеров {{ SPQR }}](../managed-spqr/concepts/index.md) и изменять такие задания, просматривать информацию о кластерах {{ SPQR }} и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также о [хостах](../managed-spqr/concepts/instance-types.md) кластеров, [квотах](../managed-spqr/concepts/limits.md#mspqr-quotas) и операциях с ресурсами сервиса {{ mspqr-name }}.

Включает разрешения, предоставляемые ролью `managed-spqr.maintenanceTask.viewer`.

Подробнее см. [{#T}](../managed-spqr/security.md).


## {{ mrd-full-name }} {#mrd-roles}

#### managed-redis.clusters.connector {#managed-redis-clusters-connector}

Роль `managed-redis.clusters.connector` позволяет [пользователям](concepts/users/accounts.md) {{ yandex-cloud }} подключаться к базам данных в [кластерах {{ VLK }}](../managed-valkey/concepts/index.md) с помощью механизмов сервиса [{{ iam-full-name }}](index.md).

#### managed-redis.auditor {#managed-redis-auditor}

Роль `managed-redis.auditor` позволяет просматривать информацию о [кластерах](../managed-valkey/concepts/index.md) {{ VLK }} и назначенных [правах доступа](concepts/access-control/index.md) к ним, о [хостах](../managed-valkey/concepts/instance-types.md) и [резервных копиях](../managed-valkey/concepts/backup.md) кластеров, а также о [квотах](../managed-valkey/concepts/limits.md#mrd-quotas) и операциях с ресурсами сервиса {{ mrd-full-name }}.

#### managed-redis.viewer {#managed-redis-viewer}

Роль `managed-redis.viewer` позволяет просматривать информацию о хостах и кластерах {{ VLK }}, логи их работы, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах](../managed-valkey/concepts/index.md) {{ VLK }} и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-valkey/concepts/maintenance.md) кластеров {{ VLK }};
* просматривать информацию о [хостах](../managed-valkey/concepts/instance-types.md) кластеров {{ VLK }};
* просматривать информацию о [шардах](../managed-valkey/concepts/sharding.md) кластеров {{ VLK }};
* просматривать [информацию](../managed-valkey/operations/user-list.md) о пользователях {{ VLK }};
* просматривать информацию о [резервных копиях](../managed-valkey/concepts/backup.md) кластеров {{ VLK }};
* просматривать информацию об алертах {{ VLK }};
* просматривать логи работы кластеров {{ VLK }};
* просматривать информацию о [квотах](../managed-valkey/concepts/limits.md#mrd-quotas) сервиса {{ mrd-full-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mrd-full-name }}.

Включает разрешения, предоставляемые ролями `managed-redis.auditor` и `managed-redis.maintenanceTask.viewer`.

#### managed-redis.restorer {#managed-redis-restorer}

Роль `managed-redis.restorer` позволяет восстанавливать кластеры {{ VLK }} из резервных копий, а также просматривать информацию о хостах и кластерах {{ VLK }}, логи их работы, данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о [резервных копиях](../managed-valkey/concepts/backup.md) кластеров {{ VLK }}, а также восстанавливать [кластеры](../managed-valkey/concepts/index.md) из резервных копий;
* просматривать информацию о кластерах {{ VLK }} и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-valkey/concepts/maintenance.md) кластеров {{ VLK }};
* просматривать информацию о [хостах](../managed-valkey/concepts/instance-types.md) кластеров {{ VLK }};
* просматривать информацию о [шардах](../managed-valkey/concepts/sharding.md) кластеров {{ VLK }};
* просматривать [информацию](../managed-valkey/operations/user-list.md) о пользователях {{ VLK }};
* просматривать информацию об алертах {{ VLK }};
* просматривать логи работы кластеров {{ VLK }};
* просматривать информацию о [квотах](../managed-valkey/concepts/limits.md#mrd-quotas) сервиса {{ mrd-full-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mrd-full-name }}.

Включает разрешения, предоставляемые ролью `managed-redis.viewer`.

#### managed-redis.user {#managed-redis-user}

Роль `managed-redis.user` позволяет использовать [кластеры {{ VLK }}](../managed-valkey/concepts/index.md).

#### managed-redis.switcher {#managed-redis-switcher}

Роль `managed-redis.switcher` позволяет переназначать хост-мастер в кластерах {{ VLK }}, просматривать информацию о хостах и кластерах {{ VLK }}, логи их работы, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* переназначать хост-мастер в [кластерах {{ VLK }}](../managed-valkey/concepts/index.md);
* просматривать информацию о кластерах {{ VLK }} и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-valkey/concepts/maintenance.md) кластеров {{ VLK }};
* просматривать информацию о [хостах](../managed-valkey/concepts/instance-types.md) кластеров {{ VLK }};
* просматривать информацию о [шардах](../managed-valkey/concepts/sharding.md) кластеров {{ VLK }};
* просматривать [информацию](../managed-valkey/operations/user-list.md) о пользователях {{ VLK }};
* просматривать информацию о [резервных копиях](../managed-valkey/concepts/backup.md) кластеров {{ VLK }};
* просматривать информацию об алертах {{ VLK }};
* просматривать логи работы кластеров {{ VLK }};
* просматривать информацию о [квотах](../managed-valkey/concepts/limits.md#mrd-quotas) сервиса {{ mrd-full-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mrd-full-name }}.

Включает разрешения, предоставляемые ролью `managed-redis.viewer`.

#### managed-redis.editor {#managed-redis-editor}

Роль `managed-redis.editor` позволяет управлять кластерами {{ VLK }}.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах](../managed-valkey/concepts/index.md) {{ VLK }}, а также создавать, использовать, изменять, удалять, запускать и останавливать их;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к кластерам {{ VLK }};
* просматривать информацию о заданиях на [техническое обслуживание](../managed-valkey/concepts/maintenance.md) кластеров {{ VLK }} и изменять такие задания;
* просматривать информацию о [хостах](../managed-valkey/concepts/instance-types.md) кластеров {{ VLK }}, а также создавать, изменять и удалять их;
* переназначать хост-мастер в кластерах {{ VLK }};
* просматривать информацию о [шардах](../managed-valkey/concepts/sharding.md) кластеров {{ VLK }}, а также создавать и удалять их;
* просматривать [информацию](../managed-valkey/operations/user-list.md) о пользователях {{ VLK }}, а также создавать, изменять и удалять таких пользователей;
* просматривать информацию о [резервных копиях](../managed-valkey/concepts/backup.md) кластеров {{ VLK }}, создавать резервные копии и восстанавливать кластеры из резервных копий;
* просматривать информацию об алертах {{ VLK }}, а также создавать, изменять и удалять их;
* просматривать логи работы кластеров {{ VLK }};
* просматривать информацию о [квотах](../managed-valkey/concepts/limits.md#mrd-quotas) сервиса {{ mrd-full-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mrd-full-name }}.

Включает разрешения, предоставляемые ролями `managed-redis.viewer`, `managed-redis.restorer`, `managed-redis.user`, `managed-redis.switcher` и `managed-redis.maintenanceTask.editor`.

Для создания кластеров {{ VLK }} дополнительно необходима роль `vpc.user`.

#### managed-redis.admin {#managed-redis-admin}

Роль `managed-redis.admin` позволяет управлять кластерами {{ VLK }} и доступом к ним.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к [кластерам](../managed-valkey/concepts/index.md) {{ VLK }} и изменять такие права доступа;
* просматривать информацию о кластерах {{ VLK }}, а также создавать, использовать, изменять, удалять, запускать и останавливать их;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-valkey/concepts/maintenance.md) кластеров {{ VLK }} и изменять такие задания;
* просматривать информацию о [хостах](../managed-valkey/concepts/instance-types.md) кластеров {{ VLK }}, а также создавать, изменять и удалять их;
* переназначать хост-мастер в кластерах {{ VLK }};
* просматривать информацию о [шардах](../managed-valkey/concepts/sharding.md) кластеров {{ VLK }}, а также создавать и удалять их;
* просматривать [информацию](../managed-valkey/operations/user-list.md) о пользователях {{ VLK }}, а также создавать, изменять и удалять таких пользователей;
* просматривать информацию о [резервных копиях](../managed-valkey/concepts/backup.md) кластеров {{ VLK }}, создавать резервные копии и восстанавливать кластеры из резервных копий;
* просматривать информацию об алертах {{ VLK }}, а также создавать, изменять и удалять их;
* просматривать логи работы кластеров {{ VLK }};
* просматривать информацию о [квотах](../managed-valkey/concepts/limits.md#mrd-quotas) сервиса {{ mrd-full-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mrd-full-name }}.

Включает разрешения, предоставляемые ролью `managed-redis.editor`.

Для создания кластеров {{ VLK }} дополнительно необходима роль `vpc.user`.

#### managed-redis.maintenanceTask.viewer {#managed-redis-maintenanceTask-viewer}

Роль `managed-redis.maintenanceTask.viewer` позволяет просматривать информацию о заданиях на [техническое обслуживание](../managed-valkey/concepts/maintenance.md) кластеров {{ VLK }}, а также о таких [кластерах](../managed-valkey/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о [хостах](../managed-valkey/concepts/instance-types.md) и [резервных копиях](../managed-valkey/concepts/backup.md) кластеров, о [квотах](../managed-valkey/concepts/limits.md#mrd-quotas) и операциях с ресурсами сервиса {{ mrd-full-name }}.

Включает разрешения, предоставляемые ролью `managed-redis.auditor`.

#### managed-redis.maintenanceTask.editor {#managed-redis-maintenanceTask-editor}

Роль `managed-redis.maintenanceTask.editor` позволяет просматривать информацию о заданиях на [техническое обслуживание](../managed-valkey/concepts/maintenance.md) кластеров {{ VLK }} и изменять такие задания, просматривать информацию о [кластерах](../managed-valkey/concepts/index.md) {{ VLK }} и назначенных [правах доступа](concepts/access-control/index.md) к ним, о [хостах](../managed-valkey/concepts/instance-types.md) и [резервных копиях](../managed-valkey/concepts/backup.md) кластеров, а также о [квотах](../managed-valkey/concepts/limits.md#mrd-quotas) и операциях с ресурсами сервиса {{ mrd-full-name }}.

Включает разрешения, предоставляемые ролью `managed-redis.maintenanceTask.viewer`.

Подробнее см. [{#T}](../managed-valkey/security/index.md).


## {{ mms-full-name }} {#mms-roles}

#### managed-sqlserver.auditor {#managed-sqlserver-auditor}

Роль `managed-sqlserver.auditor` позволяет просматривать информацию кластерах, хостах, пользователях, базах данных, резервных копиях кластеров SQL Server, а также о квотах и операциях с ресурсами сервиса Managed Service for SQL Server.

#### managed-sqlserver.viewer {#managed-sqlserver-viewer}

Роль `managed-sqlserver.viewer` позволяет просматривать логи кластеров SQL Server, а также информацию о кластерах, хостах, пользователях, базах данных и резервных копиях БД SQL Server.

Пользователи с этой ролью могут:
* просматривать информацию о кластерах SQL Server;
* просматривать информацию о хостах кластеров SQL Server;
* просматривать информацию о пользователях SQL Server;
* просматривать информацию о базах данных SQL Server;
* просматривать информацию о резервных копиях кластеров SQL Server;
* просматривать логи кластеров SQL Server;
* просматривать информацию об операциях с ресурсами сервиса Managed Service for SQL Server;
* просматривать информацию о квотах сервиса Managed Service for SQL Server.

Включает разрешения, предоставляемые ролью `managed-sqlserver.auditor`.

#### managed-sqlserver.restorer {#managed-sqlserver-restorer}

Роль `managed-sqlserver.restorer` позволяет восстанавливать кластеры SQL Server из резервных копий, а также просматривать логи кластеров SQL Server, информацию о кластерах, хостах, пользователях, базах данных и резервных копиях кластеров SQL Server.

Пользователи с этой ролью могут:
* восстанавливать кластеры SQL Server из резервных копий;
* просматривать информацию о кластерах SQL Server;
* просматривать информацию о хостах кластеров SQL Server;
* просматривать информацию о пользователях SQL Server;
* просматривать информацию о базах данных SQL Server;
* просматривать информацию о резервных копиях баз данных SQL Server;
* просматривать логи кластеров SQL Server;
* просматривать информацию об операциях с ресурсами сервиса Managed Service for SQL Server;
* просматривать информацию о квотах сервиса Managed Service for SQL Server.

Включает разрешения, предоставляемые ролью `managed-sqlserver.viewer`.

#### managed-sqlserver.editor {#managed-sqlserver-editor}

Роль `managed-sqlserver.editor` позволяет управлять кластерами, хостами, пользователями и базами данных SQL Server, создавать резервные копии кластеров и восстанавливать кластеры из резервных копий, а также просматривать логи кластеров SQL Server.

Пользователи с этой ролью могут:
* просматривать информацию о кластерах SQL Server, а также использовать такие кластеры, создавать, запускать, останавливать, изменять и удалять их;
* просматривать информацию о хостах кластеров SQL Server, а также создавать, изменять и удалять такие хосты;
* просматривать информацию о пользователях SQL Server, а также создавать, изменять и удалять их;
* просматривать информацию о базах данных SQL Server, а также создавать, изменять и удалять их;
* просматривать информацию о резервных копиях кластеров SQL Server, создавать резервные копии и восстанавливать кластеры из резервных копий;
* просматривать логи кластеров SQL Server;
* просматривать информацию об операциях с ресурсами сервиса Managed Service for SQL Server;
* просматривать информацию о квотах сервиса Managed Service for SQL Server.

Включает разрешения, предоставляемые ролями `managed-sqlserver.viewer` и `managed-sqlserver.restorer`.

#### managed-sqlserver.admin {#managed-sqlserver-admin}

Роль `managed-sqlserver.admin` позволяет управлять кластерами, хостами, пользователями и базами данных SQL Server, создавать резервные копии кластеров и восстанавливать кластеры из резервных копий, а также просматривать логи кластеров SQL Server.

Пользователи с этой ролью могут:
* просматривать информацию о кластерах SQL Server, а также использовать такие кластеры, создавать, запускать, останавливать, изменять и удалять их;
* просматривать информацию о хостах кластеров SQL Server, а также создавать, изменять и удалять такие хосты;
* просматривать информацию о пользователях SQL Server, а также создавать, изменять и удалять их;
* просматривать информацию о базах данных SQL Server, а также создавать, изменять и удалять их;
* просматривать информацию о резервных копиях кластеров SQL Server, создавать резервные копии, а также восстанавливать кластеры из резервных копий;
* просматривать логи кластеров SQL Server;
* просматривать информацию об операциях с ресурсами сервиса Managed Service for SQL Server;
* просматривать информацию о квотах сервиса Managed Service for SQL Server.

Включает разрешения, предоставляемые ролью `managed-sqlserver.editor`.


## {{ mtr-full-name }} {#mtr-roles}

#### managed-trino.auditor {#managed-trino-auditor}

Роль `managed-trino.auditor` позволяет просматривать информацию о [кластерах {{ TR }}](../managed-trino/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также о [квотах](../managed-trino/concepts/limits.md#quotas) сервиса {{ mtr-name }}.

#### managed-trino.viewer {#managed-trino-viewer}

Роль `managed-trino.viewer` позволяет просматривать информацию о кластерах {{ TR }} и квотах сервиса {{ mtr-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах {{ TR }}](../managed-trino/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-trino/concepts/maintenance.md) кластеров {{ TR }};
* просматривать информацию о [квотах](../managed-trino/concepts/limits.md#quotas) сервиса {{ mtr-name }}.

Включает разрешения, предоставляемые ролями `managed-trino.auditor` и `managed-trino.maintenanceTask.viewer`.

#### managed-trino.user {#managed-trino-user}

Роль `managed-trino.user` позволяет выполнять базовые операции с кластерами {{ TR }}.

Пользователи с этой ролью могут:
* использовать веб-интерфейс {{ TR }};
* отправлять запросы к API {{ TR }};
* просматривать информацию о [кластерах {{ TR }}](../managed-trino/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-trino/concepts/maintenance.md) кластеров {{ TR }};
* просматривать информацию о [квотах](../managed-trino/concepts/limits.md#quotas) сервиса {{ mtr-name }}.

Включает разрешения, предоставляемые ролью `managed-trino.viewer`.

#### managed-trino.editor {#managed-trino-editor}

Роль `managed-trino.editor` позволяет управлять кластерами {{ TR }}.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах {{ TR }}](../managed-trino/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* создавать, изменять, запускать, останавливать и удалять кластеры {{ TR }};
* просматривать информацию о заданиях на [техническое обслуживание](../managed-trino/concepts/maintenance.md) кластеров {{ TR }} и изменять такие задания;
* использовать веб-интерфейс {{ TR }};
* отправлять запросы к API {{ TR }};
* просматривать информацию о [квотах](../managed-trino/concepts/limits.md#quotas) сервиса {{ mtr-name }}.

Включает разрешения, предоставляемые ролями `managed-trino.user` и `managed-trino.maintenanceTask.editor`.

Для создания кластеров {{ TR }} дополнительно необходима роль `vpc.user`.

#### managed-trino.admin {#managed-trino-admin}

Роль `managed-trino.admin` позволяет управлять кластерами {{ TR }} и доступом к ним.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к [кластерам {{ TR }}](../managed-trino/concepts/index.md) и изменять такие права доступа;
* просматривать информацию о кластерах {{ TR }}, а также создавать, изменять, запускать, останавливать и удалять их;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-trino/concepts/maintenance.md) кластеров {{ TR }} и изменять такие задания;
* использовать веб-интерфейс {{ TR }};
* отправлять запросы к API {{ TR }};
* просматривать информацию о [квотах](../managed-trino/concepts/limits.md#quotas) сервиса {{ mtr-name }}.

Включает разрешения, предоставляемые ролью `managed-trino.editor`.

Для создания кластеров {{ TR }} дополнительно необходима роль `vpc.user`.

#### managed-trino.maintenanceTask.viewer {#managed-trino-maintenanceTask-viewer}

Роль `managed-trino.maintenanceTask.viewer` позволяет просматривать информацию о [кластерах {{ TR }}](../managed-trino/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также о заданиях на [техническое обслуживание](../managed-trino/concepts/maintenance.md) таких кластеров и [квотах](../managed-trino/concepts/limits.md#quotas) сервиса {{ mtr-name }}.

Включает разрешения, предоставляемые ролью `managed-trino.auditor`.

#### managed-trino.maintenanceTask.editor {#managed-trino-maintenanceTask-editor}

Роль `managed-trino.maintenanceTask.editor` позволяет просматривать информацию о заданиях на [техническое обслуживание](../managed-trino/concepts/maintenance.md) кластеров {{ TR }} и изменять такие задания, просматривать информацию о [кластерах {{ TR }}](../managed-trino/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также о [квотах](../managed-trino/concepts/limits.md#quotas) сервиса {{ mtr-name }}.

Включает разрешения, предоставляемые ролью `managed-trino.maintenanceTask.viewer`.

#### managed-trino.integrationProvider {#managed-trino-integrationProvider}

Роль `managed-trino.integrationProvider` позволяет кластеру {{ TR }} взаимодействовать от имени сервисного аккаунта с пользовательскими ресурсами, необходимыми для работы кластера. Роль назначается сервисному аккаунту, привязанному к кластеру {{ TR }}.

Пользователи с этой ролью могут:
* добавлять записи в [лог-группы](../logging/concepts/log-group.md);
* просматривать информацию о лог-группах;
* просматривать информацию о приемниках логов;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к ресурсам сервиса {{ cloud-logging-name }};
* просматривать информацию о выгрузках логов;
* просматривать информацию о [метриках](../monitoring/concepts/data-model.md#metric) и их [метках](../monitoring/concepts/data-model.md#label), а также загружать и выгружать метрики;
* просматривать список [дашбордов](../monitoring/concepts/visualization/dashboard.md) и [виджетов](../monitoring/concepts/visualization/widget.md) и информацию о них, а также создавать, изменять и удалять дашборды и виджеты;
* просматривать историю [уведомлений](../monitoring/concepts/alerting/notification-channel.md);
* просматривать информацию о [квотах](../monitoring/concepts/limits.md#monitoring-quotas) сервиса {{ monitoring-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролями `logging.writer` и `monitoring.editor`.

Подробнее см. [{#T}](../managed-trino/security.md).


## {{ myt-full-name }} {#myt-roles}

#### managed-ytsaurus.auditor {#managed-ytsaurus-auditor}

Роль `managed-ytsaurus.auditor` позволяет просматривать информацию о кластерах {{ ytsaurus-name }}, а также данные о [квотах](../managed-ytsaurus/concepts/limits.md#quotas) и операциях с ресурсами сервиса {{ myt-name }}.

#### managed-ytsaurus.viewer {#managed-ytsaurus-viewer}

Роль `managed-ytsaurus.viewer` позволяет просматривать информацию о кластерах {{ ytsaurus-name }}, [квотах](../managed-ytsaurus/concepts/limits.md#quotas) и операциях с ресурсами сервиса {{ myt-name }}.

Включает разрешения, предоставляемые ролью `managed-ytsaurus.auditor`.

#### managed-ytsaurus.user {#managed-ytsaurus-user}

Роль `managed-ytsaurus.user` позволяет выполнять базовые операции с кластерами {{ ytsaurus-name }}.

Пользователи с этой ролью могут:
* использовать веб-интерфейс {{ ytsaurus-name }};
* просматривать информацию о кластерах {{ ytsaurus-name }};
* просматривать информацию о [квотах](../managed-ytsaurus/concepts/limits.md#quotas) сервиса {{ myt-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ myt-name }}.

Включает разрешения, предоставляемые ролью `managed-ytsaurus.viewer`.

#### managed-ytsaurus.editor {#managed-ytsaurus-editor}

Роль `managed-ytsaurus.editor` позволяет управлять кластерами {{ ytsaurus-name }}, а также получать информацию о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о кластерах {{ ytsaurus-name }}, а также создавать, изменять, удалять, запускать и останавливать их;
* просматривать информацию о [квотах](../managed-ytsaurus/concepts/limits.md#quotas) сервиса {{ myt-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ myt-name }};
* использовать веб-интерфейс {{ ytsaurus-name }}.

Включает разрешения, предоставляемые ролью `managed-ytsaurus.user`.

Для создания кластеров {{ ytsaurus-name }} дополнительно необходима роль `vpc.user`.

#### managed-ytsaurus.admin {#managed-ytsaurus-admin}

Роль `managed-ytsaurus.admin` позволяет управлять кластерами {{ ytsaurus-name }}, а также получать информацию о квотах и операциях с ресурсами сервиса {{ myt-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о кластерах {{ ytsaurus-name }}, а также создавать, изменять, запускать, останавливать и удалять их;
* просматривать информацию о [квотах](../managed-ytsaurus/concepts/limits.md#quotas) сервиса {{ myt-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ myt-name }};
* использовать веб-интерфейс {{ ytsaurus-name }}.

Включает разрешения, предоставляемые ролью `managed-ytsaurus.editor`.

Для создания кластеров {{ ytsaurus-name }} дополнительно необходима роль `vpc.user`.

Подробнее см. [{#T}](../managed-ytsaurus/security/index.md).


## {{ ydb-full-name }} {#ydb-roles}

#### ydb.auditor {#ydb-auditor}

Роль `ydb.auditor` позволяет устанавливать соединения c базами данных, просматривать информацию о БД и назначенных правах доступа к ним, а также о схемных объектах и резервных копиях БД.

Пользователи с этой ролью могут:
* устанавливать соединения c [базами данных](../ydb/concepts/resources.md#database);
* просматривать список баз данных и информацию о них, а также о назначенных [правах доступа](concepts/access-control/index.md) к базам данных;
* просматривать информацию о резервных копиях баз данных и назначенных правах доступа к резервным копиям;
* просматривать список схемных объектов БД (таблиц, индексов и каталогов) и информацию о них;
* просматривать информацию о [квотах](../ydb/concepts/limits.md#ydb-quotas) сервиса {{ ydb-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

#### ydb.viewer {#ydb-viewer}

Роль `ydb.viewer` позволяет устанавливать соединения c БД и выполнять запросы на чтение данных, просматривать информацию о БД и назначенных правах доступа к ним, а также о схемных объектах и резервных копиях БД.

Пользователи с этой ролью могут:
* устанавливать соединения c [базами данных](../ydb/concepts/resources.md#database) и выполнять запросы на чтение данных;
* просматривать список баз данных и информацию о них, а также о назначенных [правах доступа](concepts/access-control/index.md) к базам данных;
* просматривать информацию о резервных копиях баз данных и назначенных правах доступа к резервным копиям;
* просматривать список схемных объектов БД (таблиц, индексов и каталогов) и информацию о них;
* просматривать информацию о [квотах](../ydb/concepts/limits.md#ydb-quotas) сервиса {{ ydb-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `ydb.auditor`.

#### ydb.editor {#ydb-editor}

Роль `ydb.editor` позволяет управлять базами данных, схемными объектами и резервными копиями БД, а также выполнять запросы к БД на чтение и запись данных.

Пользователи с этой ролью могут:
* просматривать список [баз данных](../ydb/concepts/resources.md#database) и информацию о них и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также создавать, запускать, останавливать, изменять и удалять базы данных; 
* устанавливать соединения c базами данных и выполнять запросы на чтение и запись данных;
* просматривать информацию о резервных копиях баз данных и назначенных правах доступа к резервным копиям, а также создавать резервные копии, удалять их и восстанавливать базы данных из резервных копий;
* просматривать список схемных объектов БД (таблиц, индексов и каталогов) и информацию о них, а также создавать, изменять и удалять схемные объекты БД;
* просматривать информацию о [квотах](../ydb/concepts/limits.md#ydb-quotas) сервиса {{ ydb-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `ydb.viewer`.

#### ydb.admin {#ydb-admin}

Роль `ydb.admin` позволяет управлять базами данных и доступом к ним, управлять схемными объектами и резервными копиями БД, а также выполнять запросы к БД на чтение и запись данных.

Пользователи с этой ролью могут:
* просматривать список [баз данных](../ydb/concepts/resources.md#database) и информацию о них, а также создавать, запускать, останавливать, изменять и удалять базы данных;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к базам данных и изменять такие права доступа;
* устанавливать соединения c базами данных и выполнять запросы на чтение и запись данных;
* просматривать информацию о резервных копиях баз данных, а также создавать резервные копии, удалять их и восстанавливать базы данных из резервных копий;
* просматривать информацию о назначенных правах доступа к резервным копиям и изменять такие права доступа;
* просматривать список схемных объектов БД (таблиц, индексов и каталогов) и информацию о них, а также создавать, изменять и удалять схемные объекты БД;
* просматривать информацию о [квотах](../ydb/concepts/limits.md#ydb-quotas) сервиса {{ ydb-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `ydb.editor`.

#### ydb.kafkaApi.client {#ydb-kafkaapi-client}

Роль `ydb.kafkaApi.client` позволяет работать с `ydb` по протоколу [Kafka API](https://ydb.tech/docs/ru/reference/kafka-api) с использованием plain-аутентификации через SSL-соединение.

Подробнее см. [{#T}](../ydb/security/index.md).


## {{ mmg-full-name }} {#storedoc-roles}

#### managed-mongodb.auditor {#managed-mongodb-auditor}

Роль `managed-mongodb.auditor` позволяет просматривать информацию о [кластерах {{ SD }}](../storedoc/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о [хостах](../storedoc/concepts/instance-types.md) и [резервных копиях](../storedoc/concepts/backup.md) кластеров, а также о [квотах](../storedoc/concepts/limits.md#mmg-quotas) и операциях с ресурсами сервиса.

#### managed-mongodb.viewer {#managed-mongodb-viewer}

Роль `managed-mongodb.viewer` позволяет просматривать информацию о кластерах, хостах, шардах, базах данных и пользователях {{ SD }}, логи работы кластеров, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах {{ SD }}](../storedoc/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../storedoc/concepts/maintenance.md) кластеров {{ SD }};
* просматривать информацию о [хостах](../storedoc/concepts/instance-types.md) кластеров {{ SD }};
* просматривать информацию о [шардах](../storedoc/concepts/sharding.md) кластеров {{ SD }};
* просматривать информацию о базах данных {{ SD }};
* просматривать информацию о [пользователях](../storedoc/concepts/users-and-roles.md) {{ SD }};
* просматривать информацию о [резервных копиях](../storedoc/concepts/backup.md) кластеров {{ SD }};
* просматривать информацию об алертах {{ SD }};
* просматривать [логи](../storedoc/operations/cluster-logs.md) работы кластеров {{ SD }};
* просматривать информацию о результатах диагностики производительности кластеров {{ SD }};
* просматривать информацию о [квотах](../storedoc/concepts/limits.md#mmg-quotas) сервиса {{ mmg-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mmg-name }}.

Включает разрешения, предоставляемые ролями `managed-mongodb.auditor` и `managed-mongodb.maintenanceTask.viewer`.

#### managed-mongodb.restorer {#managed-mongodb-restorer}

Роль `managed-mongodb.restorer` позволяет восстанавливать кластеры {{ SD }} из резервных копий, просматривать информацию о кластерах, хостах, шардах, базах данных и пользователях {{ SD }}, логи работы кластеров, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о резервных копиях [кластеров {{ SD }}](../storedoc/concepts/index.md) и восстанавливать кластеры из [резервных копий](../storedoc/concepts/backup.md);
* просматривать информацию о кластерах {{ SD }} и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../storedoc/concepts/maintenance.md) кластеров {{ SD }};
* просматривать информацию о [хостах](../storedoc/concepts/instance-types.md) кластеров {{ SD }};
* просматривать информацию о [шардах](../storedoc/concepts/sharding.md) кластеров {{ SD }};
* просматривать информацию о базах данных {{ SD }};
* просматривать информацию о [пользователях](../storedoc/concepts/users-and-roles.md) {{ SD }};
* просматривать информацию об алертах {{ SD }};
* просматривать [логи](../storedoc/operations/cluster-logs.md) работы кластеров {{ SD }};
* просматривать информацию о результатах диагностики производительности кластеров {{ SD }};
* просматривать информацию о [квотах](../storedoc/concepts/limits.md#mmg-quotas) сервиса {{ mmg-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mmg-name }}.

Включает разрешения, предоставляемые ролью `managed-mongodb.viewer`.

#### managed-mongodb.user {#managed-mongodb-user}

Роль `managed-mongodb.user` позволяет использовать [кластеры {{ SD }}](../storedoc/concepts/index.md).

#### managed-mongodb.switcher {#managed-mongodb-switcher}

Роль `managed-mongodb.switcher` позволяет переназначать хост-мастер в кластерах {{ SD }}, просматривать информацию о кластерах, хостах, шардах, базах данных и пользователях {{ SD }}, логи работы кластеров, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* переназначать хост-мастер в [кластерах {{ SD }}](../storedoc/concepts/index.md);
* просматривать информацию о кластерах {{ SD }} и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../storedoc/concepts/maintenance.md) кластеров {{ SD }};
* просматривать информацию о [хостах](../storedoc/concepts/instance-types.md) кластеров {{ SD }};
* просматривать информацию о [шардах](../storedoc/concepts/sharding.md) кластеров {{ SD }};
* просматривать информацию о базах данных {{ SD }};
* просматривать информацию о [пользователях](../storedoc/concepts/users-and-roles.md) {{ SD }};
* просматривать информацию о [резервных копиях](../storedoc/concepts/backup.md) кластеров {{ SD }};
* просматривать информацию об алертах {{ SD }};
* просматривать [логи](../storedoc/operations/cluster-logs.md) работы кластеров {{ SD }};
* просматривать информацию о результатах диагностики производительности кластеров {{ SD }};
* просматривать информацию о [квотах](../storedoc/concepts/limits.md#mmg-quotas) сервиса {{ mmg-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mmg-name }}.

Включает разрешения, предоставляемые ролью `managed-mongodb.viewer`.

#### managed-mongodb.editor {#managed-mongodb-editor}

Роль `managed-mongodb.editor` позволяет управлять кластерами {{ SD }}.

Пользователи с этой ролью могут:
* создавать, использовать, изменять, удалять, запускать и останавливать [кластеры {{ SD }}](../storedoc/concepts/index.md) и просматривать информацию о них;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к кластерам {{ SD }};
* просматривать информацию о заданиях на [техническое обслуживание](../storedoc/concepts/maintenance.md) кластеров {{ SD }} и изменять такие задания;
* создавать, изменять и удалять [хосты](../storedoc/concepts/instance-types.md) кластеров {{ SD }} и просматривать информацию о них;
* переназначать хост-мастер в кластерах {{ SD }};
* создавать и удалять [шарды](../storedoc/concepts/sharding.md) кластеров {{ SD }} и просматривать информацию о них;
* создавать и удалять базы данных {{ SD }} и просматривать информацию о них;
* создавать, изменять и удалять [пользователей](../storedoc/concepts/users-and-roles.md) {{ SD }} и просматривать информацию о них;
* создавать [резервные копии](../storedoc/concepts/backup.md) кластеров {{ SD }}, просматривать информацию о резервных копиях, а также восстанавливать кластеры из резервных копий;
* создавать, изменять и удалять алерты {{ SD }} и просматривать информацию о них;
* просматривать логи работы кластеров {{ SD }};
* просматривать информацию о результатах диагностики производительности кластеров {{ SD }};
* просматривать информацию о [квотах](../storedoc/concepts/limits.md#mmg-quotas) сервиса {{ mmg-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mmg-name }}.

Включает разрешения, предоставляемые ролями `managed-mongodb.viewer`, `managed-mongodb.restorer`, `managed-mongodb.user`, `managed-mongodb.switcher` и `managed-mongodb.maintenanceTask.editor`.

Для создания кластеров {{ SD }} дополнительно необходима роль `vpc.user`.

#### managed-mongodb.admin {#managed-mongodb-admin}

Роль `managed-mongodb.admin` позволяет управлять кластерами {{ SD }} и доступом к ним.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к [кластерам {{ SD }}](../storedoc/concepts/index.md) и изменять такие права доступа;
* создавать, использовать, изменять, удалять, запускать и останавливать кластеры {{ SD }} и просматривать информацию о них;
* просматривать информацию о заданиях на [техническое обслуживание](../storedoc/concepts/maintenance.md) кластеров {{ SD }} и изменять такие задания;
* создавать, изменять и удалять [хосты](../storedoc/concepts/instance-types.md) кластеров {{ SD }} и просматривать информацию о них;
* переназначать хост-мастер в кластерах {{ SD }};
* создавать и удалять [шарды](../storedoc/concepts/sharding.md) кластеров {{ SD }} и просматривать информацию о них;
* создавать и удалять базы данных {{ SD }} и просматривать информацию о них;
* создавать, изменять и удалять [пользователей](../storedoc/concepts/users-and-roles.md) {{ SD }} и просматривать информацию о них;
* создавать [резервные копии](../storedoc/concepts/backup.md) кластеров {{ SD }}, просматривать информацию о резервных копиях, а также восстанавливать кластеры из резервных копий;
* создавать, изменять и удалять алерты {{ SD }} и просматривать информацию о них;
* просматривать логи работы кластеров {{ SD }};
* просматривать информацию о результатах диагностики производительности кластеров {{ SD }};
* просматривать информацию о [квотах](../storedoc/concepts/limits.md#mmg-quotas) сервиса {{ mmg-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mmg-name }}.

Включает разрешения, предоставляемые ролью `managed-mongodb.editor`.

Для создания кластеров {{ SD }} дополнительно необходима роль `vpc.user`.

#### managed-mongodb.maintenanceTask.viewer {#managed-mongodb-maintenanceTask-viewer}

Роль `managed-mongodb.maintenanceTask.viewer` позволяет просматривать информацию о заданиях на [техническое обслуживание](../storedoc/concepts/maintenance.md) кластеров {{ SD }}, а также о таких [кластерах](../storedoc/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о [хостах](../storedoc/concepts/instance-types.md) и [резервных копиях](../storedoc/concepts/backup.md) кластеров, о [квотах](../storedoc/concepts/limits.md#mmg-quotas) и операциях с ресурсами сервиса.

Включает разрешения, предоставляемые ролью `managed-mongodb.auditor`.

#### managed-mongodb.maintenanceTask.editor {#managed-mongodb-maintenanceTask-editor}

Роль `managed-mongodb.maintenanceTask.editor` позволяет просматривать информацию о заданиях на [техническое обслуживание](../storedoc/concepts/maintenance.md) кластеров {{ SD }} и изменять такие задания, просматривать информацию о [кластерах {{ SD }}](../storedoc/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о [хостах](../storedoc/concepts/instance-types.md) и [резервных копиях](../storedoc/concepts/backup.md) кластеров, а также о [квотах](../storedoc/concepts/limits.md#mmg-quotas) и операциях с ресурсами сервиса.

Включает разрешения, предоставляемые ролью `managed-mongodb.maintenanceTask.viewer`.

Подробнее см. [{#T}](../storedoc/security/index.md).


## {{ message-queue-full-name }} {#message-queue-roles}

#### ymq.reader {#ymq-reader}

Роль `ymq.reader` дает право читать и удалять [сообщения](../message-queue/concepts/message.md), устанавливать [таймауты видимости](../message-queue/concepts/visibility-timeout.md) для сообщений, а также очищать [очередь](../message-queue/concepts/queue.md) от сообщений. Позволяет получать список очередей и информацию о них.

#### ymq.writer {#ymq-writer}

Роль `ymq.writer` дает права на запись [сообщений](../message-queue/concepts/message.md) в [очереди](../message-queue/concepts/queue.md) и создание новых очередей. Позволяет получать список очередей и информацию о них.

#### ymq.admin {#ymq-admin}

Роль `ymq.admin` включает права ролей `ymq.reader` и `ymq.writer`, а также дает права изменять атрибуты [очередей](../message-queue/concepts/queue.md) и удалять очереди. Позволяет получать список очередей и информацию о них.

Подробнее см. [{#T}](../message-queue/security/index.md).


## {{ monitoring-full-name }} {#monitoring-roles}

#### monitoring.viewer {#monitoring-viewer}

Роль `monitoring.viewer` позволяет выгружать метрики, а также просматривать информацию о метриках, дашбордах и виджетах.

Пользователи с этой ролью могут:
* просматривать информацию о [метриках](../monitoring/concepts/data-model.md#metric) и их [метках](../monitoring/concepts/data-model.md#label), а также выгружать метрики;
* просматривать список [дашбордов](../monitoring/concepts/visualization/dashboard.md) и [виджетов](../monitoring/concepts/visualization/widget.md), а также информацию о них;
* просматривать историю [уведомлений](../monitoring/concepts/alerting/notification-channel.md);
* просматривать информацию о [квотах](../monitoring/concepts/limits.md#monitoring-quotas) сервиса Monitoring;
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

#### monitoring.editor {#monitoring-editor}

Роль `monitoring.editor` позволяет управлять дашбордами и виджетами, загружать и выгружать метрики, а также просматривать историю уведомлений и информацию о квотах сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о [метриках](../monitoring/concepts/data-model.md#metric) и их [метках](../monitoring/concepts/data-model.md#label), а также загружать и выгружать метрики;
* просматривать список [дашбордов](../monitoring/concepts/visualization/dashboard.md) и [виджетов](../monitoring/concepts/visualization/widget.md) и информацию о них, а также создавать, изменять и удалять дашборды и виджеты;
* просматривать историю [уведомлений](../monitoring/concepts/alerting/notification-channel.md);
* просматривать информацию о [квотах](../monitoring/concepts/limits.md#monitoring-quotas) сервиса Monitoring;
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `monitoring.viewer`.

#### monitoring.admin {#monitoring-admin}

Роль `monitoring.admin` позволяет управлять дашбордами и виджетами, загружать и выгружать метрики, а также просматривать историю уведомлений, информацию о квотах сервиса и метаданные каталога.

Пользователи с этой ролью могут:
* просматривать информацию о [метриках](../monitoring/concepts/data-model.md#metric) и их [метках](../monitoring/concepts/data-model.md#label), а также загружать и выгружать метрики;
* просматривать список [дашбордов](../monitoring/concepts/visualization/dashboard.md) и [виджетов](../monitoring/concepts/visualization/widget.md) и информацию о них, а также создавать, изменять и удалять дашборды и виджеты;
* просматривать историю [уведомлений](../monitoring/concepts/alerting/notification-channel.md);
* просматривать информацию о [квотах](../monitoring/concepts/limits.md#monitoring-quotas) сервиса Monitoring;
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `monitoring.editor`.

Подробнее см. [{#T}](../monitoring/security/index.md).


## {{ network-load-balancer-full-name }} {#network-load-balancer-roles}

#### load-balancer.auditor {#load-balancer-auditor}

Роль `load-balancer.auditor` позволяет просматривать список целевых групп и сетевых балансировщиков, а также информацию о них и о квотах сервиса.

Пользователи с этой ролью могут:
* просматривать список [целевых групп](../network-load-balancer/concepts/target-resources.md) и информацию о них;
* просматривать список [сетевых балансировщиков](../network-load-balancer/concepts/index.md) и информацию о них;
* просматривать список операций с ресурсами сервиса {{ network-load-balancer-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder);
* просматривать информацию о [квотах](../network-load-balancer/concepts/limits.md#load-balancer-quotas) сервиса {{ network-load-balancer-name }}.

#### load-balancer.viewer {#load-balancer-viewer}

Роль `load-balancer.viewer` позволяет просматривать список целевых групп и сетевых балансировщиков, информацию о них и список операций с ними, а также информацию о каталоге, облаке и квотах сервиса.

Пользователи с этой ролью могут:
* просматривать список [целевых групп](../network-load-balancer/concepts/target-resources.md) и информацию о них;
* просматривать список [сетевых балансировщиков](../network-load-balancer/concepts/index.md) и информацию о них;
* просматривать список операций с ресурсами сервиса {{ network-load-balancer-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder);
* просматривать информацию о [квотах](../network-load-balancer/concepts/limits.md#load-balancer-quotas) сервиса {{ network-load-balancer-name }}.

Включает разрешения, предоставляемые ролью `load-balancer.auditor`.

#### load-balancer.privateAdmin {#load-balancer-private-admin}

Роль `load-balancer.privateAdmin` позволяет управлять внутренними сетевыми балансировщиками нагрузки и целевыми группами, а также просматривать информацию о них и об облачных сетях, подсетях, таблицах маршрутизации, шлюзах, группах безопасности и IP-адресах.

Пользователи с этой ролью могут:
* просматривать список [сетевых балансировщиков](../network-load-balancer/concepts/index.md) и информацию о них, а также создавать внутренние сетевые балансировщики (в т.ч. с UDP-обработчиком), изменять, удалять, запускать и останавливать их;
* просматривать список [целевых групп](../network-load-balancer/concepts/target-resources.md) и информацию о них, а также создавать, изменять, удалять и использовать целевые группы;
* просматривать список [облачных сетей](../vpc/concepts/network.md#network) и информацию о них;
* просматривать список [подсетей](../vpc/concepts/network.md#subnet) и информацию о них, а также использовать подсети;
* просматривать список [адресов облачных ресурсов](../vpc/concepts/address.md) и информацию о них;
* просматривать список [таблиц маршрутизации](../vpc/concepts/routing.md#rt-vpc) и информацию о них;
* просматривать список [групп безопасности](../vpc/concepts/security-groups.md) и информацию о них;
* просматривать информацию о [NAT-шлюзах](../vpc/concepts/gateways.md);
* просматривать информацию об использованных IP-адресах в подсетях, а также создавать [внутренние адреса](../vpc/concepts/address.md#internal-addresses);
* просматривать информацию об операциях с ресурсами сервисов {{ vpc-name }} и {{ compute-name }};
* просматривать список операций с ресурсами сервиса {{ network-load-balancer-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder);
* просматривать информацию о квотах сервисов [{{ network-load-balancer-name }}](../network-load-balancer/concepts/limits.md#load-balancer-quotas) и [{{ vpc-name }}](../vpc/concepts/limits.md#vpc-quotas).

Включает разрешения, предоставляемые ролями `load-balancer.viewer` и `vpc.viewer`.

#### load-balancer.editor {#load-balancer-editor}

Роль `load-balancer.editor` позволяет управлять внутренними и внешними сетевыми балансировщиками нагрузки и целевыми группами, а также просматривать информацию о них и об облачных сетях, подсетях, таблицах маршрутизации, шлюзах, группах безопасности и IP-адресах. Роль не позволяет создавать публичные IP-адреса.

Пользователи с этой ролью могут:
* просматривать список [сетевых балансировщиков](../network-load-balancer/concepts/index.md) и информацию о них;
* создавать внутренние и внешние сетевые балансировщики, а также сетевые балансировщики с UDP-обработчиками, изменять, удалять, запускать и останавливать их;
* просматривать список [целевых групп](../network-load-balancer/concepts/target-resources.md) и информацию о них, а также создавать, изменять, удалять и использовать целевые группы;
* просматривать список [облачных сетей](../vpc/concepts/network.md#network) и информацию о них, а также настраивать внешний доступ к облачным сетям;
* просматривать список [подсетей](../vpc/concepts/network.md#subnet) и информацию о них, а также использовать подсети;
* просматривать список [адресов облачных ресурсов](../vpc/concepts/address.md) и информацию о них;
* просматривать список [таблиц маршрутизации](../vpc/concepts/routing.md#rt-vpc) и информацию о них;
* просматривать список [групп безопасности](../vpc/concepts/security-groups.md) и информацию о них;
* просматривать информацию о [NAT-шлюзах](../vpc/concepts/gateways.md);
* просматривать информацию об использованных IP-адресах, а также создавать [внутренние](../vpc/concepts/address.md#internal-addresses) адреса и использовать их;
* просматривать информацию об операциях с ресурсами сервисов {{ vpc-name }} и {{ compute-name }};
* просматривать список операций с ресурсами сервиса {{ network-load-balancer-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder);
* просматривать информацию о квотах сервисов [{{ network-load-balancer-name }}](../network-load-balancer/concepts/limits.md#load-balancer-quotas) и [{{ vpc-name }}](../vpc/concepts/limits.md#vpc-quotas).

Включает разрешения, предоставляемые ролью `load-balancer.privateAdmin`.

#### load-balancer.admin {#load-balancer-admin}

Роль `load-balancer.admin` позволяет управлять внутренними и внешними сетевыми балансировщиками нагрузки и целевыми группами, а также просматривать информацию о них и об облачных сетях, подсетях, таблицах маршрутизации, шлюзах, группах безопасности и IP-адресах.

Пользователи с этой ролью могут:
* просматривать список [сетевых балансировщиков](../network-load-balancer/concepts/index.md) и информацию о них;
* создавать внутренние и внешние сетевые балансировщики, а также сетевые балансировщики с UDP-обработчиками, изменять, удалять, запускать и останавливать их;
* просматривать список [целевых групп](../network-load-balancer/concepts/target-resources.md) и информацию о них, а также создавать, изменять, удалять и использовать целевые группы;
* просматривать список [облачных сетей](../vpc/concepts/network.md#network) и информацию о них, а также настраивать внешний доступ к облачным сетям;
* просматривать список [подсетей](../vpc/concepts/network.md#subnet) и информацию о них, а также использовать подсети;
* просматривать список [адресов облачных ресурсов](../vpc/concepts/address.md) и информацию о них;
* просматривать список [таблиц маршрутизации](../vpc/concepts/routing.md#rt-vpc) и информацию о них;
* просматривать список [групп безопасности](../vpc/concepts/security-groups.md) и информацию о них;
* просматривать информацию о [NAT-шлюзах](../vpc/concepts/gateways.md);
* просматривать информацию об использованных IP-адресах, а также создавать [внутренние](../vpc/concepts/address.md#internal-addresses) и [публичные](../vpc/concepts/address.md#public-addresses) адреса и использовать их;
* просматривать информацию об операциях с ресурсами сервисов {{ vpc-name }} и {{ compute-name }};
* просматривать список операций с ресурсами сервиса {{ network-load-balancer-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder);
* просматривать информацию о квотах сервисов [{{ network-load-balancer-name }}](../network-load-balancer/concepts/limits.md#load-balancer-quotas) и [{{ vpc-name }}](../vpc/concepts/limits.md#vpc-quotas).

Включает разрешения, предоставляемые ролью `load-balancer.editor`.

Подробнее см. [{#T}](../network-load-balancer/security/index.md).


## {{ objstorage-full-name }} {#storage-roles}

#### storage.viewer {#storage-viewer}

Роль `storage.viewer` позволяет читать данные в бакетах, просматривать информацию о бакетах и объектах в них, а также о каталоге и квотах сервиса {{ objstorage-name }}.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать список [бакетов](../storage/concepts/bucket.md);
* просматривать списки [объектов](../storage/concepts/object.md) в бакетах, информацию о таких объектах и их содержимое;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к бакетам и объектам в них;
* просматривать информацию о конфигурации [CORS](../storage/concepts/cors.md) бакетов;
* просматривать информацию о конфигурации [хостинга статических сайтов](../storage/concepts/hosting.md) бакетов;
* просматривать информацию о [протоколе](../storage/concepts/bucket.md#bucket-https) обращения к бакету;
* просматривать настройки [логирования](../storage/concepts/server-logs.md) действий с бакетами;
* просматривать настройки [версионирования](../storage/concepts/versioning.md) бакетов;
* просматривать настройки [шифрования](../storage/concepts/encryption.md) бакетов;
* просматривать информацию о [классе хранилища](../storage/concepts/storage-class.md#default-storage-class) по умолчанию для бакета;
* просматривать [метки](../storage/concepts/tags.md) бакетов;
* просматривать информацию о регионе, в котором расположен бакет;
* просматривать информацию о конфигурации [жизненных циклов](../storage/concepts/lifecycles.md) объектов;
* просматривать списки версий объектов и информацию о таких версиях;
* просматривать информацию о [блокировках версий объектов](../storage/concepts/object-lock.md);
* просматривать [метки](../storage/concepts/tags.md#object-tags) объектов и версий объектов;
* просматривать информацию о текущих [составных загрузках](../storage/concepts/multipart.md) объектов и их частях;
* просматривать статистику [облака](../resource-manager/concepts/resources-hierarchy.md#cloud), [каталога](../resource-manager/concepts/resources-hierarchy.md#folder) и сервиса {{ objstorage-name }};
* просматривать информацию о [квотах](../storage/concepts/limits.md#storage-quotas) сервиса {{ objstorage-name }};
* просматривать информацию о каталоге.

{% endcut %}

#### storage.configViewer {#storage-config-viewer}

Роль `storage.configViewer` позволяет просматривать информацию о настройках бакетов и объектов в них, но не позволяет просматривать данные внутри бакета.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать список [бакетов](../storage/concepts/bucket.md) и списки [объектов](../storage/concepts/object.md) в бакетах без доступа к содержимому объектов;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к бакетам и объектам в них;
* просматривать информацию о [политиках доступа](../storage/concepts/policy.md) к бакетам;
* просматривать информацию о конфигурации [CORS](../storage/concepts/cors.md) бакетов;
* просматривать информацию о конфигурации [хостинга статических сайтов](../storage/concepts/hosting.md) бакетов;
* просматривать информацию о [протоколе](../storage/concepts/bucket.md#bucket-https) обращения к бакету;
* просматривать настройки [логирования](../storage/concepts/server-logs.md) действий с бакетами;
* просматривать настройки [версионирования](../storage/concepts/versioning.md) бакетов;
* просматривать информацию о регионе, в котором расположен бакет;
* просматривать информацию о [блокировках версий объектов](../storage/concepts/object-lock.md);
* просматривать списки версий объектов в бакетах;
* просматривать настройки [шифрования](../storage/concepts/encryption.md) бакетов;
* просматривать информацию о [классе хранилища](../storage/concepts/storage-class.md#default-storage-class) по умолчанию для бакета;
* просматривать [метки](../storage/concepts/tags.md) бакетов;
* просматривать информацию о конфигурации [жизненных циклов](../storage/concepts/lifecycles.md) объектов;
* просматривать информацию о текущих [составных загрузках](../storage/concepts/multipart.md) объектов и их частях;
* просматривать статистику [облака](../resource-manager/concepts/resources-hierarchy.md#cloud), [каталога](../resource-manager/concepts/resources-hierarchy.md#folder) и сервиса {{ objstorage-name }};
* просматривать информацию о каталоге.

{% endcut %}

#### storage.configurer {#storage-configurer}

Роль `storage.configurer` позволяет управлять настройками жизненных циклов объектов, хостинга статических сайтов, политики доступа и CORS. Не позволяет управлять настройками списка управления доступом (ACL) и настройками публичного доступа. Не предоставляет доступа к данным в бакете.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать информацию о [политиках доступа](../storage/concepts/policy.md) к бакетам, а также создавать, изменять и удалять такие политики;
* просматривать информацию о конфигурации [CORS](../storage/concepts/cors.md) бакетов и изменять конфигурацию CORS;
* просматривать информацию о конфигурации [хостинга статических сайтов](../storage/concepts/hosting.md) бакетов и изменять конфигурацию хостинга статических сайтов;
* просматривать информацию о [протоколе](../storage/concepts/bucket.md#bucket-https) обращения к бакету, а также изменять протокол обращения;
* просматривать настройки [логирования](../storage/concepts/server-logs.md) действий с бакетами и изменять настройки логирования;
* просматривать настройки [шифрования](../storage/concepts/encryption.md) бакетов и изменять настройки шифрования;
* просматривать информацию о регионе, в котором расположен бакет;
* просматривать информацию о конфигурации [жизненных циклов](../storage/concepts/lifecycles.md) объектов и изменять конфигурацию жизненных циклов;
* просматривать настройки [версионирования](../storage/concepts/versioning.md) бакетов;
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

#### storage.uploader {#storage-uploader}

Роль `storage.uploader` позволяет загружать объекты в бакеты, в том числе перезаписывать загруженные ранее, а также читать данные в бакетах, просматривать информацию о бакетах и объектах в них, а также о каталоге и квотах сервиса {{ objstorage-name }}. Не позволяет удалять объекты и конфигурировать бакеты.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать список [бакетов](../storage/concepts/bucket.md);
* просматривать списки [объектов](../storage/concepts/object.md) в бакетах, информацию о таких объектах и их содержимое;
* загружать объекты в бакет;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к бакетам и объектам в них;
* просматривать информацию о конфигурации [CORS](../storage/concepts/cors.md) бакетов;
* просматривать информацию о конфигурации [хостинга статических сайтов](../storage/concepts/hosting.md) бакетов;
* просматривать информацию о [протоколе](../storage/concepts/bucket.md#bucket-https) обращения к бакету;
* просматривать настройки [логирования](../storage/concepts/server-logs.md) действий с бакетами;
* просматривать настройки [версионирования](../storage/concepts/versioning.md) бакетов;
* просматривать настройки [шифрования](../storage/concepts/encryption.md) бакетов;
* просматривать информацию о [классе хранилища](../storage/concepts/storage-class.md#default-storage-class) по умолчанию для бакета;
* просматривать [метки](../storage/concepts/tags.md) бакетов;
* просматривать информацию о регионе, в котором расположен бакет;
* просматривать информацию о конфигурации [жизненных циклов](../storage/concepts/lifecycles.md) объектов;
* просматривать списки версий объектов и информацию о таких версиях;
* просматривать информацию о [блокировках версий объектов](../storage/concepts/object-lock.md) и настраивать такие блокировки;
* просматривать [метки](../storage/concepts/tags.md#object-tags) объектов и версий объектов, а также изменять такие метки;
* просматривать информацию о текущих [составных загрузках](../storage/concepts/multipart.md) объектов и их частях, а также удалять частично загруженные объекты;
* просматривать статистику [облака](../resource-manager/concepts/resources-hierarchy.md#cloud), [каталога](../resource-manager/concepts/resources-hierarchy.md#folder) и сервиса {{ objstorage-name }};
* просматривать информацию о [квотах](../storage/concepts/limits.md#storage-quotas) сервиса {{ objstorage-name }};
* просматривать информацию о каталоге.

{% endcut %}

Включает разрешения, предоставляемые ролью `storage.viewer`.

#### storage.editor {#storage-editor}

Роль `storage.editor` позволяет выполнять любые операции с бакетами и объектами: создавать, удалять и изменять их. Не позволяет управлять настройками списка управления доступом (ACL), а также создавать публично доступные бакеты.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать список [бакетов](../storage/concepts/bucket.md), а также создавать и удалять бакеты;
* просматривать списки [объектов](../storage/concepts/object.md) в бакетах, информацию о таких объектах и их содержимое;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к бакетам и объектам в них;
* загружать объекты в бакет, а также удалять объекты и версии объектов;
* просматривать информацию о конфигурации [CORS](../storage/concepts/cors.md) бакетов и изменять конфигурацию CORS;
* просматривать информацию о конфигурации [хостинга статических сайтов](../storage/concepts/hosting.md) бакетов и изменять конфигурацию хостинга статических сайтов;
* просматривать информацию о [протоколе](../storage/concepts/bucket.md#bucket-https) обращения к бакету, а также изменять протокол обращения;
* просматривать настройки [логирования](../storage/concepts/server-logs.md) действий с бакетами и изменять настройки логирования;
* просматривать настройки [версионирования](../storage/concepts/versioning.md) бакетов;
* просматривать настройки [шифрования](../storage/concepts/encryption.md) бакетов и изменять настройки шифрования;
* просматривать информацию о [классе хранилища](../storage/concepts/storage-class.md#default-storage-class) по умолчанию для бакета, а также изменять класс хранилища по умолчанию;
* просматривать [метки](../storage/concepts/tags.md) бакетов и изменять такие метки;
* просматривать информацию о регионе, в котором расположен бакет;
* просматривать информацию о конфигурации [жизненных циклов](../storage/concepts/lifecycles.md) объектов и изменять конфигурацию жизненных циклов;
* просматривать списки версий объектов и информацию о таких версиях;
* восстанавливать версии объектов в версионируемых бакетах;
* просматривать информацию о [блокировках версий объектов](../storage/concepts/object-lock.md) и настраивать такие блокировки;
* просматривать [метки](../storage/concepts/tags.md#object-tags) объектов и версий объектов, а также изменять и удалять такие метки;
* просматривать информацию о текущих [составных загрузках](../storage/concepts/multipart.md) объектов и их частях, а также удалять частично загруженные объекты;
* просматривать статистику [облака](../resource-manager/concepts/resources-hierarchy.md#cloud), [каталога](../resource-manager/concepts/resources-hierarchy.md#folder) и сервиса {{ objstorage-name }};
* просматривать информацию о [квотах](../storage/concepts/limits.md#storage-quotas) сервиса {{ objstorage-name }};
* просматривать информацию о каталоге.

{% endcut %}

Включает разрешения, предоставляемые ролью `storage.uploader`.

#### storage.admin {#storage-admin}

Роль `storage.admin` позволяет управлять сервисом {{ objstorage-name }}.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать список [бакетов](../storage/concepts/bucket.md);
* создавать бакеты, в том числе доступные публично, и удалять бакеты;
* просматривать списки [объектов](../storage/concepts/object.md) в бакетах, информацию о таких объектах и их содержимое;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к бакетам и объектам в них, а также изменять назначенные права доступа к бакетам и объектам;
* просматривать информацию о [политиках доступа](../storage/concepts/policy.md) к бакетам, а также создавать, изменять и удалять такие политики;
* назначать [список управления доступом](../storage/concepts/acl.md) (ACL);
* настраивать доступ к бакету через [сервисное подключение](../vpc/concepts/private-endpoint.md) из {{ vpc-name }};
* загружать объекты в бакет, а также удалять объекты и версии объектов;
* просматривать информацию о конфигурации [CORS](../storage/concepts/cors.md) бакетов и изменять конфигурацию CORS;
* просматривать информацию о конфигурации [хостинга статических сайтов](../storage/concepts/hosting.md) бакетов и изменять конфигурацию хостинга статических сайтов;
* просматривать информацию о [протоколе](../storage/concepts/bucket.md#bucket-https) обращения к бакету, а также изменять протокол обращения;
* просматривать настройки [логирования](../storage/concepts/server-logs.md) действий с бакетами и изменять настройки логирования;
* просматривать настройки [версионирования](../storage/concepts/versioning.md) бакетов и изменять настройки версионирования;
* просматривать настройки [шифрования](../storage/concepts/encryption.md) бакетов и изменять настройки шифрования;
* просматривать информацию о [классе хранилища](../storage/concepts/storage-class.md#default-storage-class) по умолчанию для бакета, а также изменять класс хранилища по умолчанию;
* просматривать [метки](../storage/concepts/tags.md) бакетов и изменять такие метки;
* просматривать информацию о регионе, в котором расположен бакет;
* просматривать информацию о конфигурации [жизненных циклов](../storage/concepts/lifecycles.md) объектов и изменять конфигурацию жизненных циклов;
* просматривать списки версий объектов и информацию о таких версиях;
* восстанавливать версии объектов в версионируемых бакетах;
* просматривать информацию о [блокировках версий объектов](../storage/concepts/object-lock.md) и настраивать такие блокировки;
* обходить [временную управляемую блокировку](../storage/concepts/object-lock.md#types) (governance-mode retention);
* просматривать [метки](../storage/concepts/tags.md#object-tags) объектов и версий объектов, а также изменять и удалять такие метки;
* просматривать информацию о текущих [составных загрузках](../storage/concepts/multipart.md) объектов и их частях, а также удалять частично загруженные объекты;
* просматривать статистику [облака](../resource-manager/concepts/resources-hierarchy.md#cloud), [каталога](../resource-manager/concepts/resources-hierarchy.md#folder) и сервиса {{ objstorage-name }};
* просматривать информацию о [квотах](../storage/concepts/limits.md#storage-quotas) сервиса {{ objstorage-name }};
* просматривать информацию о каталоге.

{% endcut %}

Включает разрешения, предоставляемые ролями `storage.editor`, `storage.configViewer` и `storage.configurer`.

Подробнее см. [{#T}](../storage/security/index.md).


## {{ yq-full-name }} {#query-roles}

#### yq.auditor {#query-auditor}

Роль `yq.auditor` позволяет просматривать метаданные сервиса, в том числе информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder), [соединениях](../query/concepts/glossary.md#connection), [привязках](../query/concepts/glossary.md#binding), [запросах](../query/concepts/glossary.md#query) и [запусках](../query/concepts/glossary.md#jobs).

#### yq.viewer {#query-viewer}

Роль `yq.auditor` позволяет просматривать метаданные сервиса, в том числе информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder), [соединениях](../query/concepts/glossary.md#connection), [привязках](../query/concepts/glossary.md#binding), [запросах](../query/concepts/glossary.md#query) и [запусках](../query/concepts/glossary.md#jobs), включая текст запросов и их результаты.

Включает разрешения, предоставляемые ролью `yq.auditor`.

#### yq.editor {#query-editor}

Пользователь с ролью `yq.editor` может управлять соединениями и запросами, созданными им. 

Пользователи с этой ролью могут:
* просматривать информацию о [запросах](../query/concepts/glossary.md#query), созданных этими пользователями, и [запусках](../query/concepts/glossary.md#jobs) таких запросов, в том числе просматривать текст запросов и их результаты;
* создавать запросы, а также запускать и отменять выполнение запросов, созданных этими пользователями;
* просматривать информацию о [соединениях](../query/concepts/glossary.md#connection), а также создавать, использовать, изменять и удалять их;
* просматривать информацию о [привязках](../query/concepts/glossary.md#binding), а также создавать, использовать, изменять и удалять их;
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролями `yq.viewer` и `yq.invoker`.

#### yq.admin {#query-admin}

Роль `yq.admin` позволяет управлять любыми ресурсами Yandex Query, в том числе помеченными как приватные.

Пользователи с этой ролью могут:
* просматривать информацию о [запросах](../query/concepts/glossary.md#query) и [запусках](../query/concepts/glossary.md#jobs) запросов, в том числе просматривать текст запросов и их результаты;
* создавать запросы, а также запускать их и отменять запуски;
* просматривать информацию о [соединениях](../query/concepts/glossary.md#connection), а также создавать, использовать, изменять и удалять их;
* просматривать информацию о [привязках](../query/concepts/glossary.md#binding), а также создавать, использовать, изменять и удалять их;
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `yq.editor`.

#### yq.invoker {#query-invoker}

Роль `yq.invoker` позволяет создавать и запускать [запросы](../query/concepts/glossary.md#query), использовать [соединения](../query/concepts/glossary.md#connection) и [привязки](../query/concepts/glossary.md#binding), а также просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder) и запросах, включая их текст и результаты.

Роль предназначена для автоматизации выполнения запросов сервисными аккаунтами. Например, для запуска запросов по событию или по расписанию.

Подробнее см. [{#T}](../query/security/index.md).


## {{ resmgr-full-name }} {#resource-manager-roles}

#### resource-manager.auditor {#resource-manager-auditor}

Роль `resource-manager.auditor` позволяет просматривать метаинформацию облаков и каталогов, а также информацию о назначенных правах доступа к облакам и каталогам.

Пользователи с этой ролью могут:
* просматривать информацию об [облаках](../resource-manager/concepts/resources-hierarchy.md#cloud) и их настройках, а также о назначенных [правах доступа](concepts/access-control/index.md) к облакам;
* просматривать информацию о [каталогах](../resource-manager/concepts/resources-hierarchy.md#folder) и их настройках, а также о назначенных правах доступа к каталогам;
* просматривать [политики авторизации](concepts/access-control/access-policies.md), назначенные на облака и каталоги;
* просматривать информацию о [квотах](../resource-manager/concepts/limits.md#resmgr-quotas) сервиса Resource Manager.

#### resource-manager.viewer {#resource-manager-viewer}

Роль `resource-manager.viewer` позволяет просматривать информацию об облаках и каталогах, а также о назначенных правах доступа к облакам и каталогам.

Пользователи с этой ролью могут:
* просматривать информацию об [облаках](../resource-manager/concepts/resources-hierarchy.md#cloud) и их настройках, а также о назначенных [правах доступа](concepts/access-control/index.md) к облакам;
* просматривать информацию о [каталогах](../resource-manager/concepts/resources-hierarchy.md#folder) и их настройках, а также о назначенных правах доступа к каталогам;
* просматривать [политики авторизации](concepts/access-control/access-policies.md), назначенные на облака и каталоги;
* просматривать информацию о [квотах](../resource-manager/concepts/limits.md#resmgr-quotas) сервиса Resource Manager.

Включает разрешения, предоставляемые ролью `resource-manager.auditor`.

#### resource-manager.editor {#resource-manager-editor}

Роль `resource-manager.editor` позволяет управлять облаками и каталогами, а также просматривать информацию о назначенных правах доступа к облакам и каталогам.

Пользователи с этой ролью могут:
* просматривать информацию об [облаках](../resource-manager/concepts/resources-hierarchy.md#cloud), их настройках и назначенных [правах доступа](concepts/access-control/index.md) к облакам, а также создавать, изменять и удалять облака;
* просматривать информацию о [каталогах](../resource-manager/concepts/resources-hierarchy.md#folder), их настройках и назначенных правах доступа к каталогам, а также создавать, изменять и удалять каталоги;
* просматривать [политики авторизации](concepts/access-control/access-policies.md), назначенные на облака и каталоги;
* просматривать информацию о [квотах](../resource-manager/concepts/limits.md#resmgr-quotas) сервиса Resource Manager.

Включает разрешения, предоставляемые ролью `resource-manager.viewer`.

#### resource-manager.admin {#resource-manager-admin}

Роль `resource-manager.admin` позволяет управлять облаками и каталогами, а также доступом к ним.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к [облакам](../resource-manager/concepts/resources-hierarchy.md#cloud) и изменять такие права доступа;
* просматривать информацию об облаках и их настройках, а также создавать, изменять и удалять облака;
* просматривать информацию о назначенных правах доступа к [каталогам](../resource-manager/concepts/resources-hierarchy.md#folder) и изменять такие права доступа;
* просматривать [политики авторизации](concepts/access-control/access-policies.md), назначенные на облака и каталоги, а также назначать такие политики на облака и каталоги и отзывать их;
* просматривать информацию о каталогах и их настройках, а также создавать, изменять и удалять каталоги;
* просматривать информацию о [квотах](../resource-manager/concepts/limits.md#resmgr-quotas) сервиса Resource Manager.

Включает разрешения, предоставляемые ролью `resource-manager.editor`.

#### resource-manager.clouds.member {#resource-manager-clouds-member}

Роль `resource-manager.clouds.member` позволяет просматривать информацию об облаке и обращаться в техническую поддержку Yandex Cloud.

Можно назначить только на облако.

Пользователи с этой ролью могут:
* просматривать список [обращений](../support/overview.md#response-time) в техническую поддержку и информацию о них, а также создавать и закрывать такие обращения, оставлять в них комментарии и прикреплять файлы;
* просматривать информацию об [облаках](../resource-manager/concepts/resources-hierarchy.md#cloud) и их настройках.

#### resource-manager.clouds.owner {#resource-manager-clouds-owner}

Роль `resource-manager.clouds.owner` позволяет совершать любые действия в [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и дочерних [ресурсах](../resource-manager/concepts/resources-hierarchy.md).

Роль также позволяет управлять привязкой облака к [платежному аккаунту](../billing/concepts/billing-account.md), для этого у пользователя должны быть права на этот платежный аккаунт. Подробнее об управлении доступом к платежному аккаунту см. в [документации Yandex Cloud Billing](../billing/security/index.md#billing-account).

По умолчанию пользователи с этой ролью получают [уведомления](../resource-manager/concepts/notify.md) о событиях в облаке и его каталогах.

Роль можно назначить только на облако. Пользователю, создающему облако, автоматически назначается данная роль на это облако.

Включает разрешения, предоставляемые ролями `admin` и `resource-manager.clouds.member`.

Подробнее см. [{#T}](../resource-manager/security/index.md).


## {{ search-api-full-name }} {#search-api-roles}

#### search-api.executor {#search-api-executor}

Роль `search-api.executor` использовалась для работы с устаревшим API сервиса.

Роль `search-api.executor` устарела и больше не используется.

#### search-api.webSearch.user {#search-api-webSearch-user}

Роль `search-api.webSearch.user` позволяет выполнять поисковые запросы в сервисе {{ search-api }}, а также просматривать информацию об [облаке]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#cloud), [каталоге]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#folder) и [квотах]({{ link-docs-ai }}search-api/concepts/limits#search-api-quotas) сервиса {{ search-api }}.

#### search-api.auditor {#search-api-auditor}

Роль `search-api.auditor` использовалась для работы с устаревшим API сервиса и позволяет просматривать информацию о квотах сервиса {{ search-api }}, а также об облаке и каталоге.

Роль `search-api.auditor` устарела и не должна использоваться.

#### search-api.viewer {#search-api-viewer}

Роль `search-api.viewer` использовалась для работы с устаревшим API сервиса и позволяет просматривать информацию о квотах сервиса {{ search-api }}, а также об облаке и каталоге.

Роль `search-api.viewer` устарела и не должна использоваться.

#### search-api.editor {#search-api-editor}

Роль `search-api.editor` использовалась для работы с устаревшим API сервиса и позволяет просматривать информацию о квотах сервиса {{ search-api }}, а также об облаке и каталоге.

Роль `search-api.editor` устарела и не должна использоваться.

#### search-api.admin {#search-api-admin}

Роль `search-api.admin` использовалась для работы с устаревшим API сервиса и позволяет просматривать информацию о квотах сервиса {{ search-api }}, а также об облаке и каталоге.

Роль `search-api.admin` устарела и не должна использоваться.

Подробнее см. [Управление доступом в {{ search-api-full-name }}]({{ link-docs-ai }}search-api/security/index).


## {{ sd-full-name }} {#security-deck-roles}

### Общие роли {{ sd-name }} {#general-sd-roles}

#### security-deck.worker {#security-deck-worker}

Роль `security-deck.worker` позволяет просматривать информацию об области сканирования модуля {{ dspm-name }} и контролируемых ресурсах модулей {{ kspm-name }} и {{ cspm-name }} в {{ sd-name }}.

Пользователи с этой ролью могут:

* просматривать информацию об [организации](../organization/concepts/organization.md), просматривать список [облаков](../resource-manager/concepts/resources-hierarchy.md#cloud), [каталогов](../resource-manager/concepts/resources-hierarchy.md#folder) и [бакетов](../storage/concepts/bucket.md) в заданной пользователем модуля {{ dspm-name }} [области сканирования](../security-deck/concepts/dspm.md#data-source) и информацию о них, а также просматривать данные в сканируемых бакетах;
* просматривать список облаков и каталогов и информацию о них в составе контролируемых ресурсов [окружения](../security-deck/concepts/workspace.md) {{ sd-name }} для [модуля {{ kspm-name }}](../security-deck/concepts/kspm.md);
* просматривать список кластеров {{ k8s }}, информацию о них и их настройках в составе контролируемых ресурсов окружения {{ sd-name }} для модуля {{ kspm-name }};
* просматривать информацию об организации, просматривать список облаков и каталогов и информацию о них в составе контролируемых ресурсов окружения {{ sd-name }} для [модуля {{ cspm-name }}](../security-deck/concepts/cspm.md).

Роль выдается [сервисному аккаунту](concepts/users/service-accounts.md), от имени которого будет выполняться [сканирование](../security-deck/concepts/dspm.md#scanning) {{ dspm-name }}, проверка {{ kspm-name }} или {{ cspm-name }}. Роль назначается на организацию, облако, каталог или (при использовании [модуля {{ dspm-name }}](../security-deck/concepts/dspm.md)) бакет.

Роль не позволяет просматривать данные в [зашифрованных бакетах](../storage/concepts/encryption.md). Для сканирования зашифрованного бакета дополнительно назначьте сервисному аккаунту [роль](../kms/security/index.md#kms-keys-encrypter) `kms.keys.decrypter` на соответствующий [ключ шифрования](../kms/concepts/key.md), либо на каталог, облако или организацию, в которой находится этот ключ.

Включает разрешения, предоставляемые ролями `dspm.worker`, `kspm.worker` и `cspm.worker`.

{% note info %}

Роль не может гарантировать доступа к бакету, если к бакету применена [политика доступа](../storage/security/policy.md) {{ objstorage-full-name }}.

{% endnote %}

#### security-deck.auditor {#security-deck-auditor}

Роль `security-deck.auditor` позволяет просматривать информацию о ресурсах модулей {{ dspm-name }}, {{ cspm-name }} и {{ kspm-name }}, а также об алертах и приемниках алертов, о заданиях сканирования и количестве найденных угроз безопасности. Роль не позволяет просматривать замаскированные и необработанные данные.

Пользователи с этой ролью могут:
* просматривать информацию о профилях {{ dspm-name }};
* просматривать информацию об [источниках данных](../security-deck/concepts/dspm.md#data-source) {{ dspm-name }};
* просматривать информацию о заданиях [сканирования](../security-deck/concepts/dspm.md#scanning) на угрозы безопасности в модуле {{ dspm-name }};
* просматривать информацию о типах и [категориях](../security-deck/concepts/dspm.md#data-categories) данных;
* просматривать результаты сканирования {{ dspm-name }} и информацию об обнаруженных угрозах безопасности;
* просматривать информацию об [окружениях](../security-deck/concepts/workspace.md) {{ sd-name }} и контролируемых в них ресурсах, а также о назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о [коннекторах](../security-deck/concepts/workspace.md#connectors);
* просматривать информацию о заданиях проверок инфраструктуры на соответствие [стандартам безопасности](../security-deck/concepts/cspm.md#standards), заданным в настройках [модуля CSPM](../security-deck/concepts/cspm.md);
* просматривать информацию о настройках [модуля {{ kspm-name }}](../security-deck/concepts/kspm.md) и операциях в модуле, а также список исключений из правил;
* просматривать информацию о [приемниках алертов](../security-deck/concepts/workspace.md#alert-sinks) и назначенных правах доступа к ним.

Включает разрешения, предоставляемые ролями `dspm.auditor`, `cspm.auditor`, `kspm.auditor` и `security-deck.alertSinks.auditor`.

#### security-deck.viewer {#security-deck-viewer}

Роль `security-deck.viewer` позволяет просматривать информацию о событиях доступа к ресурсам организации со стороны сотрудников {{ yandex-cloud }}, информацию о ресурсах модулей {{ dspm-name }}, {{ cspm-name }} и {{ kspm-name }}, а также об алертах и приемниках алертов, о заданиях сканирования и количестве найденных угроз безопасности. Роль не позволяет просматривать замаскированные и необработанные данные.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать список событий доступа к ресурсам организации со стороны сотрудников {{ yandex-cloud }};
* выражать согласие или несогласие с результатами подготовленного нейросетью анализа событий доступа к ресурсам организации со стороны сотрудников {{ yandex-cloud }};
* просматривать информацию о профилях {{ dspm-name }};
* просматривать информацию об [источниках данных](../security-deck/concepts/dspm.md#data-source) {{ dspm-name }};
* просматривать информацию о заданиях [сканирования](../security-deck/concepts/dspm.md#scanning) на угрозы безопасности в модуле {{ dspm-name }};
* просматривать информацию о типах и [категориях](../security-deck/concepts/dspm.md#data-categories) данных;
* просматривать результаты сканирования {{ dspm-name }} и информацию об обнаруженных угрозах безопасности;
* просматривать информацию об [окружениях](../security-deck/concepts/workspace.md) {{ sd-name }} и контролируемых в них ресурсах, а также о назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о [коннекторах](../security-deck/concepts/workspace.md#connectors);
* просматривать информацию о заданиях проверок инфраструктуры на соответствие [стандартам безопасности](../security-deck/concepts/cspm.md#standards), заданным в настройках [модуля {{ cspm-name }}](../security-deck/concepts/cspm.md), о результатах таких проверок, а также о заданных [исключениях](../security-deck/concepts/cspm.md#exceptions) из правил проверок;
* просматривать информацию о настройках [модуля {{ kspm-name }}](../security-deck/concepts/kspm.md), [кластерах](../managed-kubernetes/concepts/index.md#kubernetes-cluster) {{ managed-k8s-name }}, подключенных к {{ kspm-name }}, исключениях из правил, исключениях из области контроля, пользователях {{ kspm-name }} и операциях в модуле;
* просматривать информацию о [приемниках алертов](../security-deck/concepts/workspace.md#alert-sinks) и назначенных правах доступа к ним;
* просматривать информацию об [алертах](../security-deck/concepts/alerts.md) и назначенных правах доступа к ним;
* просматривать дополнительную информацию об алертах и их источниках, а также перечень затронутых ресурсов и рекомендации по устранению проблем.

{% endcut %}

Включает разрешения, предоставляемые ролями `access-transparency.viewer`, `dspm.viewer`, `cspm.viewer`, `kspm.viewer` и `security-deck.alertSinks.viewer`.

#### security-deck.editor {#security-deck-editor}

Роль `security-deck.editor` позволяет управлять подписками на события доступа к ресурсам организации со стороны сотрудников {{ yandex-cloud }}, управлять окружениями, алертами и приемниками алертов, а также ресурсами модулей {{ dspm-name }}, {{ cspm-name }} и {{ kspm-name }}. Роль не позволяет просматривать замаскированные и необработанные данные.

{% cut "Пользователи с этой ролью могут:" %}

* выбирать [платежный аккаунт](../billing/concepts/billing-account.md) в модуле {{ atr-name }};
* просматривать информацию о подписках на события доступа к ресурсам организации со стороны сотрудников {{ yandex-cloud }}, а также создавать, удалять и отменять удаление таких подписок;
* просматривать список событий доступа к ресурсам организации со стороны сотрудников {{ yandex-cloud }};
* выражать согласие или несогласие с результатами подготовленного нейросетью анализа событий доступа к ресурсам организации со стороны сотрудников {{ yandex-cloud }};
* просматривать информацию о профилях {{ dspm-name }} и использовать их;
* просматривать информацию об [источниках данных](../security-deck/concepts/dspm.md#data-source) {{ dspm-name }}, а также создавать, изменять, использовать и удалять их;
* просматривать информацию о заданиях [сканирования](../security-deck/concepts/dspm.md#scanning) {{ dspm-name }} на угрозы безопасности, а также создавать, изменять и удалять такие задания;
* запускать задания сканирования {{ dspm-name }} и просматривать их результаты и информацию об обнаруженных угрозах;
* просматривать информацию о типах и [категориях](../security-deck/concepts/dspm.md#data-categories) данных {{ dspm-name }};
* просматривать метаданные [бакетов](../storage/concepts/bucket.md);
* просматривать информацию об [окружениях](../security-deck/concepts/workspace.md) {{ sd-name }} и контролируемых в них ресурсах, а также о назначенных [правах доступа](concepts/access-control/index.md) к ним;
* создавать, изменять и удалять окружения {{ sd-name }};
* просматривать информацию о [коннекторах](../security-deck/concepts/workspace.md#connectors), а также создавать, использовать, изменять и удалять их;
* просматривать информацию о заданиях проверок инфраструктуры на соответствие [стандартам безопасности](../security-deck/concepts/cspm.md#standards), заданным в настройках [модуля {{ cspm-name }}](../security-deck/concepts/cspm.md);
* просматривать результаты проверок безопасности модуля {{ cspm-name }};
* создавать, приостанавливать, возобновлять, изменять и удалять задания проверок модуля {{ cspm-name }};
* просматривать заданные [исключения](../security-deck/concepts/cspm.md#exceptions) из правил проверок модуля {{ cspm-name }}, а также создавать и удалять такие исключения;
* задействовать, настраивать и отключать [модуль {{ kspm-name }}](../security-deck/concepts/kspm.md), создавать, изменять и удалять исключения из правил, а также исключения из области контроля;
* просматривать информацию о [кластерах](../managed-kubernetes/concepts/index.md#kubernetes-cluster) {{ managed-k8s-name }}, подключенных к {{ kspm-name }}, пользователях {{ kspm-name }} и операциях в модуле;
* просматривать информацию о [приемниках алертов](../security-deck/concepts/workspace.md#alert-sinks) и назначенных правах доступа к ним;
* создавать, использовать, изменять и удалять приемники алертов;
* просматривать информацию об [алертах](../security-deck/concepts/alerts.md) и назначенных правах доступа к ним;
* просматривать дополнительную информацию об алертах и их источниках, а также перечень затронутых ресурсов и рекомендации по устранению проблем;
* создавать, изменять и удалять алерты;
* просматривать список комментариев к алертам, а также создавать, изменять и удалять комментарии.

{% endcut %}

Включает разрешения, предоставляемые ролями `access-transparency.editor`, `dspm.editor`, `cspm.editor`, `kspm.editor` и `security-deck.alertSinks.editor`.

#### security-deck.admin {#security-deck-admin}

Роль `security-deck.admin` позволяет управлять подписками на события доступа к ресурсам организации со стороны сотрудников {{ yandex-cloud }}, управлять окружениями, алертами и приемниками алертов, а также ресурсами модулей {{ dspm-name }}, {{ cspm-name }} и {{ kspm-name }}. Роль позволяет просматривать замаскированные и необработанные данные в результатах сканирования.

{% cut "Пользователи с этой ролью могут:" %}

* выбирать [платежный аккаунт](../billing/concepts/billing-account.md) в модуле {{ atr-name }};
* просматривать информацию о подписках на события доступа к ресурсам организации со стороны сотрудников {{ yandex-cloud }}, а также создавать, удалять и отменять удаление таких подписок;
* просматривать список событий доступа к ресурсам организации со стороны сотрудников {{ yandex-cloud }};
* выражать согласие или несогласие с результатами подготовленного нейросетью анализа событий доступа к ресурсам организации со стороны сотрудников {{ yandex-cloud }};
* просматривать информацию о профилях {{ dspm-name }} и использовать их;
* просматривать информацию об [источниках данных](../security-deck/concepts/dspm.md#data-source) {{ dspm-name }}, а также создавать, изменять, использовать и удалять их;
* использовать ресурсы {{ yandex-cloud }} в источниках данных {{ dspm-name }};
* просматривать информацию о типах и [категориях](../security-deck/concepts/dspm.md#data-categories) данных {{ dspm-name }};
* просматривать информацию о заданиях [сканирования](../security-deck/concepts/dspm.md#scanning) {{ dspm-name }} на угрозы безопасности, а также создавать, изменять и удалять такие задания;
* запускать задания сканирования {{ dspm-name }} и просматривать их результаты и информацию об обнаруженных угрозах, в том числе просматривать замаскированные и необработанные данные в результатах сканирования;
* просматривать метаданные [бакетов](../storage/concepts/bucket.md);
* просматривать информацию об [окружениях](../security-deck/concepts/workspace.md) {{ sd-name }} и контролируемых в них ресурсах, а также создавать, изменять и удалять окружения {{ sd-name }};
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к окружениям {{ sd-name }} и изменять такие права доступа;
* просматривать информацию о [коннекторах](../security-deck/concepts/workspace.md#connectors), а также создавать, использовать, изменять и удалять их;
* просматривать информацию о заданиях проверок инфраструктуры на соответствие [стандартам безопасности](../security-deck/concepts/cspm.md#standards), заданным в настройках [модуля {{ cspm-name }}](../security-deck/concepts/cspm.md);
* просматривать результаты проверок безопасности модуля {{ cspm-name }};
* создавать, приостанавливать, возобновлять, изменять и удалять задания проверок модуля {{ cspm-name }};
* просматривать заданные [исключения](../security-deck/concepts/cspm.md#exceptions) из правил проверок модуля {{ cspm-name }}, а также создавать и удалять такие исключения;
* задействовать, настраивать и отключать [модуль {{ kspm-name }}](../security-deck/concepts/kspm.md), создавать, изменять и удалять исключения из правил, а также исключения из области контроля;
* просматривать информацию о [кластерах](../managed-kubernetes/concepts/index.md#kubernetes-cluster) {{ managed-k8s-name }}, подключенных к {{ kspm-name }}, пользователях {{ kspm-name }} и операциях в модуле;
* просматривать информацию о [приемниках алертов](../security-deck/concepts/workspace.md#alert-sinks), а также создавать, использовать, изменять и удалять их;
* просматривать информацию о назначенных правах доступа к приемникам алертов и изменять такие права доступа;
* просматривать информацию об [алертах](../security-deck/concepts/alerts.md), а также создавать, изменять и удалять их;
* просматривать информацию о назначенных правах доступа к алертам и изменять такие права доступа;
* просматривать дополнительную информацию об алертах и их источниках, а также перечень затронутых ресурсов и рекомендации по устранению проблем;
* просматривать список комментариев к алертам, а также создавать, изменять и удалять комментарии.

{% endcut %}

Включает разрешения, предоставляемые ролями `access-transparency.admin`, `dspm.admin`, `cspm.admin`, `kspm.admin` и `security-deck.alertSinks.admin`.

Подробнее см. [Общие роли {{ sd-full-name }}](../security-deck/security/index.md).

### Сервисные роли для контроля данных ({{ dspm-name }}) {#dspm-roles}

#### dspm.worker {#dspm-worker}

Роль `dspm.worker` позволяет просматривать информацию об [организации](../organization/concepts/organization.md), просматривать список [облаков](../resource-manager/concepts/resources-hierarchy.md#cloud), [каталогов](../resource-manager/concepts/resources-hierarchy.md#folder) и [бакетов](../storage/concepts/bucket.md) в заданной пользователем [области сканирования](../security-deck/concepts/dspm.md#data-source) и информацию о них, а также просматривать данные в сканируемых бакетах.

Роль выдается [сервисному аккаунту](concepts/users/service-accounts.md), от имени которого будет выполняться [сканирование](../security-deck/concepts/dspm.md#scanning), и назначается на организацию, облако, каталог или бакет.

Роль не позволяет просматривать данные в [зашифрованных бакетах](../storage/concepts/encryption.md). Для сканирования зашифрованного бакета дополнительно назначьте сервисному аккаунту [роль](../kms/security/index.md#kms-keys-encrypter) `kms.keys.decrypter` на соответствующий [ключ шифрования](../kms/concepts/key.md), либо на каталог, облако или организацию, в которой находится этот ключ.

{% note info %}

Роль не может гарантировать доступа к бакету, если к бакету применена [политика доступа](../storage/security/policy.md) {{ objstorage-full-name }}.

{% endnote %}

#### dspm.inspector {#dspm-inspector}

Роль `dspm.inspector` позволяет создавать источники данных {{ dspm-name }} с использованием заданных ресурсов {{ yandex-cloud }}. Чтобы создать источник данных в {{ dspm-name }}, эту роль необходимо назначить пользователю на соответствующий облачный ресурс.

Роль `dspm.inspector` устарела и больше не используется.

#### dspm.auditor {#dspm-auditor}

Роль `dspm.auditor` позволяет просматривать информацию о ресурсах сервиса {{ dspm-name }}, а также о заданиях сканирования и количестве найденных угроз безопасности. Роль не позволяет просматривать замаскированные и необработанные данные.

Пользователи с этой ролью могут:
* просматривать информацию о профилях {{ dspm-name }};
* просматривать информацию об [источниках данных](../security-deck/concepts/dspm.md#data-source) {{ dspm-name }};
* просматривать информацию о заданиях [сканирования](../security-deck/concepts/dspm.md#scanning) на угрозы безопасности.

#### dspm.viewer {#dspm-viewer}

Роль `dspm.viewer` позволяет просматривать информацию о ресурсах сервиса {{ dspm-name }}, а также о заданиях сканирования и количестве найденных угроз безопасности. Роль не позволяет просматривать замаскированные и необработанные данные.

Пользователи с этой ролью могут:
* просматривать информацию о профилях {{ dspm-name }};
* просматривать информацию об [источниках данных](../security-deck/concepts/dspm.md#data-source) {{ dspm-name }};
* просматривать информацию о заданиях [сканирования](../security-deck/concepts/dspm.md#scanning) на угрозы безопасности.

Включает разрешения, предоставляемые ролью `dspm.auditor`.

#### dspm.editor {#dspm-editor}

Роль `dspm.editor` позволяет использовать профили {{ dspm-name }}, управлять источниками данных и сканированием на угрозы безопасности. Роль не позволяет просматривать замаскированные и необработанные данные.

Пользователи с этой ролью могут:
* просматривать информацию о профилях {{ dspm-name }} и использовать их;
* просматривать информацию об [источниках данных](../security-deck/concepts/dspm.md#data-source) {{ dspm-name }}, а также создавать, изменять, использовать и удалять их;
* просматривать информацию о заданиях [сканирования](../security-deck/concepts/dspm.md#scanning) на угрозы безопасности, а также создавать, запускать, изменять и удалять такие задания.

Включает разрешения, предоставляемые ролью `dspm.viewer`.

#### dspm.admin {#dspm-admin}

Роль `dspm.admin` позволяет использовать профили {{ dspm-name }}, управлять источниками данных и сканированием на угрозы безопасности, в том числе просматривать замаскированные и необработанные данные в результатах сканирования.

Пользователи с этой ролью могут:
* просматривать информацию о профилях {{ dspm-name }} и использовать их;
* просматривать информацию об [источниках данных](../security-deck/concepts/dspm.md#data-source) {{ dspm-name }}, а также создавать, изменять, использовать и удалять их;
* использовать ресурсы {{ yandex-cloud }} в источниках данных {{ dspm-name }};
* просматривать информацию о [категориях данных](../security-deck/concepts/dspm.md#data-categories) {{ dspm-name }};
* просматривать информацию о заданиях [сканирования](../security-deck/concepts/dspm.md#scanning) на угрозы безопасности, а также создавать, изменять и удалять такие задания;
* запускать задания сканирования и просматривать их результаты и информацию об обнаруженных угрозах, в том числе просматривать замаскированные и необработанные данные в результатах сканирования.

Включает разрешения, предоставляемые ролью `dspm.editor`.

Подробнее см. [Управление доступом в {{ dspm-name }}](../security-deck/security/dspm-roles.md).

### Сервисные роли для модуля Контроль {{ k8s }}® ({{ kspm-name }}) {#kspm-roles}

#### kspm.worker {#kspm-worker}

Роль `kspm.worker` позволяет просматривать информацию о [кластерах](../managed-kubernetes/concepts/index.md#kubernetes-cluster) {{ managed-k8s-name }} и устанавливать в них компоненты [модуля {{ kspm-name }}](../security-deck/concepts/kspm.md).

Роль выдается [сервисному аккаунту](concepts/users/service-accounts.md), от имени которого будут выполняться проверки кластера, и назначается на организацию, облако или каталог. Этот сервисный аккаунт указывается при [создании](../security-deck/operations/workspaces/create.md) окружения.

#### kspm.auditor {#kspm-auditor}

Роль `kspm.auditor` позволяет просматривать информацию о настройках [модуля {{ kspm-name }}](../security-deck/concepts/kspm.md), операциях в модуле и списке исключений из правил.

#### kspm.viewer {#kspm-viewer}

Роль `kspm.viewer` позволяет просматривать информацию о настройках [модуля {{ kspm-name }}](../security-deck/concepts/kspm.md), [кластерах](../managed-kubernetes/concepts/index.md#kubernetes-cluster) {{ managed-k8s-name }}, подключенных к {{ kspm-name }}, исключениях из правил, исключениях из области контроля, пользователях {{ kspm-name }} и операциях в модуле.

Включает разрешения, предоставляемые ролью `kspm.auditor`.

#### kspm.editor {#kspm-editor}

Роль `kspm.editor` позволяет задействовать, настраивать и отключать [модуль {{ kspm-name }}](../security-deck/concepts/kspm.md), создавать, изменять и удалять исключения из правил, а также исключения из области контроля, просматривать информацию о [кластерах](../managed-kubernetes/concepts/index.md#kubernetes-cluster) {{ managed-k8s-name }}, подключенных к {{ kspm-name }}, пользователях {{ kspm-name }} и операциях в модуле.

Включает разрешения, предоставляемые ролью `kspm.viewer`.

#### kspm.admin {#kspm-admin}

Роль `kspm.admin` позволяет задействовать, настраивать и отключать [модуль {{ kspm-name }}](../security-deck/concepts/kspm.md), создавать, изменять и удалять исключения из правил, а также исключения из области контроля, просматривать информацию о [кластерах](../managed-kubernetes/concepts/index.md#kubernetes-cluster) {{ managed-k8s-name }}, подключенных к {{ kspm-name }}, пользователях {{ kspm-name }} и операциях в модуле.

Включает разрешения, предоставляемые ролью `kspm.editor`.

Подробнее см. [Управление доступом в {{ kspm-name }}](../security-deck/security/kspm-roles.md).

### Сервисные роли для модуля Контроль конфигурации ({{ cspm-name }}) {#cspm-roles}

#### cspm.worker {#cspm-worker}

Роль `cspm.worker` позволяет просматривать информацию об [организации](../organization/concepts/organization.md), просматривать список [облаков](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталогов](../resource-manager/concepts/resources-hierarchy.md#folder), а также информацию о них в составе контролируемых ресурсов [окружения](../security-deck/concepts/workspace.md) {{ sd-name }}.

Роль выдается [сервисному аккаунту](concepts/users/service-accounts.md), от имени которого будет выполняться проверка на соответствие [стандартам безопасности](../security-deck/concepts/cspm.md#standards), заданным в настройках [модуля {{ cspm-name }}](../security-deck/concepts/cspm.md), и назначается на организацию, облако или каталог.

#### cspm.auditor {#cspm-auditor}

Роль `cspm.auditor` позволяет просматривать информацию о заданиях проверок инфраструктуры на соответствие [стандартам безопасности](../security-deck/concepts/cspm.md#standards), заданным в настройках [модуля {{ cspm-name }}](../security-deck/concepts/cspm.md).

#### cspm.viewer {#cspm-viewer}

Роль `cspm.viewer` позволяет просматривать информацию о заданиях проверок инфраструктуры на соответствие [стандартам безопасности](../security-deck/concepts/cspm.md#standards), заданным в настройках [модуля {{ cspm-name }}](../security-deck/concepts/cspm.md), о результатах таких проверок, а также о заданных [исключениях](../security-deck/concepts/cspm.md#exceptions) из правил проверок.

Включает разрешения, предоставляемые ролью `cspm.auditor`.

#### cspm.editor {#cspm-editor}

Роль `cspm.editor` позволяет управлять заданиями проверок инфраструктуры на соответствие стандартам безопасности модуля {{ cspm-name }} и исключениями из правил проверок.

Пользователи с этой ролью могут:
* просматривать информацию о заданиях проверок инфраструктуры на соответствие [стандартам безопасности](../security-deck/concepts/cspm.md#standards), заданным в настройках [модуля {{ cspm-name }}](../security-deck/concepts/cspm.md);
* просматривать результаты проверок безопасности модуля {{ cspm-name }};
* создавать, приостанавливать, возобновлять, изменять и удалять задания проверок модуля {{ cspm-name }};
* просматривать заданные [исключения](../security-deck/concepts/cspm.md#exceptions) из правил проверок модуля {{ cspm-name }}, а также создавать и удалять такие исключения.

Включает разрешения, предоставляемые ролью `cspm.viewer`.

#### cspm.admin {#cspm-admin}

Роль `cspm.admin` позволяет управлять заданиями проверок инфраструктуры на соответствие стандартам безопасности модуля {{ cspm-name }} и исключениями из правил проверок.

Пользователи с этой ролью могут:
* просматривать информацию о заданиях проверок инфраструктуры на соответствие [стандартам безопасности](../security-deck/concepts/cspm.md#standards), заданным в настройках [модуля {{ cspm-name }}](../security-deck/concepts/cspm.md);
* просматривать результаты проверок безопасности модуля {{ cspm-name }};
* создавать, приостанавливать, возобновлять, изменять и удалять задания проверок модуля {{ cspm-name }};
* просматривать заданные [исключения](../security-deck/concepts/cspm.md#exceptions) из правил проверок модуля {{ cspm-name }}, а также создавать и удалять такие исключения.

Включает разрешения, предоставляемые ролью `cspm.editor`.

Подробнее см. [Управление доступом в {{ cspm-name }}](../security-deck/security/cspm-roles.md).

### Сервисные роли для анализа данных {{ atr-name }} {#access-transparency-roles}

#### access-transparency.viewer {#access-transparency-viewer}

Роль `access-transparency.viewer` позволяет просматривать список событий доступа к ресурсам организации со стороны сотрудников {{ yandex-cloud }}, а также выражать согласие или несогласие с результатами подготовленного нейросетью анализа таких событий.

#### access-transparency.editor {#access-transparency-editor}

Роль `access-transparency.editor` позволяет выбирать платежный аккаунт в модуле {{ atr-name }}, управлять подписками организации на события доступа к ресурсам организации со стороны сотрудников {{ yandex-cloud }}, просматривать список таких событий, а также выражать согласие или несогласие с результатами подготовленного нейросетью анализа таких событий.

Включает разрешения, предоставляемые ролями `access-transparency.billingProvider` и `access-transparency.subscriptionManager`.

#### access-transparency.admin {#access-transparency-admin}

Роль `access-transparency.admin` позволяет выбирать платежный аккаунт в модуле {{ atr-name }}, управлять подписками организации на события доступа к ресурсам организации со стороны сотрудников {{ yandex-cloud }}, просматривать список таких событий, а также выражать согласие или несогласие с результатами подготовленного нейросетью анализа таких событий.

Включает разрешения, предоставляемые ролью `access-transparency.editor`.

#### access-transparency.billingProvider {#access-transparency-billingProvider}

Роль `access-transparency.billingProvider` позволяет выбирать платежный аккаунт в модуле {{ atr-name }}.

#### access-transparency.subscriptionManager {#access-transparency-subscriptionManager}

Роль `access-transparency.subscriptionManager` позволяет управлять подписками организации на события доступа к ресурсам организации со стороны сотрудников {{ yandex-cloud }}, просматривать список таких событий, а также выражать согласие или несогласие с результатами подготовленного нейросетью анализа таких событий.

Включает разрешения, предоставляемые ролью `access-transparency.viewer`.

Подробнее см. [Управление доступом в {{ atr-name }}](../security-deck/security/access-transparency-roles.md).

### Сервисные роли для модуля {{ alerts-name }} {#alerts-roles}

#### security-deck.alertSinks.user {#security-deck-alertSinks-user}

Роль `security-deck.alertSinks.user` позволяет просматривать информацию о [приемниках алертов](../security-deck/concepts/workspace.md#alert-sinks) и использовать их.

#### security-deck.alertSinks.auditor {#security-deck-alertSinks-auditor}

Роль `security-deck.alertSinks.auditor` позволяет просматривать информацию о [приемниках алертов](../security-deck/concepts/workspace.md#alert-sinks) и назначенных [правах доступа](concepts/access-control/index.md) к ним.

#### security-deck.alertSinks.viewer {#security-deck-alertSinks-viewer}

Роль `security-deck.alertSinks.viewer` позволяет просматривать информацию об алертах и приемниках алертов, а также о назначенных правах доступа к ним.

Пользователи с этой ролью могут:
* просматривать информацию о [приемниках алертов](../security-deck/concepts/workspace.md#alert-sinks) и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию об [алертах](../security-deck/concepts/alerts.md) и назначенных правах доступа к ним;
* просматривать дополнительную информацию об алертах и их источниках, а также перечень затронутых ресурсов и рекомендации по устранению проблем.

Включает разрешения, предоставляемые ролью `security-deck.alertSinks.auditor`.

#### security-deck.alertSinks.editor {#security-deck-alertSinks-editor}

Роль `security-deck.alertSinks.editor` позволяет управлять приемниками алертов, алертами и комментариями в них.

Пользователи с этой ролью могут:
* просматривать информацию о [приемниках алертов](../security-deck/concepts/workspace.md#alert-sinks) и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* создавать, использовать, изменять и удалять приемники алертов;
* просматривать информацию об [алертах](../security-deck/concepts/alerts.md) и назначенных правах доступа к ним;
* просматривать дополнительную информацию об алертах и их источниках, а также перечень затронутых ресурсов и рекомендации по устранению проблем;
* создавать, изменять и удалять алерты;
* просматривать список комментариев к алертам, а также создавать, изменять и удалять комментарии.

Включает разрешения, предоставляемые ролями `security-deck.alertSinks.viewer` и `security-deck.alertSinks.user`.

#### security-deck.alertSinks.admin {#security-deck-alertSinks-admin}

Роль `security-deck.alertSinks.admin` позволяет управлять приемниками алертов и алертами, а также доступом к ним.

Пользователи с этой ролью могут:
* просматривать информацию о [приемниках алертов](../security-deck/concepts/workspace.md#alert-sinks), а также создавать, использовать, изменять и удалять их;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к приемникам алертов и изменять такие права доступа;
* просматривать информацию об [алертах](../security-deck/concepts/alerts.md), а также создавать, изменять и удалять их;
* просматривать информацию о назначенных правах доступа к алертам и изменять такие права доступа;
* просматривать дополнительную информацию об алертах и их источниках, а также перечень затронутых ресурсов и рекомендации по устранению проблем;
* просматривать список комментариев к алертам, а также создавать, изменять и удалять комментарии.

Включает разрешения, предоставляемые ролью `security-deck.alertSinks.editor`.

Подробнее см. [Управление доступом в модуле Алерты](../security-deck/security/alerts-roles.md).


## {{ serverless-containers-full-name }} {#serverless-containers-roles}

#### serverless-containers.auditor {#serverless-containers-auditor}

Роль `serverless-containers.auditor` позволяет просматривать информацию о [контейнерах](../serverless-containers/concepts/container.md), кроме информации о [переменных](../serverless-containers/concepts/runtime.md#environment-variables) окружения [ревизии](../serverless-containers/concepts/container.md#revision).

#### serverless-containers.viewer {#serverless-containers-viewer}

Роль `serverless-containers.viewer` позволяет просматривать информацию о контейнерах, а также об облаке и каталоге.

Пользователи с этой ролью могут:
* просматривать информацию о [контейнерах](../serverless-containers/concepts/container.md), в том числе о [переменных](../serverless-containers/concepts/runtime.md#environment-variables) окружения [ревизии](../serverless-containers/concepts/container.md#revision);
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к контейнерам;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `serverless-containers.auditor`.

#### serverless-containers.editor {#serverless-containers-editor}

Роль `serverless-containers.editor` позволяет управлять контейнерами и просматривать информацию о них, а также об облаке и каталоге.

Пользователи с этой ролью могут:
* создавать, вызывать, изменять и удалять [контейнеры](../serverless-containers/concepts/container.md);
* просматривать информацию о контейнерах, в том числе о [переменных](../serverless-containers/concepts/runtime.md#environment-variables) окружения [ревизии](../serverless-containers/concepts/container.md#revision), а также о назначенных [правах доступа](concepts/access-control/index.md) к контейнерам;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `serverless-containers.viewer`.

#### serverless-containers.admin {#serverless-containers-admin}

Роль `serverless-containers.admin` позволяет управлять контейнерами и доступом к ним, а также просматривать информацию о контейнерах, облаке и каталоге.

Пользователи с этой ролью могут:
* создавать, вызывать, изменять и удалять [контейнеры](../serverless-containers/concepts/container.md);
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к контейнерам и изменять права доступа;
* просматривать информацию о контейнерах, в том числе о [переменных](../serverless-containers/concepts/runtime.md#environment-variables) окружения [ревизии](../serverless-containers/concepts/container.md#revision);
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `serverless-containers.editor`.

#### serverless-containers.containerInvoker {#serverless-containers-containerinvoker}

Роль `serverless-containers.containerInvoker` позволяет вызывать [контейнеры](../serverless-containers/concepts/container.md).

#### serverless.containers.viewer {#serverless-containers-viewer-deprecated}

Роль `serverless.containers.viewer` позволяет просматривать информацию о контейнерах, а также об облаке и каталоге.

Пользователи с этой ролью могут:
* просматривать информацию о контейнерах, в том числе о переменных окружения ревизии;
* просматривать информацию о назначенных правах доступа к контейнерам;
* просматривать информацию об облаке;
* просматривать информацию о каталоге.

Эта роль недоступна. Используйте роль `serverless-containers.viewer`.

#### serverless.containers.editor {#serverless-containers-editor-deprecated}

Роль `serverless.containers.editor` позволяет управлять контейнерами и просматривать информацию о них, а также об облаке и каталоге.

Пользователи с этой ролью могут:
* создавать, вызывать, изменять и удалять контейнеры;
* просматривать информацию о контейнерах, в том числе о переменных окружения ревизии, а также о назначенных правах доступа к контейнерам;
* просматривать информацию об облаке;
* просматривать информацию о каталоге.

Эта роль недоступна. Используйте роль `serverless-containers.editor`.

#### serverless.containers.admin {#serverless-containers-admin-deprecated}

Роль `serverless.containers.admin` позволяет управлять контейнерами и доступом к ним, а также просматривать информацию о контейнерах, облаке и каталоге.

Пользователи с этой ролью могут:
* создавать, вызывать, изменять и удалять контейнеры;
* просматривать информацию о назначенных правах доступа к контейнерам и изменять права доступа;
* просматривать информацию о контейнерах, в том числе о переменных окружения ревизии;
* просматривать информацию об облаке;
* просматривать информацию о каталоге.

Эта роль недоступна. Используйте роль `serverless-containers.admin`.

#### serverless.containers.invoker {#serverless-containers-invoker-deprecated}

Роль `serverless.containers.invoker` позволяет вызывать контейнеры.

Эта роль недоступна. Используйте роль `serverless-containers.containerInvoker`.

Подробнее см. [{#T}](../serverless-containers/security/index.md).


## {{ si-full-name }} {#serverless-integrations-roles}

### Сервисные роли {{ er-full-name }} {#eventrouter-roles}

#### serverless.eventrouter.auditor {#serverless-eventrouter-auditor}

Роль `serverless.eventrouter.auditor` позволяет просматривать информацию о [шинах](../serverless-integrations/concepts/eventrouter/bus.md), [коннекторах](../serverless-integrations/concepts/eventrouter/connector.md) и [правилах](../serverless-integrations/concepts/eventrouter/rule.md), а также о назначенных [правах доступа](concepts/access-control/index.md) к ним.

#### serverless.eventrouter.viewer {#serverless-eventrouter-viewer}

Роль `serverless.eventrouter.viewer` позволяет просматривать информацию о [шинах](../serverless-integrations/concepts/eventrouter/bus.md), [коннекторах](../serverless-integrations/concepts/eventrouter/connector.md) и [правилах](../serverless-integrations/concepts/eventrouter/rule.md), а также о назначенных [правах доступа](concepts/access-control/index.md) к ним.

Включает разрешения, предоставляемые ролью `serverless.eventrouter.auditor`.

#### serverless.eventrouter.supplier {#serverless-eventrouter-supplier}

Роль `serverless.eventrouter.supplier` позволяет отправлять пользовательские события в шины, а также передавать события аудита.

Пользователи с этой ролью могут:
* отправлять пользовательские события в [шины](../serverless-integrations/concepts/eventrouter/bus.md) с помощью вызова gRPC API [EventService/Send](../serverless-integrations/eventrouter/api-ref/grpc/Event/send.md);
* отправлять пользовательские события в шины с помощью вызова gRPC API [EventService/Put](../serverless-integrations/eventrouter/api-ref/grpc/Event/put.md);
* передавать события аудита.

#### serverless.eventrouter.editor {#serverless-eventrouter-editor}

Роль `serverless.eventrouter.editor` позволяет управлять шинами, коннекторами и правилами, а также отправлять в шины пользовательские и аудитные события.

Пользователи с этой ролью могут:
* просматривать информацию о [шинах](../serverless-integrations/concepts/eventrouter/bus.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также создавать, изменять и удалять шины;
* просматривать информацию о [коннекторах](../serverless-integrations/concepts/eventrouter/connector.md) и назначенных правах доступа к ним, а также создавать, изменять и удалять коннекторы;
* просматривать информацию о [правилах](../serverless-integrations/concepts/eventrouter/rule.md) и назначенных правах доступа к ним, а также создавать, изменять и удалять правила;
* отправлять пользовательские события в шины с помощью вызова gRPC API [EventService/Send](../serverless-integrations/eventrouter/api-ref/grpc/Event/send.md);
* отправлять пользовательские события в шины с помощью вызова gRPC API [EventService/Put](../serverless-integrations/eventrouter/api-ref/grpc/Event/put.md);
* передавать события аудита.

Включает разрешения, предоставляемые ролями `serverless.eventrouter.viewer` и `serverless.eventrouter.supplier`.

#### serverless.eventrouter.admin {#serverless-eventrouter-admin}

Роль `serverless.eventrouter.admin` позволяет управлять шинами, коннекторами, правилами и доступом к ним, а также отправлять в шины пользовательские и аудитные события.

Пользователи с этой ролью могут:
* просматривать информацию о [шинах](../serverless-integrations/concepts/eventrouter/bus.md), а также создавать, изменять и удалять их;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к шинам, а также изменять такие права доступа;
* просматривать информацию о [коннекторах](../serverless-integrations/concepts/eventrouter/connector.md), а также создавать, изменять и удалять их;
* просматривать информацию о назначенных правах доступа к коннекторам, а также изменять такие права доступа;
* просматривать информацию о [правилах](../serverless-integrations/concepts/eventrouter/rule.md), а также создавать, изменять и удалять их;
* просматривать информацию о назначенных правах доступа к правилам, а также изменять такие права доступа;
* отправлять пользовательские события в шины с помощью вызова gRPC API [EventService/Send](../serverless-integrations/eventrouter/api-ref/grpc/Event/send.md);
* отправлять пользовательские события в шины с помощью вызова gRPC API [EventService/Put](../serverless-integrations/eventrouter/api-ref/grpc/Event/put.md);
* передавать события аудита;
* просматривать информацию о [квотах](../serverless-integrations/concepts/limits.md#eventrouter) EventRouter.

Включает разрешения, предоставляемые ролью `serverless.eventrouter.editor`.

Подробнее см. [Управление доступом в {{ er-name }}](../serverless-integrations/security/eventrouter.md).

### Сервисные роли {{ sw-full-name }} {#workflows-roles}

#### serverless.workflows.auditor {#serverless-workflows-auditor}

Роль `serverless.workflows.auditor` позволяет просматривать информацию о [рабочих процессах](../serverless-integrations/concepts/workflows/workflow.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, просматривать историю [запусков](../serverless-integrations/concepts/workflows/execution.md) рабочих процессов, а также информацию о [квотах](../serverless-integrations/concepts/limits.md#workflows) Yandex Workflows.

#### serverless.workflows.viewer {#serverless-workflows-viewer}

Роль `serverless.workflows.viewer` позволяет просматривать информацию о [рабочих процессах](../serverless-integrations/concepts/workflows/workflow.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, просматривать историю [запусков](../serverless-integrations/concepts/workflows/execution.md) рабочих процессов, а также информацию о [квотах](../serverless-integrations/concepts/limits.md#workflows) Yandex Workflows.

Включает разрешения, предоставляемые ролью `serverless.workflows.auditor`.

#### serverless.workflows.executor {#serverless-workflows-executor}

Роль `serverless.workflows.executor` позволяет запускать, приостанавливать, возобновлять и останавливать [рабочие процессы](../serverless-integrations/concepts/workflows/workflow.md) Yandex Workflows.

#### serverless.workflows.editor {#serverless-workflows-editor}

Роль `serverless.workflows.editor` позволяет управлять рабочими процессами.

Пользователи с этой ролью могут:
* просматривать информацию о [рабочих процессах](../serverless-integrations/concepts/workflows/workflow.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* создавать, изменять и удалять рабочие процессы;
* запускать, приостанавливать, возобновлять и останавливать рабочие процессы;
* просматривать историю [запусков](../serverless-integrations/concepts/workflows/execution.md) рабочих процессов;
* просматривать информацию о [квотах](../serverless-integrations/concepts/limits.md#workflows) Yandex Workflows.

Включает разрешения, предоставляемые ролями `serverless.workflows.viewer` и `serverless.workflows.executor`.

#### serverless.workflows.admin {#serverless-workflows-admin}

Роль `serverless.workflows.admin` позволяет управлять рабочими процессами.

Пользователи с этой ролью могут:
* просматривать информацию о [рабочих процессах](../serverless-integrations/concepts/workflows/workflow.md), а также создавать, изменять и удалять их;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к рабочим процессам, а также изменять такие права доступа;
* запускать, приостанавливать, возобновлять и останавливать рабочие процессы;
* просматривать историю [запусков](../serverless-integrations/concepts/workflows/execution.md) рабочих процессов;
* просматривать информацию о [квотах](../serverless-integrations/concepts/limits.md#workflows) Yandex Workflows.

Включает разрешения, предоставляемые ролью `serverless.workflows.editor`.

Подробнее см. [Управление доступом в {{ sw-name }}](../serverless-integrations/security/workflows.md).


## {{ yandex-siem-full-name }} {#yandex-siem-roles}

#### ycem.inspector {#ycem-inspector}

Роль `ycem.inspector` позволяет управлять запросами, расследованиями и датасетами.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать информацию о [расследованиях](../yandex-siem/concepts/investigations.md), а также создавать, обновлять, удалять и выполнять расследования;
* просматривать информацию о [датасетах](../yandex-siem/concepts/investigations.md#datasets-schema), а также создавать, обновлять и удалять датасеты;
* просматривать информацию о [запросах](../yandex-siem/concepts/queries.md), а также создавать, обновлять, удалять и выполнять запросы;
* просматривать информацию об [инстансах](../yandex-siem/concepts/index.md) {{ yandex-siem-full-name }}.

{% endcut %}

#### ycem.executor {#ycem-executor}

Роль `ycem.executor` позволяет управлять запросами, расследованиями, датасетами, а также правилами корреляции.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать информацию о [расследованиях](../yandex-siem/concepts/investigations.md), а также создавать, обновлять, удалять и выполнять расследования;
* просматривать информацию о [датасетах](../yandex-siem/concepts/investigations.md#datasets-schema) и их содержимом, а также создавать, обновлять и удалять датасеты;
* просматривать информацию о [запросах](../yandex-siem/concepts/queries.md), а также создавать, обновлять, удалять и выполнять запросы;
* просматривать информацию о [правилах корреляции](../yandex-siem/concepts/correlation-rules.md#correlation-rules), а также обновлять правила корреляции;
* просматривать информацию об [исключениях](../yandex-siem/concepts/correlation-rules.md#exceptions), а также список запросов, которые используют эти исключения;
* просматривать информацию об [инстансах](../yandex-siem/concepts/index.md) {{ yandex-siem-full-name }} и версии их компонентов.

{% endcut %}

Включает разрешения, предоставляемые ролью `ycem.inspector`.

Подробнее см. [{#T}](../yandex-siem/security/index.md).


## {{ captcha-full-name }} {#captcha-roles}

#### smart-captcha.auditor {#smart-captcha-auditor}

Роль `smart-captcha.auditor` позволяет просматривать информацию о [капчах](../smartcaptcha/concepts/validation.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним.

#### smart-captcha.viewer {#smart-captcha-viewer}

Роль `smart-captcha.viewer` позволяет просматривать информацию о [капчах](../smartcaptcha/concepts/validation.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также получать [ключи](../smartcaptcha/concepts/keys.md) капчи.

Включает разрешения, предоставляемые ролью `smart-captcha.auditor`.

#### smart-captcha.editor {#smart-captcha-editor}

Роль `smart-captcha.editor` позволяет управлять капчами, просматривать информацию о них и получать ключи капчи.

Пользователи с этой ролью могут:
* просматривать информацию о [капчах](../smartcaptcha/concepts/validation.md), а также создавать, изменять и удалять их;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к капчам;
* получать [ключи капчи](../smartcaptcha/concepts/keys.md).

Включает разрешения, предоставляемые ролью `smart-captcha.viewer`.

#### smart-captcha.admin {#smart-captcha-admin}

Роль `smart-captcha.admin` позволяет управлять капчами и доступом к ним, а также получать ключи капчи.

Пользователи с этой ролью могут:
* просматривать информацию о [капчах](../smartcaptcha/concepts/validation.md), а также создавать, изменять и удалять их;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к капчам и изменять такие права доступа;
* получать [ключи капчи](../smartcaptcha/concepts/keys.md).

Включает разрешения, предоставляемые ролью `smart-captcha.editor`.

Подробнее см. [{#T}](../smartcaptcha/security/index.md).


## {{ sws-full-name }} {#sws-roles}

#### smart-web-security.auditor {#smart-web-security-auditor}

Роль `smart-web-security.auditor` позволяет просматривать метаданные ресурсов сервиса {{ sws-name }}, а также информацию об облаке и каталоге.

Пользователи с этой ролью могут:
* просматривать информацию о [профилях безопасности](../smartwebsecurity/concepts/profiles.md);
* просматривать список [ресурсов](../smartwebsecurity/operations/host-connect.md), к которым подключен профиль безопасности;
* просматривать информацию о [профилях WAF](../smartwebsecurity/concepts/waf.md);
* просматривать информацию о [профилях ARL](../smartwebsecurity/concepts/arl.md);
* просматривать информацию о [прокси-серверах](../smartwebsecurity/concepts/domain-protect.md#proxy);
* просматривать информацию о [списках](../smartwebsecurity/concepts/lists.md);
* просматривать информацию о [шаблонах страниц ответов](../smartwebsecurity/concepts/response-templates.md);
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Назначить роль `smart-web-security.auditor` может пользователь с ролью `admin` в облаке или `smart-web-security.admin` в каталоге.

#### smart-web-security.viewer {#smart-web-security-viewer}

Роль `smart-web-security.viewer` позволяет просматривать информацию о ресурсах сервиса {{ sws-name }}, а также об облаке и каталоге.

Пользователи с этой ролью могут:
* просматривать информацию о [профилях безопасности](../smartwebsecurity/concepts/profiles.md);
* просматривать список [ресурсов](../smartwebsecurity/operations/host-connect.md), к которым подключен профиль безопасности;
* просматривать информацию о [профилях WAF](../smartwebsecurity/concepts/waf.md);
* просматривать информацию о [профилях ARL](../smartwebsecurity/concepts/arl.md);
* просматривать информацию о [прокси-серверах](../smartwebsecurity/concepts/domain-protect.md#proxy);
* просматривать информацию о [списках](../smartwebsecurity/concepts/lists.md);
* просматривать информацию о [шаблонах страниц ответов](../smartwebsecurity/concepts/response-templates.md);
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `smart-web-security.auditor`.

Назначить роль `smart-web-security.viewer` может пользователь с ролью `admin` в облаке или `smart-web-security.admin` в каталоге.

#### smart-web-security.user {#smart-web-security-user}

Роль `smart-web-security.user` позволяет просматривать информацию о ресурсах сервиса {{ sws-name }}, а также подключать профили безопасности к защищаемым ресурсам.

Пользователи с этой ролью могут:
* просматривать информацию о [профилях безопасности](../smartwebsecurity/concepts/profiles.md) {{ sws-name }} и подключать их к защищаемым ресурсам;
* просматривать список [ресурсов](../smartwebsecurity/operations/host-connect.md), к которым подключен профиль безопасности;
* просматривать информацию о [профилях WAF](../smartwebsecurity/concepts/waf.md);
* просматривать информацию о [профилях ARL](../smartwebsecurity/concepts/arl.md);
* просматривать информацию о [прокси-серверах](../smartwebsecurity/concepts/domain-protect.md#proxy);
* просматривать информацию о [списках](../smartwebsecurity/concepts/lists.md);
* просматривать информацию о [шаблонах страниц ответов](../smartwebsecurity/concepts/response-templates.md);
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `smart-web-security.viewer`.

Назначить роль `smart-web-security.user` может пользователь с ролью `admin` в облаке или `smart-web-security.admin` в каталоге.

#### smart-web-security.editor {#smart-web-security-editor}

Роль `smart-web-security.editor` позволяет использовать ресурсы сервиса {{ sws-name }} и управлять ими.

Пользователи с этой ролью могут:
* просматривать информацию о [профилях безопасности](../smartwebsecurity/concepts/profiles.md) {{ sws-name }}, создавать, изменять и удалять их, а также подключать профили безопасности к защищаемым ресурсам;
* просматривать список [ресурсов](../smartwebsecurity/operations/host-connect.md), к которым подключен профиль безопасности;
* просматривать информацию о [профилях WAF](../smartwebsecurity/concepts/waf.md), а также создавать, изменять, использовать и удалять их;
* просматривать информацию о [профилях ARL](../smartwebsecurity/concepts/arl.md), а также создавать, изменять, использовать и удалять их;
* просматривать информацию о [прокси-серверах](../smartwebsecurity/concepts/domain-protect.md#proxy), а также создавать, изменять и удалять их;
* просматривать информацию о [списках](../smartwebsecurity/concepts/lists.md), а также создавать, изменять, использовать и удалять их;
* просматривать информацию о [шаблонах страниц ответов](../smartwebsecurity/concepts/response-templates.md), а также создавать, изменять, использовать и удалять их;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `smart-web-security.user`.

Чтобы включать или отключать [логирование](../smartwebsecurity/concepts/logging.md) в профиле безопасности, дополнительно необходима роль `logging.writer` или выше на [лог-группу](../logging/concepts/log-group.md), в которую передаются логи.

Назначить роль `smart-web-security.editor` может пользователь с ролью `admin` в облаке или `smart-web-security.admin` в каталоге.

#### smart-web-security.admin {#smart-web-security-admin}

Роль `smart-web-security.admin` позволяет использовать ресурсы сервиса {{ sws-name }} и управлять ими.

Пользователи с этой ролью могут:
* просматривать информацию о [профилях безопасности](../smartwebsecurity/concepts/profiles.md) {{ sws-name }}, создавать, изменять и удалять их, а также подключать профили безопасности к защищаемым ресурсам;
* просматривать список [ресурсов](../smartwebsecurity/operations/host-connect.md), к которым подключен профиль безопасности;
* просматривать информацию о [профилях WAF](../smartwebsecurity/concepts/waf.md), а также создавать, изменять, использовать и удалять их;
* просматривать информацию о [профилях ARL](../smartwebsecurity/concepts/arl.md), а также создавать, изменять, использовать и удалять их;
* просматривать информацию о [прокси-серверах](../smartwebsecurity/concepts/domain-protect.md#proxy), а также создавать, изменять и удалять их;
* просматривать информацию о [списках](../smartwebsecurity/concepts/lists.md), а также создавать, изменять, использовать и удалять их;
* просматривать информацию о [шаблонах страниц ответов](../smartwebsecurity/concepts/response-templates.md), а также создавать, изменять, использовать и удалять их;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `smart-web-security.editor`.

Чтобы включать или отключать [логирование](../smartwebsecurity/concepts/logging.md) в профиле безопасности, дополнительно необходима роль `logging.writer` или выше на [лог-группу](../logging/concepts/log-group.md), в которую передаются логи.

Назначить роль `smart-web-security.admin` может пользователь с ролью `admin` в облаке.

Подробнее см. [{#T}](../smartwebsecurity/security/index.md).


## {{ speechkit-full-name }} {#speechkit-roles}

#### ai.speechkit-stt.user {#ai-speechkit-stt-user}

Роль `ai.speechkit-stt.user` позволяет использовать сервис {{ speechkit-full-name }} для [распознавания]({{ link-docs-ai }}speechkit/stt/) речи, а также просматривать информацию об [облаке]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#cloud), [каталоге]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#folder) и [квотах]({{ link-docs-ai }}speechkit/concepts/limits#speechkit-quotas) сервиса.

#### ai.speechkit-tts.user {#ai-speechkit-tts-user}

Роль `ai.speechkit-tts.user` позволяет использовать сервис {{ speechkit-full-name }} для [синтеза]({{ link-docs-ai }}speechkit/tts/) речи, а также просматривать информацию об [облаке]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#cloud), [каталоге]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#folder) и [квотах]({{ link-docs-ai }}speechkit/concepts/limits#speechkit-quotas) сервиса.

Подробнее см. [Управление доступом в {{ speechkit-name }}]({{ link-docs-ai }}speechkit/security/index).


## {{ speechsense-full-name }} {#speechsense-roles}

#### speech-sense.auditor {#speechsense-auditor}

Роль `speech-sense.auditor` позволяет просматривать название, описание и список участников [проекта]({{ link-docs-ai }}speechsense/concepts/resources-hierarchy#project) или [пространства]({{ link-docs-ai }}speechsense/concepts/resources-hierarchy#space) и всех его проектов. Роль не дает доступа к данным проекта.

#### speech-sense.viewer {#speechsense-viewer}

Роль `speech-sense.viewer` позволяет просматривать характеристики [проекта]({{ link-docs-ai }}speechsense/concepts/resources-hierarchy#project) или [пространства]({{ link-docs-ai }}speechsense/concepts/resources-hierarchy#space), список участников, список [подключений]({{ link-docs-ai }}speechsense/concepts/resources-hierarchy#connection) и дашборды.

Включает разрешения, предоставляемые ролью `speech-sense.auditor`.

#### speech-sense.editor {#speechsense-editor}

Роль `speech-sense.editor` позволяет редактировать [проект]({{ link-docs-ai }}speechsense/concepts/resources-hierarchy#project), его описание, дашборды и алерты, создавать и редактировать его классификаторы и запускать анализ. Назначенная на [пространство]({{ link-docs-ai }}speechsense/concepts/resources-hierarchy#space) роль позволяет редактировать пространство и создавать в нем проекты, [подключения]({{ link-docs-ai }}speechsense/concepts/resources-hierarchy#connection) и [словари]({{ link-docs-ai }}speechsense/concepts/dictionaries).

Включает разрешения, предоставляемые ролями `speech-sense.viewer` и `speech-sense.spaces.creator`.

#### speech-sense.admin {#speechsense-admin}

Роль `speech-sense.admin`, назначенная на [пространство]({{ link-docs-ai }}speechsense/concepts/resources-hierarchy#space) или [проект]({{ link-docs-ai }}speechsense/concepts/resources-hierarchy#project), позволяет выполнять любые действия в нем: просматривать [диалоги]({{ link-docs-ai }}speechsense/concepts/dialogs), редактировать [подключения]({{ link-docs-ai }}speechsense/concepts/resources-hierarchy#connection), запускать [анализ]({{ link-docs-ai }}speechsense/concepts/assistants#analysis). Роль дает право назначать роли другим пользователям.

Включает разрешения, предоставляемые ролями `speech-sense.editor` и `speech-sense.data.editor`.

#### speech-sense.spaces.creator {#speechsense-spaces-creator}

Роль `speech-sense.spaces.creator` позволяет создавать [пространства]({{ link-docs-ai }}speechsense/concepts/resources-hierarchy#space) в {{ speechsense-name }}.

#### speech-sense.data.viewer {#speechsense-data-viewer}

Роль `speech-sense.data.viewer` позволяет просматривать название и описание [проекта]({{ link-docs-ai }}speechsense/concepts/resources-hierarchy#project), список [подключений]({{ link-docs-ai }}speechsense/concepts/resources-hierarchy#connection) и дашборды, список участников проекта, а также дает возможность искать по документам, прослушивать [диалоги]({{ link-docs-ai }}speechsense/concepts/dialogs) и просматривать текстовые [расшифровки]({{ link-docs-ai }}speechsense/concepts/dialogs#contents). При назначении роли на пространство дает возможность просматривать все проекты этого [пространства]({{ link-docs-ai }}speechsense/concepts/resources-hierarchy#space), но не дает права редактировать их.

#### speech-sense.data.editor {#speechsense-data-editor}

Роль `speech-sense.data.editor` позволяет загружать [диалоги]({{ link-docs-ai }}speechsense/concepts/dialogs) в [подключения]({{ link-docs-ai }}speechsense/concepts/resources-hierarchy#connection) [проекта]({{ link-docs-ai }}speechsense/concepts/resources-hierarchy#project) или [пространства]({{ link-docs-ai }}speechsense/concepts/resources-hierarchy#space), оценивать диалоги и писать комментарии к ним в системе.

Включает разрешения, предоставляемые ролью `speech-sense.data.viewer`.

Пользователи с ролями вида `speech-sense.data.*` могут просматривать и оценивать содержимое документов, но не имеют доступа к агрегированной информации.

Подробнее см. [Управление доступом в {{ speechsense-name }}]({{ link-docs-ai }}speechsense/security/).


## {{ translate-full-name }} {#translate-roles}

#### ai.translate.user {#translate-user}

Роль `ai.translate.user` позволяет использовать сервис {{ translate-full-name }} для [перевода текста]({{ link-docs-ai }}translate/quickstart), а также просматривать информацию об [облаке]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#cloud), [каталоге]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#folder) и [квотах]({{ link-docs-ai }}translate/concepts/limits#translate-quotas) сервиса.

Подробнее см. [Управление доступом в {{ translate-name }}]({{ link-docs-ai }}translate/security/index).


## {{ vpc-full-name }} {#vpc-roles}

#### vpc.auditor {#vpc-auditor}

Роль `vpc.auditor` позволяет просматривать метаданные сервиса, в том числе информацию об облачных сетях, подсетях, таблицах маршрутизации, шлюзах, группах безопасности и IP-адресах, а также о квотах и операциях с ресурсами сервиса.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать список [облачных сетей](../vpc/concepts/network.md#network) и информацию о них;
* просматривать список [подсетей](../vpc/concepts/network.md#subnet) и информацию о них;
* просматривать список [адресов облачных ресурсов](../vpc/concepts/address.md) и информацию о них;
* просматривать список [таблиц маршрутизации](../vpc/concepts/routing.md#rt-vpc) и информацию о них;
* просматривать список [групп безопасности](../vpc/concepts/security-groups.md) и информацию о них;
* просматривать информацию о [NAT-шлюзах](../vpc/concepts/gateways.md);
* просматривать информацию об использованных IP-адресах в подсетях;
* просматривать информацию о [квотах](../vpc/concepts/limits.md#vpc-quotas) сервиса {{ vpc-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ vpc-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ compute-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

#### vpc.viewer {#vpc-viewer}

Роль `vpc.viewer` позволяет просматривать информацию об облачных сетях, подсетях, таблицах маршрутизации, шлюзах, группах безопасности и IP-адресах, а также о квотах и операциях с ресурсами сервиса.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать список [облачных сетей](../vpc/concepts/network.md#network) и информацию о них;
* просматривать список [подсетей](../vpc/concepts/network.md#subnet) и информацию о них;
* просматривать список [адресов облачных ресурсов](../vpc/concepts/address.md) и информацию о них;
* просматривать список [таблиц маршрутизации](../vpc/concepts/routing.md#rt-vpc) и информацию о них;
* просматривать список [групп безопасности](../vpc/concepts/security-groups.md) и информацию о них;
* просматривать информацию о [NAT-шлюзах](../vpc/concepts/gateways.md);
* просматривать информацию об использованных IP-адресах в подсетях;
* просматривать информацию о [квотах](../vpc/concepts/limits.md#vpc-quotas) сервиса {{ vpc-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ vpc-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ compute-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролью `vpc.auditor`.

#### vpc.user {#vpc-user}

Роль `vpc.user` позволяет использовать облачные сети, подсети, таблицы маршрутизации, шлюзы, группы безопасности и IP-адреса, получать информацию об этих ресурсах, а также о квотах и операциях с ресурсами сервиса.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать список [облачных сетей](../vpc/concepts/network.md#network) и информацию о них, а также использовать облачные сети;
* просматривать список [подсетей](../vpc/concepts/network.md#subnet) и информацию о них, а также использовать подсети;
* просматривать список [адресов облачных ресурсов](../vpc/concepts/address.md) и информацию о них, а также использовать такие адреса;
* просматривать список [таблиц маршрутизации](../vpc/concepts/routing.md#rt-vpc) и информацию о них, а также использовать таблицы маршрутизации;
* просматривать список [групп безопасности](../vpc/concepts/security-groups.md) и информацию о них, а также использовать группы безопасности;
* просматривать информацию о [NAT-шлюзах](../vpc/concepts/gateways.md) и подключать их к таблицам маршрутизации;
* просматривать информацию об использованных IP-адресах в подсетях;
* просматривать информацию о [квотах](../vpc/concepts/limits.md#vpc-quotas) сервиса {{ vpc-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ vpc-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ compute-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролью `vpc.viewer`.

#### vpc.externalAddresses.user {#vpc-externalAddresses-user}

Роль `vpc.externalAddresses.user` позволяет просматривать список [внутренних](../vpc/concepts/address.md#internal-addresses) и [публичных](../vpc/concepts/address.md#public-addresses) адресов облачных ресурсов и информацию об этих адресах, использовать их, а также управлять внешней сетевой связностью.

#### vpc.admin {#vpc-admin}

Роль `vpc.admin` позволяет управлять облачными сетями, подсетями, таблицами маршрутизации, NAT-шлюзами, группами безопасности, внутренними и публичными IP-адресами, а также внешней сетевой связностью.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать список [облачных сетей](../vpc/concepts/network.md#network) и информацию о них, а также создавать, изменять и удалять облачные сети;
* настраивать внешний доступ к облачным сетям;
* управлять связностью нескольких облачных сетей;
* управлять мультиинтерфейсными ВМ, обеспечивающими связность между несколькими сетями;
* просматривать список [подсетей](../vpc/concepts/network.md#subnet) и информацию о них, а также создавать, изменять и удалять подсети;
* просматривать список [таблиц маршрутизации](../vpc/concepts/routing.md#rt-vpc) и информацию о них, а также создавать, изменять и удалять таблицы маршрутизации;
* привязывать таблицы маршрутизации к подсетям;
* просматривать информацию о [NAT-шлюзах](../vpc/concepts/gateways.md), а также создавать, изменять и удалять их;
* просматривать список [групп безопасности](../vpc/concepts/security-groups.md) и информацию о них, а также создавать, изменять и удалять группы безопасности;
* создавать и удалять в [облачных сетях](../vpc/concepts/network.md#network) группы безопасности по умолчанию;
* создавать и удалять [правила](../vpc/concepts/security-groups.md#security-groups-rules) групп безопасности, изменять их метаданные;
* настраивать [DHCP](../vpc/concepts/dhcp-options.md) в подсетях;
* просматривать список [адресов облачных ресурсов](../vpc/concepts/address.md) и информацию о них, а также создавать, изменять и удалять внутренние и публичные IP-адреса;
* просматривать информацию об использованных IP-адресах в подсетях;
* просматривать информацию о [квотах](../vpc/concepts/limits.md#vpc-quotas) сервиса {{ vpc-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ vpc-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ compute-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролями `vpc.privateAdmin`, `vpc.publicAdmin` и `vpc.securityGroups.admin`.

#### vpc.bridgeAdmin {#vpc-bridge-admin}

Роль `vpc.bridgeAdmin` позволяет использовать подсети и управлять связностью нескольких облачных сетей. Роль также позволяет просматривать информацию об облачных сетях, подсетях, таблицах маршрутизации, шлюзах, группах безопасности и IP-адресах, а также о квотах и операциях с ресурсами сервиса.

{% cut "Пользователи с этой ролью могут:" %}

* управлять связностью нескольких облачных сетей;
* просматривать список [подсетей](../vpc/concepts/network.md#subnet) и информацию о них, а также использовать подсети;
* просматривать список [облачных сетей](../vpc/concepts/network.md#network) и информацию о них;
* просматривать список [адресов облачных ресурсов](../vpc/concepts/address.md) и информацию о них;
* просматривать список [таблиц маршрутизации](../vpc/concepts/routing.md#rt-vpc) и информацию о них;
* просматривать список [групп безопасности](../vpc/concepts/security-groups.md) и информацию о них;
* просматривать информацию о [NAT-шлюзах](../vpc/concepts/gateways.md);
* просматривать информацию об использованных IP-адресах в подсетях;
* просматривать информацию о [квотах](../vpc/concepts/limits.md#vpc-quotas) сервиса {{ vpc-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ vpc-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ compute-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролью `vpc.viewer`.

#### vpc.privateAdmin {#vpc-private-admin}

Роль `vpc.privateAdmin` позволяет управлять облачными сетями, подсетями и таблицами маршрутизации, а также просматривать информацию о квотах, ресурсах и операциях с ресурсами сервиса. Роль позволяет управлять сетевой связностью внутри {{ yandex-cloud }}, но не из интернета.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать список [облачных сетей](../vpc/concepts/network.md#network) и информацию о них, а также создавать, изменять и удалять облачные сети;
* просматривать список [подсетей](../vpc/concepts/network.md#subnet) и информацию о них, а также создавать, изменять и удалять подсети;
* просматривать список [таблиц маршрутизации](../vpc/concepts/routing.md#rt-vpc) и информацию о них, а также создавать, изменять и удалять таблицы маршрутизации;
* привязывать таблицы маршрутизации к подсетям;
* просматривать список [групп безопасности](../vpc/concepts/security-groups.md) и информацию о них, а также создавать в облачных сетях группы безопасности по умолчанию;
* настраивать [DHCP](../vpc/concepts/dhcp-options.md) в подсетях;
* просматривать список [адресов облачных ресурсов](../vpc/concepts/address.md) и информацию о них, а также создавать внутренние IP-адреса;
* просматривать информацию о [NAT-шлюзах](../vpc/concepts/gateways.md);
* просматривать информацию об использованных IP-адресах в подсетях;
* просматривать информацию о [квотах](../vpc/concepts/limits.md#vpc-quotas) сервиса {{ vpc-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ vpc-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ compute-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролью `vpc.viewer`.

#### vpc.publicAdmin {#vpc-public-admin}

Роль `vpc.publicAdmin` позволяет управлять NAT-шлюзами, публичными IP-адресами и внешней сетевой связностью, а также просматривать информацию о квотах, ресурсах и операциях с ресурсами сервиса. Роль предоставляет права администратора мультиинтерфейсных ВМ, обеспечивающих связность между несколькими сетями.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать список [облачных сетей](../vpc/concepts/network.md#network) и информацию о них, а также настраивать внешний доступ к облачным сетям;
* управлять связностью нескольких облачных сетей;
* управлять мультиинтерфейсными ВМ, обеспечивающими связность между несколькими сетями;
* просматривать список [подсетей](../vpc/concepts/network.md#subnet) и информацию о них, а также изменять подсети;
* просматривать информацию о [NAT-шлюзах](../vpc/concepts/gateways.md), а также создавать, изменять и удалять их;
* просматривать список [адресов облачных ресурсов](../vpc/concepts/address.md) и информацию о них, а также создавать, изменять и удалять публичные IP-адреса;
* просматривать список [таблиц маршрутизации](../vpc/concepts/routing.md#rt-vpc) и информацию о них, а также привязывать таблицы маршрутизации к подсетям;
* просматривать список [групп безопасности](../vpc/concepts/security-groups.md) и информацию о них;
* просматривать информацию об использованных IP-адресах в подсетях;
* просматривать информацию о [квотах](../vpc/concepts/limits.md#vpc-quotas) сервиса {{ vpc-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ vpc-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ compute-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролью `vpc.viewer`.

Роль можно назначить на облако или каталог.

{% note warning %}

Если сеть и подсеть находятся в разных каталогах, то наличие роли `vpc.publicAdmin` проверяется на том каталоге, в котором находится сеть.

{% endnote %}

#### vpc.gateways.viewer {#vpc-gw-viewer}

Роль `vpc.gateways.viewer` позволяет просматривать информацию о [NAT-шлюзах](../vpc/concepts/gateways.md).

#### vpc.gateways.user {#vpc-gw-user}

Роль `vpc.gateways.user` позволяет просматривать информацию о [NAT-шлюзах](../vpc/concepts/gateways.md) и подключать их к [таблицам маршрутизации](../vpc/concepts/routing.md#rt-vpc).

#### vpc.gateways.editor {#vpc-gw-editor}

Роль `vpc.gateways.editor` позволяет просматривать информацию о [NAT-шлюзах](../vpc/concepts/gateways.md), а также создавать, изменять и удалять их.

#### vpc.securityGroups.user {#vpc-sg-user}

Роль `vpc.securityGroups.user` позволяет назначать группы безопасности сетевым интерфейсам и просматривать информацию о ресурсах сервиса, а также о квотах и операциях с ресурсами сервиса.

{% cut "Пользователи с этой ролью могут:" %}

* назначать группы безопасности сетевым интерфейсам виртуальных машин;
* получать список [облачных сетей](../vpc/concepts/network.md#network) и просматривать информацию о них;
* получать список [подсетей](../vpc/concepts/network.md#subnet) и просматривать информацию о них;
* получать список [адресов облачных ресурсов](../vpc/concepts/address.md) и просматривать информацию о них;
* получать список [таблиц маршрутизации](../vpc/concepts/routing.md#rt-vpc) и просматривать информацию о них;
* получать список [групп безопасности](../vpc/concepts/security-groups.md) и просматривать информацию о них;
* просматривать информацию о [NAT-шлюзах](../vpc/concepts/gateways.md);
* просматривать информацию об использованных IP-адресах в подсетях;
* просматривать информацию о [квотах](../vpc/concepts/limits.md#vpc-quotas) сервиса {{ vpc-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ vpc-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ compute-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролью `vpc.viewer`.

#### vpc.securityGroups.admin {#vpc-sg-admin}

Роль `vpc.securityGroups.admin` позволяет управлять группами безопасности и просматривать информацию о ресурсах сервиса, а также о квотах и операциях с ресурсами сервиса.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать информацию о [группах безопасности](../vpc/concepts/security-groups.md), а также создавать, изменять и удалять их;
* создавать и удалять в [облачных сетях](../vpc/concepts/network.md#network) группы безопасности по умолчанию;
* создавать и удалять [правила](../vpc/concepts/security-groups.md#security-groups-rules) групп безопасности, изменять их метаданные;
* получать список облачных сетей и просматривать информацию о них;
* получать список [подсетей](../vpc/concepts/network.md#subnet) и просматривать информацию о них;
* получать список [адресов облачных ресурсов](../vpc/concepts/address.md) и просматривать информацию о них;
* получать список [таблиц маршрутизации](../vpc/concepts/routing.md#rt-vpc) и просматривать информацию о них;
* просматривать информацию о [NAT-шлюзах](../vpc/concepts/gateways.md);
* просматривать информацию об использованных IP-адресах в подсетях;
* просматривать информацию о [квотах](../vpc/concepts/limits.md#vpc-quotas) сервиса {{ vpc-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ vpc-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ compute-name }};
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролью `vpc.viewer`.

#### vpc.privateEndpoints.viewer {#vpc-privateEndpoints-viewer}

Роль `vpc.privateEndpoints.viewer` позволяет просматривать информацию о [сервисных подключениях](../vpc/concepts/private-endpoint.md).

#### vpc.privateEndpoints.editor {#vpc-privateEndpoints-editor}

Роль `vpc.privateEndpoints.editor` позволяет просматривать информацию о [сервисных подключениях](../vpc/concepts/private-endpoint.md), а также создавать, изменять и удалять сервисные подключения.

Включает разрешения, предоставляемые ролью `vpc.privateEndpoints.viewer`.

#### vpc.privateEndpoints.admin {#vpc-privateEndpoints-admin}

Роль `vpc.privateEndpoints.admin` позволяет просматривать информацию о [сервисных подключениях](../vpc/concepts/private-endpoint.md), а также создавать, изменять и удалять сервисные подключения.

Включает разрешения, предоставляемые ролью `vpc.privateEndpoints.editor`.

Подробнее см. [{#T}](../vpc/security/index.md).


## {{ vision-full-name }} {#vision-roles}

#### ai.vision.user {#vision-user}

Роль `ai.vision.user` позволяет использовать сервис {{ vision-full-name }} для [анализа изображений]({{ link-docs-ai }}vision/concepts/ocr/), а также просматривать информацию об [облаке]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#cloud), [каталоге]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#folder) и [квотах]({{ link-docs-ai }}vision/concepts/limits#vision-quotas) сервиса.

Подробнее см. [Управление доступом в {{ vision-name }}]({{ link-docs-ai }}vision/security/index).


## {{ websql-full-name }} {#websql-roles}

#### websql.executedQueries.auditor {#websql-executedQueries-auditor}

Роль `websql.executedQueries.auditor` позволяет просматривать метаданные опубликованного запроса из истории и информацию о назначенных [правах доступа](concepts/access-control/index.md) к нему.

#### websql.savedQueries.auditor {#websql-savedQueries-auditor}

Роль `websql.savedQueries.auditor` позволяет просматривать метаданные опубликованного сохраненного запроса и информацию о назначенных [правах доступа](concepts/access-control/index.md) к нему.

#### websql.executedQueries.viewer {#websql-executedQueries-viewer}

Роль `websql.executedQueries.viewer` позволяет просматривать информацию об опубликованном запросе из истории и назначенных [правах доступа](concepts/access-control/index.md) к нему.

Включает разрешения, предоставляемые  ролью `websql.executedQueries.auditor`.

#### websql.savedQueries.viewer {#websql-savedQueries-viewer}

Роль `websql.savedQueries.viewer` позволяет просматривать информацию об опубликованном сохраненном запросе и назначенных [правах доступа](concepts/access-control/index.md) к нему.

Включает разрешения, предоставляемые  ролью `websql.savedQueries.auditor`.

#### websql.executedQueries.editor {#websql-executedQueries-editor}

Роль `websql.executedQueries.editor` позволяет просматривать информацию об опубликованном запросе из истории и удалять его.

Пользователи с этой ролью могут:
* просматривать информацию об опубликованном запросе из истории и удалять его;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к опубликованному запросу из истории.

Включает разрешения, предоставляемые  ролью `websql.executedQueries.viewer`.

#### websql.savedQueries.editor {#websql-savedQueries-editor}

Роль `websql.savedQueries.editor` позволяет изменять и удалять опубликованный сохраненный запрос. 

Пользователи с этой ролью могут:
* просматривать информацию об опубликованном сохраненном запросе, а также изменять и удалять его;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к опубликованному сохраненному запросу.

Включает разрешения, предоставляемые ролью `websql.savedQueries.viewer`.

#### websql.executedQueries.admin {#websql-executedQueries-admin}

Роль `websql.executedQueries.admin` позволяет управлять опубликованным запросом из истории и доступом к нему.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к опубликованному запросу из истории и изменять такие права доступа;
* просматривать информацию об опубликованном запросе из истории и удалять его.

Включает разрешения, предоставляемые  ролью `websql.executedQueries.editor`.

#### websql.savedQueries.admin {#websql-savedQueries-admin}

Роль `websql.savedQueries.admin` позволяет управлять опубликованным сохраненным запросом и доступом к нему.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к опубликованному сохраненному запросу и изменять такие права доступа;
* просматривать информацию об опубликованном сохраненном запросе, а также изменять и удалять его.

Включает разрешения, предоставляемые  ролью `websql.savedQueries.editor`.

#### websql.auditor {#websql-auditor}

Роль `websql.auditor` позволяет просматривать метаданные всех опубликованных запросов в сервисе {{ websql-name }} и информацию о назначенных [правах доступа](concepts/access-control/index.md) к ним.

Включает разрешения, предоставляемые  ролями `websql.savedQueries.auditor` и `websql.executedQueries.auditor`.

#### websql.viewer {#websql-viewer}

Роль `websql.viewer` позволяет просматривать информацию обо всех опубликованных запросах в сервисе {{ websql-name }} и назначенных правах доступа к ним.

Пользователи с этой ролью могут:
* просматривать информацию об опубликованных сохраненных запросах и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию об опубликованных запросах из истории и назначенных правах доступа к ним.

Включает разрешения, предоставляемые  ролями `websql.savedQueries.viewer` и `websql.executedQueries.viewer`.

#### websql.user {#websql-user}

Роль `websql.user` позволяет просматривать информацию об опубликованных запросах в сервисе {{ websql-name }}, а также создавать, изменять и удалять приватные запросы.

Пользователи с этой ролью могут:
* просматривать информацию об опубликованных сохраненных запросах и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* приватно сохранять запросы, а также изменять и удалять приватные сохраненные запросы;
* просматривать информацию об опубликованных запросах из истории и назначенных правах доступа к ним;
* сохранять исполненные запросы в приватную историю и удалять такие запросы из истории.

Включает разрешения, предоставляемые  ролью `websql.viewer`.

#### websql.editor {#websql-editor}

Роль `websql.editor` позволяет управлять опубликованными и приватными запросами в сервисе {{ websql-name }}.

Пользователи с этой ролью могут:
* просматривать информацию об опубликованных сохраненных запросах и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также изменять и удалять опубликованные сохраненные запросы;
* приватно сохранять запросы, а также изменять, удалять и публиковать приватные сохраненные запросы;
* просматривать информацию об опубликованных запросах из истории и назначенных правах доступа к ним, а также удалять опубликованные запросы из истории;
* сохранять исполненные запросы в приватную историю, а также публиковать приватные запросы из истории и удалять их.

Включает разрешения, предоставляемые  ролями `websql.user`, `websql.savedQueries.editor` и `websql.executedQueries.editor`.

#### websql.admin {#websql-admin}

Роль `websql.admin` позволяет управлять приватными запросами и публиковать их, а также управлять опубликованными запросами и доступом к ним.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к опубликованным сохраненным запросам и изменять такие права доступа;
* просматривать информацию об опубликованных сохраненных запросах, а также изменять и удалять их;
* приватно сохранять запросы, а также изменять, удалять и публиковать приватные сохраненные запросы;
* просматривать информацию о назначенных правах доступа к опубликованным запросам из истории и изменять такие права доступа;
* просматривать информацию об опубликованных запросах из истории и удалять их;
* сохранять исполненные запросы в приватную историю, а также публиковать приватные запросы из истории и удалять их.

Включает разрешения, предоставляемые  ролями `websql.editor`, `websql.savedQueries.admin` и `websql.executedQueries.admin`.

Подробнее см. [{#T}](../websql/security/index.md).


## {{ wiki-full-name }} {#wiki-roles}

#### wiki.viewer {#wiki-viewer}

Роль `wiki.viewer` назначается на организацию.

Дает право читать страницы в Yandex Wiki организации.

#### wiki.admin {#wiki-admin}

Роль `wiki.admin` назначается на организацию.

Дает право редактировать страницы, настраивать права доступа для других пользователей, изменять список авторов и назначать владельца страницы.

_{{ CH }} является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._