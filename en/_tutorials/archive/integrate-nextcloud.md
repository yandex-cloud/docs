# {{ objstorage-full-name }} integration with Nextcloud

[Nextcloud](https://nextcloud.com/) is an open-source software solution that allows you to easily, flexibly, and securely manage files, share them, and collaborate on documents. You can use Nextcloud create your own cloud storages as well as integrate off-the-shelf solutions, such as [{{ objstorage-full-name }}](../../storage/index.yaml).

In this tutorial, you will connect an {{ objstorage-name }} [bucket](../../storage/concepts/bucket.md) to a Nextcloud solution deployed on a {{ compute-full-name }} [VM instance](../../compute/concepts/vm.md) with a database in a {{ mmy-full-name }} [cluster](../../managed-mysql/concepts/index.md). To ensure fault tolerance and redundancy of your Nextcloud infrastructure, you will scale Nextcloud across an [instance group](../../compute/concepts/instance-groups/index.md) and implement [L7 load balancing](../../application-load-balancer/concepts/application-load-balancer.md) with {{ alb-full-name }}. In the fault-tolerant configuration, Nextcloud will be available via a domain name, for which a [TLS certificate](../../certificate-manager/concepts/managed-certificate.md) will be issued in {{ certificate-manager-full-name }}.

{% note info %}

To implement a fault-tolerant Nextcloud configuration, you will need a domain for the L7 load balancer.

{% endnote %}


To deploy Nextcloud in {{ yandex-cloud }} and connect an {{ objstorage-name }} bucket:

1. [Get your cloud ready](#before-you-begin).
1. [Deploy Nextcloud in a basic configuration](#the-basic-variant):

    1. [Create and set up a cloud network](#setup-network).
    1. [Create a service account and static access key](#setup-sa).
    1. [Create an {{ objstorage-name }} bucket](#create-bucket).
    1. [Create a VM](#create-vm).
    1. [Create a {{ mmy-name }} cluster](#create-mysql-cluster).
    1. [Install and configure Nextcloud on the VM](#setup-nextcloud).
    1. [Test the solution in the basic configuration](#test-simple).
1. [Deploy Nextcloud in a fault-tolerant configuration](#the-redundant-variant):

    1. [Scale the {{ mmy-name }} cluster](#expand-mysql-cluster).
    1. [Complete the Nextcloud setup and create a VM disk snapshot](#create-snapshot).
    1. [Add a TLS certificate to {{ certificate-manager-full-name }}](#issue-certificate).
    1. [Deploy an instance group](#create-instance-group).
    1. [Create an L7 load balancer](#setup-balancer).
    1. [Create an A resource record in your domain’s public DNS zone](#create-a-record).
    1. [Test the solution in the fault-tolerant configuration](#test-redundant).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of the proposed solution includes: 
* Fee for [disks](../../compute/concepts/disk.md), [disk snapshots](../../compute/concepts/snapshot.md), and continuously running [VMs](../../compute/concepts/vm.md) (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using [public IP addresses](../../vpc/concepts/address.md#public-addresses) and [NAT gateways](../../vpc/concepts/gateways.md#nat-gateway) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for [data storage](../../storage/concepts/bucket.md) in {{ objstorage-name }} and data [operations](../../storage/operations/index.md) (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md)).
* Fee for using a {{ MY }} managed DB (see [{{ mmy-name }} pricing](../../managed-mysql/pricing.md)).
* If using {{ dns-full-name }}, the fee for [DNS zones](../../dns/concepts/dns-zone.md#public-zones) and public DNS queries (see [{{ dns-name }} pricing](../../dns/pricing.md)).
* If using a load balancer, the fee for the amount of [L7 load balancer](../../application-load-balancer/concepts/application-load-balancer.md) resource units (see [{{ alb-full-name }} pricing](../../application-load-balancer/pricing.md)).
* If using a [log group](../../logging/concepts/log-group.md) for load balancer logging, the fee for writing and storing data (see [{{ cloud-logging-full-name }} pricing](../../logging/pricing.md)).

## Deploy Nextcloud in a basic configuration {#the-basic-variant}

You will deploy the basic Nextcloud configuration on a single VM with the Nextcloud service database created in a single-host {{ mmy-name }} cluster or directly on the Nexcloud VM.

### Set up a cloud network {#setup-network}

1. Create a [cloud network](../../vpc/concepts/network.md#network) and [subnets](../../vpc/concepts/network.md#subnet) for your new cloud infrastructure:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you are going to create your infrastructure.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
      1. In the top-right corner, click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
      1. In the **{{ ui-key.yacloud.vpc.networks.create.field_name }}** field, enter a name for the network: `nextcloud-network`.
      1. Make sure the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** option is enabled and click **{{ ui-key.yacloud.vpc.networks.button_create }}**.

    {% endlist %}

1. Create a [security group](../../vpc/concepts/security-groups.md) that allows the traffic required for your Nextcloud infrastructure:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
      1. In the left-hand panel, select ![shield](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}**. 
      1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** field, enter `nextcloud-sg` for name.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** field, select `nextcloud-network` you created earlier.
      1. Under **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}**, [create](../../vpc/operations/security-group-add-rule.md) the following traffic management rules:

          | Traffic<br/>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }} |
          | --- | --- | --- | --- | --- | --- |
          | Ingress | `http`           | `80` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
          | Inbound | `https`           | `443` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
          | Inbound | `ssh`            | `22` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
          | Ingress | `self`            | `All` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` |
          | Inbound | `healthchecks`            | `All` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}` | `–` |
          | Egress | `any`           | `All` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
      1. Click **{{ ui-key.yacloud.common.create }}**.

    {% endlist %}

1. Create a [NAT gateway](../../vpc/concepts/gateways.md#nat-gateway):

    Your VMs need internet access to connect to {{ objstorage-name }} buckets. To avoid assigning public IP addresses to VM instances in the group, use a NAT gateway to enable internet access.

    {% note info %}

    You can also configure VM access to the bucket using [service connections](../../vpc/concepts/private-endpoint.md).

    {% include [preview-pp](../../_includes/preview-pp.md) %}

    {% endnote %}

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
      1. In the left-hand panel, select ![arrows-opposite-to-dots](../../_assets/console-icons/arrows-opposite-to-dots.svg) **{{ ui-key.yacloud.vpc.switch_gateways }}** and click **{{ ui-key.yacloud.vpc.gateways.button_create-gateway }}**.
      1. In the **{{ ui-key.yacloud.vpc.gateways.field_name }}** field, specify `nextcloud-gateway` as the gateway name. 
      1. In the **{{ ui-key.yacloud.vpc.gateways.field_type }}** field, select `{{ ui-key.yacloud.vpc.gateways.value_gateway-type-egress-nat }}` and click **{{ ui-key.yacloud.common.save }}**.

    {% endlist %}

1. Create a [route table](../../vpc/concepts/routing.md):

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
      1. In the left-hand panel, select ![route](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.vpc.network.switch_route-table }}** and click **{{ ui-key.yacloud.vpc.network.overview.button_create_route-table }}**.
      1. In the **{{ ui-key.yacloud.vpc.route-table-form.field_name }}** field, specify `nextcloud-rt-table`.
      1. In the **{{ ui-key.yacloud.vpc.route-table-form.field_network-id }}** field, select `nextcloud-network`.
      1. Click **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**, and in the window that opens:

          1. In the **{{ ui-key.yacloud.vpc.add-static-route.field_next-hop-address }}** field, select `{{ ui-key.yacloud.vpc.add-static-route.value_gateway }}`.
          1. In the **{{ ui-key.yacloud.vpc.add-static-route.value_gateway }}** field, select the NAT gateway you created. The destination prefix will apply automatically.
          1. Click **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.
      1. Click **{{ ui-key.yacloud.vpc.route-table.create.button_create }}**. 

    {% endlist %}

1. Link the route table to all subnets in `nextcloud-network` to route their outgoing traffic via the NAT gateway:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
      1. In the left-hand panel, select ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
      1. In the subnet row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}** in the context menu.
      1. In the window that opens, select the route table you created in the previous step and click **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.

    {% endlist %}

    Make sure the **{{ ui-key.yacloud.vpc.network.overview.column_subnetwork_route-table-id }}** field for each listed subnet displays the name of the route table linked to it.

### Create a service account and static access key {#setup-sa}

To enable access from Nextcloud to the {{ objstorage-name }} bucket, create a [service account](../../iam/concepts/users/service-accounts.md) and [static access key](../../iam/concepts/authorization/access-key.md).

1. Create a service account:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
      1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. Enter a name for the service account: `nextcloud-sa`.
      1. Click ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the `editor` [role](../../iam/roles-reference.md#editor).
      1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

    {% endlist %}

1. Create a static access key:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
      1. In the left-hand panel, select ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}** and select the `nextcloud-sa` service account you created earlier.
      1. In the top panel, click ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
      1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
      1. Save the ID and secret key.

          {% note alert %}

          After you close this dialog, the key value will not be shown again.

          {% endnote %}

    {% endlist %}

### Create an {{ objstorage-name }} bucket {#create-bucket}

Create the {{ objstorage-name }} bucket you will connect to Nextcloud:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. At the top right, click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** field, enter a name for the bucket, e.g., `my-nextcloud-bucket`. The bucket name must be [unique](../../storage/concepts/bucket.md#naming) within {{ objstorage-full-name }}.
  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_size-limit }}** field, specify the bucket size you need or enable **{{ ui-key.yacloud.storage.bucket.settings.label_size-limit-disabled }}**.
  1. Leave all the other parameters unchanged and click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

{% endlist %}

### Create a VM {#create-vm}

Create the VM to deploy Nextcloud on:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder to create the infrastructure in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}** and click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, in the **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** field, type `Ubuntu 24.04 LTS` and select a public [Ubuntu 24.04 LTS](/marketplace/products/yc/ubuntu-24-04-lts) image.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the `{{ region-id }}-a` [availability zone](../../overview/concepts/geo-scope.md).
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, select the `2 {{ ui-key.yacloud.component.compute.resources.field_cores }} 4 {{ ui-key.yacloud.common.units.label_gigabyte }} {{ ui-key.yacloud.component.compute.resources.field_memory }}` configuration.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select `nextcloud-network` and the subnet in the VM availability zone, `nextcloud-network-{{ region-id }}-a`.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, leave the `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` value to assign the VM a random public IP address from the {{ yandex-cloud }} pool.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** field, select the `nextcloud-sg` security group.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

      * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter a username, e.g., `yc-user`. Do not use `root` or other reserved usernames. To perform operations requiring root privileges, use the `sudo` command.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `nextcloud-vm`.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

{% endlist %}

### Create a {{ mmy-name }} cluster {#create-mysql-cluster}

Nextcloud uses a {{ MY }} database to store service information. In this tutorial, you will deploy the Nextcloud database in a {{ mmy-full-name }} [cluster](../../managed-mysql/concepts/index.md).

{% note info %}

You can create the {{ MY }} database on the same host as Nextcloud, but this is less reliable and does not provide fault tolerance. If you are not going to deploy a fault-tolerant configuration, you may skip the cluster creation step and create the database later on the Nextcloud host.

{% endnote %}

To create a {{ mmy-name }} cluster:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}** and click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. In the **{{ ui-key.yacloud.mdb.forms.base_field_name }}** field, enter `nextcloud-db-cluster`.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_database }}**:

      * In the **{{ ui-key.yacloud.mdb.forms.database_field_name }}** field, enter `nextcloud`.
      * In the **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** field, enter `user`.
      * In the **{{ ui-key.yacloud.mdb.forms.config_field_password }}** field, select `{{ ui-key.yacloud.component.password-input.label_button-enter-manually }}` and enter a password you will use to access the database.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**, select `nextcloud-network` and the `nextcloud-sg` security group.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**, make sure the cluster is going to have one [host](../../managed-mysql/concepts/instance-types.md) within the same [availability zone](../../overview/concepts/geo-scope.md) you created the VM in.

      {% note info %}

      To test Nextcloud in its basic configuration, a single-host cluster would be enough. Later, when deploying a fault-tolerant configuration, you will scale the cluster you created across the remaining availability zones.

      {% endnote %}

  1. Under **{{ ui-key.yacloud.mdb.forms.section_settings }}**, click **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}**, and in the window that opens:

      1. In the **character_set_server** field, select `utf8mb4`.
      1. In the **collation_server** field, select `utf8mb4_general_ci`.
      1. Leave all the other parameters unchanged and click **{{ ui-key.yacloud.component.mdb.settings.popup_settings-submit }}**.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

{% endlist %}

It may take a few minutes to create a cluster.

### Install and configure Nextcloud on the VM {#setup-nextcloud}

1. Install Nextcloud on `nextcloud-vm`:

    1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to `nextcloud-vm` over SSH. You will perform all further actions under this step in the VM terminal.
    1. Upgrade the versions of the packages installed on the VM:

        ```bash
        sudo apt update && sudo apt upgrade
        ```
    1. Install the required software packages and dependencies:

        ```bash
        sudo apt install \
          apache2 mariadb-server libapache2-mod-php php-gd php-mysql php-curl php-mbstring \
          php-intl php-gmp php-bcmath php-xml php-imagick php-zip php-fpm unzip
        ```
    1. Optionally, if you want to create the database on the same host as Nextcloud:

        {% cut "If you did not create a {{ MY }} cluster and are not going to deploy a fault-tolerant solution:" %}

        1. Run MySQL:

            ```bash
            sudo mysql
            ```
        1. Run these commands to create the database and user and grant the user the permissions to work with the database:

            ```bash
            CREATE USER 'user'@'localhost' IDENTIFIED BY '<password>';
            CREATE DATABASE IF NOT EXISTS nextcloud CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
            GRANT ALL PRIVILEGES ON nextcloud.* TO 'user'@'localhost';
            FLUSH PRIVILEGES;
            quit;
            ```

            Where `<password>` is the password you will use to access the database.

        {% endcut %}

    1. Download the archive with the latest Nextcloud version:

        ```bash
        wget https://download.nextcloud.com/server/releases/latest.zip
        ```
    1. Unpack the archive to the `/var/www` directory:

        ```bash
        sudo unzip latest.zip -d /var/www
        ```
    1. Edit access permissions for the Nextcloud directory:

        ```bash
        sudo chown -R www-data:www-data /var/www/nextcloud
        sudo chmod -R 755 /var/www/nextcloud/
        ```
    1. Configure the default virtual host:

        1. Open the default virtual host's configuration file:

            ```bash
            sudo nano /etc/apache2/sites-available/000-default.conf
            ```
        1. Replace the contents of `000-default.conf` with the following:

            ```text
            <VirtualHost *:80>
            DocumentRoot /var/www/nextcloud/

            <Directory /var/www/nextcloud/>
            Require all granted
            AllowOverride All
            Options FollowSymLinks MultiViews

            <IfModule mod_dav.c>
            Dav off
            </IfModule>
            </Directory>
            </VirtualHost>
            ```
    1. Enable the required [Apache web server](https://en.wikipedia.org/wiki/Apache_HTTP_Server) modules:

        ```bash
        sudo a2enmod rewrite
        sudo a2enmod headers
        a2enmod env
        a2enmod dir
        a2enmod mime
        ```
    1. Increase the amount of RAM available to the PHP interpreter for processing requests to Nextcloud to `512 MB`.

        1. Open the `.htaccess` file in the Nextcloud installation directory:

            ```bash
            sudo nano /var/www/nextcloud/.htaccess
            ```
        1. Add the following line to the end of the file:

            ```bash
            php_value memory_limit 512M
            ```
        
            Make sure to save your changes.
    1. Restart the web server:

        ```bash
        sudo systemctl restart apache2
        ```
1. Configure Nextcloud in the GUI:

    1. Open your local computer browser and enter the following in the address bar:

        ```text
        http://<VM_public_IP_address>
        ```

        You can look up the VM's public IP address in the [management console]({{ link-console-main }}) by checking the **{{ ui-key.yacloud.compute.instance.overview.section_network }}** section's **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}** field on the VM information page.
    1. In the **Create an administrator account** form that opens:

        1. In the **New administrator account name** and **New administrator password** fields, set the Nextcloud administrator credentials you will use to log in to the system.
        1. In the **Database account** field, enter `user`, i.e., the database user name you specified when creating the {{ MY }} cluster or local database.
        1. In the **Database password** field, enter the database user password you specified when creating the {{ MY }} cluster or local database.
        1. In the **Database name** field, enter `nextcloud`, i.e., the database name you specified when creating the {{ MY }} cluster or local database.
        1. In the **Database host** field, specify the FQDN of the cluster’s [current master host](../../managed-mysql/operations/connect.md#fqdn-master) and port in this format:

            ```text
            c-<cluster_ID>.rw.{{ dns-zone }}:3306
            ```

            You can look up the cluster ID in the [management console]({{ link-console-main }}) by checking the **{{ ui-key.yacloud.common.id }}** field on the cluster information page.

            {% note info %}

            If it is not your intention to deploy a fault-tolerant solution and you did not create a {{ MY }} cluster, but created a database on `nextcloud-vm` instead, leave `localhost` in the **Database host** field.

            {% endnote %}

        1. Click **Install**.

            This will start the deployment of the Nextcloud database in the {{ MY }} cluster. Wait for this process to complete.
    1. After the installation is over, click **Skip** in the window with recommended applications that opens. You can get back to installing the applications you need at a later time.
    1. Close the window with information on updates in the current Nextcloud version.
    1. Open the application management menu. Do it by clicking the user icon in the top-right corner and selecting ![plus](../../_assets/console-icons/plus.svg) **Applications** in the context menu that pops open.
    1. In the window that opens, select ![person](../../_assets/console-icons/person.svg) **Your applications** in the left-hand panel.
    1. In the list that opens, find the `External storage support` application and click **Enable** in the row with it.

        If needed, enter your Nextcloud administrator password in the pop-up window to confirm the operation.
    1. Open the main settings menu. Do it by clicking the user icon in the top-right corner and selecting ![admin-icon](../../_assets/tutorials/integrate-nextcloud/admin-icon.svg) **Server parameters** in the context menu that pops open.
    1. In the window that opens, select ![app-dark-icon](../../_assets/tutorials/integrate-nextcloud/app-dark-icon.svg) **External storage** in the left-hand panel under **Server parameters** and specify {{ objstorage-name }} integration settings under **External storage** in the window that opens:

        1. In the **External storage** section, select `Amazon S3`.
        1. In the **Authorization method** section, select `Access key`.
        1. Under **Configuration**:

            * In the **Bucket** field, enter a name for the bucket you created earlier, e.g., `my-nextcloud-bucket`.
            * In the **Hostname** field, specify `{{ s3-storage-host }}`.
            * In the **Port** field, specify `443`.
            * In the **Access key** field, paste the ID of the static access key you created earlier.
            * In the **Secret key** field, paste the secret key of the static access key you created earlier.
        1. Under **Available to**, enable **All**.
        1. On the right side of the section you are editing, click the ![check](../../_assets/console-icons/check.svg) icon to save your changes.

            Enter your Nextcloud administrator password in the pop-up window to confirm the operation.

### Test the solution in the basic configuration {#test-simple}

To test {{ objstorage-full-name }} integration with Nextcloud on a single host:

1. Open your local computer browser and enter the public IPv4 address of the Nextcloud VM in the address bar:

    ```text
    http://<VM_public_IP_address>
    ```
1. Get authenticated in Nextcloud using the login and password created when configuring the solution in the previous step.
1. In the left part of the top menu, select ![folder-fill](../../_assets/console-icons/folder-fill.svg) **Files**.
1. In the left-hand menu, select **External storage** and then **AmazonS3**.
1. Click ![plus](../../_assets/console-icons/plus.svg) **New** and select ![arrow-shape-up-from-line](../../_assets/console-icons/arrow-shape-up-from-line.svg) **Upload files** to upload a file from your local computer to the storage.
1. Select a file on your local computer and upload it to the storage.

    The uploaded file will now appear in the Nextcloud storage named `AmazonS3`.
1. In {{ objstorage-full-name }}, [make sure](../../storage/operations/objects/list.md) the file was uploaded to the bucket.

The deployment of the Nextcloud basic configuration is now complete. If you used a {{ MY }} cluster in the basic configuration, you can now proceed to deploy a fault-tolerant configuration.

## Deploy Nextcloud in a fault-tolerant configuration {#the-redundant-variant}

You will deploy a fault-tolerant Nextcloud configuration in a three-VM group of three VMs, the load on Nextcloud hosts distributed with the help of an L7 {{ alb-full-name }}. The service database will reside in a three-host {{ MY }} cluster. Hosts of the instance group, load balancer, and {{ MY }} cluster will be evenly distributed across three [availability zones](../../overview/concepts/geo-scope.md). Nextcloud will be available via the domain name, for which a TLS certificate will be issued in {{ certificate-manager-name }}.

### Scale the {{ mmy-name }} cluster {#expand-mysql-cluster}

To add more hosts to a {{ mmy-name }} cluster:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}** and then select `nextcloud-db-cluster`.
  1. In the left-hand menu, select ![cube](../../_assets/console-icons/cube.svg) **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}**.
  1. Use the **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}** button to add more [hosts](../../managed-mysql/concepts/instance-types.md) to have three hosts in the cluster, one per [availability zone](../../overview/concepts/geo-scope.md).

        Do not enable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** when creating hosts.

        {% note warning %}

        Before adding the third host, wait until the second one goes `ALIVE`. You cannot add a new host to the cluster until the operation of adding the previous one is over.

        {% endnote %}

{% endlist %}

### Complete Nextcloud setup and create a VM disk snapshot {#create-snapshot}

Before you create a VM snapshot to proceed with the instance group deployment, add your domain to the list of trusted addresses and Nextcloud domains:

1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to `nextcloud-vm` over SSH.
1. Add your domain to the array of trusted addresses and Nextcloud domains:

    1. In the VM terminal, open the Nextcloud configuration file:

        ```bash
        sudo nano /var/www/nextcloud/config/config.php
        ```
    1. In the `trusted_domains` array, replace the host IP address with your domain name.

        Here is an example:

        ```php
        'trusted_domains' =>
        array (
          0 => 'example.com',
        ),
        ```

        The `trusted_domains` array allows you to restrict the range of IP addresses and/or domains you can use to access Nextcloud and ensures additional protection from unauthorized access. You can specify multiple addresses and/or domains, and you can also reduce or remove this restriction using wildcard characters:

        {% list tabs %}

        - Example 1

          ```php
          'trusted_domains' =>
          array (
            0 => '*.example.com',
            1 => '198.168.*.*',
          ),
          ```

          In this example, access is allowed from any subdomains of the `example.com` domain and the IP addresses of the `192.168.0.0` - `192.168.255.255` range.

        - Example 2

          ```php
          'trusted_domains' =>
          array (
            0 => '*',
          ),
          ```

          In this example, access is allowed from any domains and IP addresses.

        {% endlist %}
    1. Delete the `'overwrite.cli.url' => 'http://<VM_IP_address>',` line.
    1. Save the changes and close the `nano` editor.
1. [Stop](../../compute/operations/vm-control/vm-stop-and-start.md#stop) the `nextcloud-vm` virtual machine.
1. After the VM stops, create a snapshot of its disk:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder to create the infrastructure in.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. In the left-hand panel, select ![hard-drive](../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.disks_ddfdb }}**.
      1. In the line with the disk, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.compute.disks.button_action-snapshot }}**.
      1. In the **{{ ui-key.yacloud.common.name }}** field, specify `nextcloud-vm-snapshot` as the snapshot name.
      1. Click **{{ ui-key.yacloud.common.create }}**.
      1. Wait until the snapshot creation process is over.
      
          To track the snapshot status, select ![image](../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.snapshots_81jHX }}** in the left-hand panel.

    {% endlist %}


### Add a TLS certificate to {{ certificate-manager-full-name }} {#issue-certificate}

To enable access to Nextcloud over HTTPS, issue a TLS certificate for your domain:

1. Add a Let's Encrypt® [certificate](../../certificate-manager/concepts/managed-certificate.md) for your domain to {{ certificate-manager-name }}:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
      1. Click **{{ ui-key.yacloud.certificate-manager.button_empty-action }}** and select **{{ ui-key.yacloud.certificate-manager.action_request }}**.
      1. In the window that opens, specify `mymanagedcert` in the **{{ ui-key.yacloud.certificate-manager.metadata.field_name }}** field.
      1. In the **{{ ui-key.yacloud.certificate-manager.request.field_domains }}** field, enter a name for your domain, e.g., `example.com`.
      1. In the **{{ ui-key.yacloud.certificate-manager.request.field_challenge-type }}** field, select `{{ ui-key.yacloud.certificate-manager.request.challenge-type_label_dns }}` and click **{{ ui-key.yacloud.certificate-manager.request.button_request }}**.

    {% endlist %}

    A new certificate with the `Validating` status will appear in the certificate list. This status means that a Let's Encrypt® certificate was requested and you need to pass a [domain rights check](../../certificate-manager/operations/managed/cert-validate.md) for the request to be successfully processed.
1. For the certificate to be issued successfully, pass a domain rights check:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
      1. From the list of certificates, select `mymanagedcert`.
      1. In the window that opens, under **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}**, select `CNAME record`.
      1. Add a [CNAME record](../../dns/concepts/resource-record.md#cname) required for the domain rights check to your domain’s public DNS zone. This step's further actions will depend on whether your domain is managed by {{ dns-full-name }} or a third-party DNS provider:

          {% include [creating-cname](../../_includes/certificate-manager/creating-cname.md) %}

          The domain rights check may take from a few minutes to a few days. Wait until it is complete. As a result, the certificate will be issued and get the `Issued` status.

    {% endlist %}

### Deploy an instance group {#create-instance-group}

For a fault-tolerant Nextcloud solution, scale it across an [instance group](../../compute/concepts/instance-groups/index.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder to create the infrastructure in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
  1. Click **{{ ui-key.yacloud.compute.groups.button_create }}**.
  1. In the **{{ ui-key.yacloud.compute.groups.create.field_name }}** field, specify `nextcloud-instance-group` as the group name.
  1. In the **{{ ui-key.yacloud.compute.groups.create.field_service-account }}** field, select the `nextcloud-sa` service account.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_allocation }}**, select all [availability zones](../../overview/concepts/geo-scope.md) for maximum fault tolerance.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_instance }}**, click **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}** and in the form that opens:

      1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, navigate to the **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}** tab and click **{{ ui-key.yacloud.common.select }}**.

          In the window that opens, select the `nextcloud-vm-snapshot` snapshot you created earlier and click **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, select the `2 {{ ui-key.yacloud.component.compute.resources.field_cores }} 4 {{ ui-key.yacloud.common.units.label_gigabyte }} {{ ui-key.yacloud.component.compute.resources.field_memory }}` configuration.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

          1. In the **{{ ui-key.yacloud.compute.instances.create.field_instance-group-network }}** field, select `nextcloud-network`.
          1. In the **{{ ui-key.yacloud.compute.instances.create.field_instance-group-address }}** field, select `{{ ui-key.yacloud.compute.instances.create.value_address-none }}`.
          1. In the **{{ ui-key.yacloud.compute.instances.create.field_security-groups }}** field, select `nextcloud-sg`.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:
      
          * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter a username, e.g., `yc-user`. Do not use `root` or other reserved usernames. To perform operations requiring root privileges, use the `sudo` command.
          * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}
      1. Click **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_scale }}**, specify `3` in the **{{ ui-key.yacloud.compute.groups.create.field_scale-size }}** field.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_alb }}**, enable **{{ ui-key.yacloud.compute.groups.create.field_target-group-attached }}** and specify `nextcloud-target-group` in the **{{ ui-key.yacloud.compute.groups.create.field_target-group-name }}** field that appears.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_health-check }}**:

      1. Enable **{{ ui-key.yacloud.compute.groups.create.field_enable-health-check }}**.
      1. In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-protocol }}** field, select `{{ ui-key.yacloud.common.label_tcp }}`.
  1. Click **{{ ui-key.yacloud.common.create }}** and wait for the instance group to be created and started.

