## Create a {{ GLR }} {#runners}

To run build jobs on a [{{ managed-k8s-full-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), create a [{{ GLR }}](https://docs.gitlab.com/runner/install/kubernetes.html).
1. Connect a Helm repository containing the {{ GL }} Runner distribution:

   ```bash
   helm repo add gitlab https://charts.gitlab.io
   ```

1. Retrieve the {{ GLR }} settings:
   1. Open the {{ GL }} administration panel in the browser:
      * If the {{ GL }} has been deployed on a {{ compute-full-name }} [VM instance](../../compute/concepts/vm.md), use its [public IP](../../compute/concepts/network.md#public-ip).
      * If the {{ GL }} has been deployed in {{ mgl-name }}, use the [instance FQDN](../../compute/concepts/network.md##hostname).
   1. Select the project named `gitlab-test`.
   1. On the left-hand side of the resulting window, click **Settings** and select the **CI/CD** option.
   1. Under **Runners**, click **Expand**.
   1. Save the `URL` and the `registration token` values as you will need them in the next step.
1. Create a file called `values.yaml` with the {{ GLR }} settings:

   ```yaml
   imagePullPolicy: IfNotPresent
   gitlabUrl: <Public IP of the VM or the {{ mgl-name }} instance FQDN>
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

1. Install {{ GLR }} using the following command:

   ```bash
   helm install --namespace default gitlab-runner -f values.yaml gitlab/gitlab-runner
   ```

1. Make sure that the {{ GLR }} pod status has changed to `Running`:

   ```bash
   kubectl get pods -n default | grep gitlab-runner
   ```

Now you can run automated builds inside your {{ k8s }} cluster.

For more information about installing and running {{ GLR }}, see the [{{ GL }} documentation](https://docs.gitlab.com/runner/install/).