# {{ datalens-name }}

{{ datalens-full-name }} is a business analytics and data visualization platform. With it, you can create interactive dashboards, charts, and tables based on various data sources. The component is built upon [DataLens On-premises](https://datalens.ru/on-premises/docs/ru/).

## Main features {#features}

* Creating interactive dashboards and charts
* Connecting to {{ PG }}, {{ CH }}, and other data sources
* Shared access to collections and workbooks
* Role-based access management

## UI access {#ui}

The {{ datalens-name }} UI is available at `https://datalens.sys.<cluster_domain>`. Authentication is managed with {{ iam-name }}.

When the component is activated for the first time, the system automatically creates the `stackland-datalens-admins` group and adds the cluster administrator to it. Members of this group get the `datalens.admin` role.

## Access management {#access}

{{ datalens-name }} supports three roles:

* `datalens.admin`: Full access to {{ datalens-name }}, including management of users, collections, workbooks, and data sources. This role is assigned in {{ iam-name }} via the `stackland-datalens-admins` group.
* `datalens.creator`: Permission to create and modify objects (dashboards, charts, datasets, and connections).
* `datalens.visitor`: View-only access to published objects. This is the default role for authenticated users.

Roles are mapped to {{ iam-name }} groups. To assign a user the `datalens.admin` role, add them to the `stackland-datalens-admins` group.

### Adding a user via the UI {#add-user-ui}

A {{ datalens-name }} administrator can add a local user via the web UI.

To add a user:

1. Open the {{ datalens-name }} web UI at `https://datalens.<cluster_domain>`.
1. In the left-hand menu, select **Service settings**.
1. Go to the **Users** tab.
1. Click **+ Add user**.
1. Fill in the **Add user** form with the following user details:

   * **Login** for {{ datalens-name }} authentication.
   * **First name**. This is an optional field.
   * **Last name**. This is an optional field.
   * **Email**. This is an optional field.
   * **Role** in {{ datalens-name }}: `Admin`, `Creator`, or `Visitor`.
   * **Group**: User group. This is an optional field.
   * **Password** for authentication. Click **Generate password** to create one automatically.

1. Click **Add**.

## Dependencies {#dependencies}

To use {{ datalens-name }}, you also need the following components:

* [{{ mpg-name }}](postgresql.md): To store {{ datalens-name }} data.
* [{{ iam-name }}](iam.md): For user authentication and authorization.

## Configuration {#configuration}

To manage the component, use the `DataLensConfig` custom resource.

Here is an example:

{% include notitle [YAML-file](../../_includes/yamls/components/datalensconfig.md) %}

Where:

* `enabled`: Enables and disables the component.
* `settings.clusterIssuer`: ClusterIssuer name for TLS certificates. The default value is `stackland-default`.
* `settings.database.instances`: Number of {{ PG }} instances. The default value is one.
* `settings.database.storageSize`: Database storage size. The default value is `2Gi`.
* `settings.database.storageClass`: Storage class. Defaults to the platform's storage class.
* `settings.database.logLevel`: {{ PG }} logging level. The default value is `info`.
* `settings.database.resources`: Resources allocated for database pods:
  * `requests`: Minimum resource requirements.
  * `limits`: Maximum resource limits.

## See also {#see-also}

* [{#T}](../../operations/datalens/install-images.md)
* [{#T}](../../operations/datalens/configure.md)
* [{#T}](../../operations/datalens/disable.md)
