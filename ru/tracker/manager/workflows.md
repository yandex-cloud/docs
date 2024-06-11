# Шаблоны очередей

Чтобы вам было проще настроить {{ tracker-name }} для работы с вашими задачами, предусмотрены несколько шаблонов очередей для распространенных процессов. Шаблон очереди включает [воркфлоу](workflow.md) с предварительно настроенными типами задач и статусами.

## Базовый шаблон {#section_now}

Шаблон очереди с простым воркфлоу, который подойдет для первого знакомства с возможностями {{ tracker-name }}. Позже вы сможете настроить воркфлоу под ваши задачи.

При выборе этого шаблона автоматически создается [простая доска задач](../dev-process-agile.md#board_types) с таким же названием, как у очереди.

Воркфлоу включает типы задач:
- **Задача**;
- **Веха**.

Задачи могут иметь статусы:

- **{{ ui-key.startrek-backend.applinks.samsara.status.open }}**;
- **{{ ui-key.startrek-backend.applinks.samsara.status.in.progress }}**;
- **{{ ui-key.startrek-backend.applinks.samsara.status.need.info }}**;
- **{{ ui-key.startrek-backend.applinks.samsara.status.closed }}**.

При переходе задачи в статус **{{ ui-key.startrek-backend.applinks.samsara.status.closed }}** она будет закрыта с резолюцией **{{ ui-key.startrek-backend.applinks.samsara.resolution.resolved }}**.


## Управление проектами

Этот шаблон очереди подойдет для компании, в которой работают несколько команд.

При выборе этого шаблона для каждого проекта будет создаваться [простая доска задач](../dev-process-agile.md#board_types).

Воркфлоу включает типы задач:
- **Задача**;
- **Веха**.

Задачи могут иметь статусы:

- **{{ ui-key.startrek-backend.applinks.samsara.status.open }}**;
- **{{ ui-key.startrek-backend.applinks.samsara.status.in.progress }}**;
- **{{ ui-key.startrek-backend.applinks.samsara.status.need.info }}**;
- **{{ ui-key.startrek-backend.applinks.samsara.status.closed }}**.

При переходе задачи в статус **{{ ui-key.startrek-backend.applinks.samsara.status.closed }}** она будет закрыта с резолюцией **{{ ui-key.startrek-backend.applinks.samsara.resolution.resolved }}**.


## Разработка {#section_q5d_3rm_qz}

Этот шаблон очереди подойдет для команды разработки.

При выборе этого шаблона автоматически создается [доска задач «С бэклогом и спринтами»](../dev-process-agile.md#instrumenty-na-skram-doske), на которой можно планировать спринты, оценивать задачи и смотреть диаграмму сгорания задач.

Воркфлоу включает типы задач:

- **Задача**;
- **Веха**;
- **Ошибка**;
- **Релиз**;
- **Epic**;
- **Story**.

Задачи могут иметь статусы:

- **{{ ui-key.startrek-backend.presets.devPreset.board.column.open }}**;
- **{{ ui-key.startrek-backend.presets.developmentPreset.board.column.need.info }}**;
- **{{ ui-key.startrek-backend.presets.devPreset.board.column.in.progress }}**;
- **{{ ui-key.startrek-backend.presets.devPreset.board.column.closed }}**.

При переходе задачи в статус **{{ ui-key.startrek-backend.presets.devPreset.board.column.closed }}** пользователю будет предложено оставить комментарий и выбрать одну из резолюций:

- **{{ ui-key.startrek-backend.applinks.samsara.resolution.resolved }}**;
- **{{ ui-key.startrek-backend.applinks.samsara.resolution.rejected }}**.

## Поддержка {#section_nsm_jrm_qz}

Этот шаблон очереди поможет организовать службу поддержки пользователей.

При выборе этого шаблона автоматически создается [простая доска задач](../dev-process-agile.md#board_types) с таким же названием, как у очереди.

Воркфлоу включает типы задач:
- **Задача**;
- **Веха**;
- **Улучшение**;
- **Запрос**;
- **Ошибка**.

Задачи могут иметь статусы:

- **{{ ui-key.startrek-backend.applinks.samsara.status.open }}**;
- **{{ ui-key.startrek-backend.applinks.samsara.status.in.progress }}**;
- **{{ ui-key.startrek-backend.applinks.samsara.status.need.info }}**;
- **{{ ui-key.startrek-backend.applinks.samsara.status.closed }}**.

При переходе задачи в статус **{{ ui-key.startrek-backend.applinks.samsara.status.closed }}** пользователю будет предложено оставить комментарий и выбрать одну из резолюций:

- **{{ ui-key.startrek-backend.applinks.samsara.resolution.resolved }}**;
- **{{ ui-key.startrek-backend.applinks.samsara.resolution.rejected }}**.


## Производство {#section_production}

Этот шаблон очереди подойдет промышленным предприятиям.

При выборе этого шаблона автоматически создается [простая доска задач](../dev-process-agile.md#board_types) с таким же названием, как у очереди.

Воркфлоу включает типы задач:

- **Задача**;
- **Веха**.

Задачи могут иметь статусы:

- **{{ ui-key.startrek-backend.applinks.samsara.status.open }}**;
- **{{ ui-key.startrek-backend.applinks.samsara.status.need.info }}**;
- **{{ ui-key.startrek-backend.applinks.samsara.status.in.progress }}**;
- **Согласование результата**;
- **{{ ui-key.startrek-backend.applinks.samsara.status.closed }}**.

При переходе задачи в статус **{{ ui-key.startrek-backend.applinks.samsara.status.closed }}** пользователю будет предложено оставить комментарий и выбрать одну из резолюций:

- **{{ ui-key.startrek-backend.applinks.samsara.resolution.resolved }}**;
- **{{ ui-key.startrek-backend.applinks.samsara.resolution.rejected }}**.


## Маркетинг {#section_marketing}

Этот шаблон очереди подойдет организациям, которые проводят рекламные кампании.

При выборе этого шаблона для каждого проекта будет создаваться [простая доска задач](../dev-process-agile.md#board_types).

Воркфлоу включает типы задач:

- **Задача**;
- **Веха**.

Задачи могут иметь статусы:

- **{{ ui-key.startrek-backend.applinks.samsara.status.open }}**;
- **{{ ui-key.startrek-backend.applinks.samsara.status.in.progress }}**;
- **{{ ui-key.startrek-backend.applinks.samsara.status.need.info }}**;
- **{{ ui-key.startrek-backend.applinks.samsara.status.closed }}**.

При переходе задачи в статус **{{ ui-key.startrek-backend.applinks.samsara.status.closed }}** она будет закрыта с резолюцией **{{ ui-key.startrek-backend.applinks.samsara.resolution.resolved }}**.

## Оказание услуг {#section_service}

Этот шаблон очереди подойдет организациям, которые оказывают услуги компаниям и частным клиентам.

При выборе этого шаблона автоматически создается [простая доска задач](../dev-process-agile.md#board_types) с таким же названием, как у очереди.

Воркфлоу включает типы задач: 

- **Задача**;
- **Веха**.

Задачи могут иметь статусы: 

- **{{ ui-key.startrek-backend.applinks.samsara.status.open }}**;
- **{{ ui-key.startrek-backend.applinks.samsara.status.need.info }}**;
- **{{ ui-key.startrek-backend.applinks.samsara.status.in.progress }}**;
- **Согласование результата**;
- **{{ ui-key.startrek-backend.applinks.samsara.status.closed }}**.

При переходе задачи в статус **{{ ui-key.startrek-backend.applinks.samsara.status.closed }}** пользователю будет предложено оставить комментарий и выбрать одну из резолюций:

- **{{ ui-key.startrek-backend.applinks.samsara.resolution.resolved }}**;
- **{{ ui-key.startrek-backend.applinks.samsara.resolution.rejected }}**.

## Документооборот {#section_docflow}

Этот шаблон очереди поможет организовать процесс согласования документов.

При выборе этого шаблона автоматически создается [простая доска задач](../dev-process-agile.md#board_types) с таким же названием, как у очереди.

Воркфлоу включает типы задач:
- **Задача**;
- **Веха**;
- **Запрос**;
- **Документы**.

Задачи могут иметь статусы:

- **{{ ui-key.startrek-backend.applinks.samsara.status.open }}**;
- **{{ ui-key.startrek-backend.applinks.samsara.status.need.info }}**;
- **{{ ui-key.startrek-backend.applinks.samsara.status.in.progress }}**;
- **Согласование результата**;
- **Ожидание подтверждения**;
- **Документы подготовлены**;
- **{{ ui-key.startrek-backend.applinks.samsara.status.closed }}**.

При переходе задачи в статус **{{ ui-key.startrek-backend.applinks.samsara.status.closed }}** пользователю будет предложено оставить комментарий и выбрать одну из резолюций:

- **{{ ui-key.startrek-backend.applinks.samsara.resolution.resolved }}**;
- **{{ ui-key.startrek-backend.applinks.samsara.resolution.rejected }}**.

## Кадровые процессы {#section_hr}

Этот шаблон очереди нужен для задач отдела кадров.

При выборе этого шаблона автоматически создается [простая доска задач](../dev-process-agile.md#board_types) с таким же названием, как у очереди.

Воркфлоу включает типы задач:
- **Задача**;
- **Отсутствие**;
- **Командировка**;
- **Документы**;
- **Запрос**.

Задачи могут иметь статусы:

- **{{ ui-key.startrek-backend.applinks.samsara.status.open }}**;
- **{{ ui-key.startrek-backend.applinks.samsara.status.need.info }}**;
- **{{ ui-key.startrek-backend.applinks.samsara.status.in.progress }}**;
- **Документы подготовлены**;
- **Ожидание подтверждения**;
- **Согласование результата**;
- **{{ ui-key.startrek-backend.applinks.samsara.status.closed }}**.

При переходе задачи в статус **{{ ui-key.startrek-backend.applinks.samsara.status.closed }}** пользователю будет предложено оставить комментарий и выбрать одну из резолюций:

- **{{ ui-key.startrek-backend.applinks.samsara.resolution.resolved }}**;
- **{{ ui-key.startrek-backend.applinks.samsara.resolution.rejected }}**.

## Подбор персонала {#section_hire}

Этот шаблон очереди поможет организовать процесс найма сотрудников.

При выборе этого шаблона автоматически создается [простая доска задач](../dev-process-agile.md#board_types) с таким же названием, как у очереди.

Воркфлоу включает типы задач:
- **Задача**;
- **Веха**;
- **Вакансия**;
- **Кандидат**.

Задачи могут иметь статусы: 
- **{{ ui-key.startrek-backend.applinks.samsara.status.open }}**;
- **{{ ui-key.startrek-backend.applinks.samsara.status.need.info }}**;
- **{{ ui-key.startrek-backend.applinks.samsara.status.in.progress }}**;
- **Согласование результата**;
- **Ожидание подтверждения**;
- **Документы подготовлены**;
- **{{ ui-key.startrek-backend.applinks.samsara.status.closed }}**.

При переходе задачи в статус **{{ ui-key.startrek-backend.applinks.samsara.status.closed }}** пользователю будет предложено оставить комментарий и выбрать одну из резолюций:

- **{{ ui-key.startrek-backend.applinks.samsara.resolution.resolved }}**;
- **{{ ui-key.startrek-backend.applinks.samsara.resolution.rejected }}**.

## Управление целями {#section_goals}

Этот шаблон очереди нужен для постановки целей компании и контроля над их выполнением.

Воркфлоу включает типы задач:

- **Цель**;
- **Веха**.

Задачи могут иметь статусы:

- **Новая цель**;
- **По плану**;
- **Есть риски**;
- **Отменена**;
- **Достигнута**;
- **Цель заблокирована**.

При переходе задачи в статус **Отменена** или **Достигнута** пользователю будет предложено оставить комментарий и выбрать одну из резолюций:

- **Успешно**; 
- **Перевыполнено**;
- **{{ ui-key.startrek-backend.applinks.samsara.resolution.duplicate }}**; 
- **Позже**;
- **Не делаем**.
