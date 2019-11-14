# Getting started with {{ mch-short-name }}

To use the service, create a cluster and connect to a DBMS:

1. All you need to create a database cluster is a folder in Yandex.Cloud that you are allowed to access. If you already have a folder in Yandex.Cloud, open the page of that folder in the management console. If there is no folder yet, create one:

    {% include [create-folder](../_includes/create-folder.md) %}

2. You can connect to DB clusters from both inside and outside of the Cloud:

    1. To connect to a DB cluster from inside the Cloud, create a VM in the same network as the DB cluster (based on [Linux](../compute/quickstart/quick-create-linux.md) or [Windows](../compute/quickstart/quick-create-windows.md))

    2. To connect to a cluster from the internet, request public access to the hosts when creating the cluster and adding new hosts.

1. In the management console, select the folder where you want to create a DB cluster.

