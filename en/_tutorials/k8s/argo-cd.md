# Integration with Argo CD


[Argo CD](https://argo-cd.readthedocs.io) is a declarative GitOps tool for continuous delivery to {{ k8s }}.

This tutorial describes how to integrate a [{{ mgl-full-name }} instance](../../managed-gitlab/concepts/index.md#instance), a [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), and [Argo CD](/marketplace/products/yc/argo-cd), as well as [{{ GLR }}](/marketplace/products/yc/gitlab-runner) installed in the cluster and building Docker containers using [Kaniko](https://github.com/GoogleContainerTools/kaniko).

To integrate Argo CD with {{ managed-k8s-name }} and {{ mgl-name }}:

1. [Create a {{ GL }} instance](#create-gitlab).
1. [Configure {{ GL }}](#configure-gitlab).
1. [Create a {{ GLR }}](#runners).
1. [Prepare the application repository for deployment](#setup-repo).
1. [Deploy your application using Argo CD](#deploy-argo).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost includes:

* {{ managed-k8s-name }} cluster fee: using the master and outgoing traffic (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).
* Fee for using computing resources, OS, and storage in cluster nodes (VMs) (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Fee for public IP addresses assigned to cluster nodes (see [{{ vpc-name }} pricing](../../vpc/pricing.md#prices-public-ip)).
* NAT gateway fee if used instead of public IP addresses for cluster nodes (see [{{ vpc-name }} pricing](../../vpc/pricing.md#nat-gateways)).
* Fee for {{ container-registry-name }} [storage](../../container-registry/pricing).
* {{ GL }} instance fee. The fee depends on the instance creation method:

   * {{ mgl-name }}: You pay for VM resources, data and backup storage, and the amount of outgoing traffic (see [{{ mgl-name }} pricing](../../managed-gitlab/pricing)).
   * VM with the {{ GL }} image: You pay for VM resources, {{ GL }} image, VM public IP address (see [{{ compute-name }}](../../compute/pricing.md) and [{{ vpc-name }} pricing](../../vpc/pricing.md#nat-gateways)).


## Getting started {#before-you-begin}

### Prepare the infrastructure {#deploy-infrastructure}

{% list tabs group=instructions %}

- Manually {#manual}

  1. If you do not have a [network](../../vpc/concepts/network.md#network) yet, [create one](../../vpc/operations/network-create.md).
  1. If you do not have any [subnets](../../vpc/concepts/network.md#subnet) yet, [create them](../../vpc/operations/subnet-create.md) in the [availability zones](../../overview/concepts/geo-scope.md) where your {{ managed-k8s-name }} cluster and [node group](../../managed-kubernetes/concepts/index.md#node-group) will be created.
  1. [Create service accounts](../../iam/operations/sa/create.md):
     * Service account for the {{ k8s }} resources with the `k8s.clusters.agent` and `vpc.publicAdmin` [roles](../../resource-manager/concepts/resources-hierarchy.md#folder) for the [folder](../../managed-kubernetes/security/index.md#yc-api) where the {{ managed-k8s-name }} cluster is created.
     * Service account for {{ managed-k8s-name }} nodes with the [{{ roles-cr-puller }}](../../container-registry/security/index.md#container-registry-images-puller) and [{{ roles-cr-pusher }}](../../container-registry/security/index.md#container-registry-images-pusher) roles. This service account will be used by the {{ managed-k8s-name }} nodes to push the [Docker images](../../container-registry/concepts/registry.md) built in {{ GL }} to the [registry](../../container-registry/concepts/docker-image.md) and pull them to run [pods](../../managed-kubernetes/concepts/index.md#pod).

     {% note tip %}

     You can use the same service account to manage your {{ managed-k8s-name }} cluster and its node groups.

     {% endnote %}

  1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

        {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

  1. [Create a security group](../../managed-gitlab/operations/configure-security-group.md) for the [{{ mgl-name }} instance](../../managed-gitlab/concepts/index.md#instance).
  1. [Create a {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) cluster and a [node group](../../managed-kubernetes/operations/node-group/node-group-create.md). When creating a {{ managed-k8s-name }} cluster, specify the previously created service accounts for resources and nodes as well as the security groups for the cluster.
  1. [Create a registry in {{ container-registry-full-name }}](../../container-registry/operations/registry/registry-create.md).
  1. [Save the ID of the registry created](../../container-registry/operations/registry/registry-list.md#registry-get), as you will need it at the next steps.

- {{ TF }} {#tf}

  1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
  1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
  1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
  1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

  1. Download the [k8s-argocd.tf](https://github.com/yandex-cloud-examples/yc-mk8s-argo-cd/blob/main/k8s-argocd.tf) {{ managed-k8s-name }} cluster configuration file to the same working directory. This file describes:
     * [Network](../../vpc/concepts/network.md#network).
     * [Subnet](../../vpc/concepts/network.md#subnet).
     * {{ managed-k8s-name }} cluster.
     * [Service account](../../iam/concepts/users/service-accounts.md) for {{ managed-k8s-name }} resources and nodes.
     * {{ container-registry-name }} registry.
     * {% include [configure-sg-terraform](../../_includes/managed-kubernetes/security-groups/configure-sg-tf-lvl3.md) %}

        These security groups also contain the rules required for {{ mgl-name }} instance and [{{ container-registry-name }} registry](../../container-registry/concepts/registry.md).

        {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

  1. Specify the following in the configuration file:
     * [Folder ID](../../resource-manager/operations/folder/get-id.md).
     * [{{ k8s }}](../../managed-kubernetes/concepts/release-channels-and-updates.md) version for the {{ managed-k8s-name }} cluster and node groups.
     * {{ managed-k8s-name }} cluster CIDR.
     * Name of the service account for {{ managed-k8s-name }} resources and nodes.
     * Name of the {{ container-registry-name }} registry.
  1. Make sure the {{ TF }} configuration files are correct using this command:

     ```bash
     terraform validate
     ```

     If there are any errors in the configuration files, {{ TF }} will point them out.
  1. Create the required infrastructure:

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Install additional dependencies {#prepare}

Install the following tools in the local environment:
* [{{ yandex-cloud }} command line interface (YC CLI)](../../cli/operations/install-cli.md)
* [`jq`](https://stedolan.github.io/jq/) JSON stream processor.
* [Helm package manager]({{ links.helm.install }}).
* {% include [kubectl-install-links](../../_includes/managed-kubernetes/kubectl-install.md) %}

{% include [create-gitlab](../../_includes/managed-gitlab/create-gitlab.md) %}

{% include [Create a project](../../_includes/managed-gitlab/initialize.md) %}

{% include [create glr](../../_includes/managed-gitlab/k8s-runner.md) %}

## Prepare the application's repository to deploy {#setup-repo}

1. Get an [authorized key](../../iam/concepts/authorization/key.md) for the previously created service account with the `{{ roles-cr-puller }}` and `{{ roles-cr-pusher }}` roles:

   ```bash
   yc iam key create --service-account-name <service_account_name_for_nodes> -o key.json
   ```

1. Save the contents of the key for the next step:

   ```bash
   cat key.json | base64
   ```

1. Create the [{{ GL }}]({{ gl.docs }}/ee/ci/variables/) environment variables:
   1. In {{ GL }}, navigate to **Settings** in the left-hand panel and select **CI/CD** from the drop-down list.
   1. Click **Expand** next to **Variables**.
   1. Add these environment variables:
      * `CI_REGISTRY`: Address of the previously created registry in `{{ registry }}/<registry_ID>` format.
      * `CI_REGISTRY_USER`: `json_key`
      * `CI_REGISTRY_PASSWORD`: Output of the `cat key.json | base64`.

      To add a variable:
      1. Click **Add variable**.
      1. In the window that opens, specify the variable name in the **Key** field and its value in the **Value** field.
      1. Click **Add variable**.
1. Set up access to the repository:
   1. [Generate a new pair of SSH keys](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) or use an existing one.
   1. [Add a public part of the SSH key to the {{ GL }}](https://docs.gitlab.com/ee/user/ssh.html#add-an-ssh-key-to-your-gitlab-account) account settings.
1. Clone the repository:

   ```bash
   git clone git@<instance_name>.gitlab.yandexcloud.net:<admin_username>/gitlab-test.git
   ```

1. Clone the [yc-webinar-gitops-argo-crossplane](https://github.com/yandex-cloud-examples/yc-webinar-gitops-argo-crossplane) repository to your instance:

   ```bash
   git clone https://github.com/yandex-cloud-examples/yc-webinar-gitops-argo-crossplane.git
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

1. This will run the build script. To view its progress, in the left-hand panel in {{ GL }}, select **Build** → **Pipelines**. Wait until both build steps are complete.
1. Open the completed build and copy the following line from the log (you will need it at the next step):

   ```text
   INFO[0025] Pushing image to {{ registry }}/<registry_ID>/<admin_username>/gitlab-test:main.<commit_number>
   ```

## Deploy your application using Argo CD {#deploy-argo}

### Install Argo CD to the {{ managed-k8s-name }} cluster {#install}

1. Install Argo CD by following [this guide](../../managed-kubernetes/operations/applications/argo-cd.md).

   {% include [Install kubectl](../../_includes/managed-kubernetes/note-node-group-internet-access.md) %}

1. Get the administrator password from a {{ k8s }} secret:

   ```bash
   kubectl --namespace <namespace> get secret argocd-initial-admin-secret \
     --output jsonpath="{.data.password}" | base64 -d
   ```

1. Configure ArgoCD port forwarding onto the local computer:

   ```bash
   kubectl port-forward service/<Argo_CD_app_name>-argocd-server \
     --namespace <namespace> 8080:443
   ```

1. Open the Argo CD console at `https://127.0.0.1:8080` in your browser.
1. Log in to the console as `admin` using the password you got earlier.

### Add a {{ GL }} repository to Argo CD {#create}

1. Go to **Settings** in the left {{ GL }} panel and select **Access Tokens** from the drop-down list.
1. Set parameters for a new token:
   * **Token name**: `argocd`.
   * **Select a role**: `Maintainer`.
   * **Select scopes**: `read_repository`.
1. Click **Create project access token**.
1. Copy the value of the token you created.
1. In the Argo CD console, go to **Settings** → **Repositories**.
1. Click **Connect Repo** and select **VIA HTTPS** from the list.

   {% note info %}

   If you get the `FATA[0000] rpc error: code = Unknown desc = error testing repository connectivity: authorization failed` error when connecting a repository, enable access to {{ GL }} via HTTP(S).

   To enable access, from the left-hand panel in {{ GL }}, select **Admin → Settings → General**. Under **Visibility and access controls**, find the **Enabled Git access protocols** setting and select the option that allows HTTP(S) access from the list.

   [For more information, see the {{ GL }} documentation](https://docs.gitlab.com/administration/settings/visibility_and_access_controls/#configure-enabled-git-access-protocols).

   {% endnote %}

1. In the resulting form, enter the settings:
   * **Repository URL**: Repository URL in the following format: `https://<{{ GL }}_instance_name>.gitlab.yandexcloud.net/<admin_username>/gitlab-test.git`.
   * **Username**: `gitlab-ci-token`.
   * **Password**: Previously generated {{ GL }} token.
1. Click **Connect**.
1. In the Argo CD console, go to **Applications**, then click **Create Application**.
1. In the resulting form, enter the settings:
   * **Application Name**: `gitlab-test`.
   * **Project**: `default`.
   * **Sync policy**: `Automatic`, then select **Prune resources** and **Self Heal**.
   * **Sync options**: Select `Auto-Create Namespace`.
   * **Repository URL**: Specify the repository URL in the following format: `https://<{{ GL }}_instance_name>.gitlab.yandexcloud.net/<admin_username>/gitlab-test.git`.
   * **Path**: `.helm`.
   * **Cluster URL**: `https://kubernetes.default.svc`.
   * **Namespace**: `gitlab-test`.
   * **image.repository** : `{{ registry }}/<registry_ID>/<admin_username>/gitlab-test`.
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

### Test auto-syncing from the repository {#check}

1. Go to the directory with the [cloned project](#setup-repo) and open the `.helm/values.yaml` file.
1. Set the value of the `replicaCount` parameter to `3`.
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
1. [Delete the created Docker images](../../container-registry/operations/docker-image/docker-image-delete.md).
1. Delete the {{ managed-k8s-name }} cluster and {{ container-registry-name }} registry:

   {% list tabs group=instructions %}

   - Manually {#manual}

     1. [Delete the {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
     1. [Delete the {{ container-registry-name }} registry](../../container-registry/operations/registry/registry-delete.md).
     1. [Delete the created subnets](../../vpc/operations/subnet-delete.md) and [networks](../../vpc/operations/network-delete.md).
     1. [Delete service accounts you created](../../iam/operations/sa/delete.md).

   - {{ TF }} {#tf}

     {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

   {% endlist %}

1. [Delete the {{ GL }}](../../compute/operations/vm-control/vm-delete.md) VM or {{ mgl-name }} instance you created.
