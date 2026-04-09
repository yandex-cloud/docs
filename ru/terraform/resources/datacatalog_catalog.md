---
subcategory: Datacatalog
---

# yandex_datacatalog_catalog (Resource)

Request message for getting a catalog.

## Example usage

```terraform
resource "yandex_datacatalog_catalog" "tf_test_catalog" {
  name = "tf-test-catalog"
  folder_id = "folder_id"
  description = "test-catalog description"
  labels = {
    "label1" = "value0"
    "label2" = "value2"
    "label3" = "value3"
  }
}
```

## Arguments & Attributes Reference

- `ai_markup_rules` [Block]. AI markup enabled flag
  - `ai_enabled` (Bool). If set to true, AI marking up of catalog entities will be enabled
  - `documentation_rules` (String). Rules for the AI agent, that will be used for assets mark up
  - `domain_rules` (String). Rules for the AI agent, that will be used for domains mark up
  - `tags_rules` (String). Rules for the AI agent, that will be used for tags mark up
  - `terms_rules` (String). Rules for the AI agent, that will be used for terms mark up
- `auto_ingestion_params` [Block]. Configuration for auto ingestion feature
  - `service_account_id` (String). ID of service account, which will be used for auto ingestion feature
- `catalog_id` (String). ID of the catalog to return.
- `created_at` (*Read-Only*) (String). Date of catalog creation
- `created_by` (*Read-Only*) (String). Id of subject who created the catalog
- `description` (String). Catalog description
- `folder_id` (String). Folder identifier
- `id` (String). ID of the catalog to return.
- `labels` (Map Of String). Catalog labels
- `name` (**Required**)(String). Catalog name
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
- `updated_at` (*Read-Only*) (String). Date of catalog last update


