# Reference architecture for cloud infrastructure in isolated mode without internet access

Deployment of a cloud infrastructure without internet access is a common client use case in {{ yandex-cloud }}. In this scenario, access to cloud resources is only allowed from the client’s [on‑premise](https://en.wikipedia.org/wiki/On-premises_software) infrastructure and not from the internet. If cloud resources require networking with external internet resources, this traffic must go through client’s own infrastructure, e.g., firewalls, that controls internet access.

The section provides recommendations for implementing such a scenario.

## Setting up networking

For this scenario, we recommend using [{{ interconnect-name }}](../../interconnect/concepts/) to configure IP network connectivity between the client infrastructure resources and {{ yandex-cloud }} resources:
* Using the dedicated physical channels, the client’s network equipment is connected to {{ yandex-cloud }} equipment in [points of presence](../../interconnect/concepts/pops.md) either directly over a cross connection or via network providers.
* With {{ interconnect-name }} connections, you can set up logical connections to the client’s [cloud networks](../../interconnect/concepts/priv-con.md), as well as to {{ yandex-cloud }} [services](../../interconnect/concepts/pub-con.md), such as [{{ objstorage-name }}](../../storage).
* To ensure {{ interconnect-name }} fault tolerance, you may want to set up connections at multiple [points of presence](../../interconnect/concepts/pops.md).
* For detailed instructions on how to enable and manage {{ interconnect-name }}, see the [relevant documentation](../../interconnect/operations/).

## Resource and access management
In the {{ yandex-cloud }} resource model, any cloud user with the `editor` or `admin` permissions for a resource can modify its specifications. When infrastructure is isolated, this poses a risk of unauthorized changes in resource specifications, which compromises the threat model’s isolation principle. We recommend using [{{ at-name }}](../../audit-trails/) logs and [SIEM](https://ru.wikipedia.org/wiki/SIEM) notifications to track such events; however, there is also a proactive approach to monitoring changes in the protected environment.

GitOps is an approach to infrastructure management where the product infrastructure is formally defined as code ([Infrastructure as Code](https://en.wikipedia.org/wiki/Infrastructure_as_code)) in line with the threat model. Changes to all infrastructure components are introduced as pull requests to the source code repository and then applied by a {{ yandex-cloud }} service account. All cloud users must have the `auditor` or `viewer` role for all production environment services. This allows you to mitigate the following risks:
* Unauthorized access to resources and data.
* Unauthorized copying or deleting of resources and data by the cloud administrator.
* Unauthorized resource editing which leads to threat model violation (e.g., assigning a public IP to a network interface or creating a gateaway to the internet).
* Unwarranted manual changes made using high-level permissions.

According to the DevOps principles, making a change is impossile without creating a pull request to the source code repository. This way, changes can only be approved and applied by certain responsible employees, or reviewers. Other employees make sure the changes are correct, so the pull request creator does not have all the decision-making authority. To keep track of changes, this approach relies on a source code management system. You need to make sure that no users have administrative privileges at the {{ yandex-cloud }} organization level and use subject groups to grant all the required roles for different environments.

The source code management system offered by {{ yandex-cloud }} is [{{ mgl-full-name }}](../../managed-gitlab).

## Cloud service requirements

Below we outline how to implement this scenario in {{ yandex-cloud }} core services: 
* [{{ compute-name }}](#computecloud)
* [{{ vpc-name }}](#virtualprivatecloud)
* [{{ network-load-balancer-name }}](#networkloadbalancer)
* [{{ alb-name }}](#applicationloadbalancer)
* [{{ managed-k8s-name }}](#managedserviceforkubernetes)
* [{{ mpg-name }}](#managedserviceforpostgresql)
* [{{ mch-name }}](#managedserviceforclickhouse)
* [{{ sf-name }} and {{ serverless-containers-name }}](#cloudfunctionsiserverlesscontainers)

To learn how to enable internet access for other {{ yandex-cloud }} services, see the relevant service [documentation](../..).

### {{ compute-name }} {#computecloud}

VMs must not have [public IP address](../../compute/concepts/network.md#public-ip). 

{% list tabs group=instructions %}

- Management console {#console}

   {% note info %}
   
   Checks performed using the console do not return public IP addresses of stopped VMs. To get the addresses of all the VMs, use the CLI.
   
   {% endnote %}

   1. Open the [management console]({{ link-console-main }}) in your browser.
   1. Go to the appropriate folder.
   1. Go to **{{ ui-key.yacloud.component.navigation-menu.label_vpc }} / {{ ui-key.yacloud.vpc.addresses.label_title }}**.
   1. Make sure that the reserved public IP addresses are not used by any VMs or that you see this message: `You do not have public IP addresses yet`. Otherwise, proceed to **Guides and solutions to use**.

- CLI {#cli}

   1. View the available organizations and write down the `ID` you need:
      
      ```
      yc organization-manager organization list
      ```
      
   1. Run the command below to search for all the VMs with public IP addresses:
      
      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do VM_LIST=$(yc compute instance list --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(.network_interfaces[].primary_v4_address.one_to_one_nat)' | jq -r '.id');
      if [ -n "$VM_LIST" ]; then printf "FOLDER_ID: $FOLDER_ID\nVM_ID:\n$VM_LIST\n-----\n"; fi;
      done;
      done
      ```
    
   1. The command output should be empty. Otherwise, proceed to **Guides and solutions to use**.

{% endlist %}


**Guides and solutions to use**:
* Do not assign user [roles](../../vpc/security/) that enable creating public IP addresses for VMs. Roles that allow users to assing public IP addresses to VMs are `admin`, `editor`, `vpc.admin`, and `vpc.publicAdmin`.
* If there is a public IP address assigned to a VM, [detach](../../compute/operations/vm-control/vm-detach-public-ip.md) the address and [delete](../../vpc/operations/address-delete.md) it if this address is static.

### {{ vpc-name }} {#virtualprivatecloud}

A cloud network must not contain any [NAT gateways](../../vpc/concepts/gateways.md) that can be used to provide internet access to cloud resources.

{% list tabs group=instructions %}

- Management console {#console}

   1. Open the [management console]({{ link-console-main }}) in your browser.
   1. Go to the appropriate folder.
   1. Go to **{{ ui-key.yacloud.component.navigation-menu.label_vpc }} / {{ ui-key.yacloud.vpc.gateways.label_gateways }}**.
   1. Make sure you see the `No gateways` message. Otherwise, proceed to **Guides and solutions to use**.

- CLI {#cli}

   1. View the available organizations and write down the `ID` you need:
      
      ```
      yc organization-manager organization list
      ```

   1. Run the command below to search for NAT gateways:
      
      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do NAT_GW_LIST=$(yc vpc gateway list --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(.id)' | jq -r '.id');
      if [ -n "$NAT_GW_LIST" ]; then printf "FOLDER_ID: $FOLDER_ID\nNAT_GW:\n$NAT_GW_LIST\n-----\n"; fi;
      done;
      done
      ```

   1. The command output should be empty. Otherwise, proceed to **Guides and solutions to use**.

{% endlist %}

**Guides and solutions to use**:
* Do not assign user [roles](../../vpc/security/) that enable creating NAT gateways. Roles with permissions to create NAT gateways are `admin`, `editor`, `vpc.gateways.editor`, `vpc.admin`, and `vpc.publicAdmin`.
* If there are any NAT gateways, [delete](../../vpc/operations/delete-nat-gateway.md) them.

### {{ network-load-balancer-name }} {#networkloadbalancer}

In [{{ network-load-balancer-name }}](../../network-load-balancer/concepts/), the following load balancer options are available:
* External load balancer created by default. It has a public IP address and handles internet traffic. 
* Internal load balancer used to handle traffic in {{ vpc-short-name }}. It has an internal IP address.

There must be no external load balancers in cloud infrastructure. You may use internal load balancers. 

{% list tabs group=instructions %}

- Management console {#console}

   1. Open the [management console]({{ link-console-main }}) in your browser.
   1. Go to the appropriate folder.
   1. Go to **{{ ui-key.yacloud.component.navigation-menu.label_load-balancer }} / {{ ui-key.yacloud.load-balancer.network-load-balancer.label_list }}**.
   1. Make sure there are no `EXTERNAL` load balancers in the list. Otherwise, proceed to **Guides and solutions to use**.

- CLI {#cli}

   1. View the available organizations and write down the `ID` you need:
      
      ```
      yc organization-manager organization list
      ```
      
   1. Run the command below to search for external load balancers:
      
      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do NLB_LIST=$(yc load-balancer network-load-balancer list --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(.type == "EXTERNAL")' | jq -r '.id');
      if [ -n "$NLB_LIST" ]; then printf "FOLDER_ID: $FOLDER_ID\nNLB_ID:\n$NLB_LIST\n-----\n"; fi;
      done;
      done
      ```
      
   1. The command output should be empty. Otherwise, proceed to **Guides and solutions to use**.

{% endlist %}

**Guides and solutions to use**:
* Do not assign user [roles](../../network-load-balancer/security/) that enable creating external load balancers. Roles with permissions to create external load balancers are `admin`, `editor`, `load-balancer.admin`.
* If there are any external load balancers, [delete](../../network-load-balancer/operations/load-balancer-delete) them.

### {{ alb-name }} {#applicationloadbalancer}

In [{{ alb-name }}](../../application-load-balancer/concepts/application-load-balancer), L7 load balancer listeners must not have public IP addresses. You may assign internal IP addresses to listeners.

{% list tabs group=instructions %}

- Management console {#console}

   1. Open the [management console]({{ link-console-main }}) in your browser.
   1. Go to the appropriate folder.
   1. Go to **{{ ui-key.yacloud.component.navigation-menu.label_vpc }} / {{ ui-key.yacloud.vpc.addresses.label_title }}**.
   1. Make sure that the reserved public IP addresses are not assigned to L7 load balancer listeners or that you see this message: `You do not have public IP addresses yet`. Otherwise, proceed to **Guides and solutions to use**.

- CLI {#cli}

   1. View the available organizations and write down the `ID` you need:
      
      ```
      yc organization-manager organization list
      ```
      
   1. Run the command below to search for L7 load balancers with public IP addresses assigned to listeners:
      
      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do ALB_LIST=$(yc application-load-balancer load-balancer list --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(has("listeners")) | select(.listeners[].endpoints[].addresses[].external_ipv4_address)' | jq -r '.id' );
      if [ -n "$ALB_LIST" ]; then printf "FOLDER_ID: $FOLDER_ID\nALB_ID:\n$ALB_LIST\n-----\n" | sort -u; fi;
      done;
      done
      ```

   1. The command output should be empty. Otherwise, proceed to **Guides and solutions to use**.

{% endlist %}

**Guides and solutions to use**:
* Do not grant user [roles](../../application-load-balancer/security/) that enable assigning public IP address to L7 load balancer listeners. Roles with permissions to assign public IP addresses to L7 load balancer listeners are `admin`, `editor`, `vpc.admin`, and `vpc.publicAdmin`.
* If there are public IP addresses assigned to L7 load balancer listeners, [delete these listeners](../../application-load-balancer/operations/application-load-balancer-update.md#delete-listener). If the addresses are static, [delete](../../vpc/operations/address-delete.md) them as well.

### {{ managed-k8s-name }} {#managedserviceforkubernetes}

Your {{ managed-k8s-name }} cluster and node group must not have [public IP addresses](../../managed-kubernetes/concepts/network.md#public-access-to-a-host). The cloud network hosting the cluster and node group must have no [NAT gateaways](../../vpc/concepts/gateways.md). Do not assign roles that enable creating load balancers with internet access to cluster service accounts (see **Guides and solutions to use**).

For more information about creating and configuring a {{ managed-k8s-name }} cluster with no internet access, see this [tutorial](../../managed-kubernetes/tutorials/k8s-cluster-with-no-internet.md). The tutorial lists the minimum roles you need to assign to service accounts to create such a cluster.

{% list tabs group=instructions %}

- Management console {#console}

   {% note info %}
   
   If using the console, you will have to check each cluster separately for public access. We recommend using the CLI if you need to check a large number of clusters.
   
   {% endnote %}

   {% note info %}
   
   Checks performed using the console do not return public IP addresses of stopped cluster nodes. To get the addresses of all the clusters, use the CLI.
   
   {% endnote %}

   1. Open the [management console]({{ link-console-main }}) in your browser.
   1. Go to the appropriate folder.
   1. Go to **{{ ui-key.yacloud.component.navigation-menu.label_managed-kubernetes }}** and select the cluster.
   1. Make sure the cluster has no `Public IPv4` field in the **{{ ui-key.yacloud.k8s.cluster.overview.label_title }}** tab. Otherwise, proceed to **Guides and solutions to use**.
   1. Go to **{{ ui-key.yacloud.component.navigation-menu.label_vpc }} / {{ ui-key.yacloud.vpc.addresses.label_title }}**.
   1. Make sure that no reserved public IP addresses are assigned to VMs (cluster nodes) or L7 load balancers or that you see this message: `You do not have public IP addresses yet`. Otherwise, proceed to **Guides and solutions to use**.
   1. Go to **{{ ui-key.yacloud.component.navigation-menu.label_vpc }} / {{ ui-key.yacloud.vpc.gateways.label_gateways }}**.
   1. Make sure you see the `No gateways` message. Otherwise, proceed to **Guides and solutions to use**.
   1. Go to **{{ ui-key.yacloud.component.navigation-menu.label_load-balancer }} / {{ ui-key.yacloud.load-balancer.network-load-balancer.label_list }}**.
   1. Make sure there are no `EXTERNAL` load balancers in the list. Otherwise, proceed to **Guides and solutions to use**.

- CLI {#cli}

   1. View the available organizations and write down the `ID` you need:
      
      ```
      yc organization-manager organization list
      ```
      
   1. Run the command below to search for clusters with public IP addresses:
      
      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id');
      do CLUSTER_LIST=$(yc managed-kubernetes cluster list --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(.master.endpoints.external_v4_endpoint)' | jq -r '.id');
      if [ -n "$CLUSTER_LIST" ]; then printf "FOLDER_ID: $FOLDER_ID\nK8S_CLUSTER_ID:\n$CLUSTER_LIST\n-----\n"; fi;
      done;
      done
      ```

   1. Run the command below to search for node groups with public IP addresses:
      
      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do NODE_GROUP_LIST=$(yc managed-kubernetes node-group list --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(.node_template.network_interface_specs[].primary_v4_address_spec.one_to_one_nat_spec)' | jq -r '.id');
      if [ -n "$NODE_GROUP_LIST" ]; then printf "FOLDER_ID: $FOLDER_ID\nNODE_GROUP:\n$NODE_GROUP_LIST\n-----\n"; fi;
      done;
      done
      ```
      
   1. Run the command below to search for NAT gateways:
      
      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do NAT_GW_LIST=$(yc vpc gateway list --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(.id)' | jq -r '.id');
      if [ -n "$NAT_GW_LIST" ]; then printf "FOLDER_ID: $FOLDER_ID\nNAT_GW:\n$NAT_GW_LIST\n-----\n"; fi;
      done;
      done
      ```
      
   1. Run the command below to search for external network load balancers (NLB):
      
      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do NLB_LIST=$(yc load-balancer network-load-balancer list --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(.type == "EXTERNAL")' | jq -r '.id');
      if [ -n "$NLB_LIST" ]; then printf "FOLDER_ID: $FOLDER_ID\nNLB_ID:\n$NLB_LIST\n-----\n"; fi;
      done;
      done
      ```
      
   1. Run the command below to search for L7 load balancers with public IP addresses assigned to listeners:
      
      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do ALB_LIST=$(yc application-load-balancer load-balancer list --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(has("listeners")) | select(.listeners[].endpoints[].addresses[].external_ipv4_address)' | jq -r '.id' );
      if [ -n "$ALB_LIST" ]; then printf "FOLDER_ID: $FOLDER_ID\nALB_ID:\n$ALB_LIST\n-----\n" | sort -u; fi;
      done;
      done
      ```

   1. The outputs of all these commands should be empty. Otherwise, proceed to **Guides and solutions to use**.

{% endlist %}

**Guides and solutions to use**:
* Do not grant {{ k8s }} cluster service accounts [roles](../../managed-kubernetes/security/), that enable assigning public IP addresses to a cluster or a node group as well as creating load balancers with internet access. Roles with permissions to create a cluster with internet access: `admin`, `editor`, `load-balancer.admin`, `vpc.admin`, and `vpc.publicAdmin`.
* If there are any clusters with public IP addresses, [delete](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md) them. You cannot delete a public IP address for such clusters. Before deleting the clusters, move their workload to Kubernetes clusters without public IP addresses.
* If there are any node groups with public IP addresses, [update](../../managed-kubernetes/operations/node-group/node-group-update.md) them so that nodes do not get public IP addresses.
* If there are any external load balancers for [Service resources](../../managed-kubernetes/nlb-ref/service.md), delete them. 
* If there are any public IP addresses assigned to [{{ alb-name }} controllers](../../managed-kubernetes/alb-ref/ingress.md), delete them. 
* Do not assign user [roles](../../vpc/security/) that enable creating NAT gateways. Roles with permissions to create NAT gateways are `admin`, `editor`, `vpc.gateways.editor`, `vpc.admin`, and `vpc.publicAdmin`.
* If there are any NAT gateways, [delete](../../vpc/operations/delete-nat-gateway.md) them.


### {{ mpg-name }} {#managedserviceforpostgresql}

[Public access](../../managed-postgresql/concepts/network.md#public-access-to-a-host) must be disabled for cluster hosts.

{% list tabs group=instructions %}

- Management console {#console}

   {% note info %}
   
   If using the console, you will have to check hosts for public access separately in each cluster. We recommend using the CLI if you need to check a large number of clusters.
   
   {% endnote %}

   1. Open the [management console]({{ link-console-main }}) in your browser.
   1. Go to the appropriate folder.
   1. Go to **{{ ui-key.yacloud.component.navigation-menu.label_managed-postgresql }}**. Go to the cluster and then go to **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}**. 
   1. Make sure the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_public-ip }}** column indicates `No` for all cluster hosts. Otherwise, proceed to **Guides and solutions to use**.

- CLI {#cli}

   1. View the available organizations and write down the `ID` you need:
      
      ```
      yc organization-manager organization list
      ```
      
   1. Run the command below to search for hosts with public IP addresses in clusters:
      
      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do for PG_CLUSTER_ID in $(yc managed-postgresql cluster list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id');
      do HOST_LIST=$(yc managed-postgresql hosts list --cluster-id=$PG_CLUSTER_ID --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(.assign_public_ip)' | jq -r '.name' );
      if [ -n "$HOST_LIST" ]; then printf "FOLDER_ID: $FOLDER_ID\nPG_CLUSTER_ID: $PG_CLUSTER_ID\nHOST_NAME:\n$HOST_LIST\n-----\n"; fi
      done;
      done;
      done
      ```

   1. The command output should be empty. Otherwise, proceed to **Guides and solutions to use**.

{% endlist %}

**Guides and solutions to use**:
* Do not assign user [roles](../../managed-postgresql/security/) that enable configuring public access for cluster hosts. Roles with permissions to configure public access to hosts are `admin`, `editor`, `vpc.admin`, and `vpc.publicAdmin`.
* If there are cluster hosts with public access enabled, [disable](../../managed-postgresql/operations/hosts.md#update) it.

### {{ mch-name }} {#managedserviceforclickhouse}

[Public access](../../managed-clickhouse/concepts/network.md#public-access-to-a-host) must be disabled for cluster hosts.

{% list tabs group=instructions %}

- Management console {#console}

   {% note info %}

   If using the console, you will have to check hosts for public access separately in each cluster. We recommend using the CLI if you need to check a large number of clusters.

   {% endnote %}

   1. Open the [management console]({{ link-console-main }}) in your browser.
   1. Go to the appropriate folder.
   1. Go to **{{ ui-key.yacloud.component.navigation-menu.label_managed-clickhouse }}**. Go to the cluster and then go to **{{ ui-key.yacloud.clickhouse.cluster.switch_hosts }}**. 
   1. Make sure the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_public-ip }}** column indicates `No` for all cluster hosts. Otherwise, proceed to **Guides and solutions to use**.

- CLI {#cli}

   1. View the available organizations and write down the `ID` you need:
      
      ```
      yc organization-manager organization list
      ```
      
   1. Run the command below to search for hosts with public IP addresses in clusters:
      
      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do for CH_CLUSTER_ID in $(yc managed-clickhouse cluster list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id');
      do HOST_LIST=$(yc managed-clickhouse hosts list --cluster-id=$CH_CLUSTER_ID --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(.assign_public_ip)' | jq -r '.name' );
      if [ -n "$HOST_LIST" ]; then printf "FOLDER_ID: $FOLDER_ID\nCH_CLUSTER_ID: $CH_CLUSTER_ID\nHOST_NAME:\n$HOST_LIST\n-----\n"; fi
      done;
      done;
      done
      ```

   1. The command output should be empty. Otherwise, proceed to **Guides and solutions to use**.

{% endlist %}

**Guides and solutions to use**:
* Do not assign user [roles](../../managed-clickhouse/security) that enable configuring public access to cluster hosts. Roles with permissions to configure public access to hosts are `admin`, `editor`, `vpc.admin`, and `vpc.publicAdmin`.
* If there are cluster hosts with public access enabled, [disable](../../managed-clickhouse/operations/hosts.md#update) it.

### {{ sf-name }} and {{ serverless-containers-name }} {#cloudfunctionsiserverlesscontainers}

There must be no functions or containers in the cloud infrastructure. 

By default, a container or function is launched in an isolated IP network with an enabled NAT gateway. Functions and containers provide access to public IPv4 addresses. [Function](../../functions/concepts/networking.md#user-network) or [container](../../serverless-containers/concepts/networking.md#user-network) settings may specify a cloud network. In this case, the function will have access both to the internet and user resources in the specified {{ vpc-short-name }}, such as databases, VMs, etc.

{% list tabs group=instructions %}

- Management console {#console}

   1. Open the [management console]({{ link-console-main }}) in your browser.
   1. Go to the appropriate folder.
   1. Go to **{{ ui-key.yacloud.component.navigation-menu.label_serverless-functions }}**.
   1. Make sure you see the `Create your first function` message. Otherwise, proceed to **Guides and solutions to use**.
   1. Go to **{{ ui-key.yacloud.component.navigation-menu.label_serverless-containers }}**.
   1. Make sure you see the `Create your first container` message. Otherwise, proceed to **Guides and solutions to use**.

- CLI {#cli}

   1. View the available organizations and write down the `ID` you need:
      
      ```
      yc organization-manager organization list
      ```
      
   1. Run the command below to search for functions:
      
      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do FUNC_LIST=$(yc serverless function list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id');
      if [ -n "$FUNC_LIST" ]; then printf "FOLDER_ID: $FOLDER_ID\nFUNCTION_ID:\n$FUNC_LIST\n-----\n"; fi;
      done;
      done
      ```
      
   1. The command output should be empty. Otherwise, proceed to **Guides and solutions to use**.

   1. Run the command below to search for containers:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do CONT_LIST=$(yc serverless containers list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id');
      if [ -n "$CONT_LIST" ]; then printf "FOLDER_ID: $FOLDER_ID\nCONTAINER_ID:\n$CONT_LIST\n-----\n"; fi;
      done;
      done
      ```

   1. The command output should be empty. Otherwise, proceed to **Guides and solutions to use**.

{% endlist %}

**Guides and solutions to use**:
* Do not assign user roles that enable creating functions and containers. [Roles](../../functions/security/) with permissions to create functions: `admin`, `editor`, `functions.admin`, and `functions.editor`. [Roles](../../serverless-containers/security/) with permissions to create containers: `admin`, `editor`, `serverless-containers.admin`, and `serverless-containers.editor`.
* [Delete the functions](../../functions/operations/function/function-delete.md) or [containers](../../serverless-containers/operations/delete.md) if there are any.
