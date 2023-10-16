## Create a test application {#app-create}

Create a test application that can be deployed in a [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster):
1. Add `Dockerfile` to the project:
   1. Log in to {{ GL }}.
   1. On the home page, select a repository.
   1. Select the **Repository** → **Files** section.
   1. Click ![image](../../_assets/plus.svg) and select **New file** from the drop-down menu.
   1. Name the file as `Dockerfile` and add the following code to it:

      ```Dockerfile
      FROM alpine:3.10
      CMD echo "Hello"
      ```

   1. Add a comment to the commit in the **Commit message** field: `Dockerfile for test application`.
   1. Click **Commit changes**.
1. Add the manifest for creating {{ managed-k8s-name }} cluster resources to the project:
   1. Select the **Repository** → **Files** section.
   1. Click ![image](../../_assets/plus.svg) and select **New file** from the drop-down menu.
   1. Name the file as `k8s.yaml`:

      {% cut "k8s.yaml" %}

      ```yaml
      apiVersion: v1
      kind: Namespace
      metadata:
        name: hello-world
      ---
      apiVersion: apps/v1
      kind: Deployment
      metadata:
        name: hello-world-deployment
        namespace: hello-world
      spec:
        replicas: 1
        selector:
          matchLabels:
            app: hello
        template:
          metadata:
            namespace: hello-world
            labels:
              app: hello
          spec:
            containers:
              - name: hello-world
                image: {{ registry }}/<registry ID>/__VERSION__
                imagePullPolicy: Always
      ```

      {% endcut %}

   1. Replace the `<registry ID>` with the ID of the {{ container-registry-name }} [registry](../../container-registry/concepts/registry.md) that you created previously.
   1. Add a comment to the commit in the **Commit message** field: `Docker image deployment config`.
   1. Click **Commit changes**.