[Документация Yandex Cloud](../index.md) > Партнерская программа B2B Tech > Партнерская программа Yandex Cloud

# Партнерская программа B2B Tech

Партнерская программа позволяет решать задачи клиентов с помощью технологий и сервисов, проверенных нагрузками Яндекса. Вы сможете: <ul><li>Продавать технологии Yandex Cloud и получать за это вознаграждение.</li> <li>Зарабатывать на консалтинге, миграции, интеграции и других услугах по внедрению облака.</li></ul>

<a href="https://partners.yandex.cloud">Партнёрский портал</a> помогает управлять клиентами, отслеживать их потребление, регистрировать сделки и проекты, просматривать партнерскую премию и начисление рибейтов, а также работать с реферальными ссылками.

О том, как публиковать свои продукты и продавать их клиентам Yandex Cloud, читайте в документации <a href="../marketplace/quickstart.md">Yandex Cloud Marketplace</a>.

# Партнерская программа B2B Tech

 - [Начало работы](quickstart.md)

## Партнерские программы

### Программа прямого партнерства

 - [Обзор](program/var.md)

 - [Инструменты](program/var-tools.md)

#### Партнерские статусы Yandex Cloud

 - [Обзор](specializations/index.md)

 - [Условия получения](specializations/conditions.md)

 - [Реферальная программа](program/referral.md)

## Партнерский портал

 - [Обзор](portal.md)

### Пошаговые инструкции

#### Управление аккаунтами клиентов

 - [Создать аккаунт клиента](operations/create-account.md)

 - [Добавить сабаккаунт клиента](operations/pin-client.md)

 - [Предоставить доступ к партнерскому аккаунту](operations/access/partners-account.md)

 - [Приостановить оказание услуг клиенту](operations/stop-client-services.md)

 - [Привязать облако к сабаккаунту](operations/pin-cloud.md)

 - [Добавить пользователя в сабаккаунт](operations/add-user-sub-account.md)

 - [Настроить квоты для клиентов](operations/manage-quotas.md)

#### Просмотр детализации

 - [Посмотреть детализацию сабаккаунтов](operations/get-client-stat.md)

 - [Экспортировать расширенную детализацию](operations/get-partner-report.md)

#### Управление сделками

 - [Все инструкции](operations/deals/index.md)

 - [Создать сделку](operations/deals/create-deal.md)

 - [Создать сделку в рамках регламентированной закупки](operations/deals/create-tender.md)

 - [Создать проект](operations/deals/create-project.md)

 - [Посмотреть информацию о сделке](operations/deals/deal-info.md)

 - [Редактировать сделку](operations/deals/edit.md)

 - [Зарегистрировать сделку](operations/deal-registration.md)

 - [Зарегистрировать проект](operations/project-registration.md)

#### Управление активностями по сделкам

 - [Посмотреть информацию об активности](operations/activity-info.md)

 - [Фильтровать список сущностей](operations/filter.md)

 - [Запросить пресейл](operations/presale-request.md)

 - [Получить вознаграждение](operations/get-bonus.md)

 - [Управление доступом](security/index.md)

 - [История изменений](release-notes/index.md)

### API

 - [Обзор](api/index.md)

#### Описание методов (англ.)

 - [Overview](api-ref/index.md)

##### Accounts

 - [Overview](api-ref/Accounts/index.md)

 - [List accounts](api-ref/Accounts/POST_accounts_v1_masterBAId_accounts_list.md)

 - [Account data](api-ref/Accounts/GET_accounts_v1_masterBAId_account_accountId.md)

 - [Update account](api-ref/Accounts/PATCH_accounts_v1_masterBAId_account_accountId.md)

 - [Create account](api-ref/Accounts/POST_accounts_v1_masterBAId_account.md)

##### Activities

 - [Overview](api-ref/Activities/index.md)

 - [List activities](api-ref/Activities/POST_activities_v1_masterBAId_activities_list.md)

##### Comarketing

 - [Overview](api-ref/Comarketing/index.md)

 - [Get co-marketing balance](api-ref/Comarketing/GET_comarketing_v1_balance_billingAccountId.md)

 - [List co-marketing transactions](api-ref/Comarketing/POST_comarketing_v1_listTransactions_billingAccountId.md)

 - [Accrue/deduct co-marketing rebates](api-ref/Comarketing/POST_comarketing_v1_transact_billingAccountId.md)

 - [Get co-marketing transaction filter values](api-ref/Comarketing/GET_comarketing_v1_listTransactionsFilters.md)

##### Operations

 - [Overview](api-ref/Operations/index.md)

 - [Request operation data](api-ref/Operations/GET_operations_v1_operationId.md)

