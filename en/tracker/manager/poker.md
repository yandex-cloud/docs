# Planning Poker

In [Agile development methodologies]({{ link-wiki-agile-en }}), development teams use [Planning Poker]({{ link-wiki-poker }}) for issue evaluation. Each planner provides an independent evaluation of the effort needed to complete the issue by assigning Story Points to it. After that, the planners announce their evaluations, discuss them, and arrive at a final evaluation. Planning Poker usually uses special cards numbered according to the selected evaluation scale.

In {{ tracker-name }}, you can use boards in Planning Poker mode to collaborate on workload estimation.

{% note warning %}

Planning Poker is enabled by default on boards with a **Backlog and sprints**. If you want to estimate issues using Planning Poker on a **Basic board**, [enable a backlog on it](backlog.md#add-backlog).

{% endnote %}

## Estimating effort for issues {#section_estimate}

1. To switch to poker mode, open your board and click **Planning poker** in any of its tabs.

1. In the window that opens, copy the poker link and send it to other team members. The poker page will list all the users who followed the link.

1. There are several ways to add an issue to a poker:
   * Drag the issue to the poker section from a sprint or backlog.
   * Click ![](../../_assets/tracker/svg/actions.svg) → **Add to poker** on the issue card.

1. Select the appropriate score for the issue and wait until other planners assign their values: you should see the green check mark in the card of each of them.

1. Tap **Show estimates**. The scores chosen by the other users appear under their names.

   The final score will be [calculated automatically](#section_calc) and then saved in the **Estimate** field. You can change this value if needed.

1. Click **Set an estimate** to finalize the score. The score value from the **Estimate** field is copied to the **Story Points** field in the issue, and the issue disappears from the poker page.

## Configuring the estimation scale {#section_scale}

The estimation system used in planning poker usually includes Fibonacci numbers and similar number sequences. To change the scoring system:

1. Open your board and click **{{ ui-key.startrek.ui_Boards_pages_PageAgileBoard_PageAgileBoardHeader.settings }}** → **Poker** in the top-right corner.

1. To add a number to the scoring system, enter it in the **Deck of estimates** field.

1. To remove a number from the scoring system, click ![](../../_assets/tracker/delete-agile-status.png).

1. Tap **Save**.

## Configuring how the final score is calculated {#section_calc}

You can select how the values assigned by planners will affect the final effort estimate for your issues. To do this:

1. Open your board and click **{{ ui-key.startrek.ui_Boards_pages_PageAgileBoard_PageAgileBoardHeader.settings }}** → **Poker** in the top-right corner.

1. In the **Calculation of the final score** field, choose a calculation function. **Maximum value** is set by default.

1. Tap **Save**.

## Hide issues with Story Points set {#hide-estimated}

When you enable Planning Poker, issues that have a value set in the **Story Points** field are hidden automatically. To display these issues when poker mode is on, disable this option in the settings:

1. Open your board and click **{{ ui-key.startrek.ui_Boards_pages_PageAgileBoard_PageAgileBoardHeader.settings }}** → **Poker** in the top-right corner.
1. Enable the **Display estimated issues** option.