# Grouping requests by topic

You might often need to group requests by certain attributes: problem type, product, and others. You might need it to assign issues to employees with the relevant expertise, as well as to collect and analyze statistics by request types.

To group issues by subject, use the following components:

1. In the support team queue, [create components](manager/components.md) that correspond to request types.

   You can make an employee responsible for a particular component and select **Assign to issues by default** so that they are automatically assigned any issue that contains a component they are responsible for.

1. If you do not want users to be able to view or edit issues containing specific components, [configure access rights for components](manager/queue-access.md#access-components).

1. If you want to automatically pick an assignee once a component is added to an existing issue, [set up a trigger](manager/trigger-examples.md#assign_ticket) that does that.

1. Use components in filters to search for issues by topic or configure [dashboards with statistics](#dashboards).