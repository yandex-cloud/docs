1. Log in to the [{{ marketplace-short-name }} partner dashboard]({{ link-cloud-partners }}).
1. Open the **{{ ui-key.yacloud_portal.portal.products }}** section.
1. Click **{{ ui-key.yacloud_portal.marketplace_v2.product.page_action_product-create }}**.
1. Fill out the form with information about your product:

   1. Specify a name for the permanent link. For {{ compute-full-name }} products, this name will be used as the name of the [image family](../../compute/concepts/image.md#family).
   1. Select the product type.
   1. Specify the product name in Russian and English. This product name will be displayed in the {{ marketplace-short-name }} partner dashboard. Users will see the product name specified when creating the version.
   1. Specify the product access type:

       * `Available to all`: All users can install the product.
       * `Available on request`: Only the users whose [access requests](../../marketplace/operations/access-requests.md) you have approved can install the product.

1. Click **{{ ui-key.yacloud.common.create }}**.

After the application is reviewed, the product status will change to `Approved` or `Rejected`.

During the review process, you can contact the manager. To do this:

1. Select **{{ ui-key.yacloud_portal.marketplace_v2.common.menu_ticket }}**.
1. Fill out the form and click **{{ ui-key.yacloud_portal.common.submit }}**.

If your product is approved, you can start uploading the first version of the product.