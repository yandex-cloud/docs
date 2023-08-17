# Подписаться на уведомления

Подписки помогут вам не пропустить изменения важных для вас задач. Если кто-то отредактирует задачу, на которую вы подписаны, вы получите уведомление по почте.

Вы можете подписаться как на конкретную задачу, так и на все задачи, относящиеся к определенной очереди, версии или компоненту.

Для ваших уведомлений и подписок вы можете [настроить содержимое](notification-settings.md), чтобы получать письма только об интересующих вас событиях.

{% note info %}

Уведомления о призыве в комментарии отображаются также в [центре уведомлений](#notif_call_comments) {{ tracker-name }}.

{% endnote %}

## Как подписаться на задачу {#section_xt5_xrv_jz}

Если вы хотите получать уведомления об изменениях определенной задачи, подпишитесь на нее:

1. Откройте страницу задачи.

1. На правой панели в поле **{{ ui-key.startrek-backend.fields.issue.followers }}** нажмите **{{ ui-key.startrek.components_IssueFieldView.me-multiple }}**. Если поля **{{ ui-key.startrek-backend.fields.issue.followers }}** нет, добавьте его с помощью кнопки ![](../../_assets/tracker/svg/add-task.svg)&nbsp;**{{ ui-key.startrek.ui_components_IssueSidebar.add-sidebar-field }}**.


Если вы все сделали правильно, в поле наблюдатели появится ваше имя. Теперь вы будете получать письма с уведомлениями о любых изменениях этой задачи.

{% note info %}

Вы также можете добавить других пользователей в список наблюдателей. Для этого нажмите на слово **{{ ui-key.startrek-backend.fields.issue.followers }}** и введите логин или имя пользователя.

{% endnote %}

## Как подписаться на очередь {#section_k13_z5v_jz}

Подпишитесь на изменения очереди, чтобы отслеживать изменения всех ее задач:

1. Откройте [страницу очереди](queue.md).

1. В правом верхнем углу нажмите значок ![](../../_assets/tracker/svg/actions.svg). Затем нажмите ![](../../_assets/tracker/svg/subscribe.svg)&nbsp;**{{ ui-key.startrek.ui_components_PageQueue_header.subscribe }}** и выберите значение:
    - **{{ ui-key.startrek.ui_components_PageQueue_header.subscribe-new-tickets }}**, чтобы получать уведомления о создании новых задач в очереди. Вы также будете подписаны на все события, которые указаны в [настройках уведомлений](user-notifications.md#sec_add_role) для роли **{{ ui-key.startrek-backend.roles.role.name.queue-follower-key-value }}**.
    - **{{ ui-key.startrek.ui_components_PageQueue_header.subscribe-all }}**, чтобы получать уведомления о любых изменениях задач очереди.
    
Вы также можете [выбрать события](user-subscriptions.md), уведомления о которых хотите получать.


## Как подписаться на компонент {#section_km3_jnf_qz}

Вы можете подписаться не только на очередь, но и на отдельные ее компоненты. Так вы будете получать уведомления только о задачах, связанных с интересующими вас компонентами.

Чтобы подписаться на компонент:

1. Откройте [страницу очереди](queue.md).

1. В правом верхнем углу нажмите значок ![](../../_assets/tracker/svg/actions.svg), затем нажмите ![](../../_assets/tracker/svg/components.svg)&nbsp;**{{ ui-key.startrek.blocks-desktop_b-page-agile-sprints.components }}**.

1. Наведите курсор на компонент.

1. Выберите ![](../../_assets/tracker/icon-settings.png) → **{{ ui-key.startrek.blocks-desktop_b-page-components.action--subscribe }}**.

Если вы все сделали правильно, рядом с названием компонента появится значок ![](../../_assets/tracker/subscribtion.png)

По умолчанию на почту будут приходить все уведомления. Вы можете [выбрать события](user-subscriptions.md), уведомления о которых хотите получать.

## Как подписаться на версию {#section_n2y_jnf_qz}

Чтобы отслеживать задачи, связанные с определенной версией, подпишитесь на нее:

1. Откройте [страницу очереди](queue.md).

1. В правом верхнем углу нажмите значок ![](../../_assets/tracker/svg/actions.svg), затем нажмите ![](../../_assets/tracker/svg/versions.svg)&nbsp;**{{ ui-key.startrek.blocks-desktop_b-page-agile-sprints.versions }}**.

1. Наведите курсор на версию.

1. Выберите ![](../../_assets/tracker/icon-settings.png) → **{{ ui-key.startrek.blocks-desktop_b-page-goals.subscribe }}**.

Если вы все сделали правильно, рядом с номером версии появится значок ![](../../_assets/tracker/subscribtion.png)

По умолчанию на почту будут приходить все уведомления. Вы можете [выбрать события](user-subscriptions.md), уведомления о которых хотите получать.


## Получать уведомления о своих действиях {#sec_self}

По умолчанию вы не получаете уведомления о ваших собственных действиях над задачами. Чтобы включить уведомления о своих действиях: 

1. Перейдите по ссылке [{{link-tracker}}settings]({{ link-settings }}).

1. Включите опцию **{{ ui-key.startrek.blocks-desktop_b-page-settings.receive-own-events }}**.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-settings.save }}**.

## Уведомление о призыве в комментарии {#notif_call_comments}

Если вас призвали в комментарии к задаче, уведомление об этом придет не только на вашу почту, но и в [центр уведомлений](notifications.md#notif_center) {{ tracker-name }}.

Чтобы отключить уведомления:
1. На панели слева нажмите ![](../../_assets/tracker/svg/bell_2.svg)&nbsp;**{{ ui-key.startrek.blocks-desktop_b-subscriptions-header.roles }}**, откроется центр уведомлений.
1. В правом верхнем углу центра уведомлений нажмите значок ![](../../_assets/vertical-ellipsis.svg) → **{{ ui-key.startrek.blocks-desktop_guide.common--header--settings--title }}**.
1. Снимите отметку напротив пункта **{{ ui-key.startrek.blocks-desktop_guide.ticket--tabs--invites--title }}**.

