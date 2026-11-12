This section describes typical issues you may encounter while using {{ managed-k8s-name }} and gives troubleshooting recommendations.

#### Error creating a cluster in a different folder's cloud network {#neighbour-catalog-permission-denied}

Error message:

```text
Permission denied
```

This error occurs when the [resource service account](../../managed-kubernetes/security/index.md#sa-annotation) has no required [roles](../../iam/concepts/access-control/roles.md) in the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) that contains the [cloud network](../../vpc/concepts/network.md#network) selected when creating the cluster.

To create a [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) in a cloud network of another folder, [assign](../../iam/operations/sa/assign-role-for-sa.md) the resource [service account](../../iam/concepts/users/service-accounts.md) the following roles in that folder:
* [{{ roles-vpc-private-admin }}](../../vpc/security/index.md#vpc-private-admin)
* [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user)

To use a [public IP address](../../vpc/concepts/address.md#public-addresses), also [assign](../../iam/operations/sa/assign-role-for-sa.md) the [{{ roles-vpc-public-admin }}](../../vpc/security/index.md#vpc-public-admin) role.

#### Namespace fails to delete and remains _Terminating_ {#namespace-terminating}

This issue occurs when your [namespace](../../managed-kubernetes/concepts/index.md#namespace) contains stuck resources that the namespace controller cannot delete.

To fix it, delete the stuck resources manually.

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. [Connect to the {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/connect/index.md).
  1. Get the list of resources remaining in the namespace:

     ```bash
     kubectl api-resources --verbs=list --namespaced --output=name \
       | xargs --max-args=1 kubectl get --show-kind \
       --ignore-not-found --namespace=<namespace>
     ```

  1. Delete the listed resources:

     ```bash
     kubectl delete <resource_type> <resource_name> --namespace=<namespace>
     ```

  If the namespace is still in the `Terminating` status and cannot be deleted, delete it forcibly using `finalizer`:
  1. Run a local proxy to the {{ k8s }} API:

     ```bash
     kubectl proxy
     ```

  1. Delete the namespace:

     ```bash
     kubectl get namespace <namespace> --output=json \
       | jq '.spec = {"finalizers":[]}' > temp.json && \
     curl --insecure --header "Content-Type: application/json" \
       --request PUT --data-binary @temp.json \
       127.0.0.1:8001/api/v1/namespaces/<namespace>/finalize
     ```

    We do not recommend deleting the namespace with the `Terminating` status using `finalizer` right away, as this may cause the stuck resources to remain in your {{ managed-k8s-name }} cluster.

{% endlist %}

#### I am using {{ network-load-balancer-full-name }} together with an ingress controller. Why are some of my cluster's nodes _UNHEALTHY_? {#nlb-ingress}

This is normal behavior for a [load balancer](../../network-load-balancer/concepts/index.md) with `External Traffic Policy: Local` enabled. Only the [{{ managed-k8s-name }} nodes](../../managed-kubernetes/concepts/index.md#node-group) whose [pods](../../managed-kubernetes/concepts/index.md#pod) are ready to handle user traffic get the `HEALTHY` status. All other nodes are labeled as `UNHEALTHY`.

To check the policy type of a load balancer created using a `LoadBalancer` service, run this command:

```bash
kubectl describe svc <LoadBalancer_service_name> \
| grep 'External Traffic Policy'
```

For more information, see [Parameters of a LoadBalancer service](../../managed-kubernetes/operations/create-load-balancer.md#advanced).

#### Why does the newly created PersistentVolumeClaim remain _Pending_? {#pvc-pending}

This is normal for a [PersistentVolumeClaim](../../managed-kubernetes/concepts/volume.md#persistent-volume) (PVC). The newly created PVC remains **Pending** until you create a pod that will use it.

To change the PVC status to **Running**:
1. View the PVC details:

   ```bash
   kubectl describe pvc <PVC_name> \
     --namespace=<namespace>
   ```

   Where `--namespace` is the namespace containing the PVC.

   The `waiting for first consumer to be created before binding` message means that the PVC is awaiting pod creation.
1. [Create a pod](../../managed-kubernetes/operations/volumes/dynamic-create-pv.md#create-pod) for this PVC.

#### Why does my {{ managed-k8s-name }} cluster fail to start after I update its node configuration? {#not-starting}

Make sure the new configuration of {{ managed-k8s-name }} nodes is within the [quota](../../managed-kubernetes/concepts/limits.md):

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To run diagnostics for your {{ managed-k8s-name }} cluster nodes:
  1. [Connect to the {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/connect/index.md).
  1. Check the state of {{ managed-k8s-name }} nodes:

     ```bash
     yc managed-kubernetes cluster list-nodes <cluster_ID>
     ```

     A message saying that the limit of {{ managed-k8s-name }} cluster resources has been exceeded appears in the first column of the command output. Here is an example:

     ```text
     +--------------------------------+-----------------+------------------+-------------+--------------+
     |         CLOUD INSTANCE         | KUBERNETES NODE |     RESOURCES    |     DISK    |    STATUS    |
     +--------------------------------+-----------------+------------------+-------------+--------------+
     | fhmil14sdienhr5uh89no          |                 | 2 100% core(s),  | 64.0 GB hdd | PROVISIONING |
     | CREATING_INSTANCE              |                 | 4.0 GB of memory |             |              |
     | [RESOURCE_EXHAUSTED] The limit |                 |                  |             |              |
     | on total size of network-hdd   |                 |                  |             |              |
     | disks has exceeded.,           |                 |                  |             |              |
     | [RESOURCE_EXHAUSTED] The limit |                 |                  |             |              |
     | on total size of network-hdd   |                 |                  |             |              |
     | disks has exceeded.            |                 |                  |             |              |
     +--------------------------------+-----------------+------------------+-------------+--------------+
     ```

{% endlist %}

If out of quotas, [request an increase]({{ link-console-quotas }}). Check both the {{ managed-k8s-name }} and [{{ compute-name }}](../../compute/concepts/limits.md) quotas.

These checks are also useful where your cluster remains `STARTING` for a long time after being created or started. Also check the roles granted to the [service account for cluster resources](../../managed-kubernetes/security/index.md#sa-annotation). It must have the `{{ roles.k8s.clusters.agent }}` role; for using public IP addresses, `{{ roles-vpc-public-admin }}`.

If the issue persists, [create a support ticket]({{ link-console-support }}). Specify the cluster ID, the time the error occurred, and the diagnostic results.

#### After changing the node subnet mask in the cluster settings, the number of pods per node is not as expected {#count-pods}

**Solution**: Recreate the node group.

#### Error updating ingress controller certificate {#ingress-certificate}

Error message:

```text
ERROR controller-runtime.manager.controller.ingressgroup Reconciler error
{"name": "some-prod", "namespace": , "error": "rpc error: code = InvalidArgument
desc = Validation error:\nlistener_specs[1].tls.sni_handlers[2].handler.certificate_ids:
Number of elements must be less than or equal to 1"}
```

The error occurs if different certificates are specified for the same ingress controller handler.

**Solution**: Edit and apply the ingress controller specifications so that each handler has only one certificate.

#### Why is DNS resolution not working in my cluster? {#not-resolve-dns}

A {{ managed-k8s-name }} cluster may fail to resolve internal and external DNS requests for several reasons. To fix the issue:
1. [Check the version of your {{ managed-k8s-name }} cluster and node groups](#check-version).
1. [Make sure CoreDNS is up and running](#check-coredns).
1. [Make sure your {{ managed-k8s-name }} cluster has enough CPU resources available](#check-cpu).
1. [Set up autoscaling](#dns-autoscaler).
1. [Set up local DNS caching](#node-local-dns).

##### Check the version of your cluster and node groups {#check-version}

1. Get the list of current {{ k8s }} versions:

   ```bash
   yc managed-kubernetes list-versions
   ```

1. Get the {{ managed-k8s-name }} cluster version:

   ```bash
   yc managed-kubernetes cluster get <cluster_name_or_ID> | grep version:
   ```

   You can get the {{ managed-k8s-name }} cluster ID and name with the [list of clusters in the folder](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-list.md#list).
1. Get the {{ managed-k8s-name }} node group version:

   ```bash
   yc managed-kubernetes node-group get <node_group_name_or_ID> | grep version:
   ```

   You can get the {{ managed-k8s-name }} node group ID and name with the [list of node groups in the cluster](../../managed-kubernetes/operations/node-group/node-group-list.md#list).
1. If the versions of your {{ managed-k8s-name }} cluster and node groups are not on the list of current {{ k8s }} versions, [upgrade them](../../managed-kubernetes/operations/update-kubernetes.md).

##### Make sure CoreDNS is up and running {#check-coredns}

Get the list of CoreDNS pods and their statuses:

```bash
kubectl get pods -n kube-system -l k8s-app=kube-dns -o wide
```

Make sure all pods have the `Running` status. If the status is different or DNS requests continue to fail, check the logs:

```bash
kubectl logs -l k8s-app=kube-dns -n kube-system --all-containers=true
```

For further diagnostics, follow the [{{ k8s }} guide on checking DNS](https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/).

##### Make sure your cluster has enough CPU resources available {#check-cpu}

1. In the [management console]({{ link-console-main }}), select the folder.
1. [Navigate]({{ link-console-main }}/link/managed-kubernetes) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Locate the {{ managed-k8s-name }} cluster you need in the list, click its name, and select the **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** tab.
1. Go to the **{{ ui-key.yacloud.k8s.nodes.label_nodes }}** tab and click the name of any {{ managed-k8s-name }} node.
1. Navigate to the **{{ ui-key.yacloud.k8s.node.overview.label_monitoring }}** tab.
1. Make sure that, in the **CPU, [cores]** chart, the `used` CPU values have not reached the `total` available CPU values. Check this for each {{ managed-k8s-name }} cluster node.

##### Set up autoscaling {#dns-autoscaler}

Set up [DNS autoscaling based on the {{ managed-k8s-name }} cluster size](../../managed-kubernetes/tutorials/dns-autoscaler.md).

##### Set up local DNS caching {#node-local-dns}

[Set up NodeLocal DNS Cache](../../managed-kubernetes/tutorials/node-local-dns.md). For optimal settings, [install NodeLocal DNS Cache from {{ marketplace-full-name }}](../../managed-kubernetes/operations/applications/node-local-dns.md#marketplace-install).

If the issue persists, [create a support ticket]({{ link-console-support }}). Specify the cluster ID, the time the error occurred, and the diagnostic results. Attach the CoreDNS logs and examples of failed DNS requests.

#### Creating a node group with the CLI results in a parameter conflict. How do I fix it? {#conflicting-flags}

Check whether you are specifying the `--location`, `--network-interface`, and `--public-ip` parameters in the same command. Providing them together causes the following errors:
* For the `--location` and `--public-ip` or `--location` and `--network-interface` pairs:

  ```text
  ERROR: rpc error: code = InvalidArgument desc = Validation error:
  allocation_policy.locations[0].subnet_id: can't use "allocation_policy.locations[0].subnet_id" together with "node_template.network_interface_specs"
  ```

* For the `--network-interface` and `--public-ip` pair:

  ```text
  ERROR: flag --public-ip cannot be used together with --network-interface. Use '--network-interface' option 'nat' to get public address
  ```

Make sure you only provide one of the three parameters in a command. It is enough to specify the location of a {{ managed-k8s-name }} node group either in `--location` or in `--network-interface`.

{% include [assign-public-ip-addresses](../../_includes/managed-kubernetes/assign-public-ip-addresses.md) %}

#### Error connecting to a cluster using kubectl {#connect-to-cluster}

Error message:

```text
ERROR: cluster has empty endpoint
```

This error occurs if you try to [connect to a cluster](../../managed-kubernetes/operations/connect/index.md#kubectl-connect) with no public IP address and get `kubectl` credentials for a public IP address using this command:

```bash
{{ yc-k8s }} cluster \
   get-credentials <cluster_name_or_ID> \
   --external
```

To connect to the cluster's private IP address from a VM in the same network, get `kubectl` credentials using this command:

```bash
{{ yc-k8s }} cluster \
   get-credentials <cluster_name_or_ID> \
   --internal
```

If you need to connect to a cluster from the internet, [recreate the cluster and assign](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) it a public IP address.

#### Errors connecting to a node over SSH {#node-connect}

Error messages:

```text
Permission denied (publickey,password)
```

```text
Too many authentication failures
```

The following situations cause errors [when connecting to a {{ managed-k8s-name }} node](../../managed-kubernetes/operations/node-connect-ssh.md):
* No public SSH key is added to the {{ managed-k8s-name }} node group metadata.

  **Solution**: [Update the {{ managed-k8s-name }} node group keys](../../managed-kubernetes/operations/node-connect-ssh.md#node-add-metadata).
* An invalid public SSH key is added to the {{ managed-k8s-name }} node group metadata.

  **Solution**: [Change the format of the public key file to the appropriate one](../../managed-kubernetes/operations/node-connect-ssh.md#key-format) and [update the {{ managed-k8s-name }} node group keys](../../managed-kubernetes/operations/node-connect-ssh.md#node-add-metadata).
* No private SSH key is added to an authentication agent (`ssh-agent`).

  **Solution**: Add a private key by running the `ssh-add <path_to_private_key_file>` command.

#### How do I provide internet access to my {{ managed-k8s-name }} cluster nodes? {#internet}

If {{ managed-k8s-name }} cluster nodes have no internet access, the following error occurs when trying to connect to the internet:

```text
Failed to pull image "{{ registry }}/***": rpc error: code = Unknown desc = Error response from daemon: Gethttps://{{ registry }}/v2/: net/http: request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)
```

You can provide internet access to your {{ managed-k8s-name }} cluster nodes in several ways:
* Set up a [NAT gateway](../../vpc/operations/create-nat-gateway.md) or [NAT instance](../../vpc/tutorials/nat-instance/index.md). With [static routing](../../vpc/concepts/routing.md) in place, traffic will go through a gateway or a separate NAT instance.
* [Assign a public IP addresses to your {{ managed-k8s-name }} node group](../../managed-kubernetes/operations/node-group/node-group-update.md#node-internet-access).

{% note info %}

If you assign public IP addresses to your cluster nodes and then configure a NAT gateway or NAT instance, you will lose internet access via the public addresses. For more information, see [this {{ vpc-full-name }} guide](../../vpc/concepts/routing.md#internet-routes).

{% endnote %}

#### Why cannot I choose Docker as the container runtime? {#docker-runtime}

Clusters running {{ k8s }} 1.24 or higher do not support the Docker container runtime. [containerd](https://containerd.io/) is the only available runtime.

#### Error connecting a {{ GL }} repository to Argo CD {#argo-cd}

Error message:

```text
FATA[0000] rpc error: code = Unknown desc = error testing repository connectivity: authorization failed
```

This error occurs if access to {{ GL }} over HTTP(S) is disabled.

**Solution**: Enable HTTP(S) access. To do this:

  1. In {{ GL }}, in the left-hand panel, select **Admin → Settings → General**.
  1. Under **Visibility and access controls**, find the **Enabled Git access protocols** setting.
  1. In the list, select the item which allows access over HTTP(S).

  For more information, see [this {{ GL }} guide](https://docs.gitlab.com/administration/settings/visibility_and_access_controls/#configure-enabled-git-access-protocols).

#### Traffic loss when deploying app updates in a cluster with {{ alb-full-name }} {#alb-traffic-lost}

When your app traffic is managed by an {{ alb-name }} and the load balancer's ingress controller [traffic policy](../../managed-kubernetes/nlb-ref/service.md#servicespec) is set to `externalTrafficPolicy: Local`, the app processes requests on the same node they were delivered to by the load balancer. There is no traffic flow between nodes.

The [default health check](../../network-load-balancer/concepts/health-check.md) monitors the status of the node, not application. Therefore, {{ alb-name }} traffic may go to a node where there is no application running. When you deploy a new app version in a cluster, the [{{ alb-name }} ingress controller](../../application-load-balancer/tools/k8s-ingress-controller/index.md) requests the load balancer to update the backend group configuration. It takes at least 30 seconds to process the request, and the app may not receive any user traffic during that time.

To prevent this, we recommend setting up backend health checks on your {{ alb-name }}. With health checks, the load balancer timely spots unavailable backends and reroutes traffic to healthy backends. Once the application is updated, traffic will again be distributed across all backends.

For more information, see [{#T}](../../application-load-balancer/concepts/best-practices.md) and [{#T}](../../application-load-balancer/k8s-ref/service-for-ingress.md#annotations).

#### System time displayed incorrectly on nodes, as well as in container and {{ managed-k8s-name }} cluster pod logs {#time}

{{ managed-k8s-name }} cluster time may not match the time of other resources, such as VMs, if they use different time synchronization sources. For example, a {{ managed-k8s-name }} cluster synchronizes with a time server (by default), whereas a VM synchronizes with a private or public NTP server.

**Solution**: Set up {{ managed-k8s-name }} cluster time synchronization with your private NTP server. Follow these steps:

1. Specify the NTP server addresses in the [DHCP settings](../../vpc/concepts/dhcp-options.md) of the subnets housing the master and worker nodes. If the worker nodes reside in other subnets, repeat the configuration procedure for those subnets.

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the folder.
     1. [Navigate]({{ link-console-main }}/link/managed-kubernetes) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
     1. Click the name of the {{ k8s }} cluster.
     1. Under **{{ ui-key.yacloud.k8s.cluster.overview.section_master }}**, click the subnet name.
     1. Click ![subnets](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** in the top-right corner.
     1. In the window that opens, expand the **{{ ui-key.yacloud.vpc.subnetworks.create.section_dhcp-options }}** section.
     1. Click **{{ ui-key.yacloud.vpc.subnetworks.create.button_add-ntp-server }}** and specify the IP address of your NTP server.
     1. Click **{{ ui-key.yacloud.vpc.subnetworks.update.button_update }}**.

   - CLI {#cli}

     {% include [include](../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     1. See the description of the CLI command for updating subnet settings:

         ```bash
         yc vpc subnet update --help
         ```

     1. Run the `subnet` command, specifying the NTP server IP address in the `--ntp-server` parameter: 

         ```bash
         yc vpc subnet update <subnet_ID> --ntp-server <server_address>
         ```

     {% include [note-get-cluster-subnet-id](../../_includes/managed-kubernetes/note-get-cluster-subnet-id.md) %}

   - {{ TF }} {#tf}

     1. In the {{ TF }} configuration file, change the cluster subnet description. Add the `dhcp_options` section (if missing) with the `ntp_servers` parameter specifying the IP address of your NTP server:

        ```hcl
        ...
        resource "yandex_vpc_subnet" "lab-subnet-a" {
          ...
          v4_cidr_blocks = ["<IPv4_address>"]
          network_id     = "<network_ID>"
          ...
          dhcp_options {
            ntp_servers = ["<IPv4_address>"]
            ...
          }
        }
        ...
        ```

        For more information about `yandex_vpc_subnet` properties in {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/vpc_subnet).

     1. Apply the changes:

        {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
        
        {{ TF }} will update all required resources. You can check the subnet update using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

        ```bash
        yc vpc subnet get <subnet_name>
        ```
     
   - API {#api}
   
     Use the [update](../../vpc/api-ref/Subnet/update.md) method for the [Subnet](../../vpc/api-ref/Subnet/index.md) resource and provide the following in the request:

     * NTP server IP address in the `dhcpOptions.ntpServers` parameter.
     * `dhcpOptions.ntpServers` parameter to update in the `updateMask` parameter.
     
     {% include [note-get-cluster-subnet-id](../../_includes/managed-kubernetes/note-get-cluster-subnet-id.md) %}

   {% endlist %}

   {% note warning %}

   For a highly available master hosted across three availability zones, you need to update each of the three subnets.

   {% endnote %}

1. Enable connections from the cluster to NTP servers.
   
   [Create a rule](../../vpc/operations/security-group-add-rule.md) for outbound traffic in the [cluster and node group security group](../../managed-kubernetes/operations/connect/security-groups.md#rules-internal-cluster):

   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `123`. If your NTP server uses a port other than `123`, specify that port.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_udp }}`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `<NTP_server_IP_address>/32`. For a master hosted across three availability zones, specify three sections: `<NTP_server_IP_address_in_subnet1>/32`, `<NTP_server_IP_address_in_subnet2>/32`, and `<NTP_server_IP_address_in_subnet3>/32`.

1. Update the network settings in the cluster node group using one of the following methods:

   * Connect to each node in the group [over SSH](../../managed-kubernetes/operations/node-connect-ssh.md) or [via {{ oslogin }}](../../managed-kubernetes/operations/node-connect-oslogin.md) and run the `sudo dhclient -v -r && sudo dhclient` command.
   * Reboot the group nodes at any convenient time.

   {% note warning %}

   Updating network settings may cause the services within the cluster to become unavailable for a few minutes.

   {% endnote %}

For worker nodes running `systemd-timesyncd`, time sources can also be configured via a DaemonSet. This option requires a privileged container and modifies the host configuration. Before proceeding, check the time synchronization service being used.

{% cut "Example DaemonSet for configuring systemd-timesyncd" %}

In `NTP_SERVERS`, specify NTP servers accessible from the nodes. The example creates a separate configuration file, so subsequent runs do not depend on whether the main file contains a commented-out `NTP=` line.

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: ntp-configurator
  namespace: kube-system
spec:
  selector:
    matchLabels:
      app: ntp-configurator
  template:
    metadata:
      labels:
        app: ntp-configurator
    spec:
      hostPID: true
      hostNetwork: true
      initContainers:
        - name: configure-ntp
          image: ubuntu:22.04
          env:
            - name: NTP_SERVERS
              value: "<NTP_server_1> <NTP_server_2>"
          command:
            - /bin/bash
            - -ec
            - |
              nsenter --mount=/proc/1/ns/mnt -- /bin/sh -ec '
                mkdir -p /etc/systemd/timesyncd.conf.d
                printf "[Time]\nNTP=%s\n" "$1" > /etc/systemd/timesyncd.conf.d/90-custom-ntp.conf
                systemctl restart systemd-timesyncd
                systemctl is-active systemd-timesyncd
              ' sh "$NTP_SERVERS"
          securityContext:
            privileged: true
      containers:
        - name: sleep
          image: ubuntu:22.04
          command: ["/bin/sleep", "infinity"]
```

A DaemonSet applies settings only to nodes where it can be scheduled. Deleting a DaemonSet does not remove the created file from the nodes. To revert the configuration, delete the `/etc/systemd/timesyncd.conf.d/90-custom-ntp.conf` file and restart `systemd-timesyncd` on the affected nodes.

{% endcut %}

If the issue persists, [create a support ticket]({{ link-console-support }}). Specify the cluster ID, the time the error occurred, and the diagnostic results. Specify the NTP servers used and the exact time discrepancy.

#### What should I do if I deleted my {{ network-load-balancer-full-name }} or its target groups that were automatically created for a LoadBalancer service? {#deleted-loadbalancer-service}

You cannot manually restore a {{ network-load-balancer-name }} or its target groups. [Recreate](../../managed-kubernetes/operations/create-load-balancer.md#lb-create) your `LoadBalancer` service. This will automatically create a load balancer and target groups.

#### Error connecting a {{ compute-full-name }} VM instance as an external {{ managed-k8s-name }} node {#vm-as-external-node}

Error message:

```text
Unable to create remote dir /home/kubernetes/bin/: ssh run `mkdir -p -m 0644 /home/kubernetes/bin/': Process exited with status 142
Please login as the user "NONE" rather than the user "root".
```

To fix the issue, [recreate](../../compute/operations/index.md#vm-create) the VM instance, specifying `disable_root: false` in the metadata for the `user-data` key.

{% include [external-node-metadata-example](../../_includes/managed-kubernetes/external-node-metadata-example.md) %}

#### What should I do if I get the `node(s) had untolerated taint` error? {#untolerated-taint}

The error means that a `taint` is set on the node, for which the pod does not have a corresponding `toleration`. The taint effect determines the behavior: `NoSchedule` prevents new pods from being scheduled, `NoExecute` also evicts already running pods, and `PreferNoSchedule` applies a soft restriction.

Check the node taints and pod tolerations:

```bash
kubectl describe node <node_name>
kubectl describe pod <pod_name> --namespace <namespace>
```

If the pod must run on this node, add the corresponding toleration to the pod’s `spec.tolerations`. If the taint is no longer required, remove it or change its effect to `PreferNoSchedule`. For more details on `taint` and `toleration`, see [this Kubernetes guide](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/).

#### Why does the pod remain in the Pending status? {#pod-pending}

View the pod description:

```bash
kubectl describe pod <pod_name> --namespace <namespace>
```

Messages under `Events` help determine the cause, e.g., insufficient resources, placement restrictions, or a volume mounting issue. The next steps depend on the error message.

If the information is insufficient, [create a support ticket]({{ link-console-support }}). Specify the cluster ID and attach the pod description. If the pod is already scheduled on a node, attach the `kubelet`, kernel, and system logs from that node. You can use a [diagnostic script](https://github.com/yandex-cloud/yc-architect-solution-library/tree/main/yc-k8s-capture-nodes-logs) to collect the logs.

#### What to do if I get a `DEADLINE_EXCEEDED` error when exporting metrics? {#metrics-deadline-exceeded}

When exporting {{ managed-k8s-name }} metrics via the {{ monitoring-name }} API, the request may fail with a `504` code and a `DEADLINE_EXCEEDED` message. One possible reason is a large volume of metrics, causing your request to time out.

Reduce the data volume using the `selectors` parameter. For example, in the {{ prometheus-name }} configuration, specify the namespace:

```yaml
scrape_configs:
  - job_name: yc-monitoring-export
    metrics_path: /monitoring/v2/prometheusMetrics
    params:
      folderId:
        - '<folder_ID>'
      service:
        - managed-kubernetes
      selectors:
        - 'namespace=<namespace>'
    bearer_token: '<IAM_token>'
```

This is a snippet of the metrics collection configuration: keep the server address settings from your configuration. For pod metrics, you can also use a name mask, e.g., `pod=app*`. You can learn more about the {{ monitoring-name }} query language [here](../../monitoring/concepts/querying.md).

#### What to do if HPA does not receive metrics? {#hpa-metrics}

If HPA reports `FailedGetResourceMetric` or requests to `metrics.k8s.io` time out, check the [cluster security groups](../../managed-kubernetes/operations/connect/security-groups.md#apply) and the resources of the node running your Metrics Server.

If this node does not have enough resources, migrate the Metrics Server pod to another node:

1. Locate the pod name and node:

   ```bash
   kubectl get pods -n kube-system -o wide | grep metrics-server
   ```

1. Make sure that another node has enough resources and meets the pod placement rules. Prevent new pods from being scheduled on the original node and delete the Metrics Server pod:

   ```bash
   kubectl cordon <original_node>
   kubectl delete pod <metrics-server_pod_name> -n kube-system
   ```

   The controller will create a new pod. Until it starts, metrics may be unavailable.

1. Check the new pod’s readiness and the node it is placed on:

   ```bash
   kubectl get pods -n kube-system -o wide | grep metrics-server
   ```

1. After the pod starts, allow pod scheduling on the original node again:

   ```bash
   kubectl uncordon <original_node>
   ```

   If the migration fails, also uncordon the node before further diagnostics.

If the error persists, [create a support ticket]({{ link-console-support }}). Specify the cluster ID, the name of the affected pod, and attach the output of `kubectl describe hpa --namespace <namespace>`.

#### What to do if mounting a volume to a pod times out? {#volume-mount-timeout}

When mounting a volume, you may get the following error:

```text
Unable to attach or mount volumes: timed out waiting for the condition
```

Check the pod and PVC events to determine the cause:

```bash
kubectl describe pod <pod_name> --namespace <namespace>
kubectl describe pvc <PVC_name> --namespace <namespace>
```

If the kubelet logs contain a message about a slow file permission change, use [this guide for volumes with a large number of files](#volume-many-files).

If the issue is related to attaching the disk to the node’s VM, stopping and restarting the VM may help. [Stop the VM](../../compute/operations/vm-control/vm-stop-and-start.md#stop), wait for the `STOPPED` state, then [start it](../../compute/operations/vm-control/vm-stop-and-start.md#start) again. This will interrupt the operation of pods on the node, so perform this operation during a period of minimal load.

#### Why does mounting a volume with a large number of files take a long time? {#volume-many-files}

If mounting times out, check the kubelet log on the node:

```bash
sudo journalctl -u kubelet --no-pager --since today
```

`If the volume has a lot of files then setting volume ownership could be slow...` indicates that changing the owner and access permissions to the volume’s files is taking a long time.

If `fsGroup` is set for the pod, {{ k8s }} may recursively change permissions during mounting. For supported volumes, the `fsGroupChangePolicy: OnRootMismatch` parameter in `spec.securityContext` allows this operation to be skipped if the root directory’s permissions already match the expected ones. For more details on when this applies, see [this {{ k8s }} guide](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#configure-volume-permission-and-ownership-change-policy-for-pods).

If the issue persists, [create a support ticket]({{ link-console-support }}). Specify the cluster ID, the time the error occurred, and the diagnostic results.

#### What to do if nodes remain in the `RECONCILING` status for a long time? {#node-reconciling}

If the `RECONCILING` status persists for more than 20 minutes, check [quota usage]({{ link-console-quotas }}) and the node status:

```bash
yc managed-kubernetes node-group list-nodes <node_group_ID> --format yaml
```

`Kubelet stopped posting node status` indicates that your kubelet has stopped reporting the node’s status. [Connect to the node over SSH](../../managed-kubernetes/operations/node-connect-ssh.md) and check the services:

```bash
sudo systemctl status containerd kubelet
```

If the services are not working correctly, review their logs and restart the affected services:

```bash
sudo systemctl restart containerd
sudo systemctl restart kubelet
```

Restarting may affect the node’s applications. After restarting, recheck the status of the services and the node.

If the issue persists, [create a support ticket]({{ link-console-support }}). Specify the cluster ID, the time the error occurred, and the diagnostic results.
