# Setting up NodeLocal DNS Cache

To reduce the number of DNS requests to a [{{ managed-k8s-name }} cluster](../concepts/index.md#kubernetes-cluster), enable NodeLocal DNS Cache.

{% note tip %}

If a {{ managed-k8s-name }} cluster contains more than 50 [nodes](../concepts/index.md#node-group), use [automatic DNS scaling](dns-autoscaler.md).

{% endnote %}

By default, [pods](../concepts/index.md#pod) send requests to the `kube-dns` [service](../concepts/service.md). In `/etc/resolv.conf`, the `nameserver` field is set to `ClusterIp` of the `kube-dns` service. To establish a connection with `ClusterIP`, use [iptables](https://en.wikipedia.org/wiki/Iptables) or [IP Virtual Server](https://en.wikipedia.org/wiki/IP_Virtual_Server).

When NodeLocal DNS Cache is enabled, a [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) is deployed in a {{ managed-k8s-name }} cluster. The caching agent (`node-local-dns` pod) runs on each {{ managed-k8s-name }} node. User pods now send requests to the agent running on their {{ managed-k8s-name }} nodes.

If the request is in the agent's cache, the agent returns a direct response. Otherwise, the system creates a TCP connection to `kube-dns` `ClusterIP`. By default, the caching agent makes cache-miss requests to `kube-dns` for the `cluster.local` [DNS zone](../../dns/concepts/dns-zone.md) of the {{ managed-k8s-name }} cluster.

This helps avoid the DNAT rules, [connection tracking](https://github.com/kubernetes/enhancements/blob/master/keps/sig-network/1024-nodelocal-cache-dns/README.md#motivation), and restrictions on the [number of connections](../../vpc/concepts/limits.md#vpc-limits). For more information about NodeLocal DNS Cache, see the [documentation](https://github.com/kubernetes/enhancements/blob/master/keps/sig-network/1024-nodelocal-cache-dns/README.md).

To set up DNS request caching:

1. [Install NodeLocal DNS](#install).
1. [Change the NodeLocal DNS Cache configuration](#configure).
1. [Run DNS requests](#dns-queries).
1. [Set up traffic routing through NodeLocal DNS](#dns-traffic).
1. [Check logs](#check-logs).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

### Create an infrastructure {#create-infrastructure}

{% list tabs group=instructions %}

- Manually {#manual}

  1. Create a [cloud network](../../vpc/operations/network-create.md) and [subnet](../../vpc/operations/subnet-create.md).
  1. Create a [service account](../../iam/operations/sa/create.md) with the `editor` [role](../../iam/concepts/access-control/roles.md).

  1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

        {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

  1. [Create a {{ managed-k8s-name }} cluster](../operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../operations/node-group/node-group-create.md) with public internet access and the security groups you prepared earlier.

- {{ TF }} {#tf}

  1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
  1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
  1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
  1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

  1. Download the [k8s-node-local-dns.tf](https://github.com/yandex-cloud-examples/yc-mk8s-node-local-dns-cache/blob/main/k8s-node-local-dns.tf) configuration file of the {{ managed-k8s-name }} cluster to the same working directory. The file describes:
     * [Network](../../vpc/concepts/network.md#network).
     * [Subnet](../../vpc/concepts/network.md#subnet).
     * {{ managed-k8s-name }} cluster.
     * [Service account](../../iam/concepts/users/service-accounts.md) required for the {{ managed-k8s-name }} cluster and [node group](../concepts/index.md#node-group).
     * {% include [configure-sg-terraform](../../_includes/managed-kubernetes/security-groups/configure-sg-tf-lvl3.md) %}

        {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

  1. Specify the following in the configuration file:
     * [Folder ID](../../resource-manager/operations/folder/get-id.md).
     * [{{ k8s }} versions](../concepts/release-channels-and-updates.md) for the cluster and {{ managed-k8s-name }} node groups.
     * {{ managed-k8s-name }} cluster CIDR.
     * Name of the {{ managed-k8s-name }} cluster service account.
  1. Check that the {{ TF }} configuration files are correct using this command:

     ```bash
     terraform validate
     ```

     If there are any errors in the configuration files, {{ TF }} will point them out.
  1. Create the required infrastructure:

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Prepare the environment {#prepare-env}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. {% include [Install kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Install NodeLocal DNS {#install}

{% list tabs group=instructions %}


- {{ marketplace-full-name }} {#marketplace}

  Install [NodeLocal DNS](/marketplace/products/yc/node-local-dns) using {{ marketplace-name }} as described in this [guide](../operations/applications/node-local-dns.md#marketplace-install).


- Manually {#manual}

  1. Retrieve the `kube-dns` service [IP address](../../vpc/concepts/address.md):

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

To change configuration, edit the relevant `configmap`. For example, to enable DNS request logging for the `cluster.local` zone:

1. Run this command:

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

1. Save your changes.

   Result:

   ```text
   configmap/node-local-dns edited
   ```

It may take several minutes to update the configuration.

## Run DNS requests {#dns-queries}

To run [test requests](https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/#create-a-simple-pod-to-use-as-a-test-environment), use a pod with the DNS diagnostic utilities.

1. Run the pod:

   ```bash
   kubectl apply -f https://k8s.io/examples/admin/dns/dnsutils.yaml
   ```

   Result:

   ```text
   pod/dnsutils created
   ```

1. Make sure the pod has entered the `Running` state:

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
   Server:         <kube-dns_IP_address>
   Address:        <kube-dns_IP_address>#53

   Name:   kubernetes.default.svc.cluster.local
   Address: 10.96.128.1
   ```

1. Run the following requests:

   ```bash
   dig +short @169.254.20.10 www.com
   dig +short @<kube-dns_IP_address> example.com
   ```

   Result:

   ```text
   # dig +short @169.254.20.10 www.com
   52.128.23.153
   # dig +short @<kube-dns_IP_address> example.com
   93.184.216.34
   ```

   After `node-local-dns` starts, the `iptables` rules will be configured so that the [local DNS](https://github.com/kubernetes/enhancements/blob/master/keps/sig-network/1024-nodelocal-cache-dns/README.md#iptables-notrack) responds at both addresses (`<kube-dns_IP_address>:53` and `169.254.20.10:53`).

   You can access `kube-dns` using `ClusterIp` of the `kube-dns-upstream` service. You may need this address to configure request forwarding.

## Set up traffic routing through NodeLocal DNS {#dns-traffic}

{% list tabs %}

- All pods
  
  1. Create a pod for network traffic setup:

     ```bash
     kubectl apply -f - <<EOF
     apiVersion: v1
     kind: Pod
     metadata:
       name: dnschange
       namespace: default
     spec:
       priorityClassName: system-node-critical
       hostNetwork: true
       dnsPolicy: Default
       hostPID: true
       tolerations:
         - key: "CriticalAddonsOnly"
           operator: "Exists"
         - effect: "NoExecute"
           operator: "Exists"
         - effect: "NoSchedule"
           operator: "Exists"
       containers:
       - name: dnschange
         image: registry.k8s.io/e2e-test-images/jessie-dnsutils:1.3
         tty: true
         stdin: true
         securityContext:
           privileged: true
         command:
           - nsenter
           - --target
           - "1"
           - --mount
           - --uts
           - --ipc
           - --net
           - --pid
           - --
           - sleep
           - "infinity"
         imagePullPolicy: IfNotPresent
       restartPolicy: Always
     EOF
     ```

  1. Connect to the `dnschange` pod you created:

     ```bash
     kubectl exec -it dnschange -- sh
     ```

  1. Open the `/etc/default/kubelet` file in the container to edit it:

     ```bash
     vi /etc/default/kubelet
     ```

  1. In the file, add the `--cluster-dns=169.254.20.10` parameter (NodeLocal DNS cache address) to the `KUBELET_OPTS` variable value:

     ```text
     KUBELET_OPTS="--bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubeconfig.conf --cert-dir=/var/lib/kubelet/pki/   --cloud-provider=external --config=/home/kubernetes/kubelet-config.yaml --kubeconfig=/etc/kubernetes/  kubelet-kubeconfig.conf --resolv-conf=/run/systemd/resolve/resolv.conf --v=2 --cluster-dns=169.254.20.10"
     ```

  1. Save the file and run the `kubelet` restart command:

     ```bash
     systemctl daemon-reload && systemctl restart kubelet
     ```

     Then, exit container mode by running the `exit` command.

  1. Delete the `dnschange` pod:

     ```bash
     kubectl delete pod dnschange
     ```  

  1. To make sure all pods start running through NodeLocal DNS, restart them, e.g., using the command below:

     ```bash
     kubectl get deployments --all-namespaces | \
       tail +2 | \
       awk '{
         cmd=sprintf("kubectl rollout restart deployment -n %s %s", $1, $2) ; 
         system(cmd) 
       }'
     ```

- Selected pods

  1. Run this command:

     ```bash
     kubectl edit deployment <pod_deployment_name>
     ```

  1. In the pod specification, replace the `dnsPolicy: ClusterFirst` setting in the `spec.template.spec` key with the following section:

     ```yaml
       dnsPolicy: "None"
       dnsConfig:
         nameservers:
           - 169.254.20.10
         searches:
           - default.svc.cluster.local
           - svc.cluster.local
           - cluster.local
           - {{ region-id }}.internal
           - internal
           - my.dns.search.suffix
         options:
           - name: ndots
             value: "5"
     ```

{% endlist %}

## Check logs {#check-logs}

Run this command:

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

Delete the resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

- Manually {#manual}

  1. [Delete the {{ managed-k8s-name }} cluster](../operations/kubernetes-cluster/kubernetes-cluster-delete.md).
  1. If static [public IP addresses](../../vpc/concepts/address.md#public-addresses) were used for {{ managed-k8s-name }} cluster and node access, release and [delete](../../vpc/operations/address-delete.md) them.

- {{ TF }} {#tf}

  1. In the command line, go to the directory with the current {{ TF }} configuration file with an infrastructure plan.
  1. Delete the `k8s-node-local-dns.tf` configuration file.
  1. Check that the {{ TF }} configuration files are correct using this command:

     ```bash
     terraform validate
     ```

     If there are any errors in the configuration files, {{ TF }} will point them out.
  
  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     All the resources described in the `k8s-node-local-dns.tf` configuration file will be deleted.

  1. If static [public IP addresses](../../vpc/concepts/address.md#public-addresses) were used for {{ managed-k8s-name }} cluster and node access, release and [delete](../../vpc/operations/address-delete.md) them.

{% endlist %}
