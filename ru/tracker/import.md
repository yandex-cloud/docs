---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Мигрировать в {{ tracker-name }}

{% note warning %}

Переносить данные в {{ tracker-name }} может только администратор организации.

{% endnote %}

Если вы уже используете какой-то сервис управления проектами, перенесите свои данные в {{ tracker-name }} с помощью API:

1. Убедитесь, что вы авторизованы в {{ tracker-name }} с учетной записью администратора.

1. Получите [доступ к API](concepts/access.md).

1. [Создайте очереди](manager/create-queue.md), в которые вы будете импортировать задачи.

1. Настройте очередь:

    - добавьте [типы задач и резолюции](manager/add-ticket-type.md);

    - настройте [статусы](manager/workflow.md);

    - создайте [версии](manager/versions.md) и [компоненты](manager/components.md).

1. При необходимости создайте [доски задач](manager/create-agile-board.md) и [спринты](manager/create-agile-sprint.md).

1. Импортируйте данные в {{ tracker-name }} [с помощью API](concepts/import/import-ticket.md).




