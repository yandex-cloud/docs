# Secure user access to cloud resources based on WireGuard VPN

To set up secure remote [VPN](https://ru.wikipedia.org/wiki/VPN) access to your cloud resources over [WireGuard VPN](https://www.wireguard.com/), use the open-source [Firezone](https://www.firezone.dev/) solution. To implement [Single Sign-On](https://ru.wikipedia.org/wiki/Технология_единого_входа) scenarios for users, the solution supports multiple authentication services ([Identity Providers](https://www.firezone.dev/docs/authenticate)). In the example below, we will use the [Keycloak](https://www.keycloak.org/) identity and access management solution.

In this scenario, you will deploy a cloud infrastructure in {{ yandex-cloud }} to set up a remote access VPN based on WireGuard VPN using the following scenario:

![image](../../_assets/tutorials/remote-access-vpn.svg)

Notes to the chart elements:

| Name | Description |
| ---- | ---- |
| Firezone VM | VM with installed Firezone software based on WireGuard VPN to set up VPN access |
| Database cluster | [Managed Service for PostgreSQL](../../managed-postgresql/) to run Firezone and Keycloak VMs. | 
| Keycloak VM | Open-source [Keycloak](https://www.keycloak.org/) software for user single sign-on authentication in a corporate user identity federation, such as Active Directory. |


For more information, see the project repository [here](https://github.com/yandex-cloud-examples/yc-remote-acess-vpn-with-wireguard-firezone/blob/main/README.md).

To set up Firezone and test it:

1. [Get your cloud ready](#prepare-cloud).
1. [Set up an environment for deploying the resources](#setup-environment).
1. [Prepare a domain](#prepare-domain).
1. [Deploy Firezone and Keycloak](#deploy-firezone).
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

## Set up the environment for deploying the resources {#setup-environment}

1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
1. If you do not have the {{ yandex-cloud }} command line interface yet, [install](../../cli/quickstart.md) it and sign in as a user.
1. Create a service account:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the folder where you want to create a service account.
     1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
     1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
     1. Specify the service account name, e.g., `sa-firezone`.
     1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

   - CLI {#cli}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     Run the command below to create a service account, specifying the `sa-firezone` name:

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

1. Assign the service account the administrator [role](../../iam/concepts/access-control/roles.md) for the folder: 

   {% list tabs group=instructions %}

   - Management console {#console}

     1. On the management console [home page]({{ link-console-main }}), select a folder.
     1. Navigate to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
     1. Find the `sa-firezone` account in the list and click ![image](../../_assets/console-icons/ellipsis.svg).
     1. Click **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
     1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.acl.update-dialog.button_add-role }}** in the dialog that opens and select the `admin` role.

   - CLI {#cli}

     Run this command:

     ```
     yc resource-manager folder add-access-binding <folder_ID> \
       --role admin \
       --subject serviceAccount:<service_account_ID>
      ```

   {% endlist %}

1. Set up the CLI profile to perform operations under the service account:

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
         * `--folder-id`: ID of the folder in which the service account was created.
         * `--output`: Name of the file with the authorized key.

         Result:

         ```
         id: aje8nn871qo4********
         service_account_id: ajehr0to1g8b********
         created_at: "2023-07-06T09:03:00.479156798Z"
         key_algorithm: RSA_2048
         ```

     1. Create a CLI profile to perform operations under the service account:

         ```bash
         yc config profile create sa-firezone
         ```

         Result:

         ```text
         Profile 'sa-firezone' created and activated
         ```

     1. Set the profile configuration:

         ```bash
         yc config set service-account-key key.json
         ```

         Where `service-account-key`is the file with the service account authorized key.

     1. Save the access key to the environment variable:

         ```bash
         export YC_TOKEN=$(yc iam create-token)
         ```

   {% endlist %}

## Prepare a domain {#prepare-domain}

You will need a domain to use for Firezone and Keycloak VMs. Make sure to first delegate this domain to Yandex Cloud from the domain registrar. To do this, specify the addresses of the `ns1.{{ dns-ns-host-sld }}` and `ns2.{{ dns-ns-host-sld }}` servers in your account on your registrar's website.

## Deploy Firezone and Keycloak {#deploy-firezone}

1. On your workstation, clone the `yandex-cloud-examples/yc-remote-acess-vpn-with-wireguard-firezone` [repository](https://github.com/yandex-cloud-examples/yc-remote-acess-vpn-with-wireguard-firezone) from [{{ yandex-cloud }} Security Solution Library](https://github.com/yandex-cloud-examples/yc-security-solutions-library) and go to the `yc-remote-acess-vpn-with-wireguard-firezone` scenario directory:

   ```bash
   git clone https://github.com/yandex-cloud-examples/yc-remote-acess-vpn-with-wireguard-firezone.git

   cd yc-remote-acess-vpn-with-wireguard-firezone
   ```

1. Edit the `variables.tf` file, specifying the properties of the resources you are deploying:

   * In the `domain` section, specify your domain name (second and first-level, separated with a period) for the Firezone and Keycloak VMs. In this example, we use `example.com` as domain.
   * In the `folder_id` section, specify the ID of the folder to host your resources, such as `b1grj7grr1kn********`.
   * In the `vpc_id` section, specify the ID of the cloud network to host your resources, such as `enp48c1ndilt********`.
   * In the `trusted_ip_for_mgmt` section, list public IPs/subnets to allow SSH connections to the Firezone and Keycloak VMs from, e.g., `["A.A.A.A/32", "B.B.B.0/24"]`.
   * In the `admin_email` section, enter the admin email address (username) to access the Firezone admin web interface, e.g., `admin@example.com`.
   * In the `email` section enter the user email address to add to Firezone after successful authentication in Keycloak, e.g., `user@example.com`.
   * You can leave other properties unchanged or edit them as you see fit, except `image_folder_id` and `image_name`.

   {% note warning %}

      The values set in the file are intended for deploying resource-intensive infrastructures.
      Check whether your cloud quotas allow you to deploy your resources.

   {% endnote %}

   {% cut "See reference information about the amount of resources" %}

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

     1. Go to the `main` directory:

         ```bash
         cd main
         ```

     1. Initialize Terraform:

         ```bash
         terraform init
         ```

     1. Check the list of cloud resources you are about to create:

         ```bash
         terraform plan
         ```

     1. Create the resources:

         ```bash
         terraform apply
         ```
         Wait for the process to complete. It may take up to 30 minutes to process a request for a Let's Encrypt certificate. 

     1. When it is over, the command line will output the URL addresses for connection to the Firezone and Keycloak web interfaces, as well as the Firezone and Keycloak admin credentials. Later on, you can view this information by running the `terraform output` command.

         ```bash
         Outputs:

         firezone_admin_credentials = <sensitive>
         firezone_url = "https://vpn.example.com"
         keycloak_admin_credentials = <sensitive>
         keycloak_url = "https://kc.example.com:8443/admin"
         ```

         To get the `sensitive` value, specify the parameter name in the `terraform output` command, such as:

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

  1. After you deploy the Firezone and Keycloak VMs, go to the `keycloak-config` directory to set up Keycloak for intergration with Firezone and single sign-on.

      ```bash
      cd ../keycloak-config
      ```

  1. Initialize Terraform:

      ```bash
      terraform init
      ```

  1. Check the list of cloud resources you are about to create:

      ```bash
      terraform plan
      ```

  1. Create the resources:

      ```bash
      terraform apply
      ```

  1. Once the `terraform apply` process is complete, the command line will show information for Firezone and Keycloak integration setup and test user credentials to test SSO in Keycloak and connect to the VPN. Later on, you can view this information by running the `terraform output` command.

      ```bash
      Outputs:

      keycloak_config_for_firezone = <sensitive>
      test_user_credentials = <sensitive>
      ```

      To output the `sensitive` value, specify it in the `terraform output` command.

{% endlist %}

## Configure Firezone {#configure-firezone}

1. In your browser, go to `https://firezone_url`, where `firezone_url` is the `terraform output firezone_url` command output in the `main` directory (in our case, it is `https://vpn.example.com`).
1. Log in to the Firezone admin interface using the admin credentials from the `terraform output firezone_admin_credentials` command output in the `main` directory.
1. Go to the **SETTINGS / Defaults** section to change the default values.
1. In the **Allowed IPs** field, specify the cloud subnet IP addresses (as a comma-separated list of subnet IPs/masks) for VPN clients to route traffic to a VPN tunnel, e.g.: `192.168.1.0/24, 192.168.2.0/24`.
1. In the **DNS Servers** field, specify the DNS server addresses to be used by the VPN clients, e.g.: `192.168.1.2, 192.168.2.2`.
   If these DNS addresses are not to be reassigned on the client side, delete information in this field. 
1. You can also change the default properties for the VPN client `keepalive` interval and `MTU` size. The default `MTU` is 1280 bytes; you can increase it to 1440 bytes.
1. Click **Save** to apply the settings.
1. Go to the **SETTINGS / Security** section to change the security settings.
1. Disable the **Allow unprivileged device configuration** setting so that the users cannot change the VPN client network settings through the Firezone user web interface.
1. Activate the **Auto disable VPN** setting. This will allow disabling a user's VPN connections when the user is removed in the identity provider (in this case, Keycloak).
1. Click **Add OpenID Connect Provider** to add Keycloak.
1. In the **OIDC Configuration** section, fill in the following fields:
   - **Config ID**: `keycloak`.
   - **Label**: `Keycloak`.
   - **OIDC scopes**: `openid email profile offline_access`.
   - **Client ID**: `firezone`.
   - **Client secret**: `client_secret` from the `terraform output keycloak_config_for_firezone` output in the `keycloak-config` directory (specify the value without quotes).
   - **Discovery Document URI**: `discovery_document_uri` from the `terraform output keycloak_config_for_firezone` output in the `keycloak-config` directory (specify the value without quotes).
   - **Redirect URI**: Leave blank.
   - Enable **Auto-create users** to automatically add users to Firezone after their successful authentication in Keycloak.
1. Click **Save** in the **OIDC Configuration** section to apply the settings.

## Test Firezone {#test-firezone}

1. Install the [WireGuard client](https://www.wireguard.com/install/) from the WireGuard website on your device.

    For further steps to set up the WireGuard client, we will use Windows as an example. For other operating systems, the names of UI elements may differ.

1. In your browser, go to `https://firezone_url`, where `firezone_url` is the `terraform output firezone_url` command output in the `main` directory. If you have an active admin session in the Firezone web interface, **Log Out** first. Click **Sign in with Keycloak**. You will be redirected to the Keycloak web page for single sign-on.
1. Log in using the test user credentials from the `terraform output test_user_credentials` command output in the `keycloak-config` directory.
1. After successful authentication in the Firezone web interface as the test user, add a device to establish a VPN connection from. To do this, click **Add Device**.
1. In the window that opens, you can change the device name and add its description. Click **Generate Configuration**.
1. This will open a window with the device's VPN configuration. Click **Download WireGuard Configuration** to download the configuration file. You can also use the WireGuard app for Android or iOS to scan a QR code from this page to add a VPN tunnel.

   {% note warning %}

      Do not close the window until you download the configuration file or scan the QR code. You will not be able to view the device's VPN configuration in the Firezone web interface once you close the window.

   {% endnote %}

1. Add a new VPN tunnel (**Import tunnel(s) from file**) in the WireGuard app using the configuration file you downloaded.
1. Click **Activate** to activate the tunnel.  
1. Use `ping 192.168.1.1` in the command line on your device to check whether the gateway is accessible from the `firezone` cloud subnet. You are now connected to the cloud infrastructure through the VPN tunnel.

   ```bash
   Pinging 192.168.1.1 with 32 bytes of data:
   Reply from 192.168.1.1: bytes=32 time=67ms TTL=53
   ```

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

  1. On your workstation, go to the `keycloak-config` directory and run the `terraform destroy` command.
  1. Next, go to the `main` directory and run `terraform destroy` again.

{% endlist %}