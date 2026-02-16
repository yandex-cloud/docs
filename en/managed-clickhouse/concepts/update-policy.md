# {{ CH }} versioning policy

{{ CH }} employs the frequent release policy. {{ mch-name }} offers a limited set of {{ CH }} versions: {{ versions.console.str }}. The list of versions is continuously updated. If the {{ CH }} version used in a {{ mch-name }} cluster becomes deprecated, it gets updated.

Upgrading to current versions allows you to get new features, patches, and security fixes, which improves the overall stability of the cluster.

Each {{ CH }} version supported by {{ mch-name }} undergoes comprehensive testing. 

Upgrading to a new supported version of {{ CH }} does not affect data integrity and access.


## Versioning policy {#versioning-policy}

{{ mch-name }} uses two types of {{ CH }} versions:
- **LTS** (Long-Term Support) versions.

  LTS versions are supported for 12 months, with new versions released every 6 months.

  Two LTS versions are supported at the same time: the current one and the previous one. 
  
  When a new LTS version is released in {{ mch-name }}, the oldest available one becomes obsolete.

- **Interim** versions.

  The three latest {{ CH }} versions, including interim ones, are supported. If one of these versions is an LTS version, only two interim versions are supported.

  When a new interim {{ CH }} version is released in {{ mch-name }}, the oldest interim one becomes obsolete.

You can manually [update the cluster version](../operations/cluster-version-update.md) to one of the supported versions.

{% note warning %}

* For clusters with an obsolete {{ CH }} version, there is no option to create new hosts or restore from backups.
* Clusters running on an obsolete {{ CH }} version will be automatically updated according to the [update policy](#update-policy).

{% endnote %}


## Update policy {#update-policy}

{% list tabs %}

- LTS versions

  A {{ mch-name }} cluster running on an obsolete version of {{ CH }} will be updated to the next LTS version.
  
  ![image](../../_assets/mdb/mch-update-policy-lts.svg)
  
  {% note warning %}
  
  Users get notifications about the scheduled update of clusters using an obsolete LTS version **two months** and **one week** prior to the update.

  {% endnote %} 

- Interim versions

  A {{ mch-name }} cluster running on an obsolete {{ CH }} version will be upgraded to either the nearest LTS version, if available, or the latest interim version.
  
  ![image](../../_assets/mdb/mch-update-policy.svg)
  
  {% note warning %}
     
  * Users get notifications about the scheduled update of clusters using an obsolete interim version **one week** prior to the update.
  * If you upgrade to an LTS version, the appropriate update policy will apply to the cluster.

  {% endnote %}

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}