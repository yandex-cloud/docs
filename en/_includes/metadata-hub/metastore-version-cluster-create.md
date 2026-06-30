Available versions: 3.1, 4.0, and 4.2.

{% note warning %}

Before integrating an {{ metastore-name }} cluster with [{{ msp-full-name }}](../../managed-spark/index.yaml), make sure their versions are compatible:

* {{ SPRK }} 3.5.7 supports {{ metastore-name }} 3.1.
* {{ SPRK }} 4.0.0 supports {{ metastore-name }} versions 3.1 and higher.

If required, you can upgrade from {{ metastore-name }} 3.1 in this sequence: 3.1 → 4.0 → 4.2. However, you cannot downgrade 4.2 to 3.1.

{% endnote %}
