# Managing namespaces in a project

Project namespaces allows you to organize your resources and maintain their isolation. Each project can contain several namespaces.

## Getting started {#before-you-begin}

Make sure that:

* You have the project administrator or cluster administrator role.
* The project already exists. If not, [create one](create-project.md).

## Creating a namespace {#create-namespace}

The names of project namespaces must be prefixed with `<project_name>-`. For example, for a project named `test-project`, the possible names would be `test-project-main` or `test-project-backend`.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the left-hand menu, select **Projects**.
  1. Select the project from the list.
  1. Click **Namespaces** on the project’s side panel.
  1. Click **+ Create namespace**.
  1. Specify the parameters:

      * **Name**: Namespace suffix. The `<project_name>-` prefix is added automatically. This is a required field.
      * **Allow deletion**: Remove this flag to protect the namespace from accidental deletion. The flag is removed by default.

  1. Click **Create**.


- CLI {#cli}

  To create a namespace, use the `ProjectNamespace` resource. This resource is created in the service namespace of the `project-<project_name>` project.

  1. Create a manifest file, e.g., `namespace.yaml`:

      ```yaml
      apiVersion: stackland.yandex.cloud/v1alpha1
      kind: ProjectNamespace
      metadata:
        namespace: project-team-alpha
        name: team-alpha-backend
      spec:
        template:
          labels:
            environment: production
          annotations:
            description: "Backend services"
      ```

      Where:

      * `metadata.namespace`: Project's service namespace in `project-<project_name>` format. This is a required field.
      * `metadata.name`: Name of the new namespace. Must be prefixed with `<project_name>-`. This is a required field.
      * `spec.template.labels`: Additional labels for the namespace. This is an optional field.
      * `spec.template.labels`: Additional annotations for the namespace. This is an optional field.

  1. Apply the manifest:

      ```bash
      kubectl apply -f namespace.yaml
      ```

  {{ stackland-name }} will automatically create the `team-alpha-backend` namespace labeled with `stackland.yandex.cloud/project-name: team-alpha`.

{% endlist %}

### Alternative method: creating via Namespace {#create-via-namespace}

You can create a namespace directly by specifying a project label:

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: team-alpha-backend
  labels:
    stackland.yandex.cloud/project-name: team-alpha
```

{% note info %}

To create a namespace directly, you need permissions to create a Namespace resource in the cluster. The name of your namespace must be prefixed with `<project_name>-`.

{% endnote %}

## Viewing the project's namespaces {#list-namespaces}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the left-hand menu, select **Projects**.
  1. Select the project from the list.
  1. Click **Namespaces** on the project’s side panel.


- CLI {#cli}

  To get a list of the project's namespaces, run this command:

  ```bash
  kubectl get namespaces -l stackland.yandex.cloud/project-name=team-alpha
  ```

  To get a list of `ProjectNamespace` resources:

  ```bash
  kubectl get projectnamespaces -n project-team-alpha
  ```

{% endlist %}

## Deletion protection {#deletion-protection}

By default, namespaces are deletion-protected. This protection is controlled by the **Allow deletion** flag:

* When the flag is removed, the namespace is deletion-protected.
* When the flag is set, the namespace can be deleted.

To change the protection setting via the management console:

1. In the left-hand menu, select **Projects**.
1. Select the project from the list.
1. Click **Namespaces** on the project’s side panel.
1. Click the name of the namespace.
1. Click **Edit**.
1. Set or remove the **Allow deletion** flag.
1. Click **Save**.

To change the protection setting via the CLI:

```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: ProjectNamespace
metadata:
  namespace: project-team-alpha
  name: team-alpha-backend
spec:
  allowDeletion: true
```

## Deleting a namespace {#delete-namespace}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the left-hand menu, select **Projects**.
  1. Select the project from the list.
  1. Click **Namespaces** on the project’s side panel.
  1. In the namespace row, click **⋯** and select **Delete**.
  1. Confirm the deletion.


- CLI {#cli}

  1. Disable deletion protection, if it is on:

      ```bash
      kubectl patch projectnamespace team-alpha-backend \
        -n project-team-alpha \
        --type merge \
        -p '{"spec":{"allowDeletion":true}}'
      ```

  1. Delete the `ProjectNamespace` resource:

      ```bash
      kubectl delete projectnamespace team-alpha-backend -n project-team-alpha
      ```

  {{ stackland-name }} will automatically delete the associated namespace and all resources inside it.

{% endlist %}

{% note warning %}

Deleting a namespace deletes all resources inside it. This operation is irreversible.

{% endnote %}

## What's next {#what-is-next}

* [Configuring roles in a project](project-roles.md)
* [Setting project quotas](namespace-quotas.md)
