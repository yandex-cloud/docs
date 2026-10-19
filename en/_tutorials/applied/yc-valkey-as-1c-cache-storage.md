# Using a {{ mrd-name }} cluster as a cache storage for 1C-Bitrix: Site Management

You can use a {{ mrd-name }} cluster as an external cache storage for a website on 1C-Bitrix: Site Management.

To set up caching:

1. [Set up your infrastructure](#deploy-infrastructure).
1. [Configure 1C-Bitrix: Website Management](#configure-bitrix).
1. [Check the result](#test).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

* VM instance: use of computing resources, storage, public IP address, and OS (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* {{ mrd-name }} cluster: computing resources allocated to hosts, storage and backup size (see [{{ mrd-name }} pricing](../../managed-valkey/pricing.md)).

This tutorial uses the trial version of 1C-Bitrix with a 30-day trial period. You can check the cost of the product software versions on the [1C-Bitrix](https://www.1c-bitrix.ru) official website.


## Set up your infrastructure {#deploy-infrastructure}

{% list tabs group="instructions" %}

- Manually {#manual}

    1. [Create a network](../../vpc/operations/network-create.md) named `network-1c` with the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** option disabled.
    1. In `network-1c`, [create a subnet](../../vpc/operations/subnet-create.md) with the following settings:

        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}**: `subnet-a`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}**: `{{ region-id }}-a`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}**: `192.168.0.0/24`.

    1. In `network-1c`, [create security groups](../../vpc/operations/security-group-create.md):

        1. Named `bitrix-sg`, for the VM in the cloud. [Set the following rules](../../vpc/operations/security-group-add-rule.md) for this security group:

            | Traffic<br>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
            |------------------------|----------------------------------------------------------------------------------|---------------------------------------------------------------------------------|-------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------|
            | Outbound              | `ANY`                                                                            | `All`                                                                          | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`            | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}`                                                                                    | `0.0.0.0/0`                                                                      |
            | Inbound               | `HTTP`                                                                           | `80`                                                                            | `{{ ui-key.yacloud.common.label_tcp }}`                                       | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}`                                                                                    | `0.0.0.0/0`                                                                      |
            | Inbound               | `EXT-HTTPS`                                                                      | `443`                                                                           | `{{ ui-key.yacloud.common.label_tcp }}`                                       | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}`                                                                                    | `0.0.0.0/0`                                                                      |
            | Inbound               | `SSH`                                                                            | `22`                                                                            | `{{ ui-key.yacloud.common.label_tcp }}`                                       | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}`                                                                                    | `0.0.0.0/0`                                                                      |

        1. Named `valkey-sg`, for the {{ mrd-name }} cluster. [Set the following rules](../../vpc/operations/security-group-add-rule.md) for this security group:

            | Traffic<br>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
            |------------------------|----------------------------------------------------------------------------------|---------------------------------------------------------------------------------|-------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------|
            | Outbound              | `ANY`                                                                            | `All`                                                                          | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`            | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}`                                                                                    | `0.0.0.0/0`                                                                      |
            | Inbound               | `EXT-HTTPS`                                                                      | `6379`                                                                          | `{{ ui-key.yacloud.common.label_tcp }}`                                       | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}`                                                                                    | `0.0.0.0/0`                                                                      |

    1. [Create a virtual machine](../../compute/operations/images-with-pre-installed-software/create.md) with the following configuration in {{ compute-name }}:

        * Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select a [1C-Bitrix](/marketplace/products/yc/bitrix-1c-centos-7) image.
        * Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, set the following settings:

            * **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}**: `network-1c` and `subnet-a`.
            * **{{ ui-key.yacloud.component.compute.network-select.field_external }}**: `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
            * **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}**: `bitrix-sg`.
            * **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}**: `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.

    1. [Connect to the VM](../../compute/operations/images-with-pre-installed-software/operate.md#vm-connect) over SSH and install the dependencies:

        ```bash
        sudo yum install php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo && \
        sudo yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
        sudo yum install yum-utils && \
        sudo yum-config-manager --enable remi-php74 && \
        sudo yum update && \
        php -v
        ```

        The last command will show the PHP version installed on the VM. For 1C-Bitrix to run correctly, update the PHP version to 7.4 or higher.

    1. Install 1C-Bitrix: Site Management on the VM. Do it by going to `http://<VM_public_IP_address>/` in your browser and following the installer instructions.

    1. Create a test website on 1C-Bitrix.

    1. [Create](../../managed-valkey/operations/cluster-create.md) a {{ mrd-name }} cluster with the following configuration:

        * **Valkey version**: `9.1`.
        * **Persistence**: `On replicas`.
        * **Network settings**: `network-1c` as the network and `valkey-sg` as the security group.
        * **DBMS settings**:
            * **Password**: `default`.
            * **Configure** → **Maxmemory policy**: `ALLKEYS LRU`. This setting will allow {{ VLK }} to delete the oldest keys when running out of memory.
        * **Access from WebSQL**: Enabled.


- {{ TF }} {#tf}

  1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
  1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
  1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
  1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}
  1. Download the [yc-valkey-as-1c-cache-storage.tf](https://github.com/yandex-cloud-examples/yc-valkey-1c-locks/blob/main/yc-valkey-as-1c-cache-storage.tf) configuration file to the same working directory.

      This file describes:

      * Network.
      * Subnets.
      * Security groups.
      * {{ mrd-name }} cluster.
      * Virtual machine with public internet access and preinstalled 1C-Bitrix: Site Management.
      * Settings for 1C-Bitrix: Site Management.

          {% note info %}

          Specific 1C-Bitrix settings may vary depending on your custom implementation. You can find cache configuration examples in the [product documentation](https://dev.1c-bitrix.ru/).

          {% endnote %}

  1. In `yc-valkey-as-1c-cache-storage.tf`, specify the value for the `valkey_password` variable, i.e., the {{ mrd-name }} cluster user password.

  1. Validate your {{ TF }} configuration using this command:

      ```bash
      terraform validate
      ```
      {{ TF }} will display any configuration errors detected in your files.

  1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

  After you create the resources, the terminal will display the following connection settings:

  * `valkey_endpoint`: Endpoint for connection to the {{ mrd-name }} cluster.
  * `bitrix_vm_public_ip`: Public IP address of the VM running 1C-Bitrix: Site Management.


{% endlist %}

## Configure 1C-Bitrix {#configure-bitrix}

{% list tabs group="instructions" %}

- Manually {#manual}

  1. [Connect to the VM](../../compute/operations/images-with-pre-installed-software/operate.md#vm-connect) running 1C-Bitrix over SSH.

  1. Navigate to the website folder and open the additional settings file named `bitrix/.settings_extra.php`.

  1. Specify {{ RD }} as the caching option and the {{ mrd-name }} cluster address:

      ```php
      <?php
      return [
          'cache' => [
              'value' => [
                  'type' => [
                      'class_name' => '\Bitrix\Main\Data\CacheEngineRedis',
                  ],
                  'redis' => [
                      'servers' => [
                          [
                              'host' => 'c-<cluster_ID>.rw.mdb.yandexcloud.net',
                              'port' => 6379,
                          ],
                      ],
                      'serializer' => \Redis::SERIALIZER_IGATBINARY ?? null,
                  ],
              ],
              'readonly' => true,
          ],
      ];
      ```

      You can get the cluster ID with the [list of clusters](../../managed-valkey/operations/cluster-list.md#list-clusters) in the folder.

      {% note info %}

      Specific 1C-Bitrix settings may vary depending on your custom implementation. You can find cache configuration examples in the [product documentation](https://dev.1c-bitrix.ru/).

      {% endnote %}


- {{ TF }} {#tf}

  1C-Bitrix: Site Management is configured when you create the VM. No additional setup is required.


{% endlist %}


## Check the result {#test}

1. Authenticate to your website and navigate to the control panel.
1. Open **Settings** → **Productivity settings** → **Productivity panel**.
1. On the **Bitrix** tab, make sure that caching is enabled with {{ RD }} as storage.
1. Make sure data actually ends up in the cluster:

    1. In the [management console]({{ link-console-main }}), select the folder containing the cluster.
    1. [Navigate]({{ link-console-main }}/link/managed-valkey) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
    1. Click the name of your cluster and select the **{{ ui-key.yacloud.redis.cluster.switch_monitoring }}** tab. The page that opens will display performance charts for the cluster.
    1. Make sure that clients have appeared, stored data and traffic are growing, and there is disk write activity on replicas due to enabled persistence.

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Delete the {{ mrd-full-name }} cluster](../../managed-valkey/operations/cluster-delete.md).
    1. [Delete the VM](../../compute/operations/vm-control/vm-delete.md).
    1. If you reserved public static IP addresses, release and [delete them](../../vpc/operations/address-delete.md).


- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}


{% endlist %}
