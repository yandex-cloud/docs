# Case studies

1. For HR specialists:

   Configure the queue so that all employees can create new issues, but only the reporter and assignee can see them. For example, an employee reaches out to the department with a private request that only HR specialists should see.

   **Solution**: Under [Main queue participants](queue-access-types.md#main), configure permissions only to create issues for all the organization's users, and permissions to edit issues for the HR team. Under [Roles in issues](../../tracker/role-model), grant view and edit [permissions](queue-access-types.md) to the reporter and assignee.

1. For information security:

   Configure [access](queue-access-types.md) restrictions for issues using the [component](components.md). For example, you need to restrict access for all users with different roles in the issue, except for the **Information security** group.

   **Solution**: [Create](components.md#create-component) a component in the queue, e.g., **private**. For the **private** component, under [Main participants](queue-access-types.md#main), grant permissions to create and edit issues to the **Information security** group. Leave the [Roles in issues](queue-access-types.md#task-role) block as it is, with the **Doesn't affect access** labels.