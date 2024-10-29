# Установить уведомления 

Для контроля расходов в {{ yandex-cloud }} вы можете настроить уведомления с помощью [бюджетов](../concepts/budget.md). 

Доступные типы бюджета:
* _{{ ui-key.yacloud_billing.billing.account.budgets.label_type-cost }}_ — уведомление отправляется, когда стоимость ресурсов без учета скидок превышает установленный порог потребления.
* _{{ ui-key.yacloud_billing.billing.account.budgets.label_type-expense }}_ — уведомление отправляется, когда стоимость ресурсов с учетом скидок и активных промокодов превышает установленный порог потребления.
* _{{ ui-key.yacloud_billing.billing.account.budgets.label_type-balance }}_ — уведомление отправляется, когда баланс лицевого счета становится меньше установленного порога.


{% note info %}

Вы можете создать триггер, который будет запускать [функцию](../../functions/concepts/function.md) {{ sf-name }} или [контейнер](../../serverless-containers/concepts/container.md) {{ serverless-containers-name }} при превышении пороговых значений. Подробнее о [триггере для бюджетов](../../functions/operations/trigger/budget-trigger-create.md).

{% endnote %}


## Создать бюджет {#create-budget}

Для создания бюджета необходима роль `editor`. Для получения оповещений из бюджета указанным получателям достаточно роли `viewer`. Подробнее об управлении доступом можно узнать в разделе [{#T}](../../iam/concepts/access-control/roles.md).

Чтобы создать бюджет:

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. Перейдите в сервис [**{{ billing-name }}**]({{ link-console-billing }}).

  1. Выберите аккаунт на странице **{{ ui-key.yacloud_billing.billing.title_accounts }}**.

  1. Перейдите на страницу **{{ ui-key.yacloud_billing.billing.account.budgets.label_budgets }}** и нажмите **{{ ui-key.yacloud_billing.billing.account.budgets.button_create }}**.

     1. Введите имя бюджета.
     1. Выберите **{{ ui-key.yacloud_billing.billing.account.budgets.label_type }}**.
     1. Задайте **Сумму бюджета**: 

        * для типов **{{ ui-key.yacloud_billing.billing.account.budgets.label_type-cost }}** или **{{ ui-key.yacloud_billing.billing.account.budgets.label_type-expense }}** — сумму расходов на потребление;
        * для типа **{{ ui-key.yacloud_billing.billing.account.budgets.label_type-balance }}** — остаток на лицевом счете.

     1. Для типов **{{ ui-key.yacloud_billing.billing.account.budgets.label_type-cost }}** и **{{ ui-key.yacloud_billing.billing.account.budgets.label_type-expense }}** выберите период расчета бюджета:

        * Если вы выбрали **{{ ui-key.yacloud_billing.billing.account.budgets.reset-period_value_custom }}** период, задайте дату начала действия бюджета. Дата начала — первое число заданного месяца.
        * Задайте дату окончания действия бюджета. Дата окончания устанавливает, когда бюджет перестанет считать потребление или остаток средств и отправлять уведомления. Дата окончания — последнее число месяца. Не может быть позже пяти лет от текущей даты.

     1. В поле **{{ ui-key.yacloud_billing.billing.account.budgets.label_notify }}** выберите пользователей, которые получат уведомление.
     1. Для типов **{{ ui-key.yacloud_billing.billing.account.budgets.label_type-cost }}** и **{{ ui-key.yacloud_billing.billing.account.budgets.label_type-expense }}** определите **{{ ui-key.yacloud_billing.billing.account.budgets.section_scope }}** бюджета. Вы можете выбрать отдельные облака, каталоги и сервисы, которые будут входить в установленный бюджет. По умолчанию данные собираются со всех облаков, каталогов и сервисов, доступных выбранному платежному аккаунту. 
     1. Установите хотя бы один порог потребления, при котором будут отправлены уведомления. Вы можете указать пороговое значение в процентах или валюте и выбрать пользователей, которые получат уведомления. Бюджет может иметь несколько пороговых значений.
   
     {% note info %}
   
     Пользователи, указанные в блоке **{{ ui-key.yacloud.common.section-base }}**, будут получать уведомления при достижении каждого заданного порога. Пользователи, указанные при задании порога, получат уведомление только при достижении этого порога.
   
     Если при подсчете бюджета были достигнуты одновременно несколько порогов, пользователи получат только одно уведомление.
   
     {% endnote %}

  1. После заполнения всех полей нажмите кнопку **{{ ui-key.yacloud.common.create }}**. Бюджет будет создан.

- API {#api}

  Чтобы создать бюджет, воспользуйтесь методом REST API [create](../api-ref/Budget/create.md) для ресурса [Budget](../api-ref/Budget/index.md) или вызовом gRPC API [BudgetService/Create](../api-ref/grpc/Budget/create.md).
  
{% endlist %}


## См. также

* [{#T}](../tutorials/serverless-trigger-budget-vm.md).
* [{#T}](../tutorials/serverless-trigger-budget-queue-vm-tg.md).
