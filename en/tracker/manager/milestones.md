# Project milestones

Milestones indicate certain events in a project's timeline. With milestones, you can monitor the completion of project stages. For example, the <q>Web app launch</q> milestone shows that all the issues required for the launch are completed and you can proceed to the next stage.

A milestone has no start and end dates, as it indicates the deadline of a key event in the project timeline.

Project milestones in {{ tracker-name }} are displayed in the **About the project** tab under the project description. They are sorted by deadline, starting from the closest one.

On the [project Gantt chart](../gantt/project.md), milestones are shown as a diamond.

## Adding the <q>Milestone</q> issue type to a queue {#add-milestones}

A <q>milestone</q> is a special [issue type](add-ticket-type.md). This means that, to start using milestones in a queue, you should first add the <q>Milestone</q> issue type to a workflow in this queue. However, if you created a queue using [workflow templates](create-work-process.md), the <q>Milestone</q> issue type is already available in your queue and you do not need to add it to a workflow.

To add the <q>Milestone</q> issue type to your queue, follow this [guide](add-ticket-type.md#add-ticket-type-queue). Only the queue [administrator](../role-model.md#admin) can do it.

## Adding a milestone to a project {#add-milestones}

There are several ways to add a milestone to a project:

* Open the **About the project** tab and click **Add** in the **Milestones** section.

* In the **Issue list** tab, click **Add milestone**.

* In the **Gantt chart** tab, click **Add milestone** at the bottom of the issue list.

The add milestone window will show a list of queues whose workflow has the <q>Milestone</q> issue type added. If there are none, you can click the respective button in this window to add <q>Milestones</q> to the queues where you have administrator privileges. To do this, start typing the queue key and select a queue from the list. If you do not have queue setup permissions, contact the administrator.

