### Set up your infrastructure {#deploy-infrastructure}

{% list tabs group=instructions %}

- Manually {#manual}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. If you do not have a [network](../../vpc/concepts/network.md#network) yet, [create one](../../vpc/operations/network-create.md).
  1. If you do not have any [subnets](../../vpc/concepts/network.md#subnet) yet, [create them](../../vpc/operations/subnet-create.md) in the [availability zones](../../overview/concepts/geo-scope.md) where your [{{ managed-k8s-full-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) and [node group](../../managed-kubernetes/concepts/index.md#node-group) will be created.
  1. [Create service accounts](../../iam/operations/sa/create.md):
     * For the resources with the `k8s.clusters.agent` and `vpc.publicAdmin` [roles](../../iam/concepts/access-control/roles.md) for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) the {{ managed-k8s-name }} cluster is created in. This service account will be used to create the resources required for the {{ managed-k8s-name }} cluster.
     * For nodes with the [{{ roles-cr-puller }}](../../container-registry/security/index.md#container-registry-images-puller) and [{{ roles-cr-pusher }}](../../container-registry/security/index.md#container-registry-images-pusher) roles for the folder with the [Docker image](../../container-registry/concepts/registry.md) [registry](../../container-registry/concepts/docker-image.md). This service account will be used by the {{ managed-k8s-name }} nodes to push the Docker images built in {{ GL }} to the registry and pull them to run [pods](../../managed-kubernetes/concepts/index.md#pod).

     {% note tip %}

     You can use the same [service account](../../iam/concepts/users/service-accounts.md) for both operations.

     {% endnote %}

  1. {% include [configure-sg-manual](../managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

        {% include [sg-common-warning](../managed-kubernetes/security-groups/sg-common-warning.md) %}

   1. [Create a security group](../../managed-gitlab/operations/configure-security-group.md) for the [{{ mgl-name }} instance](../../managed-gitlab/concepts/index.md#instance).

  1. [Create a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) and a [node group](../../managed-kubernetes/operations/node-group/node-group-create.md). When creating a {{ managed-k8s-name }} cluster, specify the previously created service accounts for resources and nodes and the security group.

  1. [Create a registry in {{ container-registry-full-name }}](../../container-registry/operations/registry/registry-create.md).
  1. [Create an authorized key](../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) for the service account with the `{{ roles-cr-pusher }}` role and save it to the `key.json` file:

     ```bash
     yc iam key create \
       --service-account-name <service_account_name> \
       --output key.json
     ```

     This key is required to access the registry from {{ GL }}.

- {{ TF }} {#tf}

  1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
  1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
  1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
  1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

  1. Download the [k8s-and-registry-for-gitlab.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cr-gitlab/blob/main/k8s-and-registry-for-gitlab.tf) configuration file to the same working directory.

     This file describes:
     * [Network](../../vpc/concepts/network.md#network).
     * [Subnet](../../vpc/concepts/network.md#subnet).
     * [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).
     * [Service account](../../iam/concepts/users/service-accounts.md) required for the {{ managed-k8s-name }} cluster and [node group](../../managed-kubernetes/concepts/index.md#node-group).
     * {% include [configure-sg-terraform](../managed-kubernetes/security-groups/configure-sg-tf-with-audience-lvl3.md) %}

        {% include [sg-common-warning](../managed-kubernetes/security-groups/sg-common-warning.md) %}

     * [Default security group](../../vpc/concepts/security-groups.md) and rules needed to run the [{{ mgl-name }} instance](../../managed-gitlab/concepts/index.md#instance).
     * [Registry](../../container-registry/concepts/registry.md) in [{{ container-registry-full-name }}](../../container-registry/).
     * [Authorized key](../../iam/concepts/authorization/key.md) for the service account. This key is required to access the registry from {{ GL }}.
     * Local `key.json` file with authorized key data.
  1. Specify the following in the `k8s-and-registry-for-gitlab.tf` file:
     * [Folder ID](../../resource-manager/operations/folder/get-id.md).
     * [{{ k8s }} version](../../managed-kubernetes/concepts/release-channels-and-updates.md) for the {{ managed-k8s-name }} cluster and node groups.
     * Name of the {{ managed-k8s-name }} cluster service account.
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

{% note warning %}

For applications running in production environments, make sure to restrict access of {{ managed-k8s-name }} cluster service accounts to pushing Docker images to a registry. This is required for security reasons. In that case, create a separate service account with the `{{ roles-cr-pusher }}` role and specify it for deploying applications.

{% endnote %}
