#|
|| | **{{ cloud-logging-name }}** | **{{ monium-name }}** ||
|| **Write** | {{ sku|USD|logging.ingested.traffic|pricingRate.5|string }} (GB per month) | {{ sku|USD|monium.logs.ingested.traffic|string }} (GB per month) ||
|| **Storage** | You are billed for | You are not billed for, [TTL](../../monium/concepts/common-ttl.md#ttl-logs): 31 days ||
|| **Reading and analytics** | Basic log search | Aggregations, unified query language for logs, metrics, and traces ||
|| **Migration** | — | Changing format (OTEL) and endpoint ||
|#
