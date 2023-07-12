# {{ OS }} versioning policy

## Version support policy for {#versioning-policy}

{{ mos-name }} works only with manufacturer-supported {{ OS }} versions. For information about the EOL (end of life) for individual versions, see the vendor's [maintenance tables](https://opensearch.org/releases.html).

{{ mos-name }} uses two types of {{ OS }} versions:

- **Major versions**.

   Two major versions are supported: the current one and the previous one. When a new major version is released in {{ mos-name }}, the oldest available major version support is discontinued.

   The only exception is major version 1, which is not supported. Until major version 3 is released, only major version 2 is supported.

- **Minor versions**.

   The latest {{ OS }} minor version is supported for each available major version. When a new minor {{ OS }} version is released in {{ mos-name }}, support for the previous minor version is discontinued.

{% note warning %}

* You can't create new hosts in clusters on a discontinued version of {{ OS }}.
* Clusters on a deprecated version of {{ OS }} are automatically updated according to the [update policy](#update-policy).

{% endnote %}

## Update policy {#update-policy}

{% list tabs %}

- Major versions

   A {{ mos-name }} cluster running a discontinued {{ OS }} version is updated to the next major version (listed as LTS).


- Minor versions.

   A {{ mos-name }} cluster running a discontinued {{ OS }} version will be updated either to a major version, if available (listed as LTS), or the latest minor version.


{% endlist %}

The owner of the affected clusters receives a notice of the expected automatic update. When your {{ OS }} version approaches its EOL, we recommend that you update the cluster to a newer version.
