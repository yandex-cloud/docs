# Access management

In this section, you'll learn:

* [What resources you can assign roles to](#resources).
* [What roles exist in the service](#roles-list).
* [What roles are required](#required-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## What resources you can assign roles to {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## What roles exist in the service {#roles-list}

The diagram shows which roles are available in the service and how they inherit each other's permissions. For example, the `editor` role includes all `viewer` role permissions. A description of each role is given under the diagram.

![image](../../_assets/load-testing/service-roles-hierarchy.svg)

Active roles in the service:

* Primitive roles:

    * {% include [viewer](../../_includes/iam/roles/short-descriptions/viewer.md) %}
    * {% include [editor](../../_includes/iam/roles/short-descriptions/editor.md) %}
    * {% include [admin](../../_includes/iam/roles/short-descriptions/admin.md) %}

* Service roles:

    * `loadtesting.viewer`: Allows viewing reports and created agents.
    * `loadtesting.editor`: Allows viewing and deleting reports, and creating, deleting, and editing VMs with agents.
    * `loadtesting.admin`: The service currently doesn't include any administration capabilities, so this role repeats the permissions granted by the `editor` role.
    * `loadtesting.loadTester`: Allows running and stopping load tests, uploading payloads, and deleting reports.
    * `loadtesting.generatorClient`: Allows running a test on an agent and uploading test results to storage (granted to the service account that the VM with the agent is created under).

#### What's next {#next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [For more information about role inheritance, ](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