{% endlist %}

### Create an L7 load balancer {#setup-balancer}

Create an [application-level load balancer](../../application-load-balancer/concepts/application-load-balancer.md) for traffic distribution between the hosts of the future Nextcloud instance group:

1. Create a [backend group](../../application-load-balancer/concepts/backend-group.md):

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
      1. In the left-hand panel, select ![image](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.alb.label_backend-groups }}** and click **{{ ui-key.yacloud_billing.alb.button_backend-group-create }}**.
      1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the group: `nextcloud-bg`.
      1. Enable **{{ ui-key.yacloud_billing.alb.label_session-affinity }}** and select `{{ ui-key.yacloud.alb.label_affinity-connection }}` in the **{{ ui-key.yacloud_billing.alb.label_session-affinity-mode }}** field that appears.
      1. Under **{{ ui-key.yacloud.alb.label_backends }}**, click **{{ ui-key.yacloud.common.add }}** and do the following in the **{{ ui-key.yacloud_billing.alb.label_new-backend }}** form that opens:

          1. In the **{{ ui-key.yacloud.common.name }}** field, specify `nextcloud-backend`.
          1. In the **{{ ui-key.yacloud_billing.alb.label_target-groups }}** field, select the `nextcloud-target-group` target group you created earlier.
          1. Expand the **{{ ui-key.yacloud.alb.label_lb-settings }}** section and select `MAGLEV_HASH` in the **{{ ui-key.yacloud.alb.label_load-balancing-mode }}** field.
          1. In the **HTTP health check**, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
      1. Click **{{ ui-key.yacloud.common.create }}**.

    {% endlist %}

