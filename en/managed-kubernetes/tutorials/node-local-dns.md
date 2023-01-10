# Setting up NodeLocal DNS Cache

To reduce the number of DNS queries to a [{{ k8s }} cluster](../concepts/index.md#kubernetes-cluster), enable NodeLocal DNS Cache. {% if product == "cloud-il" %}The feature is available in {{ k8s }} clusters version 1.18 and higher.{% endif %}

{% note tip %}

If a cluster is made up of over 50 nodes, use [automatic DNS scaling](dns-autoscaler.md).

{% endnote %}

By default, [pods](../concepts/index.md#pod) send queries to the `kube-dns` [service](../concepts/service.md). The `nameserver` field in the `/etc/resolv.conf` file is set to the `ClusterIp` value of `kube-dns`. A connection to the `ClusterIP` is established using [iptables]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Iptables){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Iptables){% endif %} or [IP Virtual Server](https://en.wikipedia.org/wiki/IP_Virtual_Server).

When NodeLocal DNS Cache is enabled, a [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) is deployed in a cluster. The caching agent is run on each node (under `node-local-dns`). User pods now send queries to the agent running on their nodes.

If a query is in the agent cache, it returns a direct response. Otherwise, a TCP connection to the `ClusterIP` `kube-dns` is created. By default, the caching agent makes cache-miss requests to `kube-dns` for the `cluster.local` cluster zone.

This helps avoid the DNAT rules, [connection tracking](https://github.com/kubernetes/enhancements/blob/master/keps/sig-network/1024-nodelocal-cache-dns/README.md#motivation), and restrictions on the [number of connections](../../vpc/concepts/limits.md#vpc-limits). For more information about NodeLocal DNS Cache, see the [documentation](https://github.com/kubernetes/enhancements/blob/master/keps/sig-network/1024-nodelocal-cache-dns/README.md).

To set up DNS query caching:
1. [{#T}](#install).
1. [{#T}](#configure).
1. [{#T}](#dns-queries).
1. [{#T}](#check-logs).

## Before you begin {#before-you-begin}

### Create an infrastructure {#create-infrastructure}

{% list tabs %}

- Manually

  1. Create a [cloud network](../../vpc/operations/network-create.md) and [subnet](../../vpc/operations/subnet-create.md).
  1. Create a [service account](../../iam/operations/sa/create.md) with the `editor` role.
  1. [Create a {{ k8s }} cluster](../operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../operations/node-group/node-group-create.md) with the parameters.
     * {{ k8s }} version: {% if product == "cloud-il" %}1.18{% endif %}{% if product == "yandex-cloud" %}1.20{% endif %} or higher.
     * Public access to the internet

- Using {{ TF }}

  1. If you don't have {{ TF }}, [install it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
  1. Download the [k8s-node-local-dns.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/k8s-node-local-dns.tf) cluster configuration file to the same working directory. The file describes:
     * [Network](../../vpc/concepts/network.md#network).
     * [Subnet](../../vpc/concepts/network.md##subnet).
     * [Security group](../../vpc/concepts/security-groups.md) and [rules](../operations/connect/security-groups.md) needed to run the {{ managed-k8s-name }} cluster:
       * Rules for service traffic.
       * Rules for accessing the {{ k8s }} API and managing the cluster with `kubectl` through ports 443 and 6443.
     * {{ managed-k8s-name }} cluster.
     * [Service account](../../iam/concepts/users/service-accounts.md) required to use the cluster and [{{ managed-k8s-name }} node group](../concepts/index.md#node-group).
  1. Specify the following in the configuration file:
     * [Folder ID](../../resource-manager/operations/folder/get-id.md).
     * [{{ k8s }} versions](../concepts/release-channels-and-updates.md) for the cluster and {{ managed-k8s-name }} node groups.
     * {{ managed-k8s-name }} cluster CIDR.
     * Name of the cluster service account.
  1. Run the `terraform init` command in the directory with the configuration files. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
  1. Make sure the {{ TF }} configuration files are correct using the command:

     ```bash
     terraform validate
     ```

     If there are errors in the configuration files, {{ TF }} will point to them.
  1. Create the required infrastructure:

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Prepare the environment {#prepare-env}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. {% include [Install kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Retrieve the service IP address for `kube-dns`:

   ```bash
   kubectl get svc kube-dns -n kube-system -o jsonpath={.spec.clusterIP}
   ```

## Install NodeLocal DNS {#install}

{% list tabs %}

{% if product == "yandex-cloud" %}

- Using {{ marketplace-full-name }}

  Install [NodeLocal DNS](/marketplace/products/yc/node-local-dns) using {{ marketplace-name }} as described in the [instructions](../operations/applications/node-local-dns.md#marketplace-install).

{% endif %}

- Manually

  1. Create a file named `node-local-dns.yaml`. In the `node-local-dns` DaemonSet settings, specify the `kube-dns` service IP address:

     {% cut "node-local-dns.yaml" %}

     ```yaml
     # Copyright 2018 The {{ k8s }} Authors.
     #
     # Licensed under the Apache License, Version 2.0 (the "License");
     # you may not use this file except in compliance with the License.
     # You may obtain a copy of the License at
     #
     #     http://www.apache.org/licenses/LICENSE-2.0
     #
     # Unless required by applicable law or agreed to in writing, software
     # distributed under the License is distributed on an "AS IS" BASIS,
     # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
     # See the License for the specific language governing permissions and
     # limitations under the License.
     # Modified for {{ yandex-cloud }} Usage
     ---
     apiVersion: v1
     kind: ServiceAccount
     metadata:
       name: node-local-dns
       namespace: kube-system
       labels:
     ---
     apiVersion: v1
     kind: Service
     metadata:
       name: kube-dns-upstream
       namespace: kube-system
       labels:
         k8s-app: kube-dns
         kubernetes.io/name: "KubeDNSUpstream"
     spec:
       ports:
       - name: dns
         port: 53
         protocol: UDP
         targetPort: 53
       - name: dns-tcp
         port: 53
         protocol: TCP
         targetPort: 53
       selector:
         k8s-app: kube-dns
     ---
     apiVersion: v1
     kind: ConfigMap
     metadata:
       name: node-local-dns
       namespace: kube-system
       labels:
     data:
       Corefile: |
         cluster.local:53 {
           errors
           cache {
             success 9984 30
             denial 9984 5
           }
           reload
           loop
           bind 169.254.20.10 <kube-dns service IP address>
           forward . __PILLAR__CLUSTER__DNS__ {
             prefer_udp
           }
           prometheus :9253
           health 169.254.20.10:8080
           }
         in-addr.arpa:53 {
           errors
           cache 30
           reload
           loop
           bind 169.254.20.10 <kube-dns service IP address>
           forward . __PILLAR__CLUSTER__DNS__ {
             prefer_udp
           }
           prometheus :9253
           }
         ip6.arpa:53 {
           errors
           cache 30
           reload
           loop
           bind 169.254.20.10 <kube-dns service IP address>
           forward . __PILLAR__CLUSTER__DNS__ {
             prefer_udp
           }
           prometheus :9253
           }
         .:53 {
           errors
           cache 30
           reload
           loop
           bind 169.254.20.10 <kube-dns service IP address>
           forward . __PILLAR__UPSTREAM__SERVERS__ {
             prefer_udp
           }
           prometheus :9253
           }
     ---
     apiVersion: apps/v1
     kind: DaemonSet
     metadata:
       name: node-local-dns
       namespace: kube-system
       labels:
         k8s-app: node-local-dns
     spec:
       updateStrategy:
         rollingUpdate:
           maxUnavailable: 10%
       selector:
         matchLabels:
           k8s-app: node-local-dns
       template:
         metadata:
           labels:
             k8s-app: node-local-dns
           annotations:
             prometheus.io/port: "9253"
             prometheus.io/scrape: "true"
         spec:
           priorityClassName: system-node-critical
           serviceAccountName: node-local-dns
           hostNetwork: true
           dnsPolicy: Default # Don't use cluster DNS.
           tolerations:
           - key: "CriticalAddonsOnly"
             operator: "Exists"
           - effect: "NoExecute"
             operator: "Exists"
           - effect: "NoSchedule"
             operator: "Exists"
           containers:
           - name: node-cache
             image: k8s.gcr.io/dns/k8s-dns-node-cache:1.17.0
             resources:
               requests:
                 cpu: 25m
                 memory: 5Mi
             args: [ "-localip", "169.254.20.10,<IP-address of kube-dns service>", "-conf", "/etc/Corefile", "-upstreamsvc", "kube-dns-upstream" ]
             securityContext:
               privileged: true
             ports:
             - containerPort: 53
               name: dns
               protocol: UDP
             - containerPort: 53
               name: dns-tcp
               protocol: TCP
             - containerPort: 9253
               name: metrics
               protocol: TCP
             livenessProbe:
               httpGet:
                 host: 169.254.20.10
                 path: /health
                 port: 8080
               initialDelaySeconds: 60
               timeoutSeconds: 5
             volumeMounts:
             - mountPath: /run/xtables.lock
               name: xtables-lock
               readOnly: false
             - name: config-volume
               mountPath: /etc/coredns
             - name: kube-dns-config
               mountPath: /etc/kube-dns
           volumes:
           - name: xtables-lock
             hostPath:
               path: /run/xtables.lock
               type: FileOrCreate
           - name: kube-dns-config
             configMap:
               name: kube-dns
               optional: true
           - name: config-volume
             configMap:
               name: node-local-dns
               items:
                 - key: Corefile
                   path: Corefile.base
     ---
     # A headless service is a service with a service IP but instead of load-balancing it will return the IPs of our associated Pods.
     # We use this to expose metrics to Prometheus.
     apiVersion: v1
     kind: Service
     metadata:
       annotations:
         prometheus.io/port: "9253"
         prometheus.io/scrape: "true"
       labels:
         k8s-app: node-local-dns
       name: node-local-dns
       namespace: kube-system
     spec:
       clusterIP: None
       ports:
         - name: metrics
           port: 9253
           targetPort: 9253
       selector:
         k8s-app: node-local-dns
     ```

     {% endcut %}

  1. Create resources for NodeLocal DNS:

     ```bash
     kubectl apply -f node-local-dns.yaml
     ```

     Result:

     ```text
     serviceaccount/node-local-dns created
     service/kube-dns-upstream created
     configmap/node-local-dns created
     daemonset.apps/node-local-dns created
     service/node-local-dns created
     ```

  1. Make sure that DaemonSet is successfully deployed and running:

     ```bash
     kubectl get ds -l k8s-app=node-local-dns -n kube-system
     ```

     Result:

     ```text
     NAME            DESIRED  CURRENT  READY  UP-TO-DATE  AVAILABLE  NODE SELECTOR  AGE
     node-local-dns  3        3        3      3           3          <none>         24m
     ```

{% endlist %}

## Change the NodeLocal DNS Cache configuration {#configure}

To change the configuration, edit the appropriate `configmap`. For instance, to enable DNS request logging for the `cluster.local` zone.
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

## Run DNS queries {#dns-queries}

To run [test queries](https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/#create-a-simple-pod-to-use-as-a-test-environment), use the pod with the DNS diagnostic utilities.
1. Run the pod:

   ```bash
   kubectl apply -f https://k8s.io/examples/admin/dns/dnsutils.yaml
   ```

   Result:

   ```text
   pod/dnsutils created
   ```

1. Make sure the pod status changed to `Running`:

   ```bash
   kubectl get pods dnsutils
   ```

   Result:

   ```text
   NAME      READY  STATUS   RESTARTS  AGE
   dnsutils  1/1    Running  0         26m
   ```

1. Connect to a pod:

   ```bash
   kubectl exec -i -t dnsutils -- sh
   ```

1. Get the IP address of the local DNS cache:

   ```bash
   nslookup kubernetes.default
   ```

   Result:

   ```text
   Server:         <kube-dns IP>
   Address:        <kube-dns IP>#53

   Name:   kubernetes.default.svc.cluster.local
   Address: 10.96.128.1
   ```

1. Run the following queries:

   ```bash
   dig +short @169.254.20.10 www.com
   dig +short @<kube-dns IP> example.com
   ```

   Result:

   ```text
   # dig +short @169.254.20.10 www.com
   52.128.23.153
   # dig +short @<kube-dns IP> example.com
   93.184.216.34
   ```

   After `node-local-dns` launches, the iptables rules will be configured for [local DNS](https://github.com/kubernetes/enhancements/blob/master/keps/sig-network/1024-nodelocal-cache-dns/README.md#iptables-notrack) to respond on both of the addresses (`<kube-dns service IP>:53` and `169.254.20.10:53`).

   The `kube-dns` service can be accessed at the new address, that is, the `ClusterIp` of `kube-dns-upstream`. You may need this address to configure request forwarding.

## Check logs {#check-logs}

Run the command:

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

## Stop the DaemonSet {#stop-daemonset}

To disable DaemonSet in NodeLocal DNS Cache, run:

```bash
kubectl delete -f node-local-dns.yaml
```

Result:

```text
serviceaccount "node-local-dns" deleted
service "kube-dns-upstream" deleted
configmap "node-local-dns" deleted
daemonset.apps "node-local-dns" deleted
service "node-local-dns" deleted
```

## Delete the resources you created {#clear-out}

If you no longer need these resources, delete them:
1. [Delete a {{ k8s }} cluster](../operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. Delete the {{ managed-k8s-name }} cluster.

   {% list tabs %}

   - Manually

     [Delete the {{ managed-k8s-name }} cluster](../operations/kubernetes-cluster/kubernetes-cluster-delete.md).

   - Using {{ TF }}

     1. In the command line, go to the directory with the current {{ TF }} configuration file with an infrastructure plan.
     1. Delete the `k8s-node-local-dns.tf` configuration file.
     1. Make sure the {{ TF }} configuration files are correct using the command:

        ```bash
        terraform validate
        ```

        If there are errors in the configuration files, {{ TF }} will point to them.
     1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        All the resources described in the `k8s-node-local-dns.tf` configuration file will be deleted.

   {% endlist %}

1. If static public IP addresses were used for cluster and node access, release and [delete](../../vpc/operations/address-delete.md) them.