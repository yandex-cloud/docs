# Collaborative workload estimation

In [agile development methodologies]({{ link-wiki-agile-en }}), development teams use [Planning Poker]({{ link-wiki-poker }}) for issue evaluation. Each planner provides an independent evaluation of the effort needed to complete the issue by assigning Story Points to it. After that, the planners announce their evaluations, discuss them, and arrive at a final evaluation. Planning Poker usually uses special cards numbered according to the selected evaluation scale.

You can use the planning poker page in {{ tracker-name }} to collaborate on workload estimation.

{% note warning %}

Planning poker is only available for **{{ ui-key.startrek.components_QueuePresetOnboarding.preset-name--scrum-development-preset }}** boards.

{% endnote %}

## Estimating effort for issues {#section_estimate}

1. To go to the planning poker page, open your board and click **{{ ui-key.startrek.ui_components_agile_poker_PokerButton.poker }}** in the top-right corner.

1. Ask other planners to go to the poker page. All users visiting the page can be seen in the **{{ ui-key.startrek.components_Poker.users-section-title }}** section.

1. To add an issue to the list for estimation, enter the issue name or key in the search box on the left panel.

1. To select an issue to estimate, find the issue card in the left-hand panel and click **{{ ui-key.startrek.components_Poker.estimate }}**.

1. On the right panel, click a button with the value that you want to assign to the selected issue.

1. Wait until the other planners assign their values. In the **{{ ui-key.startrek.components_Poker.users-section-title }}** section, you will see ![](../../_assets/tracker/estimate-done.png) under planner names.

1. Click **{{ ui-key.startrek.ui_components_agile_poker_PokerIssueForm.show-estimates }}**. The scores chosen by the other users appear under their names.

    The final score will be [calculated automatically](#section_calc) and then saved in the **{{ ui-key.startrek.components_Poker.mark-title }}** field. You can change this value if needed.

1. Click **{{ ui-key.startrek.ui_components_agile_poker_PokerIssueForm.apply-estimate }}** to finalize the score. The score value from the **{{ ui-key.startrek.components_Poker.mark-title }}** field is copied to the **{{ ui-key.startrek-backend.fields.issue.storyPoints }}** field in the issue, and the issue disappears from the poker page.

## Configuring the estimation scale {#section_scale}

The estimation system used in planning poker usually includes Fibonacci numbers and similar number sequences. To change the scoring system:

1. Open your board and click ![](../../_assets/tracker/edit-agile.png).

1. Go to the **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_poker.title }}** tab.

1. To add a number to the scoring system, enter it in the **Add estimate** field.

1. To remove a number from the scoring system, click ![](../../_assets/tracker/delete-agile-status.png).

1. Click **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_poker.action-save }}**.

## Configuring how the final score is calculated {#section_calc}

You can select how the values assigned by planners will affect the final effort estimate for your issues. To do this:

1. Open your board and click ![](../../_assets/tracker/edit-agile.png).

1. Go to the **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_poker.title }}** tab.

1. In the **{{ ui-key.startrek.ui_components_agile_settings_PokerSettings.aggregation-function-field-label }}** field, choose a calculation function. **{{ ui-key.startrek-backend.messages.boards.poker.aggregate.function.maximum.double }}** is selected by default.

1. Click **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_poker.action-save }}**.
