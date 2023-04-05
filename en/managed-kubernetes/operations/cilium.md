# Configuring the Cilium network policy controller

This scenario shows the [implementation of L3/L4 and L7 network policies](https://docs.cilium.io/en/v1.10/gettingstarted/http/) that are managed by the [Cilium network policy controller](../concepts/network-policy.md#cilium).

To use the Cilium network policy controller in a cluster:
* [Install and configure the Hubble networking and security observability platform](#install-hubble).
* [Create a test environment](#create-test-environment).
* [Create an L3/L4 network policy](#l3-l4-policy).
* [Create an L7 network policy](#l7-policy).

## Before you begin {#before-you-begin}

1. [Create a service account](../../iam/operations/sa/create.md) and [grant it the roles](../../iam/operations/sa/assign-role-for-sa.md) of `k8s.tunnelClusters.agent` and `vpc.publicAdmin`.
1. [Create a {{ k8s }} cluster](kubernetes-cluster/kubernetes-cluster-create.md) with any suitable configuration.

   Under **Cluster network settings**, select **Enable tunnel mode**.

1. [Create a node group](node-group/node-group-create.md) of any suitable configuration.

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Install and configure Hubble {#install-hubble}

1. Create a file named `hubble-ui.yaml` with a specification of resources required for Hubble:

   {% cut "hubble-ui.yaml" %}

   ```yaml
   ---
   # Source: cilium/templates/hubble-ui-serviceaccount.yaml
   apiVersion: v1
   kind: ServiceAccount
   metadata:
     name: "hubble-ui"
     namespace: kube-system
   ---
   # Source: cilium/templates/hubble-ui-configmap.yaml
   apiVersion: v1
   kind: ConfigMap
   metadata:
     name: hubble-ui-envoy
     namespace: kube-system
   data:
     envoy.yaml: |
       static_resources:
         listeners:
           - name: listener_hubble_ui
             address:
               socket_address:
                 address: 0.0.0.0
                 port_value: 8081
             filter_chains:
               - filters:
                   - name: envoy.filters.network.http_connection_manager
                     typed_config:
                       "@type": type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.HttpConnectionManager
                       codec_type: auto
                       stat_prefix: ingress_http
                       route_config:
                         name: local_route
                         virtual_hosts:
                           - name: local_service
                             domains: ["*"]
                             routes:
                               - match:
                                   prefix: "/api/"
                                 route:
                                   cluster: backend
                                   prefix_rewrite: "/"
                                   timeout: 0s
                                   max_stream_duration:
                                     grpc_timeout_header_max: 0s
                               - match:
                                   prefix: "/"
                                 route:
                                   cluster: frontend
                             cors:
                               allow_origin_string_match:
                                 - prefix: "*"
                               allow_methods: GET, PUT, DELETE, POST, OPTIONS
                               allow_headers: keep-alive,user-agent,cache-control,content-type,content-transfer-encoding,x-accept-content-transfer-encoding,x-accept-response-streaming,x-user-agent,x-grpc-web,grpc-timeout
                               max_age: "1728000"
                               expose_headers: grpc-status,grpc-message
                       http_filters:
                         - name: envoy.filters.http.grpc_web
                         - name: envoy.filters.http.cors
                         - name: envoy.filters.http.router
         clusters:
           - name: frontend
             connect_timeout: 0.25s
             type: strict_dns
             lb_policy: round_robin
             load_assignment:
               cluster_name: frontend
               endpoints:
                 - lb_endpoints:
                     - endpoint:
                         address:
                           socket_address:
                             address: 127.0.0.1
                             port_value: 8080
           - name: backend
             connect_timeout: 0.25s
             type: logical_dns
             lb_policy: round_robin
             http2_protocol_options: {}
             load_assignment:
               cluster_name: backend
               endpoints:
                 - lb_endpoints:
                     - endpoint:
                         address:
                           socket_address:
                             address: 127.0.0.1
                             port_value: 8090
   ---
   # Source: cilium/templates/hubble-ui-clusterrole.yaml
   kind: ClusterRole
   apiVersion: rbac.authorization.k8s.io/v1
   metadata:
     name: hubble-ui
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
   # Source: cilium/templates/hubble-ui-clusterrolebinding.yaml
   kind: ClusterRoleBinding
   apiVersion: rbac.authorization.k8s.io/v1
   metadata:
     name: hubble-ui
   roleRef:
     apiGroup: rbac.authorization.k8s.io
     kind: ClusterRole
     name: hubble-ui
   subjects:
     - kind: ServiceAccount
       namespace: kube-system
       name: "hubble-ui"
   ---
   # Source: cilium/templates/hubble-ui-service.yaml
   kind: Service
   apiVersion: v1
   metadata:
     name: hubble-ui
     labels:
       k8s-app: hubble-ui
     namespace: kube-system
   spec:
     selector:
       k8s-app: hubble-ui
     ports:
       - name: http
         port: 80
         targetPort: 8081
     type: ClusterIP
   ---
   # Source: cilium/templates/hubble-ui-deployment.yaml
   kind: Deployment
   apiVersion: apps/v1
   metadata:
     namespace: kube-system
     labels:
       k8s-app: hubble-ui
     name: hubble-ui
   spec:
     replicas: 1
     selector:
       matchLabels:
         k8s-app: hubble-ui
     template:
       metadata:
         annotations:
         labels:
           k8s-app: hubble-ui
       spec:
         securityContext:
           runAsUser: 1001
         serviceAccount: "hubble-ui"
         serviceAccountName: "hubble-ui"
         containers:
           - name: frontend
             image: "quay.io/cilium/hubble-ui:v0.7.9@sha256:e0e461c680ccd083ac24fe4f9e19e675422485f04d8720635ec41f2ba9e5562c"
             imagePullPolicy: IfNotPresent
             ports:
               - containerPort: 8080
                 name: http
             resources: {}
           - name: backend
             image: "quay.io/cilium/hubble-ui-backend:v0.7.9@sha256:632c938ef6ff30e3a080c59b734afb1fb7493689275443faa1435f7141aabe76"
             imagePullPolicy: IfNotPresent
             env:
               - name: EVENTS_SERVER_PORT
                 value: "8090"
               - name: FLOWS_API_ADDR
                 value: "hubble-relay:80"
             ports:
               - containerPort: 8090
                 name: grpc
             resources: {}
           - name: proxy
             image: "docker.io/envoyproxy/envoy:v1.18.2@sha256:e8b37c1d75787dd1e712ff389b0d37337dc8a174a63bed9c34ba73359dc67da7"
             imagePullPolicy: IfNotPresent
             ports:
               - containerPort: 8081
                 name: http
             resources: {}
             command: ["envoy"]
             args: ["-c", "/etc/envoy.yaml", "-l", "info"]
             volumeMounts:
               - name: hubble-ui-envoy-yaml
                 mountPath: /etc/envoy.yaml
                 subPath: envoy.yaml
         volumes:
           - name: hubble-ui-envoy-yaml
             configMap:
               name: hubble-ui-envoy
   ```

   {% endcut %}

1. Create resources:

   ```bash
   kubectl apply -f hubble-ui.yaml
   ```

   Command result:

   ```text
   serviceaccount/hubble-ui created
   configmap/hubble-ui-envoy created
   clusterrole.rbac.authorization.k8s.io/hubble-ui created
   clusterrolebinding.rbac.authorization.k8s.io/hubble-ui created
   service/hubble-ui created
   deployment.apps/hubble-ui created
   ```

1. Check that the Hubble pods' status changes to `Running`. To do this, run the command:

   ```bash
   kubectl get pod -A -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase \
     | grep hubble | grep -v certs
   ```

   Command result:

   ```text
   hubble-relay-6b9c774ffc-2jm7t  Running
   hubble-ui-95d74d44c-7jpvl      Running
   ```

1. Download the Hubble client to the local computer:

   ```bash
   export HUBBLE_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/hubble/master/stable.txt) && \
   curl -LO "https://github.com/cilium/hubble/releases/download/$HUBBLE_VERSION/hubble-linux-amd64.tar.gz" && \
   curl -LO "https://github.com/cilium/hubble/releases/download/$HUBBLE_VERSION/hubble-linux-amd64.tar.gz.sha256sum" && \
   sha256sum --check hubble-linux-amd64.tar.gz.sha256sum && \
   tar zxf hubble-linux-amd64.tar.gz
   ```

1. Configure Hubble port forwarding onto the local computer:

   ```bash
   kubectl port-forward -n kube-system svc/hubble-ui 12000:80
   ```

   {% note info %}

   Port forwarding is stopped if you close the terminal window or abort the command.

   {% endnote %}

1. To open the Hubble UI in a browser, [follow this link](http://localhost:12000).

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
   kubectl create -f http-sw-app.yaml
   ```

   Command result:

   ```text
   service/deathstar created
   deployment.apps/deathstar created
   pod/tiefighter created
   pod/xwing created
   ```

1. Make sure the pods and services you created are working:

   ```bash
   kubectl get pods,svc
   ```

   Command result:

   ```text
   NAME                            READY   STATUS    RESTARTS   AGE
   pod/deathstar-c74d84667-6x4gx   1/1     Running   1          7d
   pod/deathstar-c74d84667-jrdsp   1/1     Running   0          7d
   pod/tiefighter                  1/1     Running   0          7d
   pod/xwing                       1/1     Running   0          7d

   NAME                 TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
   service/deathstar    ClusterIP   10.4.207.162   <none>        80/TCP    7d
   service/kubernetes   ClusterIP   10.4.0.1       <none>        443/TCP   8d
   ```

1. Find out the name of the pod serving the Cilium controller:

   ```bash
   kubectl -n kube-system get pods -l k8s-app=cilium
   ```

   Command result:

   ```text
   NAME           READY   STATUS    RESTARTS   AGE
   cilium-67c4p   1/1     Running   0          42h
   ```

   In this example, the Cilium controller pod name is `cilium-67c4p`. If there are multiple nodes in the created node group, the Cilium controller pod is run on each of them. In this case, use the name of any of the pods.
1. Make sure that network policies are disabled: the `POLICY (ingress) ENFORCEMENT` and `POLICY (egress) ENFORCEMENT` columns are set to `Disabled`:

   ```bash
   kubectl -n kube-system exec <Cilium controller pod name> -- cilium endpoint list
   ```

1. Make sure the `xwing` and `tiefighter` applications have access to the `deathstar` API and return the `Ship landed` string, since the network policies are not activated:

   ```bash
   kubectl exec xwing -- curl -s -XPOST deathstar.default.svc.cluster.local/v1/request-landing && \
   kubectl exec tiefighter -- curl -s -XPOST deathstar.default.svc.cluster.local/v1/request-landing
   ```

   Command result:

   ```text
   Ship landed
   Ship landed
   ```

## Create an L3/L4 network policy {#l3-l4-policy}

Apply an L3/L4 network policy to disable the `xwing` pod's access to `deathstar`. Access rules for the `tiefighter` pod remain unchanged.

For access differentiation, the following labels are assigned to pods when creating them:
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

1. Create a policy:

   ```bash
   kubectl create -f sw_l3_l4_policy.yaml
   ```

1. Make sure that the status of the policy for the `k8s:class=deathstar` object is `Enabled`:

   ```bash
   kubectl -n kube-system exec <Cilium controller pod name> -- cilium endpoint list
   ```

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
   * To view the policy specification and status, run the command:

      ```bash
      kubectl describe cnp rule1
      ```

   * To check if the pods can connect to `deathstar`, open the Hubble UI. To do this, [follow the link](http://localhost:12000/default).

## Create an L7 network policy {#l7-policy}

In this part of the scenario, we'll change the access policy for the `tiefighter` pod:
* Access to the `deathstar.default.svc.cluster.local/v1/exhaust-port` API method will be disabled.
* Access to the `deathstar.default.svc.cluster.local/v1/request-landing` API method remains unchanged.

Access for the `xwing` pod remains unchanged. This pod can't access `deathstar`.
1. Check that the `tiefighter` pod can access the `deathstar.default.svc.cluster.local/v1/exhaust-port` method in the current policy version:

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

1. Create a file named `sw_l3_l4_l7_policy.yaml` with a specification of the policy:

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

1. Create a new policy:

   ```bash
   kubectl apply -f sw_l3_l4_l7_policy.yaml
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
   * To view the updated policy specification and status, run the command:

      ```bash
      kubectl describe cnp rule1
      ```

   * To check if the pods can connect to `deathstar`, open the Hubble UI. To do this, [follow the link](http://localhost:12000/default).

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

1. [Delete the {{ k8s }} cluster](kubernetes-cluster/kubernetes-cluster-delete.md).
1. If static public IP addresses were used for cluster and node access, release and [delete](../../vpc/operations/address-delete.md) them.