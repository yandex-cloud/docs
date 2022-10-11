# Writing load balancer logs to {{ PG }}

This use case describes [logging](../../application-load-balancer/concepts/application-load-balancer.md#logging) messages about each incoming request to the {{ alb-full-name }} load balancer to the {{ PG }} database.

To log load balancer operations, a log group is automatically created. Under the use case, log delivery from this log group to the database will be set up using {{ sf-full-name }} resources: a [trigger](../../functions/concepts/trigger/cloudlogs-trigger.md) and triggered [function](../../functions/concepts/function.md)

To create a database, in this use case we'll use {{ mpg-full-name }}.

{% note info %}

Some use case steps can't be performed in the [management console]({{ link-console-main }}). You can [get the log group ID](#get-log-group-id) and [create a trigger](#set-up-sf-create-trigger) with this ID through the CLI or API only.

{% endnote %}

To set up logging:

1. [Before you start](#before-begin).
1. [Create a cloud network](#create-network).
1. [Create security groups](#create-security-groups).
1. [Set up a database in {{ mpg-full-name }}](#set-up-db).
1. [Create an instance group](#create-vms).
1. [Create the necessary resources in {{ alb-full-name }}](#create-alb-resources).
1. [Get the ID of the log group for the load balancer](#get-log-group-id).
1. [Create the necessary resources in {{ sf-full-name }}](#set-up-sf).
1. [Test the logging process](#test).

If you no longer need these resources, [delete them](#clear-out).

## Before you start {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The support cost for a load balancer with logging includes:

* A fee for continuously running virtual machines (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* A payment for computing resources, the amount of storage and backups for a {{ PG }} cluster (see [{{ mpg-full-name }} pricing](../../managed-postgresql/pricing.md)).
* A payment for calling the log-processing function and allocating computing resources to the function (see [{{ sf-full-name }}](../../functions/pricing.md) pricing).


## Create a cloud network {#create-network}

All resources you have created in the tutorial belong to the same [cloud network](../../vpc/concepts/network.md).

To create a network:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), open **{{ vpc-name }}**.
   1. Click **Create network**.
   1. Enter the network **Name**: `alb-logging-network`.
   1. In the **Advanced** field, select **Create subnets**.
   1. Click **Create network**.

{% endlist %}

## Create security groups {#create-security-groups}

{% include [security-groups-note](../../application-load-balancer/_includes_service/security-groups-note.md) %}

[Security groups](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) include rules that:
* Let the load balancer receive incoming traffic and redirect it to the VMs so they can receive the traffic.
* Let the load balancer send logs to the log group and the {{ PG }} cluster receive the logs from it.

Three security groups will be created in the use case: for the load balancer, all VMs, and the cluster.

To create security groups:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), open **{{ vpc-name }}**.
   1. Open the **Security groups** tab.
   1. Create a security group for the load balancer:

      1. Click **Create group**.
      1. Enter the **Name** for the group: `alb-logging-sg-balancer`.
      1. Select the **Network**: `alb-logging-network`.
      1. Under **Rules**, create the following rules using the instructions below the table:

         | Traffic<br/>direction | Description | Port<br/>range | Protocol | Source/<br/>destination type | Source /<br/>destination |
         | --- | --- | --- | --- | --- | --- |
         | Outgoing | any | All | Any | CIDR | 0.0.0.0/0 |
         | Incoming | ext-http | 80 | TCP | CIDR | 0.0.0.0/0 |
         | Incoming | ext-https | 443 | TCP | CIDR | 0.0.0.0/0 |
         | Incoming | healthchecks | 30080 | TCP | CIDR | 198.18.235.0/24<br/>198.18.248.0/24 |

         1. Select the **Outgoing traffic** or **Incoming traffic** tab.
         1. Click **Add rule**.
         1. In the **Port range** field of the window that opens, specify a single port or a range of ports that traffic will come to or from.
         1. In the **Protocol** field, specify the desired protocol or leave **Any** to allow traffic transmission over any protocol.
         1. In the **Purpose** or **Source** field, select the purpose of the rule:

            * **CIDR**: The rule will apply to the range of IP addresses. In the **CIDR blocks** field, specify the CIDR and masks of subnets that traffic will come to or from. To add multiple CIDRs, click **Add CIDR**.
            * **Security group**: The rule will apply to the VMs from the current group or the selected security group.

         1. Click **Save**. Repeat the steps to create all rules from the table.

      1. Click **Save**.

   1. In the same way, create a security group for the VMs named `alb-logging-sg-vms` with the same `alb-logging-network` network and the following rules:

      | Traffic<br/>direction | Description | Port<br/>range | Protocol | Source type | Source |
      | --- | --- | --- | --- | --- | --- |
      | Incoming | balancer | 80 | TCP | Security group | `alb-logging-sg-balancer` |
      | Incoming | ssh | 22 | TCP | CIDR | 0.0.0.0/0 |

   1. In the same way, create a security group for the {{ PG }} cluster named `alb-logging-sg-cluster` with the same network `alb-logging-network` and the following rules:

      | Traffic<br/>direction | Description | Port<br/>range | Protocol | Source type | Source |
      | --- | --- | --- | --- | --- | --- |
      | Incoming | db | 6432 | TCP | CIDR | 0.0.0.0/0 |

{% endlist %}

## Set up a database in {{ mpg-full-name }} {#set-up-db}

### Create a cluster {#set-up-db-create-cluster}

Logs received from the load balancer will be written to the database that is part of the [cluster](../../managed-postgresql/concepts/index.md) {{ mpg-name }}.

To create a cluster and a database:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), open **{{ mpg-name }}**.
   1. Click **Create cluster**.
   1. In the **Cluster name** field, enter `alb-logging-cluster`.
   1. In the **Environment** field, select `PRODUCTION`.
   1. In the **Version** field, select `12`.
   1. Under **Host class**:

      * Specify the `Intel Cascade Lake` platform.
      * Select the `burstable` type.
      * Specify the `b2.nano` class.

      {% note warning %}

      The `b2.nano` class was only selected as part of testing. In real projects, it isn't recommended to use hosts with a guaranteed vCPU share under 100%.

      {% endnote %}

   1. Under **Storage size**:

      * Choose `network-ssd`.
      * Set the size to 10 GB.

      {% note info %}

      The type and size of the disk should be selected according to the projects to be implemented. The above values are used for testing.

      {% endnote %}

   1. Under **Database**, specify the DB attributes:

      * Database name. The DB name must be unique within the folder and contain only Latin letters, numbers, and underscores.
      * The name of the user who is the DB owner. The username may only contain Latin letters, numbers, and underscores.
      * User password. From 8 to 128 characters.

      For the database created with the cluster, the character set and collate settings are specified as `LC_CTYPE=C` and `LC_COLLATE=C`. You can't change these settings after the database is created, but you can [create a new database](../../managed-postgresql/operations/databases.md#add-db) with the right settings.

   1. Under **Network settings**:

      * Select the network `alb-logging-network`.
      * Select the security group `alb-logging-sg-cluster`.

   1. Under **Hosts**, add a host to be accessible from outside of {{ yandex-cloud }}. To do this, enable **Public access**.
   1. Under **Additional settings**, enable the options **Access from the management console** and **Serverless access**.
   1. Leave the default values in the other fields.
   1. Click **Create cluster**.

{% endlist %}

For more information about creating a cluster, see [How to create a PostgreSQL cluster](../../managed-postgresql/operations/cluster-create.md#create-cluster).

Afterwards, the cluster settings can be [updated](../../managed-postgresql/operations/update.md).

### Connect to the cluster and create a table {#set-up-db-create-table}

As an example, we'll save data from the following message fields, which are logged by the load balancer when it receives requests, to the {{ PG }} database:

* `type`: Request protocol (HTTP or gRPC).
* `time`: Date and time of the request.
* `http_status`: HTTP code of the load balancer's response to the request.
* `backend_ip`: IP address of the VM that processed the request.
* `request_processing_times.request_time`: Duration of the connection between the client and the load balancer.

You need to create a log table in advance:

{% list tabs %}

- Management console

   After [creating the cluster](#set-up-db-create-cluster), you'll be automatically redirected to the **Clusters** page.

   1. Wait until the `alb-logging-cluster cluster` changes its status to **Alive**, then select this cluster.
   1. Go to the **SQL** tab.
   1. Select the user that you [created together with the cluster](#set-up-db-create-cluster) and enter their password.
   1. Select the database that you created together with the cluster, and click **Connect**.
   1. In the edit window, enter the following query:

      ```sql
      CREATE TABLE load_balancer_requests (
          type            varchar(24) NOT NULL,
          "time"          timestamptz NOT NULL,
          http_status     varchar(4) NOT NULL,
          backend_ip      varchar(40) NULL,
          request_time    numeric NULL
      );
      ```

   1. Click **Run**.
   1. Wait until a message that the query is executed appears.

{% endlist %}

## Create an instance group {#create-vms}

As web servers for your site, you'll use an [instance group](../../compute/concepts/instance-groups/index.md) {{ compute-name }}. In this use case, the servers will be deployed on the LEMP stack (Linux, NGINX, MySQL, PHP). For more information, see the use case [Website on LAMP or LEMP stack](../../tutorials/web/lamp-lemp.md).

To create an instance group:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), open **{{ compute-name }}**.
   1. Open the **Instance groups** tab. Click **Create group**.
   1. Enter the instance group name: `alb-logging-ig`.
   1. Under **Allocation**, select multiple availability zones to ensure fault tolerance of your hosting.
   1. Under **Instance template**, click **Define**.
   1. On the **{{ marketplace-name }}** tab, click **Show more** and select the **LEMP** product. Click **Use**.
   1. Under **Computing resources**:

      - Select the VM's [platform](../../compute/concepts/vm-platforms.md).
      - Specify the necessary number of vCPUs and amount of RAM.

      The minimum configuration is enough for functional website testing:
      * **Platform**: Intel Cascade Lake.
      * **Guaranteed vCPU share**: 5%.
      * **vCPU**: 2.
      * **RAM**: 1 GB.

   1. Under **Network settings**, select the **Network** named `alb-logging-network` that you [created earlier](#create-network) and its subnets.
   1. In the **Public address** field, select **Auto**.
   1. Select the [previously created](#create-security-groups) `alb-logging-sg-vms` security group.
   1. Specify data required for accessing the VM:
      - Enter the username in the **Login** field.
      - In the **SSH key** field, paste the contents of the public key file.

         You need to create a key pair for the SSH connection yourself. See the [section about how to connect to VMs via SSH](../../compute/operations/vm-connect/ssh.md).

      {% note alert %}

      The IP address and host name (FQDN) to connect to the VM are assigned on VM creation. If you selected **No address** in the **Public address** field, you won't be able to access the VM from the internet.

      {% endnote %}

   1. Click **Save**.
   1. Under **Scaling**, enter the **Size** of the instance group: 2.
   1. Under **Integration with Application Load Balancer**, select **Create target group** and specify `alb-logging-tg` as the group name. [Read more about target groups](../../application-load-balancer/concepts/target-group.md).
   1. Click **Create**.

{% endlist %}

It may take several minutes to create an instance group. Once created, the group's [status](../../compute/concepts/instance-groups/statuses.md#group-statuses) changes to `RUNNING`and the [status](../../compute/concepts/instance-groups/statuses.md#vm-statuses) of all of its VMs to `RUNNING_ACTUAL`.

![ig-running](../../_assets/application-load-balancer/tutorials/virtual-hosting/ig-running.png)

## Create the necessary resources in {{ alb-full-name }} {#create-alb-resources}

### Create a backend group {#create-backend-group}

You must link the target group created with the VM group to the [backend group](../../application-load-balancer/concepts/backend-group.md) that defines traffic allocation settings.

For the backends in the group, a [health check](../../application-load-balancer/concepts/backend-group.md#health-checks) will be created: the load balancer will periodically send health check requests to the VMs and expect a response for a certain period of time.

To create a backend group:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), open **{{ alb-name }}**.
   1. Open the **Backend groups** tab. Click **Create backend group**.
   1. Enter the **Name** for the backend group: `alb-logging-bg`.
   1. Under **Backends**, click **Add**.
   1. Enter the **Name** for the backend: `alb-logging-backend`.
   1. In the **Target group** field, select the `alb-logging-tg` group.
   1. Specify the **Port** that the backend VMs will use to receive incoming traffic from the load balancer: `80`.
   1. Click **Add health check**.
   1. Enter the **Port** that the backend VMs will use to accept health check connections from the load balancer: `80`.
   1. Enter the **Path** to be accessed by the load balancer's health checks: `/`.
   1. Click **Create**.

{% endlist %}

### Create and configure an HTTP router {#create-http-router}

The backend group should be linked to an [HTTP router](../../application-load-balancer/concepts/http-router.md) that defines HTTP routing rules.

To create an HTTP router:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), open **{{ alb-name }}**.
   1. Open the **HTTP routers** tab. Click **Create HTTP router**.
   1. Enter the **Name** of the HTTP router: `alb-logging-router`.
   1. Click **Add virtual host**.
   1. Enter the **Name** of the virtual host: `alb-logging-host`.
   1. Click **Add route**.
   1. Enter the **Name** of the route: `alb-logging-route`.
   1. In the **Backend group** field, select the `alb-logging-bg` group.
   1. Click **Create**.

{% endlist %}

### Create an L7 load Balancer {#create-l7-balancer}

To create a load balancer:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), open **{{ alb-name }}**.
   1. Click **Create L7 load balancer**.
   1. Enter the **Name** of the load balancer: `alb-logging-balancer`.
   1. Under **Network settings**, select the `alb-logging-network` network and the `alb-logging-sg-balancer` security group you created previously.
   1. Click **Add listener** under **Listeners**.
   1. Enter the **Name** of the listener: `alb-logging-listener`.
   1. In the **Protocol** field, select **HTTP**.
   1. In the **HTTP Router** field, select the router `alb-logging-router` you [created previously](#create-http-router).
   1. Click **Create**.

{% endlist %}

## Get the ID of the log group for the load balancer {#get-log-group-id}

{% note info %}

You can't perform this step in the [management console]({{ link-console-main }}).

{% endnote %}

Along with a load balancer, a log group is created to write logs to. You'll need the log group ID when creating a trigger in {{ sf-name }}.

To get the log group ID:

{% list tabs %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   Run the command:

   ```bash
   yc alb load-balancer get alb-logging-balancer | grep log_group_id
   ```

- API

   Use the gRPC API [LoadBalancerService/Get](../../application-load-balancer/api-ref/grpc/load_balancer_service.md#Get) call or the [get](../../application-load-balancer/api-ref/LoadBalancer/get.md) REST API method. The ID of the log group will be specified in the `log_group_id` field.

{% endlist %}

## Create the necessary resources in {{ sf-full-name }} {#set-up-sf}

### Create a function for processing data {#set-up-sf-create-function}

The [function](../../functions/concepts/function.md) will receive messages from the log group and write them to the table [created earlier](#set-up-db-create-table).

To create a function:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), open **{{ sf-name }}**.
   1. Click **Create function**.
   1. Enter the function name: `alb-logging-function`.
   1. Click **Create**. After creating the function, you'll be automatically redirected to the **Editor** page.
   1. Select the **Python** runtime environment and click **Next**.
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
              alb_message = json.loads(message['message'])
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

   2. Specify the following version parameters:

      * **Timeout, sec:** 10.
      * **RAM:** 128 MB.

   3. Create a service account:

      1. Click **Create account** (or **Create new**). An additional window opens.
      2. In the **Name** field, enter `alb-logging-function-service-account`.
      3. Add roles: `serverless.functions.invoker` and `editor`.
      4. Click **Create**.

      The created account is automatically added to the **Service account** field. On behalf of this account, the function will write data to the DB.

   4. Add environment variables:

      * `VERBOSE_LOG`: Parameter that displays detailed information about the function execution. Set it to `True`.
      * `DB_HOSTNAME`: Name of the {{ PG }} DB host to connect to.
      * `DB_PORT`: Port to connect to.
      * `DB_NAME`: Name of the database to connect to.
      * `DB_USER`: Username for the connection.
      * `DB_PASSWORD`: Password that you entered when [creating your cluster](#cluster).

      To define the values of connection parameters:

      1. In the [management console]({{ link-console-main }}), open **{{ mpg-name }}**.
      2. Select the cluster `alb-logging-cluster`.
      3. Click ![image](../../_assets/horizontal-ellipsis.svg) in the line with the desired DB.
      4. Click **Connect**.
      5. On the **Shell** tab, find a sample connection string.
      6. Move the values of the `host`, `port`, `dbname`, and `user` variables to the appropriate **Value** field of the function environment variables.

   5. In the upper-right corner, click **Create version**.

{% endlist %}

### Create a trigger {#set-up-sf-create-trigger}

The [trigger](../../functions/concepts/trigger/index.md) will receive copies of messages from the load balancer and pass them to the function for processing.

{% note info %}

{{ alb-name }} uses a special type of log group. Before creating a trigger, ask [technical support]({{ link-console-support }}) to give you the option to create triggers for such log groups. You can only create a trigger using the CLI or API.

{% endnote %}

To create a trigger:

{% list tabs %}

- CLI

   Run the command:

   ```bash
   yc serverless trigger create cloud-logs alb-logging-trigger \
     --log-groups <log group ID> \
     --invoke-function-name alb-logging-function \
     --invoke-function-service-account-name alb-logging-function-service-account \
     --batch-size 10 \
     --batch-cutoff 15s
   ```

   * `--log-groups`: ID of the log group for the load balancer, which you [received earlier](#get-log-group-id).
   * `--invoke-function-name`: Name of the function that you [created earlier](#set-up-sf-create-function).
   * `--invoke-function-service-account-name`: The name of the service account you created along with the function.
   * `--batch-size`: The maximum number of messages sent to the function at the same time.
   * `--batch-cutoff`: The maximum time interval between sending consecutive messages to the function.

   For more information about the command, see the [CLI reference](../../cli/cli-ref/managed-services/serverless/trigger/create/cloud-logs.md).

- API

   Use the [TriggerService/Create](../../functions/triggers/api-ref/grpc/trigger_service.md#Create) gRPC API call or the [create](../../functions/triggers/api-ref/Trigger/create.md) REST API method.

{% endlist %}

## Test the load balancer and logging {#test}

1. Get the public IP address of the load balancer:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), open **{{ alb-name }}**.
      1. Find the load balancer `alb-logging-balancer` in the list and copy its IP address.

   {% endlist %}

1. Open the `http://<Load balancer IP address>` in the browser. Refresh the page several times.
1. Make sure that the logs contain information about your requests to the load balancer:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), open **{{ mpg-name }}**.
      1. Select the cluster `alb-logging-cluster`.
      1. Go to the **SQL** tab.
      1. Select the user that you [created together with the cluster](#set-up-db-create-cluster) and enter their password.
      1. Select the database that you created together with the cluster, and click **Connect**.
      1. Click on the `load_balancer_requests` table. You should now see the first rows of this table with the data about your requests to the load balancer.

   {% endlist %}

## How to delete created resources {#clear-out}

To shut down the load balancer and stop paying for the created resources:

1. Delete the non-billable resources that block the deletion of billable resources:

   1. [Delete](../../application-load-balancer/operations/application-load-balancer-delete.md) the `alb-logging-balancer` L7 load balancer.
   1. [Delete](../../application-load-balancer/operations/http-router-delete.md) the `alb-logging-router` HTTP router.
   1. [Delete](../../application-load-balancer/operations/backend-group-delete.md) the `alb-logging-bg` backend group.

1. [Delete](../../compute/operations/instance-groups/delete.md) the `alb-logging-ig` instance group.
1. [Delete](../../functions/operations/trigger/trigger-delete.md) the trigger `alb-logging-trigger`.
1. [Delete](../../functions/operations/function/function-delete.md) the function `alb-logging-function`.
1. [Delete](../../managed-postgresql/operations/cluster-delete.md) the cluster `alb-logging-cluster`.
