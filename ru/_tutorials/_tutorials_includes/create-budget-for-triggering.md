Чтобы создать бюджет, у пользователя должна быть роль `editor`. Чтобы получать оповещения, достаточно роли `viewer`. 

{% list tabs group=instructions %}

- Интерфейс {{ billing-name }} {#billing}

    1. {% include [move-to-billing-step](../../billing/_includes/move-to-billing-step.md) %}
    1. Выберите платежный аккаунт.
    1. В секции **{{ ui-key.yacloud.billing.account.overview.section_account-data }}**, в поле **{{ ui-key.yacloud.common.id }}**, скопируйте идентификатор платежного аккаунта. Он пригодится при создании триггера для бюджетов.
    1. Перейдите на вкладку **{{ ui-key.yacloud.billing.account.switch_budgets }}** и нажмите кнопку **{{ ui-key.yacloud.billing.account.budgets.button_create }}**.
    1. В блоке **{{ ui-key.yacloud.common.section-base }}** укажите:
        * **{{ ui-key.yacloud.common.name }}** — `vm-budget`.
        * **{{ ui-key.yacloud.common.type }}** — `{{ ui-key.yacloud.billing.account.budgets.label_type-expense }}`.
        * **{{ ui-key.yacloud.billing.account.budgets.label_amount }}** — сумму расходов на потребление, например `10 ₽`.
        * **{{ ui-key.yacloud.billing.account.budgets.label_reset-period }}** — `{{ ui-key.yacloud.billing.account.budgets.reset-period_value_monthly }}`.
        * **{{ ui-key.yacloud.billing.account.budgets.label_expire }}** — дату окончания действия бюджета.
        
            Дата окончания устанавливает, когда бюджет перестанет считать потребление и отправлять уведомления. Дата окончания — последнее число месяца. Не может быть позже пяти лет от текущей даты.
        * **{{ ui-key.yacloud.billing.account.budgets.label_notify }}** — выберите себя.

    1. В блоке **{{ ui-key.yacloud.billing.account.budgets.section_scope }}** выберите каталог, в котором ведете работу, и сервис **{{ compute-name }}**.
    1. В блоке **{{ ui-key.yacloud.billing.account.budgets.label_limits }}** укажите пороговые значения в процентах, при достижении которых:
        * указанным пользователям будут приходить уведомления.
        * будет срабатывать триггер для бюджетов.

        Например, можно указать два порога — `50%` и `100%`.

    1. Нажмите кнопку **{{ ui-key.yacloud.billing.accounts.button_empty-billing-create }}**.
    1. В открывшемся окне появился новый бюджет `vm-budget`. В поле **{{ ui-key.yacloud.common.id }}** скопируйте идентификатор созданного бюджета. Он пригодится позднее при создании триггера.

- API {#api}

    Чтобы создать бюджет, воспользуйтесь методом [create](../../billing/api-ref/Budget/create.md) для ресурса [Budget](../../billing/api-ref/Budget/index.md) или вызовом gRPC API [BudgetService/Create](../../billing/api-ref/grpc/budget_service.md#Create).

{% endlist %}