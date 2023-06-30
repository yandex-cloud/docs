# Командная оценка задач

В [гибких методологиях разработки]({{ link-wiki-agile }}) команды используют для совместной оценки задач [покер планирования (Planning Poker)]({{ link-wiki-poker }}). Участники планирования оценивают трудоемкость задачи независимо друг от друга в относительных единицах Story Points. Затем участники планирования объявляют свои оценки, обсуждают их и приходят к окончательной оценке. Обычно для покера планирования используют специальные карты, на которые нанесены числа выбранной шкалы оценки.

В {{ tracker-name }} вы можете проводить командную оценку задач на странице покера планирования.

{% note warning %}

Покер планирования доступен только на досках типа **{{ ui-key.startrek.components_QueuePresetOnboarding.preset-name--scrum-development-preset }}**.

{% endnote %}

## Провести оценку задач {#section_estimate}

1. Чтобы перейти на страницу покера, откройте вашу доску и в правом верхнем углу страницы нажмите кнопку **{{ ui-key.startrek.ui_components_agile_poker_PokerButton.poker }}**.

1. Попросите других участников планирования перейти на страницу покера. Все пользователи, которые зашли на страницу, будут отображены в блоке **{{ ui-key.startrek.components_Poker.users-section-title }}**.

1. Чтобы добавить задачу в список на оценку, на левой панели в поле поиска введите ключ или название задачи.

1. Чтобы выбрать задачу для оценки, на левой панели на карточке задачи нажмите кнопку **{{ ui-key.startrek.components_Poker.estimate }}**. 

1. На правой панели нажмите кнопку с оценкой, которую вы хотите выставить выбранной задаче.

1. Дождитесь, пока остальные участники планирования выставят свои оценки. В блоке **{{ ui-key.startrek.components_Poker.users-section-title }}** под именами участников появятся значки ![](../../_assets/tracker/estimate-done.png).

1. Нажмите кнопку **{{ ui-key.startrek.ui_components_agile_poker_PokerIssueForm.show-estimates }}**. Под именами участников планирования появятся значения оценок, которые они выбрали. 

    Итоговая оценка будет [автоматически рассчитана](#section_calc) и сохранена в поле **{{ ui-key.startrek.components_Poker.mark-title }}**. При необходимости вы можете изменить это значение.

1. Чтобы завершить оценку задачи, нажмите кнопку **{{ ui-key.startrek.ui_components_agile_poker_PokerIssueForm.apply-estimate }}**. Значение из поля **{{ ui-key.startrek.components_Poker.mark-title }}** будет скопировано в поле задачи **{{ ui-key.startrek-backend.fields.issue.storyPoints }}**, задача будет скрыта со страницы покера.

## Настроить шкалу оценки {#section_scale}

Обычно шкала оценки для покера планирования включает числа Фибоначчи или подобную числовую последовательность. Чтобы изменить шкалу оценки:

1. Откройте вашу доску и в правом верхнем углу страницы нажмите кнопку ![](../../_assets/tracker/edit-agile.png).

1. Перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_poker.title }}**.

1. Чтобы добавить число в шкалу оценки, введите его в поле **Добавить оценку**.

1. Чтобы удалить число из шкалы оценки, рядом с числом нажмите значок ![](../../_assets/tracker/delete-agile-status.png).

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_poker.action-save }}**.

## Настроить расчет итоговой оценки {#section_calc}

Вы можете выбрать, как будет определяться итоговая оценка трудоемкости задачи на основе оценок участников планирования. Для этого:

1. Откройте вашу доску и в правом верхнем углу страницы нажмите кнопку ![](../../_assets/tracker/edit-agile.png).

1. Перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_poker.title }}**.

1. В поле **{{ ui-key.startrek.ui_components_agile_settings_PokerSettings.aggregation-function-field-label }}** выберите функцию расчета. По умолчанию задано **{{ ui-key.startrek-backend.messages.boards.poker.aggregate.function.maximum.double }}**.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_poker.action-save }}**.




