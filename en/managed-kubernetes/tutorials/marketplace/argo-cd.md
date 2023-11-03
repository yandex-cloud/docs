# Integrating with Argo CD

[Argo CD](https://argo-cd.readthedocs.io) is a declarative GitOps tool for continuous delivery to {{ k8s }}.

This tutorial describes how to integrate a [{{ mgl-full-name }} instance](../../../managed-gitlab/concepts/index.md#instance), a [{{ k8s }} cluster](../../concepts/index.md#kubernetes-cluster), and [Argo CD](/marketplace/products/yc/argo-cd) that is installed in the cluster and builds Docker containers using [Kaniko](https://github.com/GoogleContainerTools/kaniko).

To integrate Argo CD with {{ managed-k8s-name }} and {{ mgl-name }}:
1. [{#T}](#create-gitlab).
1. [{#T}](#configure-gitlab).
1. [{#T}](#runner).
1. [{#T}](#setup-repo).
1. [{#T}](#deploy-argo).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

### Prepare the infrastructure {#deploy-infrastructure}

{% list tabs %}

- Manually

   1. If you do not have a [network](../../../vpc/concepts/network.md#network) yet, [create one](../../../vpc/operations/network-create.md).
   1. If you do not have any [subnets](../../../vpc/concepts/network.md#subnet) yet, [create them](../../../vpc/operations/subnet-create.md) in the [availability zones](../../../overview/concepts/geo-scope.md) where your {{ k8s }} cluster and node group will be created.
   1. [Create service accounts](../../../iam/operations/sa/create.md):
      * With the [{{ roles-editor }}](../../../iam/concepts/access-control/roles.md#editor) [role](../../../iam/concepts/access-control/roles.md) for the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you create your {{ k8s }} cluster. The resources the {{ k8s }} cluster needs will be created on behalf of this account.
      * With the [{{ roles-cr-puller }}](../../../iam/concepts/access-control/roles.md#cr-images-puller) and [{{ roles-cr-pusher }}](../../../iam/concepts/access-control/roles.md#cr-images-pusher.md) roles. This service account will be used to push the Docker images that you build to {{ GL }} and pull them to run [pods](../../concepts/index.md#pod).

      {% note tip %}

      You can use the same [service account](../../../iam/concepts/users/service-accounts.md) to manage your {{ k8s }} cluster and its node groups.

      {% endnote %}

   1. [Create a {{ k8s }} cluster](../../operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../../operations/node-group/node-group-create.md) with the following settings:
      * **Service account for resources**: Select the service account with the `{{ roles-editor }}` role you created previously.
      * **Service account for nodes**: Select the service account with the `{{ roles-cr-puller }}` and `{{ roles-cr-pusher }}` roles that you created previously.
      * **Public address**: `Auto`.
      * Individual node group parameters:
         * **vCPU**: `4`
         * **RAM**: `8 GB`
         * **Preemptible**
         * **Scaling**: `Auto`
         * **Minimum nodes**: `1`
         * **Maximum nodes**: `4`
         * **Initial nodes**: `1`

      Save the cluster ID, as you will need it at the next steps.
   1. [Create a registry in {{ container-registry-full-name }}](../../../container-registry/operations/registry/registry-create.md).
   1. [Save the ID of the registry created](../../../container-registry/operations/registry/registry-list.md#registry-get), as you will need it at the next steps.

- Using {{ TF }}

   1. {% include [terraform-install](../../../_includes/terraform-install.md) %}
   1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
   1. Download the [k8s-argocd.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/managed-kubernetes/k8s-argocd.tf) cluster configuration file to the same working directory. The file describes:
      * [Network](../../../vpc/concepts/network.md#network).
      * [Subnet](../../../vpc/concepts/network.md#subnet).
      * [Security group](../../../vpc/concepts/security-groups.md) and [rules](../../operations/connect/security-groups.md) required for the cluster, node group, {{ mgl-name }} instance, and {{ container-registry-name }} container to run:
         * Rules for service traffic.
         * Rules for accessing the {{ k8s }} API and managing the cluster with `kubectl` through ports 443 and 6443.
         * Rules for connecting to a Git repository over SSH on port 22.
         * Rules that allow HTTP and HTTPS traffic through ports 80 and 443.
         * Rules for connecting to {{ container-registry-name }} through port 5050.
      * {{ managed-k8s-name }} cluster.
      * [Service account](../../../iam/concepts/users/service-accounts.md) required to use the {{ managed-k8s-name }} cluster and node group.
      * [{{ container-registry-name }} registry](../../../container-registry/concepts/registry.md).
   1. Specify the following in the configuration file:
      * [Folder ID](../../../resource-manager/operations/folder/get-id.md).
      * {{ k8s }} version for the cluster and node groups.
      * {{ k8s }} cluster CIDR.
      * Name of the cluster service account.
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

{% include [k8s-get-token](../../../_includes/managed-gitlab/k8s-get-token.md) %}

{% include [create-gitlab](../../../_includes/managed-gitlab/create-gitlab.md) %}

{% include [Create a project](../../../_includes/managed-gitlab/initialize.md) %}

## Create a {{ GLR }} {#runner}

To run build tasks in the [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster), create a [{{ GLR }}](https://docs.gitlab.com/runner/install/kubernetes.html).
1. Connect a Helm repository containing the {{ GLR }} distribution.

   ```bash
   helm repo add gitlab https://charts.gitlab.io
   ```

1. Retrieve the {{ GLR }} settings:
   1. Open the {{ GL }} administration panel in the browser:
      * If the {{ GL }} has been deployed on a {{ compute-full-name }} [VM instance](../../../compute/concepts/vm.md), use its [public IP](../../../compute/concepts/network.md#public-ip).
      * If {{ GL }} is deployed in {{ mgl-name }}, use the [instance FQDN](../../../compute/concepts/network.md##hostname).
   1. Select the project named `gitlab-test`.
   1. On the left-hand side of the resulting window, click **Settings** and select the **CI/CD** option.
   1. Under **Runners**, click **Expand**.
   1. Save the `URL` and the `registration token` values as you will need them in the next step.
1. Create a file called `values.yaml` with the {{ GLR }} settings:

   {% cut "values.yaml" %}

   ```yaml
   ---
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

   {% endcut %}

1. Install {{ GLR }} using the following command:

   ```bash
   helm install --namespace default gitlab-runner -f values.yaml gitlab/gitlab-runner
   ```

1. Wait for the {{ GLR }} status to change to `Running`:

   ```bash
   kubectl get pods -n default | grep gitlab-runner
   ```

Now you can run automated builds inside your [{{ k8s }} cluster](../../concepts/index.md#kubernetes-cluster).

For more information about installing and running {{ GLR }}, see the [{{ GL }} documentation](https://docs.gitlab.com/runner/install/).

## Prepare the application's repository to deploy {#setup-repo}

1. In {{ mgl-name }}, create a new repository named `my-app`:

   {% list tabs %}

   - {{ mgl-name }} instance

     1. Log in to the {{ mgl-name }} instance web interface.
     1. Go to the `gitlab-test` group.
     1. Click **Create a project**.
     1. Click **Create blank project**.
     1. Fill out the fields below:
        * **Project name**: `my-app`.
        * **Project URL**: Select `gitlab-test` in the field next to the {{ mgl-name }}instance FQDN.

        Leave the other fields unchanged.
     1. Click **Create project**.

   - VM running a {{ GL }} image

     To configure {{ GL }} and enable Continuous Integration (CI), create a new project and enter the CI authorization parameters:
     1. On the {{ compute-name }} page, select the created VM and find its [public IP](../../../vpc/concepts/address.md#public-addresses).
     1. In the browser, open a link in the format `http://<public VM IP address>`. The {{ GL }} admin panel opens.
     1. Set the administrator password and click **Change your password**.
     1. Enter the `root` username and your administrator password.
     1. Click **Sign in**.
     1. Select **Create a project**.
     1. Name the project `my-app`.
     1. Click **Create project**.

   {% endlist %}

1. Get an [authorized key](../../../iam/concepts/authorization/key.md) for the previously created service account with the `{{ roles-cr-pusher }}` role:

   ```bash
   yc iam key create --service-account-name <registry's service account name> -o key.json
   ```

1. Save the contents of the key for the next step:

   ```bash
   cat key.json | base64
   ```

1. Create the [{{ GL }} environment variables](https://docs.gitlab.com/ee/ci/variables/README.html):
   1. Go to **Settings** in the left-hand {{ GL }} panel and select **CI/CD** from the drop-down list.
   1. Click **Expand** next to **Variables**.
   1. Add three environment variables:

      | Name | Value | Options |
      | --- | --- | --- |
      | CI_REGISTRY | {{ registry }}/<registry ID> | `no` |
      | CI_REGISTRY_USER | json_key | `no` |
      | CI_REGISTRY_PASSWORD | <`cat key.json \| base64` command output> | `Mask variable` |

1. Set up access to the repository:
   1. [Generate a new pair of SSH keys](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) or use an existing one.
   1. [Add a public part of the SSH key to the {{ GL }} account settings](https://docs.gitlab.com/ee/user/ssh.html#add-an-ssh-key-to-your-gitlab-account).
1. Clone the repository:

   ```bash
   git clone git@<{{ mgl-name }} instance name>.gitlab.yandexcloud.net:gitlab-test/my-app.git
   ```

1. Download the `app.zip` archive and unzip it.
1. Copy all files, including the hidden ones, from the archive to the `my-app` directory:

   ```bash
   cp -a <path to directory with files from app.zip> <path to my-app directory>
   ```

1. Save the changes and push them to the repository:

   ```bash
   git add . && \
   git commit -m "Add app src and CI" && \
   git push
   ```

1. Run the build script. To track its progress, in the drop-down menu, select **CI/CD** → **Pipelines**. Wait until both build steps are complete.
1. Open the completed build and copy the following line from the log (you will need it at the next step):

   ```text
   INFO[0025] Pushing image to {{ registry }}/<registry ID>/gitlab-test/my-app:main.<commit number>
   ```

## Deploy your application using Argo CD {#deploy-argo}

### Install Argo CD to the {{ k8s }} cluster {#install}

1. Install Argo CD by following this [guide](../../operations/applications/argo-cd.md).

   {% include [Install kubectl](../../../_includes/managed-kubernetes/note-node-group-internet-access.md) %}

1. Configure the `argocd-server` port forwarding to the local machine, and then connect to the {{ k8s }} cluster:

   ```bash
   kubectl port-forward svc/<Argo CD application name>-argocd-server 8080:443
   ```

1. Get the administrator password from a {{ k8s }} secret:

   ```bash
   kubectl get secret argocd-initial-admin-secret \
     -o jsonpath='{.data.password}' | base64 -d
   ```

1. Open the Argo CD console at `https://127.0.0.1:8080` in your browser.
1. Log in to the console as `admin` using the password obtained in the previous step.

### Create a {{ GL }} repository for Argo CD {#create}

1. Go to **Settings** in the left {{ GL }} panel and select **Access Tokens** from the drop-down list.
1. Set parameters for a new token:
   * **Token name**: `argocd`.
   * **Select scopes**: `read_repository`.
1. Click **Create project access token**.
1. Copy the value of the created token.
1. In the Argo CD console, go to **Settings** → **Repositories**.
1. Click **Connect Repo Using SSH**.
1. In the resulting form, enter the settings:
   * **Repository URL**: Repository URL like `https://<{{ GL }} instance name>.gitlab.yandexcloud.net/gitlab-test/my-app.git`.
   * **Username**: `gitlab-ci-token`.
   * **Password**: A previously generated {{ GL }} token.
1. Click **Connect**.
1. In the Argo CD console, go to **Applications**, then click **Create Application**.
1. In the resulting form, enter the settings:
   * **Application Name**: `my-app`.
   * **Project**: `default`.
   * **Sync policy**: `Automatic`, then select **Prune resources** and **Self Heal**.
   * **Sync options**: Select the `Auto-Create Namespace` option.
   * **Source**: Specify the repository URL in the following format: `https://<{{ GL }} instance name>.gitlab.yandexcloud.net/gitlab-test/my-app.git`.
   * **Path**: `.helm`.
   * **Cluster URL**: `https://kubernetes.default.svc`.
   * **Namespace**: `my-app`.
   * **Directory**: Select `Helm` and then, in the **Parameters** section that appears, set the parameters based on the value of the successful {{ GL }} build:
     * **image.repository**: `{{ registry }}/<registry ID>/gitlab-test/my-app`.
     * **image.tag**: `main.<commit number>`.
1. Click **Create** and wait until the syncing completes.
1. To test how the application runs, execute the following command in the {{ k8s }} cluster:

   ```bash
   kubectl get all -n my-app
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
1. Make sure the number of application pods in the cluster has increased:

   ```bash
   kubectl get pod -n my-app
   ```

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:
1. [Delete the created Docker images](../../../container-registry/operations/docker-image/docker-image-delete.md).
1. Delete the {{ k8s }} cluster and {{ container-registry-name }} registry:

   {% list tabs %}

   - Manually

     1. [Delete the {{ k8s }} cluster](../../operations/kubernetes-cluster/kubernetes-cluster-delete.md).
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