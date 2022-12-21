# Setting up NodeLocal DNS Cache

To reduce the number of DNS queries to a [{{ k8s }} cluster](../concepts/index.md#kubernetes-cluster), enable NodeLocal DNS Cache. 

{% note tip %}

If a cluster is made up of over 50 nodes, use [automatic DNS scaling](dns-autoscaler.md).

{% endnote %}

By default, [pods](../concepts/index.md#pod) send queries to the `kube-dns` [service](../concepts/service.md). The `nameserver` field in the `/etc/resolv.conf` file is set to the `ClusterIp` value of the `kube-dns` [service](../concepts/service.md). A connection to the `ClusterIP` is established using [iptables](https://en.wikipedia.org/wiki/Iptables) or [IP Virtual Server](https://en.wikipedia.org/wiki/IP_Virtual_Server).

When NodeLocal DNS Cache is enabled, a [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) is deployed in a cluster. The caching agent is run on each node (under `node-local-dns`). User pods now send queries to the agent running on their nodes.

If a query is in the agent cache, it returns a direct response. Otherwise, a TCP connection to the `ClusterIP` `kube-dns` is created. By default, the caching agent makes cache-miss requests to `kube-dns` for the `cluster.local` cluster zone.

This helps avoid the DNAT rules, [connection tracking](https://github.com/kubernetes/enhancements/blob/master/keps/sig-network/1024-nodelocal-cache-dns/README.md#motivation), and restrictions on the [number of connections](../../vpc/concepts/limits.md#vpc-limits). For more information about NodeLocal DNS Cache, see the [documentation](https://github.com/kubernetes/enhancements/blob/master/keps/sig-network/1024-nodelocal-cache-dns/README.md).

To set up DNS query caching, follow these steps:

## Prepare the environment {#prepare}

1. Create resources.

   For this use case, you'll need [a cloud network, subnet](../../vpc/concepts/network.md) and [service account](../../iam/concepts/index.md#sa). You can use existing resources or create new ones.

   {% cut "Creating resources" %}

   1. Create a [cloud network](../../vpc/operations/network-create.md).
   1. In the cloud network, create a [subnet](../../vpc/operations/subnet-create.md).
   1. Create a [service account](../../iam/operations/sa/create.md) with the `editor` role.

   {% endcut %}

1. Create a {{ k8s }} cluster and a group of nodes.

   You can use an existing {{ k8s }} cluster or node group or create new ones. 

   {% cut "Creating a {{ k8s }} cluster and a group of nodes" %}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Create a {{ k8s }} cluster:

   ```bash
   {{ yc-k8s }} cluster create \
     --name node-local-dns \
     --service-account-name <cluster service account name> \
     --node-service-account-name <node group service account name> \
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
   {{ yc-k8s }} node-group create \
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

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Retrieve the service IP address for `kube-dns`:

   ```bash
   kubectl get svc kube-dns -n kube-system -o jsonpath={.spec.clusterIP}
   ```

## Create a specification for NodeLocal DNS and run DaemonSet {#daemonset}

1. Create a file named `node-local-dns.yaml`. In the `node-local-dns` DaemonSet settings, specify the `kube-dns` service IP address:

   `node-local-dns.yaml`

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
           args: [ "-localip", "169.254.20.10,<kube-dns service IP address>", "-conf", "/etc/Corefile", "-upstreamsvc", "kube-dns-upstream" ]
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

1. Run the following queries:

   ```bash
   dig +short @169.254.20.10 www.com
   dig +short @<kube-dns service IP> example.com
   nslookup kubernetes.default
   ```

   After `node-local-dns` launches, the iptables rules will be configured for [local DNS](https://github.com/kubernetes/enhancements/blob/master/keps/sig-network/1024-nodelocal-cache-dns/README.md#iptables-notrack) to respond on both of the addresses (`<kube-dns service IP>:53` and `169.254.20.10:53`).

   The `kube-dns` service can be accessed at the new address, that is, the `ClusterIp` of `kube-dns-upstream`. You may need this address to configure request forwarding.

   Commands and result:

   ```bash
   # dig +short @169.254.20.10 www.com
   52.128.23.153
   # dig +short @<kube-dns service IP> example.com
   93.184.216.34
   # nslookup kubernetes.default
   Server:         10.96.128.2
   Address:        10.96.128.2#53

   Name:   kubernetes.default.svc.cluster.local
   Address: 10.96.128.1
   ```

   Here, `10.96.128.2` is the `kube-dns` service IP.

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
1. [Delete the {{ k8s }} cluster](../operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. If static public IP addresses were used for cluster and node access, release and [delete](../../vpc/operations/address-delete.md) them.