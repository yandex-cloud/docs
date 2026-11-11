Чтобы создать бюджет, у пользователя должна быть [роль](../../iam/concepts/access-control/roles.md) `editor`. Чтобы получать оповещения, достаточно роли `viewer`.

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. {% include [move-to-billing-step](../../billing/_includes/move-to-billing-step.md) %}
  1. Выберите [платежный аккаунт](../../billing/concepts/billing-account.md).
  1. В верхней части экрана в поле **ID** скопируйте идентификатор платежного аккаунта. Он понадобится при создании [триггера](../../functions/concepts/trigger/index.md) для бюджетов.
  1. На панели слева выберите ![megaphone](../../_assets/console-icons/megaphone.svg) **Уведомления о потреблении** и нажмите кнопку **Создать уведомление**. В открывшемся окне:

      1. Задайте основные параметры бюджета:

          * В поле **{{ ui-key.yacloud.common.name }}** укажите `vm-budget`.
          * В поле **Условие отправки** выберите `Потребление со скидками превышает`.
          * В поле **{{ ui-key.yacloud_billing.billing.account.budgets.label_amount }}** задайте сумму расходов на потребление, например `10 ₽`.
          * В поле **Период контроля** выберите `Месяц`.
          * В поле **{{ ui-key.yacloud_billing.billing.account.budgets.label_expire }}** задайте дату окончания действия бюджета.

            Дата окончания устанавливает, когда бюджет перестанет считать потребление и отправлять уведомления. Дата окончания — последнее число месяца. Не может быть позже пяти лет от текущей даты.
          * В поле **{{ ui-key.yacloud_billing.billing.account.budgets.label_notify }}** выберите себя.
      1. Разверните блок **Дополнительно** и задайте дополнительные параметры бюджета:

          * В поле **В каких сервисах** выберите сервис **{{ compute-name }}**.
          * В поле **В каких облаках и каталогах** выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором ведете работу.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. В открывшемся окне появится новый бюджет `vm-budget`. В поле **{{ ui-key.yacloud.common.id }}** скопируйте идентификатор созданного бюджета. Он понадобится позднее при создании триггера.

- API {#api}

  Чтобы создать бюджет, воспользуйтесь методом [create](../../billing/api-ref/Budget/create.md) для ресурса [Budget](../../billing/api-ref/Budget/index.md) или вызовом gRPC API [BudgetService/Create](../../billing/api-ref/grpc/Budget/create.md).

{% endlist %}