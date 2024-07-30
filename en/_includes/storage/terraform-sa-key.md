```hcl
...
// Creating a service account
resource "yandex_iam_service_account" "sa" {
  name = "<service_account_name>"
}

// Assigning a role to a service account
resource "yandex_resourcemanager_folder_iam_member" "sa-admin" {
  folder_id = "<folder_ID>"
  role      = "storage.admin"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

// Creating a static access key
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}
```
