# Secure user access to cloud resources based on WireGuard VPN

In this tutorial, we will set up [WireGuard VPN](https://www.wireguard.com/) access to your cloud resources with [Firezone](https://www.firezone.dev/): an open-source [VPN](https://ru.wikipedia.org/wiki/VPN) solution supporting various [identity providers](https://www.firezone.dev/docs/authenticate) for [single sign-on](https://ru.wikipedia.org/wiki/Технология_единого_входа). We will also use the [Keycloak](https://www.keycloak.org/) access management software.

In our scenario, we will create a {{ yandex-cloud }} infrastructure and set up a WireGuard VPN access as shown in the diagram below:

![image](../../_assets/tutorials/remote-access-vpn.svg)

Diagram elements:

| Name | Description |
| ---- | ---- |
| Firezone VM | VM running Firezone WireGuard VPN software |
| Database cluster | [Managed Service for PostgreSQL](../../managed-postgresql/) supporing Firezone and Keycloak VMs | 
| Keycloak VM | VM running the [Keycloak](https://www.keycloak.org/) single sign-on operator supporting authentication of different identity providers, e.g., Active Directory |


For more information, see the [project repository](https://github.com/yandex-cloud-examples/yc-remote-acess-vpn-with-wireguard-firezone/blob/main/README.md).

To set up and test Firezone:

1. [Get your cloud ready](#prepare-cloud).
1. [Set up your resource environment](#setup-environment).
1. [Register your domain](#prepare-domain).
1. [Set up Firezone and Keycloak](#deploy-firezone).
1. [Set up Keycloak integration with Firezone](#configure-keycloak).
1. [Configure Firezone](#configure-firezone). 
1. [Test Firezone](#test-firezone).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure support costs include:

* Fee for continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for IP addresses and outbound traffic (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for using {{ mpg-name }} (see [{{ mpg-full-name }} pricing](../../managed-postgresql/pricing.md)).
* Fee for public DNS queries and [DNS zones](../../dns/concepts/dns-zone.md) (see [{{ dns-name }} pricing](../../dns/pricing.md)).

## Set up your resource environment {#setup-environment}

1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
1. If do not have the {{ yandex-cloud }} CLI yet, [install](../../cli/quickstart.md) it and sign in as a user.
1. Create a service account:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the folder where you want to create your service account.
     1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
     1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
     1. Specify the service account name, e.g., `sa-firezone`.
     1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

   - CLI {#cli}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     To create a service account, run the command below and specify the `sa-firezone` name:

     ```bash
     yc iam service-account create --name sa-firezone
     ```

     Where `--name` is the service account name.

     Result:

     ```text
     id: ajehr0to1g8b********
     folder_id: b1gv87ssvu49********
     created_at: "2023-07-06T09:00:00.665153755Z"
     name: sa-firezone
     ```

   {% endlist %}

1. Assign the administrator [role](../../iam/concepts/access-control/roles.md) for the folder to the service account: 

   {% list tabs group=instructions %}

   - Management console {#console}

     1. On the management console [home page]({{ link-console-main }}), select a folder.
     1. Navigate to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
     1. Find the `sa-firezone` account in the list and click ![image](../../_assets/console-icons/ellipsis.svg).
     1. Click **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
     1. In the dialog that opens, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.acl.update-dialog.button_add-role }}** and select the `admin` role.

   - CLI {#cli}

     Run this command:

     ```
     yc resource-manager folder add-access-binding <folder_ID> \
       --role admin \
       --subject serviceAccount:<service_account_ID>
      ```

   {% endlist %}

1. Set up a CLI profile to run operations on behalf of the service account:

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
         
         * `--service-account-id`: Service account ID.
         * `--folder-id`: Service account folder ID.
         * `--output`: Authorized key file name.

         Result:

         ```
         id: aje8nn871qo4********
         service_account_id: ajehr0to1g8b********
         created_at: "2023-07-06T09:03:00.479156798Z"
         key_algorithm: RSA_2048
         ```

     1. Create a CLI profile to run operations on behalf of the service account:

         ```bash
         yc config profile create sa-firezone
         ```

         Result:

         ```text
         Profile 'sa-firezone' created and activated
         ```

     1. Configure the profile:

         ```bash
         yc config set service-account-key key.json
         ```

         Where `service-account-key` is the service account authorized key file name.

     1. Export the access key to the environment variable:

         ```bash
         export YC_TOKEN=$(yc iam create-token)
         ```

   {% endlist %}

## Register your domain {#prepare-domain}

To use Firezone and Keycloak, you need to register a domain. Make sure to delegate this domain to Yandex Cloud by specifying the `ns1.{{ dns-ns-host-sld }}` and `ns2.{{ dns-ns-host-sld }}` server addresses in the NS records of your domain zone registrar.

## Set up Firezone and Keycloak {#deploy-firezone}

1. On your PC, clone the `yandex-cloud-examples/yc-remote-acess-vpn-with-wireguard-firezone` [repository](https://github.com/yandex-cloud-examples/yc-remote-acess-vpn-with-wireguard-firezone) from [{{ yandex-cloud }} Security Solution Library](https://github.com/yandex-cloud-examples/yc-security-solutions-library) and navigate to the `yc-remote-acess-vpn-with-wireguard-firezone` directory:

   ```bash
   git clone https://github.com/yandex-cloud-examples/yc-remote-acess-vpn-with-wireguard-firezone.git

   cd yc-remote-acess-vpn-with-wireguard-firezone
   ```

1. Describe the resources you plan to create in the `variables.tf` file:

   * In the `domain` section, specify your domain’s first and second levels separated by a dot for the Firezone and Keycloak VMs. In this example, we will use `example.com` as a domain.
   * In the `folder_id` section, specify your resource folder ID, e.g., `b1grj7grr1kn********`.
   * In the `vpc_id` section, specify your cloud network ID, e.g., `enp48c1ndilt********`.
   * In the `trusted_ip_for_mgmt` section, list public and subnet IP addresses allowed to access the Firezone and Keycloak VMs over SSH, e.g., `["A.A.A.A/32", "B.B.B.0/24"]`.
   * In the `admin_email` section, specify the admin email address that will be used to log in to the Firezone admin web UI, e.g., `admin@example.com`.
   * In the `email` section specify the test user email address that will be added to Firezone after Keycloak authentication, e.g., `user@example.com`.
   * You can leave other properties unchanged or edit them as you see fit, except for `image_folder_id` and `image_name`.

   {% note warning %}

      Using this configuration, you are going to deploy a resource-heavy infrastructure.
      Make sure you have sufficient quotas in Yandex Cloud.

   {% endnote %}

   {% cut "See the required resource reference" %}

      | Resource                                      | Amount |
      | ------------------------------------------- | ---------- |
      | Virtual machines                          | 2          |
      | VM vCPUs                      | 4          |
      | VM RAM                       | 12 GB      |
      | Disks                                       | 2          |
      | SSD size                            | 110 GB     |
      | Subnets                                     | 2          |
      | Static public IP addresses             | 2          |
      | Security groups                         | 2          |
      | Certificate Manager certificate              | 1          |
      | DNS zone                                    | 1          |
      | Managed Service for PostgreSQL cluster      | 1          |
      | SSD storage capacity for PostgreSQL cluster | 10 GB      |
      | Number of vCPUs for PostgreSQL cluster     | 2          |
      | Amount of RAM for PostgreSQL cluster        | 8          |

   {% endcut %}

   {% list tabs group=instructions %}

   - {{ TF }} {#tf}

     1. Navigate to the `main` directory:

         ```bash
         cd main
         ```

     1. Initialize Terraform:

         ```bash
         terraform init
         ```

     1. Preview the list of new cloud resources:

         ```bash
         terraform plan
         ```

     1. Create resources:

         ```bash
         terraform apply
         ```
         Wait for the process to complete. It may take up to 30 minutes to process a request for a Let's Encrypt certificate. 

     1. Once the process is complete, you will see Firezone and Keycloak web UI URL addresses and admin credentials. You can also see this information by running the `terraform output` command.

         ```bash
         Outputs:

         firezone_admin_credentials = <sensitive>
         firezone_url = "https://vpn.example.com"
         keycloak_admin_credentials = <sensitive>
         keycloak_url = "https://kc.example.com:8443/admin"
         ```

         To display sensitive information, such as passwords, specify the required variable name in the `terraform output` command, for example:

         ```bash
         terraform output firezone_admin_credentials
         ```

         Result:
         ```text
         {
            "admin_email" = "admin@example.com"
            "admin_password" = "7fVN********"
         }      
         ```

   {% endlist %}

## Set up Keycloak integration with Firezone {#configure-keycloak}

{% list tabs group=instructions %}

- {{ TF }} {#tf}

  1. Once you set up the Firezone and Keycloak VMs, navigate to the `keycloak-config` directory.

      ```bash
      cd ../keycloak-config
      ```

  1. Initialize Terraform:

      ```bash
      terraform init
      ```

  1. Preview the list of new cloud resources:

      ```bash
      terraform plan
      ```

  1. Create resources:

      ```bash
      terraform apply
      ```

  1. Once the process is complete, you will see the Firezone and Keycloak integration information and test user credentials you will need to test Keycloak single sign-on and the VPN connection. You can also see this information by running the `terraform output` command.

      ```bash
      Outputs:

      keycloak_config_for_firezone = <sensitive>
      test_user_credentials = <sensitive>
      ```

      To display sensitive information, such as passwords, specify the required variable in the `terraform output` command.

{% endlist %}

## Configure Firezone {#configure-firezone}

1. In your browser, navigate to `https://firezone_url`, where `firezone_url` is the Firezone admin web UI URL you saved earlier. To get it again, navigate to the `main` directory and run `terraform output firezone_url`. In our example, the address is `https://vpn.example.com`.
1. Log in to the Firezone admin web UI using admin credentials you saved earlier. To get them again navigate to the `main` directory and run `terraform output firezone_admin_credentials`.
1. Navigate to the **SETTINGS / Defaults** section.
1. In the **Allowed IPs** field, specify the comma-separated list of cloud subnets (in the `IP address/mask` format) accessible through the VPN. Example: `192.168.1.0/24, 192.168.2.0/24`.
1. In the **DNS Servers** field, specify the DNS server addresses that your VPN clients will use. 
   Example: `192.168.1.2, 192.168.2.2`.
   If your clients will not use these DNS addresses, delete information in this field. 
1. You can also change your clients `keepalive` and `MTU` settings. For example, you can increase `MTU` to 1440 bytes from the default 1280 bytes.
1. Click **Save** to apply the changes.
1. Navigate to the **SETTINGS / Security** section.
1. Disable **Allow unprivileged device configuration** to keep users from changing VPN client network settings via the Firezone web UI.
1. Activate **Auto disable VPN**. This will automatically close VPN connections of users removed from the identity provider, e.g., Keycloak.
1. Click **Add OpenID Connect Provider** and add Keycloak.
1. In the **OIDC Configuration** section, specify the following settings:
   - **Config ID**: `keycloak`
   - **Label**: `Keycloak`
   - **OIDC scopes**: `openid email profile offline_access`
   - **Client ID**: `firezone`
   - **Client secret**: `client_secret` you saved earlier. To get it again, navigate to the `keycloak-config` and run `terraform output keycloak_config_for_firezone`. Enter the value without quotes.
   - **Discovery Document URI**: `discovery_document_uri` you saved earlier. To get it again, navigate to the `keycloak-config` and run `terraform output keycloak_config_for_firezone`. Enter the value without quotes.
   - **Redirect URI**: Leave it blank.
   - Enable **Auto-create users** to automatically add authenticated Keycloak users to Firezone.
1. Click **Save** in the **OIDC Configuration** section to apply the changes.

## Test Firezone {#test-firezone}

1. Install the [WireGuard client](https://www.wireguard.com/install/) on your remote PC.

    In our example, we will use Windows WireGuard client. For other operating systems, the client UI names may differ.

1. In your browser, navigate to `https://firezone_url`, where `firezone_url` is the Firezone web UI URL you saved earlier. To get it again, navigate to the `main` directory and run `terraform output firezone_url`. If you already logged in as admin, **Log Out** first. Click **Sign in with Keycloak**. You will be redirected to the Keycloak login page.
1. Log in with test user credentials you saved earlier. To get them again, navigate to the `keycloak-config` directory and run `terraform output test_user_credentials`.
1. Once you logged in Firezone as a test user, add your VPN client device by clicking **Add Device**.
1. In the window that opens, you can change the device name and add its description. Click **Generate Configuration**.
1. You will see a window with your device's VPN configuration. Click **Download WireGuard Configuration** to download the configuration file. The window also contains a QR code you can scan to add a VPN tunnel on Android or iOS.

   {% note warning %}

      Do not close the window before you download the configuration file or scan the QR code because, once you close it, you will not be able to get this information again.

   {% endnote %}

1. Click **Import tunnel(s) from file** in the WireGuard client to add a new VPN tunnel using the configuration file you downloaded.
1. Click **Activate** to activate the tunnel.  
1. Run `ping 192.168.1.1` on your remote PC to check whether the gateway is accessible from the `firezone` cloud subnet. If `ping` is successful, it means you are now connected to your cloud infrastructure through the VPN tunnel.

   ```bash
   Pinging 192.168.1.1 with 32 bytes of data:
   Reply from 192.168.1.1: bytes=32 time=67ms TTL=53
   ```

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

  1. On your remote PC, navigate to the `keycloak-config` directory and run the `terraform destroy` command.
  1. Next, navigate to the `main` directory and run `terraform destroy` again.

{% endlist %}