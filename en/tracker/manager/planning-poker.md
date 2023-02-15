# Collaborative workload estimation

In [Agile development methodologies]({{ link-wiki-agile-en }}), development teams use [Planning Poker]({{ link-wiki-poker }}) for issue evaluation. Each planner provides an independent evaluation of the effort needed to complete the issue by assigning Story Points to it. After that, the planners announce their evaluations, discuss them, and arrive at a final evaluation. Planning Poker usually uses special cards numbered according to the selected evaluation scale.

You can use the planning poker page in {{ tracker-name }} to collaborate on workload estimation.

{% note warning %}

Planning poker is only available for **Scrum** boards.

{% endnote %}

## Estimating effort for issues {#section_estimate}

1. To go to the planning poker page, open your board and click **Poker** in the upper-right corner.

1. Ask other planners to go to the poker page. Everyone who is on the page is shown in the **Team** section.

1. To add an issue to the list for estimation, enter the issue name or key in the search box on the left panel.

1. To select an issue to estimate, find the issue card on the left panel and click **Estimate**.

1. On the right panel, click a button with the value that you want to assign to the selected issue.

1. Wait until the other planners assign their values. In the **Team** section, you'll see ![](../../_assets/tracker/estimate-done.png).

1. Click **Show values**. The scores chosen by the other users appear under their names.

    The final score will be [calculated automatically](#section_calc) and then saved in the **Estimate** field. You can change this value if needed.

1. Click **Rate** to finalize the score. The score value from the **Estimate** field is copied to the **Story Points** field in the issue, and the issue disappears from the poker page.

## Configuring the estimation scale {#section_scale}

The estimation system used in planning poker usually includes Fibonacci numbers and similar number sequences. To change the scoring system:

1. Open your board and click ![](../../_assets/tracker/edit-agile.png).

1. Go to the **Poker** tab.

1. To add a number to the scoring system, enter it in the **Add estimate** field.

1. To remove a number from the scoring system, click ![](../../_assets/tracker/delete-agile-status.png).

1. Click **Save**.

## Configuring how the final score is calculated {#section_calc}

You can select how the values assigned by planners will affect the final effort estimate for your issues. To do this:

1. Open your board and click ![](../../_assets/tracker/edit-agile.png).

1. Go to the **Poker** tab.

1. Choose the calculation function in the **Calculation of final estimate** field. **Maximum value** is set by default.

1. Click **Save**.