1. Create an [HTTP router](../../application-load-balancer/concepts/http-router.md):

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
      1. In the left-hand panel, select ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}** and click **{{ ui-key.yacloud.alb.button_http-router-create }}**.
      1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the HTTP router: `nextcloud-router`.
      1. Under **{{ ui-key.yacloud_billing.alb.label_virtual-hosts }}**, click **{{ ui-key.yacloud.alb.button_virtual-host-add }}** and do the following in the **{{ ui-key.yacloud_billing.alb.label_new-virtual-host }}** form that opens:

          1. In the **{{ ui-key.yacloud.common.name }}** field, enter `nextcloud-vh` for the virtual host's name and click **{{ ui-key.yacloud_billing.alb.button_add-route }}**.
          1. In the **{{ ui-key.yacloud.alb.label_new-route }}** form that opens, enter `nextcloud-route` as the route's name in the **{{ ui-key.yacloud.common.name }}** field.
          1. In the **{{ ui-key.yacloud_billing.alb.label_backend-group }}** field, select the `nextcloud-bg` backend group created in the previous step.
          1. Leave all other parameters as they are and click **{{ ui-key.yacloud.component.mdb.settings.popup_settings-submit }}** at the bottom of the page.

    {% endlist %}

1. Create an L7 load balancer:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
      1. Click **{{ ui-key.yacloud.alb.button_load-balancer-create }}** and select **{{ ui-key.yacloud.alb.label_alb-create-form }}**.
      1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the load balancer: `nextcloud-alb`.
      1. In the **{{ ui-key.yacloud.mdb.forms.label_network }}** field, select `nextcloud-network`.
      1. In the **{{ ui-key.yacloud.mdb.forms.field_security-group }}** field, select `{{ ui-key.yacloud.component.security-group-field.label_sg-from-list }}` and then the `nextcloud-sg` security group from the list that opens.
      1. Under **{{ ui-key.yacloud_billing.alb.section_allocation-settings }}**, make sure all availability zones are selected.
      1. If you do not want load balancer logs saved to a [log group](../../logging/concepts/log-group.md), disable **{{ ui-key.yacloud.alb.label_log-requests }}**.
      1. In the **{{ ui-key.yacloud_billing.alb.label_listeners }}** section, click **{{ ui-key.yacloud.alb.button_add-listener }}** and in the form that opens:

          1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the listener: `nextcloud-listener`.
          1. In the **{{ ui-key.yacloud.alb.label_protocol-type }}** field, select `HTTPS`.
          1. In the **{{ ui-key.yacloud_billing.alb.label_certificate }}** field, select the `mymanagedcert` certificate you created earlier.
          1. In the **{{ ui-key.yacloud_billing.alb.label_http-router }}** field, select the `nextcloud-router` HTTP router you created earlier.
      1. Leave all other parameters as they are and click **{{ ui-key.yacloud.component.mdb.settings.popup_settings-submit }}** at the bottom of the page.

    {% endlist %}

    Wait for the load balancer status to change to `Active` and copy its IP address from the **{{ ui-key.yacloud.alb.column_addresses }}** field.

