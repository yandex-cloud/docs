# Integrating with Argo CD

[Argo CD](https://argo-cd.readthedocs.io) is a declarative GitOps tool for continuous delivery to {{ k8s }}.

This tutorial describes how to integrate a [{{ mgl-full-name }} instance](../../../managed-gitlab/concepts/index.md#instance), a [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster), and [Argo CD](/marketplace/products/yc/argo-cd), as well as [{{ GLR }}](/marketplace/products/yc/gitlab-runner) installed in the cluster and building Docker containers using [Kaniko](https://github.com/GoogleContainerTools/kaniko).

To integrate Argo CD with {{ managed-k8s-name }} and {{ mgl-name }}:
1. [{#T}](#create-gitlab).
1. [{#T}](#configure-gitlab).
1. [{#T}](#runners).
1. [{#T}](#setup-repo).
1. [{#T}](#deploy-argo).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

### Prepare the infrastructure {#deploy-infrastructure}

{% list tabs %}

- Manually

   1. If you do not have a [network](../../../vpc/concepts/network.md#network) yet, [create one](../../../vpc/operations/network-create.md).
   1. If you do not have any [subnets](../../../vpc/concepts/network.md#subnet) yet, [create them](../../../vpc/operations/subnet-create.md) in the [availability zones](../../../overview/concepts/geo-scope.md) where your {{ managed-k8s-name }} cluster and [node group](../../concepts/index.md#node-group) will be created.
   1. [Create service accounts](../../../iam/operations/sa/create.md):
      * Service account for {{ k8s }} resources with the [{{ roles-editor }}](../../../iam/concepts/access-control/roles.md#editor) [role](../../../iam/concepts/access-control/roles.md) for the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the {{ managed-k8s-name }} cluster is created.
      * Service account for {{ managed-k8s-name }} nodes with the [{{ roles-cr-puller }}](../../../iam/concepts/access-control/roles.md#cr-images-puller) and [{{ roles-cr-pusher }}](../../../iam/concepts/access-control/roles.md#cr-images-pusher.md) roles. This service account will be used by the {{ managed-k8s-name }} nodes to push the [Docker images](../../../container-registry/concepts/docker-image.md) that you build in {{ GL }} to the [registry](../../../container-registry/concepts/registry.md), as well as pull them to run [pods](../../concepts/index.md#pod).

      {% note tip %}

      You can use the same service account to manage your {{ managed-k8s-name }} and its node groups.

      {% endnote %}

   1. [Create a {{ managed-k8s-name }} cluster](../../operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../../operations/node-group/node-group-create.md). When creating a {{ managed-k8s-name }} cluster, specify the previously created service accounts for the resources and nodes.
   1. [Configure security groups](../../operations/connect/security-groups.md) for the {{ managed-k8s-name }} cluster to run.
   1. [Configure the default security group](../../../managed-gitlab/operations/connect.md) required for the [{{ mgl-name }} instance](../../../managed-gitlab/concepts/index.md#instance) to run.
   1. [Create a registry in {{ container-registry-full-name }}](../../../container-registry/operations/registry/registry-create.md).
   1. [Save the ID of the registry created](../../../container-registry/operations/registry/registry-list.md#registry-get), as you will need it at the next steps.

- Using {{ TF }}

   1. {% include [terraform-install](../../../_includes/terraform-install.md) %}
   1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
   1. Download the [k8s-argocd.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/managed-kubernetes/k8s-argocd.tf) {{ managed-k8s-name }} cluster configuration file to the same working directory. The file describes:
      * [Network](../../../vpc/concepts/network.md#network).
      * [Subnet](../../../vpc/concepts/network.md#subnet).
      * [Security group](../../../vpc/concepts/security-groups.md) and [rules](../../operations/connect/security-groups.md) required for the {{ managed-k8s-name }} cluster, node group, {{ mgl-name }} instance, and [{{ container-registry-name }} register](../../../container-registry/concepts/registry.md) to run:
         * Rules for service traffic.
         * Rules for accessing the {{ k8s }} API and managing the {{ managed-k8s-name }} cluster with `kubectl` through ports 443 and 6443.
         * Rules for connecting to a Git repository over SSH on port 22.
         * Rules that allow HTTP and HTTPS traffic through ports 80 and 443.
         * Rules for connecting to {{ container-registry-name }} through port 5050.
      * {{ managed-k8s-name }} cluster.
      * [Service account](../../../iam/concepts/users/service-accounts.md) for {{ managed-k8s-name }} resources and nodes.
      * {{ container-registry-name }} registry.
   1. Specify the following in the configuration file:
      * [Folder ID](../../../resource-manager/operations/folder/get-id.md).
      * [{{ k8s }} version](../../concepts/release-channels-and-updates.md) for the {{ managed-k8s-name }} cluster and node groups.
      * {{ managed-k8s-name }} cluster CIDR.
      * Name of the service account for {{ managed-k8s-name }} resources and nodes.
      * Name of the {{ container-registry-name }} registry.
   1. Run the `terraform init` command in the directory with the configuration files. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.
   1. Create the required infrastructure:

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Install additional dependencies {#prepare}

Install the following items in the local environment:
* [{{ yandex-cloud }} command line interface (YC CLI)](../../../cli/operations/install-cli.md)
* [`jq` JSON stream processor](https://stedolan.github.io/jq/)
* [Helm package manager]({{ links.helm.install }})
* {% include [kubectl-install-links](../../../_includes/managed-kubernetes/kubectl-install.md) %}

{% include [create-gitlab](../../../_includes/managed-gitlab/create-gitlab.md) %}

{% include [Create a project](../../../_includes/managed-gitlab/initialize.md) %}

{% include [create glr](../../../_includes/managed-gitlab/k8s-runner.md) %}

## Prepare the application's repository to deploy {#setup-repo}

1. Get an [authorized key](../../../iam/concepts/authorization/key.md) for the previously created service account with the `{{ roles-cr-puller }}` and `{{ roles-cr-pusher }}` roles:

   ```bash
   yc iam key create --service-account-name <name_of_service_account_for_nodes> -o key.json
   ```

1. Save the contents of the key for the next step:

   ```bash
   cat key.json | base64
   ```

1. Create the [{{ GL }} environment variables](https://docs.gitlab.com/ee/ci/variables/README.html):
   1. Go to **Settings** in the left-hand {{ GL }} panel and select **CI/CD** from the drop-down list.
   1. Click **Expand** next to **Variables**.
   1. Add environment variables:
      * `CI_REGISTRY`: Address of the previously created registry in `{{ registry }}/<registry_ID>` format.
      * `CI_REGISTRY_USER`: `json_key`.
      * `CI_REGISTRY_PASSWORD`: Output of the `cat key.json | base64` command.

      To add a variable:
      1. Click **Add variable**.
      1. In the window that opens, enter the variable name in the **Key** field and the value in the **Value** field.
      1. Click **Add variable**.
1. Set up access to the repository:
   1. [Generate a new pair of SSH keys](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) or use an existing one.
   1. [Add a public part of the SSH key to the {{ GL }} account settings](https://docs.gitlab.com/ee/user/ssh.html#add-an-ssh-key-to-your-gitlab-account).
1. Clone the repository:

   ```bash
   git clone git@<instance_name>.gitlab.yandexcloud.net:<admin_name>/gitlab-test.git
   ```

1. Clone the [yc-webinar-gitops-argo-crossplane](https://github.com/yandex-cloud-examples/yc-webinar-gitops-argo-crossplane) repository to your instance:

   ```bash
   git clone git@github.com:yandex-cloud-examples/yc-webinar-gitops-argo-crossplane.git
   ```

1. To the `gitlab-test` directory, copy all files from the `yc-webinar-gitops-argo-crossplane/02-argocd/app` directory, including hidden files:

   ```bash
   cp -rT <path_to_app_directory> <path_to_gitlab-test_directory>
   ```

1. Commit the changes to `gitlab-test` and push them to the repository:

   ```bash
   git add . && \
   git commit -m "Add app src and CI" && \
   git push
   ```

1. This will run the build script. To track its progress, in the drop-down menu, select **Build** → **Pipelines**. Wait until both build steps are complete.
1. Open the completed build and copy the following line from the log (you will need it at the next step):

   ```text
   INFO[0025] Pushing image to {{ registry }}/<registry_ID>/<admin_name>/gitlab-test:main.<commit_number>
   ```

## Deploy your application using Argo CD {#deploy-argo}

### Install Argo CD to the {{ managed-k8s-name }} cluster {#install}

1. Install Argo CD by following this [guide](../../operations/applications/argo-cd.md).

   {% include [Install kubectl](../../../_includes/managed-kubernetes/note-node-group-internet-access.md) %}

1. Configure ArgoCD port forwarding onto the local computer:

   ```bash
   kubectl port-forward service/<Argo_CD_application_name>-argocd-server \
     --namespace <namespace> 8080:443
   ```

1. Get the administrator password from a {{ k8s }} secret:

   ```bash
   kubectl --namespace <namespace> get secret argocd-initial-admin-secret \
     --output jsonpath="{.data.password}" | base64 -d
   ```

1. Open the Argo CD console at `https://127.0.0.1:8080` in your browser.
1. Log in to the console as `admin` using the password obtained in the previous step.

### Add a {{ GL }} repository to Argo CD {#create}

1. Go to **Settings** in the left {{ GL }} panel and select **Access Tokens** from the drop-down list.
1. Set parameters for a new token:
   * **Token name**: `argocd`.
   * **Select a role**: `Maintainer`.
   * **Select scopes**: `read_repository`.
1. Click **Create project access token**.
1. Copy the value of the created token.
1. In the Argo CD console, go to **Settings** → **Repositories**.
1. Click **Connect Repo Using HTTPS**.
1. In the resulting form, enter the settings:
   * **Repository URL**: Repository URL in the following format: `https://<{{ GL }}_instance_name>.gitlab.yandexcloud.net/<admin_name>/gitlab-test.git`.
   * **Username**: `gitlab-ci-token`.
   * **Password**: A previously generated {{ GL }} token.
1. Click **Connect**.
1. In the Argo CD console, go to **Applications**, then click **Create Application**.
1. In the resulting form, enter the settings:
   * **Application Name**: `gitlab-test`.
   * **Project**: `default`.
   * **Sync policy**: `Automatic`, then select **Prune resources** and **Self Heal**.
   * **Sync options**: Select the `Auto-Create Namespace` option.
   * **Repository URL**: Specify the repository URL, such as `https://<{{ GL }}_instance_name>.gitlab.yandexcloud.net/<admin_name>/gitlab-test.git`.
   * **Path**: `.helm`.
   * **Cluster URL**: `https://kubernetes.default.svc`.
   * **Namespace**: `gitlab-test`.
   * **image.repository**: `{{ registry }}/<registry_ID>/<admin_username>/gitlab-test`.
   * **image.tag**: `main.<commit_number>`.
1. Click **Create** and wait until the syncing completes.
1. To test how the application runs, execute the following command in the {{ managed-k8s-name }} cluster:

   ```bash
   kubectl get all -n gitlab-test
   ```

   Result:

   ```text
   NAME                               READY   STATUS    RESTARTS   AGE
   pod/gitlab-test-67c8d58bc4-6w4q7   1/1     Running   0          2m26s
   pod/gitlab-test-67c8d58bc4-sldpc   1/1     Running   0          2m26s

   NAME                  TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
   service/gitlab-test   ClusterIP   10.96.186.223   <none>        80/TCP    2m26s

   NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
   deployment.apps/gitlab-test   2/2     2            2           2m26s

   NAME                                     DESIRED   CURRENT   READY   AGE
   replicaset.apps/gitlab-test-67c8d58bc4   2         2         2       2m26s
   ```

### Test auto-syncing from the {#check} repository

1. Go to the directory with the [cloned project](#setup-repo) and open the `.helm/values.yaml` file.
1. Change the `replicaCount` parameter to `3`.
1. Save the changes and push them to the repository:

   ```bash
   git add . && \
   git commit -m "Increase replica count" && \
   git push
   ```

1. In the Argo CD console, wait until the application is synced.
1. Make sure the number of application pods in the {{ managed-k8s-name }} cluster has increased:

   ```bash
   kubectl get pod -n gitlab-test
   ```

   Result:

   ```text
   NAME                               READY   STATUS    RESTARTS   AGE
   pod/gitlab-test-67c8d58bc4-6w4q7   1/1     Running   0          15m
   pod/gitlab-test-67c8d58bc4-7hmcn   1/1     Running   0          10m
   pod/gitlab-test-67c8d58bc4-sldpc   1/1     Running   0          15m

   NAME                  TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
   service/gitlab-test   ClusterIP   10.96.186.223   <none>        80/TCP    15m

   NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
   deployment.apps/gitlab-test   3/3     3            3           15m

   NAME                                     DESIRED   CURRENT   READY   AGE
   replicaset.apps/gitlab-test-67c8d58bc4   3         3         3       15m
   ```

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:
1. [Delete the created Docker images](../../../container-registry/operations/docker-image/docker-image-delete.md).
1. Delete the {{ managed-k8s-name }} cluster and {{ container-registry-name }} registry:

   {% list tabs %}

   - Manually

     1. [Delete the {{ managed-k8s-name }} cluster](../../operations/kubernetes-cluster/kubernetes-cluster-delete.md).
     1. [Delete the {{ container-registry-name }} registry](../../../container-registry/operations/registry/registry-delete.md).
     1. [Delete the created subnets](../../../vpc/operations/subnet-delete.md) and [networks](../../../vpc/operations/network-delete.md).
     1. [Delete the created service accounts](../../../iam/operations/sa/delete.md).

   - Using {{ TF }}

     1. In the command line, go to the directory with the current {{ TF }} configuration file with an infrastructure plan.
     1. Delete the `k8s-argocd.tf` configuration file.
     1. Make sure the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        If there are any errors in the configuration files, {{ TF }} will point them out.
     1. Confirm updating the resources.

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        All the resources described in the `k8s-argocd.tf` configuration file will be deleted.

   {% endlist %}

1. [Delete the {{ GL }} VM](../../../compute/operations/vm-control/vm-delete.md) or {{ mgl-name }} instance that you created.