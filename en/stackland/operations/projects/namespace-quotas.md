# Setting quotas in namespaces

Quotas limit the consumption of resources in your project’s namespaces. Quotas are set at the namespace level and allow you to control the use of CPU, memory, storage, and GPU.

## Getting started {#before-you-begin}

Make sure that:

* You have the cluster or project administrator role.
* You have already created a project and a namespace. If not, create a [project](create-project.md) and a [namespace](manage-namespaces.md).

## Supported quota types {#quota-types}

You can set the following quotas at the namespace level:

* `requests.cpu`: Total requested CPU for pods in the namespace.
* `requests.memory`: Total requested memory for pods in the namespace.
* `limits.cpu`: Total CPU limit for pods in the namespace.
* `limits.memory`: Total memory limit for pods in the namespace.
* `requests.storage`: Total storage capacity for all PVCs in the namespace.
* `requests.nvidia.com/gpu`: Total number of GPUs for pods in the namespace.

If you set no quota for a certain resource type, no consumption limit will apply to this resource.

## Creating a quota {#set-quotas}

Quotas are set at the project’s namespace level.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the left-hand menu, select **Projects**.
  1. Select the project from the list.
  1. Click **Namespaces** on the project’s side panel.
  1. Select the namespace.
  1. Go to the **Quotas** tab.
  1. Click **+ Add quota**.
  1. Specify the following quota settings:

      * **Quota name**: Unique quota name in the namespace. This is a required field.

  1. Under **Resource quotas**, add limits:

      * Select the resource type from the **Resource** drop-down list, e.g., `limits.cpu`, `requests.cpu`.
      * Set the value in the **Value** field.
      * To add another limit, click **Add**.
      * To delete a row, click the recycle bin icon.

  1. Optionally, expand the **Additional** section and specify a **Scope**, i.e., a YAML description of the quota's scope selector (e.g., for a limit based on pod priority class).
  1. Click **Save**.


- CLI {#cli}

  Create a manifest file, e.g., `quota.yaml`:

  ```yaml
  apiVersion: v1
  kind: ResourceQuota
  metadata:
    name: my-quota
    namespace: team-alpha-backend
  spec:
    hard:
      limits.cpu: "20"
      requests.cpu: "10"
      limits.memory: "64Gi"
      requests.memory: "32Gi"
    scopeSelector:
      matchExpressions:
        - scopeName: PriorityClass
          operator: In
          values:
            - middle
  ```

  Where:

  * `metadata.name`: Quota name. This is a required field.
  * `metadata.namespace`: Project namespace the quota is in. This is a required field.
  * `spec.hard`: Dictionary of resources and their limits. This is a required field.
  * `spec.scopeSelector`: Quota scope selector. This is an optional field.

  Apply the manifest:

  ```bash
  kubectl apply -f quota.yaml
  ```

{% endlist %}

## Viewing the current quota usage {#view-usage}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the left-hand menu, select **Projects**.
  1. Select the project from the list.
  1. Click **Namespaces** on the project’s side panel.
  1. Select the namespace.
  1. Go to the **Quotas** tab.
  1. Click the name of the quota.

  The quota page displays the following:

  * **Quota information**: Name, namespace, scope, creation date.
  * **Quotas**: Table with the following columns: **Resource**, **Requests (used/limit)**, **Limits (used/limit)**, **Effective**.


- CLI {#cli}

  To view the list of quotas in the namespace:

  ```bash
  kubectl get resourcequota -n team-alpha-backend
  ```

  Response example:

  ```bash
  NAME         REQUEST             LIMIT             AGE
  my-quota     requests.cpu: 0/2   limits.cpu: 0/4   20m
  ```

  To view the quota's details with current usage data:

  ```bash
  kubectl describe resourcequota my-quota -n team-alpha-backend
  ```

  Response example:
  
  ```bash
  Name:         my-quota
  Namespace:    team-alpha-backend
  Resource      Used  Hard
  --------      ----  ----
  limits.cpu    1     4
  requests.cpu  1     2
  ```


{% endlist %}

## Updating a quota {#update-quotas}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the left-hand menu, select **Projects**.
  1. Select the project from the list.
  1. Click **Namespaces** on the project’s side panel.
  1. Select the namespace.
  1. Go to the **Quotas** tab.
  1. In the quota row, click **⋯** and select **Edit**.
  1. Make your changes and click **Save**.


- CLI {#cli}

  Edit the quota directly:

  ```bash
  kubectl edit resourcequota my-quota -n team-alpha-backend
  ```

{% endlist %}

{% note info %}

If the new quota value is below the current usage level, the quota will be updated successfully. However, you will not be able to create new resources above the quota until your usage falls below the limit.

{% endnote %}

## Deleting a quota {#delete-quotas}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the left-hand menu, select **Projects**.
  1. Select the project from the list.
  1. Click **Namespaces** on the project’s side panel.
  1. Select the namespace.
  1. Go to the **Quotas** tab.
  1. In the quota row, click **⋯** and select **Delete**.
  1. Confirm the deletion.


- CLI {#cli}

  ```bash
  kubectl delete resourcequota my-quota -n team-alpha-backend
  ```

{% endlist %}

## Examples {#examples}

### Quota for a development environment {#dev-example}

```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: dev-quota
  namespace: development-main
spec:
  hard:
    requests.cpu: "10"
    requests.memory: "32Gi"
    requests.storage: "200Gi"
    limits.cpu: "20"
    limits.memory: "64Gi"
```

### Quota for a production namespace with GPUs {#prod-example}

```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: ml-prod-quota
  namespace: ml-production-main
spec:
  hard:
    requests.cpu: "100"
    requests.memory: "512Gi"
    requests.storage: "5Ti"
    limits.cpu: "200"
    limits.memory: "1Ti"
    requests.nvidia.com/gpu: "8"
```

## What's next {#what-is-next}

* [Configuring roles in a project](project-roles.md)
* [Managing namespaces in a project](manage-namespaces.md)
