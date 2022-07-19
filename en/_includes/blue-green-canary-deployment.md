# Enabling blue-green and canary deployment of web service versions

In this tutorial, you'll configure your web service architecture to switch between versions using the commonly adopted deployment models: [blue-green deployment](https://martinfowler.com/bliki/BlueGreenDeployment.html) and [canary deployment](https://martinfowler.com/bliki/CanaryRelease.html).

Both models use two backends: a "blue" and a "green" one. First you deploy a stable version generally available to users on one backend (let it be the blue one). Then you use the other backend (the green one) to test the next version. When the testing is complete, the backends switch roles:

* With a blue-green deployment, all user traffic switches from one backend to the other right away.
* With canary deployment, the traffic is switched over gradually, starting with some part of your user base.

After that, the green backend becomes the primary one, and you can use the "blue" backend to test your next version. As long as your previous version runs on the blue backend, you can roll the service back to it by switching the backends back.

In this tutorial, we use {{ objstorage-full-name }} buckets as backends with the {{ alb-full-name }} L7 load balancer switching traffic between them. User requests are transmitted to the load balancer via the {{ cdn-full-name }} content delivery network (CDN) that reduces the time of content delivery.

In the tutorial, we'll use the domain names `cdn.yandexcloud.example` and `cdn-staging.yandexcloud.example` as examples.

