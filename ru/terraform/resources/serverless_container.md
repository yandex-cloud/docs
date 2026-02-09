---
subcategory: Cloud Logging
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/serverless_container.md
---

# yandex_serverless_container (Resource)

Allows management of a Yandex Cloud Serverless Container.

## Example usage

```terraform
//
// Create a new Serverless Container.
//
resource "yandex_serverless_container" "test-container" {
  name               = "some_name"
  description        = "any description"
  memory             = 256
  execution_timeout  = "15s"
  cores              = 1
  core_fraction      = 100
  service_account_id = "are1service2account3id"
  runtime {
    type = "task"
  }
  secrets {
    id                   = yandex_lockbox_secret.secret.id
    version_id           = yandex_lockbox_secret_version.secret_version.id
    key                  = "secret-key"
    environment_variable = "ENV_VARIABLE"
  }
  mounts {
    mount_point_path = "/mount/point"
    ephemeral_disk {
      size_gb = 5
    }
  }
  image {
    url = "cr.yandex/yc/test-image:v1"
  }
  log_options {
    log_group_id = "e2392vo6d1bne2aeq9fr"
    min_level    = "ERROR"
  }
  provision_policy {
    min_instances = 1
  }
}
```
```terraform
//
// Create a new Serverless Container with Image digest.
//
resource "yandex_serverless_container" "test-container-with-digest" {
  name   = "some_name"
  memory = 128
  image {
    url    = "cr.yandex/yc/test-image:v1"
    digest = "sha256:e1d772fa8795adac847a2420c87d0d2e3d38fb02f168cab8c0b5fe2fb95c47f4"
  }
}
```
```terraform
//
// Create a new Serverless Container with Storage mount.
//
locals {
  folder_id = "folder_id"
}

resource "yandex_serverless_container" "test-container-object-storage-mount" {
  name               = "some_name"
  memory             = 128
  service_account_id = yandex_iam_service_account.sa.id
  image {
    url = "cr.yandex/yc/test-image:v1"
  }
  mounts {
    mount_point_path = "/mount/point"
    mode             = "ro"
    object_storage {
      bucket = yandex_storage_bucket.my-bucket.bucket
    }
  }
}

// Auxiliary resources
resource "yandex_iam_service_account" "sa" {
  folder_id = local.folder_id
  name      = "test-sa"
}

resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = local.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

resource "yandex_storage_bucket" "my-bucket" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = "bucket"
}
```

## Arguments & Attributes Reference

- `concurrency` (Number). Concurrency of Yandex Cloud Serverless Container.
- `core_fraction` (Number). Core fraction (**0...100**) of the Yandex Cloud Serverless Container.
- `cores` (Number). Cores (**1+**) of the Yandex Cloud Serverless Container.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `execution_timeout` (String). Execution timeout in seconds (**duration format**) for Yandex Cloud Serverless Container.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `memory` (**Required**)(Number). Memory in megabytes (**aligned to 128 MB**).
- `name` (**Required**)(String). The resource name.
- `revision_id` (*Read-Only*) (String). Last revision ID of the Yandex Cloud Serverless Container.
- `service_account_id` (String). [Service account](https://yandex.cloud/docs/iam/concepts/users/service-accounts) which linked to the resource.
- `url` (*Read-Only*) (String). Invoke URL for the Yandex Cloud Serverless Container.
- `async_invocation` [Block]. Config for asynchronous invocations of Yandex Cloud Serverless Container.
  - `service_account_id` (String). Service account used for async invocation.
- `connectivity` [Block]. Network access. If specified the revision will be attached to specified network.
  - `network_id` (**Required**)(String). Network the revision will have access to.
- `image` [Block]. Revision deployment image for Yandex Cloud Serverless Container.
  - `args` (List Of String). List of arguments for Yandex Cloud Serverless Container.
  - `command` (List Of String). List of commands for Yandex Cloud Serverless Container.
  - `digest` (String). Digest of image that will be deployed as Yandex Cloud Serverless Container. If presented, should be equal to digest that will be resolved at server side by URL. Container will be updated on digest change even if `image.0.url` stays the same. If field not specified then its value will be computed.
  - `environment` (Map Of String). A set of key/value environment variable pairs for Yandex Cloud Serverless Container. Each key must begin with a letter (A-Z, a-z).
  - `url` (**Required**)(String). URL of image that will be deployed as Yandex Cloud Serverless Container.
  - `work_dir` (String). Working directory for Yandex Cloud Serverless Container.
- `log_options` [Block]. Options for logging from Yandex Cloud Serverless Container.
  - `disabled` (Bool). Is logging from container disabled.
  - `folder_id` (String). Log entries are written to default log group for specified folder.
  - `log_group_id` (String). Log entries are written to specified log group.
  - `min_level` (String). Minimum log entry level.
- `metadata_options` [Block]. Options set the access mode to revision's metadata endpoints.
  - `aws_v1_http_endpoint` (Number). Enables access to AWS flavored metadata (IMDSv1). Values: `0` - default, `1` - enabled, `2` - disabled.
  - `gce_http_endpoint` (Number). Enables access to GCE flavored metadata. Values: `0`- default, `1` - enabled, `2` - disabled.
- `mounts` [Block]. Mounts for Yandex Cloud Serverless Container.
  - `mode` (String). Mount’s accessibility mode. Valid values are `ro` and `rw`.
  - `mount_point_path` (**Required**)(String). Path inside the container to access the directory in which the target is mounted.
  - `ephemeral_disk` [Block]. One of the available mount types. Disk available during the function execution time.
    - `block_size_kb` (Number). Block size of the ephemeral disk in KB.
    - `size_gb` (**Required**)(Number). Size of the ephemeral disk in GB.
  - `object_storage` [Block]. Available mount types. Object storage as a mount.
    - `bucket` (**Required**)(String). Name of the mounting bucket.
    - `prefix` (String). Prefix within the bucket. If you leave this field empty, the entire bucket will be mounted.
- `provision_policy` [Block]. Provision policy. If specified the revision will have prepared instances.
  - `min_instances` (**Required**)(Number). Minimum number of prepared instances that are always ready to serve requests.
- `runtime` [Block]. Runtime for Yandex Cloud Serverless Container.
  - `type` (**Required**)(String). Type of the runtime for Yandex Cloud Serverless Container. Valid values are `http` and `task`.
- `secrets` [Block]. Secrets for Yandex Cloud Serverless Container.
  - `environment_variable` (**Required**)(String). Container's environment variable in which secret's value will be stored. Must begin with a letter (A-Z, a-z).
  - `id` (**Required**)(String). Secret's ID.
  - `key` (**Required**)(String). Secret's entries key which value will be stored in environment variable.
  - `version_id` (**Required**)(String). Secret's version ID.
- `storage_mounts` [Block]. (**DEPRECATED**, use `mounts.object_storage` instead) Storage mounts for Yandex Cloud Serverless Container.
  - `bucket` (**Required**)(String). Name of the mounting bucket.
  - `mount_point_path` (**Required**)(String). Path inside the container to access the directory in which the bucket is mounted.
  - `prefix` (String). Prefix within the bucket. If you leave this field empty, the entire bucket will be mounted.
  - `read_only` (Bool). Mount the bucket in read-only mode.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_serverless_container.<resource Name> <resource Id>
terraform import yandex_serverless_container.test-container ...
```
