# Connecting to {{ container-registry-name }} from {{ vpc-short-name }}

To work with [{{ container-registry-name }}](../../container-registry/), cloud resources require internet access. Follow this guide to deploy a cloud infrastructure in {{ yandex-cloud }} to set up access to {{ container-registry-name }} for resources that are hosted in the [{{ vpc-name }}](../../vpc/concepts/) cloud network and have no public IP addresses or access to the internet through a [NAT gateway](../../vpc/concepts/gateways).

{{ container-registry-short-name }} uses [{{ objstorage-name }}](../../storage/) to store Docker images in a registry. This solution also has access to {{ objstorage-name }} for resources in {{ vpc-name }}.

After the solution is deployed in {{ yandex-cloud }}, the following resources will be created:

| Name | Description |
| ---- | ---- |
| `cr-vpc` `*` | Cloud network with the resources for which access to {{ container-registry-name }} is set up. |
| `cr-nlb` | Internal network load balancer accepts traffic to {{ container-registry-name }}. The load balancer accepts TCP traffic with destination port 443 and distributes it across resources (VMs) in a target group. |
| `nat-group` | Load balancer target group with VMs that have the NAT function enabled. |
| `s3-nlb` | Internal network load balancer accepts traffic to {{ objstorage-name }}. The load balancer accepts TCP traffic with destination port 443 and distributes it across resources (VMs) in a target group. |
| `nat-a1-vm`, `nat-b1-vm` | VMs with NAT in the `ru-central1-a` and `ru-central1-b` zones for routing traffic to {{ container-registry-name }} and {{ objstorage-name }} with translation of IP addresses of traffic sources and targets, as well as for routing the return traffic. |
| `pub-ip-a1`, `pub-ip-b1` | VM public IP addresses to which the VPC cloud network translates their internal IP addresses. |
| `DNS zones and A records` | `{{ s3-storage-host }}.` and `{{ registry }}.` private DNS zones in the `cr-vpc` network with `A` resource records mapping domain names to IP addresses of internal network load balancers. |
| `test-registry` | Registry in {{ container-registry-name }}. |
| `container-registry-<registry_ID>` | Bucket name in {{ objstorage-name }} for storing Docker images, where `<registry_ID>` is the registry ID. {{ container-registry-name }} automatically creates a bucket for the registry in {{ objstorage-name }}. |
| `cr-subnet-a`, `cr-subnet-b` | Cloud subnets to host NAT instances in the `ru-central1-a` and `ru-central1-b` zones. |
| `test-cr-vm` | Test VM to verify access to {{ container-registry-name }}. |
| `test-cr-subnet-a` | Cloud subnet to host the test VM. |

`*` *When deploying, you can specify an existing cloud network as well*.

Internal DNS zones are created for the cloud network with hosted resources in [{{ dns-name }}](../../dns/concepts/):
* `{{registry}}.` and a type A resource record mapping the `{{ registry }}` domain name of {{ container-registry-name }} to the IP address of the `cr-nlb` [internal network load balancer](../../network-load-balancer/concepts/nlb-types).
* `{{ s3-storage-host }}.` and a type A resource record mapping the `{{ s3-storage-host }}` domain name of {{ objstorage-short-name }} to the IP address of the `s3-nlb` internal network load balancer.

With these recodrs, traffic from cloud resources to {{ container-registry-short-name }} and {{ objstorage-short-name }} will be routed to internal load balancers that will distribute the load across the NAT instances.

To deploy a NAT instance, an [image from Marketplace](/marketplace/products/yc/nat-instance-ubuntu-22-04-lts) is used that translates the source and target IP addresses to ensure traffic routing to the {{ container-registry-short-name }} and {{ objstorage-short-name }} public IP addresses.

