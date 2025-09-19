# Creating a demo {{ cloud-apps-name }} product

In this tutorial, you will create a basic {{ cloud-apps-name }} product with a {{ mpg-full-name }} [cluster](../../managed-postgresql/concepts/index.md) and {{ compute-full-name }} [VM](../../compute/concepts/vm.md) connected to it, install the created _app_ (product instance), and test its behavior.

## Getting started {#before-you-begin}

1. [Upload](../../compute/operations/image-create/upload.md) your disk image to {{ compute-full-name }}. To complete this tutorial, you can use [this Ubuntu image](https://ubuntu.com/download/desktop). When using this image to install an app in {{ cloud-apps-name }}, a VM will be created automatically.

   {% note tip %}

   For your demo app, you can [create a VM from a {{ marketplace-name }} public image](../../compute/operations/images-with-pre-installed-software/create.md), such as [Ubuntu 22.04 LTS](../../../marketplace/products/yc/ubuntu-22-04-lts), and [build an image from that VM's disk](../../compute/operations/image-create/create-from-disk.md). See also [{#T}](../../tutorials/infrastructure-management/packer-quickstart.md).

   {% endnote %}

1. Fill out the questionnaire on the [{{ marketplace-full-name }} page](/marketplace).
1. [Register](../operations/registration.md) an account.
1. [Create](../operations/create-product.md) a **{{ cloud-apps-name }}** product.

## Create a configuration {#create-configuration}

1. Select the product for which you want to create a configuration.
1. Navigate the **Configurations** tab.
1. Click ![image](../../_assets/console-icons/plus.svg) **Create configuration**.
1. On the **From scratch** tab:
    1. Specify the following:
        * Folder to save your configuration to. You need the `cloudapps.editor` role for that folder.
        * Configuration name, e.g., `demo`.
    1. Click **Create**. Your `demo` configuration will appear on the **Configurations** tab with the `Draft` status.

## Set up your configuration {#configure}

### Add an artifact {#artifact}

1. Select the `demo` configuration.
1. In the **Artifact selection** tab, click **Add artifact**.
1. Select **Disk image** as the **Artifact type**.
1. Specify a **Name**, e.g., `ubuntu`.
1. Select the disk image you created when [{#T}](#before-you-begin).
1. Click **Add**.

### Create a form {#form}

1. Navigate to the **Launch parameters** tab.
1. Add the following fields one by one by clicking ![image](../../_assets/console-icons/plus.svg) **Add field**:

    * **DB username**:<br>

        Parameter | Value | Description
        --- | --- | ---
        Variable type | `String` |
        Field type | `Base` | Plain string
        Variable name | `pg_username` | You can use the variable name when creating resources to access the value entered by the user.
        Required field | Selected | This field is required.
        Pattern | `^[a-z][a-z0-9]*$` | The regular expression that the DB username must match.
        Pattern error | `Wrong name` | The error message the user sees if the database username does not match the specified pattern.
        Field header | `DB username` | The field name the user sees in the interface.
        Field header | `DB username` | The field name the user sees in the interface.

    * **Secret with DB user password**:<br>

        Parameter | Value | Description
        --- | --- | ---
        Variable type | `String` |
        Field type | `{{ lockbox-short-name }} Secret` | {{ lockbox-full-name }} [secret](../../lockbox/concepts/secret.md) with the DB user password
        Variable name | `pg_password_secret` | You can use the variable name when creating resources to access the value entered by the user.
        Required field | Selected | This field is required.
        Field header | `Secret with DB user password`: | The field name the user sees in the interface.
        Field header | `Secret with DB user password` | The field name the user sees in the interface.

    * **Cloud network**:<br>

        Parameter | Value | Description
        --- | --- | ---
        Variable type | `String` |
        Field type | `{{ vpc-short-name }} network` | {{ vpc-full-name }} [cloud network](../../vpc/concepts/network.md#network) for your app in {{ cloud-apps-name }}
        Variable name | `vpc_network` | You can use the variable name when creating resources to access the value entered by the user.
        Required field | Selected | This field is required.
        Field header | `Cloud network` | The field name the user sees in the interface.
        Field header | `Cloud network` | The field name the user sees in the interface.

    * **Subnet 1**:<br>

        Parameter | Value | Description
        --- | --- | ---
        Variable type | `String` |
        Field type | `{{ vpc-short-name }} subnet` | {{ vpc-full-name }} [subnet](../../vpc/concepts/network.md#subnet)
        Variable name | `vpc_subnet_0` | You can use the variable name when creating resources to access the value entered by the user.
        Required field | Selected | This field is required.
        Field header | `Subnet 1` | The field name the user sees in the interface.
        Field header | `Subnet 1` | The field name the user sees in the interface.

    * **Subnet 2**:<br>

        Parameter | Value | Description
        --- | --- | ---
        Variable type | `String` |
        Field type | `{{ vpc-short-name }} subnet` | {{ vpc-full-name }} [subnet](../../vpc/concepts/network.md#subnet)
        Variable name | `vpc_subnet_1` | You can use the variable name when creating resources to access the value entered by the user.
        Required field | Selected | This field is required.
        Field header | `Subnet 2` | The field name the user sees in the interface.
        Field header | `Subnet 2` | The field name the user sees in the interface.

### Add resources {#resources}

1. Navigate to the **Resources** tab.
1. Add the following resources one by one by clicking ![image](../../_assets/console-icons/plus.svg) **Add resource**:

    {% note info %}

    _User resources_ are resources the user creates on their own prior to installing the app.
    
    _New resources_ are those automatically created in the user folder while installing the app.

    {% endnote %}

    * `User resource` → `{{ vpc-short-name }} cloud network`:<br>

        Parameter | Value | Description
        --- | --- | ---
        Name | `vpc-network` | Click ![image](../../_assets/console-icons/pencil.svg) next to the auto-generated cloud network name to change it. The resource name must be unique within the configuration. The user will see it when installing the app.
        Network id | `Input field` → `vpc_network` | The cloud network ID will be retrieved from the **Cloud network** field as specified by the user when filling out the form.

    * `User resource` → `{{ vpc-short-name }} subnet`:

        **Subnet 1**

        Parameter | Value | Description
        --- | --- | ---
        Name | `vpc-subnet-0` | Click ![image](../../_assets/console-icons/pencil.svg) next to the auto-generated subnet name to change it. The resource name must be unique within the configuration. The user will see it when installing the app.
        Subnet id | `Input field` → `vpc_subnet_0` | The subnet ID will be retrieved from the **Subnet 1** field as specified by the user when filling out the form.

        **Subnet 2**

        Parameter | Value | Description
        --- | --- | ---
        Name | `vpc-subnet-1` | Click ![image](../../_assets/console-icons/pencil.svg) next to the auto-generated subnet name to change it. The resource name must be unique within the configuration. The user will see it when installing the app.
        Subnet id | `Input field` → `vpc_subnet_1` | The cloud network ID will be retrieved from the **Subnet 2** field as specified by the user when filling out the form.

    * `User resource` → `{{ lockbox-short-name }} secret`:<br>

        Parameter | Value | Description
        --- | --- | ---
        Name | `lockbox-secret-with-db-password` | Click ![image](../../_assets/console-icons/pencil.svg) next to the auto-generated {{ lockbox-name }} secret name to change it. The resource name must be unique within the configuration. The user will see it when installing the app.
        Secret id | `Input field` → `pg_password_secret` | The {{ lockbox-short-name }} secret ID will be retrieved from the **Secret with DB user password** field as specified by the user when filling out the form.

    * `New resource` → `Service account`:<br>

        Parameter | Value | Description
        --- | --- | ---
        Name | `service-account` | Click ![image](../../_assets/console-icons/pencil.svg) next to the auto-generated service account name to change it. The resource name must be unique within the configuration. The user will see it when installing the app.
        Folder id | `Application attribute` → `Folder ID` | The service account to use for deploying the application will be automatically created in the same folder the user selected for app installation.
        Name | `Value` → `my-best-app` | The name of the automatically created service account will be `my-best-app`.

    * `New resource` → `Folder user`:<br>

        Parameter | Value | Description
        --- | --- | ---
        Name | `lockbox-payload-viewer` | Click ![image](../../_assets/console-icons/pencil.svg) next to the auto-generated folder user name to change it. The resource name must be unique within the configuration. The user will see it when installing the app.
        Folder id | `Application attribute` → `Folder ID` | The specified roles will be assigned to the service account for the folder the user selected for app installation.
        Member | `Value` → `Service account` → `Reference` → `service-account` → `id` | The specified roles will be assigned to the `my-best-app` service account.
        Role |  `Value` → `{{ roles-lockbox-payloadviewer }}` | The service account will get the [{{ roles-lockbox-payloadviewer }}](../../lockbox/security/index.md#lockbox-payloadViewer) role required for accessing the {{ lockbox-full-name }} secret that stores the DB user password.

    * `New resource` → `{{ PG }} cluster`:<br>

        Parameter | Value | Description
        --- | --- | ---
        Name | `postgres-cluster` | Click ![image](../../_assets/console-icons/pencil.svg) next to the {{ mpg-full-name }} [cluster’s](../../managed-postgresql/concepts/index.md) auto-generated name to change it. The resource name must be unique within the configuration. The user will see it when installing the app.
        Environment | `Value` → `PRODUCTION` | The environment where you want to create the cluster. The production environment is used for stable app versions.
        Folder id | `Application attribute` → `Folder ID` | The cluster will be automatically created in the same folder the user selected for app installation.
        Name |  `Value` → `my-best-app-pg-cluster` | The new cluster’s name will be `my-best-app-pg-cluster`.
        Network id | `Resource` → `vpc-network` | The cluster will be automatically created in the cloud network named `vpc-network`.
        Config | `Value` → `Key: Version` → `Value` → `16` | DBMS version.
        Config | `Value` → `Key: Resources` → `Value` → `Key: Disk size` → `Value` → `10` | Disk size.
        Config | `Value` → `Key: Resources` → `Value` → `Key: Disk type id` → `Value` → `network-ssd` | Disk [type](../../managed-postgresql/concepts/storage.md).
        Config | `Value` → `Key: Resources` → `Value` → `Key: Resource preset id` → `Value` → `c3-c2-m4` | Host [class](../../managed-postgresql/concepts/instance-types.md)
        Host | `Value` → `Element 1` → `Value` → `Key: Subnet id` → `Resource` → `vpc-subnet-0` | The cluster will include two hosts. The first host will reside in `vpc-subnet-0`.
        Host | `Value` → `Element 1` → `Value` → `Key: Zone` → `Reference` → `vpc-subnet-0` → `zone` | The first host will reside in the same [availability zone](../../overview/concepts/geo-scope.md) as `vpc-subnet-0`.
        Host | `Value` → `Element 2` → `Value` → `Key: Subnet id` → `Resource` → `vpc-subnet-1` | The cluster will include two hosts. The second host will reside in `vpc-subnet-1`.
        Host | `Value` → `Element 2` → `Value` → `Key: Zone` → `Reference` → `vpc-subnet-1` → `zone` | The second host will reside in the same [availability zone](../../overview/concepts/geo-scope.md) as `vpc-subnet-1`.

    * `New resource` → `{{ PG }} user`:<br>

        Parameter | Value | Description
        --- | --- | ---
        Name | `postgresql-user` | Click ![image](../../_assets/console-icons/pencil.svg) next to the auto-generated {{ PG }} user name to change it. The resource name must be unique within the configuration. The user will see it when installing the app.
        Cluster id | `Resource` → `postgres-cluster` | The cluster to which `pg_username` will have access.
        Name | `Input field` → `pg_username` | The username will be retrieved from the **DB username** field as specified by the user when filling out the form.
        Password |  `Reference` → `lockbox-secret-with-db-password` → `entries[0].text_value` | To access the cluster, `pg_username` will use the password retrieved from `lockbox-secret-with-db-password`.

    * `New resource` → `{{ PG }} database`:<br>

        Parameter | Value | Description
        --- | --- | ---
        Name | `postgresql-db` | Click ![image](../../_assets/console-icons/pencil.svg) next to the auto-generated {{ PG }} DB name to change it. The resource name must be unique within the configuration. The user will see it when installing the app.
        Cluster id | `Resource` → `postgres-cluster` | The cluster where the `pg_username` database will be automatically created.
        Name | `Input field` → `pg_username` | The database name will be retrieved from the **DB username** field as specified by the user when filling out the form. The DB user name and the DB name match in the demo example.
        Owner |  `Reference` → `postgresql-user` → `name` | The DB owner name will be the {{ PG }} user name, `postgresql-user`.

    * `New resource` → `Virtual machine`:<br>

        Parameter | Value | Description
        --- | --- | ---
        Name | `instance` | Click ![image](../../_assets/console-icons/pencil.svg) next to the auto-generated VM name to change it. The resource name must be unique within the configuration. The user will see it when installing the app.
        Folder id | `Application attribute` → `Folder ID` | The {{ compute-name }} [VM](../../compute/concepts/vm.md) will be automatically created in the same folder the user selected for app installation.
        Boot disk | `Value` → `Key: Initialize params` → `Value` → `Key: Image id` → `Value` → `ubuntu` | Disk image to create the VM from. You added it at [this step](#artifact).
        Boot disk | `Value` → `Key: Initialize params` → `Value` → `Key: Size` → `Value` → `32` | Disk size. 
        Boot disk | `Value` → `Key: Initialize params` → `Value` → `Key: Type` → `Value` → `network-ssd` | Disk [type](../../compute/concepts/disk.md#disks-types).
        Network interface | `Value` → `Element 1` → `Value` → `Key: Subnet id` → `Resource` → `vpc-subnet-0` | The VM will reside in `vpc-subnet-0`.
        Resources | `Value` → `Key: Cores` → `Value` → `2` | Number of vCPUs
        Resources | `Value` → `Key: Memory` → `Value` → `8` | Amount of RAM
        Metadata | `Value` → `Element 1` → `Key: pg-host-0` → `Reference` → `postgres-cluster` → `host[0].fqdn` | Settings for connecting from the VM to the database. First cluster host.
        Metadata | `Value` → `Element 2` → `Key: pg-host-1` → `Reference` → `postgres-cluster` → `host[1].fqdn` | Settings for connecting from the VM to the database. Second cluster host.
        Metadata | `Value` → `Element 3` → `Key: pg-username` → `Reference` → `postgres-user` → `name` | Settings for connecting from the VM to the database. DB username.
        Metadata | `Value` → `Element 4` → `Key: pg-password-lockbox-secret-id` → `Input field` → `postgres_password_secret` | Settings for connecting from the VM to the database. DB user password.
        Platform id | `Value` → `standard-v3` | [Platform](../../compute/concepts/vm-platforms.md) on which the VM will run.
        Service account id | `Resource` → `service-account` | The service account with read permissions for the {{ lockbox-short-name }} secret that stores the DB user password.
        Zone | `Reference` → `vpc-subnet-0` → `zone` | The VM will reside in the same [availability zone](../../overview/concepts/geo-scope.md) as `vpc-subnet-0`.
        Depends on | `lockbox-payload-viewer` | The VM will be created after the `lockbox-payload-viewer` resource.

1. Click **Save** to save the configuration.

## Install the app {#install}

1. In the top-right corner, click **Run**.
1. Fill out the form.
1. Click **Install**.
1. Wait for the service to verify the resources you are creating and click **Confirm**.
1. The application list will now contain your `demo-app` with the `Deploying` status. Wait until the status switches to `Deployed`. This may take several minutes.
1. Check all newly created resources. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM and [make sure](../../managed-postgresql/operations/connect.md) it can access the {{ mpg-full-name }} cluster.
