# Billing and payment

### Will the new features only be available in the Business service plan? {#new-features-on-business}

No, new basic features will be available across all [service plans](../../datalens/pricing.md). However, certain updates will be exclusive to the paid plan.

### Can I continue using the old {{ datalens-short-name }} with no service plan applied? {#use-datalens-without-pricing}

On April 23, 2024, all {{ datalens-short-name }} instances will be migrated to the free Community plan. You can continue using this plan if your users authenticate with [Yandex ID](https://yandex.com/support/id/index.html) / [Yandex 360](https://yandex.com/support/business/index.html). No restrictions will apply.

If you had set up authentication with an [identity federation](../../organization/concepts/add-federation.md) (corporate SSO, e.g., via LDAP), the free Community plan will remain effective for your {{ datalens-short-name }} instance until December 31, 2024. To continue using {{ datalens-short-name }}, you should plan an [upgrade](../../datalens/settings/service-plan.md#change-service-plan) to the Business plan or switch to Yandex ID authentication.

### What is the timeline for introducing the billing system? {#timeline}

The billing system for {{ datalens-short-name }} will be introduced in stages:

* March 20, 2024: We announce the service plans and notify all our users.
* April 23, 2024: You can upgrade your service plan to Business free of charge.
* June 1, 2024: We start charging for the Business service plan.
* December 31, 2024: We discontinue SSO for the existing free Community plan users.

### Can I go back to the free Community service plan? {#free-rollback}

Yes, you can. The move can only be effected from the beginning of the next month. However, you will lose access to the paid service plan features.

### Is a partial upgrade to Business possible? For example, can I have 10 users on Business and the rest of them on the Community plan? {#part-business}

No, the upgrade takes effect for the whole [organization](../../datalens/concepts/organizations.md) for which {{ datalens-short-name }} is enabled.

### What if I have both federated and regular users? {#sso-and-users-pricing}

If you need to retain federated users, schedule an upgrade to the Business service plan. Note that, under this plan, you will be charged for all your users, both SSO and Yandex ID.

### How will you count the users of public charts and dashboards? {#public-pricing}

[Public URLs](../../datalens/concepts/datalens-public.md) to dashboards and charts work without authentication and do not contribute to the active user count. Public charts and dashboards will be free of charge across all service plans.

### How will you count chart views through secure embeddings? {#embed-pricing}

We are not counting users of [secure chart embeddings](../../datalens/security/private-embedded-objects.md). One embedded object can be viewed by thousands of users in an external system, each with a filter of their own. For that reason, in the future, we may impose additional limitations on the number of embedded object views to prevent overload. We will announce this in advance.

### How do I know how many of my users are actually using {{ datalens-short-name }}? {#statistics}

Starting April 23, 2024, basic [usage statistics](../../datalens/operations/connection/create-usage-tracking.md) will be available even under the free service plan.
