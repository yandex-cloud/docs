# Изменить основные параметры очереди

{% note warning %}

* По умолчанию настраивать очередь может [только ее владелец](queue-access.md).
* [Ключ очереди](create-queue.md#key) изменить нельзя.

{% endnote %}

Чтобы настроить основные параметры очереди:

1. Откройте [страницу очереди](../user/queue.md).

1. В правом верхнем углу страницы нажмите ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--main }}**.

1. Настройте параметры очереди.
    * Основные параметры:
        * **Название очереди**.
        * **{{ ui-key.startrek.blocks-desktop_b-page-queue-description.description }}**. Описание отображается на странице очереди на вкладке **{{ ui-key.startrek.blocks-desktop_b-page_type_queue.tab_description }}**.
        * **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_events.field--default-priority }}**.
        * **{{ ui-key.startrek.blocks-desktop_b-queue-form.voting }}** — разрешить или запретить пользователям [голосовать за задачи](../user/votes.md) очереди.

    * В блоке **{{ ui-key.startrek.blocks-desktop_b-queue-form.advanced-settings }}**:
        * **{{ ui-key.startrek.blocks-desktop_b-queue-form.required-fields }}** — параметры, которые будут отображаться на странице задачи вне зависимости от [настроек пользователя](../user/edit-ticket.md#edit-fields).
        * **{{ ui-key.startrek.blocks-desktop_b-queue-form.notification-fields }}** — параметры задачи, которые будут присутствовать во всех уведомлениях о задачах очереди.


        * **{{ ui-key.startrek.blocks-desktop_b-queue-form.mail }}** — пользователи смогут [отправлять письма](../user/comments.md#send-comment) на любые адреса прямо со страницы задачи. Текст письма прикрепляется к задаче в виде комментария.
        * **{{ ui-key.startrek.blocks-desktop_b-queue-form.add-issue-key-in-email-checkbox }}** — указывать ключ задачи в теме [писем, отправленных со страницы задачи](../user/comments.md#send-comment).
      
        * **Не связывать с задачами других очередей автоматически** — не добавлять связь, если в комментарий или в описание задачи вставлен ключ задачи из другой очереди.
    * В блоке **{{ ui-key.startrek.blocks-desktop_b-queue-form.integration-settings }}**: {#integration}
        * **Отображать вкладку Коммиты** — включить или выключить вкладку **{{ ui-key.startrek.blocks-desktop_b-page_type_queue.tab_commits }}** на странице очереди и на страницах задач. На вкладке отображаются все [привязанные к задачам коммиты](../user/ticket-links.md#section_commit).


        * **{{ ui-key.startrek.blocks-desktop_b-queue-form.projects }}** — включить или выключить вкладку [Проекты](project-new.md) на странице очереди.


1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-queue-form.save }}**.
