[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Managed Service for Gitlab > Data Sources > gitlab_instance

# yandex_gitlab_instance (DataSource)

Managed Gitlab instance.

## Example usage

```terraform
//
// Get information about GitLab instance by id
//
data "yandex_gitlab_instance" "gitlab_instance_by_id" {
  id = "<gitlab-instance-id>"
}
```

## Arguments & Attributes Reference

- `admin_email` (*Read-Only*) (String). An email of admin user in Gitlab.
- `admin_login` (*Read-Only*) (String). A login of admin user in Gitlab.
- `approval_rules_id` (String). Approval rules configuration. One of: NONE, BASIC, STANDARD, ADVANCED.
- `approval_rules_token` (String). Approval rules token.
- `backup_retain_period_days` (*Read-Only*) (Number). Auto backups retain period in days.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (String). The resource description.
- `disk_size` (*Read-Only*) (Number). Amount of disk storage available to a instance in GB.
- `domain` (*Read-Only*) (String). Domain of the Gitlab instance.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `gitlab_version` (*Read-Only*) (String). Version of Gitlab on instance.
- `id` (String). The resource identifier.
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `maintenance_delete_untagged` (Bool). The `true` value means that untagged images will be deleted during maintenance.
- `name` (*Read-Only*) (String). The resource name.
- `resource_preset_id` (*Read-Only*) (String). ID of the preset for computational resources available to the instance (CPU, memory etc.). One of: s2.micro, s2.small, s2.medium, s2.large.
- `status` (*Read-Only*) (String). Status of the instance.
- `subnet_id` (*Read-Only*) (String). ID of the subnet where the GitLab instance is located.
- `updated_at` (*Read-Only*) (String). The timestamp when the instance was updated.
- `timeouts` [Block].