### Database version is out of date {#opensearch_deprecated_version}

**Description**

Database version is out of date. Support for the version was officially discontinued. Clusters are running, but support is limited. We recommend upgrading to a supported version.

**Action**

To upgrade the database version:

1. In the [management console]({{ link-console-main }}), navigate to the folder page.
1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
1. Select the cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
1. In the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field, select the {{ OS }} version you need.
1. Click **{{ ui-key.yacloud.common.save }}**.

For more on supported database versions, see [Database version control policy](../../managed-opensearch/concepts/update-policy.md).