---
title: "Как удалить очередь в {{ tracker-name }}"
description: "Следуя данной инструкции, вы сможете удалить очередь в {{ tracker-name }}."
---

# Удалить очередь в {{ tracker-name }}

{% note warning %}

Перед удалением очереди убедитесь, что вы [перенесли важные задачи](../user/move-ticket.md) в другие очереди. Удаленную очередь и ее задачи можно восстановить только с помощью [запроса к API](../concepts/queues/restore-queue.md).

После удаления очереди создать новую очередь с тем же ключом будет нельзя. 

{% endnote %}

Чтобы удалить очередь и все входящие в нее задачи:

1. Откройте [страницу очереди](../user/queue.md).

1. В правом верхнем углу страницы нажмите ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--main }}**.

1. Нажмите кнопку **{{ ui-key.startrek.ui_components_page-queue-admin_QueueActionsMenu.remove-queue-action }}**.

1. Подтвердите удаление.

{% note tip %}

* Чтобы удалить очередь только из меню **{{ ui-key.startrek.blocks-desktop_b-head.queues }}** на верхней панели {{ tracker-name }}, откройте меню и нажмите на значок ![](../../_assets/tracker/remove-task-type.png).
* Вместо того чтобы удалять очередь, вы можете [закрыть доступ к ней](queue-access.md#set-access) для всех, кроме владельца. Задачи такой очереди не отображаются у других пользователей, но их можно легко восстановить.
 
{% endnote %}
