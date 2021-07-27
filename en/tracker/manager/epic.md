---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Epics

An epic is a type of issue that allows you to group other issues based on a shared theme. Epics can include issues from different queues and sprints.

Epics are especially effective with **Scrum** boards for [planning your team's workload](create-agile-sprint.md#section_sjg_111_2gb). Issues in epics can be distributed within multiple sprints. This will let you predict labor costs and deadlines.

{% note warning %}

An issue can only be part of one epic at one time.

{% endnote %}

#### Filter issues by epic

1. On the top panel in {{ tracker-name }}, click **Boards** and select your board.

1. Click **Sprints** in the upper-right corner.

1. Select issue grouping by epic on the left side of the page.

    ![image](../../_assets/tracker/epic-pane.png)

    The list will display epics [added to the board](../user/agile.md#section_psd_wl4_vgb) or created there.

1. Click the epic card. Issues from the selected epic will be displayed in the backlog and sprints.

1. To view an epic's properties, click the arrow to the left of its name.

    An epic card displays the total number of issues within the epic, the total [Story Points](agile.md#dlen_sp) for all issues, the total number of assignees, and the queues whose issues are included in the epic.

#### Create an epic on the board

1. Above the epic list, click ![](../../_assets/tracker/add-sprint.png).

1. Specify the queue where the epic will be created as well as the epic's name and owner.

1. Click **Create epic**.

#### Add an issue to the epic

Go to the sprint page and drag an issue from the backlog or a sprint to the epic's card.

You can also add issues to epics using [links](../user/edit-ticket.md#section_wz1_rpn_jz):

1. Click **Actions** → **Add link** on the issue page.

1. Select the **Sub-epic** link type.

1. Specify the [epic key](../user/create-ticket.md#key).

#### Create a new issue in an epic

1. Expand the epic card by clicking the arrow to the left of its name.

1. Click **Create sub-issue** at the bottom.

1. Fill in the issue fields and click **Create**. Your new issue will be added to the epic.

#### Remove an issue from an epic

You can remove an issue from an epic on the sprint page or the issue page.

- Open the sprint page on the board and drag your issue to the **Without epics** card.

- Open the issue page, hover over the epic's field in the **Related** section, and click ![](../../_assets/tracker/delete-agile-status.png).

