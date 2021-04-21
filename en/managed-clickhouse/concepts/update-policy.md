# {{ CH }} versioning policy

{{ CH }} has a frequent release policy. In {{ mch-name }}, a limited set of {{ CH }} versions is available for use, and this set is continually maintained to ensure it is up to date. If the {{ CH }} version used in a {{ mch-name }} cluster becomes outdated, the cluster's version gets updated.

Updating to current versions allows you to get new functionality, patches, and security fixes, which improves the overall stability of the cluster.
Each {{ CH }} version supported by {{ mch-name }} undergoes comprehensive testing.

You can be confident that your data will remain safe and accessible after updating to a new supported version of {{ CH }}.

## Version support policy for {#versioning-policy}

{{ mch-name }} uses two types of {{ CH }} versions:

- **LTS** (versions with extended support period, Long-Term Support).

  The LTS version support period is 1 year, with new versions released every 6 months.

  Two LTS versions are supported: the current one and the previous one.

  When a new LTS version is released in {{ mch-name }}, the previous LTS version is deprecated. Users with clusters deployed on the current LTS version are notified that support for this version will be discontinued in 6 months.

- **Interim**.

  The three latest interim {{ CH }} versions that are not LTS versions are supported.

  When a new interim version of {{ CH }} is released in {{ mch-name }}, the oldest of the three supported interim versions is deprecated.

You can manually [change the cluster version](../operations/cluster-version-update.md) to one of the supported versions.

{% note warning %}

* You can't create new hosts in clusters on a deprecated version of {{ CH }}.
* Clusters on a deprecated version of {{ CH }} are automatically updated according to the [update policy](#update-policy).

{% endnote %}

## Update policy {#update-policy}

{% list tabs %}

- LTS versions

  A {{ mch-name }} cluster on a deprecated version of {{ CH }} is updated to the next LTS version.

  ![image](../../_assets/mdb/mch-update-policy-lts.svg)

  {% note warning %}

  Notifications about the scheduled update of clusters using a deprecated LTS version are sent to users **2 months**, **1 month**, and **1 week** before the update.

  {% endnote %}

- Interim versions

  A {{ mch-name }} cluster on a deprecated {{ CH }} version is updated to either an LTS version, if available, or the latest interim version.

  ![image](../../_assets/mdb/mch-update-policy.svg)

  {% note warning %}
  * Notifications about the scheduled update of clusters using a deprecated interim version are sent to users **1 week** before the update.
  * If you upgrade to the LTS version, the corresponding update policy is applied to the cluster.

  {% endnote %}

{% endlist %}

