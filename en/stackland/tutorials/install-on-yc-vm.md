# Installing {{ stackland-name }} on {{ yandex-cloud }} VMs

This guide describes how to install {{ stackland-full-name }} on {{ yandex-cloud }} VMs from a custom boot image.

{% note info "Note" %}

Common use cases for {{ stackland-name }} deployment over VMs in {{ yandex-cloud }} are demonstration, prototyping, and test benches.

We recommend these services for production loads in zones where managed {{ yandex-cloud }} services are available.

{% endnote %}

## Introduction {#introduction}

To deploy a minimal cluster, you will need:

* One bastion host on Ubuntu 22.04 or higher. This host is used to run `sladm`, gets access to the cluster, and give nodes access to the internet.
* At least three VMs for your future {{ stackland-name }} cluster. All the VMs must reside in the same cloud network and the same subnet.
* Custom disk image created from a {{ stackland-name }} raw image.
* On each VM: one boot disk created from the custom image and one separate data disk.
* Service account with the permissions to manage {{ network-load-balancer-name }} and use the cloud network.

See the recommended resources for cluster nodes in the [Infrastructure](../quickstart.md#infrastructure) section.

{% note info "Note" %}

Links to release artifacts use the `$VERSION` variable. Replace it with current {{ stackland-name }} version.

{% endnote %}

The CLI examples below use variables. Before you run the commands, set them to the following:

```bash
export VERSION=26.1.5
export ZONE=ru-central1-d
export NETWORK_NAME=stackland-network
export SUBNET_NAME=stackland-subnet
export SUBNET_CIDR=10.130.0.0/24
export SECURITY_GROUP_NAME=stackland-sg
export DNS_ZONE_NAME=stackland-internal
export BASE_DOMAIN=stackland.internal
export CLUSTER_NAME=main
```

## Get a cloud network ready {#prepare-network}

Create a cloud network with a subnet to deploy the bastion host and cluster VMs in.

Proceed with the following requirements in mind:

* All cluster VMs must reside in the same subnet. This facilitates the operation of {{ network-load-balancer-name }} and the target group.
* Cluster VMs must have stable internal IP addresses.
* The bastion host must have internet access and network access to cluster VMs.
* Custer nodes must have internet access via the bastion host, NAT, or another network mechanism in your infrastructure.

Create a DNS zone for the new cluster. The examples below use the `stackland.internal` domain.

If using the CLI, run these commands:

```bash
yc vpc network create --name $NETWORK_NAME

yc vpc subnet create \
  --name $SUBNET_NAME \
  --zone $ZONE \
  --range $SUBNET_CIDR \
  --network-name $NETWORK_NAME

NETWORK_ID=$(yc vpc network get $NETWORK_NAME --format json | jq -r '.id')

yc dns zone create \
  --name $DNS_ZONE_NAME \
  --zone $BASE_DOMAIN. \
  --private-visibility \
  --network-ids $NETWORK_ID
```

If using security groups for VMs, create a group and allow the traffic required for cluster installation and operation:

```bash
yc vpc security-group create \
  --name $SECURITY_GROUP_NAME \
  --network-name $NETWORK_NAME

SECURITY_GROUP_ID=$(yc vpc security-group get $SECURITY_GROUP_NAME --format json | jq -r '.id')

yc vpc security-group update-rules $SECURITY_GROUP_ID \
  --add-rule "direction=ingress,protocol=any,predefined=self_security_group" \
  --add-rule "direction=ingress,protocol=tcp,port=22,v4-cidrs=<admin_ip_address>/32" \
  --add-rule "direction=ingress,protocol=tcp,from-port=30000,to-port=32767,v4-cidrs=0.0.0.0/0" \
  --add-rule "direction=egress,protocol=any,v4-cidrs=0.0.0.0/0"
```

The `30000-32767` range rule is required for {{ network-load-balancer-name }} to access the NodePort ports of the system ingress. The example gives the standard NodePort range in Kubernetes. If you have another range set in your configuration, specify it in the security group rule. For production benches, limit the traffic source in this rule according to your organization’s network policy.

## Prepare a service account {#service-account}

Create a service account to be associated with your cluster VMs. Assign the following roles to it:

* `load-balancer.admin`: To create and delete network load balancers and target groups.
* `vpc.user`: To work with cloud network resources.

Run the following commands:

```bash
yc iam service-account create --name stackland-yc-lb

SA_ID=$(yc iam service-account get stackland-yc-lb --format json | jq -r '.id')
FOLDER_ID=$(yc config get folder-id)

yc resource-manager folder add-access-binding "$FOLDER_ID" \
  --role load-balancer.admin \
  --subject serviceAccount:"$SA_ID"

yc resource-manager folder add-access-binding "$FOLDER_ID" \
  --role vpc.user \
  --subject serviceAccount:"$SA_ID"
```

## Create a disk image {#create-image}

Create a custom disk image from the {{ stackland-name }} raw image. The raw image is available at:

```text
https://storage.yandexcloud.net/stackland-public/stackland/$VERSION/images/stackland-amd64-$VERSION.raw
```

You can follow the [Uploading a custom image](https://yandex.cloud/ru/docs/compute/operations/image-create/upload) guide to create an image.

If using the CLI, run this command:

```bash
yc compute image create \
  --name stackland-$VERSION \
  --source-uri https://storage.yandexcloud.net/stackland-public/stackland/$VERSION/images/stackland-amd64-$VERSION.raw \
  --os-type linux \
  --min-disk-size 150GB
```

Wait for the image to change its status to `READY`.

## Create a bastion host {#create-bastion}

Create a VM on Ubuntu 22.04 or higher in the same subnet where the cluster nodes will reside.

Install the required utilities on the bastion host:

```bash
sudo apt update
sudo apt install unzip jq curl wget -y
```

Install `kubectl` to be able to check cluster health status after installation. For example:

```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
```

Install and configure the [CLI for {{ yandex-cloud }}](https://yandex.cloud/ru/docs/cli/quickstart).

If cluster nodes access the internet via the bastion host, enable IPv4 routing and NAT. For a NAT configuration example, see [Installing {{ stackland-name }} on {{ baremetal-full-name }}](install-on-yc-bms.md#net-settings).

## Create cluster VMs {#create-vms}

Create at least three VMs for your {{ stackland-name }} cluster.

For each one, configure the following settings:

* Boot disk: From the `stackland-$VERSION` custom image.
* Additional data disk: At least the [minimum required](../quickstart.md#infrastructure) size.
* Service account: Service account you created earlier.
* Subnet: Same subnet the bastion host is in.
* Internal IP address: Static.
* Public IP address: Do not assign if hosts are accessed via the bastion host.
* `cluster-name` label: The value must match that of `metadata.name` in the `StacklandClusterConfig` resource. In the example below, it is `main`.

If using the CLI, add the `--labels cluster-name=$CLUSTER_NAME` argument when creating the VMs.

If the VMs have already been created, add the label separately:

```bash
yc compute instance add-labels node1 --labels cluster-name=$CLUSTER_NAME
yc compute instance add-labels node2 --labels cluster-name=$CLUSTER_NAME
yc compute instance add-labels node3 --labels cluster-name=$CLUSTER_NAME
```

{% note warning "Warning" %}

The `cluster-name` label is required for the `yandexcloud-lb` component. Without it, the balancer's operator will not be able to get the cluster name from the {{ yandex-cloud }} metadata service and will keep on restarting with the `failed to get cluster name from metadata: metadata service returned status 404` error.

{% endnote %}

Here is an example of creating the first node using the CLI:

```bash
yc compute instance create \
  --name node1 \
  --zone $ZONE \
  --hostname node1.$BASE_DOMAIN \
  --platform standard-v3 \
  --cores 32 \
  --memory 64GB \
  --core-fraction 100 \
  --labels cluster-name=$CLUSTER_NAME \
  --create-boot-disk name=node1-boot,image-name=stackland-$VERSION,type=network-ssd,size=150,auto-delete=true \
  --create-disk name=node1-data,type=network-ssd,size=400,device-name=data,auto-delete=true \
  --network-interface subnet-name=$SUBNET_NAME,ipv4-address=10.130.0.11,security-group-ids=$SECURITY_GROUP_ID \
  --service-account-name stackland-yc-lb
```

Use this example to create your other nodes by changing names, FQDNs, IP addresses, and disk names.

Once the VMs are created, write down the following for each node:

* FQDN or name to use in the {{ stackland-name }} configuration.
* Internal IP address.
* MAC address of the network interface.
* Boot disk name within the guest OS. Usually the name is `/dev/vda`, but you should check the value for your configuration.
* Data disk name within the guest OS. Usually the name is `/dev/vdb` if there is one additional disk connected to the VM.

## Configure DNS {#dns}

Configure DNS records for the cluster domain.

For cluster nodes, create A records pointing to the internal IP addresses of your VMs:

```text
node1.stackland.internal.  A  10.130.0.11
node2.stackland.internal.  A  10.130.0.12
node3.stackland.internal.  A  10.130.0.13
```

If using the CLI, run this command:

```bash
yc dns zone add-records $DNS_ZONE_NAME \
  --record "node1 300 A 10.130.0.11" \
  --record "node2 300 A 10.130.0.12" \
  --record "node3 300 A 10.130.0.13"
```

Prepare records for system endpoints:

* `api.sys.$baseDomain`: For the address of the network load balancer you use to access the Kubernetes API, or for internal IP addresses of the `combined` or `control-plane` nodes.
* `*.sys.$baseDomain`: For the address you are going to assign to the network load balancer after installation.

If the address of the network load balancer is not known in advance, create or update a wildcard record after you complete the installation and create {{ network-load-balancer-name }}.

Prior to the installation, create a record for the Kubernetes API:

```bash
yc dns zone add-records $DNS_ZONE_NAME \
  --record "api.sys 300 A 10.130.0.11" \
  --record "api.sys 300 A 10.130.0.12" \
  --record "api.sys 300 A 10.130.0.13"
```

After the installation, get the external IP address of your {{ network-load-balancer-name }} and add a wildcard record:

```bash
INGRESS_IP=$(kubectl get svc -n stackland-ingress ingress-controller -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

yc dns zone add-records $DNS_ZONE_NAME \
  --record "*.sys 300 A $INGRESS_IP"
```

## Prepare the {{ stackland-name }} configuration {#prepare-config}

Create a folder named `config/` on the bastion host and save the cluster configuration files in it.

{% note info "Note" %}

Do not specify `ipPools` for the `yandex-nlb` load balancer. {{ network-load-balancer-name }} does not support this parameter.

{% endnote %}

Cluster configuration example:

```yaml
apiVersion: v1alpha1
kind: StacklandClusterConfig
metadata:
  name: main
spec:
  platform:
    type: yandexcloud
    loadBalancer:
      type: yandex-nlb

  cluster:
    baseDomain: stackland.internal

    networking:
      hostsNetwork:
        - cidr: 10.130.0.0/24
      clusterNetwork:
        - cidr: 172.16.0.0/16
      servicesNetwork:
        - cidr: 10.96.0.0/12

    storage:
      defaultStorageClass: stackland-other

  genericHostConfig:
    disksConfig:
      - installDisk:
          name: /dev/vda
      - dataDisk:
          name: /dev/vdb
    networkConfig:
      routes:
        - to: 0.0.0.0/0
          via: 10.130.0.1
          iface: eth0
      resolvers:
        - 10.130.0.2
      timeservers:
        - 10.130.0.2
```

In {{ compute-name }}, VM network disks are displayed as VirtIO devices. {{ stackland-name }} treats such disks as the `stackland-other` storage class; therefore, specify `defaultStorageClass: stackland-other` for this scenario.

If you specify `stackland-ssd`, persistent volumes for system components may remain `Pending`, and you will get the `did not have enough free storage` message in pod events.

Host configuration example:

```yaml
apiVersion: v1alpha1
kind: StacklandHostsList
metadata:
  name: main
spec:
  hosts:
    - hostname: node1.stackland.internal
      role: combined
      networkConfig:
        interfaces:
          - macaddress: d0:0d:20:97:18:17
            name: eth0
        addresses:
          - interface: eth0
            ip: 10.130.0.11/24

    - hostname: node2.stackland.internal
      role: combined
      networkConfig:
        interfaces:
          - macaddress: d0:0d:1f:a3:b5:05
            name: eth0
        addresses:
          - interface: eth0
            ip: 10.130.0.12/24

    - hostname: node3.stackland.internal
      role: combined
      networkConfig:
        interfaces:
          - macaddress: d0:0d:1a:c5:b7:a5
            name: eth0
        addresses:
          - interface: eth0
            ip: 10.130.0.13/24
```

Replace the IP addresses, MAC addresses, DNS servers, NTP servers, and host names with what is relevant for your infrastructure.

## Download `sladm` {#download-sladm}

On the bastion host, download and unzip `sladm`:

```bash
wget https://storage.yandexcloud.net/stackland-public/stackland/$VERSION/sladm-$VERSION-linux-amd64.zip
unzip sladm-$VERSION-linux-amd64.zip
chmod +x sladm
```

## Prepare secrets {#prepare-secrets}

Generate a `StacklandSecretsConfig` resource:

```bash
./sladm secrets add --out config/secrets.yaml --license-key key.json
```

Where `key.json` is the file with the {{ stackland-name }} license key.

## Install the cluster {#install}

Prior to installing, check the configuration:

```bash
./sladm validate --config config/
```

Run the installation:

```bash
./sladm install --config config/ --installation-timeout 2h 2>&1 | tee install-$(date +%y%m%d-%H%M).log
```

The installation takes approximately one hour. Save the installation log until the check is over: it contains messages about transitions of nodes and components between statuses; and after the installation is successfully completed, it will show the management console address and admin login and password.

{% note warning "Warning" %}

The installation log contains the admin password. Do not publish the log or disclose it to third parties.

{% endnote %}

If the installation was not over within the allocated time or threw an error, refer to [Troubleshooting](#troubleshooting).

## Check the installation {#check-installation}

After the installation is complete, the following message should appear in the `sladm` log:

```text
✓ Your Stackland cluster is ready
```

`sladm` will also display the management console address and the default login and password.

Check the status of the installation manually on the bastion host.

If `sladm` has not copied kubeconfig to the user’s home directory yet, specify the kubeconfig file explicitly:

```bash
export KUBECONFIG=./_out/kubeconfig
```

1. Make sure the Kubernetes API is available and all nodes are `Ready`:

   ```bash
   kubectl get nodes -o wide
   ```

1. Check whether the initial installation of the platform is completed:

   ```bash
   kubectl get platformconfig main -o jsonpath='{.status.initialInstall.state}{"\n"}'
   ```

   Expected value:

   ```text
   Installed
   ```

1. Check the status of components:

   ```bash
   kubectl get componentinstallations -o wide
   ```

   All components should be `Ready`.

1. Make sure there are no frozen PVCs and PVCs with an incorrect storage class:

   ```bash
   kubectl get pvc -A
   kubectl get pvc -A | grep -E 'Pending|Lost|stackland-ssd' || true
   ```

   For this scenario, system component PVCs should use `stackland-other`.

1. Make sure there are no pods with errors:

   ```bash
   kubectl get pod -A --field-selector=status.phase!=Succeeded | grep -E 'Pending|Error|CrashLoop|Init|0/|ContainerCreating' || true
   ```

   If the command outputs pods, check their events and logs:

   ```bash
   kubectl describe pod <pod_name> -n <namespace>
   kubectl logs <pod_name> -n <namespace> --previous --tail=100
   ```

1. Check system ingress resources:

   ```bash
   kubectl get ingress -A
   kubectl get svc -n stackland-ingress ingress-controller -o wide
   ```

   In the `ADDRESS` field, ingress resources must have the {{ network-load-balancer-name }} external IP address specified.

Make sure that system endpoints are available:

* `https://console.sys.$baseDomain`: Cluster management console.
* `https://dashboard.sys.$baseDomain`: Cluster dashboard.
* `https://grafana.sys.$baseDomain`: Cluster charts in Grafana.
* `https://prometheus.sys.$baseDomain`: Cluster metrics in Prometheus.
* `https://alertmanager.sys.$baseDomain`: Cluster alerts in Alertmanager.

If the `*.sys.$baseDomain` wildcard record does not point at the {{ network-load-balancer-name }} address yet, get the address of the load balancer you created and update the DNS record.

For example:

```bash
INGRESS_IP=$(kubectl get svc -n stackland-ingress ingress-controller -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

yc dns zone add-records $DNS_ZONE_NAME \
  --record "*.sys 300 A $INGRESS_IP"
```

If you are testing access from a workstation without using a public DNS zone, add these records to the `hosts` file on your computer:

```text
<load_balancer_ip> console.sys.stackland.internal auth.sys.stackland.internal kubeconfig.sys.stackland.internal grafana.sys.stackland.internal docs.sys.stackland.internal
```

{% note info "Note" %}

If you open the {{ network-load-balancer-name }} IP address directly in your browser, the ingress will return `default backend - 404`. This is the expected behavior: routing is done based on host name. Open the console at `https://console.sys.$baseDomain`.

{% endnote %}

Test access to the management console:

```bash
curl -I --max-time 10 -H "Host: console.sys.$BASE_DOMAIN" http://$INGRESS_IP
curl -kI --max-time 10 \
  --resolve console.sys.$BASE_DOMAIN:443:$INGRESS_IP \
  https://console.sys.$BASE_DOMAIN
```

Expected result:

* HTTP request returns a redirect to HTTPS.
* HTTPS request returns a redirect to the login page or the login page itself with code `200`.

Check the status of your load balancer’s target group:

```bash
yc load-balancer network-load-balancer list
yc load-balancer target-group list
yc load-balancer network-load-balancer target-states <load_balancer_name_or_id> \
  --target-group-id <target_group_id>
```

All nodes should now turn `HEALTHY`.

If the nodes remain `UNHEALTHY`, make sure the ingress NodePort is reachable from the bastion host:

```bash
INGRESS_HTTP_NODEPORT=$(kubectl get svc -n stackland-ingress ingress-controller -o jsonpath='{.spec.ports[?(@.port==80)].nodePort}')

for ip in <node_1_ip> <node_2_ip> <node_3_ip>; do
  timeout 3 bash -c "</dev/tcp/$ip/$INGRESS_HTTP_NODEPORT" && \
    echo "$ip:$INGRESS_HTTP_NODEPORT open" || \
    echo "$ip:$INGRESS_HTTP_NODEPORT closed"
done
```

If the NodePort is reachable from the subnet, but the target group remains `UNHEALTHY`, check:

* Security group rules for incoming traffic from {{ network-load-balancer-name }} to NodePorts of your nodes.
* Network ACLs, routes, and NAT rules that can affect the return traffic from nodes to {{ network-load-balancer-name }} health checks.
* That the internal IP addresses of all nodes are specified in the target group.
* That the `stackland-ingress/ingress-controller` service uses the same NodePorts as {{ network-load-balancer-name }}.

To additionally test the ingress from the subnet, run this command on the bastion host:

```bash
curl -I --max-time 10 -H "Host: console.sys.$BASE_DOMAIN" \
  http://<any_node_ip>:$INGRESS_HTTP_NODEPORT
```

Expected response: HTTP redirect to HTTPS or login page.

## Troubleshooting {#troubleshooting}

This section covers issues that are common when installing {{ stackland-name }} on VMs in {{ yandex-cloud }}. For common installation issues, refer to [Diagnostics and troubleshooting](../operations/troubleshooting.md).

### `yandexcloud-lb` restarts with a metadata service error {#yandexcloud-lb-metadata}

If the installation stops at the `load-balancer` or `ingress` component, check the pods of the load balancer component:

```bash
kubectl get pod -n stackland-load-balancer
kubectl logs -n stackland-load-balancer deploy/yandexcloud-lb --tail=100
```

If the logs contain the `failed to get cluster name from metadata: metadata service returned status 404` error, make sure all cluster VMs have the `cluster-name` label matching `metadata.name` in the `StacklandClusterConfig` resource:

```bash
yc compute instance add-labels node1 --labels cluster-name=$CLUSTER_NAME
yc compute instance add-labels node2 --labels cluster-name=$CLUSTER_NAME
yc compute instance add-labels node3 --labels cluster-name=$CLUSTER_NAME
```

Once the label is added, restart the `yandexcloud-lb` pod:

```bash
kubectl delete pod -n stackland-load-balancer -l app.kubernetes.io/name=yandexcloud-lb
```

### PVCs remain `Pending` {#pending-pvc}

If the installation stops at the `iam`, `logging`, or `storage` component, and pod events contain the `did not have enough free storage` message, check the storage class and TopoLVM capacity:

```bash
kubectl get nodes -o custom-columns=NAME:.metadata.name,OTHER:.status.capacity.capacity\.topolvm\.io/stackland-other,SSD:.status.capacity.capacity\.topolvm\.io/stackland-ssd
kubectl get pvc -A
```

For {{ compute-name }} VMs, the capacity should be available at `capacity.topolvm.io/stackland-other`. The installation configuration must contain the following parameter:

```yaml
storage:
  defaultStorageClass: stackland-other
```

If PVCs have already been created with `stackland-ssd`, change the configuration and restart the installation. On a test bench without user data, you can delete only those PVCs that are `Pending` for operators to recreate them with correct storage class.

## See also {#see-also}

* [Installation guide](../quickstart.md)
* [Installing {{ stackland-name }} on {{ baremetal-full-name }}](install-on-yc-bms.md)
* [Diagnostics and troubleshooting](../operations/troubleshooting.md)
