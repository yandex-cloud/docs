# Access management in {{ load-testing-name }}

{{ load-testing-name }} uses [roles](../../iam/concepts/access-control/roles.md) to manage access rights.

In this section, you will learn:
* [Which resources you can assign roles to](#resources).
* [Which roles exist in the service](#roles-list).
* [Which roles are required](#required-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign roles to {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Which roles exist in the service {#roles-list}

The chart below shows which roles are available in the service and how they inherit each other's permissions. For example, the `editor` role includes all `viewer` role permissions. You can find the description of each role under the chart.

![image](../../_assets/load-testing/service-roles-hierarchy.svg)

Active roles in the service:

* Primitive roles:
   * {% include [viewer](../../_includes/iam/roles/short-descriptions/viewer.md) %}
   * {% include [editor](../../_includes/iam/roles/short-descriptions/editor.md) %}
   * {% include [admin](../../_includes/iam/roles/short-descriptions/admin.md) %}
* Service roles:
   * `loadtesting.viewer`: Allows viewing reports and created agents.
   * `loadtesting.editor`: Allows viewing and deleting reports, creating, deleting, and editing VMs with agents, enables running and stopping load tests, loading test data, deleting reports, and uploading output to the repository.
   * `loadtesting.admin`: At the moment, the service does not include an administrative function, so the role has the same permissions as `loadtesting.editor`.
   * `loadtesting.loadTester`: Allows viewing and deleting reports, creating, deleting, and editing VMs with agents, enables the running of load tests, stopping tests, loading test data, and deleting reports.
   * `loadtesting.generatorClient`: Allows starting VMs, running tests on agents, and uploading the output to the repository (assigned to a service account that is used to create VMs with agents).

#### What's next {#next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
