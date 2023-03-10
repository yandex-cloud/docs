# {{ ES }} versioning policy

By updating to the latest versions, you get new features, revisions, and bug fixes.

{{ mes-name }} always supports multiple {{ ES }} versions. Support for new versions is added as they are released.

Each {{ ES }} version supported is tested thoroughly. That's why, when you update versions, the integrity and availability of your cluster data is not affected.

## Version support policy {#versioning-policy}

Each {{ ES }} version supported in {{ mes-name }} remains available as long as it's maintained by the vendor (usually 18 months after the release date). For detailed information about the EOL (end of life) for individual versions, see the [vendor's maintenance tables](https://www.elastic.co/support/eol).

## Update policy {#update-policy}

A {{ mes-name }} cluster running the {{ ES }} version past its EOL is automatically updated with the most up-to-date and stable maintained version.

{% note info %}

Notifications about the planned automatic update are sent to users both **one month** and **two days** before the EOL of the {{ ES }} version run by the clusters.

{% endnote %}

When your {{ ES }} version approaches its EOL, we recommend that you [update the cluster](../operations/cluster-version-update.md#version-update) to a newer {{ ES }} version.
