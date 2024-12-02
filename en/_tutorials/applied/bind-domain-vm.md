# Assigning a domain name to a VM with a web server


In this tutorial, you will assign your own domain name to a [VM](../../compute/concepts/vm.md) with a web server. You can use any domain name registrar to register your domain name.

To create a VM, this tutorial uses a public [LAMP](/marketplace/products/yc/lamp) image with a pre-installed [Apache HTTP server](https://httpd.apache.org/). Using a public [LEMP](/marketplace/products/yc/lemp) image with an [NGINX](https://www.nginx.com/) web server is also possible.

To assign a domain name to a VM with a web server in {{ dns-name }}:

1. [Prepare your cloud](#before-you-begin).
1. [Create a VM with a web server](#create-web-server).
1. [Create a public DNS zone](#configure-dns).
1. [Delegate your domain to {{ dns-name }}](#delegate-domain).
1. [Create a type A resource record](#create-record).
1. [Test the website](#check).

If you no longer need the resources you created, [delete them](#clear-out).

You can also assign a domain name to a VM with a web server via {{ TF }} using a ready-made [configuration file](#terraform).


## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}



### Required paid resources {#paid-resources}

The support cost includes:

* Fee for using a public IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for VM computing resources and disks (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using a public DNS zone and public DNS requests (see [{{ dns-full-name }} pricing](../../dns/pricing.md)).



### Create a cloud network and subnet {#create-network}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select your folder.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. At the top right, click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. In the **{{ ui-key.yacloud.vpc.networks.create.field_name }}** field, specify `webserver-network`.
  1. In the **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** field, disable the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** option.
  1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. In the left-hand panel, select ![subnets](../../_assets/vpc/subnets.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
  1. At the top right, click **{{ ui-key.yacloud.common.create }}**.
  1. In the **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** field, specify `webserver-subnet-{{ region-id }}-b`.
  1. In the **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** field, select the `{{ region-id }}-b` [availability zone](../../overview/concepts/geo-scope.md).
  1. In the **{{ ui-key.yacloud.vpc.subnetworks.create.field_network }}** field, select the [cloud network](../../vpc/concepts/network.md) named `webserver-network`.
  1. In the **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** field, specify `192.168.1.0/24`.
  1. Click **{{ ui-key.yacloud.vpc.subnetworks.create.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Create the `webserver-network` [cloud network](../../vpc/concepts/network.md).

      ```bash
      yc vpc network create webserver-network
      ```

      Result:

      ```
      id: enp1gg8kr3pv********
      folder_id: b1gt6g8ht345********
      created_at: "2023-12-20T20:08:11Z"
      name: webserver-network
      default_security_group_id: enppne4l2eg5********
      ```

      For more information about the `yc vpc network create` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/network/create.md).

  1. Create a subnet in the `{{ region-id }}-b` [availability zone](../../overview/concepts/geo-scope.md):

      ```bash
      yc vpc subnet create webserver-subnet-{{ region-id }}-b \
        --zone {{ region-id }}-b \
        --network-name webserver-network \
        --range 192.168.1.0/24
      ```

      Result:

      ```
      id: e2li9tcgi7ii********
      folder_id: b1gt6g8ht345********
      created_at: "2023-12-20T20:11:16Z"
      name: webserver-subnet-{{ region-id }}-b
      network_id: enp1gg8kr3pv********
      zone_id: {{ region-id }}-b
      v4_cidr_blocks:
        - 192.168.1.0/24
      ```

      For more information about the `yc vpc subnet create` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/subnet/create.md).

- {{ TF }} {#tf}

  See [How to create an infrastructure using {{ TF }}](#terraform) for details.

- API {#api}

  1. To create a [cloud network](../../vpc/concepts/network.md), use the [create](../../vpc/api-ref/Network/create.md) REST API method for the [Network](../../vpc/api-ref/Network/index.md) resource or the [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md) gRPC API call.

  1. To create a subnet, use the [create](../../vpc/api-ref/Subnet/create.md) REST API method for the [Subnet](../../vpc/api-ref/Subnet/index.md) resource or the [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md) gRPC API call.

{% endlist %}


### Create a security group {#create-sg}

Create a [security group](../../vpc/concepts/security-groups.md) that allows inbound TCP traffic on ports `22`, `80`, and `443` as well as any outbound traffic.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select your folder.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. In the left-hand panel, select ![image](../../_assets/vpc/security-group.svg) **{{ ui-key.yacloud.vpc.switch_security-groups }}**.
  1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
  1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** field, enter the name: `webserver-sg`.
  1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** field, select the `webserver-network` network you created earlier.
  1. Under **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}**, [create](../../vpc/operations/security-group-add-rule.md) the following traffic management rules:

      | Traffic<br/>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
      | --- | --- | --- | --- | --- | --- |
      | Incoming | `http`           | `80` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
      | Incoming | `https`            | `443`   | `TCP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
      | Incoming | `ssh`            | `22`   | `TCP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
      | Outgoing | `any`           | `All` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |

  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Run this command:

  ```bash
  yc vpc security-group create \
    --name webserver-sg \
    --rule "description=http,direction=ingress,port=80,protocol=tcp,v4-cidrs=[0.0.0.0/0]" \
    --rule "description=https,direction=ingress,port=443,protocol=tcp,v4-cidrs=[0.0.0.0/0]" \
    --rule "description=ssh,direction=ingress,port=22,protocol=tcp,v4-cidrs=[0.0.0.0/0]" \
    --rule "description=any,direction=egress,port=any,protocol=any,v4-cidrs=[0.0.0.0/0]" \
    --network-name webserver-network
  ```

  Result:

  ```text
  id: enp4htsnl1sa********
  folder_id: b1gt6g8ht345********
  created_at: "2023-12-23T19:07:03Z"
  name: webserver-sg
  network_id: enp37qpnksl2********
  status: ACTIVE
  rules:
    - id: enpdu0t8san9********
      description: http
      direction: INGRESS
      ports:
        from_port: "80"
        to_port: "80"
      protocol_name: TCP
      protocol_number: "6"
      cidr_blocks:
        v4_cidr_blocks:
          - 0.0.0.0/0
    - id: enpr7oirpff5********
      description: https
      direction: INGRESS
      ports:
        from_port: "443"
        to_port: "443"
      protocol_name: TCP
      protocol_number: "6"
      cidr_blocks:
        v4_cidr_blocks:
          - 0.0.0.0/0
    - id: enp0bgk6dkdd********
      description: ssh
      direction: INGRESS
      ports:
        from_port: "22"
        to_port: "22"
      protocol_name: TCP
      protocol_number: "6"
      cidr_blocks:
        v4_cidr_blocks:
          - 0.0.0.0/0
    - id: enpspns0tfml********
      description: any
      direction: EGRESS
      protocol_name: ANY
      protocol_number: "-1"
      cidr_blocks:
        v4_cidr_blocks:
          - 0.0.0.0/0
  ```

  For more information about the `yc vpc security-group create` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/security-group/create.md).

  Save the security group ID (`id`) as you will need it to create a VM.

- {{ TF }} {#tf}

  See [How to create an infrastructure using {{ TF }}](#terraform) for details.

- API {#api}

  To create a security group, use the [create](../../vpc/api-ref/SecurityGroup/create.md) REST API method for the [SecurityGroup](../../vpc/api-ref/SecurityGroup/index.md) resource or the [SecurityGroupService/Create](../../vpc/api-ref/grpc/SecurityGroup/create.md) gRPC API call.

{% endlist %}


## Create a VM with a web server {#create-web-server}

Before you start, prepare a [key pair](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) (public and private keys) to access your VM over SSH.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create your VM.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**:

      * Go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab.
      * Click **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**.
      * In the list of public images, select [LAMP](/marketplace/products/yc/lamp) and click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.

  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the `{{ region-id }}-b` [availability zone](../../overview/concepts/geo-scope.md).

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select the `webserver-subnet-{{ region-id }}-b` subnet you created earlier.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** field, select the `webserver-sg` security group you created earlier.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the information required to access the VM:

      * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter the `yc-user` username.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `mywebserver`.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- CLI {#cli}

  Run the command specifying the security group ID you saved at the previous step:

  ```bash
  yc compute instance create \
    --name mywebserver \
    --zone {{ region-id }}-b \
    --network-interface subnet-name=webserver-subnet-{{ region-id }}-b,nat-ip-version=ipv4,security-group-ids=<security_group_ID> \
    --create-boot-disk image-folder-id=standard-images,image-id=fd8jtn9i7e9ha5q25niu \
    --ssh-key <SSH_key>
  ```

  Where `--ssh-key` is the path to the public SSH key file and its name, e.g., `~/.ssh/id_ed25519.pub`.

  Result:

  ```yml

  done (32s)
  id: fhmaq4shfrcm********
  folder_id: b1gt6g8ht345********
  created_at: "2023-12-23T05:36:34Z"
  name: mywebserver
  zone_id: {{ region-id }}-b
  platform_id: standard-v2
  resources:
    memory: "2147483648"
    cores: "2"
    core_fraction: "100"
  status: RUNNING
  metadata_options:
    gce_http_endpoint: ENABLED
    aws_v1_http_endpoint: ENABLED
    gce_http_token: ENABLED
    aws_v1_http_token: DISABLED
  boot_disk:
    mode: READ_WRITE
    device_name: fhmprher1d0q********
    auto_delete: true
    disk_id: fhmprher1d0q********
  network_interfaces:
    - index: "0"
      mac_address: d0:0d:ad:13:91:7e
      subnet_id: e9bk1m87r4m4********
      primary_v4_address:
        address: 192.168.1.11
        one_to_one_nat:
          address: 158.160.***.***
          ip_version: IPV4
      security_group_ids:
        - enpa5j0mrgm4********
  gpu_settings: {}
  fqdn: fhmaq4shfrcm********.auto.internal
  scheduling_policy: {}
  network_settings:
    type: STANDARD
  placement_policy: {}
  ```

  For more information about the `yc compute instance create` command, see the [CLI reference](../../cli/cli-ref/compute/cli-ref/instance/create.md).

- {{ TF }} {#tf}

  See [How to create an infrastructure using {{ TF }}](#terraform) for details.

- API {#api}

  To create a VM, use the [create](../../compute/api-ref/Instance/create.md) REST API method for the [Instance](../../compute/api-ref/Instance/) resource or the [InstanceService/Create](../../compute/api-ref/grpc/Instance/create.md) gRPC API call.

{% endlist %}

This will create the `mywebserver` VM in your folder. To [connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM over SSH, use the `yc-user` username and the VM’s public IP address. If you plan to use the created web server over a long period of time, [make](../../vpc/operations/set-static-ip.md) this VM's public IP address static.


## Create a public DNS zone {#configure-dns}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select your folder.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Click **{{ ui-key.yacloud.dns.button_zone-create }}**.
  1. Specify the [DNS zone](../../dns/concepts/dns-zone.md) settings consistent with your domain:

      1. **{{ ui-key.yacloud.dns.label_zone }}**: Domain zone. The zone name must end with a period. For example, the `example.com.` zone name corresponds to the `example.com` domain. You cannot create public top-level domain (TLD) zones. To create a domain zone with non-Latin characters, use the [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode) encoding.
      1. **{{ ui-key.yacloud.common.type }}**: `{{ ui-key.yacloud.dns.label_public }}`.
      1. **{{ ui-key.yacloud.common.name }}**: Zone name.

  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  Run this command:

  ```bash
  yc dns zone create \
    --name <zone_name> \
    --zone <domain_zone> \
    --public-visibility
  ```

  Where:

  * `--name`: [DNS zone](../../dns/concepts/dns-zone.md) name.
  * `--zone`: Domain zone. The zone name must end with a period. For example, the `example.com.` zone name corresponds to the `example.com` domain. You cannot create public top-level domain (TLD) zones. To create a domain zone with non-Latin characters, use the [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode) encoding.

  Result:

  ```
  id: dns39gihj0ef********
  folder_id: b1gt6g8ht345********
  created_at: "2023-12-21T16:43:37.883Z"
  name: my-domain-zone
  zone: example.com.
  public_visibility: {}
  ```

  For more information about the `yc dns zone create` command, see the [CLI reference](../../cli/cli-ref/dns/cli-ref/zone/create.md).

- {{ TF }} {#tf}

  See [How to create an infrastructure using {{ TF }}](#terraform) for details.

- API {#api}

  To create a public [DNS zone](../../dns/concepts/dns-zone.md), use the [create](../../dns/api-ref/DnsZone/create.md) REST API method for the [DnsZone](../../dns/api-ref/DnsZone/index.md) resource or the [DnsZoneService/Create](../../dns/api-ref/grpc/DnsZone/create.md) gRPC API call.

{% endlist %}


## Delegate your domain to {{ dns-name }} {#delegate-domain}

To delegate a domain to {{ dns-name }}, in your account on your domain registrar's website, specify the DNS server addresses in the domain settings:

* `ns1.{{ dns-ns-host-sld }}`
* `ns2.{{ dns-ns-host-sld }}`

Delegation does not take effect immediately. It usually takes up to 24 hours (86,400 seconds) for internet service providers to update records. This depends on the TTL value which specifies how long domain records are cached.

You can check the domain delegation using [Whois](https://www.reg.com/whois/check_site) or the `dig` utility:

```bash
dig +short NS example.com
```

Result:


```
ns2.{{ dns-ns-host-sld }}.
ns1.{{ dns-ns-host-sld }}.
```




## Create a type A resource record {#create-record}

In your DNS zone, create a [type A resource record](../../dns/concepts/resource-record.md#a) that points to the web server's public IP address:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select your folder.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Select the previously created DNS zone.
  1. Click **{{ ui-key.yacloud.dns.button_record-set-create }}**.
  1. Set the record parameters:
      1. In the **{{ ui-key.yacloud.common.name }}** field, select `{{ ui-key.yacloud.dns.label_fqdn-equal-to-zone }}`.
      1. In the **{{ ui-key.yacloud.common.type }}** field, select `A` as the [record type](../../dns/concepts/resource-record.md#rr-types).
      1. Under **{{ ui-key.yacloud.dns.label_records }}**, specify the web server's [public IP address](../../vpc/concepts/address.md#public-addresses).

          You can find the VM IP address in the **{{ ui-key.yacloud.compute.instance.overview.section_network }}** section on the VM page in the [management console]({{ link-console-main }}) or using this CLI command: `yc compute instance get <VM_name>`.

  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  Run this command:

  ```bash
  yc dns zone add-records \
    --name <zone_name> \
    --record "<domain_name> 600 A <VM_IP_address>"
  ```

  Where:

  * `--name`: Name of the public DNS zone you created earler.
  * `--record`: Parameters of the new resource record:
      * `<domain_name>`: Domain name that must end with a period. For example, for the `example.com` domain, the correct value is `example.com.`.
      * `<VM_IP_address>`: [Public IP address](../../vpc/concepts/address.md#public-addresses) of the web server.

          You can find the VM IP address in the **{{ ui-key.yacloud.compute.instance.overview.section_network }}** section on the VM page in the [management console]({{ link-console-main }}) or using this CLI command: `yc compute instance get <VM_name>`.

  Result:

  ```text
  +--------+--------------+------+---------------+-----+
  | ACTION |     NAME     | TYPE |     DATA      | TTL |
  +--------+--------------+------+---------------+-----+
  | +      | example.com. | A    | 51.250.**.*** | 600 |
  +--------+--------------+------+---------------+-----+
  ```

  For more information about the `yc dns zone add-records` command, see the [CLI reference](../../cli/cli-ref/dns/cli-ref/zone/add-records.md).

- {{ TF }} {#tf}

  See [How to create an infrastructure using {{ TF }}](#terraform) for details.

- API {#api}

  To create a resource record in a DNS zone, use the [updateRecordSets](../../dns/api-ref/DnsZone/updateRecordSets.md) REST API method for the [DnsZone](../../dns/api-ref/DnsZone/index.md) resource or the [DnsZoneService/UpdateRecordSets](../../dns/api-ref/grpc/DnsZone/updateRecordSets.md) gRPC API call.

{% endlist %}


## Test the website {#check}

The website on your web server is now accessible by its domain name. To test the site, enter its IP address or domain name in your browser:

* `http://<VM_public_IP_address>`
* `http://example.com`


## How to delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. In {{ compute-name }}, [delete](../../compute/operations/vm-control/vm-delete.md) the VM you created.
1. In {{ dns-name }}, [delete](../../dns/operations/zone-delete.md) the domain zone you created.
1. In {{ vpc-name }}, [delete](../../vpc/operations/security-group-delete.md) the security group first, then [delete](../../vpc/operations/subnet-delete.md) the subnet; finally, [delete](../../vpc/operations/network-delete.md) the network.


## How to create an infrastructure using {{ TF }} {#terraform}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

To create an infrastructure for assigning a domain name to a VM with a web server in {{ dns-name }} using {{ TF }}:

1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Prepare a file with the infrastructure description:

    {% list tabs %}

    - Ready-made archive

      1. Create a folder for the file with the infrastructure description.
      1. Download the [archive](https://{{ s3-storage-host }}/doc-files/???) (2 KB).
      1. Unpack the archive to the directory. As a result, it should contain the `bind-domain-to-vm.tf` configuration file and the `bind-domain-to-vm.auto.tfvars` user data file.

    - Creating files manually

      1. Create a folder for the file with the infrastructure description.
      1. In the directory, create a configuration file named `bind-domain-to-vm.tf`:

          {% cut "bind-domain-to-vm.tf" %}

          {% include [bind-domain-to-vm-tf-config](../../_includes/web/bind-domain-to-vm-tf-config.md) %}

          {% endcut %}

      1. In the directory, create a user data file named `bind-domain-to-vm.auto.tfvars`:

          {% cut "bind-domain-to-vm.auto.tfvars" %}

          {% include [bind-domain-to-vm-tf-variables](../../_includes/web/bind-domain-to-vm-tf-variables.md) %}

          {% endcut %}

    {% endlist %}

    For more information about the parameters of resources used in {{ TF }}, see the provider documentation:

    * [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network)
    * [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet)
    * [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group)
    * [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance)
    * [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone)
    * [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset)

1. In the `bind-domain-to-vm.auto.tfvars` file, set the following user-defined parameters:

    * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
    * `ssh_key_path`: Path to the file with a public SSH key to authenticate the user on the VM, e.g., `~/.ssh/id_ed25519.pub`. For more information, see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
    * `domain_name`: Your domain name, e.g., `example.com`.

1. Create resources:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

1. [Test secure access to files](#check).

#### See also {#see-also}

* [{{ dns-name }} integration with {{ compute-name }}](../../dns/concepts/compute-integration.md)