---
subcategory: Cloud Registry
---

# yandex_cloudregistry_folder (DataSource)

A Artifact resource.

## Example usage

```terraform
//
// Get information about existing Cloud Registry Folder.
//
data "yandex_cloudregistry_folder" "source" {
  artifact_id = "some_artifact_id"
}
```

## Arguments & Attributes Reference

- `artifact_id` (String). ID of the artifact resource to return.
- `content` [Block]. Content of the artifact.
  - `docker` [Block]. Docker-specific content.
    - `image_manifest` [Block]. Single-platform image manifest.
      - `config` [Block]. Descriptor of the image configuration.
        - `digest` (*Read-Only*) (String). Digest of the content.
        - `size` (*Read-Only*) (Number). Size of the content in bytes.
      - `layers` [Block]. Descriptors of the image layers.
        - `digest` (*Read-Only*) (String). Digest of the content.
        - `size` (*Read-Only*) (Number). Size of the content in bytes.
    - `manifest_digest` (*Read-Only*) (String). Digest of the manifest.
    - `manifest_list` [Block]. Multi-platform manifest list.
      - `manifests` [Block]. List of platform-specific manifests.
        - `manifest_descriptor` [Block]. Descriptor of the platform-specific manifest.
          - `digest` (*Read-Only*) (String). Digest of the content.
          - `size` (*Read-Only*) (Number). Size of the content in bytes.
        - `platform` [Block]. Platform this manifest targets.
          - `architecture` (*Read-Only*) (String). CPU architecture.
          - `os` (*Read-Only*) (String). Operating system.
          - `os_version` (*Read-Only*) (String). OS version.
          - `variant` (*Read-Only*) (String). CPU variant.
- `created_at` (*Read-Only*) (String). Output only. Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
- `created_by` (*Read-Only*) (String). Output only. ID of the user or service account who created the artifact.
- `id` (String). ID of the artifact resource to return.
- `kind` (*Read-Only*) (String). Kind of the artifact.
- `modified_at` (*Read-Only*) (String). Output only. Modification timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
- `modified_by` (*Read-Only*) (String). Output only. ID of the user or service account who last modified the artifact.
- `name` (*Read-Only*) (String). Name of the artifact.
- `properties` (*Read-Only*) (Map Of String). Key-value properties associated with the artifact.
- `registry_id` (**Required**)(String). Output only. ID of the registry that contains this artifact.
- `status` (*Read-Only*) (String). Output only. Status of the artifact.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).


