---
editable: false
---

# {{ sd-full-name }} pricing policy



The applicable {{ sd-name }} pricing depends on the module you are using:

* Using the [Cloud Infrastructure Entitlement Management (CIEM) module](concepts/ciem.md) is not charged.
* The [Data Security Posture Management (DSPM) module](concepts/dspm.md) sends requests to files in {{ objstorage-full-name }} buckets when [scanning data](operations/dspm/create-scan.md). Such requests are charged as per the [{{ objstorage-name }} pricing policy](../storage/pricing.md). There is no additional charge for using this module.
* For the [Access Transparency](concepts/access-transparency.md) module, refer to the [relevant section](#atr-rules) below.

## What goes into the cost of using {{ sd-name }} {#rules}

### Access Transparency {#atr-rules}

The cost for using Access Transparency is monthly-based and depends on the overall resource consumption over the previous month in the organization for which Access Transparency is enabled. You can estimate the resource consumption for your organization based on the [usage details by service](../billing/operations/check-charges.md#services_1) for each [billing account](../billing/concepts/billing-account.md) associated with your organization.

The price is calculated in the beginning of the calendar month and does not change over this month. The price does not depend on the number of days in the calendar month when Access Transparency is used from the first day of the month.

When Access Transparency is used from the second day of the calendar month or later, only the remaining time until the end of the month is charged, on an hourly basis.

## Prices for the Russia region {#prices}

### Access Transparency {#atr-pricing}

{% note warning %}

These prices are valid as of March 13, 2025.

{% endnote %}




{% include notitle [usd.md](../_pricing/security-deck/access-transparency/usd.md) %}

