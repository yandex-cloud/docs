# Trial period

A trial period is the time within which a {{ marketplace-short-name }} product is available to the user free of charge. You can only create a trial period for a plan with the `{{ ui-key.yacloud_components.marketplace.product-pricing-type_payg }}` pricing policy for the SKUs based on the VM consumption parameters. We do not recommend creating a trial period of less than 30 days.

The trial period for the product is only available to the user from the management console. When a user installs your product that has a trial period, they are awarded a grant. The grant amount is equal to the product usage cost for the specified period per VM: the number of days in the trial period is multiplied by the price of the cheapest SKU in the plan. The grant is available to the user only within the product's trial period.

The trial period is granted once per [billing account](../../billing/concepts/billing-account.md) for each product. However, if you created a new trial period for your product, the user who installed the product with the old trial period will be able to install it once again with the new one. If you edit your trial period, the users who already installed your product will continue consuming their previously awarded grant. The new users will be awarded your edited grant. You cannot delete your trial period.

The trial period applies only to your product, while the users continue paying for other resources. For example, if a product runs on an operating system, and the operating system is charged, the user will pay for its use.
