---
title: Скачать отчетные документы
description: Узнайте как скачать архив с закрывающими документами, заказать акт сверки, акт выполненных работы и электронные счета-фактуры.
---

# Посмотреть историю расходов и скачать отчетные документы в сервисе {{ billing-name }}

Физические лица, организации и ИП могут просматривать историю расходов. Организации и ИП, которые являются резидентами Российской Федерации или Республики Беларусь, могут скачивать отчетные документы в сервисе {{ billing-name }}.

{% list tabs group=customers %}

- Юридические лица и ИП {#businesses}
    
    {% include [billing.accounts.account](../../_includes/billing/accountant-role.md) %}

    ## Ограничения {#restrictions}

    При скачивании отчетных документов действуют следующие ограничения:
    * Максимальный период для заказа документов — 15 календарных месяцев от текущей даты.
    * Для каждого документа можно заказать оригиналы не более 3 раз.
    * Функциональность недоступна для платежных аккаунтов с активированным электронным документооборотом (ЭДО).
    * Если в запросе присутствуют документы с разным статусом ЭДО, {{ billing-name }} обработает только те документы, для которых ЭДО не был активен.
    * Функциональность недоступна для [сабаккаунтов](../../partner/terms.md#sub-account).
    
    ## Организации и ИП Российской Федерации и Республики Беларусь {#legal-entities-russia}

    Организации и ИП могут скачивать [акты](../concepts/act.md) и [счета-фактуры](../concepts/invoice.md), а также заказывать [акты сверки](../concepts/act.md#reconciliation-report).

    ### Скачать закрывающие документы {#download-closing-docs}

    {% include [download-closing-docs](../_includes/download-closing-docs.md) %}

    ### Заказать акт сверки {#download-acts}

    Акты сверки формируются по запросу, который можно оставить в сервисе {{ billing-name }}. После выполнения запроса документ будет доступен для скачивания.

    Акт сверки за текущий месяц можно заказать спустя 7 рабочих дней после его завершения.

    Чтобы заказать акт сверки:

    1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
    1. Выберите платежный аккаунт.
    1. Перейдите в раздел **{{ ui-key.yacloud_billing.billing.account.switch_acts }}**.
    1. Откройте вкладку **{{ ui-key.yacloud_billing.billing.account.tab_reconciliation-reports-title }}**.
    1. Нажмите на кнопку **{{ ui-key.yacloud_billing.billing.account.reconciliation-reports.action_request-report }}**. В открывшемся окне выберите период, за который требуется сформировать акт сверки, и нажмите **{{ ui-key.yacloud_billing.billing.account.reconciliation-reports.action_request-report-short }}**.
    1. Когда статус запроса изменится на **{{ ui-key.yacloud_billing.billing.account.reconciliation-reports.value_completed }}**, в столбце **{{ ui-key.yacloud_billing.billing.account.reconciliation-reports.field_actions }}** появится кнопка для скачивания. Выберите **{{ ui-key.yacloud_billing.billing.account.reconciliation-reports.action_download-with-facsimile }}** или **{{ ui-key.yacloud_billing.billing.account.reconciliation-reports.action_download-without-facsimile }}**.
    1. Нажмите кнопку с выбранным типом скачивания. Документ откроется в новом окне, и вы сможете его сохранить.

    Для обмена оригиналами документов скачайте акт без подписи, распечатайте два экземпляра, подпишите их и отправьте:

    * Почтой России: 115035, г. Москва, ул. Садовническая, д. 82, стр. 2.
          На конверте укажите <q>для группы по сопровождению проектных сделок</q> и не используйте имена сотрудников.
   
    * Курьером: 115035, г. Москва, ул. Садовническая, д. 82, стр. 2.
          Вход с Садовнической улицы, между 5 и 6 подъездами БЦ <q>Аврора</q>.
          Курьерский ресепшен работает с понедельника по пятницу с 9:00 до 18:00.
          Телефон канцелярии: +7(495)739-70-00, далее нажмите 1, а после включения голосового меню — 7704.

    Документы будут подписаны, и вам отправят ваш экземпляр.

    ## Организации и ИП Республики Казахстан {#legal-entities-kazakhstan}

    Организации и ИП могут скачивать [акты](../concepts/act.md), получать [счета-фактуры](../concepts/invoice.md), а также заказывать [акты сверки](../concepts/act.md#reconciliation-report).

    ### Акт выполненных работ {#report-of-completion}

    Организации и ИП, которые являются резидентами РK, могут скачивать акты выполненных работ (АВР).

    Документы формируются в последний день отчетного периода — месяца. Через 7 рабочих дней после окончания отчетного периода акт выполненных работ будет доступен для скачивания. АВР за предыдущие отчетные периоды также доступны в сервисе {{ billing-name }}.

    Чтобы заказать акт выполненных работ:

    1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
    1. Выберите платежный аккаунт.
    1. Перейдите в раздел **{{ ui-key.yacloud_billing.billing.account.switch_acts }}**.
    1. Откройте вкладку **{{ ui-key.yacloud_billing.billing.account.tab_acts-title }}**.
    1. В строке с нужным отчетным периодом нажмите ![image](../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud_billing.billing.account.button_download-action }}**. Откроется окно с актами за выбранный период.
    1. Справа от документа нажмите ![image](../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.common.open }}**. Документ откроется в новой вкладке браузера, и вы сможете его сохранить.
    1. Чтобы скачать акты за несколько периодов одним архивом, отметьте нужные периоды в левом столбце (отметка в заголовке таблицы позволяет выбрать все периоды) и нажмите **{{ ui-key.yacloud_billing.billing.account.acts_batch-download-text_pdf }}** или **{{ ui-key.yacloud_billing.billing.account.acts_batch-download-text_zip }}**.

    ### Электронный счет-фактура {#electronic-invoice}

    Электронные счета-фактуры (ЭСФ) отправляются в [Информационную систему по приему и обработке электронных счетов-фактур](https://esf.gov.kz:8443/esf-web/login) (ИС ЭСФ) не позднее, чем через 15 календарных дней после даты совершения оборота по реализации.

    ### Заказать акт сверки {#download-acts-kazakhstan}

    Акты сверки формируются по запросу, который можно оставить в сервисе {{ billing-name }}. После выполнения запроса документ будет доступен для скачивания.

    Акт сверки за текущий месяц можно заказать спустя 7 рабочих дней после его завершения.

    Чтобы заказать акт сверки:

    1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
    1. Выберите платежный аккаунт.
    1. Перейдите в раздел **{{ ui-key.yacloud_billing.billing.account.switch_acts }}**.
    1. Откройте вкладку **{{ ui-key.yacloud_billing.billing.account.tab_reconciliation-reports-title }}**.
    1. Нажмите на кнопку **{{ ui-key.yacloud_billing.billing.account.reconciliation-reports.action_request-report }}**. В открывшемся окне выберите период, за который требуется сформировать акт сверки, и нажмите **{{ ui-key.yacloud_billing.billing.account.reconciliation-reports.action_request-report-short }}**.
    1. Когда статус запроса изменится на **{{ ui-key.yacloud_billing.billing.account.reconciliation-reports.value_completed }}**, в столбце **{{ ui-key.yacloud_billing.billing.account.reconciliation-reports.field_actions }}** появится кнопка для скачивания. Выберите **{{ ui-key.yacloud_billing.billing.account.reconciliation-reports.action_download-with-facsimile }}** или **{{ ui-key.yacloud_billing.billing.account.reconciliation-reports.action_download-without-facsimile }}**.
    1. Нажмите кнопку с выбранным типом скачивания. Документ откроется в новом окне, и вы сможете его сохранить.
    
    Для обмена оригиналами документов, скачайте акт без подписи, распечатайте два экземпляра, подпишите их и отправьте по адресу: 050059, Республика Казахстан, город Алматы, Бостандыкский район, Проспект Аль-Фараби, дом 11/1, ресепшн. Документы будут подписаны, и вам отправят ваш экземпляр.


- Физические лица {#individuals}

  ## Посмотреть историю расходов {#expense-history}

  Физические лица могут просматривать историю расходов помесячно в сервисе {{ billing-name }}.

  Чтобы посмотреть историю расходов:

    1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
    1. Выберите платежный аккаунт.
    1. Перейдите в раздел **{{ ui-key.yacloud_billing.billing.account.switch_expences }}**.

  Для физических лиц недоступно скачивание отчетных документов.

{% endlist %}
