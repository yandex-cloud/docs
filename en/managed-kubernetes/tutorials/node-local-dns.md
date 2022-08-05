# Setting up NodeLocal DNS Cache

To reduce the number of DNS queries to a [{{ k8s }} cluster](../concepts/index.md#kubernetes-cluster), enable NodeLocal DNS Cache. The feature is available in {{ k8s }} clusters version {% if product == "cloud-il" %}1.18{% endif %}{% if product == "yandex-cloud" %}1.19{% endif %} and higher.

{% note tip %}

If a cluster is made up of over 50 nodes, use [automatic DNS scaling](dns-autoscaler.md).

{% endnote %}

By default, [pods](../concepts/index.md#pod) send queries to the `kube-dns` [service](../concepts/service.md). The `nameserver` field in the `/etc/resolv.conf` file is set to the `ClusterIp` value of the `kube-dns` [service](../concepts/service.md). A connection to the `ClusterIP` is established using [iptables]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Iptables){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Iptables){% endif %} or [IP Virtual Server](https://en.wikipedia.org/wiki/IP_Virtual_Server).

When NodeLocal DNS Cache is enabled, a [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) is deployed in a cluster. The caching agent is run on each node (under `node-local-dns`). User pods now send queries to the agent running on their nodes.

If a query is in the agent cache, it returns a direct response. Otherwise, a TCP connection to the `kube-dns` `ClusterIP` is established. By default, the caching agent makes cache-miss requests to `kube-dns` for the `cluster.local` cluster zone.

This helps avoid the DNAT rules, [connection tracking](https://github.com/kubernetes/enhancements/blob/master/keps/sig-network/1024-nodelocal-cache-dns/README.md#motivation), and restrictions on the [number of connections](../../vpc/concepts/limits.md#vpc-limits). For more information about NodeLocal DNS Cache, see the [documentation](https://github.com/kubernetes/enhancements/blob/master/keps/sig-network/1024-nodelocal-cache-dns/README.md).

To set up DNS query caching, follow these steps:

## Prepare the environment {#prepare}

1. Create resources.

   For this use case, you'll need a [cloud network, subnet](../../vpc/concepts/network.md) and [service account](../../iam/concepts/index.md#sa). You can use existing resources or create new ones.

   {% cut "How to create resources" %}

   1. Create a [cloud network](../../vpc/operations/network-create.md).
   1. In the cloud network, create a [subnet](../../vpc/operations/subnet-create.md).
   1. Create a [service account](../../iam/operations/sa/create.md) with the `editor` role.

   {% endcut %}

1. Create a {{ k8s }} cluster and a group of nodes.

   You can use an existing cluster and a group of {{ k8s }} nodes or create new ones. Make sure that the **{{ k8s }} version** field is set to version {% if product == "cloud-il" %}1.18{% endif %}{% if product == "yandex-cloud" %}1.19{% endif %} or higher.

   {% cut "How to create a {{ k8s }} cluster and a group of nodes" %}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Create a {{ k8s }} cluster:

   ```bash
   yc managed-kubernetes cluster create \
     --name node-local-dns \
     --service-account-name <service account name> \
     --node-service-account-name <service account name> \
     --public-ip \
     --zone {{ region-id }}-a \
     --network-name <cloud network name>
   ```

   Result:

   ```text
   done (7m21s)
   ...
   ```

   Create a node group:

   ```bash
   yc managed-kubernetes node-group create \
     --name node-group \
     --cluster-name node-local-dns \
     --location zone={{ region-id }}-a \
     --network-interface subnets=<subnet or node group name>,ipv4-address=nat \
     --fixed-size 3
   ```

   Result:

   ```text
   done (2m43s)
   ...
   ```

   {% endcut %}

1. Configure kubectl.

   To run commands for a {{ k8s }} cluster, install and configure the kubectl management console.

   {% cut "How to configure kubectl" %}

   Install the {{ k8s }} CLI [kubectl]{% if lang == "ru" %}(https://kubernetes.io/ru/docs/tasks/tools/install-kubectl/){% endif %}{% if lang == "en" %}(https://kubernetes.io/docs/tasks/tools/install-kubectl/){% endif %}.

   Add the {{ k8s }} cluster credentials to the kubectl configuration file:

   ```bash
   yc managed-kubernetes cluster get-credentials --external --name node-local-dns
   ```

   Result:

   ```text
   Context 'node-local-dns' was added as default to kubeconfig '/home/<your home folder>/.kube/config'.
   ...
   ```

   {% endcut %}

## Set up a DaemonSet {#daemonset}

### Download a specification template {#download-spec}

You can download the [specification template](https://{{ s3-storage-host }}/doc-files/nodelocaldns.yaml) manually or using the command:

{% list tabs %}

- Windows (PowerShell)

  ```
  wget "https://{{ s3-storage-host }}/doc-files/nodelocaldns.yaml" -OutFile "nodelocaldns.yaml"
  ```

- Linux

  ```bash
  wget https://{{ s3-storage-host }}/doc-files/nodelocaldns.yaml
  ```

- macOS

  ```bash
  brew install wget

  wget https://{{ s3-storage-host }}/doc-files/nodelocaldns.yaml
  ```

{% endlist %}

### Replace variables in the template {#variables}

The template contains the NodeLocal DNS Cache configuration. To change the configuration to suit your needs, use the following five variables:
* `__PILLAR__DNS__DOMAIN__`
  {{ k8s }} cluster zone (`cluster.local` by default).
* `__PILLAR__LOCAL__DNS__`
  Address `link-local` that NodeLocal DNS Cache will listen on. We recommend using an address within the 169.254.0.0/16 range for IPv4 or fd00::/8 for IPv6.
* `__PILLAR__DNS__SERVER__`
  Address `ClusterIp` [of the service](../concepts/service.md) `kube-dns`. Queries from user pods at this IP address will also be forwarded to NodeLocal DNS Cache using the iptables rules.
* `__PILLAR__CLUSTER__DNS__`
  Upstream server for requests within the cluster zone. When starting NodeLocal DNS Cache, a new service `kube-dns-upstream` with `ClusterIP` is created. You can use this IP address to access `kube-dns` bypassing the caching agent. This variable must be filled in automatically.
* `__PILLAR__UPSTREAM__SERVERS__`
  Upstream servers for requests outside the cluster zone. The variable should be filled in automatically from `configmap` of `kube-dns`.

Set the following values:
* `__PILLAR__DNS__DOMAIN__`: `cluster.local`.
* `__PILLAR__LOCAL__DNS__`: `169.254.20.10`.
* `__PILLAR__DNS__SERVER__`: `ClusterIp` of `kube-dns`.

To do this, perform automatic replacement in any text editor or using the command line:

{% list tabs %}

- Windows (PowerShell)

  ```
  $domain="cluster.local"
  $localdns="169.254.20.10"
  $kubedns=(kubectl get svc kube-dns -n kube-system -o jsonpath="{.spec.clusterIP}")

  ((Get-Content -path nodelocaldns.yaml -Raw) -replace '__PILLAR__LOCAL__DNS__',$localdns) | Set-Content -Path nodelocaldns.yaml
  ((Get-Content -path nodelocaldns.yaml -Raw) -replace '__PILLAR__DNS__DOMAIN__',$domain) | Set-Content -Path nodelocaldns.yaml
  ((Get-Content -path nodelocaldns.yaml -Raw) -replace '__PILLAR__DNS__SERVER__',$kubedns) | Set-Content -Path nodelocaldns.yaml
  ```

- Linux

  ```bash
  domain=cluster.local
  localdns=169.254.20.10
  kubedns=$(kubectl get svc kube-dns -n kube-system -o jsonpath={.spec.clusterIP})

  sed -i "s/__PILLAR__LOCAL__DNS__/$localdns/g; s/__PILLAR__DNS__DOMAIN__/$domain/g; s/__PILLAR__DNS__SERVER__/$kubedns/g" nodelocaldns.yaml
  ```

- macOS

  ```bash
  brew install gnu-sed

  domain=cluster.local
  localdns=169.254.20.10
  kubedns=$(kubectl get svc kube-dns -n kube-system -o jsonpath={.spec.clusterIP})

  gsed -i "s/__PILLAR__LOCAL__DNS__/$localdns/g; s/__PILLAR__DNS__DOMAIN__/$domain/g; s/__PILLAR__DNS__SERVER__/$kubedns/g" nodelocaldns.yaml
  ```

{% endlist %}

### Run NodeLocal DNS Cache {#startup}

To run NodeLocal DNS Cache, use the command:

```bash
kubectl create -f nodelocaldns.yaml
```

Result:

```text
serviceaccount/node-local-dns created
service/kube-dns-upstream created
configmap/node-local-dns created
daemonset.apps/node-local-dns created
service/node-local-dns created
```

To make sure that the [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) is deployed successfully, run the command:

```bash
kubectl get ds -l k8s-app=node-local-dns -n kube-system
```

Result:

```text
NAME            DESIRED  CURRENT  READY  UP-TO-DATE  AVAILABLE  NODE SELECTOR  AGE
node-local-dns  3        3        3      3           3          <none>         24m
```

### Change the NodeLocal DNS Cache configuration {#configure}

To change the configuration, edit the appropriate `configmap`. For example, to enable DNS query logs for the `cluster.local` zone, follow these steps:

1. Run the command:

   ```bash
   kubectl -n kube-system edit configmap node-local-dns
   ```

1. Add the `log` line to the `cluster.local` zone configuration:

   ```text
   ...
   apiVersion: v1
   data:
   Corefile: |
   cluster.local:53 {
     log
     errors
     cache {
       success 9984 30
       denial 9984 5
     }
   ...
   ```

1. Save the changes.

   Result:

   ```text
   configmap/node-local-dns edited
   ```

It may take several minutes to update the configuration.

### Run DNS queries {#dns-queries}

To run [test queries](https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/#create-a-simple-pod-to-use-as-a-test-environment), use the pod with the DNS diagnostic utilities.

1. Run the pod:

   ```bash
   kubectl apply -f https://k8s.io/examples/admin/dns/dnsutils.yaml
   ```

   Result:

   ```text
   pod/dnsutils created
   ```

1. Check that the pod's status is `Running`:

   ```bash
   kubectl get pods dnsutils
   ```

   Result:

   ```text
   NAME      READY  STATUS   RESTARTS  AGE
   dnsutils  1/1    Running  0         26m
   ```

1. Connect to the pod and run queries:

   ```text
   kubectl exec -i -t dnsutils -- sh

   # dig +short @169.254.20.10 www.com
   # dig +short @<ClusterIp of kube-dns> example.com
   # nslookup kubernetes.default
   ```

   After `node-local-dns` is run, the iptables rules are set up so that the [local DNS](https://github.com/kubernetes/enhancements/blob/master/keps/sig-network/1024-nodelocal-cache-dns/README.md#iptables-notrack) responds at both addresses (`<ClusterIp of kube-dns>:53` and `169.254.20.10:53`).

   The `kube-dns` service can be accessed at the new address, that is, the `ClusterIp` of `kube-dns-upstream`. You may need this IP address to set up query forwarding.

   Result:

   ```text
   # dig +short @169.254.20.10 www.com
   52.128.23.153
   # dig +short @<ClusterIp of kube-dns> example.com
   93.184.216.34
   # nslookup kubernetes.default
   Server:  10.96.128.2
   Address:  10.96.128.2#53

   Name:  kubernetes.default.svc.cluster.local
   Address: 10.96.128.1
   ```
   
   Here, `10.96.128.2` is the `ClusterIp` of `kube-dns`.

### Check logs {#check-logs}

To check logs, run the command:

```bash
kubectl logs --namespace=kube-system -l k8s-app=node-local-dns -f
```

To stop displaying a log, press **Ctrl** + **C**.

Result:

```text
...
[INFO] 10.112.128.7:50527 - 41658 "A IN kubernetes.default.svc.cluster.local. udp 54 false 512" NOERROR qr,aa,rd 106 0.000097538s
[INFO] 10.112.128.7:44256 - 26847 "AAAA IN kubernetes.default.svc.cluster.local. udp 54 false 512" NOERROR qr,aa,rd 147 0.057075876s
...
```

### Stop the DaemonSet {#stop-daemonset}

To disable the DaemonSet of NodeLocal DNS Cache, run:

```bash
kubectl delete -f nodelocaldns.yaml
```

Result:

```text
serviceaccount "node-local-dns" deleted
service "kube-dns-upstream" deleted
configmap "node-local-dns" deleted
daemonset.apps "node-local-dns" deleted
service "node-local-dns" deleted
```
