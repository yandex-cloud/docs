# Покер планирования

В [гибких методологиях разработки]({{ link-wiki-agile }}) команды используют для совместной оценки задач [покер планирования (Planning Poker)]({{ link-wiki-poker }}). Участники планирования оценивают трудоемкость задачи независимо друг от друга в относительных единицах Story Points. Затем участники планирования объявляют свои оценки, обсуждают их и приходят к окончательной оценке. Обычно для покера планирования используют специальные карты, на которые нанесены числа выбранной шкалы оценки.

В {{ tracker-name }} вы можете проводить командную оценку задач на доске в режиме покера планирования.

{% note warning %}

Покер планирования по умолчанию подключен на досках **С бэклогом и спринтами**. Если вы хотите оценивать задачи с помощью покера на **Простой доске**, [включите на ней бэклог](backlog.md#add-backlog).

{% endnote %}

## Провести оценку задач {#section_estimate}

1. Чтобы перейти в режим покера, откройте вашу доску и на любой ее вкладке нажмите кнопку **{{ ui-key.startrek.ui_components_agile_common_AgileTabs.poker }}**.

1. В открывшемся окне скопируйте ссылку на покер и отправьте ее другим участникам команды. Все пользователи, которые перешли по ссылке, отобразятся на странице покера.

1. Добавить задачу в покер можно несколькими способами:
   * перетащить задачу в блок покера из спринта или бэклога;
   * на карточке задачи нажать ![](../../_assets/tracker/svg/actions.svg) → **{{ ui-key.startrek.ui_components_agile_poker_hooks.add-issue-to-poker }}**.

1. Выберите подходящую оценку для задачи и дождитесь, когда остальные участники планирования выставят свои оценки — на карточке каждого участника должна отобразиться зеленая галочка.

1. Нажмите кнопку **{{ ui-key.startrek.ui_components_agile_poker_PokerIssueForm.show-estimates }}**. Под именами участников планирования появятся значения оценок, которые они выбрали. 

    Итоговая оценка будет [автоматически рассчитана](#section_calc) и сохранена в поле **Оценка**. При необходимости вы можете изменить это значение.

1. Чтобы завершить оценку задачи, нажмите **{{ ui-key.startrek.ui_components_agile_poker_PokerIssueForm.apply-estimate }}**. Значение из поля **Оценка** будет скопировано в поле задачи **Story Points**, задача будет скрыта со страницы покера.

## Настроить шкалу оценки {#section_scale}

Обычно шкала оценки для покера планирования включает числа Фибоначчи или подобную числовую последовательность. Чтобы изменить шкалу оценки:

1. Откройте вашу доску и в правом верхнем углу нажмите **{{ ui-key.startrek.ui_components_PageAgileBoard_PageAgileBoardHeader.settings }}** → **{{ ui-key.startrek.ui_components_agile_settings_AgileSettingsLayout.poker }}**.

1. Чтобы добавить число в шкалу оценки, введите его в поле **{{ ui-key.startrek.ui_components_agile_settings_PokerSettings.deck-field-label }}**.

1. Чтобы удалить число из шкалы оценки, рядом с числом нажмите значок ![](../../_assets/tracker/delete-agile-status.png).

1. Нажмите кнопку **{{ ui-key.startrek.ui_components_agile_settings_PokerSettings.save }}**.

## Настроить расчет итоговой оценки {#section_calc}

Вы можете выбрать, как будет определяться итоговая оценка трудоемкости задачи на основе оценок участников планирования. Для этого:

1. Откройте вашу доску и в правом верхнем углу нажмите **{{ ui-key.startrek.ui_components_PageAgileBoard_PageAgileBoardHeader.settings }}** → **{{ ui-key.startrek.ui_components_agile_settings_AgileSettingsLayout.poker }}**.

1. В поле **{{ ui-key.startrek.ui_components_agile_settings_PokerSettings.aggregation-function-field-label }}** выберите функцию расчета. По умолчанию задано **Максимальное значение**.

1. Нажмите кнопку **{{ ui-key.startrek.ui_components_agile_settings_PokerSettings.save }}**.

## Скрывать задачи с выставленными Story Points {#hide-estimated}

При включении покера планирования автоматически скрываются задачи с заполненным полем **Story Points**. Если вы хотите продолжать видеть эти задачи при включенном режиме покера, отключите эту опцию в настройках:

1. Откройте вашу доску и в правом верхнем углу нажмите **{{ ui-key.startrek.ui_components_PageAgileBoard_PageAgileBoardHeader.settings }}** → **{{ ui-key.startrek.ui_components_agile_settings_AgileSettingsLayout.poker }}**.
1. Активируйте опцию **{{ ui-key.startrek.ui_components_agile_settings_PokerSettings.display-estimated-field-label }}**.