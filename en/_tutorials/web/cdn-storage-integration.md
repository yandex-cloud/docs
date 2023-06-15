# Integrating L7 load balancer with {{ cdn-short-name }} and {{ objstorage-short-name }}

In this tutorial a {{ objstorage-full-name }} bucket is used as the {{ alb-full-name }} L7 load balancer backend. User requests are transmitted to the load balancer via the {{ cdn-full-name }} content delivery network (CDN) that reduces the time of content delivery.

We will use the `cdn.yandexcloud.example` domain name as an example.

To perform steps, you can use various [supported tools](#supported-tools).

To build architecture for integrating an L7 load balancer with CDN and Object Storage:

1. [Prepare your cloud](#before-you-begin).
1. [Create a cloud network and subnets](#create-network).
1. [Create a bucket in {{ objstorage-name }}](#create-buckets).
1. [Upload the file of your service to the bucket](#upload-files).
1. [Create a security group](#create-security-group).
1. [Create {{ alb-name }} backend groups](#create-l7backend).
1. [Create an HTTP router and a virtual host](#create-route-hosts).
1. [Create an L7 load balancer](#create-balancer).
1. [Create a CDN resource](#create-cdn-resource).
1. [Configure DNS for the service](#configure-dns).
1. [Run a health check for the service](#check).

If you no longer need the resources you created, [delete them](#clear-out).

## Supported tools {#supported-tools}

You can complete most of the steps in the tutorial in any standard tool, such as the [management console]({{ link-console-main }}), [{{ yandex-cloud }}](../../cli/) and [AWS](../../storage/tools/aws-cli.md) CLIs, {{ TF }}, and the [{{ yandex-cloud }} API](../../api-design-guide). Each step lists tools supported for it.

Some steps do not support certain tools:

* Currently, you cannot use CLIs and {{ TF }} to:
   * [Create a {{ alb-name }} backend group with buckets as backends](#create-l7backend).
   * Get the domain name of a CDN load balancer when [configuring DNS for the service](#configure-dns).
* Currently, you cannot get the domain name of a CDN load balancer when [configuring DNS for the service](#configure-dns).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

We use a folder named `example-folder` as an example.


### Required paid resources {#paid-resources}

The cost of this infrastructure includes:

* Fee for data storage in {{ objstorage-name }}, operations with data, and outgoing traffic (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).
* Fee for using computing resources of the L7 load balancer (see [{{ alb-name }} pricing](../../application-load-balancer/pricing.md)).
* Fee for outgoing traffic from CDN servers (see [{{ cdn-name }} pricing](../../cdn/pricing.md)).
* Fee for public DNS queries and DNS zones if you use {{ dns-full-name }} (see [{{ dns-name }} pricing](../../dns/pricing.md)).


## Create a cloud network and subnets {#create-network}

All resources belong to the same [cloud network](../../vpc/concepts/network.md).

To create a network and subnets:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select `example-folder`.
   1. In the list of services, select **{{ vpc-name }}**.
   1. Click **Create network**.
   1. Specify the **Name** of the network: `example-network`.
   1. In the **Advanced** field, select **Create subnets**.
   1. Click **Create network**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Create a network named `example-network`:

      ```bash
      yc vpc network create example-network
      ```

      Result:

      ```
      id: enptrcle5q3d3ktd33hj
      folder_id: b1g9hv2loamqfnbul7d9
      created_at: "2022-04-04T05:25:03Z"
      name: example-network
      default_security_group_id: enpbsnnop4akg7ng70ll
      ```

      For more information about the `yc vpc network create` command, see the [CLI reference](../../cli/cli-ref/managed-services/vpc/network/create.md).

   1. Create subnets in all availability zones.

      * In `{{ region-id }}-a`:

         ```bash
         yc vpc subnet create example-subnet-{{ region-id }}-a \
           --zone {{ region-id }}-a \
           --network-name example-network \
           --range 10.1.0.0/16
         ```

         Result:

         ```
         id: e9bnnssj8sc8mjhat9qk
         folder_id: b1g9hv2loamqfnbul7d9
         created_at: "2022-04-04T09:27:00Z"
         name: example-subnet-{{ region-id }}-a
         network_id: enptrcle5q3d3ktd33hj
         zone_id: {{ region-id }}-a
         v4_cidr_blocks:
         - 10.1.0.0/16
         ```

      * In `{{ region-id }}-b`:

         ```bash
         yc vpc subnet create example-subnet-{{ region-id }}-b \
           --zone {{ region-id }}-b \
           --network-name example-network \
           --range 10.2.0.0/16
         ```

         Result:

         ```
         id: e2lghukd9iqo4haidjbt
         folder_id: b1g9hv2loamqfnbul7d9
         created_at: "2022-04-04T09:27:39Z"
         name: example-subnet-{{ region-id }}-b
         network_id: enptrcle5q3d3ktd33hj
         zone_id: {{ region-id }}-b
         v4_cidr_blocks:
         - 10.2.0.0/16
         ```

      * In `{{ region-id }}-c`:

         ```bash
         yc vpc subnet create example-subnet-{{ region-id }}-c \
           --zone {{ region-id }}-c \
           --network-name example-network \
           --range 10.3.0.0/16
         ```

         Result:

         ```
         id: b0c3pte4o2kn4v12o05p
         folder_id: b1g9hv2loamqfnbul7d9
         created_at: "2022-04-04T09:28:08Z"
         name: example-subnet-{{ region-id }}-c
         network_id: enptrcle5q3d3ktd33hj
         zone_id: {{ region-id }}-c
         v4_cidr_blocks:
         - 10.3.0.0/16
         ```

      For more information about the `yc vpc subnet create` command, see the [CLI reference](../../cli/cli-ref/managed-services/vpc/subnet/create.md).

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the configuration file, describe the parameters of `example-network` and its subnets: `example-subnet-{{ region-id }}-a`, `example-subnet-{{ region-id }}-b`, and `example-subnet-{{ region-id }}-c`:

      ```hcl
      resource "yandex_vpc_network" "example-network" {
        name = "example-network"
      }

      resource "yandex_vpc_subnet" "example-subnet-a" {
        name           = "example-subnet-{{ region-id }}-a"
        zone           = "{{ region-id }}-a"
        network_id     = "${yandex_vpc_network.example-network.id}"
        v4_cidr_blocks = ["10.1.0.0/16"]
      }

      resource "yandex_vpc_subnet" "example-subnet-b" {
        name           = "example-subnet-{{ region-id }}-b"
        zone           = "{{ region-id }}-b"
        network_id     = "${yandex_vpc_network.example-network.id}"
        v4_cidr_blocks = ["10.2.0.0/16"]
      }

      resource "yandex_vpc_subnet" "example-subnet-c" {
        name           = "example-subnet-{{ region-id }}-c"
        zone           = "{{ region-id }}-c"
        network_id     = "${yandex_vpc_network.example-network.id}"
        v4_cidr_blocks = ["10.3.0.0/16"]
      }
      ```

      Learn more in the description of the [yandex_vpc_network]({{ tf-provider-link }}/vpc_network) and [yandex_vpc_subnet]({{ tf-provider-link }}/vpc_subnet) resources in the {{ TF }} provider documentation.

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm that you want to create the resources.

- API

   1. Create a network named `example-network` using the [NetworkService/Create](../../vpc/api-ref/grpc/network_service.md#Create) gRPC API call or the [create](../../vpc/api-ref/Network/create.md) REST API method.
   1. Create the `example-subnet-{{ region-id }}-a`, `example-subnet-{{ region-id }}-b` and `example-subnet-{{ region-id }}-c` in the three availability zones by calling the gRPC API [SubnetService/Create](../../vpc/api-ref/grpc/subnet_service.md#Create) or the REST API [create](../../vpc/api-ref/Subnet/create.md) method.

{% endlist %}

## Create a bucket in {{ objstorage-name }} {#create-buckets}

Create a bucket named `example-bucket`:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select `example-folder`.
   1. In the list of services, select **{{ objstorage-name }}**.
   1. Create a bucket named `example-bucket`:

      1. Click **Create bucket**.
      1. Specify the **name** of the bucket: `example-bucket`.
      1. In the **Object read access** and **Object listing access** fields, select **Public**.
      1. Click **Create bucket**.


- AWS CLI

   1. Create a bucket named `example-bucket`:

      ```bash
      aws --endpoint-url https://{{ s3-storage-host }} \
        s3 mb s3://example-bucket
      ```

      Result:

      ```
      make_bucket: s3://example-bucket
      ```

   1. Enable public access to reading objects and their list:

      ```bash
      aws --endpoint-url https://{{ s3-storage-host }} \
        s3api put-bucket-acl \
        --bucket example-bucket \
        --acl public-read
      ```

- {{ TF }}

   1. Add the parameters of the `example-bucket` bucket to the configuration file:

      ```hcl
      ...

      resource "yandex_storage_bucket" "example-bucket" {
        bucket = "example-bucket"
        acl    = "public-read"
      }
      ```

      For more information about the `yandex_storage_bucket` resource, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/storage_bucket).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm that you want to create the resources.

- API

   Use the [create](../../storage/s3/api-ref/bucket/create.md) REST API method.

{% endlist %}

## Upload the file of your service to the bucket {#upload-files}

1. Create an `index.html` file.

   {% cut "Example of the index.html file" %}

   ```html
   <!DOCTYPE html>
   <html>
     <head>
       <title>My service</title>
     </head>
     <body>
       <p>The service is working</p>
     </body>
   </html>
   ```

   {% endcut %}

1. Upload a file to the bucket:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select `example-folder`.
      1. In the list of services, select **{{ objstorage-name }}**.
      1. In the bucket list, select `example-bucket`.
      1. Click **Upload** and select the `index.html` file for uploading.

   - AWS CLI

      1. Upload `index.html` to the `example-bucket` file:

         ```bash
         aws --endpoint-url https://{{ s3-storage-host }} \
           s3 cp v1/index.html s3://example-bucket/index.html
         ```

         Result:

         ```
         upload: v1/index.html to s3://example-bucket/index.html
         ```

   - {{ TF }}

      1. Add the parameters of the `v1/index.html` file uploaded to the `example-bucket`, to the configuration file:

         ```hcl
         ...

         resource "yandex_storage_object" "example-bucket-index" {
           bucket = "example-bucket"
           key    = "index.html"
           source = "v1/index.html"
         }
         ```

         For more information about the `yandex_storage_object` resource, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/storage_object).

      1. Make sure the configuration files are valid.

         1. In the command line, go to the directory where you created the configuration file.
         1. Run the check using this command:

            ```bash
            terraform plan
            ```

         If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

      1. Deploy cloud resources.

         1. If the configuration does not contain any errors, run this command:

            ```bash
            terraform apply
            ```

         1. Confirm that you want to create the resources.

   - API

      Use the [upload](../../storage/s3/api-ref/object/upload.md) REST API method.

   {% endlist %}

## Create a security group {#create-security-group}

{% note info %}

{% include [security-groups-note](../../_includes/vpc/security-groups-note-services.md) %}

{% endnote %}

[Security groups](../../vpc/concepts/security-groups.md) contain rules that allow the L7 load balancer to receive incoming traffic and send it to backend buckets.

To create security groups:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ vpc-name }}**.
   1. Click the **Security groups** tab.
   1. Click **Create group**.
   1. Enter the **Name** of the group: `example-sg`.
   1. Select the `example-network` **network**:
   1. Under **Rules**, create the following rules using the instructions below the table:

      | Traffic<br/>direction | Description | Port<br/>range | Protocol | Source/<br/>destination type | Source /<br/>destination |
      | --- | --- | --- | --- | --- | --- |
      | Outgoing | any | All | Any | CIDR | 0.0.0.0/0 |
      | Incoming | ext-http | 80 | TCP | CIDR | 0.0.0.0/0 |
      | Incoming | ext-https | 443 | TCP | CIDR | 0.0.0.0/0 |
      | Incoming | healthchecks | 30080 | TCP | Load balancer health checks | N/A |

      1. Go to the **Outgoing traffic** or **Incoming traffic** tab.
      1. Click **Add rule**.
      1. In the **Port range** field of the window that opens, specify a single port or a range of ports that traffic will come to or from.
      1. In the **Protocol** field, specify the desired protocol or leave **Any** to allow traffic transmission over any protocol.
      1. In the **Purpose** or **Source** field, select the purpose of the rule:

         * **CIDR**: Rule will apply to the range of IP addresses. In the **CIDR blocks** field, specify the CIDR and masks of subnets that traffic will come to or from. To add multiple CIDRs, click **Add CIDR**.
         * **Security group**: Rule will apply to the VMs from the current group or the selected security group.
         * **Load balancer health checks**: Rule that allows a load balancer to check the health of VMs.

      1. Click **Save**. Repeat the steps to create all rules from the table.

   1. Click **Save**.

- CLI

   Run the following command:

   ```bash
   yc vpc security-group create example-sg \
     --network-name example-network \
     --rule direction=egress,port=any,protocol=any,v4-cidrs=[0.0.0.0/0] \
     --rule direction=ingress,port=80,protocol=tcp,v4-cidrs=[0.0.0.0/0] \
     --rule direction=ingress,port=443,protocol=tcp,v4-cidrs=[0.0.0.0/0] \
     --rule direction=ingress,port=30080,protocol=tcp,predefined=loadbalancer_healthchecks
   ```

   Result:

   ```
   id: enpd133ngcnrgc8475cc
   folder_id: b1g9hv2loamqfnbul7d9
   created_at: "2022-04-04T10:26:16Z"
   name: example-sg
   network_id: enptrcle5q3d3ktd33hj
   status: ACTIVE
   rules:
   - id: enpkgrpi2gsibdm6aotd
     direction: EGRESS
     protocol_name: ANY
     protocol_number: "-1"
     cidr_blocks:
       v4_cidr_blocks:
       - 0.0.0.0/0
   - id: enpgssij0i168jknb85r
     direction: INGRESS
     ports:
       from_port: "80"
       to_port: "80"
     protocol_name: TCP
     protocol_number: "6"
     cidr_blocks:
       v4_cidr_blocks:
       - 0.0.0.0/0
   - id: enp0bft67j9lrlnhdur5
     direction: INGRESS
     ports:
       from_port: "443"
       to_port: "443"
     protocol_name: TCP
     protocol_number: "6"
     cidr_blocks:
       v4_cidr_blocks:
       - 0.0.0.0/0
   - id: enpmorcimu65fk4oaanm
     direction: INGRESS
     ports:
       from_port: "30080"
       to_port: "30080"
     protocol_name: TCP
     protocol_number: "6"
     predefined_target: loadbalancer_healthchecks
   ```

   For more information about the `yc vpc security-group create` command, see the [CLI reference](../../cli/cli-ref/managed-services/vpc/security-group/create.md).

- {{ TF }}

   1. Add the `example-sg` security group parameters to the configuration file:

      ```hcl
      resource "yandex_vpc_security_group" "example-sg" {
        name       = "example-sg"
        network_id = "yandex_vpc_network.example-network.id"

        egress {
          protocol       = "ANY"
          from_port      = 0
          to_port        = 65535
          v4_cidr_blocks = ["0.0.0.0/0"]
        }

        ingress {
          protocol       = "TCP"
          port           = 80
          v4_cidr_blocks = ["0.0.0.0/0"]
        }

        ingress {
          protocol       = "TCP"
          port           = 443
          v4_cidr_blocks = ["0.0.0.0/0"]
        }

        ingress {
          protocol          = "TCP"
          port              = 30080
          predefined_target = "loadbalancer_healthchecks"
        }
      }
      ```

      For more information about resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/vpc_security_group).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm that you want to create the resources.

- API

   Use the [SecurityGroupService/Create](../../vpc/api-ref/grpc/security_group_service.md#Create) gRPC API call or the [create](../../vpc/api-ref/SecurityGroup/create.md) REST API method.

   To add a rule for load balancer health checks, use the `loadbalancer_healthchecks` parameter in the [SecurityGroupRuleSpec.target.predefined_target](../../vpc/api-ref/grpc/security_group_service.md#SecurityGroupRuleSpec) field for the gRPC API or the [predefinedTarget](../../vpc/api-ref/SecurityGroup/create.md#body_params) field for the REST API.

{% endlist %}

## Create {{ alb-name }} backend groups {#create-l7backend}

{% list tabs %}

- Management console

   1. Create the `example-bg` backend group with the `example-backend` backend:

      1. In the [management console]({{ link-console-main }}), select `example-folder`.
      1. In the list of services, select **{{ alb-name }}** and go to the **Backend groups** tab.
      1. Click **Create backend group**.
      1. Name the backend group: `example-bg`.
      1. Select **HTTP** as the [backend group type](../../application-load-balancer/concepts/backend-group.md#group-types).
      1. Under **Backends**, click **Add**. Specify the backend settings:
         1. Enter the backend name: `example-backend`.
         1. Set the weight of the backend: `100`.
         1. Select **Bucket** as the [backend type](../../application-load-balancer/concepts/backend-group.md#types).
         1. In the **Bucket** field, enter the bucket name: `example-bucket`.
      1. Click **Create**.

   1. If you are going to complete the next steps in {{ TF }}, copy the ID of the `example-bg` backend group from the **Backend groups** tab.

- API

   Use the [BackendGroupService/Create](../../application-load-balancer/api-ref/grpc/backend_group_service.md#Create) gRPC API call or the [create](../../application-load-balancer/api-ref/BackendGroup/create.md) REST API method.

{% endlist %}

## Create an HTTP router and virtual hosts {#create-route-hosts}

Create an HTTP router with a virtual host: `cdn.mywebsite.com`:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select `example-folder`.
   1. In the list of services, select **{{ alb-name }}** and go to the **HTTP routers** tab.
   1. Click **Create HTTP router**.
   1. Enter the router name: `example-router`.
   1. Create the `example-vh` virtual host:

      1. Under **Virtual hosts**, click **Add virtual host**.
      1. Enter the hostname: `example-vh`.
      1. Specify the value for **Authority**: `cdn.yandexcloud.example`
      1. Click **Add route**.
      1. Enter the **Name**: `example-route`.
      1. In the **Path** field, select **Starts with** and specify the path `/`.
      1. In the **HTTP methods** list, select **GET**.
      1. In the **Action** field, leave the **Routing** value.
      1. In the **Backend group** list, select `example-bg`.

   1. Leave all other settings as they are and click **Create**.

- CLI

   1. Create the `example-router` HTTP Router:

      ```bash
      yc alb http-router create example-router
      ```

      Result:

      ```
      id: ds7qd0vj01djuu3c6f8q
      name: example-router
      folder_id: b1g9hv2loamqfnbul7d9
      created_at: "2022-04-04T10:31:41.027649223Z"
      ```

      For more information about the `yc alb http-router create` command, see the [CLI reference](../../cli/cli-ref/managed-services/application-load-balancer/http-router/create.md).

   1. Create the `example-vh` virtual host:

      ```bash
      yc alb virtual-host create example-vh \
        --http-router-name example-router \
        --authority cdn.yandexcloud.example
      ```

      Result:

      ```
      done (1s)
      name: example-vh
      authority:
      - cdn.yandexcloud.example
      ```

      For more information about the `yc alb virtual-host create` command, see the [CLI reference](../../cli/cli-ref/managed-services/application-load-balancer/virtual-host/create.md).

   1. Create the `example-route` route in the `example-vh` virtual host:

      ```bash
      yc alb virtual-host append-http-route example-route \
        --http-router-name example-router \
        --virtual-host-name example-vh \
        --prefix-path-match "/" \
        --backend-group-name example-bg
      ```

      Result:

      ```
      done (1s)
      name: example-vh
      authority:
      - cdn.yandexcloud.example
      routes:
      - name: example-route
        http:
          match:
            path:
              prefix_match: /
          route:
            backend_group_id: ds7pbm5fj2v09ptnn29p
      ```

      For more information about the `yc alb virtual-host append-http-route` command, see the [CLI reference](../../cli/cli-ref/managed-services/application-load-balancer/virtual-host/append-http-route.md).

- {{ TF }}

   1. Add parameters of the `example-router` HTTP router, its virtual hosts and routes, to the configuration file:

      ```hcl
      ...

      resource "yandex_alb_http_router" "example-router" {
        name = "example-router"
      }

      resource "yandex_alb_virtual_host" "example-vh" {
        name           = "example-vh"
        http_router_id = ${yandex_alb_http_router.example-router.id}
        authority      = "cdn.yandexcloud.example"

        route {
          name = "example-route"
          http_route {
            http_route_action {
              backend_group_id = "<ID_of_example-bg_backend_group>"
            }
          }
        }  
      }
      ```

      Learn more in the description of the [yandex_alb_http_router]({{ tf-provider-link }}/alb_http_router) and [yandex_alb_virtual_host]({{ tf-provider-link }}/alb_virtual_host) resources in the {{ TF }} provider documentation.

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm that you want to create the resources.

- API

   1. Create the `example-router` HTTP router using the gRPC API [HttpRouterService/Create](../../application-load-balancer/api-ref/grpc/http_router_service.md#Create) call or the [create](../../application-load-balancer/api-ref/HttpRouter/create.md) REST API method.
   1. Create the `example-vh` virtual host linked to the router and its route using the gRPC API [VirtualHostService/Create](../../application-load-balancer/api-ref/grpc/virtual_host_service.md#Create) call or the [create](../../application-load-balancer/api-ref/VirtualHost/create.md) REST API method.

{% endlist %}

## Create an L7 load balancer {#create-balancer}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select `example-folder`.
   1. In the list of services, select **{{ alb-name }}**, then click **Load balancers**.
   1. Click **Create L7 load balancer**.
   1. Enter the load balancer name: `example-balancer`.
   1. Under **Network settings**:

      1. Select the `example-network` **network**:
      1. Select the `example-sg` **security group**. If you leave this field blank, any incoming and outgoing traffic will be allowed for the load balancer.

   1. Under **Allocation**, select three subnets for the load balancer nodes: `example-subnet-{{ region-id }}-a`, `example-subnet-{{ region-id }}-b`, and `example-subnet-{{ region-id }}-c`, then enable traffic to these subnets.
   1. Click **Add listener** under **Listeners**. Set the listener settings:

      1. Enter the listener name: `example-listener`.
      1. Under **Public IP address settings**, enable traffic.
      1. Set the port to `80`.
      1. In the **Assign IP address** field, select **Automatically**.

   1. In the **HTTP router** field, select `example-router`.
   1. Click **Create**.

- CLI

   1. Get the IDs of subnets for `example-network`:

      ```bash
      yc vpc network list-subnets example-network
      ```

      Result:

      ```
      +----------------------+-----------------------------+----------------------+----------------------+----------------+---------------+---------------+
      |          ID          |            NAME             |      FOLDER ID       |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |     RANGE     |
      +----------------------+-----------------------------+----------------------+----------------------+----------------+---------------+---------------+
      | e9bnnssj8sc8mjhat9qk | example-subnet-{{ region-id }}-c | b1g9hv2loamqfnbul7d9 | enptrcle5q3d3ktd33hj |                | {{ region-id }}-c | [10.1.0.0/16] |
      | e2lghukd9iqo4haidjbt | example-subnet-{{ region-id }}-b | b1g9hv2loamqfnbul7d9 | enptrcle5q3d3ktd33hj |                | {{ region-id }}-b | [10.2.0.0/16] |
      | b0c3pte4o2kn4v12o05p | example-subnet-{{ region-id }}-a | b1g9hv2loamqfnbul7d9 | enptrcle5q3d3ktd33hj |                | {{ region-id }}-a | [10.3.0.0/16] |
      +----------------------+-----------------------------+----------------------+----------------------+----------------+---------------+---------------+
      ```

      For more information about the `yc vpc network list-subnets` command, see the [CLI reference](../../cli/cli-ref/managed-services/vpc/network/list-subnets.md).

   1. Get the `example-sg` security group ID:

      ```bash
      yc vpc security-group get example-sg | grep "^id"
      ```

      Result:

      ```
      id: enpd133ngcnrgc8475cc
      ```

      For more information about the `yc vpc security-group get` command, see the [CLI reference](../../cli/cli-ref/managed-services/vpc/security-group/get.md).

   1. Create a load balancer named `example-balancer`:

      ```bash
      yc alb load-balancer create example-balancer \
        --network-name example-network \
        --security-group-id <example-sg_security_group_ID> \
        --location zone={{ region-id }}-a,subnet-id=<example-subnet-{{ region-id }}-a_subnet_ID> \
        --location zone={{ region-id }}-b,subnet-id=<example-subnet-{{ region-id }}-b_subnet_ID> \
        --location zone={{ region-id }}-c,subnet-id=<example-subnet-{{ region-id }}-c_subnet_ID>
      ```

      Result:

      ```hcl
      done (3m0s)
      id: ds77q7v39b4ubg8ta2n4
      name: example-balancer
      folder_id: b1g9hv2loamqfnbul7d9
      status: ACTIVE
      region_id: {{ region-id }}
      network_id: enptrcle5q3d3ktd33hj
      allocation_policy:
        locations:
        - zone_id: {{ region-id }}-c
          subnet_id: b0c3pte4o2kn4v12o05p
        - zone_id: {{ region-id }}-b
          subnet_id: e2lghukd9iqo4haidjbt
        - zone_id: {{ region-id }}-a
          subnet_id: e9bnnssj8sc8mjhat9qk
      log_group_id: ckg23vr4dlkse3hvq0kc
      security_group_ids:
      - enpd133ngcnrgc8475cc
      created_at: "2022-04-04T10:55:49.134935148Z"
      ```

      For more information about the `yc alb load-balancer create` command, see the [CLI reference](../../cli/cli-ref/managed-services/application-load-balancer/load-balancer/create.md).

   1. Add a listener to the load balancer:

      ```bash
      yc alb load-balancer add-listener \
        --name example-balancer \
        --listener-name example-listener \
        --external-ipv4-endpoint port=80 \
        --http-router-name example-router
      ```

      Result:

      ```
      done (43s)
      id: ds77q7v39b4ubg8ta2n4
      name: example-balancer
      folder_id: b1g9hv2loamqfnbul7d9
      status: ACTIVE
      region_id: {{ region-id }}
      network_id: enptrcle5q3d3ktd33hj
      listeners:
      - name: example-listener
        endpoints:
        - addresses:
          - external_ipv4_address:
              address: 84.252.133.149
          ports:
          - "80"
        http:
          handler:
            http_router_id: ds7qd0vj01djuu3c6f8q
      allocation_policy:
        locations:
        - zone_id: {{ region-id }}-c
          subnet_id: b0c3pte4o2kn4v12o05p
        - zone_id: {{ region-id }}-b
          subnet_id: e2lghukd9iqo4haidjbt
        - zone_id: {{ region-id }}-a
          subnet_id: e9bnnssj8sc8mjhat9qk
      log_group_id: ckg23vr4dlkse3hvq0kc
      security_group_ids:
      - enpd133ngcnrgc8475cc
      created_at: "2022-04-04T10:55:49.134935148Z"
      ```

      For more information about the `yc alb load-balancer add-listener` command, see the [CLI reference](../../cli/cli-ref/managed-services/application-load-balancer/load-balancer/add-listener.md).

- {{ TF }}

   1. Add the parameters of the `example-balancer` L7 load balancer to the configuration file:

      ```hcl
      ...

      resource "yandex_alb_load_balancer" "example-balancer" {
        name               = "example-balancer"
        network_id         = ${yandex_vpc_network.example-network.id}
        security_group_ids = [ ${yandex_vpc_security_group.example-sg.id} ]

        allocation_policy {
          location {
            zone_id   = "{{ region-id }}-a"
            subnet_id = ${yandex_vpc_subnet.example-subnet-{{ region-id }}-a.id}
          }

          location {
            zone_id   = "{{ region-id }}-b"
            subnet_id = ${yandex_vpc_subnet.example-subnet-{{ region-id }}-b.id}
          }

          location {
            zone_id   = "{{ region-id }}-c"
            subnet_id = ${yandex_vpc_subnet.example-subnet-{{ region-id }}-c.id}
          }
        }

        listener {
          name = "example-listener"
          endpoint {
            address {
              external_ipv4_address {
              }
            }
            ports = [80]
          }
          http {
            handler {
              http_router_id = ${yandex_alb_http_router.example-router.id}
            }
          }
        }
      }
      ```

      For more information about the `yandex_alb_load_balancer` resource, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/alb_load_balancer).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm that you want to create the resources.

- API

   Use the [LoadBalancerService/Create](../../application-load-balancer/api-ref/grpc/load_balancer_service.md#Create) gRPC API call or the [create](../../application-load-balancer/api-ref/LoadBalancer/create.md) REST API method.

{% endlist %}

## Create a CDN resource {#create-cdn-resource}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select `example-folder`.
   1. In the list of services, select **{{ cdn-name }}**.
   1. If the CDN provider hasn't been activated yet, click **Activate provider**.
   1. Create a CDN resource:

      1. On the **CDN resources** tab, click **Create resource**.
      1. Set up the main parameters of the CDN resource as follows:

         * **Content query**: **From one origin**.
         * **Source type**: **L7 load balancer**.
         * **L7 load balancer**: `example-balancer`.
         * **IP address**: The IP address assigned to the load balancer (the only one in the list).
         * **Domain names for content distribution**: `cdn.yandexcloud.example`.

            {% note alert %}

            The first domain name `cdn.yandexcloud.example` will become the primary one, and you won't be able to edit it after you create a CDN resource.

            {% endnote %}

         * In the **Advanced** section:

            * In the **Source protocol** field, select **HTTP**.
            * In the **Redirect clients** field, select **Don't use**.
            * Enable **End-user access to content**.
            * In the **Certificate type** field, select **Let's Encrypt® **to automatically issue a certificate for the `cdn.yandexcloud.example` domain name after creating your CDN resource.
            * In the **Host header** field, select **Forward**.

      1. Click **Create**.

      Wait until the Let's Encrypt® certificate is issued for the domain name. This may take up to 30 minutes.

   1. Enable a client redirect from HTTP to HTTPS:

      1. In the ![image](../../_assets/cdn/cdn-res.svg) **CDN resources** tab, select the previously created resource.
      1. Make sure the certificate status under **Additional** changes to `Issued`.
      1. At the top right, click ![image](../../_assets/pencil.svg) **Edit**.
      1. Under **Additional**, in the **Redirect clients** field, select **HTTP to HTTPS**.
      1. Click **Save**.

- CLI

   1. If the CDN provider hasn't been activated yet, run the command:

      ```bash
      yc cdn provider activate --folder-id <folder_ID> --type gcore
      ```

   1. Create the `example-origin-group` origin group by indicating the IP address of the load balancer:

      ```bash
      yc cdn origin-group create --name "example-origin-group" \
        --origin source=<load_balancer_IP_address>:80,enabled=true
      ```

      Result:

      ```
      id: "90748"
      folder_id: b1geoelk7fldts6chmjq
      name: example-origin-group
      use_next: true
      origins:
      - id: "562449"
        origin_group_id: "90748"
        source: 51.250.10.216:80
        enabled: true
      ```

      For more information about the `yc cdn origin-group create` command, see the [CLI reference](../../cli/cli-ref/managed-services/cdn/origin-group/create.md).


   1. Copy the `origin_group_id` from the previous step and create a CDN resource by running the command:

      ```bash
      yc cdn resource create \
        --cname cdn.yandexcloud.example \
        --origin-group-id <origin_group_ID> \
        --origin-protocol http \
        --lets-encrypt-gcore-ssl-cert \
        --forward-host-header
      ```

      Result:

      ```
      id: bc843k2yinvq5fhgvuvc
      folder_id: b1ge1elk72ldts6chmjq
      cname: cdn.yandexcloud.example
      ...
      active: true
      ...
      ...
      ...
      ```

      For more information about the `yc cdn resource create` command, see the [CLI reference](../../cli/cli-ref/managed-services/cdn/resource/create.md).

   1. Enable a client redirect for a resource:

      ```bash
      yc cdn resource update <resource_ID> --redirect-http-to-https
      ```

- {{ TF }}

   1. Add parameters of CDN resources to the configuration file:
      ```hcl
      ...

      resource "yandex_cdn_origin_group" "my_group" {
        name     = "example-origin-group"
        use_next = true
        origin {
         source = "<load_balancer_IP_address>:80"
         backup = false
        }
      }

      resource "yandex_cdn_resource" "my_resource" {

          cname               = "cdn.yandexcloud.example"
          active              = true
          origin_protocol     = "http"
          origin_group_id     = yandex_cdn_origin_group.my_group.id
          ssl_certificate {
            type = "lets_encrypt_gcore"
          }
          options {
              edge_cache_settings    = "345600"
              browser_cache_settings = "1800"
              ignore_cookie          = true
              ignore_query_params    = false
          }

      }
      ```

      For more information, see the descriptions of the [yandex_cdn_origin_group]({{ tf-provider-link }}/cdn_origin_group) and [yandex_cdn_resource]({{ tf-provider-link }}/cdn_resource) resources in the {{ TF }} provider documentation.

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

      All the resources you need will then be created in the specified folder. You can check that the resources are there and their settings are correct using the [management console]({{ link-console-main }}).

   1. Enable client redirect for a resource. Add the following field at the beginning of the `options` section for a CDN resource:

      ```hcl
      ...
      options {
        redirect_https_to_http = true
      ...
      ```

   1. Run the check using this command:

      ```bash
      terraform plan
      ```

      If the configuration is described correctly, the terminal will display a list of updated resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. If there are no errors, run this command:

      ```bash
      terraform apply
      ```

   1. Confirm the resource update: type `yes` in the terminal and press **Enter**.

   This enables a redirect for the resource.

- API

   Use the [ResourceService/Create](../../cdn/api-ref/grpc/resource_service.md#Create) gRPC API call or the [create](../../cdn/api-ref/Resource/create.md) REST API method.

{% endlist %}

## Configure DNS for the service{#configure-dns}

The `cdn.yandexcloud.example` domain name must be linked to the CDN resource using DNS records.

To configure DNS:

1. Get the domain name of the CDN load balancer:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select `example-folder`.
      1. In the list of services, select **{{ cdn-name }}**.
      1. In the list of CDN resources, select the resource with the `cdn.yandexcloud.example` primary domain name.
      1. From **DNS settings**, copy the domain name in `cl-....edgecdn.ru` format.

   {% endlist %}

1. On the site of your DNS hosting provider, go to the DNS settings.
1. Create or edit a CNAME record for `cdn.yandexcloud.example` to link them to the copied domain name:

   ```
   cdn CNAME cl-....edgecdn.ru
   ```

   If you use {{ dns-name }}, follow these instructions to configure the record:

   {% cut "Instructions for configuring DNS records for {{ dns-name }}" %}

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select **{{ dns-name }}**.
      1. If you don't have a public DNS zone, create one:

         1. Click **Create zone**.
         1. In the **Zone** field, enter the site's domain name with a trailing dot: `yandexcloud.example`.
         1. Select the zone **Type**: **Public**.
         1. Specify the **Name** of the zone: `example-dns-zone`.
         1. Click **Create**.

      1. In the zone, create a CNAME record for `cdn.yandexcloud.example`:

         1. In the list of zones, click `example-dns-zone`.
         1. Click **Create record**.
         1. In the **Name** field, enter `cdn`.
         1. Select the record **Type**: **CNAME**.
         1. In the **Value** field, paste the copied value in `cl-....edgecdn.ru` format.
         1. Click **Create**.

   - CLI

      1. If you don't have a public DNS zone, create one:

         ```bash
         yc dns zone create \
           --name example-dns-zone \
           --zone yandexcloud.example. \
           --public-visibility
         ```

         Result:

         ```
         id: dns4rq4tadddth4h20qm
         folder_id: b1g9hv2loamqfnbul7d9
         created_at: "2022-04-04T11:03:28.847Z"
         name: example-dns-zone
         zone: yandexcloud.example.
         public_visibility: {}
         ```

         For more information about the `yc dns zone create` command, see the [CLI reference](../../cli/cli-ref/managed-services/dns/zone/create.md).

      1. In the zone, create a CNAME record for `cdn.yandexcloud.example` with a copied value in `cl-....edgecdn.ru` format:

         ```bash
         yc dns zone add-records \
           --name example-dns-zone \
           --record "cdn CNAME cl-....edgecdn.ru" \
         ```

         For more information about the `yc dns zone add-records` command, see the [CLI reference](../../cli/cli-ref/managed-services/dns/zone/add-records.md).

   - {{ TF }}

      1. Add the parameters of the `example-dns-zone` DNS zone and its CNAME records to the configuration file:

         ```
         ...

         resource "yandex_dns_zone" "example-dns-zone" {
           zone   = "yandexcloud.example."
           name   = "example-dns-zone"
           public = true
         }

         resource "yandex_dns_recordset" "example-recordset" {
           zone_id = ${yandex_dns_zone.example-dns-zone.id}
           name    = "cdn"
           type    = "CNAME"
           data    = ["<copied_value_in_the_ format_cl-....edgecdn.ru>"]
         }
         ```

         Learn more in the description of the [yandex_dns_zone]({{ tf-provider-link }}/dns_zone) and [yandex_dns_recordset]({{ tf-provider-link }}/dns_recordset) resources in the {{ TF }} provider documentation.

      1. Make sure the configuration files are valid.

         1. In the command line, go to the directory where you created the configuration file.
         1. Run the check using this command:

            ```bash
            terraform plan
            ```

         If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

      1. Deploy cloud resources.

         1. If the configuration does not contain any errors, run this command:

            ```bash
            terraform apply
            ```

         1. Confirm that you want to create the resources.

   - API

      1. Create a DNS zone named `example-dns-zone` using the gRPC API [DnsZoneService/Create](../../dns/api-ref/grpc/dns_zone_service.md#Create) call or the [create](../../dns/api-ref/DnsZone/create.md) REST API method.
      1. Add the `cdn` CNAME record to the zone, copying the `cl-....edgecdn.ru` value with the [DnsZoneService/UpdateRecordSets](../../dns/api-ref/grpc/dns_zone_service.md#UpdateRecordSets) gRPC API call or the [updateRecordSets](../../dns/api-ref/DnsZone/updateRecordSets.md) REST API method.

   {% endlist %}

   {% endcut %}

{% include [after-creation-tip-tutorials](../../_includes/cdn/after-creation-tip-tutorials.md) %}

## Run a health check for the service {#check}

To check the service performance, open `https://cdn.yandexcloud.example/index.html` in the browser. You should see a page with the following content:

```html
<!DOCTYPE html>
<html>
  <head>
    <title>My service</title>
  </head>
  <body>
    <p>The service is working</p>
  </body>
</html>
```

## How to delete the resources you created {#clear-out}

To shut down the infrastructure and stop paying for the created resources:

1. If you set up CNAME records in {{ dns-name }}, [delete](../../dns/operations/zone-delete.md) the `example-dns-zone` DNS zone.
1. [Delete](../../cdn/operations/resources/delete-resource.md) the CDN resource with the primary `cdn.yandexcloud.example` domain name.
1. [Delete](../../application-load-balancer/operations/application-load-balancer-delete.md) the `example-balancer` L7 load balancer.
1. [Delete](../../storage/operations/objects/delete.md) all objects from the `example-bucket` bucket.
1. [Delete](../../storage/operations/buckets/delete.md) the `example-bucket` bucket.
1. [Delete](../../vpc/operations/subnet-delete.md) the `example-subnet-{{ region-id }}-a`, `example-subnet-{{ region-id }}-b`, and `example-subnet-{{ region-id }}-c` subnets.
1. [Delete](../../vpc/operations/network-delete.md) the `example-network` network.
