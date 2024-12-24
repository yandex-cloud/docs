# Шаблоны рабочих процессов

Шаблон рабочего процесса — набор инструментов {{ tracker-name }}, сгруппированных и настроенных для наиболее распространенных рабочих процессов.

## {{ ui-key.startrek.ui_Queues_constants.process-type-project }} {#manage-process-template}

Подходит для ведения проектов, ограниченных по времени и числу задач. Проект направлен на достижение общего результата одной или несколькими командами. В проекте удобно группировать задачи нескольких команд, работающих над общей целью, выстраивать [иерархию задач](project-list.md) и планировать сроки.

При выборе этого шаблона автоматически создается:
  * [проект](project-new.md) с [диаграммой Ганта](../gantt/overview.md) и [доской задач](boards-project.md);
  * [очередь](create-queue.md) с базовым набором [типов и статусов](workflow.md) задач.

Дополнительные очереди можно будет создать отдельно.

## {{ ui-key.startrek.ui_Queues_constants.process-type-development }} {#for-developers-template}

Подходит для команды разработки, которая управляет проектами по методологии [Скрам]({{ link-wiki-scrum }}). Инструменты {{ tracker-name }} позволяют декомпозировать проекты с помощью [эпиков](epic.md) и [Story](agile.md#sec_basics), планировать спринты и [оценивать задачи](planning-poker.md).

При выборе этого шаблона автоматически создается:
  * [доска задач](agile-new.md) с [бэклогом](backlog.md) и [покером планирования](planning-poker.md);
  * [очередь](create-queue.md) с базовым набором [типов и статусов](workflow.md) задач.

Если вы используете облачные сервисы GitHub, GitLab или Bitbucket, вы можете [подключить](../user/add-repository.md) любое число репозиториев и [привязывать](../user/ticket-links.md#section_commit) коммиты к задачам.

## {{ ui-key.startrek.ui_Queues_constants.process-type-support }} {#for-support-template}

Подходит для внутренней и внешней службы поддержки. Задачи можно создавать [из писем](queue-mail.md), отправленных на почту или через [форму обратной связи](forms-integration.md) на сайте, а также из интерфейса {{ tracker-name }} с помощью встроенной формы. Примеры шаблонов ответов, таймеров [SLA](sla.md) и автоответов на обращения уже настроены в этом шаблоне.

При выборе этого шаблона автоматически создается:
  * очередь задач [с формой для обращений](../../forms/new-form.md);
  * [простая доска задач](boards-project.md);
  * [очередь](create-queue.md) с базовым набором [типов и статусов](workflow.md) задач.

## {{ ui-key.startrek.ui_Queues_constants.process-type-standard }} {#basic-template}

Подходит для знакомства с возможностями {{ tracker-name }}. Если вы выберете этот шаблон, позже его можно будет настроить и дополнить.

При выборе этого шаблона автоматически создается:
  * [простая доска задач](agile.md#sec_boards);
  * [очередь](create-queue.md) с базовым набором [типов и статусов](workflow.md) задач.

## Создать рабочий процесс из шаблона {#create-from-template}

1. На стартовой [**Моя страница**](https://tracker.yandex.ru/pages/my), на виджете **{{ ui-key.startrek.ui_Dashboards_smart-components_InfoPresetsWidget.widget-title }}**, нажмите кнопку **{{ ui-key.startrek.ui_Dashboards_smart-components_InfoPresetsWidget.choose-template-button }}**.
1. Выберите шаблон и нажмите кнопку **{{ ui-key.startrek.ui_Queues_smart-components_new-process_QueueSetupForm.next-button }}**.
1. Укажите параметры очереди:
    * Название очереди задач;
    * [Ключ очереди](create-queue.md#key);
    * Права доступа.
1. Нажмите кнопку **Продолжить**. В зависимости от выбранного шаблона откроется: 
    * [{{ ui-key.startrek.ui_Queues_constants.process-type-project }}](create-work-process.md#manage-process-template) — страница нового проекта.
    * [{{ ui-key.startrek.ui_Queues_constants.process-type-development }}](create-work-process.md#for-developers-template) — доска с бэклогом.
    * [{{ ui-key.startrek.ui_Queues_constants.process-type-support }}](create-work-process.md#for-support-template) — очередь задач.
    * [{{ ui-key.startrek.ui_Queues_constants.process-type-standard }}](create-work-process.md#basic-template) — доска задач.