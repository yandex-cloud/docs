# Writing load balancer logs to {{ PG }}


You can write load balancer [logs](../../application-load-balancer/concepts/application-load-balancer.md#logging) (messages about each incoming request to a {{ alb-full-name }}) to a {{ PG }} database.

To log load balancer operations, a [log group](../../logging/concepts/log-group.md) will be created in {{ cloud-logging-name }}. Log delivery from this group to the database will be set up using {{ sf-full-name }} resources: a [trigger](../../functions/concepts/trigger/cloud-logging-trigger.md) and a triggered [function](../../functions/concepts/function.md).

To create a database, we will use [{{ mpg-full-name }}](../../managed-postgresql/index.yaml).

To set up logging:

1. [Get your cloud ready](#before-begin).
1. [Create a cloud network](#create-network).
1. [Create a service account](#create-sa).
1. [Create security groups](#create-security-groups).
1. [Set up a database in {{ mpg-full-name }}](#set-up-db).
1. [Create an instance group](#create-vms).
1. [Create a {{ cloud-logging-full-name }} log group](#create-log-group).
1. [Create the required resources in {{ alb-full-name }}](#create-alb-resources).
1. [Create the required resources in {{ sf-full-name }}](#set-up-sf).
1. [Test the logging process](#test).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The support cost for a load balancer with logging includes:

* Fee for continuously running virtual machines (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for computing resources, the amount of storage and backups for a {{ PG }} cluster (see [{{ mpg-full-name }} pricing](../../managed-postgresql/pricing.md)).
* Fee for function calls for log processing and computing resources allocated to execute the function (see [{{ sf-full-name }} pricing](../../functions/pricing.md)).
* Fee for logging operations and log storage (see [{{ cloud-logging-full-name }} pricing](../../logging/pricing.md)).
* Fee for {{ alb-name }} resource usage (see [{{ alb-full-name }} pricing](../../application-load-balancer/pricing.md)).

## Create a cloud network {#create-network}

All resources you create will belong to the same [cloud network](../../vpc/concepts/network.md).

To create a network:

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
    1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
    1. Specify the network **{{ ui-key.yacloud.vpc.networks.create.field_name }}**: `alb-logging-network`.
    1. In the **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** field, select **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
    1. Click **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.
    
{% endlist %}

## Create a service account {#create-sa}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. In the [management console]({{ link-console-main }}), select the appropriate folder.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. In the **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** field, enter `alb-logging-service-account`.
  1. Add the `{{ roles-functions-invoker }}` and `editor` roles.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

## Create security groups {#create-security-groups}

[Security groups](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) include rules that: 
* Allow the load balancer to receive incoming traffic and forward it to the VMs so they can receive the traffic. 
* Allow the load balancer to send logs to the log group and the {{ PG }} cluster, to receive the logs from it.

You will create three security groups: one for the load balancer, another one for all VMs, and the third one for the cluster.

To create security groups:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Open the **{{ ui-key.yacloud.vpc.label_security-groups }}** tab.
  1. Create a security group for the load balancer:
     
     1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
     1. Specify the group **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}**: `alb-logging-sg-balancer`.
     1. Select the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}**: `alb-logging-network`.
     1. Under **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}**, create the following rules using the instructions below the table:

        | Traffic<br/>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | Source /<br/>destination | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
        | --- | --- | --- | --- | --- | --- |
        | `Outgoing` | `any` | `All` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
        | `Incoming` | `ext-http` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
        | `Incoming` | `ext-https` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
        | `Incoming` | `healthchecks` | `30080` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}` | — |
      
        1. Select the **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** or **{{ ui-key.yacloud.vpc.network.security-groups.label_ingress }}** tab.
        1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
        1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** field of the window that opens, specify a single port or a range of ports open for incoming or outgoing traffic.
        1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** field, specify the appropriate protocol or leave `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` to allow traffic transmission over any protocol.
        1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** or **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** field, select the purpose of the rule:
      
           * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`: Rule will apply to the range of IP addresses. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** field, specify the CIDR and subnet masks traffic will come to or from. To add multiple CIDRs, click **{{ ui-key.yacloud.vpc.subnetworks.create.button_add-cidr }}**.
           * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`: Rule will apply to the VMs from the current group or the selected security group.
           * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}`: Rule allowing a load balancer to health-check VMs.

        1. Click **{{ ui-key.yacloud.common.save }}**. Repeat these steps to create all rules from the table.
   
     1. Click **{{ ui-key.yacloud.common.save }}**.

  1. Similarly, create a security group for the VM named `alb-logging-sg-vms` with the same `alb-logging-network` and the following rules:
      
     | Traffic<br/>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | Source /<br/>destination | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
     | --- | --- | --- | --- | --- | --- |
     | `Incoming` | `balancer` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}` | `alb-logging-sg-balancer` |
     | `Incoming` | `ssh` | `22` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
     
  1. Similarly, create a security group for the {{ PG }} cluster named `alb-logging-sg-cluster` with the same `alb-logging-network` and the following rules:
        
       | Traffic<br/>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | Source /<br/>destination | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
       | --- | --- | --- | --- | --- | --- |
       | `Incoming` | `db` | `6432` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
     
{% endlist %}

## Set up a database in {{ mpg-full-name }} {#set-up-db}

### Create a cluster {#set-up-db-create-cluster}

Logs received from the load balancer will be written to the database that is part of the {{ mpg-name }} [cluster](../../managed-postgresql/concepts/index.md).

To create a cluster and a database:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. In the **{{ ui-key.yacloud.mdb.forms.base_field_name }}** field, enter `alb-logging-cluster`.
  1. In the **{{ ui-key.yacloud.mdb.forms.base_field_environment }}** field, select `PRODUCTION`.
  1. In the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field, select `12`.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_resource }}**:

     * Specify the `Intel Cascade Lake` platform.
     * Select the `burstable` type.
     * Specify the `b2.medium` class.

     {% note warning %}

     The `b2.medium` class was selected for testing only. In real projects, we do not recommend using hosts with a guaranteed vCPU share less than 100%.

     {% endnote %}

  1. Under **{{ ui-key.yacloud.mdb.forms.section_disk }}**:

     * Select `network-ssd`.
     * Set the size to 10 GB.

     {% note info %}

     Select the type and size of the disk to fit your purpose. The above values are used for testing.

     {% endnote %}

  1. Under **{{ ui-key.yacloud.mdb.forms.section_database }}**, specify the DB attributes:

     * Database name. It must be unique within the folder and contain only Latin letters, numbers, and underscores.
     * DB owner username. It may only contain Latin letters, numbers, and underscores.
     * User password. It must be from 8 to 128 characters long.

     For the database created with the cluster, the character set and collate settings are specified as `LC_CTYPE=C` and `LC_COLLATE=C`. You cannot change these settings after the database is created, but you can [create a new database](../../managed-postgresql/operations/databases.md#add-db) with the appropriate settings.

  1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**:

     * Select `alb-logging-network`.
     * Select the `alb-logging-sg-cluster` security group.
   
  1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**, add a host to be accessible from outside {{ yandex-cloud }}. To do this, enable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_additional }}**, enable **{{ ui-key.yacloud.mdb.forms.additional-field-websql }}** and **{{ ui-key.yacloud.mdb.forms.additional-field-serverless }}**.
  1. Leave the default values in all other fields.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

{% endlist %}

For more information about creating a cluster, see [How to create a PostgreSQL cluster](../../managed-postgresql/operations/cluster-create.md#create-cluster).

Afterwards, the cluster settings can be [updated](../../managed-postgresql/operations/update.md).

### Connect to the cluster and create a table {#set-up-db-create-table}

In this example, we will save data from the following message fields, which are logged by the load balancer when it receives requests, to the {{ PG }} database:

* `type`: Request protocol, HTTP or gRPC.
* `time`: Date and time of the request.
* `http_status`: HTTP code of the load balancer's response to the request.
* `backend_ip`: IP address of the VM that processed the request.
* `request_processing_times.request_time`: Duration of the connection between the client and the load balancer.

You need to create a log table in advance:

{% list tabs group=instructions %}

- Management console {#console}

  After [creating the cluster](#set-up-db-create-cluster), you will be automatically redirected to the **{{ ui-key.yacloud.mdb.clusters.label_title }}** page.

  1. Wait until `alb-logging-cluster` changes its status to **Alive**, then select this cluster.
  1. Navigate to the **{{ ui-key.yacloud.postgresql.cluster.switch_explore }}** tab.
  1. Select the user that you [created together with the cluster](#set-up-db-create-cluster) and enter their password.
  1. Select the database you created together with the cluster and click **{{ ui-key.yacloud.clickhouse.cluster.explore.button_submit-creds }}**.
  1. In the edit window, enter the following request:
  
     ```sql
     CREATE TABLE load_balancer_requests (
         type            varchar(24) NOT NULL,
         "time"          timestamptz NOT NULL,
         http_status     varchar(4) NOT NULL,
         backend_ip      varchar(40) NULL,
         request_time    numeric NULL
     );
     ```

  1. Click **{{ ui-key.yacloud.clickhouse.cluster.explore.button_execute }}**.
  1. Wait until a message confirms that the request is complete.
  
{% endlist %}
    
## Create an instance group {#create-vms}

We will use a {{ compute-name }} [instance group](../../compute/concepts/instance-groups/index.md) as web servers for your website. The LEMP stack (Linux, NGINX, MySQL, PHP) will be installed on the servers. For more information, see [LAMP or LEMP-based website](../../tutorials/web/lamp-lemp/index.md).

To create an instance group:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Open the **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}** tab. Click **{{ ui-key.yacloud.compute.groups.button_create }}**.
  1. Enter the instance group name: `alb-logging-ig`.
  1. In the **{{ ui-key.yacloud.compute.groups.create.field_service-account }}** field, select the account you [previously created](#create-sa).
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_allocation }}**, select multiple availability zones to ensure the fault tolerance of your hosting.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_instance }}**, click **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, open the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab and click **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**. Select [LEMP](/marketplace/products/yc/lemp) and click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
     
     - Select the VM [platform](../../compute/concepts/vm-platforms.md).
     - Specify the required number of vCPUs and the amount of RAM.
  
     This minimum configuration will do for functional website testing:
     * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Cascade Lake`
     * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `5%`
     * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
     * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `1 {{ ui-key.yacloud.common.units.label_gigabyte }}`
  
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, select the **{{ ui-key.yacloud.compute.instances.create.field_instance-group-network }}** named `alb-logging-network` that you [created earlier](#create-network) and its subnets.
  1. In the **{{ ui-key.yacloud.compute.instances.create.field_instance-group-address }}** field, select **{{ ui-key.yacloud.compute.instances.create.value_address-auto }}**. 
  1. Select the `alb-logging-sg-vms` security group [created earlier](#create-security-groups).
  1. Specify the VM access credentials:
     - Under **{{ ui-key.yacloud.compute.instances.create.field_user }}**, enter the username.
     - In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the public key file.
        
       You need to create a key pair for the SSH connection yourself. See [Connecting to a VM via SSH](../../compute/operations/vm-connect/ssh.md).
        
     {% note alert %}
      
     Once created, the VM gets an IP address and a host name (FQDN) for connections. If you selected **{{ ui-key.yacloud.compute.instances.create.value_address-none }}** in the **{{ ui-key.yacloud.compute.instances.create.field_instance-group-address }}** field, you will not be able to access the VM from the internet.
      
     {% endnote %}
     
  1. Click **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_scale }}**, enter the **{{ ui-key.yacloud.compute.groups.create.field_scale-size }}** of the instance group: 2.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_alb }}**, select **{{ ui-key.yacloud.compute.groups.create.field_target-group-attached }}** and enter `alb-logging-tg` as the group name. [Read more about target groups](../../application-load-balancer/concepts/target-group.md).
  1. Click **{{ ui-key.yacloud.common.create }}**.
  
{% endlist %}

It may take a few minutes to create an instance group. Wait until the group [status](../../compute/concepts/instance-groups/statuses.md#group-statuses) switches to `RUNNING`, and all VMs in it [status](../../compute/concepts/instance-groups/statuses.md#vm-statuses) switch to `RUNNING_ACTUAL`.

![ig-running](../../_assets/application-load-balancer/tutorials/virtual-hosting/ig-running.png)

## Create a log group in {{ cloud-logging-full-name }} {#create-log-group}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create your [log group](../../logging/concepts/log-group.md).
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
    1. Click **{{ ui-key.yacloud.logging.button_create-group }}**.
    1. Enter a name, e.g., `alb-logging-group`, and description for the log group.
    1. Set the log group record retention period.
    1. Click **{{ ui-key.yacloud.logging.button_create-group }}**.

{% endlist %}

## Create the required resources in {{ alb-full-name }} {#create-alb-resources}

### Create a backend group {#create-backend-group}

You must link the target group created with the instance group to the [backend group](../../application-load-balancer/concepts/backend-group.md) that defines traffic allocation settings.

For the backends, the group will implement a [health check](../../application-load-balancer/concepts/backend-group.md#health-checks): the load balancer will periodically send health check requests to the VMs and expect a response for a certain period.

To create a backend group:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.alb.label_backend-groups }}**. Click **{{ ui-key.yacloud.alb.button_backend-group-create }}**.
  1. Enter the backend group **{{ ui-key.yacloud.common.name }}**: `alb-logging-bg`.
  1. Under **{{ ui-key.yacloud.alb.label_backends }}**, click **{{ ui-key.yacloud.common.add }}**.
  1. Enter the backend **{{ ui-key.yacloud.common.name }}**: `alb-logging-backend`.
  1. In the **{{ ui-key.yacloud.alb.label_target-groups }}** field, select the `alb-logging-tg` group.
  1. Specify **{{ ui-key.yacloud.alb.label_port }}** the backend VMs will use to receive incoming traffic from the load balancer: `80`.
  1. Click **{{ ui-key.yacloud.alb.button_add-healthcheck }}**.
  1. Specify **{{ ui-key.yacloud.alb.label_port }}** the backend VMs will use to accept health check connections: `80`.
  1. Specify **{{ ui-key.yacloud.alb.label_path }}** the load balancer will use for health checks: `/`.
  1. Click **{{ ui-key.yacloud.common.create }}**.
  
{% endlist %}

### Create and configure an HTTP router {#create-http-router}

The backend group should be linked to an [HTTP router](../../application-load-balancer/concepts/http-router.md) that defines the HTTP routing rules.

To create an HTTP router:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}**. Click **{{ ui-key.yacloud.alb.button_http-router-create }}**.
  1. Specify the HTTP router **{{ ui-key.yacloud.common.name }}**: `alb-logging-router`.
  1. Click **{{ ui-key.yacloud.alb.button_virtual-host-add }}**.
  1. Specify the virtual host **{{ ui-key.yacloud.common.name }}**: `alb-logging-host`.
  1. Click **{{ ui-key.yacloud.alb.button_add-route }}**.
  1. Specify the route **{{ ui-key.yacloud.common.name }}**: `alb-logging-route`.
  1. In the **{{ ui-key.yacloud.alb.label_backend-group }}** field, select the `alb-logging-bg` group.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Create an L7 load balancer {#create-l7-balancer}

To create a load balancer:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Click **{{ ui-key.yacloud.alb.button_load-balancer-create }}** and select **{{ ui-key.yacloud.alb.label_alb-create-form }}**.
  1. Enter the load balancer **{{ ui-key.yacloud.common.name }}**: `alb-logging-balancer`.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select `alb-logging-network` and the `alb-logging-sg-balancer` security group that you created earlier.
  1. Under **{{ ui-key.yacloud.alb.section_logs-settings }}**, specify `alb-logging-group`.
  1. Under **{{ ui-key.yacloud.alb.label_listeners }}**, click **{{ ui-key.yacloud.alb.button_add-listener }}**.
  1. Enter the listener **{{ ui-key.yacloud.common.name }}**: `alb-logging-listener`.
  1. In the **{{ ui-key.yacloud.alb.label_protocol-type }}** field, select `{{ ui-key.yacloud.alb.label_proto-http-tls }}`.
  1. In the **{{ ui-key.yacloud.alb.label_http-router }}** field, select the `alb-logging-router` router you [created earlier](#create-http-router).
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Create the required resources in {{ sf-full-name }} {#set-up-sf}

### Create a function for processing data {#set-up-sf-create-function}

The [function](../../functions/concepts/function.md) will receive messages from the log group and write them to the table [created earlier](#set-up-db-create-table).

To create a function:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
  1. Enter the function name: `alb-logging-function`.
  1. Click **{{ ui-key.yacloud.common.create }}**. After creating the function, you will be automatically redirected to the **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}** page.
  1. Select **Python** **3.8** as the runtime environment and click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
  1. Clear the file editing area and paste the following code into it:
  
     {% cut "Function code" %}
     
     ```python
     import os
     import logging
     import psycopg2
     import json
     
     logger = logging.getLogger()
     logger.setLevel(logging.INFO)
     verboseLogging = eval(os.environ['VERBOSE_LOG'])
     if verboseLogging:
         logger.info('Loading handler function')
     
     def handler(event, context):
         statusCode = 500
         
         if verboseLogging:
             logger.info(event)
             logger.info(context)
         
         connection_string = (
             "host='{db_hostname}' port='{db_port}' dbname='{db_name}' "
             "user='{db_user}' password='{db_password}' sslmode='require'"
         ).format(
             db_hostname=os.environ['DB_HOSTNAME'],
             db_port=os.environ['DB_PORT'],
             db_name=os.environ['DB_NAME'],
             db_user=os.environ['DB_USER'],
             db_password=os.environ['DB_PASSWORD']
         )
             
         if verboseLogging:
             logger.info(f'Connecting: {connection_string}')
     
         conn = psycopg2.connect(connection_string)
         cursor = conn.cursor()
     
         messages = event['messages'][0]['details']['messages']
     
         for message in messages:
             alb_message = message['json_payload']
             alb_message['table_name'] = 'load_balancer_requests'
             insert_statement = (
                 'INSERT INTO {table_name} ' 
                 '(type, "time", http_status, backend_ip, request_time) ' 
                 'VALUES(\'{type}\', timestamptz \'{time}\', \'{http_status}\', ' 
                 '\'{backend_ip}\', {request_processing_times[request_time]});'
             ).format(**alb_message)
     
             if verboseLogging:
                 logger.info(f'Exec: {insert_statement}')
             try:
                 cursor.execute(insert_statement)
                 statusCode = 200
             except Exception as error:
                 logger.error(error)
             
             conn.commit()
             
         cursor.close()
         conn.close()
     
         return {
             'statusCode': statusCode,
             'headers': {
                 'Content-Type': 'text/plain'
             }
         }
     ```

     {% endcut %}
  
  1. Specify the following version parameters:
  
     * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `10`
     * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud.common.units.label_megabyte }}`
  
  1. Select the `alb-logging-service-account` service account you created earlier. The function will write data to the DB on behalf of this account.
  
  1. Add these environment variables:
  
     * `VERBOSE_LOG`: Parameter displaying detailed information about the function. Type in `True`.
     * `DB_HOSTNAME`: Name of the {{ PG }} database host to connect to.
     * `DB_PORT`: Port for the connection.
     * `DB_NAME`: Name of the database to connect to.
     * `DB_USER`: Username for the connection.
     * `DB_PASSWORD`: Password you entered when [creating your cluster](#cluster).
  
     To define the values of connection parameters:
  
     1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
     1. Select `alb-logging-cluster`.
     1. In the line with the database you need, click ![image](../../_assets/console-icons/ellipsis.svg).
     1. Select **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}**.
     1. On the **Shell** tab, find a sample connection string.
     1. Move the values of the `host`, `port`, `dbname`, and `user` variables to the appropriate **{{ ui-key.yacloud.common.value }}** field for the function environment variables.
  
  1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

{% endlist %}

### Create a trigger {#set-up-sf-create-trigger}

The [trigger](../../functions/concepts/trigger/index.md) will receive copies of messages from the load balancer and forward them to the function for processing.

To create a trigger:

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create a trigger.

    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.

    1. In the left-hand panel, select ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * Enter a name for the trigger, e.g., `alb-logging-trigger`.
        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_logging }}`.
        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}`.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_logging }}**:
        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_log-group }}** field, select `alb-logging-group`.
        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_resource-type }}** field, specify `alb.loadBalancer`.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}**:
        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_cutoff }}** field, specify `15`.
        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_size }}** field, specify `10`.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**, select the function you previously created, and specify:

        * Tag of the function version: `$latest`.
        * Service account you created earlier.

    1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To create a trigger that invokes a function, run this command:

    ```bash
    yc serverless trigger create logging alb-logging-trigger \
      --log-group-name <log_group_name> \
      --resource-types alb.loadBalancer \
      --batch-size 10 \
      --batch-cutoff 15s \
      --invoke-function-name alb-logging-function \
      --invoke-function-service-account-name alb-logging-service-account \
    ```

  Where:

  * `--log-group-name`: Name of the log group you [created earlier](#create-log-group).
  * `--resource-types`: Log group resource types.
  * `--invoke-function-name`: Name of the function you [created earlier](#set-up-sf-create-function).
  * `--invoke-function-service-account-name`: Name of the service account created together with the function.
  * `--batch-size`: Maximum number of messages sent to the function at the same time.
  * `--batch-cutoff`: Maximum time interval between consecutive messages to the function.
  
  For more information about the command, see the [CLI reference](../../cli/cli-ref/serverless/cli-ref/trigger/create/logging.md).
  
- API {#api}

  Use the [TriggerService/Create](../../functions/triggers/api-ref/grpc/Trigger/create.md) gRPC API call or the [create](../../functions/triggers/api-ref/Trigger/create.md) REST API method.
  
{% endlist %}
  
## Test the load balancer and logging {#test}

1. Get the public IP address of the load balancer:

   {% list tabs group=instructions %}
   
   - Management console {#console}
   
     1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
     1. Find the `alb-logging-balancer` load balancer in the list and copy its IP address.
     
   {% endlist %}
   
1. In your browser, open `http://<load_balancer_IP_address>`. Refresh the page several times.
1. Make sure the logs contain information about your requests to the load balancer:

   {% list tabs group=instructions %}
   
   - Management console {#console}
   
     1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
     1. Select `alb-logging-cluster`.
     1. Navigate to the **{{ ui-key.yacloud.postgresql.cluster.switch_explore }}** tab.
     1. Select the user that you [created together with the cluster](#set-up-db-create-cluster) and enter their password.
     1. Select the database you created together with the cluster, and click **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}**.
     1. Click the `load_balancer_requests` table. You should now see the first rows of this table with your requests to the load balancer.
     
   {% endlist %}

## How to delete the resources you created {#clear-out}

To shut down the load balancer and stop paying for the resources you created: 

1. [Delete](../../application-load-balancer/operations/application-load-balancer-delete.md) the `alb-logging-balancer` L7 load balancer.
1. [Delete](../../application-load-balancer/operations/http-router-delete.md) the `alb-logging-router` HTTP router.
1. [Delete](../../application-load-balancer/operations/backend-group-delete.md) the `alb-logging-bg` backend group.
1. [Delete](../../compute/operations/instance-groups/delete.md) the `alb-logging-ig` instance group.
1. [Delete](../../functions/operations/trigger/trigger-delete.md) the `alb-logging-trigger` trigger.
1. [Delete](../../functions/operations/function/function-delete.md) the `alb-logging-function` function.
1. [Delete](../../managed-postgresql/operations/cluster-delete.md) the `alb-logging-cluster` cluster.
1. [Delete](../../logging/operations/delete-group.md) the `alb-logging-group` log group.
