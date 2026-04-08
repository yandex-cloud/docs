# Projects

A project is a logical resource organization unit in {{ stackland-name }}. A project groups together several Kubernetes namespaces for access and quota management at the team or application level.

## Resource hierarchy {#hierarchy}

{{ stackland-name }} uses a three-tier hierarchy:

* **Cluster**: Top-level entity that includes all {{ stackland-name }} resources.
* **Project**: Logical grouping of namespaces for a team or application.
* **Namespace**: Standard Kubernetes namespace used to isolate resources.

Each namespace belongs to a single project.

## Main features {#features}

### Namespace grouping {#namespace-grouping}

A project groups together several namespaces you want to manage in the same way. This helps with:

* Organizing development environments (dev, staging, and production).
* Separating microservices within an application.
* Managing team or department resources.

The names of project namespaces must be prefixed with `<project_name>-`. For example, for a project named `billing`, namespaces can be named `billing-backend` or `billing-frontend`.

### Access management {#access-management}

At the project level, you can assign roles to users and groups:

* Project-level roles automatically apply to all namespaces within the project.
* Project administrators can independently manage access without involving the cluster administrator.

For more information, see [Configuring roles in a project](../operations/projects/project-roles.md).

### Quotas {#quotas}

A project allows you to set shared resource quotas:

* Limits on total CPU and memory usage across all project namespaces.
* Limits on storage capacity.
* Limits on the number of GPUs.

A cluster administrator sets quotas when creating or updating a project. If total resource usage across all project namespaces exceeds the set quota, you will not be able to create new resources.

For more information, see [Setting project quotas](../operations/projects/namespace-quotas.md).

## Project structure {#structure}

When you create projects, {{ stackland-name }} automatically creates system namespaces in the `project-<project_name>` format. These namespaces contain project management resources, such as `ProjectNamespace`, `ProjectRole`, and `ProjectRoleBinding`.

System namespaces are not used for user workloads.

## System projects {#system-projects}

### stackland project {#stackland-project}

When deploying {{ stackland-name }}, the system automatically creates a project named `stackland`. This project includes all system namespaces, such as `stackland-console` and `stackland-monitoring`.

### default project {#default-project}

When deploying {{ stackland-name }}, the system automatically creates a project named `default`. Namespaces created without an explicitly specified project are automatically added to the `default` project.

Namespaces in the `default` project may have no `default-` prefix. However, their names cannot start with `stackland-` or `project-`.

You cannot delete the `default` project.

## What's next {#what-is-next}

* [Creating a project](../operations/projects/create-project.md)
* [Managing namespaces in a project](../operations/projects/manage-namespaces.md)
* [Configuring roles in a project](../operations/projects/project-roles.md)
* [Setting project quotas](../operations/projects/namespace-quotas.md)
