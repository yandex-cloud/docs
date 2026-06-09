# Yandex Cloud Billing

Yandex Cloud Billing позволяет получать информацию об объеме использованных ресурсов, проверять расходы денежных средств и оплачивать потребление ресурсов.

В Yandex Cloud вы платите только за потребленные ресурсы и время их фактического использования.

# Yandex Cloud Billing

 - [Начало работы](quickstart/index.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Работа с документами

 - [Расшифровать счет на оплату](operations/spell-out-bill.md)

 - [Скачать отчетные документы](operations/download-reporting-docs.md)

 - [Подключиться к ЭДО](operations/edo.md)

### Управление платежным аккаунтом

 - [Создать новый платежный аккаунт](operations/create-new-account.md)

 - [Изменить данные платежного аккаунта](operations/change-data.md)

 - [Скачать персональные данные, связанные с платежным аккаунтом](operations/get-data.md)

 - [Привязать облако к платежному аккаунту](operations/pin-cloud.md)

 - [Изменить организацию платежного аккаунта](operations/change-organization.md)

 - [Удалить платежный аккаунт](operations/delete-account.md)

 - [Активировать платную версию](operations/activate-commercial.md)

### Управление способами оплаты

 - [Удалить или привязать другую карту](operations/pin-card.md)

 - [Изменить способ оплаты](operations/change-payment-method.md)

### Оптимизация расходов

 - [Установить уведомления](operations/budgets.md)

 - [Зарезервировать потребление (CVoS)](operations/purchase-cvos.md)

### Оплата услуг

 - [Активировать промокод](operations/activate-promocode.md)

 - [Пополнить счет](operations/pay-the-bill.md)

 - [Принять коммерческие предложения](operations/get-offers.md)

### Анализ использования сервисов {{ yandex-cloud }}

 - [Посмотреть историю платежей](operations/check-bill-history.md)

#### Детализация расходов

 - [Обзор](operations/charges-index.md)

 - [Посмотреть детализацию в консоли](operations/check-charges.md)

 - [Посмотреть детализацию в {{ datalens-full-name }}](operations/dashboard.md)

 - [Экспортировать расширенную детализацию](operations/get-folder-report.md)

 - [Получить детализацию через API](operations/get-charges-via-api.md)

 - [Поиск в детализации с помощью {{ yq-full-name }}](operations/query-integration.md)

## Концепции

 - [Все понятия](concepts/index.md)

 - [Промокод](concepts/promo-code.md)

 - [Порог оплаты](concepts/billing-threshold.md)

### Платежный аккаунт

 - [Обзор](concepts/billing-account.md)

 - [Статусы](concepts/billing-account-statuses.md)

 - [Лицевой счет](concepts/personal-account.md)

 - [Грант](concepts/bonus-account.md)

 - [Пробный период](concepts/trial-period.md)

 - [Организация](concepts/organization.md)

 - [Отчетный период](concepts/reporting-period.md)

 - [Резервируемое потребление (CVoS)](concepts/cvos.md)

 - [Free tier](concepts/serverless-free-tier.md)

 - [Бюджет](concepts/budget.md)

 - [Договор](concepts/contract.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Глоссарий](concepts/glossary.md)

## Оплата ресурсов

 - [Общие сведения](payment/index.md)

### Физическим лицам

 - [Цикл оплаты](payment/billing-cycle-individual.md)

 - [Способы оплаты](payment/payment-methods-individual.md)

 - [Чек об оплате](concepts/individual-bill.md)

### Организациям и ИП

 - [Цикл оплаты](payment/billing-cycle-business.md)

#### Банковская карта

 - [Порядок оплаты](payment/payment-methods-card-business.md)

 - [Чек об оплате](concepts/business-bill.md)

#### Перевод с расчетного счета

 - [Порядок оплаты](payment/payment-methods-business.md)

 - [Счет на оплату](concepts/bill.md)

#### Отчетные документы

 - [Общие сведения](payment/documents.md)

 - [Акты](concepts/act.md)

 - [Счет-фактура](concepts/invoice.md)

 - [Электронный документооборот](concepts/edo.md)

 - [Валюта расчетов](payment/currency.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

 - [Создание триггера для бюджетов, который вызывает функцию для остановки ВМ](tutorials/serverless-trigger-budget-vm.md)

 - [Создание триггеров, которые вызывают функции для остановки ВМ и отправки уведомлений в Telegram](tutorials/serverless-trigger-budget-queue-vm-tg.md)

 - [Анализ поресурсной детализации расходов с помощью {{ objstorage-name }}](tutorials/billing-resource-detailing.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

## Вопросы и ответы

 - [Все вопросы на одной странице](qa/all.md)

 - [Общие вопросы](qa/common.md)

 - [Вопросы о договоре](qa/contract.md)

 - [Вопросы по оплате](qa/payment.md)

 - [Вопросы о платежном аккаунте](qa/billing-account.md)

 - [Вопросы о регулярном экспорте детализации](qa/export.md)

 - [Вопросы о пробном периоде и платной версии](qa/trial-commercial.md)

 - [Вопросы по работе с нерезидентами](qa/non-resident.md)

 - [Справочник {{ TF }}](tf-ref.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

### gRPC (англ.)

#### Billing

 - [Overview](api-ref/grpc/index.md)

##### BillingAccount

 - [Overview](api-ref/grpc/BillingAccount/index.md)

 - [Get](api-ref/grpc/BillingAccount/get.md)

 - [List](api-ref/grpc/BillingAccount/list.md)

 - [ListBillableObjectBindings](api-ref/grpc/BillingAccount/listBillableObjectBindings.md)

 - [BindBillableObject](api-ref/grpc/BillingAccount/bindBillableObject.md)

 - [ListAccessBindings](api-ref/grpc/BillingAccount/listAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/BillingAccount/updateAccessBindings.md)

##### Budget

 - [Overview](api-ref/grpc/Budget/index.md)

 - [Get](api-ref/grpc/Budget/get.md)

 - [List](api-ref/grpc/Budget/list.md)

 - [Create](api-ref/grpc/Budget/create.md)

##### Customer

 - [Overview](api-ref/grpc/Customer/index.md)

 - [List](api-ref/grpc/Customer/list.md)

 - [Invite](api-ref/grpc/Customer/invite.md)

 - [CreateResellerServed](api-ref/grpc/Customer/createResellerServed.md)

 - [Activate](api-ref/grpc/Customer/activate.md)

 - [Suspend](api-ref/grpc/Customer/suspend.md)

##### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

##### Service

 - [Overview](api-ref/grpc/Service/index.md)

 - [Get](api-ref/grpc/Service/get.md)

 - [List](api-ref/grpc/Service/list.md)

##### Sku

 - [Overview](api-ref/grpc/Sku/index.md)

 - [Get](api-ref/grpc/Sku/get.md)

 - [List](api-ref/grpc/Sku/list.md)

#### Billing usage

 - [Overview](usage/api-ref/grpc/index.md)

##### ConsumptionCore

 - [Overview](usage/api-ref/grpc/ConsumptionCore/index.md)

 - [GetBillingAccountUsageReport](usage/api-ref/grpc/ConsumptionCore/getBillingAccountUsageReport.md)

 - [GetCloudUsageReport](usage/api-ref/grpc/ConsumptionCore/getCloudUsageReport.md)

 - [GetFolderUsageReport](usage/api-ref/grpc/ConsumptionCore/getFolderUsageReport.md)

 - [GetServiceUsageReport](usage/api-ref/grpc/ConsumptionCore/getServiceUsageReport.md)

 - [GetSKUUsageReport](usage/api-ref/grpc/ConsumptionCore/getSKUUsageReport.md)

 - [GetResourceUsageReport](usage/api-ref/grpc/ConsumptionCore/getResourceUsageReport.md)

 - [GetLabelKeyUsageReport](usage/api-ref/grpc/ConsumptionCore/getLabelKeyUsageReport.md)

 - [GetServiceInstanceUsageReport](usage/api-ref/grpc/ConsumptionCore/getServiceInstanceUsageReport.md)

##### Metadata

 - [Overview](usage/api-ref/grpc/Metadata/index.md)

 - [GetUsage](usage/api-ref/grpc/Metadata/getUsage.md)

 - [GetServiceInstance](usage/api-ref/grpc/Metadata/getServiceInstance.md)

 - [GetLabel](usage/api-ref/grpc/Metadata/getLabel.md)

 - [GetCloud](usage/api-ref/grpc/Metadata/getCloud.md)

 - [GetResources](usage/api-ref/grpc/Metadata/getResources.md)

### REST (англ.)

#### Billing

 - [Overview](api-ref/index.md)

##### BillingAccount

 - [Overview](api-ref/BillingAccount/index.md)

 - [Get](api-ref/BillingAccount/get.md)

 - [List](api-ref/BillingAccount/list.md)

 - [ListBillableObjectBindings](api-ref/BillingAccount/listBillableObjectBindings.md)

 - [BindBillableObject](api-ref/BillingAccount/bindBillableObject.md)

 - [ListAccessBindings](api-ref/BillingAccount/listAccessBindings.md)

 - [UpdateAccessBindings](api-ref/BillingAccount/updateAccessBindings.md)

##### Budget

 - [Overview](api-ref/Budget/index.md)

 - [Get](api-ref/Budget/get.md)

 - [List](api-ref/Budget/list.md)

 - [Create](api-ref/Budget/create.md)

##### Customer

 - [Overview](api-ref/Customer/index.md)

 - [List](api-ref/Customer/list.md)

 - [Invite](api-ref/Customer/invite.md)

 - [CreateResellerServed](api-ref/Customer/createResellerServed.md)

 - [Activate](api-ref/Customer/activate.md)

 - [Suspend](api-ref/Customer/suspend.md)

##### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

##### Service

 - [Overview](api-ref/Service/index.md)

 - [Get](api-ref/Service/get.md)

 - [List](api-ref/Service/list.md)

##### Sku

 - [Overview](api-ref/Sku/index.md)

 - [Get](api-ref/Sku/get.md)

 - [List](api-ref/Sku/list.md)

 - [Аудитные логи {{ at-name }}](at-ref.md)

 - [История изменений](release-notes.md)