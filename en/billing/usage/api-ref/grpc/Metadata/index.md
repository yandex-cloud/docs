---
editable: false
---

# Billing Usage API, gRPC: MetadataService

MetadataService service for retrieving metadata related to usage records

The MetadataService provides a set of methods for retrieving metadata and reference information
about billing usage records within a specific billing account and date range. This metadata
includes information about clouds, services, SKUs, labels, and resources
to understand the available entity structure before building detailed usage reports.

Required permissions:
All methods in this service require one of the following permissions on the specified billing account:
- `billing.accounts.getReport`

## Methods

#|
||Method | Description ||
|| [GetUsage](getUsage.md) | GetUsage returns usage metadata including available clouds, services, SKUs, label keys, and date ranges ||
|| [GetLabel](getLabel.md) | GetLabel returns available label keys and values for a specific billing account ||
|| [GetCloud](getCloud.md) | GetCloud returns available folders for specified clouds within a billing account ||
|| [GetResourceIDs](getResourceIDs.md) | GetResourceIDs returns all resource IDs for a specific billing account and date range ||
|#