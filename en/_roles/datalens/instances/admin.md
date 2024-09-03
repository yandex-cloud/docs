The `datalens.instances.admin` role allows you to access DataLens as a DataLens instance administrator. Administrators have full access to all [objects](../../../datalens/concepts/index.md#component-interrelation) and folders in DataLens, as well as to DataLens settings. The role also allows you to view information on organization [folders](../../../resource-manager/concepts/resources-hierarchy.md#folder).

This role also includes the `datalens.instances.user` permissions.

{% note tip %}

We recommend using the `datalens.admin` role instead of the `datalens.instances.admin` one. The two roles grant identical permissions, but using `datalens.admin` is safer, because it only allows access to the DataLens instance, and disallows viewing all organization folders.

{% endnote %}

