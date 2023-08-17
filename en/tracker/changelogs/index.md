# {{ tracker-full-name }} revision history for May 2023

* [Updates](#top-news)
* [Fixes and improvements](#fixes)

## Updates {#top-news}

### Switching boards to new technologies {#old-to-new}

You can now [switch](../manager/boards-convertor.md) the old boards to our [new technologies](../manager/agile-new.md). When migrating the board, the following is retained:
* ID.
* Name.
* Issues added.
* Status distribution by column.
* **Reported by me** and **Assigned to me** filters.
* Filter for adding issues.

You can switch your board back to the old version after migration, if needed. To do this, click ![](../../_assets/tracker/svg/actions.svg) → **Switch back to the old version** in the board's top panel and wait until it switches back.

### Grouping issues by any field {#grouping}

You can now group issues by any field. This kind of grouping is supported for a [list of project issues](../manager/project-list.md), a project's Gantt chart, and on [new boards](../manager/agile-new.md).

To group issues, click ![](../../_assets/tracker/svg/group.svg) and select a field.

### Setting up an issue color for a Gantt chart based on a queue and filter {#gantt-colours-filter}

A [Gantt chart](../gantt/project.md) based on a queue and filter allows you to set a color for issues depending on the selected parameter (queue, status, etc.). To do this, click **Chart settings** on the Gantt chart page and select **by issue parameters** under **Issue color**.

### **Collapse** and **Expand** buttons {#new-buttons}

The **Issue list** and **Gantt chart** tabs of the [project](../manager/project-new.md) page now have the **Collapse** and **Expand** buttons. Use them to expand and collapse:
* All sub-issues in a tree list.
* All groups in grouping mode.

### Navigation with arrows {#arrow-buttons}

You can now use the keyboard to move across your issue list:

* Arrow keys to navigate the menu.
* **Enter** or spacebar to follow a link.


### Disabling an organization {#no-orgs}

Now, to work in {{ tracker-name }}, {{ wiki-name }}, and {{ forms-name }}, you can choose one [organization](../cloud-vs-360.md) and disable another one if you do not need it. To disable an organization, go to ![](../../_assets/tracker/svg/admin.svg) **Administration** → ![](../../_assets/tracker/svg/organizations.svg) [**Organizations**]({{ link-tracker }}admin/orgs). Click ![](../../_assets/tracker/dots.png) and select **Disable**.

In this case, it will be disconnected from {{ tracker-name }}, {{ wiki-name }}, and {{ forms-name }}. Its data will not be lost. However, this organization's users will be marked as dismissed, the groups will be deleted, and the access rights will be revoked. The email aliases set up on the domain in the queues will be deleted.


### Buttons to navigate through comments {#comment-up-down}

There are new buttons that allow you to move to the first or last comment in issues. To move to an issue description, double-click ![](../../_assets/tracker/to-first-comment.png =12x12).
You can also use the following keys for navigation:

* **Windows**: **Home** or **End**.
* **Mac OS**: **⌘** + **↑** or **⌘** + **↓**.

### Mandatory comments on the transition screen {#flow-comments}

In the [new workflow editor](../manager/workflow.md), you can now make it mandatory to write a comment when changing an issue's status. To make the **Comment** field required, go to the workflow editor and select&nbsp;**Required** in the **Transition screen** section.

### Displaying completed sprints {#scroll-fixed}

* Fixed the bug when the list of completed sprints was only displayed in part.
* Completed sprints are sorted by end date: those completed most recently are shown at the top of the list.
* There is a new button to switch to the sprint issue list on the filter page.
