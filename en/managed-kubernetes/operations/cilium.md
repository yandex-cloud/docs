# Configuring the Cilium network policy controller

This scenario shows the [implementation of L3/L4 and L7 network policies](https://docs.cilium.io/en/v1.10/gettingstarted/http/) that are managed by the [Cilium network policy controller](../concepts/network-policy.md#cilium).

To use the Cilium network policy controller in a cluster:
* [Install and configure Hubble UI, a network activity monitoring tool](#install-hubble-ui).
* [Create a test environment](#create-test-environment).
* [Create an L3/L4 network policy](#l3-l4-policy).
* [Create an L7 network policy](#l7-policy).

## Getting started {#before-you-begin}

### Prepare the infrastructure {#deploy-infrastructure}

{% list tabs group=instructions %}

- Manually {#manual}

   1. [Create a service account](../../iam/operations/sa/create.md) and [grant](../../iam/operations/sa/assign-role-for-sa.md) the `k8s.tunnelClusters.agent` and `vpc.publicAdmin` roles to it.

   1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

      {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

   1. [Create a cluster](kubernetes-cluster/kubernetes-cluster-create.md) with any suitable configuration.

      * In the **{{ ui-key.yacloud.k8s.clusters.create.field_service-account }}** and **{{ ui-key.yacloud.k8s.clusters.create.field_node-service-account }}** fields, select `{{ ui-key.yacloud.component.service-account-field.label_sg-from-list }}`, then select the service account you created from the drop-down list.

      * Under **{{ ui-key.yacloud.k8s.clusters.create.section_main-cluster }}**, select the following values:

         * **{{ ui-key.yacloud.k8s.clusters.create.field_address-type }}**: `{{ ui-key.yacloud.k8s.clusters.create.switch_auto }}`.
         * **{{ ui-key.yacloud.mdb.forms.field_security-group }}**: `{{ ui-key.yacloud.component.security-group-field.label_sg-from-list }}`. Specify security groups for the cluster.

      * Under **{{ ui-key.yacloud.k8s.clusters.create.section_allocation }}**, select **{{ ui-key.yacloud.k8s.clusters.create.field_tunnel-mode }}**.

   1. [Create a node group for the cluster](node-group/node-group-create.md) in any suitable configuration.

      Under **{{ ui-key.yacloud.k8s.node-groups.create.section_network }}**, select the following values:

      * **{{ ui-key.yacloud.k8s.node-groups.create.field_address-type }}**: `{{ ui-key.yacloud.k8s.node-groups.create.switch_auto }}`.
      * **{{ ui-key.yacloud.mdb.forms.field_security-group }}**: `{{ ui-key.yacloud.component.security-group-field.label_sg-from-list }}`. Specify security groups for the node groups.

- {{ TF }} {#tf}

   1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
   1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
   1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
   1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}
   1. Download the [k8s-cilium.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cilium-setup/blob/main/k8s-cilium.tf) configuration file to the same working directory. This file will be used to create the following resources:

      * [Network](../../vpc/concepts/network.md#network).
      * [Subnet](../../vpc/concepts/network.md#subnet).
      * {{ managed-k8s-name }} cluster.
      * Node group for the cluster.
      * [Service account](../../iam/concepts/users/service-accounts.md) the cluster and its node group need to operate.

      * {% include [configure-sg-terraform](../../_includes/managed-kubernetes/security-groups/configure-sg-tf-with-audience-lvl3.md) %}

         {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

   1. In `k8s-cilium.tf`, specify:

      * [Folder ID](../../resource-manager/operations/folder/get-id.md).
      * [{{ k8s }} version](../../managed-kubernetes/concepts/release-channels-and-updates.md) for the cluster and node groups.
      * Name of the service account.

   1. {% include [terraform-validate](../../_includes/managed-kubernetes/terraform-validate.md) %}

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Before you start working with the cluster {#do-preparations}

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}
1. [Install Cilium CLI](https://github.com/cilium/cilium-cli?tab=readme-ov-file#installation) (`cilium`).

## Install and configure Hubble UI {#install-hubble-ui}

1. Check the current status of Cilium in the cluster:

   ```bash
   cilium status
   ```

   Cilium, Operator, and Hubble Relay should have the `OK` status.

   {% cut "Command result example" %}

   ```text
       /¯¯\
    /¯¯\__/¯¯\    Cilium:             OK
    \__/¯¯\__/    Operator:           OK
    /¯¯\__/¯¯\    Envoy DaemonSet:    disabled (using embedded mode)
    \__/¯¯\__/    Hubble Relay:       OK
       \__/       ClusterMesh:        disabled

   DaemonSet              cilium             Desired: 1, Ready: 1/1, Available: 1/1
   Deployment             cilium-operator    Desired: 1, Ready: 1/1, Available: 1/1
   Deployment             hubble-relay       Desired: 1, Ready: 1/1, Available: 1/1
   Containers:            cilium             Running: 1
                          cilium-operator    Running: 1
                          hubble-relay       Running: 1
   Cluster Pods:          5/5 managed by Cilium
   Helm chart version:
   Image versions         cilium             cr.yandex/******/k8s-addons/cilium/cilium:v1.12.9: 1
                          cilium-operator    cr.yandex/******/k8s-addons/cilium/operator-generic:v1.12.9: 1
                          hubble-relay       cr.yandex/******/k8s-addons/cilium/hubble-relay:v1.12.9: 1
   ```

   {% endcut %}

1. Create a file named `hubble-ui.yaml` containing specifications for the resources required for Hubble UI:

   {% cut "hubble-ui.yaml" %}

   ```yaml
   ---
   apiVersion: v1
   kind: ServiceAccount
   metadata:
     name: "hubble-ui"
     namespace: kube-system
   ---
   apiVersion: v1
   kind: ConfigMap
   metadata:
     name: hubble-ui-nginx
     namespace: kube-system
   data:
     nginx.conf: |
       server
       {
         listen 8081;
         listen [::]:8081;
         server_name localhost;
         root /app;
         index index.html;
         client_max_body_size 1G;

         location /
         {
           proxy_set_header Host $host;
           proxy_set_header X-Real-IP $remote_addr;

           # CORS
           add_header Access-Control-Allow-Methods 'GET, POST, PUT, HEAD, DELETE, OPTIONS';
           add_header Access-Control-Allow-Origin *;
           add_header Access-Control-Max-Age 1728000;
           add_header Access-Control-Expose-Headers content-length,grpc-status,grpc-message;
           add_header Access-Control-Allow-Headers range,keep-alive,user-agent,cache-control,content-type,content-transfer-encoding,x-accept-content-transfer-encoding,x-accept-response-streaming,x-user-agent,x-grpc-web,grpc-timeout;
           if ($request_method = OPTIONS)
           {
             return 204;
           }
           # /CORS

           location /api
           {
             proxy_http_version 1.1;
             proxy_pass_request_headers on;
             proxy_hide_header Access-Control-Allow-Origin;
             proxy_pass http://127.0.0.1:8090;
           }

           location /
           {
             # double `/index.html` is required here
             try_files $uri $uri/ /index.html /index.html;
           }

           # Liveness probe
           location /healthz
           {
             access_log off;
             add_header Content-Type text/plain;
             return 200 'ok';
           }
         }
       }
   ---
   kind: ClusterRole
   apiVersion: rbac.authorization.k8s.io/v1
   metadata:
     name: hubble-ui
     labels:
       app.kubernetes.io/part-of: cilium
   rules:
   - apiGroups:
     - networking.k8s.io
     resources:
     - networkpolicies
     verbs:
     - get
     - list
     - watch
   - apiGroups:
     - ""
     resources:
     - componentstatuses
     - endpoints
     - namespaces
     - nodes
     - pods
     - services
     verbs:
     - get
     - list
     - watch
   - apiGroups:
     - apiextensions.k8s.io
     resources:
     - customresourcedefinitions
     verbs:
     - get
     - list
     - watch
   - apiGroups:
     - cilium.io
     resources:
     - "*"
     verbs:
     - get
     - list
     - watch
   ---
   kind: ClusterRoleBinding
   apiVersion: rbac.authorization.k8s.io/v1
   metadata:
     name: hubble-ui
     labels:
       app.kubernetes.io/part-of: cilium
   roleRef:
     apiGroup: rbac.authorization.k8s.io
     kind: ClusterRole
     name: hubble-ui
   subjects:
   - kind: ServiceAccount
     name: "hubble-ui"
     namespace: kube-system
   ---
   kind: Service
   apiVersion: v1
   metadata:
     name: hubble-ui
     namespace: kube-system
     labels:
       k8s-app: hubble-ui
       app.kubernetes.io/name: hubble-ui
       app.kubernetes.io/part-of: cilium
   spec:
     type: "ClusterIP"
     selector:
       k8s-app: hubble-ui
     ports:
       - name: http
         port: 80
         targetPort: 8081
   ---
   kind: Deployment
   apiVersion: apps/v1
   metadata:
     name: hubble-ui
     namespace: kube-system
     labels:
       k8s-app: hubble-ui
       app.kubernetes.io/name: hubble-ui
       app.kubernetes.io/part-of: cilium
   spec:
     replicas: 1
     selector:
       matchLabels:
         k8s-app: hubble-ui
     strategy:
       rollingUpdate:
         maxUnavailable: 1
       type: RollingUpdate
     template:
       metadata:
         annotations:
         labels:
           k8s-app: hubble-ui
           app.kubernetes.io/name: hubble-ui
           app.kubernetes.io/part-of: cilium
       spec:
         priorityClassName:
         serviceAccount: "hubble-ui"
         serviceAccountName: "hubble-ui"
         automountServiceAccountToken: true
         containers:
         - name: frontend
           image: "quay.io/cilium/hubble-ui:v0.13.0@sha256:7d663dc16538dd6e29061abd1047013a645e6e69c115e008bee9ea9fef9a6666"
           imagePullPolicy: IfNotPresent
           ports:
           - name: http
             containerPort: 8081
           livenessProbe:
             httpGet:
               path: /healthz
               port: 8081
           readinessProbe:
             httpGet:
               path: /
               port: 8081
           volumeMounts:
           - name: hubble-ui-nginx-conf
             mountPath: /etc/nginx/conf.d/default.conf
             subPath: nginx.conf
           - name: tmp-dir
             mountPath: /tmp
           terminationMessagePolicy: FallbackToLogsOnError
         - name: backend
           image: "quay.io/cilium/hubble-ui-backend:v0.13.0@sha256:1e7657d997c5a48253bb8dc91ecee75b63018d16ff5e5797e5af367336bc8803"
           imagePullPolicy: IfNotPresent
           env:
           - name: EVENTS_SERVER_PORT
             value: "8090"
           - name: FLOWS_API_ADDR
             value: "hubble-relay:80"
           ports:
           - name: grpc
             containerPort: 8090
           volumeMounts:
           terminationMessagePolicy: FallbackToLogsOnError
         nodeSelector:
           kubernetes.io/os: linux
         volumes:
         - configMap:
             defaultMode: 420
             name: hubble-ui-nginx
           name: hubble-ui-nginx-conf
         - emptyDir: {}
           name: tmp-dir
   ```

   {% endcut %}

1. Create resources:

   ```bash
   kubectl apply -f hubble-ui.yaml
   ```

   {% cut "Command result" %}

   ```text
   serviceaccount/hubble-ui created
   configmap/hubble-ui-nginx created
   clusterrole.rbac.authorization.k8s.io/hubble-ui created
   clusterrolebinding.rbac.authorization.k8s.io/hubble-ui created
   service/hubble-ui created
   deployment.apps/hubble-ui created
   ```

   {% endcut %}

1. Check Cilium status after installing Hubble UI:

   ```bash
   cilium status
   ```

   Cilium, Operator, and Hubble Relay should have the `OK` status. The `hubble-ui` container must be in the `Running: 1` state.

   {% cut "Command result example" %}

   ```text
       /¯¯\
    /¯¯\__/¯¯\    Cilium:             OK
    \__/¯¯\__/    Operator:           OK
    /¯¯\__/¯¯\    Envoy DaemonSet:    disabled (using embedded mode)
    \__/¯¯\__/    Hubble Relay:       OK
       \__/       ClusterMesh:        disabled

   Deployment             cilium-operator    Desired: 1, Ready: 1/1, Available: 1/1
   Deployment             hubble-ui          Desired: 1, Ready: 1/1, Available: 1/1
   DaemonSet              cilium             Desired: 1, Ready: 1/1, Available: 1/1
   Deployment             hubble-relay       Desired: 1, Ready: 1/1, Available: 1/1
   Containers:            cilium             Running: 1
                          hubble-relay       Running: 1
                          cilium-operator    Running: 1
                          hubble-ui          Running: 1
   Cluster Pods:          6/6 managed by Cilium
   Helm chart version:
   Image versions         cilium             cr.yandex/******/k8s-addons/cilium/cilium:v1.12.9: 1
                          hubble-relay       cr.yandex/******/k8s-addons/cilium/hubble-relay:v1.12.9: 1
                          cilium-operator    cr.yandex/******/k8s-addons/cilium/operator-generic:v1.12.9: 1
                          hubble-ui          quay.io/cilium/hubble-ui-backend:v0.13.0@sha256:******: 1
                          hubble-ui          quay.io/cilium/hubble-ui:v0.13.0@sha256:******: 1
   ```

   {% endcut %}

1. To access the Hubble UI web interface, run this command:

   ```bash
   cilium hubble ui
   ```

   Your browser will open and redirect you to the Hubble UI web interface.

   {% note info %}

   If you close the terminal session running the command, you will lose access to the web interface.

   {% endnote %}

## Create a test environment {#create-test-environment}

1. Create a file named `http-sw-app.yaml` with a specification of resources for test applications:

   {% cut "http-sw-app.yaml" %}

   ```yaml
   ---
   apiVersion: v1
   kind: Service
   metadata:
     name: deathstar
   spec:
     type: ClusterIP
     ports:
     - port: 80
     selector:
       org: empire
       class: deathstar
   ---
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: deathstar
   spec:
     replicas: 2
     selector:
       matchLabels:
         org: empire
         class: deathstar
     template:
       metadata:
         labels:
           org: empire
           class: deathstar
       spec:
         containers:
         - name: deathstar
           image: docker.io/cilium/starwars
   ---
   apiVersion: v1
   kind: Pod
   metadata:
     name: tiefighter
     labels:
       org: empire
       class: tiefighter
   spec:
     containers:
     - name: spaceship
       image: docker.io/tgraf/netperf
   ---
   apiVersion: v1
   kind: Pod
   metadata:
     name: xwing
     labels:
       org: alliance
       class: xwing
   spec:
     containers:
     - name: spaceship
       image: docker.io/tgraf/netperf
   ```

   {% endcut %}

1. Create applications:

   ```bash
   kubectl apply -f http-sw-app.yaml
   ```

   {% cut "Command result" %}

   ```text
   service/deathstar created
   deployment.apps/deathstar created
   pod/tiefighter created
   pod/xwing created
   ```

   {% endcut %}

1. Make sure the pods and services you created are working:

   ```bash
   kubectl get pods,svc
   ```

   {% cut "Command result example" %}

   ```text
   NAME                            READY   STATUS    RESTARTS   AGE
   pod/deathstar-c74d84667-6x4gx   1/1     Running   1          7d
   pod/deathstar-c74d84667-jrdsp   1/1     Running   0          7d
   pod/tiefighter                  1/1     Running   0          7d
   pod/xwing                       1/1     Running   0          7d

   NAME                 TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
   service/deathstar    ClusterIP   10.96.18.169  <none>        80/TCP    7d
   service/kubernetes   ClusterIP   10.96.0.1     <none>        443/TCP   8d
   ```

   {% endcut %}

1. View the current status of Cilium endpoints:

   ```bash
   kubectl -n kube-system exec daemonset/cilium -- cilium endpoint list
   ```

   Make sure that network policies are disabled for all endpoints: their status under `POLICY (ingress) ENFORCEMENT` and `POLICY (egress) ENFORCEMENT` should be set to `Disabled`.

   {% cut "Example of partial command result" %}

   ```text
   Defaulted container "cilium-agent" out of: cilium-agent, clean-cilium-state (init), install-cni-binaries (init)
   ENDPOINT   POLICY (ingress)   POLICY (egress)   IDENTITY   LABELS (source:key[=value])                                                  IPv6   IPv4          STATUS
              ENFORCEMENT        ENFORCEMENT
   51         Disabled           Disabled          2204       k8s:app.kubernetes.io/name=hubble-ui                                                10.112.0.97   ready
                                                              k8s:app.kubernetes.io/part-of=cilium
                                                              k8s:io.cilium.k8s.namespace.labels.kubernetes.io/metadata.name=kube-system
                                                              k8s:io.cilium.k8s.policy.cluster=default
                                                              k8s:io.cilium.k8s.policy.serviceaccount=hubble-ui
                                                              k8s:io.kubernetes.pod.namespace=kube-system
                                                              k8s:k8s-app=hubble-ui
   274        Disabled           Disabled          23449      k8s:io.cilium.k8s.namespace.labels.kubernetes.io/metadata.name=kube-system          10.112.0.224  ready
                                                              k8s:io.cilium.k8s.policy.cluster=default
                                                              k8s:io.cilium.k8s.policy.serviceaccount=kube-dns-autoscaler
                                                              k8s:io.kubernetes.pod.namespace=kube-system
                                                              k8s:k8s-app=kube-dns-autoscaler

   ...
   ```

   {% endcut %}

1. Make sure the `tiefighter` and `xwing` applications have access to the `deathstar` API and return `Ship landed`, as the network policies are disabled:

   ```bash
   kubectl exec tiefighter -- curl -s -XPOST deathstar.default.svc.cluster.local/v1/request-landing && \
   kubectl exec xwing -- curl -s -XPOST deathstar.default.svc.cluster.local/v1/request-landing
   ```

   The output of both commands must be the same:

   ```text
   Ship landed
   Ship landed
   ```

1. Go to the Hubble UI web interface and view data streams for pods and services in the `default` namespace.

   The verdict for all data streams should be `forwarded`.

## Create an L3/L4 network policy {#l3-l4-policy}

Apply an L3/L4 network policy to disable the `xwing` pod's access to `deathstar`. Access rules for the `tiefighter` pod remain unchanged.

For access differentiation, the following {{ k8s }} labels are assigned to pods when creating them:

* `org: empire` for the `tiefighter` pod.
* `org: alliance` for the `xwing` pod.

The L3/L4 network policy only allows `org: empire` labeled pods to access `deathstar`.

1. Create a file named `sw_l3_l4_policy.yaml` with a specification of the policy:

   {% cut "sw_l3_l4_policy.yaml" %}

   ```yaml
   ---
   apiVersion: "cilium.io/v2"
   kind: CiliumNetworkPolicy
   metadata:
     name: "rule1"
   spec:
     description: "L3-L4 policy to restrict deathstar access to empire ships only"
     endpointSelector:
       matchLabels:
         org: empire
         class: deathstar
     ingress:
     - fromEndpoints:
       - matchLabels:
           org: empire
       toPorts:
       - ports:
         - port: "80"
           protocol: TCP
   ```

   {% endcut %}

1. Create a policy named `rule1`:

   ```bash
   kubectl apply -f sw_l3_l4_policy.yaml
   ```

   Command result:

   ```text
   ciliumnetworkpolicy.cilium.io/rule1 created
   ```

1. View the current status of Cilium endpoints again:

   ```bash
   kubectl -n kube-system exec daemonset/cilium -- cilium endpoint list
   ```

   Make sure the inbound direction policy in enabled for the endpoint associated with the `k8s:class=deathstar` label: its status under `POLICY (ingress) ENFORCEMENT` should be `Enabled`.

   {% cut "Example of partial command result" %}

   ```text
   Defaulted container "cilium-agent" out of: cilium-agent, clean-cilium-state (init), install-cni-binaries (init)
   ENDPOINT   POLICY (ingress)   POLICY (egress)   IDENTITY   LABELS (source:key[=value])                                                  IPv6   IPv4          STATUS
              ENFORCEMENT        ENFORCEMENT

   ...

   3509       Enabled            Disabled          52725      k8s:class=deathstar                                                                 10.112.0.43   ready
                                                              k8s:io.cilium.k8s.namespace.labels.kubernetes.io/metadata.name=default
                                                              k8s:io.cilium.k8s.policy.cluster=default
                                                              k8s:io.cilium.k8s.policy.serviceaccount=default
                                                              k8s:io.kubernetes.pod.namespace=default
                                                              k8s:org=empire

   ...
   ```

   {% endcut %}

1. Check that the `deathstar` service is available for the `tiefighter` pod:

   ```bash
   kubectl exec tiefighter -- curl -s -XPOST deathstar.default.svc.cluster.local/v1/request-landing
   ```

   Command result:

   ```text
   Ship landed
   ```

1. Make sure the `xwing` pod can't access the `deathstar` service:

   ```bash
   kubectl exec xwing -- curl -s -XPOST deathstar.default.svc.cluster.local/v1/request-landing
   ```

   Press **Ctrl** + **C** to abort the command. The network policy has denied this pod access to the service.

1. Learn how the policy works:

   * To view the policy specification and status, run this command:

      ```bash
      kubectl describe cnp rule1
      ```

   * Go to the Hubble UI web interface and view data streams for pods and services in the `default` namespace.

      * The verdict for streams from `tiefighter` to `deathstar.default.svc.cluster.local/v1/request-landing` should be `forwarded`.
      * The verdict for streams from `xwing` to `deathstar.default.svc.cluster.local/v1/request-landing` should be `dropped`.

## Create an L7 network policy {#l7-policy}

In this part of the scenario, we will change the access policy for the `tiefighter` pod:

* Access to the `deathstar.default.svc.cluster.local/v1/exhaust-port` API method will be disabled.
* Access to the `deathstar.default.svc.cluster.local/v1/request-landing` API method remains unchanged.

Access for the `xwing` pod remains unchanged. This pod can't access `deathstar`.

1. Check that the `tiefighter` pod has access to the `deathstar.default.svc.cluster.local/v1/exhaust-port` method when using the existing `rule1` policy:

   ```bash
   kubectl exec tiefighter -- curl -s -XPUT deathstar.default.svc.cluster.local/v1/exhaust-port
   ```

   Command result:

   ```text
   Panic: deathstar exploded

   goroutine 1 [running]:
   main.HandleGarbage(0x2080c3f50, 0x2, 0x4, 0x425c0, 0x5, 0xa)
     /code/src/github.com/empire/deathstar/
     temp/main.go:9 +0x64
   main.main()
     /code/src/github.com/empire/deathstar/
     temp/main.go:5 +0x85
   ```

1. Create a file named `sw_l3_l4_l7_policy.yaml` with an updated policy specification:

   {% cut "sw_l3_l4_l7_policy.yaml" %}

   ```yaml
   ---
   apiVersion: "cilium.io/v2"
   kind: CiliumNetworkPolicy
   metadata:
     name: "rule1"
   spec:
     description: "L7 policy to restrict access to specific HTTP call"
     endpointSelector:
       matchLabels:
         org: empire
         class: deathstar
     ingress:
     - fromEndpoints:
       - matchLabels:
           org: empire
       toPorts:
       - ports:
         - port: "80"
           protocol: TCP
         rules:
           http:
           - method: "POST"
             path: "/v1/request-landing"
   ```

   {% endcut %}

1. Update the existing `rule1` policy:

   ```bash
   kubectl apply -f sw_l3_l4_l7_policy.yaml
   ```

   Command result:

   ```text
   ciliumnetworkpolicy.cilium.io/rule1 configured
   ```

1. Check that the `tiefighter` pod can access the `deathstar.default.svc.cluster.local/v1/request-landing` method:

   ```bash
   kubectl exec tiefighter -- curl -s -XPOST deathstar.default.svc.cluster.local/v1/request-landing
   ```

   Command result:

   ```text
   Ship landed
   ```

1. Make sure that access to the `deathstar.default.svc.cluster.local/v1/exhaust-port` method is disabled for the `tiefighter` pod:

   ```bash
   kubectl exec tiefighter -- curl -s -XPUT deathstar.default.svc.cluster.local/v1/exhaust-port
   ```

   Command result:

   ```text
   Access denied
   ```

1. Check that the `xwing` pod can't access `deathstar`:

   ```bash
   kubectl exec xwing -- curl -s -XPOST deathstar.default.svc.cluster.local/v1/request-landing
   ```

   Press **Ctrl** + **C** to abort the command.

1. Learn how the policy works:

   * To view the policy specification and status, run this command:

      ```bash
      kubectl describe cnp rule1
      ```

   * Go to the Hubble UI web interface and view data streams for pods and services in the `default` namespace:

      * The verdict for streams from `tiefighter` to `deathstar.default.svc.cluster.local/v1/request-landing` should be `forwarded`.
      * The verdict for streams from `tiefighter` to `deathstar.default.svc.cluster.local/v1/exhaust-port` should be `dropped`.
      * The verdict for streams from `xwing` to `deathstar.default.svc.cluster.local` should be `dropped`.

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

- Manually {#manual}

   1. [Delete the {{ managed-k8s-name }} cluster](kubernetes-cluster/kubernetes-cluster-delete.md).
   1. If static public IP addresses were used for cluster and node access, release and [delete](../../vpc/operations/address-delete.md) them.

- {{ TF }} {#tf}

   1. In the command line, go to the directory with the current {{ TF }} configuration file with an infrastructure plan.
   1. Delete the `k8s-cilium.tf` configuration file.
   1. {% include [terraform-validate](../../_includes/managed-kubernetes/terraform-validate.md) %}
   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      This will delete all the resources described in the `k8s-cilium.tf` configuration file.

{% endlist %}
