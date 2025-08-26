In this tutorial, you will deploy Nextcloud on a {{ compute-name }} [VM](../../../compute/concepts/vm.md) from a [{{ coi }}](../../../cos/concepts/index.md) and connect an {{ objstorage-name }} [bucket](../../../storage/concepts/bucket.md) to it. To implement this solution, you will need a [domain name](https://en.wikipedia.org/wiki/Domain_name) for accessing resources in Nextcloud.

To deploy Nextcloud integrated with an {{ objstorage-name }} bucket on a VM from a {{ coi }} image, do the following:

1. [Get your cloud ready](#before-you-begin).
1. [Create and set up a cloud network](#setup-network).
1. [Create a service account and static access key](#setup-sa).
1. [Create an {{ objstorage-name }} bucket](#create-bucket).
1. [Create a VM](#create-vm).
1. [Create an A resource record in your domain’s public DNS zone](#create-a-record).
1. [Configure Nextcloud on the VM](#setup-nextcloud).
1. [Test the solution](#test).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of the proposed solution includes: 
* Fee for [disks](../../../compute/concepts/disk.md) and continuously running [VMs](../../../compute/concepts/vm.md) (see [{{ compute-full-name }} pricing](../../../compute/pricing.md)).
* Fee for using [public IP addresses](../../../vpc/concepts/address.md#public-addresses) (see [{{ vpc-full-name }} pricing](../../../vpc/pricing.md)).
* Fee for [data storage](../../../storage/concepts/bucket.md) in {{ objstorage-name }} and data [operations](../../../storage/operations/index.md) (see [{{ objstorage-full-name }} pricing](../../../storage/pricing.md)).
* If using {{ dns-full-name }}, fee for [DNS zones](../../../dns/concepts/dns-zone.md#public-zones) and public DNS queries (see [{{ dns-name }} pricing](../../../dns/pricing.md)).

## Set up a cloud network {#setup-network}

1. {% include [create-network](../../_tutorials_includes/integrate-nextcloud/create-network.md) %}
1. Create a [security group](../../../vpc/concepts/security-groups.md) that allows the traffic required for your Nextcloud infrastructure:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
      1. In the left-hand panel, select ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}**. 
      1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** field, enter `nextcloud-sg` for name.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** field, select `nextcloud-network` you created earlier.
      1. Under **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}**, [create](../../../vpc/operations/security-group-add-rule.md) the following traffic management rules:

          | Traffic<br/>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
          | --- | --- | --- | --- | --- | --- |
          | Inbound | `http`           | `8080` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
          | Inbound | `https`           | `443` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
          | Inbound | `ssh`            | `22`   | `TCP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
          | Egress | `any`           | `All` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
      1. Click **{{ ui-key.yacloud.common.create }}**.

    {% endlist %}

## Create a service account and static access key {#setup-sa}

{% include [create-sa-and-aws-key](../../_tutorials_includes/integrate-nextcloud/create-sa-and-aws-key.md) %}

## Create an {{ objstorage-name }} bucket {#create-bucket}

{% include [create-bucket](../../_tutorials_includes/integrate-nextcloud/create-bucket.md) %}

## Create a VM {#create-vm}

Create the VM to deploy Nextcloud on:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder to create the infrastructure in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}** and click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, navigate to the **{{ ui-key.yacloud.compute.instances.create.image_value_coi }}** tab and click **{{ ui-key.yacloud.compute.instances.create.image_coi_label_empty-button }}**. In the window that opens:

      1. Navigate to the **{{ ui-key.yacloud.compute.instances.create.value_docker-compose-yaml }}** tab and copy the `compose.yaml` [docker compose specification](https://github.com/nextcloud/all-in-one/blob/main/compose.yaml) from the official Nextcloud repository on GitHub into the field that opens.
      1. Click **{{ ui-key.yacloud.common.apply }}**.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../../overview/concepts/geo-scope.md) for your VM.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, set a disk size of at least `40 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, select the `2 {{ ui-key.yacloud.component.compute.resources.field_cores }} 4 {{ ui-key.yacloud.common.units.label_gigabyte }} {{ ui-key.yacloud.component.compute.resources.field_memory }}` configuration.

      This configuration will be enough to accommodate simultaneous operations by up to 10 users. If there are more active users, provide more available resources for the VM.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select `nextcloud-network` and the subnet in your new VM's availability zone.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, leave the `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` value to assign the VM a random public IP address from the {{ yandex-cloud }} pool.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** field, select `nextcloud-sg`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

      * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter a username, e.g., `yc-user`. Do not use `root` or other reserved usernames. To perform operations requiring root privileges, use the `sudo` command.
      * {% include [access-ssh-key](../../../_includes/compute/create/access-ssh-key.md) %}
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `nextcloud-vm`.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

{% endlist %}

{% note tip %}

To ensure that your new VM's [public IP address](../../../vpc/concepts/address.md#public-addresses) does not change in the future if the VM is stopped, [make that address static](../../../vpc/operations/set-static-ip.md).

{% endnote %}

## Create an A resource record in your domain’s public DNS zone {#create-a-record}

To complete this step, you will need a registered domain name, e.g., `example.com`.

To route your domain's incoming requests to the VM you created earlier, in your [public DNS zone](../../../dns/concepts/dns-zone.md#public-zones), create an [`A` resource record](../../../dns/concepts/resource-record.md#a) pointing to the VM's public IP address. Further steps to follow will depend on whether your domain is managed by [{{ dns-full-name }}](../../../dns/index.yaml) or a third-party DNS provider.

{% cut "**If your domain is managed by {{ dns-full-name }}**" %}
 
{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Select the DNS zone you need, click **{{ ui-key.yacloud.dns.button_record-set-create }}**, and do the following in the window that opens:

      {% note info %}

      If you do not have a public DNS zone for the required domain name yet, [create](../../../dns/operations/zone-create-public.md) one.

      {% endnote %}

      1. In the **{{ ui-key.yacloud.common.name }}** field, select `{{ ui-key.yacloud.dns.label_create-subdomain }}` and enter `nextcloud` to create a subdomain, e.g., `nextcloud.example.com`, in your domain zone.
      1. In the **{{ ui-key.yacloud.common.type }}** field, select `A`.
      1. In the **{{ ui-key.yacloud.dns.label_records }}** field, specify the VM's public IP address.

          You can look up the VM's public IP address in the [management console]({{ link-console-main }}) by checking the **{{ ui-key.yacloud.compute.instance.overview.section_network }}** section's **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}** field on the VM information page.
      1. Keep the other settings unchanged and click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

{% endcut %}

{% cut "**If your domain is managed by an external DNS provider**" %}

Add an A resource record with the following properties to your DNS provider or your own DNS server:

* Host: `nextcloud.<your_domain_name>.`
* Type: `A`
* Value: `<VM_IP_address>`

{% endcut %}

## Configure Nextcloud on a VM {#setup-nextcloud}

Follow this tutorial to perform the initial setup of your Nextcloud instance and integrate an {{ objstorage-name }} bucket into Nextcloud.

### Perform basic Nextcloud setup {#initialize}

Configure the Nextcloud solution on your new VM using the Nextcloud web interface:

1. In your browser, enter the subdomain you registered earlier with port `8080`, e.g., `https://nextcloud.example.com:8080`.

    You will see a warning about an insecure connection, as your Nextcloud instance does not have a configured [TLS](https://en.wikipedia.org/wiki/Transport_Layer_Security) certificate yet. Proceed to the page despite the warning; Nextcloud will later automatically set up a certificate for your instance.
1. In the window that opens, copy the passphrase from the **Passphrase** field.

    {% note warning %}

    Displayed only once, this passphrase cannot be retrieved again. Without it, you will not be able to get the administrator password or complete your Nextcloud setup.

    {% endnote %}
1. Click **Open Nextcloud AIO login**.
1. In the **Nextcloud AIO Login** window, paste the passphrase you copied and click **Log in**.
1. In the **New AIO instance** section of the next window, enter the domain name used to access your Nextcloud instance (e.g., `nextcloud.example.com`) and click **Submit Domain**.
1. In the **Optional containers** section of the next window, disable `Nextcloud Talk` and click **Save changes**.

    For this tutorial, this module is optional. You can install it later via the Nextcloud admin interface if needed.
1. Click **Download and start containers**.

    The download and startup of the required containers may take several minutes. Wait for this process to complete.
1. Once all containers are running, the browser window will display the admin password for your Nextcloud instance in the **Initial Nextcloud password:** field. Save this password, then click **Open your Nextcloud**.
1. On the authentication screen, enter `admin` as the username and the password you got in the previous step, then click **Log in**.

### Set up integration with your {{ objstorage-name }} bucket {#integrate-bucket}

1. Open the application management menu. To do this, click the user icon in the top-right corner of the screen and select ![plus](../../../_assets/console-icons/plus.svg) **Apps** from the context menu.
1. In the window that opens, select ![person](../../../_assets/console-icons/person.svg) **Your apps** in the left-hand panel.
1. In the list that opens, find the `External storage support` application and click **Enable** in the row with it.

    If needed, enter your Nextcloud administrator password in the pop-up window to confirm the operation.
1. Open the main settings menu. To do this, click the user icon in the top-right corner of the screen and select ![admin-icon](../../../_assets/tutorials/integrate-nextcloud/admin-icon.svg) **Administration settings** from the context menu.
1. In the window that opens, select ![app-dark-icon](../../../_assets/tutorials/integrate-nextcloud/app-dark-icon.svg) **External storage** in the left-hand panel under **Administration** and specify the {{ objstorage-name }} integration settings under **External storage** in the window that opens:

    1. In the **External storage** section, select `Amazon S3`.
    1. In the **Authentication** section, select `Access key`.
    1. In the **Configuration** section:

        * In the **Bucket** field, enter the name of the bucket you created earlier, e.g., `my-nextcloud-bucket`.
        * In the **Hostname** field, specify `{{ s3-storage-host }}`.
        * In the **Port** field, specify `443`.
        * In the **Access key** field, paste the ID of the static access key you created earlier.
        * In the **Secret key** field, paste the secret key of the static access key you created earlier.
    1. Under **Available for**, enable **All people**.
    1. On the right side of the section you are editing, click the ![check](../../../_assets/console-icons/check.svg) icon to save your changes.

        Enter your Nextcloud administrator password in the pop-up window to confirm the operation.

## Test the solution {#test}

To test {{ objstorage-name }} integration with Nextcloud, do the following:

1. On your local computer, open a browser and enter the domain name of your deployed Nextcloud instance in the address bar:

    ```text
    https://nextcloud.example.com
    ```
1. Log in to Nextcloud using the `admin` username and the saved administrator password.
1. In the left pane of the top menu, select ![folder-fill](../../../_assets/console-icons/folder-fill.svg) **Files**.
1. In the left-hand menu, select **External storage** and then **AmazonS3**.
1. Click ![plus](../../../_assets/console-icons/plus.svg) **New** and select ![arrow-shape-up-from-line](../../../_assets/console-icons/arrow-shape-up-from-line.svg) **Upload files** to upload a file from your local computer to the storage.
1. Select a file on your local computer and upload it to the storage.

    The uploaded file will now appear in the Nextcloud storage named `AmazonS3`.
1. In {{ objstorage-full-name }}, [make sure](../../../storage/operations/objects/list.md) the file was uploaded to the bucket.

This completes the deployment of the Nextcloud instance and its integration with {{ objstorage-name }} storage.

## How to delete the resources you created {#clear-out}

1. Delete the resource record in [{{ dns-full-name }}](../../../dns/operations/resource-record-delete.md) or in your domain registrar's account.
1. If you created a public DNS zone, delete it in [{{ dns-full-name }}](../../../dns/operations/zone-delete.md) or in your domain registrar's account.
1. [Delete](../../../compute/operations/vm-control/vm-delete.md) the VM.
1. [Delete](../../../storage/operations/objects/delete.md) the objects you created in the bucket, then [delete](../../../storage/operations/buckets/delete.md) the bucket itself.
1. [Delete](../../../iam/operations/sa/delete.md) the service account.
1. Delete the [subnets](../../../vpc/operations/subnet-delete.md), [security group](../../../vpc/operations/security-group-delete.md), and [cloud network](../../../vpc/operations/network-delete.md) one by one.