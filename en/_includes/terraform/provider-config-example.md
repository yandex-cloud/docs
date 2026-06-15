When specifying provider settings in a {{ TF }} configuration file with no sensitive data disclosed, keep this in mind:


```hcl
provider "yandex" {
  # Do not specify `cloud_id`, `folder_id`, or `token`, as
  # your provider automatically fetches them from the environment variables

  zone = "<availability_zone>"
}
```



Where `zone` is the default [availability zone](../../overview/concepts/geo-scope.md) for all your cloud resources.

When employing such a configuration, use {{ TF }} free of any additional flags, as your provider automatically fetches them from the environment variables.
