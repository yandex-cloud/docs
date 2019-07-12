# Getting started with Load Balancer

If you already have a folder in Yandex.Cloud, open the page of that folder in the management console. If not, create a new folder before creating load balancers and target groups:

{% include [create-folder](../_includes/create-folder.md) %}

Create a [target group](concepts/target-resources.md):

1. Open the **Load Balancer** section in the folder where you want to create a target group.

1. Open the **Target group** tab.

1. Click **Create target group**.

1. Enter the name of the target group.

    {% include [name-format](../_includes/name-format.md) %}

1. Select the VMs to add to the target group.

1. Click **Create target group**.

Create a [network load balancer](concepts/index.md):

1. Open the **Load Balancer** section in the folder where you want to create a load balancer.

1. Click **Create load balancer**.

1. Enter a name.

    {% include [name-format](../_includes/name-format.md) %}

1. Turn on **Target groups**

1. Select the target group that you created.

1. In the **Health check** section, enter the health check name.

    {% include [name-format](../_includes/name-format.md) %}

1. Select the check type: **TCP** or **HTTP**.

1. Specify a port number from the range 1-32767.

1. If you chose a check via HTTP, specify the URL to perform checks for.

1. Specify the response timeout in seconds.

1. Specify the interval, in seconds, for sending health check requests.

1. Set the performance threshold, i.e., the number of successful checks required in order to consider the VM ready to receive traffic.

1. Specify the failure threshold, i.e., the number of failed checks after which no traffic will be routed to the VM.

1. Click **Add listener**.

1. In the window that opens, specify the port number (in the range from 1 to 32767) that the load balancer will receive incoming traffic on. The specified port number must match the port numbers that the VMs receive traffic on.

1. Click **Add**.

1. Click **Create load balancer**.

