# Billing and payment



* [General questions](#overview)
* [Managing seats](#manage-seats)
* [Migrating to a new plan](#process-of-changing)
* [Queries from embedded private objects](#embeds)

## General questions about {#overview}

### Is {{ datalens-name }} not free? {#for-free}

Individual users can use {{ datalens-name }} free of charge with full access to all its features. Only collaboration is paid.

### Does a user need a seat if they only view dashboards? {#viewer}

Yes. Any {{ datalens-name }} user requires a seat, regardless of their role.

### If I do not work in {{ datalens-name }} every day, do I only pay for days of actually using my seat? {#activity}

No. Once a seat is purchased, the full monthly fee will be charged, even if this seat’s user does not log in on some days. However, administrators can reassign seats among users during their inactive periods.

## Managing seats {#manage-seats}

### Where do I configure my seats? {#seats-settings}

Administrators have access to a seat management tool in the [service settings](../../datalens/settings/seats.md). They can:
* View the number of seats in the instance, including available (unassigned) ones.
* View the list of users with seats.
* Reassign seats from user to user.
* Increase or decrease the number of seats in the instance.

### If an employee is dismissed, is their seat automatically released? {#retire}

No. Your administrator must manually reassign that seat to another employee.

### Can multiple users share a seat if they do not need to access it at the same time? {#multiple-users}

Your administrators can manually reassign seats as needed.

## Queries from embedded private objects {#embeds}

### Do I need to purchase {{ datalens-name }} seats for viewers of embedded private objects? {#seats-for-external-clients}

Only users who log in directly to {{ datalens-name }} need seats. If you have any [embedded private charts](../../datalens/security/private-embedded-objects.md) in external resources, e.g., in your customers' accounts, you do not need to purchase seats for these customers since they never log in to {{ datalens-name }}.

The system counts the number of queries to data sources from private embedded charts, i.e., those in the wizard and Editor as well as QL charts, that are executed when rendering these objects. Only successfully completed requests for retrieving data to render charts are counted. If multiple requests are required to render a single chart, this is counted as one request. For embedded private dashboards, queries from the added charts are summed up.

The total number of queries from all private charts in an instance per month must not exceed the established limit.

> 2,000 queries x Number of seats

If you exceed this limit, you will need to purchase additional seats. When the limit on the number of queries from private embedded charts is exceeded and [automatic seat purchase](../../datalens/settings/seats.md#purchase-automatically) is enabled, there is no automatic repurchase of new seats.

### How can I track the number of queries from embedded private objects? {#statistics}

To estimate the number of queries from embedded private objects, use the [Usage Analytics](../../datalens/operations/connection/create-usage-tracking.md) connection, which provides detailed usage statistics. For the number of queries from private embedded objects, see the `Top Users (Requests)` table, `_ANONYMOUS_USER_OF_EMBEDDED_DATALENS_` row.

### What if I need more queries from embedded private objects? {#more-queries}

If your current number of seats is not enough to cover the required number of queries from embedded private objects, you will need to purchase more seats.

### I only have one seat, but my embedded private objects generate more than 2,000 queries per month. Is this still free? {#individual-more-queries}

No. In this case, you must purchase more seats to stay within the limit on the number of queries from embedded private objects.

### I have a public dashboard/chart embedded in my website; do the queries it generates also count? {#public-embeds}

[Public links](../../datalens/concepts/datalens-public.md) to dashboards or charts accessible without authentication do not count as queries to embedded private objects.

For the number of queries from public objects, see the [Usage Analytics](../../datalens/operations/connection/create-usage-tracking.md) connection with usage statistics. You can find this number in the `Top Users (Requests)` table, the `_ANONYMOUS_USER_OF_PUBLIC_DATALENS_` row.
