# Configuring NodeLocal DNS for the Cilium network policy controller

This article will show you how to configure a local DNS for the [Cilium network policy controller](../concepts/network-policy.md#cilium) using the [Local Redirect Policy](https://docs.cilium.io/en/v1.9/gettingstarted/local-redirect-policy/).

To set up a local DNS in a {{ k8s }} cluster:
1. [Create specifications for NodeLocal DNS and the Local Redirect Policy](#create-manifests).
1. [Create a test environment](#create-test-environment).
1. [Test NodeLocal DNS](#test-nodelocaldns).

## Before you begin {#before-you-begin}

1. [Create a service account](../../iam/operations/sa/create.md) and [grant it](../../iam/operations/sa/assign-role-for-sa.md) the `k8s.tunnelClusters.agent` and `vpc.publicAdmin` roles.
1. [Create a {{ k8s }} cluster](kubernetes-cluster/kubernetes-cluster-create.md) with the following settings:
   1. A **service account for resources** is a previously created service account with the `k8s.tunnelClusters.agent` and `vpc.publicAdmin` roles.
   1. **Release channel**: `RAPID`.
   1. Under **Cluster network settings**, select **Enable tunnel mode**.
1. [Create a node group](node-group/node-group-create.md) in any suitable configuration.

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Retrieve the service IP address for `kube-dns`:

   ```bash
   kubectl get svc kube-dns -n kube-system -o jsonpath={.spec.clusterIP}
   ```

## Create specifications for NodeLocal DNS and the Local Redirect Policy {#create-manifests}

1. Create a file named `node-local-dns.yaml`. In the `node-local-dns` DaemonSet settings, specify the `kube-dns` service IP address:

   `node-local-dns.yaml`

   ```yaml
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
         bind 0.0.0.0
         forward . __PILLAR__CLUSTER__DNS__ {
           prefer_udp
         }
         prometheus :9253
         health
       }
       in-addr.arpa:53 {
         errors
         cache 30
         reload
         loop
         bind 0.0.0.0
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
         bind 0.0.0.0
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
         bind 0.0.0.0
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
           args: [ "-localip", "169.254.20.10, <kube-dns service IP>", "-conf", "/etc/Corefile", "-upstreamsvc", "kube-dns-upstream", "-skipteardown=true", "-setupinterface=false", "-setupiptables=false" ]
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
   ```

1. Create a file named `node-local-dns-lrp.yaml`:

   {% cut "node-local-dns-lrp.yaml" %}

   ```yaml
   ---
   apiVersion: "cilium.io/v2"
   kind: CiliumLocalRedirectPolicy
   metadata:
     name: "nodelocaldns"
     namespace: kube-system
   spec:
     redirectFrontend:
       serviceMatcher:
         serviceName: kube-dns
         namespace: kube-system
     redirectBackend:
       localEndpointSelector:
         matchLabels:
           k8s-app: node-local-dns
       toPorts:
         - port: "53"
           name: dns
           protocol: UDP
         - port: "53"
           name: dns-tcp
           protocol: TCP
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
   ```

1. Create resources for the Local Redirect Policy:

   ```bash
   kubectl apply -f node-local-dns-lrp.yaml
   ```

   Result:

   ```text
   ciliumlocalredirectpolicy.cilium.io/NodeLocal DNS created
   ```

## Create a test environment {#create-test-environment}

To test the local DNS, a `nettool` [pod](../concepts/index.md#pod) will be launched in your cluster containing the `dnsutils` network utility suite.
1. Launch the `nettool` pod:

   ```bash
   kubectl run nettool --image {{ registry }}/yc/demo/network-multitool -- sleep infinity
   ```

1. Make sure the pod status changed to `Running`:

   ```bash
   kubectl get pods
   ```

1. Find out which {{ k8s }} cluster node is hosting the `nettool` pod:

   ```bash
   kubectl get pod nettool -o wide
   ```

   The name of the node is shown in the `NODE` column as below:

   ```text
   NAME     READY  STATUS   RESTARTS  AGE  IP         NODE        NOMINATED NODE  READINESS GATES
   nettool  1/1    Running  0         23h  10.1.0.68  <node name>  <none>          <none>
   ```

1. Retrieve the IP address of the pod hosting NodeLocal DNS:

   ```bash
   kubectl get pod -o wide -n kube-system | grep 'node-local.*<node name>'
   ```

   Result:

   ```text
   node-local-dns-gv68c  1/1  Running  0  26m  <pod IP address>  <node name>  <none>  <none>
   ```

## Test NodeLocal DNS {#test-nodelocaldns}

To test the local DNS from the `nettool` pod, several DNS requests will be executed. This will change the metrics for the number of DNS requests on the pod servicing NodeLocal DNS.
1. Retrieve the values of the metrics for DNS requests before testing:

   ```bash
   kubectl exec -ti nettool -- curl http://<pod IP address>:9253/metrics | grep coredns_dns_requests_total
   ```

   Result:

   ```text
   # HELP coredns_dns_requests_total Counter of DNS requests made per zone, protocol and family.
   # TYPE coredns_dns_requests_total counter
   coredns_dns_requests_total{family="1",proto="udp",server="dns://0.0.0.0:53",type="other",zone="."} 1
   coredns_dns_requests_total{family="1",proto="udp",server="dns://0.0.0.0:53",type="other",zone="cluster.local."} 1
   coredns_dns_requests_total{family="1",proto="udp",server="dns://0.0.0.0:53",type="other",zone="in-addr.arpa."} 1
   coredns_dns_requests_total{family="1",proto="udp",server="dns://0.0.0.0:53",type="other",zone="ip6.arpa."} 1
   ```

1. Run the DNS requests:

   ```bash
   kubectl exec -ti nettool -- nslookup kubernetes && \
   kubectl exec -ti nettool -- nslookup kubernetes.default && \
   kubectl exec -ti nettool -- nslookup ya.ru
   ```

   Result (IPs may differ):

   ```text
   Name:   kubernetes.default.svc.cluster.local
   Address: 10.2.0.1

   Server:         10.2.0.2
   Address:        10.2.0.2#53

   Name:   kubernetes.default.svc.cluster.local
   Address: 10.2.0.1

   Server:         10.2.0.2
   Address:        10.2.0.2#53

   Non-authoritative answer:
   Name:   ya.ru
   Address: 87.250.250.242
   Name:   ya.ru
   Address: 2a02:6b8::2:242
   ```

1. Make sure that the metric values have increased:

   ```bash
   kubectl exec -ti nettool -- curl http://<pod IP address>:9253/metrics | grep coredns_dns_requests_total
   ```

   Result:

   ```text
   # HELP coredns_dns_requests_total Counter of DNS requests made per zone, protocol and family.
   # TYPE coredns_dns_requests_total counter
   coredns_dns_requests_total{family="1",proto="udp",server="dns://0.0.0.0:53",type="A",zone="."} 3
   coredns_dns_requests_total{family="1",proto="udp",server="dns://0.0.0.0:53",type="A",zone="cluster.local."} 6
   coredns_dns_requests_total{family="1",proto="udp",server="dns://0.0.0.0:53",type="AAAA",zone="."} 1
   coredns_dns_requests_total{family="1",proto="udp",server="dns://0.0.0.0:53",type="AAAA",zone="cluster.local."} 2
   ...
   ```

## Delete the resources you created {#clear-out}

If you no longer need these resources, delete them:
1. [Delete the {{ k8s }} cluster](kubernetes-cluster/kubernetes-cluster-delete.md).
1. If static public IP addresses were used for cluster and node access, release and [delete](../../vpc/operations/address-delete.md) them.