##### Opportunities

 - [Overview](api-ref/Opportunities/index.md)

 - [Create opportunity](api-ref/Opportunities/POST_opportunities_v1_masterBAId_opportunity.md)

 - [List opportunities](api-ref/Opportunities/POST_opportunities_v1_masterBAId_opportunities_list.md)

 - [Get opportunity data](api-ref/Opportunities/GET_opportunities_v1_masterBAId_opportunity_opportunityId.md)

 - [Update opportunity](api-ref/Opportunities/PATCH_opportunities_v1_masterBAId_opportunity_opportunityId.md)

 - [Get available tools for opportunity](api-ref/Opportunities/GET_opportunities_v1_masterBAId_opportunityTools_opportunityId.md)

 - [Get products available for opportunities](api-ref/Opportunities/GET_opportunities_v1_masterBAId_products.md)

##### Orders

 - [Overview](api-ref/Orders/index.md)

 - [List orders](api-ref/Orders/POST_orders_v1_masterBAId_orders_list.md)

 - [Create order](api-ref/Orders/POST_orders_v1_masterBAId_order.md)

 - [Cancel order](api-ref/Orders/POST_orders_v1_masterBAId_orders_orderId.md)

 - [List available products](api-ref/Orders/POST_orders_v1_masterBAId_orders_listProducts.md)

 - [Get minimum terms for order](api-ref/Orders/POST_orders_v1_masterBAId_orders_listTerms.md)

 - [Calculate order cost](api-ref/Orders/POST_orders_v1_masterBAId_orders_calculateCost.md)

 - [Download invoice PDF](api-ref/Orders/POST_orders_v1_masterBAId_downloadInvoiceOrder_orderId.md)

 - [Download closing documents](api-ref/Orders/POST_orders_v1_masterBAId_downloadClosedDocs_orderId.md)

##### Subaccounts

 - [Overview](api-ref/Subaccounts/index.md)

 - [Subaccount data](api-ref/Subaccounts/GET_subaccounts_v1_masterBAId_subaccount_subAccountId.md)

 - [Update subaccount](api-ref/Subaccounts/PATCH_subaccounts_v1_masterBAId_subaccount_subAccountId.md)

 - [Get list of linked instances](api-ref/Subaccounts/POST_subaccounts_v1_masterBAId_subaccount_subAccountId_instances.md)

 - [Create subaccount](api-ref/Subaccounts/POST_subaccounts_v1_masterBAId_subaccount.md)

 - [List subaccounts](api-ref/Subaccounts/POST_subaccounts_v1_masterBAId_subaccounts_list.md)

 - [Activate subaccount](api-ref/Subaccounts/POST_subaccounts_v1_masterBAId_subaccount_subAccountId_activate.md)

 - [Suspend subaccount](api-ref/Subaccounts/POST_subaccounts_v1_masterBAId_subaccount_subAccountId_suspend.md)

##### Usage

 - [Overview](api-ref/Usage/index.md)

 - [Get usage filter values](api-ref/Usage/POST_usage_v1_masterBAId_meta.md)

 - [Request subaccount usage detail](api-ref/Usage/POST_usage_v1_masterBAId.md)

##### Yandex 360

 - [Overview](api-ref/Yandex-360/index.md)

 - [Create organization 360](api-ref/Yandex-360/POST_organization360_v1_masterBAId_subaccountId.md)

 - [Get organization 360 data](api-ref/Yandex-360/GET_organization360_v1_subaccountId_organization360Id.md)

 - [Get list of available tariffs for organization 360](api-ref/Yandex-360/GET_workseats_v1_subaccountId_organization360Id_availableList.md)

 - [Get list of tariffs and add-ons of organization 360](api-ref/Yandex-360/POST_workseats_v2_subaccountId_organization360Id_list.md)

 - [Add tariff for organization 360](api-ref/Yandex-360/POST_workseats_v1_subaccountId_organization360Id_workseat.md)

 - [Change tariff in organization 360](api-ref/Yandex-360/POST_workseats_v1_subaccountId_organization360Id_workseatId.md)

 - [Cancel tariff in organization 360](api-ref/Yandex-360/POST_workseats_v1_subaccountId_organization360Id_workseatId_disable.md)

 - [Get list of available add-ons for a tariff](api-ref/Yandex-360/GET_workseats_v1_subaccountId_organization360Id_productId_addons.md)

 - [Manage add-ons for a tariff](api-ref/Yandex-360/PUT_workseats_v1_subaccountId_organization360Id_workseatId_addons.md)

 - [Для партнеров On-premises](on-premises.md)

 - [Термины и определения](terms.md)

## Вопросы и ответы

 - [Общие вопросы](qa/general.md)

 - [Договоры и счета](qa/contracts.md)

 - [Схема премирования партнеров](qa/bonuses.md)

 - [Стартовый грант](qa/start-grant.md)

 - [Дополнительные гранты в партнерской программе](qa/additional-grants.md)

 - [Все вопросы на одной странице](qa/all.md)