### Create an A resource record in your domain’s public DNS zone {#create-a-record}

To route your domain's incoming requests to an L7 load balancer, in your DNS zone, create an [A resource record](../../dns/concepts/resource-record.md#a) pointing to the load balancer's IP address you got in the previous step. Further steps to follow will depend on whether your domain is managed by {{ dns-full-name }} or a third-party DNS provider.

{% cut "**If your domain is managed by {{ dns-full-name }}**" %}
 
{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Select the DNS zone you need, click **{{ ui-key.yacloud.dns.button_record-set-create }}**, and do the following in the window that opens:

      1. In the **{{ ui-key.yacloud.common.name }}** field, select `{{ ui-key.yacloud.dns.label_fqdn-equal-to-zone }}`.
      1. In the **{{ ui-key.yacloud.common.type }}** field, select `A`.
      1. In the **{{ ui-key.yacloud.dns.label_records }}** field, specify the load balancer IP address you saved in the previous step.
      1. Leave other parameters as they are and click **{{ ui-key.yacloud.component.mdb.settings.popup_settings-submit }}**.

{% endlist %}

{% endcut %}

{% cut "**If your domain is managed by an external DNS provider**" %}

Add an A resource record with the following properties to your DNS provider or your own DNS server:

* Host: `@`
* Type: `A`
* Value: `<load_balancer_IP_address>`

{% endcut %}

### Test the solution in the fault-tolerant configuration {#test-redundant}

To test {{ objstorage-full-name }} integration with Nextcloud in a fault-tolerant configuration:

1. Open your local computer browser and enter your domain name in the address bar, e.g.:

    ```text
    https://example.com
    ```
1. Get authenticated in Nextcloud using the login and password created when configuring the solution.
1. In the left part of the top menu, select ![folder-fill](../../_assets/console-icons/folder-fill.svg) **Files**.
1. In the left-hand menu, select **External storage** and then **AmazonS3**.
1. Make sure you see the file uploaded in the previous step.
1. Download the file you uploaded earlier. Do this by clicking ![ellipsis](../../_assets/console-icons/ellipsis.svg) and selecting ![arrow-down](../../_assets/console-icons/arrow-down.svg) **Download** in the line with the filename.
1. Delete the file. Do this by clicking ![ellipsis](../../_assets/console-icons/ellipsis.svg) and selecting ![trash-bin](../../_assets/console-icons/trash-bin.svg) **Delete file** in the line with the filename.
1. In {{ objstorage-full-name }}, [make sure](../../storage/operations/objects/list.md) the file was deleted from the bucket.

## How to delete the resources you created {#clear-out}

1. If you had created an L7 load balancer, [delete](../../application-load-balancer/operations/application-load-balancer-delete.md) it and then delete the [HTTP router](../../application-load-balancer/operations/http-router-delete.md), [backend group](../../application-load-balancer/operations/backend-group-delete.md), and the load balancer's [target group](../../application-load-balancer/operations/target-group-delete.md) one by one.
1. If you had created an instance group, [delete](../../compute/operations/instance-groups/delete.md) it.
1. If you had created resource records, delete them in [{{ dns-full-name }}](../../dns/operations/resource-record-delete.md) or in your domain registrar’s account.
1. If you had created a DNS zone, delete it in [{{ dns-full-name }}](../../dns/operations/resource-record-delete.md) or in your domain registrar’s account.
1. If you had left the L7 load balancer logging feature on, [delete](../../logging/operations/delete-group.md) the log group.
1. [Delete](../../compute/operations/vm-control/vm-delete.md) the VM.
1. [Delete](../../managed-mysql/operations/cluster-delete.md) the {{ MY }} cluster database.
1. [Delete](../../storage/operations/objects/delete.md) the objects you created in the bucket, then [delete](../../storage/operations/buckets/delete.md) the bucket itself.
1. [Delete](../../compute/operations/snapshot-control/delete.md) the disk snapshot.
1. [Delete](../../iam/operations/sa/delete.md) the service account.
1. Delete the [subnets](../../vpc/operations/subnet-delete.md), [security group](../../vpc/operations/security-group-delete.md), [route table](../../vpc/operations/delete-route-table.md), [NAT gateway](../../vpc/operations/delete-nat-gateway.md), and [cloud network](../../vpc/operations/network-delete.md) one by one.
1. Optionally, [delete](../../certificate-manager/operations/managed/cert-delete.md) the TLS certificate if you created one.
