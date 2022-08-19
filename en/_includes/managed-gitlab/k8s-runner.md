## Create a {{ GL }} Runner {#runners}

To run build jobs on a [{{ managed-k8s-full-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), create a [{{ GL }} Runner](https://docs.gitlab.com/runner/install/kubernetes.html).

1. Connect a Helm repository containing the {{ GL }} Runner distribution:

   ```bash
   helm repo add gitlab https://charts.gitlab.io
   ```

1. Retrieve the {{ GL }} Runner settings:
   1. In the browser, open a link in the format `http://<Public {{ GL }} VM IP address>/root`.
   1. Select the project named `gitlab-test`.
   1. On the left-hand side of the resulting window, click **Setting** and select the **CI/CD** option.
   1. Under **Runners**, click **Expand**.
   1. Save the `URL` and the `registration token` values as you will need them in the next step.
1. Create a file called `values.yaml` with the {{ GL }} Runner settings:

   ```yaml
   imagePullPolicy: IfNotPresent
   gitlabUrl: <{{ mgl-name }} instance URL>
   runnerRegistrationToken: "<registration token>"
   terminationGracePeriodSeconds: 3600
   concurrent: 10
   checkInterval: 30
   sessionServer:
    enabled: false
   rbac:
     create: true
     clusterWideAccess: true
     podSecurityPolicy:
       enabled: false
       resourceNames:
         - gitlab-runner
   runners:
     config: |
       [[runners]]
         [runners.kubernetes]
           namespace = "{{.Release.Namespace}}"
           image = "ubuntu:20.04"
           privileged = true
   ```

1. Install {{ GL }} Runner using the following command:

   ```bash
   helm install --namespace default gitlab-runner -f values.yaml gitlab/gitlab-runner
   ```

1. Make sure that the {{ GL }} Runner pod status has changed to `Running`:

   ```bash
   kubectl get pods -n default | grep gitlab-runner
   ```

Now you can run automated builds inside your {{ k8s }} cluster.

For more information about installing and running {{ GL }} Runner, see the [{{ GL }} documentation](https://docs.gitlab.com/runner/install/).