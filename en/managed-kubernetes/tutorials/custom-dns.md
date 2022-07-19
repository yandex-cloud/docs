# Integration with a corporate DNS zone


To configure private enterprise DNS zone resolution in a {{ k8s }} cluster, follow the steps below:

1. Set up a work environment.

   To run the use case, you will need a service account, a cloud network, and a subnet. You can use existing resources or create new ones.

   {% cut "How to create resources" %}

   1. Create a [service account](../../iam/operations/sa/create.md) with the `editor` role.
   1. Create a [cloud network](../../vpc/operations/network-create.md).
   1. In the cloud network, create a [subnet](../../vpc/operations/subnet-create.md).

   {% endcut %}

1. Configure the DNS server.

   In this scenario's examples, the DNS server has the address `10.129.0.3`, the name `ns.example.com`, and serves a zone called `example.com`. Your DNS servers can be part of {{ vpc-name }} or be accessible via a VPN or {{ interconnect-name }}. IP connectivity between the {{ k8s }} cluster nodes and the DNS servers is required.

1. Create a {{ k8s }} cluster and a group of nodes.

   You can use an existing cluster and a group of {{ k8s }} nodes or create new ones.

   {% cut "How to create a {{ k8s}} cluster and a group of nodes" %}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Create a {{ k8s }} cluster:

   ```bash
   yc managed-kubernetes cluster create \
     --name custom-dns-cluster \
     --service-account-name <service_account_name> \
     --node-service-account-name <service_account_name> \
     --public-ip \
     --zone {{ region-id }}-a \
     --network-name <cloud_network_name>
   ```

   Result:

   ```bash
   done (7m21s)
   ...
   ```

   Create a node group:

   ```bash
   yc managed-kubernetes node-group create \
     --name custom-dns-group \
     --cluster-name custom-dns-cluster \
     --location zone={{ region-id }}-a \
     --public-ip \
     --fixed-size 1
   ```

   Result:

   ```bash
   done (2m43s)
   ...
   ```

   {% endcut %}

1. Configure kubectl.

   To run commands for a {{ k8s }} cluster, install and configure the kubectl management console.

   {% cut "How to configure kubectl" %}

   Install the {{ k8s }} CLI [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl).

   Add the {{ k8s }} cluster credentials to the kubectl configuration file:

   ```bash
   yc managed-kubernetes cluster get-credentials --external --name custom-dns-cluster
   ```

   Result:

   ```text
   Context 'yc-custom-dns-cluster' was added as default to kubeconfig '/home/<your home folder>/.kube/config'.
   ...
   ```

   {% endcut %}

1. Specify a corporate DNS zone.

   Create a `custom-zone.yaml` file with the following contents:

   ```yaml
   kind: ConfigMap
   apiVersion: v1
   metadata:
     name: coredns-user
     namespace: kube-system
     labels:
       addonmanager.kubernetes.io/mode: EnsureExists
   data:
     Corefile: |
       # User can put their additional configurations here, for example:
       example.com {
         errors
         cache 30
         forward . 10.129.0.3
       }
   ```

   Run the command:

   ```bash
   kubectl replace -f custom-zone.yaml
   ```

   Result:

   ```text
   configmap/coredns-user replaced
   ```

1. Create a pod:

   ```bash
   kubectl run jessie-dnsutils \
     --image=k8s.gcr.io/jessie-dnsutils \
     --restart=Never \
     --command sleep infinity
   ```

   Result:

   ```text
   pod/jessie-dnsutils created
   ```

   View details of the pod created:

   ```bash
   kubectl describe pod jessie-dnsutils
   ```

   Result:

   ```text
   ...
   Status: Running
   ...
   ```

1. Verify DNS integration.

   To check that your DNS zone is accessible to the {{ k8s }} cluster services, execute the `nslookup` command in a running container:

   ```bash
   kubectl exec jessie-dnsutils -- nslookup ns.example.com
   ```

   Result:

   ```bash
   Server:		10.96.128.2
   Address:	10.96.128.2#53
   Name:	ns.example.com
   Address: 10.129.0.3
   ```

1. Delete the resources created.

   To delete the {{ k8s }} cluster, service account, subnet, and network, run the following commands:

   ```bash
   yc managed-kubernetes cluster delete --name custom-dns-cluster
   yc iam service-account delete <service account name>
   yc vpc subnet delete <cloud subnet name>
   yc vpc network delete <cloud network name>
   ```