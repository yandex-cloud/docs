NodeLocal DNS is a {{ managed-k8s-name }} cluster system component which acts as a local DNS cache on each node.

NodeLocal DNS is deployed in a cluster as a [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) with `node-local-dns` pods in the `kube-system` namespace. NodeLocal DNS configures [iptables](https://en.wikipedia.org/wiki/Iptables) to redirect pod requests to `kube-dns` to the `node-local-dns` pod on the same node (local cache):
* If there is a valid entry in the cache that has not yet expired, the response is returned without accessing the cluster’s main DNS service.
* If no entry exists in the cache or if the entry has expired, the request goes to the main DNS service, `kube-dns`.

{% note info %}

Redirects of DNS requests to the local cache are transparent to the pods: you do not need to modify the pod’s `/etc/resolv.conf` file and restart it. Disabling NodeLocal DNS does not require these actions as well.

{% endnote %}

Using NodeLocal DNS in a {{ managed-k8s-name }} cluster offers the [following benefits](https://github.com/kubernetes/enhancements/blob/master/keps/sig-network/1024-nodelocal-cache-dns/README.md#motivation):
* Reduced DNS request processing time.
* Reduced internal network traffic to avoid limitations on the [number of connections](../../vpc/concepts/limits.md#vpc-limits).
* Reduced risk of conntrack failure due to fewer UDP requests to the DNS service.
* Improved resilience and scalability of the cluster DNS subsystem.

Follow this guide to install NodeLocal DNS in a {{ managed-k8s-full-name }} cluster and test it using the `dnsutils` package. To do this, follow these steps:

1. [Install NodeLocal DNS](#install).
1. [Create a test environment](#create-test-environment).
1. [Check the NodeLocal DNS functionality](#test-nodelocaldns).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

* {{ managed-k8s-name }} master (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).
* {{ managed-k8s-name }} cluster nodes: Use of computing resources and storage (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Public IP addresses for {{ managed-k8s-name }} cluster nodes (see [{{ vpc-name }} pricing](../../vpc/pricing.md#prices-public-ip)).


## Getting started {#before-you-begin}

### Create your infrastructure {#create-infrastructure}

{% list tabs group=instructions %}

- Manually {#manual}

  1. Create a [cloud network](../../vpc/operations/network-create.md) and [subnet](../../vpc/operations/subnet-create.md).
  1. Create a [service account](../../iam/operations/sa/create.md) with the `k8s.clusters.agent` and `vpc.publicAdmin` [roles](../../iam/concepts/access-control/roles.md).

  1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

      {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

  1. [Create a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and [node group](../../managed-kubernetes/operations/node-group/node-group-create.md) with [public internet access](../../managed-kubernetes/operations/node-group/node-group-update.md#node-internet-access) and preconfigured security groups.

- {{ TF }} {#tf}

  1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
  1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
  1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
  1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}
  1. Download the [k8s-node-local-dns.tf](https://github.com/yandex-cloud-examples/yc-mk8s-node-local-dns-cache/blob/main/k8s-node-local-dns.tf) configuration file of the {{ managed-k8s-name }} cluster to the same working directory. This file describes:

     * [Network](../../vpc/concepts/network.md#network).
     * [Subnet](../../vpc/concepts/network.md#subnet).
     * {{ managed-k8s-name }} cluster.
     * [Service account](../../iam/concepts/users/service-accounts.md) for the {{ managed-k8s-name }} cluster and [node group](../../managed-kubernetes/concepts/index.md#node-group).
     * {% include [configure-sg-terraform](../../_includes/managed-kubernetes/security-groups/configure-sg-tf-lvl3.md) %}

        {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

  1. Specify the following in the configuration file:

     * [Folder ID](../../resource-manager/operations/folder/get-id.md).
     * [{{ k8s }} versions](../../managed-kubernetes/concepts/release-channels-and-updates.md) for the {{ managed-k8s-name }} cluster and node groups.
     * {{ managed-k8s-name }} cluster CIDR.
     * Name of the {{ managed-k8s-name }} cluster service account.

  1. Validate your {{ TF }} configuration files using this command:

     ```bash
     terraform validate
     ```

     {{ TF }} will display any configuration errors detected in your files.

  1. Create the required infrastructure:

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Set up your environment {#prepare-env}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. {% include [Install kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Install NodeLocal DNS {#install}

{% list tabs group=instructions %}

- {{ marketplace-full-name }} {#marketplace}

  Install [NodeLocal DNS](/marketplace/products/yc/node-local-dns) using {{ marketplace-name }} as described in this [guide](../../managed-kubernetes/operations/applications/node-local-dns.md#marketplace-install).

- Manually {#manual}

  1. Get the `kube-dns` service [IP address](../../vpc/concepts/address.md):

      ```bash
      kubectl get svc kube-dns -n kube-system -o jsonpath={.spec.clusterIP}
      ```

  1. Create a file named `node-local-dns.yaml`. In the `node-local-dns` `DaemonSet` settings, specify the `kube-dns` IP address:

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
            bind 169.254.20.10 <kube-dns_IP_address>
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
            bind 169.254.20.10 <kube-dns_IP_address>
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
            bind 169.254.20.10 <kube-dns_IP_address>
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
            bind 169.254.20.10 <kube-dns_IP_address>
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
              image: registry.k8s.io/dns/k8s-dns-node-cache:1.17.0
              resources:
                requests:
                  cpu: 25m
                  memory: 5Mi
              args: [ "-localip", "169.254.20.10,<kube-dns_IP_address>", "-conf", "/etc/Corefile", "-upstreamsvc", "kube-dns-upstream" ]
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
      # Headless Service has no ClusterIP and returns Pod IPs via DNS.
      # Used for Prometheus service discovery of node-local-dns metrics.
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

      {% include [Namespace warning](../../_includes/managed-kubernetes/kube-system-namespace-warning.md) %}

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

  1. Make sure the DaemonSet is successfully deployed and running:

      ```bash
      kubectl get ds -l k8s-app=node-local-dns -n kube-system
      ```

      Result:

      ```text
      NAME            DESIRED  CURRENT  READY  UP-TO-DATE  AVAILABLE  NODE SELECTOR  AGE
      node-local-dns  3        3        3      3           3          <none>         24m
      ```

{% endlist %}

## Create a test environment {#create-test-environment}

To test the local DNS, the `nettool` pod containing the `dnsutils` network utility suite will be launched in your {{ managed-k8s-name }} cluster.

1. Run the `nettool` pod:

   ```bash
   kubectl run nettool --image {{ registry }}/yc/demo/network-multitool -- sleep infinity
   ```

1. Make sure the pod has switched to `Running`:

   ```bash
   kubectl get pods
   ```

1. Find out which {{ managed-k8s-name }} cluster node is hosting the `nettool` pod:

   ```bash
   kubectl get pod nettool -o wide
   ```

   You can find the node name in the `NODE` column, for example:

   ```text
   NAME     READY  STATUS   RESTARTS  AGE  IP         NODE        NOMINATED NODE  READINESS GATES
   nettool  1/1    Running  0         23h  10.1.0.68  <node_name>  <none>          <none>
   ```

1. Get the IP address of the pod running NodeLocal DNS:

   ```bash
   kubectl get pod -o wide -n kube-system | grep 'node-local.*<node_name>'
   ```

   Result:

   ```text
   node-local-dns-gv68c  1/1  Running  0  26m  <pod_IP_address>  <node_name>  <none>  <none>
   ```

## Check the NodeLocal DNS functionality {#test-nodelocaldns}

To test the local DNS, several DNS requests will be made from the `nettool` pod. This will change the metrics for the number of DNS requests on the pod servicing NodeLocal DNS.

1. Get the values of the metrics for DNS requests before testing:

   ```bash
   kubectl exec -ti nettool -- curl http://<pod_IP_address>:9253/metrics | grep coredns_dns_requests_total
   ```

   Result:

   ```text
   # HELP coredns_dns_requests_total Counter of DNS requests made per zone, protocol and family.
   # TYPE coredns_dns_requests_total counter
   coredns_dns_requests_total{family="1",proto="udp",server="dns://10.96.128.2:53",type="A",zone="."} 18
   coredns_dns_requests_total{family="1",proto="udp",server="dns://10.96.128.2:53",type="A",zone="cluster.local."} 18
   coredns_dns_requests_total{family="1",proto="udp",server="dns://10.96.128.2:53",type="AAAA",zone="."} 18
   coredns_dns_requests_total{family="1",proto="udp",server="dns://10.96.128.2:53",type="AAAA",zone="cluster.local."} 18
   coredns_dns_requests_total{family="1",proto="udp",server="dns://169.254.20.10:53",type="other",zone="."} 1
   coredns_dns_requests_total{family="1",proto="udp",server="dns://169.254.20.10:53",type="other",zone="cluster.local."} 1
   coredns_dns_requests_total{family="1",proto="udp",server="dns://169.254.20.10:53",type="other",zone="in-addr.arpa."} 1
   coredns_dns_requests_total{family="1",proto="udp",server="dns://169.254.20.10:53",type="other",zone="ip6.arpa."} 1
   ```

   The result demonstrates that NodeLocal DNS receives DNS requests on two IP addresses:

   * Address matching the `kube-dns` cluster IP. Here, this is `10.96.128.2:53`; the actual value may differ.

     This is the main address. NodeLocal DNS configures [iptables](https://en.wikipedia.org/wiki/Iptables) to redirect requests to `kube-dns` to the `node-local-dns` pod on the same node.

   * NodeLocal DNS local address (`169.254.20.10`).

     This is a fallback address. You can use it to access the `node-local-dns` pod directly.

1. Run these DNS requests:

   ```bash
   kubectl exec -ti nettool -- nslookup kubernetes && \
   kubectl exec -ti nettool -- nslookup kubernetes.default && \
   kubectl exec -ti nettool -- nslookup ya.ru
   ```

   Result (IP addresses may differ):

   ```text
   Server:         10.96.128.2
   Address:        10.96.128.2#53
   
   Name:   kubernetes.default.svc.cluster.local
   Address: 10.96.128.1
   
   Server:         10.96.128.2
   Address:        10.96.128.2#53
   
   Name:   kubernetes.default.svc.cluster.local
   Address: 10.96.128.1
   
   Server:         10.96.128.2
   Address:        10.96.128.2#53
   
   Non-authoritative answer:
   Name:   ya.ru
   Address: 5.255.255.242
   Name:   ya.ru
   Address: 77.88.44.242
   Name:   ya.ru
   Address: 77.88.55.242
   Name:   ya.ru
   Address: 2a02:6b8::2:242
   ```

1. Get the DNS request metric values again:

   ```bash
   kubectl exec -ti nettool -- curl http://<pod_IP_address>:9253/metrics | grep coredns_dns_requests_total
   ```

   Result:

   ```text
   # HELP coredns_dns_requests_total Counter of DNS requests made per zone, protocol and family.
   # TYPE coredns_dns_requests_total counter
   coredns_dns_requests_total{family="1",proto="udp",server="dns://10.96.128.2:53",type="A",zone="."} 27
   coredns_dns_requests_total{family="1",proto="udp",server="dns://10.96.128.2:53",type="A",zone="cluster.local."} 30
   coredns_dns_requests_total{family="1",proto="udp",server="dns://10.96.128.2:53",type="AAAA",zone="."} 25
   coredns_dns_requests_total{family="1",proto="udp",server="dns://10.96.128.2:53",type="AAAA",zone="cluster.local."} 26
   coredns_dns_requests_total{family="1",proto="udp",server="dns://169.254.20.10:53",type="other",zone="."} 1
   coredns_dns_requests_total{family="1",proto="udp",server="dns://169.254.20.10:53",type="other",zone="cluster.local."} 1
   coredns_dns_requests_total{family="1",proto="udp",server="dns://169.254.20.10:53",type="other",zone="in-addr.arpa."} 1
   coredns_dns_requests_total{family="1",proto="udp",server="dns://169.254.20.10:53",type="other",zone="ip6.arpa."} 1
   ```

   The result demonstrates that metric values have increased for the `kube-dns` address but remain unchanged for the NodeLocal DNS local address. This means pods continue to send DNS requests to the `kube-dns` address, which are now handled by NodeLocal DNS.

## Delete NodeLocal DNS {#stop-daemonset}

{% list tabs group=instructions %}

- {{ marketplace-full-name }} {#marketplace}

  Delete the [NodeLocal DNS](/marketplace/products/yc/node-local-dns) application as described in [this guide](../../managed-kubernetes/operations/applications/marketplace.md#delete-apps).

- Manually {#manual}

  Run this command:

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

{% endlist %}

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

1. Delete the resources depending on how you created them:

    {% list tabs group=instructions %}

    - Manually {#manual}

        [Delete the {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).

    - {{ TF }} {#tf}

        {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}

1. If you used static [public IP addresses](../../vpc/concepts/address.md#public-addresses) to access your {{ managed-k8s-name }} cluster or nodes, release and [delete](../../vpc/operations/address-delete.md) them.
