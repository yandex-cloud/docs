# Collaborative workload estimation

Teams that follow the agile software development approach use the [Planning Poker]({{ link-wiki-poker }}) technique for getting an estimate of their workload. Each team member individually rates an issue's complexity by using Story Points as a scoring system. The team members then announce and discuss their scores and decide on a final score. Planning poker usually requires special cards with numbers that represent the issue's score.

You can use the planning poker page in {{ tracker-name }} to collaborate on workload estimation.

{% note warning %}

Planning poker is only available for **Scrum** boards.

{% endnote %}

## Estimating effort for issues {#section_estimate}

1. To go to the planning poker page, open your board and click **Poker** in the upper-right corner.

1. Ask the other participants to go to the poker page. Everyone who is on the page is shown in the **Team** section.

1. To add an issue to the list for estimation, enter the issue name or key in the search box on the left panel.

1. To select an issue to estimate, find the issue card on the left panel and click **Estimate**.

1. On the right-hand panel, click the button that corresponds to the score you want to give to this issue.

1. Wait until the other users choose their scores. In the **Team** section, you'll see ![](../../_assets/tracker/estimate-done.png) icons under users' names.

1. Click **Show values**. The scores chosen by the other users appear under their names.

    The final score will be [calculated automatically](#section_calc) and then saved in the **Estimate** field. You can change this value if necessary.

1. Click **Rate** to finalize the score. The score value from the **Estimate** field is copied to the **Story Points** field in the issue, and the issue disappears from the poker page.

## Configuring the estimation scale {#section_scale}

The estimation system used in planning poker usually includes Fibonacci numbers and similar number sequences. To change the scoring system:

1. Open your board and click ![](../../_assets/tracker/edit-agile.png) in the upper-right corner.

1. Go to the **Poker** tab.

1. To add a number to the scoring system, enter it in the **Add estimate** field.

1. To remove a number from the scoring system, click ![](../../_assets/tracker/delete-agile-status.png) next to the number.

1. Click **Save**.

## Configuring how the final score is calculated {#section_calc}

You can choose the method for calculating the issue's final difficulty score based on the scores submitted by other participants. To do this:

1. Open your board and click ![](../../_assets/tracker/edit-agile.png) in the upper-right corner.

1. Go to the **Poker** tab.

1. Choose the calculation function in the **Calculation of final estimate** field. **Maximum value** is set by default.

1. Click **Save**.

