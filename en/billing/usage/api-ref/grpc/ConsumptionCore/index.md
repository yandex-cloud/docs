---
editable: false
sourcePath: en/_api-ref-grpc/billing/usage_records/v1/usage/api-ref/grpc/ConsumptionCore/index.md
---

# Billing Usage API, gRPC: ConsumptionCoreService

Service for detailed consumption and usage reporting.

The ConsumptionCoreService provides a comprehensive set of methods for retrieving detailed
usage and billing information for different entities within a billing account hierarchy.
Each method offers aggregated data for specific entity types (a billing account, clouds,
folders, services, SKUs, resources, or labels) with support for various filtering options
and aggregation periods. Note that each request targets a single billing account.

All methods in this service follow the same three-level response structure:
1. Overall totals for the entire request period (cost, credits, expense)
2. Entity-level totals - summary data for each entity of the requested type
3. Time series data - periodic breakdown for each entity according to the specified aggregation period
(controlled by the aggregation_period request parameter: day/week/month/quarter/year)

These methods help customers and internal teams analyze usage patterns, track expenses,
monitor resource consumption, and generate detailed billing reports. The service
supports filtering by entity IDs, date ranges, labels, and other parameters to provide
targeted insights into cloud resource usage.

Required permissions:
All methods in this service require one of the following permissions on the specified billing account:
- `billing.accounts.getReport`

## Methods

#|
||Method | Description ||
|| [GetBillingAccountUsageReport](getBillingAccountUsageReport.md) | Returns aggregated usage report for a single specified billing account, ||
|| [GetCloudUsageReport](getCloudUsageReport.md) | Returns aggregated usage report for the specified clouds ||
|| [GetFolderUsageReport](getFolderUsageReport.md) | Returns aggregated usage report for the specified folders ||
|| [GetServiceUsageReport](getServiceUsageReport.md) | Returns aggregated usage report for the specified services ||
|| [GetSKUUsageReport](getSKUUsageReport.md) | Returns aggregated usage report by SKU (Stock Keeping Unit) ||
|| [GetResourceUsageReport](getResourceUsageReport.md) | Returns aggregated usage report by individual resource ||
|| [GetLabelKeyUsageReport](getLabelKeyUsageReport.md) | Returns aggregated usage report by label keys and values ||
|#