By placing the NAT instances in multiple [availability zones](../../overview/concepts/geo-scope), you can ensure fault-tolerant access to {{ container-registry-short-name }}. By increasing the number of NAT instances, you can scale the solution up when the load grows. When calculating the number of NAT instances, consider the [locality of traffic handling by the internal load balancer](../../network-load-balancer/concepts/specifics.md#nlb-int-locality).

Only the cloud resources that use this solution can access the registry. The [registry access policy](../../container-registry/operations/registry/registry-access.md) allows registry actions only from public IP addresses of NAT instances. You cannot access the registry from other IP addresses. You can disable this limitation by specifying a parameter in {{ TF }}, if required.

For more information, see the [project repository](https://github.com/yandex-cloud-examples/yc-cr-private-endpoint).

To deploy a cloud infrastructure to provide access to {{ container-registry-short-name }} for resources located in the {{ vpc-short-name }} cloud network:

1. [Prepare your cloud](#prepare-cloud).
1. [Configure the CLI profile](#setup-profile).
1. [Prepare the environment](#prepare-environment).
1. [Deploy your resources](#create-resources).
1. [Test the solution](#test-functionality).
1. [Recommendations for solution deployment in the production environment](#deployment-requirements)

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The infrastructure support cost includes:

* Fee for continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using {{ network-load-balancer-name }} (see [{{ network-load-balancer-full-name }} pricing](../../network-load-balancer/pricing.md)).
* Fee for storing pushed Docker images (see [{{ container-registry-name }} pricing](../../container-registry/pricing.md)).
* Fee for using public IP addresses and outgoing traffic (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


### Required quotas {#required-quotes}

Make sure your cloud has sufficient [quotas](../../overview/concepts/quotas-limits.md) not being used by resources for other jobs.

{% cut "Number of occupied resources created in the scenario" %}

| Resource | Amount |
| ----------- | ----------- |
| Virtual machines | 3 |
| VM instance vCPUs | 6 |
| VM instance RAM | 6 GB |
| Disks | 3 |
| HDD size | 30 GB |
| SSD size | 20 GB |
| Network load balancer | 2 |
| Target group for the load balancer | 1 |
| Networks | 1`*` |
| Subnets | 3 |
| Static public IP addresses | 2 |
| Security groups | 1 |
| DNS zone | 2 |
| Registry | 1 |
| Service account | 1 |

`*` *If you do not specify the ID of an existing network in `terraform.tfvars`.*

{% endcut %}

## Configure the CLI profile {#setup-profile}

1. If you do not have the {{ yandex-cloud }} command line interface yet, [install](../../cli/quickstart.md) it and sign in as a user.
1. Create a service account:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select a folder where you want to create a service account.
      1. In the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab, click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. Enter a name for the service account, e.g., `sa-terraform`.
      1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

   - CLI {#cli}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      Run the command below to create a service account, specifying the `sa-terraform` name:

      ```bash
      yc iam service-account create --name sa-terraform
      ```

      In this command, replace `name` with the name of the service account.

      Result:
      ```yaml
      id: ajehr0to1g8b********
      folder_id: b1gv87ssvu49********
      created_at: "2023-06-20T09:03:11.665153755Z"
      name: sa-terraform
      ```

   - API {#api}

      To create a service account, use the [ServiceAccountService/Create](../../iam/api-ref/grpc/service_account_service.md#Create) gRPC API method or the [create](../../iam/api-ref/ServiceAccount/create.md) REST API  method for the `ServiceAccount` resource.

   {% endlist %}

1. Assign the service account the administrator [role](../../iam/concepts/access-control/roles.md) for the folder:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. On the [start page]({{ link-console-main }}) of the management console, select the folder.
      1. Go to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
      1. Find the `sa-terraform` service account in the list and click ![image](../../_assets/options.svg).
      1. Click **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
      1. Click **{{ ui-key.yacloud_components.acl.button.add-role }}** in the dialog box that opens and select the `admin` role.

   - CLI {#cli}

      Run this command:
      ```
      yc resource-manager folder add-access-binding <folder_ID> \
         --role admin \
         --subject serviceAccount:<service_account_ID>
      ```

   - API {#api}

      To assign the service account a role for the folder, use the [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/service_account_service.md#SetAccessBindings) gRPC API call.

   {% endlist %}

1. Set up the CLI profile to run operations on behalf of the service account:

   {% list tabs group=instructions %}

   - CLI {#cli}

      1. Create an [authorized key](../../iam/concepts/authorization/key.md) for the service account and save it to the file:
         ```
         yc iam key create \
         --service-account-id <service_account_ID> \
         --folder-id <ID_of_folder_with_service_account> \
         --output key.json
         ```

         Where:

         * `service-account-id`: ID of your service account.
         * `folder-id`: ID of the folder in which the service account was created.
         * `output`: Name of the file with the authorized key.

         Result:
         ```
         id: aje8nn871qo4********
         service_account_id: ajehr0to1g8b********
         created_at: "2023-06-20T09:16:43.479156798Z"
         key_algorithm: RSA_2048
         ```

      1. Create a CLI profile to run operations on behalf of the service account:
         ```
         yc config profile create sa-terraform
         ```

         Result:
         ```
         Profile 'sa-terraform' created and activated
         ```

      1. Set the profile configuration:

         ```
         yc config set service-account-key key.json
         yc config set cloud-id <cloud_ID>
         yc config set folder-id <folder_ID>
         ```

         Where:

         * `service-account-key`: File with the authorized key of the service account.
         * `cloud-id`: [Cloud ID](../../resource-manager/operations/cloud/get-id.md).
         * `folder-id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).

      1. Add the credentials to the environment variables:
         ```
         export YC_TOKEN=$(yc iam create-token)
         ```

   {% endlist %}

## Prepare the environment {#prepare-environment}

### Install the required utilities {#install-utilities}

1. Install [Git](https://en.wikipedia.org/wiki/Git) using the following command:

   ```bash
   sudo apt install git
   ```

1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Deploy your resources {#create-resources}

1. Clone the GitHub [repository](https://github.com/yandex-cloud-examples/yc-cr-private-endpoint/) and go to the `yc-cr-private-endpoint` directory:

   ```bash
   git clone https://github.com/yandex-cloud-examples/yc-cr-private-endpoint.git
   cd yc-cr-private-endpoint
   ```

1. Open the `terraform.tfvars` file and edit the following:

   1. String with the folder ID:

      ```text
      folder_id = "<folder_ID>"
      ```

   1. String containing a list of aggregated prefixes of cloud subnets that are allowed to access {{ container-registry-short-name }}:

      ```text
      trusted_cloud_nets = ["10.0.0.0/8", "192.168.0.0/16"]
      ```

   {% cut "Description of variables in terraform.tfvars" %}

   | Parameter<br>name | Change<br>required | Description | Type | Example |
   | --- | --- | --- | --- | --- |
   | `folder_id` | Yes | ID of the folder to host the solution components | `string` | `b1gentmqf1ve9uc54nfh` |
   | `vpc_id` | - | ID of the cloud network for which access to {{ container-registry-short-name }} is set up. If not specified, such a network will be created. | `string` | `enp48c1ndilt42veuw4x` |
   | `yc_availability_zones` | - | List of [availability zones](../../overview/concepts/geo-scope) for deploying NAT instances | `list(string)` | `["ru-central1-a", "ru-central1-b"]` |
   | `subnet_prefix_list` | - | List of prefixes of cloud subnets to host the NAT instances (one subnet in each availability zone from the `yc_availability_zones` list in the same order) | `list(string)` | `["10.10.1.0/24", "10.10.2.0/24"]` |
   | `nat_instances_count` | - | Number of NAT instances to deploy. We recommend setting an even number to evenly distribute the instances across the availability zones. | `number` | `2` |
   | `registry_private_access` | - | Only allow registry access from public IP addresses of NAT instances. If `true`, access is limited. To cancel the limit, set `false`. | `bool` | `true` |
   | `trusted_cloud_nets` | Yes | List of aggregated prefixes of cloud subnets that {{ container-registry-short-name }} access is allowed for. It is used in the rule for incoming traffic of security groups for the NAT instances. | `list(string)` | `["10.0.0.0/8", "192.168.0.0/16"]` |
   | `vm_username` | - | NAT instance and test VM user names | `string` | `admin` |
   | `cr_ip` | - | {{ container-registry-short-name }} public IP address | `string` | `84.201.171.239` |
   | `cr_fqdn` | - | {{ container-registry-short-name }} domain name | `string` | `{{registry}}` |
   | `s3_ip` | - | {{ objstorage-short-name }} public IP address | `string` | `213.180.193.243` |
   | `s3_fqdn` | - | {{ objstorage-short-name }} domain name | `string` | `{{ s3-storage-host }}` |

   {% endcut %}

1. Deploy the resources in the cloud using {{ TF }}:

   1. Initialize {{ TF }}:

      ```bash
      terraform init
      ```

   1. Check the {{ TF }} file configuration:

      ```bash
      terraform validate
      ```

   1. Check the list of created cloud resources:

      ```bash
      terraform plan
      ```

   1. Create resources:

      ```bash
      terraform apply
      ```

1. Once the `terraform apply` process is completed, the command line will output information required to connect to the test VM and test operations with {{ container-registry-short-name }}. Afterwards, you can view this information by running the `terraform output` command.

   {% cut "Viewing information on deployed resources" %}

   | Name | Description | Sample value |
   | ----------- | ----------- | ----------- |
   | `cr_nlb_ip_address` | IP address of the internal load balancer for {{ container-registry-short-name }} | `10.10.1.100` |
   | `cr_registry_id` | Registry ID in {{ container-registry-short-name }} | `crp1r4h00mj*********` |
   | `path_for_private_ssh_key` | File with a private key used to connect to the NAT instances and test VM over SSH | `./pt_key.pem` |
   | `s3_nlb_ip_address` | IP address of the internal load balancer for {{ objstorage-short-name }} | `10.10.1.200` |
   | `test_vm_password` | `admin` user password for the test VM | `v3RСqUrQN?x)` |
   | `vm_username` | NAT instance and test VM user names | `admin` |

   {% endcut %}

## Test the solution {#test-functionality}

1. In the [management console]({{ link-console-main }}), go to the folder where the resources were created.

1. Select **{{ compute-name }}**.

1. Select `test-cr-vm` from the list of VMs.

1. Go to the **{{ ui-key.yacloud.compute.instance.switch_console }}** tab.

1. Click **{{ ui-key.yacloud.compute.instance.console.connect }}**.

1. Enter the `admin` username and the password from the `terraform output test_vm_password` command output (without quotation marks).

1. Run this command:

   ```bash
   dig {{registry}} {{ s3-storage-host }}
   ```

1. Check that the {{ objstorage-name }} and {{ container-registry-name }} domain name in the DNS server response maps to the IP address of the internal load balancer. The output of the type `A` resource records is:

   ```text
   ;; ANSWER SECTION:
   {{registry}}.               300    IN      A       10.10.1.100

   ;; ANSWER SECTION:
   {{ s3-storage-host }}. 300    IN      A       10.10.1.200
   ```

1. View the list of available Docker images:

   ```bash
   docker image list
   ```

   Result:
   ```text
   REPOSITORY    TAG       IMAGE ID       CREATED        SIZE
   golang        1.20.5    342*********   8 months ago   777MB
   hello-world   latest    9c7*********   9 months ago   13.3kB
   ```

1. Assign to the Docker image a URL in `{{registry}}/<registry_ID>/<Docker_image_name>:<tag>` format. The registry ID will be obtained from the test VM environment variable:

   ```bash
   docker tag hello-world {{registry}}/$REGISTRY_ID/hello-world:demo

   docker image list
   ```

   Result:
   ```text
   REPOSITORY                                   TAG       IMAGE ID       CREATED        SIZE
   golang                                       1.20.5    342*********   8 months ago   777MB
   {{registry}}/crp1r4h00mj*********/hello-world   demo      9c7*********   9 months ago   13.3kB
   hello-world                                  latest    9c7*********   9 months ago   13.3kB
   ```

   {% note info %}

   You can only push Docker images to {{ container-registry-short-name }} if they have a URL in `{{registry}}/<registry_ID>/<Docker_image_name>:<tag>` format.

   {% endnote %}


1. Push the required Docker image to the registry:

   ```bash
   docker push {{registry}}/$REGISTRY_ID/hello-world:demo
   ```

   Result:
   ```text
   The push refers to repository [{{registry}}/crp1r4h00mj*********/hello-world]
   01bb4*******: Pushed
   demo: digest: sha256:7e9b6e7ba284****************** size: 525
   ```

1. In the [management console]({{ link-console-main }}), go to the folder where the resources were created.

1. Select **{{ container-registry-name }}**.

1. Select `test-registry`.

1. Make sure the `hello-world` repository with the Docker image appears in the registry.

## Recommendations for solution deployment in the production environment {#deployment-requirements}

* When deploying NAT instances in multiple availability zones, set an even number of VMs to evenly distribute them across the availability zones.
* When selecting the number of NAT instances, consider the [locality of traffic handling by the internal load balancer](../../network-load-balancer/concepts/specifics.md#nlb-int-locality).
* Once the solution is deployed, reduce the number of NAT instances or update the list of availability zones in the `yc_availability_zones` parameter in the pre-scheduled period of time only. While applying changes, traffic handling may be interrupted.
* If you see a high `CPU steal time` metric value inside a NAT instance as the {{ container-registry-name }} load grows, we recommend enabling a [software-accelerated network](../..//vpc/concepts/software-accelerated-network.md) for that NAT instance.
* If you are using your own DNS server, create `A` resource records in its settings in the following format:

   | Name | Type | Value |
   | ----------- | ----------- | ----------- |
   | `{{registry}}.` | `A` | `<IP address of the internal load balancer for {{ container-registry-name }} from the terraform output cr_nlb_ip_address> command output` |
   | `{{ s3-storage-host }}.` | `A` | `<IP address of the internal load balancer for {{ objstorage-name }} from the terraform output s3_nlb_ip_address> command output` |

* Save the `pt_key.pem` private SSH key used to connect to the NAT instances to a secure location or recreate it separately from {{ TF }}.
* Once the solution is deployed, SSH access to the NAT instances will be denied. To enable access to the NAT instances over SSH, add a rule for incoming SSH traffic (`TCP/22`) in the `cr-nat-sg` [security group](../../vpc/concepts/security-groups.md) to allow access only from certain IP addresses of admin workstations.
* After performance check, delete the test VM and its subnet.

## Delete the resources you created {#clear-out}

1. In the [management console]({{ link-console-main }}), go to the folder where the resources were created.
1. Select **{{ container-registry-name }}**.
1. Select `test-registry`.
1. Select the `hello-world` repository.
1. For each Docker image in the repository, click ![image](../../_assets/console-icons/ellipsis.svg).
1. In the menu that opens, click **{{ ui-key.yacloud.common.delete }}**.
1. In the window that opens, click **{{ ui-key.yacloud.cr.image.popup-confirm_button_delete }}**.
1. To delete the resources you created using {{ TF }}, run the `terraform destroy` command.

   {% note warning %}

   {{ TF }} will permanently delete all the resources that were created while deploying the solution.

   {% endnote %}