To complete the tutorial, use the [supported tools](#supported-tools).

To build an architecture for the blue-green and canary deployment:

1. [Before you start](#before-you-begin).
1. [Create a cloud network and subnets](#create-network).
1. [Create buckets in {{ objstorage-name }}](#create-buckets).
1. [Upload the service files to buckets](#upload-files).
1. [Create {{ alb-name }} backend groups](#create-l7backend).
1. [Create an HTTP router and virtual hosts](#create-route-hosts).
1. [Create an L7 load balancer](#create-balancer).
1. [Create a CDN resource](#create-cdn-resource).
1. [Configure DNS for the service](#configure-dns).
1. [Run a health check and test the switching between service versions](#check).

If you no longer need the created resources, [delete them](#clear-out).

## Supported tools {#supported-tools}

Most of the steps in the tutorial can be completed in any standard tool: [management console]({{ link-console-main }}), command line interfaces (CLI) [{{ yandex-cloud }}](../cli/index.yaml), [AWS](../storage/tools/aws-cli.md), {{ TF }}, and [APIs {{ yandex-cloud }}](../api-design-guide). Each step lists tools supported for it.

Some steps don't support certain tools:

* At the moment, you can't use command-line interfaces and {{ TF }} in order to:
  * [Create a {{ alb-name }} backend group with buckets as backends](#create-l7backend).
  * [Create a CDN resource](#create-cdn-resource).
  * Get the domain name of a CDN load balancer when [configuring DNS for the service](#configure-dns).
  * Disable and enable caching of a CDN resource when [running a health check and testing version switching](#check).
* Currently, you can't get the domain name of a CDN load balancer via API when [configuring DNS for the service](#configure-dns).

## Before you start {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

This use case uses a folder named `example-folder` as an example.

{% if product == "yandex-cloud" %}

### Required paid resources {#paid-resources}

The cost of this infrastructure includes:

* A fee for data storage in {{ objstorage-name }}, operations with data, and outgoing traffic (see [{{ objstorage-name }} pricing](../storage/pricing.md)).
* A fee for using computing resources of the L7 load balancer (see [{{ alb-name }} pricing](../application-load-balancer/pricing.md)).
* A fee for outgoing traffic from CDN servers (see [{{ cdn-name }} pricing](../cdn/pricing.md)).
* A fee for public DNS queries and DNS zones if you use {{ dns-full-name }} (see [{{ dns-name }} pricing](../dns/pricing.md)).

{% endif %}

## Create a cloud network and subnets {#create-network}

All resources you have created in the tutorial belong to the same [cloud network](../vpc/concepts/network.md).

To create a network and subnets:

{% list tabs %}

- Management console

    1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
    1. In the list of services, select **{{ vpc-name }}**.
    1. Click **Create network**.
    1. Specify the **Name** of the network: `canary-network`.
    1. In the **Advanced** field, select **Create subnets**.
    1. Click **Create network**.

- CLI

  {% include [cli-install](cli-install.md) %}

  {% include [default-catalogue](default-catalogue.md) %}

  1. Create a network named `canary-network`:

     ```bash
     yc vpc network create canary-network
     ```

     Result:

     ```
     id: enptrcle5q3d3ktd33hj
     folder_id: b1g9hv2loamqfnbul7d9
     created_at: "2021-11-03T09:25:03Z"
     name: canary-network
     default_security_group_id: enpbsnnop4akg7ng70ll
     ```

     For more information about the `yc vpc network create` command, see the [CLI reference](../cli/cli-ref/managed-services/vpc/network/create.md).

  1. Create subnets in all availability zones:

     * In `{{ region-id }}-a`:

       ```
       yc vpc subnet create canary-subnet-{{ region-id }}-a \
         --zone {{ region-id }}-a \
         --network-name canary-network \
         --range 10.1.0.0/16
       ```

       Result:

       ```
       id: e9bnnssj8sc8mjhat9qk
       folder_id: b1g9hv2loamqfnbul7d9
       created_at: "2021-11-03T09:27:00Z"
       name: canary-subnet-{{ region-id }}-a
       network_id: enptrcle5q3d3ktd33hj
       zone_id: {{ region-id }}-a
       v4_cidr_blocks:
       - 10.1.0.0/16
       ```

     * In `{{ region-id }}-b`:

       ```
       yc vpc subnet create canary-subnet-{{ region-id }}-b \
         --zone {{ region-id }}-b \
         --network-name canary-network \
         --range 10.2.0.0/16
       ```

       Result:

       ```
       id: e2lghukd9iqo4haidjbt
       folder_id: b1g9hv2loamqfnbul7d9
       created_at: "2021-11-03T09:27:39Z"
       name: canary-subnet-{{ region-id }}-b
       network_id: enptrcle5q3d3ktd33hj
       zone_id: {{ region-id }}-b
       v4_cidr_blocks:
       - 10.2.0.0/16
       ```

     * In `{{ region-id }}-c`:

       ```
       yc vpc subnet create canary-subnet-{{ region-id }}-c \
         --zone {{ region-id }}-c \
         --network-name canary-network \
         --range 10.3.0.0/16
       ```

       Result:

       ```
       id: b0c3pte4o2kn4v12o05p
       folder_id: b1g9hv2loamqfnbul7d9
       created_at: "2021-11-03T09:28:08Z"
       name: canary-subnet-{{ region-id }}-c
       network_id: enptrcle5q3d3ktd33hj
       zone_id: {{ region-id }}-c
       v4_cidr_blocks:
       - 10.3.0.0/16
       ```

     For more information about the `yc vpc subnet create` command, see the [CLI reference](../cli/cli-ref/managed-services/vpc/subnet/create.md).

- {{ TF }}

  If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. In the configuration file, describe the parameters of `canary-network` and its subnets: `canary-subnet-{{ region-id }}-a`, `canary-subnet-{{ region-id }}-b`, and `canary-subnet-{{ region-id }}-c`:

     ```
     resource "yandex_vpc_network" "canary-network" {
       name = "canary-network"
     }
     
     resource "yandex_vpc_subnet" "canary-subnet-a" {
       name           = "canary-subnet-{{ region-id }}-a"
       zone           = "{{ region-id }}-a"
       network_id     = "${yandex_vpc_network.canary-network.id}"
       v4_cidr_blocks = ["10.1.0.0/16"]
     }
     
     resource "yandex_vpc_subnet" "canary-subnet-b" {
       name           = "canary-subnet-{{ region-id }}-b"
       zone           = "{{ region-id }}-b"
       network_id     = "${yandex_vpc_network.canary-network.id}"
       v4_cidr_blocks = ["10.2.0.0/16"]
     }
     
     resource "yandex_vpc_subnet" "canary-subnet-c" {
       name           = "canary-subnet-{{ region-id }}-c"
       zone           = "{{ region-id }}-c"
       network_id     = "${yandex_vpc_network.canary-network.id}"
       v4_cidr_blocks = ["10.3.0.0/16"]
     }
     ```

     For more information, see the [yandex_vpc_network]({{ tf-provider-link }}/vpc_network) and [yandex_vpc_subnet]({{ tf-provider-link }}/vpc_subnet) resource descriptions in the {{ TF }} provider documentation.

  1. Make sure that the configuration files are correct.

     1. In the command line, go to the directory where you created the configuration file.
     1. Run the check using the command:

        ```bash
        terraform plan
        ```

     If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, {{ TF }} points them out.

  1. Deploy the cloud resources.

     1. If the configuration doesn't contain any errors, run the command:

        ```bash
        terraform apply
        ```

     1. Confirm that you want to create the resources.

- API

  1. Create the `canary-network` network using the gRPC API [NetworkService/Create](../vpc/api-ref/grpc/network_service.md#Create) call or the REST API [create](../vpc/api-ref/Network/create.md) method.
  1. Create the `canary-subnet-{{ region-id }}-a`, `canary-subnet-{{ region-id }}-b`, and `canary-subnet-{{ region-id }}-c` subnets in the three availability zones by calling the gRPC API [SubnetService/Create](../vpc/api-ref/grpc/subnet_service.md#Create) or the REST API [create](../vpc/api-ref/Subnet/create.md) method.

{% endlist %}

## Create buckets in {{ objstorage-name }} {#create-buckets}

Create two buckets: `canary-bucket-blue` and `canary-bucket-green`:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
  1. In the list of services, select **{{ objstorage-name }}**.
  1. Create a bucket named `canary-bucket-blue`:

     1. Click **Create bucket**.
     1. Specify the bucket **Name**: `canary-bucket-blue`.
     1. In the **Object read access** and **Object listing access** fields, select **Public**.
     1. Click **Create bucket**.

  1. Similarly create a bucket named `canary-bucket-green`.

- AWS CLI

  1. Create a bucket named `canary-bucket-blue`:

     ```bash
     aws --endpoint-url https://{{ s3-storage-host }} \
       s3 mb s3://canary-bucket-blue
     ```

     Result:

     ```
     make_bucket: s3://canary-bucket-blue
     ```

  1. Enable public access to reading objects and their list:

     ```bash
     aws --endpoint-url https://{{ s3-storage-host }} \
       s3api put-bucket-acl \
       --bucket canary-bucket-blue \
       --acl public-read
     ```

  1. In a similar way, create a bucket named `canary-bucket-green` and enable public access to it.

- {{ TF }}

  1. Add the parameters of the `canary-bucket-blue` and `canary-bucket-green` buckets to the configuration file:

     ```
     ...
     
     resource "yandex_storage_bucket" "canary-bucket-blue" {
       bucket = "canary-bucket-blue"
       acl    = "public-read"
     }
     
     resource "yandex_storage_bucket" "canary-bucket-green" {
       bucket = "canary-bucket-green"
       acl    = "public-read"
     }
     ```

     For more information about the `yandex_storage_bucket` resource, see the {{ TF }} provider [documentation]({{ tf-provider-link }}/storage_bucket).

  1. Make sure that the configuration files are correct.

     1. In the command line, go to the directory where you created the configuration file.
     1. Run the check using the command:

        ```bash
        terraform plan
        ```

     If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, {{ TF }} points them out.

  1. Deploy the cloud resources.

     1. If the configuration doesn't contain any errors, run the command:

        ```bash
        terraform apply
        ```

     1. Confirm that you want to create the resources.

- API

  Use the [create](../storage/s3/api-ref/bucket/create.md) REST API method.

{% endlist %}

## Upload the files of your service to the buckets {#upload-files}

1. Create two files named `index.html`. They will represent two service versions: version 1 and version 2.

   {% cut "Sample file index.html version 1" %}

   ```html
   <!DOCTYPE html>
   <html>
     <head>
       <title>Version 1</title>
     </head>
     <body>
       <p>Version 1 is working</p>
     </body>
   </html>
   ```

   {% endcut %}

   {% cut "Sample file index.html version 2" %}

   ```html
   <!DOCTYPE html>
   <html>
     <head>
       <title>Version 2</title>
     </head>
     <body>
       <p>Version 2 is working</p>
     </body>
   </html>
   ```

   {% endcut %}

1. Upload files to buckets:

   {% list tabs %}

   - Management console

     1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
     1. In the list of services, select **{{ objstorage-name }}**.
     1. In the bucket list, select `canary-bucket-blue`.
     1. Click **Upload** and select the `index.html` file for version 1.
     1. Similarly upload to the `canary-bucket-green` bucket the `index.html` file for version 2.

   - AWS CLI

     1. To the `canary-bucket-blue` bucket, upload the `index.html` file version 1:

        ```bash
        aws --endpoint-url https://{{ s3-storage-host }} \
          s3 cp v1/index.html s3://canary-bucket-blue/index.html
        ```

        Result:

        ```
        upload: v1/index.html to s3://canary-bucket-blue/index.html
        ```

     1. Upload to the `canary-bucket-green` bucket the `index.html` file version 2:

        ```bash
        aws --endpoint-url https://{{ s3-storage-host }} \
          s3 cp v2/index.html s3://canary-bucket-green/index.html
        ```

        Result:

        ```
        upload: v2/index.html to s3://canary-bucket-green/index.html
        ```

   - {{ TF }}

     1. To the configuration file, add the parameters of the `v1/index.html` and `v2/index.html` files uploaded to `canary-bucket-blue` and `canary-bucket-green`, respectively:

        ```
        ...
        
        resource "yandex_storage_object" "canary-bucket-blue-index" {
          bucket = "canary-bucket-blue"
          key    = "index.html"
          source = "v1/index.html"
        }
        
        resource "yandex_storage_bucket" "canary-bucket-green-index" {
          bucket = "canary-bucket-green"
          key    = "index.html"
          source = "v2/index.html"
        }
        ```

        For more information about the `yandex_storage_object` resource, see the {{ TF }} provider [documentation]({{ tf-provider-link }}/storage_object).

     1. Make sure that the configuration files are correct.

        1. In the command line, go to the directory where you created the configuration file.
        1. Run the check using the command:

           ```bash
           terraform plan
           ```

        If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, {{ TF }} points them out.

     1. Deploy the cloud resources.

        1. If the configuration doesn't contain any errors, run the command:

           ```bash
           terraform apply
           ```

        1. Confirm that you want to create the resources.

   - API

     Use the [upload](../storage/s3/api-ref/object/upload.md) REST API method.

   {% endlist %}

## Create a security group {#create-security-group}

{% include [security-groups-note](../application-load-balancer/_includes_service/security-groups-note.md) %}

[Security groups](../vpc/concepts/security-groups.md) contain rules that allow the L7 load balancer to receive incoming traffic and send it to backend buckets.

To create security groups:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), open **{{ vpc-name }}**.
  1. Click the **Security groups** tab.
  1. Click **Create group**.
  1. Enter the **Name** of the group: `canary-sg`.
  1. Select the **Network** `canary-network`.
  1. Under **Rules**, create the following rules using the instructions below the table:

     | Traffic<br/>direction | Description | Port<br/>range | Protocol | Source/<br/>destination type | Source /<br/>destination |
     | --- | --- | --- | --- | --- | --- |
     | Outgoing | any | All | Any | CIDR | 0.0.0.0/0 |
     | Incoming | ext-http | 80 | TCP | CIDR | 0.0.0.0/0 |
     | Incoming | ext-https | 443 | TCP | CIDR | 0.0.0.0/0 |
     | Incoming | healthchecks | 30080 | TCP | CIDR | 198.18.235.0/24<br/>198.18.248.0/24 |

     1. Go to the **Outgoing traffic** or **Incoming traffic** tab.
     1. Click **Add rule**.
     1. In the **Port range** field of the window that opens, specify a single port or a range of ports that traffic will come to or from.
     1. In the **Protocol** field, specify the desired protocol or leave **Any** to allow traffic transmission over any protocol.
     1. In the **Purpose** or **Source** field, select the purpose of the rule:

        * **CIDR**: The rule will apply to the range of IP addresses. In the **CIDR blocks** field, specify the CIDR and masks of subnets that traffic will come to or from. To add multiple CIDRs, click **Add CIDR**.
        * **Security group**: The rule will apply to the VMs from the current group or the selected security group.

     1. Tap **Save**. Repeat the steps to create all rules from the table.

  1. Tap **Save**.

- CLI

  Run the following command:

  ```bash
  yc vpc security-group create canary-sg \
    --network-name canary-network \
    --rule direction=egress,port=any,protocol=any,v4-cidrs=[0.0.0.0/0] \
    --rule direction=ingress,port=80,protocol=tcp,v4-cidrs=[0.0.0.0/0] \
    --rule direction=ingress,port=443,protocol=tcp,v4-cidrs=[0.0.0.0/0] \
    --rule direction=ingress,port=30080,protocol=tcp,v4-cidrs=[198.18.235.0/24,198.18.248.0/24]
  ```

  Result:

  ```
  id: enpd133ngcnrgc8475cc
  folder_id: b1g9hv2loamqfnbul7d9
  created_at: "2021-11-03T10:26:16Z"
  name: canary-sg
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
    cidr_blocks:
      v4_cidr_blocks:
      - 198.18.235.0/24
      - 198.18.248.0/24
  ```

  For more information about the `yc vpc security-group create` command, see the [CLI reference](../cli/cli-ref/managed-services/vpc/security-group/create.md).

- {{ TF }}

  1. Add the `canary-sg` security group parameters to the configuration file:

     ```
     resource "yandex_vpc_security_group" "canary-sg" {
       name       = "canary-sg"
       network_id = "${yandex_vpc_network.canary-network.id}"
     
       egress {
         protocol       = "ANY"
         port           = "ANY"
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
         protocol       = "TCP"
         port           = 30080
         v4_cidr_blocks = ["198.18.235.0/24", "198.18.248.0/24"]
       }
     }
     ```

     For more information about the `yandex_vpc_security_group` resource, see the {{ TF }} provider [documentation]({{ tf-provider-link }}/vpc_security_group).

  1. Make sure that the configuration files are correct.

     1. In the command line, go to the directory where you created the configuration file.
     1. Run the check using the command:

        ```bash
        terraform plan
        ```

     If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, {{ TF }} points them out.

  1. Deploy the cloud resources.

     1. If the configuration doesn't contain any errors, run the command:

        ```bash
        terraform apply
        ```

     1. Confirm that you want to create the resources.

- API

  Use the [SecurityGroupService/Create](../vpc/api-ref/grpc/security_group_service.md#Create) gRPC API call or the [create](../vpc/api-ref/SecurityGroup/create.md) REST API method.

{% endlist %}

## Create {{ alb-name }} backend groups {#create-l7backend}

{% list tabs %}

- Management console

  1. Create a backend group named `canary-bg-production` with the `canary-backend-blue` and `canary-backend-green` backends:

     1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
     1. In the list of services, select **{{ alb-name }}** and go to the **Backend groups** tab.
     1. Click **Create backend group**.
     1. Enter the backend group name: `canary-bg-production`.
     1. Under **Backends**, click **Add**. Specify the backend settings:
         1. Enter the backend  name: `canary-backend-blue`.
         1. set the weight of the backend: `100`.
         1. Select **Bucket** as the backend type.
         1. In the **Bucket** field, enter the bucket name: `canary-bucket-blue`.
     1. Click **Add** and similarly enter settings for the `canary-backend-green` backend with the weight of `0` and the `canary-bucket-green` bucket.
     1. Click **Create**.

  1. In a similar way, create a backend group named `canary-bg-staging`. For the `canary-backend-blue` backend, set the weight to `0`, for `canary-backend-green`, set the weight to `100`.
  1. If you are going to complete the next steps in {{ TF }}, copy the IDs of the backend groups `canary-bg-production` and `canary-bg-staging` from the **Backend groups** tab.

- API

  Use the [BackendGroupService/Create](../application-load-balancer/api-ref/grpc/backend_group_service.md#Create) gRPC API call or the REST API [create](../application-load-balancer/api-ref/BackendGroup/create.md) method.

{% endlist %}

## Create an HTTP router and virtual hosts {#create-route-hosts}

Create an HTTP router with two virtual hosts: `cdn.mywebsite.com` and `cdn-staging.mywebsite.com`:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
  1. In the list of services, select **{{ alb-name }}** and go to the **HTTP routers** tab.
  1. Click **Create HTTP router**.
  1. Enter the router name: `canary-router`.
  1. Create a virtual host named `canary-vh-production`:

     1. Under **Add virtual host**, click **Add host**.
     1. Enter the host name: `canary-vh-production`.
     1. Specify the value for **Authority**: `cdn.yandexcloud.example`
     1. Click **Add route**.
     1. Enter the **Name**: `canary-route-production`.
     1. In the **Path** field, select **Starts with** and specify the path `/`.
     1. In the **HTTP methods** list, select **GET**.
     1. In the **Action** field, leave the value **Routing**.
     1. In the **Backend group** list, select `canary-bg-production`.

  1. In a similar way, create a virtual host named `canary-vh-staging` with the following parameters:

     * **Authority**: `cdn-staging.yandexcloud.example`.
     * **Route name**: `canary-route-staging`.
     * **Backend group**: `canary-bg-staging`.
     * The other parameters are the same as for `canary-vh-production`.

  1. Leave the other settings as they are and click **Create**.

- CLI

  1. Create the `canary-router` HTTP Router:

     ```bash
     yc alb http-router create canary-router
     ```

     Result:

     ```
     id: ds7qd0vj01djuu3c6f8q
     name: canary-router
     folder_id: b1g9hv2loamqfnbul7d9
     created_at: "2021-11-03T10:31:41.027649223Z"
     ```

     For more information about the `yc alb http-router create` command, see the [CLI reference](../cli/cli-ref/managed-services/application-load-balancer/http-router/create.md).

  1. Create a virtual host named `canary-vh-production`:

     ```bash
     yc alb virtual-host create canary-vh-production \
       --http-router-name canary-router \
       --authority cdn.yandexcloud.example
     ```

     Result:

     ```
     done (1s)
     name: canary-vh-production
     authority:
     - cdn.yandexcloud.example
     ```

     For more information about the `yc alb virtual-host create` command, see the [CLI reference](../cli/cli-ref/managed-services/application-load-balancer/virtual-host/create.md).

  1. Create a route named `canary-route-production` in the `canary-vh-production` virtual host:

     ```bash
     yc alb virtual-host append-http-route canary-route-production \
       --http-router-name canary-router \
       --virtual-host-name canary-vh-production \
       --prefix-path-match "/" \
       --backend-group-name canary-bg-production
     ```

     Result:

     ```
     done (1s)
     name: canary-vh-production
     authority:
     - cdn.yandexcloud.example
     routes:
     - name: canary-route-production
       http:
         match:
           path:
             prefix_match: /
         route:
           backend_group_id: ds7pbm5fj2v09ptnn29p
     ```

     For more information about the `yc alb virtual-host append-http-route` command, see the [CLI reference](../cli/cli-ref/managed-services/application-load-balancer/virtual-host/append-http-route.md).

  1. Create a virtual host named `canary-vh-staging`:

     ```bash
     yc alb virtual-host create canary-vh-staging \
       --http-router-name canary-router \
       --authority cdn-staging.yandexcloud.example
     ```

     Result:

     ```
     done (1s)
     name: canary-vh-staging
     authority:
     - cdn-staging.yandexcloud.example
     ```

  1. Create a route named `canary-route-staging` in the `canary-vh-staging` virtual host:

     ```bash
     yc alb virtual-host append-http-route canary-route-staging \
       --http-router-name canary-router \
       --virtual-host-name canary-vh-staging \
       --prefix-path-match "/" \
       --backend-group-name canary-bg-staging
     ```

     Result:

     ```
     done (1s)
     name: canary-vh-staging
     authority:
     - cdn-staging.yandexcloud.example
     routes:
     - name: canary-route-staging
       http:
         match:
           path:
             prefix_match: /
         route:
           backend_group_id: ds765atleotaiui5pqeu
     ```

- {{ TF }}

  1. To the configuration file, add parameters of the `canary-router` HTTP router, its virtual hosts and routes:

     ```
     ...
     
     resource "yandex_alb_http_router" "canary-router" {
       name = "canary-router"
     }
     
     resource "yandex_alb_virtual_host" "canary-vh-production" {
       name           = "canary-vh-production"
       http_router_id = ${yandex_alb_http_router.canary-router.id}
       authority      = "cdn.yandexcloud.example"
     
       route {
         name = "canary-route-production"
         http_route {
           http_route_action {
             backend_group_id = "<ID of the canary-bg-production backend group>"
           }
         }
       }  
     }
     
     resource "yandex_alb_virtual_host" "canary-vh-staging" {
       name           = "canary-vh-staging"
       http_router_id = ${yandex_alb_http_router.canary-router.id}
       authority      = "cdn-staging.yandexcloud.example"
     
       route {
         name = "canary-route-staging"
         http_route {
           http_route_action {
             backend_group_id = "<ID of the canary-bg-staging backend group>"
           }
         }
       }  
     }
     ```

     For more information, see the [yandex_alb_http_router]({{ tf-provider-link }}/alb_http_router) and [yandex_alb_virtual_host]({{ tf-provider-link }}/alb_virtual_host) resource descriptions in the {{ TF }} provider documentation.

  1. Make sure that the configuration files are correct.

     1. In the command line, go to the directory where you created the configuration file.
     1. Run the check using the command:

        ```bash
        terraform plan
        ```

     If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, {{ TF }} points them out.

  1. Deploy the cloud resources.

     1. If the configuration doesn't contain any errors, run the command:

        ```bash
        terraform apply
        ```

     1. Confirm that you want to create the resources.

- API

  1. Create the `canary-router` HTTP router using the gRPC API [HttpRouterService/Create](../application-load-balancer/api-ref/grpc/http_router_service.md#Create) call or the [create](../application-load-balancer/api-ref/HttpRouter/create.md) REST API method.
  1. Create the `canary-vh-production` and `canary-vh-staging` virtual hosts linked to the router, then create their routes using the gRPC API [VirtualHostService/Create](../application-load-balancer/api-ref/grpc/virtual_host_service.md#Create) call or the [create](../application-load-balancer/api-ref/VirtualHost/create.md) REST API method.

{% endlist %}

## Create an L7 load balancer {#create-balancer}

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
  1. In the list of services, select **{{ alb-name }}**, then click **Load balancers**.
  1. Click **Create L7 load balancer**.
  1. Enter the load balancer name: `canary-balancer`.
  1. Under **Network settings**:

     1. Select the **Network** `canary-network`.
     1. Select the **Security group** `canary-sg`. If this field is omitted, any incoming and outgoing traffic is allowed for the load balancer.

  1. Under **Allocation**, select three subnets for the load balancer nodes: `canary-subnet-{{ region-id }}-a`, `canary-subnet-{{ region-id }}-b`, and `canary-subnet-{{ region-id }}-c`, then enable traffic to these subnets.
  1. Click **Add listener** under **Listeners**. Set the listener settings:

     1. Enter the listener name: `canary-listener`.
     1. Under **Public IP address settings**, enable traffic.
     1. Set the port to `80`.
     1. In the **Assign IP address** field, select **Automatically**.

  1. In the **HTTP router** field, select `canary-router`.
  1. Click **Create**.

- CLI

  1. Get the IDs of subnets for `canary-network`:

     ```bash
     yc vpc network list-subnets canary-network
     ```

     Result:

     ```
     +----------------------+-----------------------------+----------------------+----------------------+----------------+---------------+---------------+
     |          ID          |            NAME             |      FOLDER ID       |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |     RANGE     |
     +----------------------+-----------------------------+----------------------+----------------------+----------------+---------------+---------------+
     | e9bnnssj8sc8mjhat9qk | canary-subnet-{{ region-id }}-c | b1g9hv2loamqfnbul7d9 | enptrcle5q3d3ktd33hj |                | {{ region-id }}-c | [10.1.0.0/16] |
     | e2lghukd9iqo4haidjbt | canary-subnet-{{ region-id }}-b | b1g9hv2loamqfnbul7d9 | enptrcle5q3d3ktd33hj |                | {{ region-id }}-b | [10.2.0.0/16] |
     | b0c3pte4o2kn4v12o05p | canary-subnet-{{ region-id }}-a | b1g9hv2loamqfnbul7d9 | enptrcle5q3d3ktd33hj |                | {{ region-id }}-a | [10.3.0.0/16] |
     +----------------------+-----------------------------+----------------------+----------------------+----------------+---------------+---------------+
     ```

     For more information about the `yc vpc network list-subnets` command, see the [CLI reference](../cli/cli-ref/managed-services/vpc/network/list-subnets.md).

  1. Get the `canary-sg` security group ID:

     ```bash
     yc vpc security-group get canary-sg | grep "^id"
     ```

     Result:

     ```
     id: enpd133ngcnrgc8475cc
     ```

     For more information about the `yc vpc security-group get` command, see the [CLI reference](../cli/cli-ref/managed-services/vpc/security-group/get.md).

  1. Create a load balancer named `canary-balancer`:

     ```bash
     yc alb load-balancer create canary-balancer \
       --network-name canary-network \
       --security-group-id <ID of the canary-sg security group> \
       --location zone={{ region-id }}-a,subnet-id=<ID of the canary-subnet-{{ region-id }}-a subnet> \
       --location zone={{ region-id }}-b,subnet-id=<ID of the canary-subnet-{{ region-id }}-b subnet> \
       --location zone={{ region-id }}-c,subnet-id=<ID of the canary-subnet-{{ region-id }}-c subnet>
     ```

     Result:

     ```
     done (3m0s)
     id: ds77q7v39b4ubg8ta2n4
     name: canary-balancer
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
     created_at: "2021-11-03T10:55:49.134935148Z"
     ```

     For more information about the `yc alb load-balancer create` command, see the [CLI reference](../cli/cli-ref/managed-services/application-load-balancer/load-balancer/create.md).

  1. Add a listener to the load balancer:

     ```bash
     yc alb load-balancer add-listener \
       --name canary-balancer \
       --listener-name canary-listener \
       --external-ipv4-endpoint port=80 \
       --http-router-name canary-router
     ```

     Result:

     ```
     done (43s)
     id: ds77q7v39b4ubg8ta2n4
     name: canary-balancer
     folder_id: b1g9hv2loamqfnbul7d9
     status: ACTIVE
     region_id: {{ region-id }}
     network_id: enptrcle5q3d3ktd33hj
     listeners:
     - name: canary-listener
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
     created_at: "2021-11-03T10:55:49.134935148Z"
     ```

     For more information about the `yc alb load-balancer add-listener` command, see the [CLI reference](../cli/cli-ref/managed-services/application-load-balancer/load-balancer/add-listener.md).

- {{ TF }}

  1. Add the parameters of the `canary-balancer` L7 load balancer to the configuration file:

     ```
     ...
     
     resource "yandex_alb_load_balancer" "canary-balancer" {
       name               = "canary-balancer"
       network_id         = ${yandex_vpc_network.canary-network.id}
       security_group_ids = [ ${yandex_vpc_security_group.canary-sg.id} ]
     
       allocation_policy {
         location {
           zone_id   = "{{ region-id }}-a"
           subnet_id = ${yandex_vpc_subnet.canary-subnet-{{ region-id }}-a.id}
         }
     
         location {
           zone_id   = "{{ region-id }}-b"
           subnet_id = ${yandex_vpc_subnet.canary-subnet-{{ region-id }}-b.id}
         }
     
         location {
           zone_id   = "{{ region-id }}-c"
           subnet_id = ${yandex_vpc_subnet.canary-subnet-{{ region-id }}-c.id}
         }
       }
     
       listener {
         name = "canary-listener"
         endpoint {
           address {
             external_ipv4_address {
             }
           }
           ports = [80]
         }
         http {
           handler {
             http_router_id = ${yandex_alb_http_router.canary-router.id}
           }
         }
       }
     }
     ```

     For more information about the `yandex_alb_load_balancer` resource, see the {{ TF }} provider [documentation]({{ tf-provider-link }}/alb_load_balancer).

  1. Make sure that the configuration files are correct.

     1. In the command line, go to the directory where you created the configuration file.
     1. Run the check using the command:

        ```bash
        terraform plan
        ```

     If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, {{ TF }} points them out.

  1. Deploy the cloud resources.

     1. If the configuration doesn't contain any errors, run the command:

        ```bash
        terraform apply
        ```

     1. Confirm that you want to create the resources.

- API

  Use the [LoadBalancerService/Create](../application-load-balancer/api-ref/grpc/load_balancer_service.md#Create) gRPC API call or the REST API [create](../application-load-balancer/api-ref/LoadBalancer/create.md) method.

{% endlist %}

## Create a CDN resource {#create-cdn-resource}

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
  1. In the list of services, select **{{ cdn-name }}**.
  1. If the CDN provider hasn't been activated yet, click **Activate provider**.
  1. Create a CDN resource:

     1. On the **CDN resources** tab, click **Create resource**.
     1. Set up the main parameters of the CDN resource as follows:

        * **Content query**: **From one origin**.
        * **Source type**: **L7 load balancer**.
        * **L7 load balancer**: `canary-balancer`.
        * **IP address**: The IP address assigned to the load balancer (the only one in the list).
        * **Domain names for content distribution**: `cdn.yandexcloud.example` and `cdn-staging.yandexcloud.example`.

          {% note alert %}

          The first domain name `cdn.yandexcloud.example`will become the primary one, and you won't be able to edit it after you create a CDN resource.

          {% endnote %}

        * In the **Advanced** section:

          * In the **Source protocol** field, select **HTTP**.
          * In the **Redirect clients** field, select **HTTP to HTTPS**.
          * Enable **End-user access to content**.
          * In the **Certificate type** field, select **Let's Encrypt®** to automatically issue a certificate for the `cdn.yandexcloud.example` and `cdn-staging.yandexcloud.example` domain names after creating the CDN resource.
          * In the **Host header** field, select **HTTP and HTTPS**.

     1. Click **Create**.
     1. Enable CDN caching:

        1. In the list of CDN resources, select the resource with the `cdn.yandexcloud.example` primary domain name.
        1. Go to the **Caching** tab.
        1. Click **Edit**.
        1. Enable **CDN caching**.
        1. Tap **Save**.

- API

  Use the gRPC API [ResourceService/Create](../cdn/api-ref/grpc/resource_service.md#Create) call or the REST API [create](../cdn/api-ref/Resource/create.md) method.

{% endlist %}

## Configure DNS for the service{#configure-dns}

The domain names `cdn.yandexcloud.example` and `cdn-staging.yandexcloud.example` must be linked to the CDN resource using DNS records.

To configure DNS:

1. Get the domain name of the CDN load balancer:

   {% list tabs %}

   - Management console

     1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
     1. In the list of services, select **{{ cdn-name }}**.
     1. In the list of CDN resources, select the resource with the `cdn.yandexcloud.example` primary domain name.
     1. From **DNS settings**, copy the domain name that has the format `cl-....gcdn.co`.

   {% endlist %}

1. On the site of your DNS hosting provider, go to the DNS settings.
1. Create or edit CNAME records for `cdn.yandexcloud.example` and `cdn-staging.yandexcloud.example` to link them to the copied domain name:

   ```
   cdn CNAME cl-....gcdn.co
   cdn-staging CNAME cl-....gcdn.co 
   ```

   If you use {{ dns-name }}, follow these instructions to configure the record:

   {% cut "Instruction for configuring DNS records for {{ dns-name }}" %}

   {% list tabs %}

   - Management console

     1. In the [management console]({{ link-console-main }}), open **{{ dns-name }}**.
     1. If you don't have a public DNS zone, create one:

        1. Click **Create zone**.
        1. In the **Zone** field, enter the site's domain name with a trailing dot: `yandexcloud.example.`
        1. Select the zone **Type**: **Public**.
        1. Specify the **Name** of the zone: `canary-dns-zone`.
        1. Click **Create**.

     1. In the zone, create a CNAME record for `cdn.yandexcloud.example`:

        1. In the list of zones, click `canary-dns-zone`.
        1. Click **Create record**.
        1. In the **Name** field, enter `cdn`.
        1. Select the record **Type**: **CNAME**.
        1. In the **Value** field, paste the copied value in the `cl-....gcdn.co` format.
        1. Click **Create**.

     1. In a similar way, create in the same zone a CNAME record for `cdn-staging.yandexcloud.example`. In the **Name** field, specify `cdn-staging`.

   - CLI

     1. If you don't have a public DNS zone, create one:

        ```bash
        yc dns zone create \
          --name canary-dns-zone \
          --zone yandexcloud.example. \
          --public-visibility
        ```

        Result:

        ```
        id: dns4rq4tadddth4h20qm
        folder_id: b1g9hv2loamqfnbul7d9
        created_at: "2021-11-03T11:03:28.847Z"
        name: canary-dns-zone
        zone: yandexcloud.example.
        public_visibility: {}
        ```

        For more information about the `yc dns zone create` command, see the [CLI reference](../cli/cli-ref/managed-services/dns/zone/create.md).

     1. In the zone, create CNAME records for `cdn.yandexcloud.example` and `cdn-staging.yandexcloud.example` with a copied value in the `cl-....gcdn.co` format:

        ```bash
        yc dns zone add-records \
          --name canary-dns-zone \
          --record "cdn CNAME cl-....gcdn.co" \
          --record "cdn-staging CNAME cl-....gcdn.co"
        ```

        For more information about the `yc dns zone add-records` command, see the [CLI reference](../cli/cli-ref/managed-services/dns/zone/add-records.md).

   - {{ TF }}

     1. Add the parameters of the `canary-dns-zone` DNS zone and its CNAME records to the configuration file:

        ```
        ...
        
        resource "yandex_dns_zone" "canary-dns-zone" {
          zone   = "yandexcloud.example."
          name   = "canary-dns-zone"
          public = true
        }
        
        resource "yandex_dns_recordset" "canary-recordset-production" {
          zone_id = ${yandex_dns_zone.canary-dns-zone.id}
          name    = "cdn"
          type    = "CNAME"
          data    = ["<copied value in the format cl-....gcdn.co>"]
        }
        
        resource "yandex_dns_recordset" "canary-recordset-staging" {
          zone_id = ${yandex_dns_zone.canary-dns-zone.id}
          name    = "cdn-staging"
          type    = "CNAME"
          data    = ["<copied value in the format cl-....gcdn.co>"]
        }
        ```

        For more information, see the descriptions of the [yandex_dns_zone]({{ tf-provider-link }}/dns_zone) and [yandex_dns_recordset]({{ tf-provider-link }}/dns_recordset) resources in the {{ TF }} provider documentation.

     1. Make sure that the configuration files are correct.

        1. In the command line, go to the directory where you created the configuration file.
        1. Run the check using the command:

           ```bash
           terraform plan
           ```

        If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, {{ TF }} points them out.

     1. Deploy the cloud resources.

        1. If the configuration doesn't contain any errors, run the command:

           ```bash
           terraform apply
           ```

        1. Confirm that you want to create the resources.

   - API

     1. Create a DNS zone named `canary-dns-zone` using the gRPC API [DnsZoneService/Create](../dns/api-ref/grpc/dns_zone_service.md#Create) call or the REST API [create](../dns/api-ref/DnsZone/create.md) method.
     1. Add the `cdn` and `cdn-staging` CNAME records to the zone, copying the `cl-....gcdn.co` value with the gRPC API [DnsZoneService/UpdateRecordSets](../dns/api-ref/grpc/dns_zone_service.md#UpdateRecordSets) call or the REST API [updateRecordSets](../dns/api-ref/DnsZone/updateRecordSets.md) method.

   {% endlist %}

   {% endcut %}

Wait 15 to 20 minutes after setting up the DNS to check that the service is up and running.

## Run a health check and test the switching between versions {#check}

### Check one {#check-one}

Check that the domain name `cdn.yandexcloud.example` corresponds to version 1 and `cdn-staging.yandexcloud.example` corresponds to version 2:

1. Open a browser and go to `https://cdn.yandexcloud.example/index.html`. You should see a page indicating version 1.
1. Delete `index.html` from the CDN resource cache:

   {% list tabs %}

   - Management console

     1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
     1. In the list of services, select **{{ cdn-name }}**.
     1. Select the created CDN resource (the list of resources will contain its primary domain name: `cdn.yandexcloud.example`).
     1. Go to the **Content** tab.
     1. Click **Purge cache**.
     1. Select the purge type: **Selective**.
     1. Enter the path to the uploaded file: `/index.html`.
     1. Click **Purge cache**.

   - CLI

     1. Get the ID of the CDN resource that you created:

        ```bash
        yc cdn resource list
        ```

        Result:

        ```
        +----------------------+--------------------------+--------------------------------+--------------------------------+--------+-------------------------------------------+
        |          ID          |          CNAME           |           CREATED AT           |           UPDATED AT           | ACTIVE |                  OPTIONS                  |
        +----------------------+--------------------------+--------------------------------+--------------------------------+--------+-------------------------------------------+
        | bc837xptmpkhbc7xwioa | cdn.yandexcloud.example  | seconds:1637235693             | seconds:1637235693             | true   | edge_cache_settings:{enabled:true         |
        |                      |                          | nanos:434085000                | nanos:434115000                |        | default_value:345600}                     |
        |                      |                          |                                |                                |        | cache_http_headers:{value:"accept-ranges" |
        |                      |                          |                                |                                |        | value:"cache-control" value:"connection"  |
        |                      |                          |                                |                                |        | value:"content-encoding"                  |
        |                      |                          |                                |                                |        | value:"content-length"                    |
        |                      |                          |                                |                                |        | value:"content-type"                      |
        |                      |                          |                                |                                |        | value:"date" value:"etag"                 |
        |                      |                          |                                |                                |        | value:"expires" value:"keep-alive"        |
        |                      |                          |                                |                                |        | value:"last-modified" value:"server"      |
        |                      |                          |                                |                                |        | value:"vary"} stale:{enabled:true         |
        |                      |                          |                                |                                |        | value:"error" value:"updating"}           |
        |                      |                          |                                |                                |        | allowed_http_methods:{value:"GET"         |
        |                      |                          |                                |                                |        | value:"POST" value:"HEAD"                 |
        |                      |                          |                                |                                |        | value:"OPTIONS"}                          |
        +----------------------+--------------------------+--------------------------------+--------------------------------+--------+-------------------------------------------+
        ```

     1. Delete the file from the cache:

        ```bash
        yc cdn cache purge \
          --resource-id <ID of the CDN resource> \
          --path "/index.html"
        ```

   - API

     1. Get the ID of the CDN resource that you created using the gRPC API [ResourceService/List](../cdn/api-ref/grpc/resource_service.md#List) call or the REST API [list](../cdn/api-ref/Resource/list.md) method.
     1. Delete the `index.html` file from the cache using the gRPC API [CacheService/Purge](../cdn/api-ref/grpc/cache_service#Purge) call or the [purge](../cdn/api-ref/Cache/purge.md) method.

   {% endlist %}

1. Open the browser and go to `https://cdn-staging.yandexcloud.example/index.html`. You should see a page indicating version 2.

### Canary deployment of version 2 {#canary-v2}

1. Disable caching of the CDN resource and delete the `index.html` file from the cache:

   {% list tabs %}

   - Management console

     1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
     1. In the list of services, select **{{ cdn-name }}**.
     1. Select the created CDN resource (the list of resources will contain its primary domain name: `cdn.yandexcloud.example`).
     1. Go to the **Caching** tab
     1. Click **Edit**.
     1. Disable **CDN caching**.
     1. Tap **Save**.

   - API

     1. Get the ID of the CDN resource that you created using the gRPC API [ResourceService/List](../cdn/api-ref/grpc/resource_service.md#List) call or the REST API [list](../cdn/api-ref/Resource/list.md) method.
     1. Disable caching using the gRPC API [ResourceService/Update](../cdn/api-ref/grpc/resource_service.md#Update) call or the REST API [list](../cdn/api-ref/Resource/update.md) method.

   {% endlist %}

1. Delete `index.html` from the cache:

   {% list tabs %}

   - Management console

     1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
     1. In the list of services, select **{{ cdn-name }}**.
     1. Select the created CDN resource (the list of resources will contain its primary domain name: `cdn.yandexcloud.example`).
     1. Go to the **Content** tab.
     1. Click **Purge cache**.
     1. Select the purge type: **Selective**.
     1. Enter the path to the uploaded file: `/index.html`.
     1. Click **Purge cache**.

   - CLI

     1. Get the ID of the CDN resource that you created:

        ```bash
        yc cdn resource list
        ```

        Result:

        ```
        +----------------------+--------------------------+--------------------------------+--------------------------------+--------+-------------------------------------------+
        |          ID          |          CNAME           |           CREATED AT           |           UPDATED AT           | ACTIVE |                  OPTIONS                  |
        +----------------------+--------------------------+--------------------------------+--------------------------------+--------+-------------------------------------------+
        | bc837xptmpkhbc7xwioa | cdn.yandexcloud.example  | seconds:1637235693             | seconds:1637235693             | true   | edge_cache_settings:{enabled:true         |
        |                      |                          | nanos:434085000                | nanos:434115000                |        | default_value:345600}                     |
        |                      |                          |                                |                                |        | cache_http_headers:{value:"accept-ranges" |
        |                      |                          |                                |                                |        | value:"cache-control" value:"connection"  |
        |                      |                          |                                |                                |        | value:"content-encoding"                  |
        |                      |                          |                                |                                |        | value:"content-length"                    |
        |                      |                          |                                |                                |        | value:"content-type"                      |
        |                      |                          |                                |                                |        | value:"date" value:"etag"                 |
        |                      |                          |                                |                                |        | value:"expires" value:"keep-alive"        |
        |                      |                          |                                |                                |        | value:"last-modified" value:"server"      |
        |                      |                          |                                |                                |        | value:"vary"} stale:{enabled:true         |
        |                      |                          |                                |                                |        | value:"error" value:"updating"}           |
        |                      |                          |                                |                                |        | allowed_http_methods:{value:"GET"         |
        |                      |                          |                                |                                |        | value:"POST" value:"HEAD"                 |
        |                      |                          |                                |                                |        | value:"OPTIONS"}                          |
        +----------------------+--------------------------+--------------------------------+--------------------------------+--------+-------------------------------------------+
        ```

     1. Delete the file from the cache:

        ```bash
        yc cdn cache purge \
          --resource-id <ID of the CDN resource> \
          --path "/index.html"
        ```

   - API

     1. Get the ID of the CDN resource that you created using the gRPC API [ResourceService/List](../cdn/api-ref/grpc/resource_service.md#List) call or the REST API [list](../cdn/api-ref/Resource/list.md) method.
     1. Delete the `index.html` file from the cache using the gRPC API [CacheService/Purge](../cdn/api-ref/grpc/cache_service#Purge) call or the [purge](../cdn/api-ref/Cache/purge.md) method.

   {% endlist %}

1. Configure the `canary-bg-production` so that  20% of the traffic coming to the `cdn.yandexcloud.example` domain name is processed by the `canary-backend-green` backend that runs version 2:

   {% list tabs %}

   - Management console

     1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
     1. In the list of services, select **{{ alb-name }}** and go to the **Backend groups** tab.
     1. Select `canary-bg-production` in the backend group list.
     1. For the `canary-backend-blue` backend, set the weight to 80 instead of 100:

        1. In the **Backends** section, find `canary-backend-blue`, then click ![...](../_assets/horizontal-ellipsis.svg) → **Edit**.
        1. In the **Weight** field, enter `80`.
        1. Tap **Save**.

     1. Similarly set the weight to 20 instead of 0 for `canary-backend-green`.
     1. Tap **Save**.

   - CLI

     1. For the `canary-backend-blue` backend, set the weight to 80 instead of 100:

        ```bash
        yc alb backend-group update-http-backend \
          --backend-group-name canary-bg-production \
          --name canary-backend-blue \
          --weight 80
        ```

        Result:

        ```
        done (1s)
        id: ds7l9puc18c9b40cd359
        name: canary-bg-production
        folder_id: b1g9hv2loamqfnbul7d9
        http:
          backends:
          - name: canary-backend-blue
            backend_weight: "80"
            storage_bucket:
              bucket: canary-bucket-blue
        created_at: "2021-11-03T10:28:47.680825561Z"
        ```

        For more information about the `yc alb backend-group update-http-backend` command, see the [CLI reference](../cli/cli-ref/managed-services/application-load-balancer/backend-group/update-http-backend.md).

     1. Set the weight to 20 instead of 0 for `canary-backend-green`:

        ```bash
        yc alb backend-group update-http-backend \
          --backend-group-name canary-bg-production \
          --name canary-backend-green \
          --weight 20
        ```

        Result:

        ```
        done (1s)
        id: ds7l9puc18c9b40cd359
        name: canary-bg-production
        folder_id: b1g9hv2loamqfnbul7d9
        http:
          backends:
          - name: canary-backend-green
            backend_weight: "20"
            storage_bucket:
              bucket: canary-bucket-green
        created_at: "2021-11-03T10:28:47.680825561Z"
        ```

   - API

     Use the gRPC API [BackendGroupService/UpdateBackend](../application-load-balancer/api-ref/grpc/backend_group_service.md#UpdateBackend) call of the REST API [updateBackend](../application-load-balancer/api-ref/BackendGroup/updateBackend.md) method.

   {% endlist %}

1. Open the browser and go to `https://cdn.yandexcloud.example/index.html`, refreshing the page several times. In about 20% of cases, you should see a page indicating version 2, in the other cases, version 1.
1. Similarly to steps 1–2, configure and check the following traffic allocations between the backends:

   1. In the `canary-bg-production` backend group: 50%-50% traffic distribution between backends.
   1. In the `canary-bg-production` backend group, forward all traffic to `canary-backend-green`.
   1. In the `canary-bg-staging` backend group (with the domain name of `cdn-staging.yandexcloud.example`), allocate all traffic to `canary-backend-blue`.

1. Re-enable caching:

   {% list tabs %}

   - Management console

     1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
     1. In the list of services, select **{{ cdn-name }}**.
     1. Select the created CDN resource (the list of resources will contain its primary domain name: `cdn.yandexcloud.example`).
     1. Go to the **Caching** tab
     1. Click **Edit**.
     1. Enable **CDN caching**.
     1. Tap **Save**.

   - API

     1. Get the ID of the CDN resource that you created using the gRPC API [ResourceService/List](../cdn/api-ref/grpc/resource_service.md#List) call or the REST API [list](../cdn/api-ref/Resource/list.md) method.
     1. To enable caching, use the gRPC API [ResourceService/Update](../cdn/api-ref/grpc/resource_service.md#Update) call or the REST API [list](../cdn/api-ref/Resource/update.md) method.

   {% endlist %}

### Blue-green deployment for rolling back to version 1 {#blue-green-v1-rollback}

1. Disable caching of the CDN resource and delete the `index.html` file from the cache:

   {% list tabs %}

   - Management console

     1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
     1. In the list of services, select **{{ cdn-name }}**.
     1. Select the created CDN resource (the list of resources will contain its primary domain name: `cdn.yandexcloud.example`).
     1. Go to the **Caching** tab
     1. Click **Edit**.
     1. Disable **CDN caching**.
     1. Tap **Save**.

   - API

     1. Get the ID of the CDN resource that you created using the gRPC API [ResourceService/List](../cdn/api-ref/grpc/resource_service.md#List) call or the REST API [list](../cdn/api-ref/Resource/list.md) method.
     1. Disable caching using the gRPC API [ResourceService/Update](../cdn/api-ref/grpc/resource_service.md#Update) call or the REST API [list](../cdn/api-ref/Resource/update.md) method.

   {% endlist %}

1. Delete `index.html` from the cache:

   {% list tabs %}

   - Management console

     1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
     1. In the list of services, select **{{ cdn-name }}**.
     1. Select the created CDN resource (the list of resources will contain its primary domain name: `cdn.yandexcloud.example`).
     1. Go to the **Content** tab.
     1. Click **Purge cache**.
     1. Select the purge type: **Selective**.
     1. Enter the path to the uploaded file: `/index.html`.
     1. Click **Purge cache**.

   - CLI

     1. Get the ID of the CDN resource that you created:

        ```bash
        yc cdn resource list
        ```

        Result:

        ```
        +----------------------+--------------------------+--------------------------------+--------------------------------+--------+-------------------------------------------+
        |          ID          |          CNAME           |           CREATED AT           |           UPDATED AT           | ACTIVE |                  OPTIONS                  |
        +----------------------+--------------------------+--------------------------------+--------------------------------+--------+-------------------------------------------+
        | bc837xptmpkhbc7xwioa | cdn.yandexcloud.example  | seconds:1637235693             | seconds:1637235693             | true   | edge_cache_settings:{enabled:true         |
        |                      |                          | nanos:434085000                | nanos:434115000                |        | default_value:345600}                     |
        |                      |                          |                                |                                |        | cache_http_headers:{value:"accept-ranges" |
        |                      |                          |                                |                                |        | value:"cache-control" value:"connection"  |
        |                      |                          |                                |                                |        | value:"content-encoding"                  |
        |                      |                          |                                |                                |        | value:"content-length"                    |
        |                      |                          |                                |                                |        | value:"content-type"                      |
        |                      |                          |                                |                                |        | value:"date" value:"etag"                 |
        |                      |                          |                                |                                |        | value:"expires" value:"keep-alive"        |
        |                      |                          |                                |                                |        | value:"last-modified" value:"server"      |
        |                      |                          |                                |                                |        | value:"vary"} stale:{enabled:true         |
        |                      |                          |                                |                                |        | value:"error" value:"updating"}           |
        |                      |                          |                                |                                |        | allowed_http_methods:{value:"GET"         |
        |                      |                          |                                |                                |        | value:"POST" value:"HEAD"                 |
        |                      |                          |                                |                                |        | value:"OPTIONS"}                          |
        +----------------------+--------------------------+--------------------------------+--------------------------------+--------+-------------------------------------------+
        ```

     1. Delete the file from the cache:

        ```bash
        yc cdn cache purge \
          --resource-id <ID of the CDN resource> \
          --path "/index.html"
        ```

   - API

     1. Get the ID of the CDN resource that you created using the gRPC API [ResourceService/List](../cdn/api-ref/grpc/resource_service.md#List) call or the REST API [list](../cdn/api-ref/Resource/list.md) method.
     1. Delete the `index.html` file from the cache using the gRPC API [CacheService/Purge](../cdn/api-ref/grpc/cache_service#Purge) call or the [purge](../cdn/api-ref/Cache/purge.md) method.

   {% endlist %}

1. Forward all traffic of the `cdn.yandexcloud.example` domain name back to the `canary-backend-blue` backend running version 1:

   {% list tabs %}

   - Management console

     1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
     1. In the list of services, select **{{ alb-name }}** and go to the **Backend groups** tab.
     1. Select `canary-bg-production` in the backend group list.
     1. For the `canary-backend-blue` backend, set the weight to 100 instead of 0:

        1. In the **Backends** section, find `canary-backend-blue`, then click ![...](../_assets/horizontal-ellipsis.svg) → **Edit**.
        1. In the **Weight** field, enter `100`.
        1. Tap **Save**.

     1. Similarly, set the weight to 0 instead of 100 for `canary-bucket-green`.
     1. Tap **Save**.

   - CLI

     1. For the `canary-backend-blue` backend, set the weight to 100 instead of 0:

        ```bash
        yc alb backend-group update-http-backend \
          --backend-group-name canary-bg-production \
          --name canary-backend-blue \
          --weight 100
        ```

        Result:

        ```
        done (1s)
        id: ds7l9puc18c9b40cd359
        name: canary-bg-production
        folder_id: b1g9hv2loamqfnbul7d9
        http:
          backends:
          - name: canary-backend-blue
            backend_weight: "100"
            storage_bucket:
              bucket: canary-bucket-blue
        created_at: "2021-11-03T10:28:47.680825561Z"
        ```

     1. For `canary-backend-green`, set the weight to 0 instead of 100:

        ```bash
        yc alb backend-group update-http-backend \
          --backend-group-name canary-bg-production \
          --name canary-backend-green \
          --weight 0
        ```

        Result:

        ```
        done (1s)
        id: ds7l9puc18c9b40cd359
        name: canary-bg-production
        folder_id: b1g9hv2loamqfnbul7d9
        http:
          backends:
          - name: canary-backend-green
            backend_weight: "0"
            storage_bucket:
              bucket: canary-bucket-green
        created_at: "2021-11-03T10:28:47.680825561Z"
        ```

   - API

     Use the gRPC API [BackendGroupService/UpdateBackend](../application-load-balancer/api-ref/grpc/backend_group_service.md#UpdateBackend) call of the REST API [updateBackend](../application-load-balancer/api-ref/BackendGroup/updateBackend.md) method.

   {% endlist %}

1. Open the browser and go to `https://cdn.yandexcloud.example/index.html`, refreshing the page several times. In all other cases, you should see a page indicating version 1.
1. Similarly to steps 1–2, switch all the traffic for the `cdn-staging.yandexcloud.example` domain name to `canary-backend-green` running version 2 and check the switching in the browser.
1. Re-enable caching:

   {% list tabs %}

   - Management console

     1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
     1. In the list of services, select **{{ cdn-name }}**.
     1. Select the created CDN resource (the list of resources will contain its primary domain name: `cdn.yandexcloud.example`).
     1. Go to the **Caching** tab
     1. Click **Edit**.
     1. Enable **CDN caching**.
     1. Tap **Save**.

   - API

     1. Get the ID of the CDN resource that you created using the gRPC API [ResourceService/List](../cdn/api-ref/grpc/resource_service.md#List) call or the REST API [list](../cdn/api-ref/Resource/list.md) method.
     1. To enable caching, use the gRPC API [ResourceService/Update](../cdn/api-ref/grpc/resource_service.md#Update) call or the REST API [list](../cdn/api-ref/Resource/update.md) method.

   {% endlist %}

## Delete the resources you created {#clear-out}

To shut down the infrastructure and stop paying for the created resources:

1. If you set up CNAME records in {{ dns-name }}, [delete](../dns/operations/zone-delete.md) `canary-dns-zone`.
1. [Delete](../cdn/operations/resources/delete-resource.md) the CDN resource with the primary `cdn.yandexcloud.example` domain name.
1. [Delete](../application-load-balancer/operations/application-load-balancer-delete.md) the `canary-balancer` L7 load balancer.
1. [Delete](../storage/operations/objects/delete.md) all objects from the `canary-bucket-blue` and `canary-bucket-green` buckets.
1. [Delete](../storage/operations/buckets/delete.md) the `canary-bucket-blue` and `canary-bucket-green` buckets.
1. [Delete](../vpc/operations/subnet-delete.md) the `canary-subnet-{{ region-id }}-a`, `canary-subnet-{{ region-id }}-b`, and `canary-subnet-{{ region-id }}-c` subnets.
1. [Delete](../vpc/operations/network-delete.md) `canary-network`.
