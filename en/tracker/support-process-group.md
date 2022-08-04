# Grouping requests by topic

You will often need to group requests by certain parameters, such as issue type, product, and so on. This lets you pick assignees with the needed know-how for each specific issue, as well as collect and analyze request statistics.

Use components to group issues by topic:

1. In the support team queue, [create components](manager/components.md) that correspond to request types.

    You can make an employee responsible for a particular component and select **Assign by default** so that they also automatically become the assignee for any issue that contains the component they're responsible for.

1. If you don't want users to be able to view or edit issues containing specific components, [configure access rights for components](manager/queue-access.md#section_tbh_cs5_qbb).

1. If you want to automatically pick an assignee once a component is added to an existing issue, [set up a trigger](manager/trigger-examples.md#assign_ticket) that does that.

1. Use components in filters to search for issues by topic or configure [dashboards with statistics](#dashboards).

