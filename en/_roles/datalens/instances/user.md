The `datalens.instances.user` role grants access to DataLens as a user with permissions to create, read, and edit objects according to the permissions to [objects](../../../datalens/concepts/index.md#component-interrelation) and allows to view information on organization [folders](../../../resource-manager/concepts/resources-hierarchy.md#folder).

After you assign a service role, you can grant the user permissions to objects and directories in DataLens.

{% note tip %}

We recommend using the `datalens.creator` role instead of the `datalens.instances.user` one. The two roles grant identical permissions, but using `datalens.creator` is safer, because it only allows access to the DataLens instance, and disallows viewing all organization folders.

{% endnote %}

