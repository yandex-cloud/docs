# Добавить форму обратной связи

Для решения текущих вопросов, поступающих от сотрудников компании в отдел кадров, создайте отдельную очередь, доступную всем сотрудникам, и настройте добавление формы обратной связи по факту закрытия задачи.

## Создайте очередь

1. [Создайте очередь](manager/create-queue.md) с помощью шаблона <q>{{ ui-key.startrek.blocks-desktop_queue-new-presets.preset-title--quick-start-preset }}</q>. 
1. В качестве имени укажите, например, `General Questions`. 
1. Если нужно, создайте дополнительные типы задач и рабочие процессы.

## Настройте форму обратной связи

1. Создайте форму обратной связи. Например, это может быть форма с названием "Оцените нашу работу" и с одним вопросом типа `Список`. В качестве опций списка можно задать:
	- `Отлично`
	- `Хорошо`
	- `Средне`
	- `Плохо`
1. Настройте интеграцию формы, например с [вашим API](../forms/send-request.md) сбора статистики.  

## Настройте триггер для добавления формы

### Создайте триггер

1. Перейдите в настройки очереди `General Questions` и в разделе **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_triggers.title }}** нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_triggers.button-create }}**.
1. Добавьте условие **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_card-settings.field-status }}** → **{{ ui-key.startrek-backend.messages.trigger.condition.type.fieldBecameEqual }}** → **{{ ui-key.startrek-backend.applinks.samsara.status.closed }}**.
1. Добавьте действие **{{ ui-key.startrek.blocks-desktop_trigger-action.select-action--comment }}**.
1. В текст комментария вставьте код:
   
   ```
   {{=<% %>=}}/iframe/(src="https://forms.yandex.ru/cloud/<id_формы>/?iframe=1" frameborder=0 width=100% height=660px scrolling=no)
   ```
   Где `<id_формы>` — идентификатор формы, которую необходимо добавить.
1. Нажмите ![](../_assets/tracker/summon.png) и в строке **{{ ui-key.startrek.blocks-desktop_trigger-action.createcomment--invite-from-field }}** введите <q>Исполнитель</q>.
1. Включите опцию **{{ ui-key.startrek.blocks-desktop_issue-reply-form.from-robot-checkbox }}**.
1. Сохраните триггер, нажав кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.action_create }}**.

### Дайте доступ роботу сервиса {{forms-name}}

Для корректной вставки формы дайте доступ к очереди роботу сервиса {{forms-name}} `yndx-forms-cnt-robot@`:

1. В настройках очереди `General Questions` выберите **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--permissions }}**.
1. В блоке **{{ ui-key.startrek.blocks-desktop_issues-filter-update-modal.access-rights }}** в поле поиска введите `Робот` и выберите из списка опцию **Робот сервиса {{forms-name}} Робот**. 
1. Нажмите **{{ ui-key.startrek.blocks-desktop_issues-filter-update-modal.action_submit }}**.

## Проверьте работу триггера

1. На странице очереди `General Questions` создайте задачу.
1. Измените статус задачи на **{{ ui-key.startrek-backend.applinks.samsara.status.closed }}**.
1. Убедитесь, что появился комментарий с формой обратной связи.