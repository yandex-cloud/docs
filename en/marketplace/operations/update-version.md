# Changing product versions

Before publication, the version must be moderated by technical experts and editors. You can edit a version until it is submitted for moderation. After it passes moderation, you can also make changes. In that case, you will have to resubmit the version for moderation. When moderation succeeds, the publisher can publish the approved version.

To change the version:

1. Log in to the [{{ marketplace-short-name }} partner interface]({{ link-cloud-partners }}).

1. Open the **{{ ui-key.yacloud_portal.portal.products }}** section and select a product.

1. On the **{{ ui-key.yacloud_portal.marketplace_v2.product.tab_versions }}** tab, select the version.

1. In the top-right corner, click **{{ ui-key.yacloud.common.edit }}**.

1. Make changes and click **{{ ui-key.yacloud.common.edit }}**.

While a version is under moderation, you can [add a new version](create-new-version.md) to the product.


## Testing a product upgrade for {{ managed-k8s-full-name }} {#test}

You can test a product upgrade for {{ managed-k8s-name }} using {{ TF }}:

1. Install the published version in the cluster using {{ TF }}.
1. Create a target version to upgrade the product to.
1. _Before submitting_ the new version for moderation, replace the current version ID in the {{ TF }} manifest with the new version ID.
    You can look up the ID in the [{{ marketplace-short-name }} partner dashboard]({{ link-cloud-partners }}).

1. Run the `terraform apply` command.
    The product will upgrade in the same way as on the users’ side.