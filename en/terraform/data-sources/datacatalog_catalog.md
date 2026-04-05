---
subcategory: Datacatalog
---

# yandex_datacatalog_catalog (DataSource)

Request message for getting a catalog.

## Example usage

```terraform
//
// Get information about existing Catalog.
//
data "yandex_datacatalog_catalog" "created_catalog" {
  catalog_id = "catalog_id"
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
- `updated_at` (*Read-Only*) (String). Date of catalog last update


