# Creating a quota

After creating a [project](../projects/create-project.md), the administrator can limit resources using the `ResourceQuota` [object](https://kubernetes.io/docs/concepts/policy/resource-quotas/).

## Using the CLI

1. Create a file of the `ResourceQuota` resource, e.g., using the `touch resourcequota.yaml` command.
1. Open the file and paste the configuration below into it:

      {% list tabs %}

      - Quota without scope

          {% include notitle [YAML-file](../../_includes/yamls/operations/quotas/quota-without-scope.md) %}

      - Quota with scope

          {% note info %}

          The quota will only be applied to pods with the `priorityClassName: middle` property.

          {% endnote %}

          {% include notitle [YAML-file](../../_includes/yamls/operations/quotas/quota-with-scope.md) %}

      {% endlist %}

1. Apply the manifest: `kubectl apply -f resourcequota.yaml -n <project name>`. Optionally, you can specify the project name in the `metadata.namespace` resource property and skip it in the command.

## Using the management console

1. If you have not opened a project yet, select one.
1. Go to the **Quotas** tab on the project description page.
1. Click **Add quota**.
1. Enter a name for the quota.
1. Specify values for the `limits.cpu` and `requests.cpu` fields or select other resources.
1. To apply the quota to the entire project, delete the text from the **Scope** field. Otherwise, the quota will only be applied to pods with the `priorityClassName: middle` property. Optionally, instead of deleting the text, you can change the scope to what is required to apply the quota.
1. Click **Save**.
