# Sprints

{% note warning %}

You can only use sprints with **Scrum** boards.

{% endnote %}

{{ tracker-name }} can help you utilize the Scrum workflow approach. With scrum, all your pipeline is split into sprints. A sprint is a development cycle that lasts a certain amount of time. Each cycle starts with issue evaluation and planning for the upcoming sprint.

## Planning a sprint {#section_sjg_111_2gb}

#### Step 1. Estimate the effort required for issues

Estimate the effort it will take to implement the issues in the backlog. Effort is measured in Story Points, which is an abstract way to define the complexity of project issues relative to each other. Each team comes to an agreement on how they determine their workload.

Use [planning poker on the issue board](planning-poker.md) to assess an issue's complexity with your team.

If you've already decided on the score, you can [enter it on the issue page](../user/edit-ticket.md#section_jqw_ppn_jz) in the **Story Points** field.

To evaluate the complexity of multiple issues when planning a sprint:

1. On the {{ tracker-name }} top panel, click **Boards** and select your board.

1. Click **Sprints** in the upper-right corner.

1. If there are too many issues, you can always hide some of them using [filters](#section_ync_v5r_yfb).

1. Hover over the issue in the **Backlog** column.

1. Enter the number of **Story Points** in the field to the right.

    To add an issue to the poker page for [team evaluation](planning-poker.md), click ![](../../_assets/tracker/context-menu.png) and select **Add to poker**.

#### Step 2. Create a new sprint {#create_sprint}

1. Click ![](../../_assets/tracker/add-sprint.png) on the right of the **Sprints** section.

1. Enter the name of the sprint and the start and end time.

1. Click **Save**.

#### Step 3. Add issues to a sprint

There are multiple ways to add an issue to a sprint:

- Go to the **Sprints** page and drag an issue from the **Backlog** column to the sprint's column. If there are too many issues, you can always hide some of them using [filters](#section_ync_v5r_yfb).

- Specify your sprint on the issue page using the corresponding field on the right-hand panel.

- To quickly add multiple issues at once, use the [bulk change](bulk-change.md#section_x2j_4kr_fgb) feature: filter your issues and specify your sprint in the corresponding field when editing the issue.

## Changing sprint status {#section_f1f_21r_yfb}

The sprint's status reflects its completion stage. To change sprint status, do the following:

1. On the {{ tracker-name }} top panel, click **Boards** and select your board.

1. Click **Sprints** in the upper-right corner.

1. Click ![](../../_assets/tracker/edit-sprint.png) to the right of the sprint name.

1. Choose one of the following statuses:

    | Status | Description |
    | ----- | ----- |
    | Open | The sprint's issues are not yet being worked on. |
    | In progress | The sprint's issues are being worked on. |
    | Completed | Sprint issues resolved.<br/><br/> If your sprint contains unresolved issues or issues that have been closed with no resolution, please select what you want to do with them in the pop-up window: move to a backlog, move to a new spring, or leave in this sprint. |
    | Archived | The sprint has been archived and won't be displayed in the sprint list. To open the list of archived sprints, click **Archived sprints**.<br/><br/>You can't add an issue to an archived sprint. |

1. Click **Save**.

## Adding issues to an epic {#section_vj5_4f5_zfb}

Epic is a type of issue that allows you to group other issues from different queues and plan your workload.

You can use the board to [create epics and add issues to them](epic.md).

## Applying filters {#section_ync_v5r_yfb}

You can filter your issues to leave only the ones you need on the **Sprints** tab. To do this:

1. On the {{ tracker-name }} top panel, click **Boards** and select your board.

1. Click **Sprints** in the upper-right corner.

1. Choose the issue filter parameters on the left side of the page. To do this, click the filter button:

    - **Resolution**

        Select one or more resolution types from the list to only display completed issues falling under these resolutions.

    - **Status**

        Select one or more statuses from the list to only display issues falling under these status types.

    - **Assigned to me**

        The sprint's page will only display issues a user is working on.

    - **Reported by me**

        The sprint's page will only display issues created by the user.

    - [**Epics**](epic.md)

        To select issues included in an epic, click on the section with the epic's name.

        To select issues not included in an epic, click **No epics**.

    - **Versions**

        Click the section with the epic's name to only display issues of a certain version.

    - **Components**

        Click the section with the component's name to only display issues with that component.

    - **Tags**

        Click the section with the tag's name to only display issues that have that tag.

## Configuring how sprints are displayed {#section_jyp_w25_xgb}

You can set your sprint page to display issues and sprints in a single column. To do this:

1. {% include [open-personal-settings](../../_includes/tracker/open-personal-settings.md) %}

1. Choose **Display sprints and issues in a single column**.

1. Click **Save**.

