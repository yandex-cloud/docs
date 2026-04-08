# Creating a project

A project is a logical resource organization unit that groups together several Kubernetes namespaces. With a project, you can manage access and quotas at the team or application level.

## Getting started {#before-you-begin}

Make sure you have the cluster administrator permissions. Only cluster administrators can create projects.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the left-hand menu, select **Projects**.
  1. In the top-right corner, click **+ Create**.
  1. Under **Main parameters**, specify the following:

      * **Name**: Project name. It must be unique within the cluster. This is a required field.
      * **displayName**: Project name displayed in the UI. This is an optional field.
      * **Description**: Brief description of the purpose of the project. This is an optional field.

  1. Under **Quotas**, you can optionally set quotas for the project's resources:

      * Select the resource type from the **Resource** drop-down list, e.g., `limits.cpu`, `limits.memory`, `requests.cpu`, `requests.memory`.
      * Set the value in the **Value** field.
      * To add another quota, click **Add**.
      * To delete a quota's row, click the recycle bin icon at the end of the row.

  1. Click **Create**.


- CLI {#cli}

  Use the `Project` resource to create a project:

  1. Create a manifest file, e.g., `project.yaml`:

      ```yaml
      apiVersion: stackland.yandex.cloud/v1alpha1
      kind: Project
      metadata:
        name: team-alpha
      spec:
        displayName: "Team Alpha Project"
        description: "Engineering team for Alpha product line"
        quotas:
          requests.cpu: "10"
          requests.memory: "32Gi"
          limits.cpu: "20"
          limits.memory: "64Gi"
          requests.storage: "500Gi"
      ```

      Where:

      * `metadata.name`: Project name. It must be unique within the cluster. This is a required field.
      * `spec.displayName`: Displayed project name. This is an optional field.
      * `spec.description`: Project description. This is an optional field.
      * `spec.quotas`: Project resource quotas. This is an optional field. For more information, see [Setting project quotas](namespace-quotas.md).

  1. Apply the manifest:

      ```bash
      kubectl apply -f project.yaml
      ```

{% endlist %}

After you create a project, {{ stackland-name }} will automatically create a service namespace named `project-<project_name>`. It will contain the project management resources.

## What's next {#what-is-next}

* [Managing namespaces in a project](manage-namespaces.md)
* [Configuring roles in a project](project-roles.md)
* [Setting project quotas](namespace-quotas.md)
