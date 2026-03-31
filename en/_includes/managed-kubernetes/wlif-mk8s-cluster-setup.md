1. If you do not have a {{ managed-k8s-name }} cluster yet:
    1. [Create a cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md).

        {% note tip %}

        To use the `yc-metadata-server` DaemonSet controller on nodes for automatic exchange of {{ k8s }} service account tokens for an IAM token, create a cluster in the `RAPID` [release channel](../../managed-kubernetes/concepts/release-channels-and-updates.md).

        Other release channels support [manual exchange](../../managed-kubernetes/tutorials/wlif-managed-k8s-integration.md#manual-token-exchange) of {{ k8s }} service account tokens for an IAM token.

        {% endnote %}

    1. [Create](../../managed-kubernetes/operations/node-group/node-group-create.md) a node group.
    1. [Set up](../../managed-kubernetes/operations/connect/security-groups.md) security groups for the cluster and node group.
1. To use the {{ yandex-cloud }} API, your cluster nodes must have internet access. Make sure your cluster nodes have public IP addresses assigned to them or the subnet they reside in has a configured [NAT gateway](../../vpc/concepts/gateways.md#nat-gateway) or [NAT instance](../../tutorials/routing/nat-instance/index.md). Also make sure the security group rules allow unrestricted outgoing traffic for your cluster nodes.
1. Set up integration with a workload identity federation for the cluster and node group:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder with your cluster.
      1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
      1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the cluster and select **{{ ui-key.yacloud.common.edit }}**.
      1. Enable the workload identity federation in the **{{ ui-key.yacloud.k8s.IAMService.section-title_4Cx2E }}** field.
      1. Click **{{ ui-key.yacloud.common.save }}**.
      1. Under **{{ ui-key.yacloud.k8s.IAMService.section-title_4Cx2E }}** on the cluster overview page, copy the **{{ ui-key.yacloud.k8s.IAMService.ClusterIAMSection.iam-issuer_iKJcv }}** and **{{ ui-key.yacloud.k8s.IAMService.ClusterIAMSection.iam-jwks-uri_x2AJJ }}** values. You will need them to complete the integration.
      1. Navigate to the **{{ ui-key.yacloud.k8s.nodes.label_node-groups }}** tab.
      1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the node group and select **{{ ui-key.yacloud.common.edit }}**.
      1. Enable the workload identity federation in the **{{ ui-key.yacloud.k8s.IAMService.section-title_4Cx2E }}** field.
      1. Click **{{ ui-key.yacloud.common.save }}**.

    - CLI {#cli}

      {% include [cli-install](../cli-install.md) %}

      {% include [default-catalogue](../default-catalogue.md) %}

      1. Enable support for integration with workload identity federation in the cluster:

          ```bash
          yc managed-kubernetes cluster update \
            --id <cluster_ID> \
            --enable-workload-identity-federation
          ```

          Result:

          ```text
          done (3s)
          ...
          workload_identity_federation:
            enabled: true
            issuer: https://{{ s3-storage-host }}/mk8s-oidc/v1/clusters/catc7433801j********
            jwks_uri: https://{{ s3-storage-host }}/mk8s-oidc/v1/clusters/catc7433801j********/jwks.json
          ```

          Copy the `workload_identity_federation.issuer` and `workload_identity_federation.jwks_uri` values. You will need them to complete the integration.

      1. Enable support for integration with workload identity federation in the node group:

          ```bash
          yc managed-kubernetes node-group update \
            --id <node_group_ID> \
            --enable-workload-identity-federation
          ```

          Result:

          ```text
          done (12s)
          ...
          workload_identity_federation:
            enabled: true
          ```

    - {{ TF }} {#tf}

      {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

      {% include [terraform-install](../terraform-install.md) %}

      1. Add the `workload_identity_federation` section to the cluster manifest in the {{ TF }} configuration file:

          ```hcl
          resource "yandex_kubernetes_cluster" "my_cluster" {
          ...
            workload_identity_federation {
              enabled = true
            }
          }
          ```

      1. Add the `workload_identity_federation` section to the node group manifest in the {{ TF }} configuration file:

          ```hcl
          resource "yandex_kubernetes_node_group" "my_node_group" {
          ...
            workload_identity_federation {
              enabled = true
            }
          }
          ```

      1. Make sure the configuration files are correct.

          {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Confirm updating the resources.

          {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      1. Get the issuer URL (`issuer`) and the JWKS keyset URL (`jwks_uri`) to configure the workload identity federation using the {{ TF }} [yandex_kubernetes_cluster]({{ tf-provider-datasources-link }}/kubernetes_cluster) data source.

          You can aslo [find out](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-list.md#get) these parameters in the [management console]({{ link-console-main }}), using the CLI or API.

    - API {#api}

      1. Use the [update](../../managed-kubernetes/managed-kubernetes/api-ref/Cluster/update.md) REST API method for the [Cluster](../../managed-kubernetes/managed-kubernetes/api-ref/Cluster/index.md) resource or the [ClusterService/Update](../../managed-kubernetes/managed-kubernetes/api-ref/grpc/Cluster/update.md) gRPC API call.

          {% include [api-parameters-case](../../_includes/managed-kubernetes/api-parameters-case.md) %}

          Provide the following in the request:
          * Cluster ID in the `clusterId` parameter.
          * `updateMask` set to `workloadIdentityFederation.enabled`.

            {% include [Note API updateMask](../note-api-updatemask.md) %}

          * `workloadIdentityFederation` set to `"enabled": "true"`.

          Copy the `workloadIdentityFederation.issuer` and `workloadIdentityFederation.jwksUri` values from the response. You will need them later.

      1. Use the [update](../../managed-kubernetes/managed-kubernetes/api-ref/NodeGroup/update.md) REST API method for the [NodeGroup](../../managed-kubernetes/managed-kubernetes/api-ref/NodeGroup/index.md) resource or the [NodeGroupService/Update](../../managed-kubernetes/managed-kubernetes/api-ref/grpc/NodeGroup/update.md) gRPC API call.

          Provide the following in the request:
          * Node group ID in the `nodeGroupId` parameter.
          * `updateMask` set to `workloadIdentityFederation.enabled`.
          * `workloadIdentityFederation` set to `"enabled": "true"`.

    {% endlist %}