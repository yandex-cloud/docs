# Billing and payment



* [Pricing changes effective December 1, 2025](#changes)
* [Managing seats](#manage-seats)
* [Migrating to a new plan](#process-of-changing)
* [Queries from embedded private objects](#embeds)

## Pricing changes effective December 1, 2025 {#changes}

### Are you deprecating the Community plan? What is going to replace it? {#quit-community}

Yes, starting December 1, 2025, the **Community** and **Business** {{ datalens-name }} [service plans](../../datalens/concepts/service-plans-comparison.md) will be deprecated. They will be replaced by a single unified plan which includes all features currently available under **Business**. This new plan is free for individual users and billed per seat for teams.

### Is {{ datalens-name }} no longer free? {#for-free}

Individual users can still use {{ datalens-name }} free of charge with full access to all **Business** features.

### How are seats different from active users? {#difference}

Under the current pricing model, you pay only for active users, i.e., those whose actions prompted a query to a data source, e.g., opening or editing a dashboard or a chart. Active-users are counted towards the month's total.

Under the new model, you pay for seats. Every user who logs in to {{ datalens-name }} needs to have one. Seats are automatically assigned to users when they first log in to {{ datalens-name }}. Administrators can manually reassign seats from less active to more active users.

### Does a user need a seat if they only view dashboards? {#viewer}

Yes. Any {{ datalens-name }} user requires a seat, regardless of their role.

### If I do not work in {{ datalens-name }} every day, do I only pay for days of actually using my seat? {#activity}

No. Once a seat is purchased, the full monthly fee will be charged, even if this seat’s user does not log in on some days. However, administrators can reassign seats among users during their inactive periods.

### Do I need to start paying for seats as early as December 1? {#december}

This depends on your current service plan:

* **Business** users will switch to seat-based billing on December 1, 2025.
* **Community** users will be provided with an extended trial period until March 1, 2026, with access to all **Business** features and free team collaboration.

   {% note warning %}
   
   By March 1, 2026, you have to decide whether to add a billing account for per-seat pricing or downscale your usage to a single seat per instance.

   {% endnote %}

   If you [add a billing account](../../datalens/settings/service-plan.md#add-billing-account) by March 1, 2026, seat-based pricing will start to apply. Otherwise, your instance will be reduced to one seat starting March 1.

   If you switch to **Business** before December 1, 2025, or complete your trial under the new plan between December 1 and December 31, 2025, you will [receive a 50% discount](../../datalens/pricing-changes.md#discounts) from the moment you switch, effective through all of 2026.

### How do I get the discount? {#discount}

To be eligible for the 50% discount, you need to be a **Community** user as of November 16, 2025 and switch to the **Business** plan before December 1, 2025 or complete your trial period under the new plan between December 1 and December 31, 2025. The discount will apply immediately and remain in effect through all of 2026.

### I am currently on the Business plan. How will my active users convert to seats? {#business-conversion}

Starting December 1, 2025, your active user count will be set to zero, and all your instance’s users will begin to get their seats. On their first login in {{ datalens-name }}, each user will be assigned a seat, charged to your billing account.

This behavior closely mirrors the old pricing model per active user, so your total spend for December should remain consistent with its current levels.

## Managing seats {#manage-seats}

### Where do I configure my seats? There are no UI controls I could use {#seats-settings}

Starting December 1, 2025, administrators will gain access to a seat management interface in {{ datalens-name }} settings. From there, they will be able to:
* View the number of seats in the instance, including available (unassigned) ones.
* View the list of users with seats.
* Reassign seats from user to user.
* Increase or decrease the number of seats in an instance.

### How does auto-assignment work? Will all users in my instance get their seats right away? {#auto}

No. Each user will get a seat on their first login to {{ datalens-name }} on or after December 1, 2025. Seat are summed up towards the month's total your billing is based on.

### If an employee is dismissed, is their seat automatically released? {#retire}

No. Your administrator must manually reassign that seat to another employee. By March 1, 2026, {{ datalens-name }} will deploy tools to automatically revoke inactive seats.

### Can multiple users share a seat if they do not need to access it at the same time? {#multiple-users}

Your administrators will be able to manually reassign seats as needed.

## Migrating to the new plan {#process-of-changing}

### I am currently on the Business plan. What should I expect? {#for-business}

The new plan will be activated on December 1, 2025, and your administrator will get access to seat management.

As your instance users log in, they will get their seats, charged to your billing account. This means, {{ datalens-name }} will continue to work as before, and your total December spend should be the same as your prior **Business** plan costs based on active users.

### I am currently on the Community plan. What should I expect? {#for-community}

On December 1, 2025, your extended trial period of the new service plan will start and remain in effect until March 1, 2026. During the trial, you will have full access to **Business** features with seats auto-assigned to users at no charge, i.e., teams will be able to use {{ datalens-name }} for free. Your administrator will get access to seat management.

If you have a linked billing account, seat-based billing will start on March 1, 2026. Otherwise, your instance will be scaled down to one seat starting March 1.

If you were on the **Community** plan as of November 16, 2025, you are eligible for a 50% discount on all your seats. To get the discount, switch to **Business** before December 1, 2025, or complete your trial period under the new plan between December 1 and December 31, 2025. The discount will apply immediately and remain in effect through all of 2026.

{% note info %}

When exiting the trial, your first month's seat cost is prorated based on remaining days in the month. 

{% endnote %}

## Queries from embedded private objects {#embeds}

### Do I need to purchase {{ datalens-name }} seats for viewers of embedded private objects? {#seats-for-external-clients}

Only users who log in directly to {{ datalens-name }} need seats. If you have any [embedded private objects](../../datalens/security/private-embedded-objects.md) in external resourses, e.g., in your customers’ accounts, you do not need to purchase seats for these customers since they never log in to {{ datalens-name }}.

However, queries to sources triggered by viewing these embedded objects are counted. The total monthly number of queries from all private objects within an instance must not exceed:

> 2,000 queries x number of seats

If you exceed this limit, you will need to purchase additional seats.

### How can I track the number of queries from embedded private objects? {#statistics}

To estimate the number of queries from embedded private objects, use the [Usage Analytics](../../datalens/operations/connection/create-usage-tracking.md) connection, which provides detailed usage statistics. For the number of queries from private embedded objects, see the `Top Users (Requests)` table, `_ANONYMOUS_USER_OF_EMBEDDED_DATALENS_` row.

### What if I need more queries from embedded private objects? {#more-queries}

If your current number of seats is not enough to cover the required number of queries from embedded private objects, you will need to purchase more seats.

### I only have one seat, but my embedded private objects generate more than 2,000 queries per month. Is this still free? {#individual-more-queries}

No. In this case, you must purchase more seats to stay within the limit on the number of queries from embedded private objects.

### I have a public dashboard/chart embedded in my website; do the queries it generates also count? {#public-embeds}

[Public links](../../datalens/concepts/datalens-public.md) to dashboards or charts accessible without authentication do not count as queries to embedded private objects.

For the number of queries from public objects, see the [Usage Analytics](../../datalens/operations/connection/create-usage-tracking.md) connection with usage statistics. You can find this number in the `Top Users (Requests)` table, the `_ANONYMOUS_USER_OF_PUBLIC_DATALENS_` row.
