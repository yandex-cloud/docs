#|
|| | **{{ cloud-logging-name }}** | **{{ monium-name }}** ||
|| **Writing** | {{ sku|USD|logging.ingested.traffic|pricingRate.5|string }} (GB per month) | {{ sku|USD|monium.logs.ingested.traffic|string }} (GB per month) ||
|| **Storage** | Billable | Not billable. [TTL](../../monium/concepts/common-ttl.md#ttl-logs): 31 days ||
|| **Reading and analytics** | Basic log search | Aggregations, unified query language for logs, metrics, and traces ||
|| **Migration** | — | Changing the format (OTEL) and endpoint ||
|#
