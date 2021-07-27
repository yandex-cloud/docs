---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# How to connect to a database

{{ ydb-short-name }} databases are accessed via gRPC over TLS.

## Prerequisites {#prerequisites}

Before connecting to a database:

1. [Create a VM](../../compute/operations/vm-create/create-linux-vm.md) in {{ yandex-cloud }}.

1. Save the public IP address of the VM. To do this, go to the VM properties or [use the command-line interface](../../compute/operations/vm-info/get-info.md#outside-instance).

1. For [ database authentication, create a service account](../../iam/operations/sa/create.md) and [assign](../../iam/operations/sa/assign-role-for-sa.md) it the `viewer` and `editor` roles.

1. Go to the **Service accounts** section of your folder and select a service account from the list. Save the service account ID.

1. [Create authorized access keys](../../iam/operations/sa/create-access-key.md) to the service account and save them.

1. Go to the **Databases** page and click the name of the DB to open the **Overview**. Copy the database endpoint.

1. To connect to the DB server, you need an SSL certificate. You can prepare all the necessary authentication data as follows:

   ```
   $ mkdir ~/.ydb
   $ wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" -O ~/.ydb/CA.pem
   ```

{% include notitle [run-app](../_includes/run-app.md) %}

