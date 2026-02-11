# Using an OIDC app and OAuth2 Proxy to set up single sign-on for applications that do not support SSO

{% include [note-preview](../../../_includes/note-preview.md) %}

Some applications have no built-in support for [single sign-on](https://en.wikipedia.org/wiki/Single_sign-on) (SSO). However, you may sometimes need to configure user authentication in such applications using {{ org-full-name }}.

In this guide, you will use the [OAuth2 Proxy](https://oauth2-proxy.github.io/oauth2-proxy/) utility combined with a reverse proxy to integrate a simple application with {{ org-full-name }} and restrict access to it exclusively to specified {{ org-name }} users via [OpenID Connect](https://en.wikipedia.org/wiki/OpenID#OpenID_Connect_(OIDC)) (OIDC)-based single sign-on.

This guide uses [nginx](https://nginx.org/en/) as the proxy server and a static HTML page as the test application. To enable your {{ org-name }} users to access the test application, you will create and configure an [OIDC app](../../../organization/concepts/applications.md#oidc). Additionally, you will need a {{ compute-full-name }} [VM instance](../../../compute/concepts/vm.md) to run `nginx` and `OAuth2 Proxy` and host your test application. Furthermore, to implement secure access to the test application, you will need a domain name and an SSL certificate issued for it.

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

To configure application access for your {{ org-name }} users, do the following:

1. [Create and configure an OIDC app in {{ org-name }}](#setup-oidc-app).
1. [Configure the test application VM](#setup-server).
1. [Set up the integration](#setup-integration).
1. [Make sure your integration works correctly](#validate).

## Creating and configuring an OIDC app in {{ org-name }} {#setup-oidc-app}

### Creating an OIDC app {#create-app}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. In the top-right corner, click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** and in the window that opens:

      1. Select the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.oauth-title_uUs4x }}** single sign-on method.
      1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify a name for your new app: `website-oidc-app`.
      1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-folder_rANM4 }}** field, select the folder where you want to create an OAuth client for your app.
      1. Optionally, in the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** field, enter a description for the new app.
      1. Optionally, add [labels](../../../resource-manager/concepts/labels.md):

          1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
          1. Enter a label in `key: value` format.
          1. Press **Enter**.
      1. Click **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.
  1. In the window that opens, on the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, copy and save the `{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}` value representing the unique OAuth client ID. You will need this value later when setting up `OAuth2 Proxy`.
  1. Create an [app secret](../../../organization/concepts/applications.md#oidc-secret):
  
      {% include [oidc-generate-secret](../../../_includes/organization/oidc-generate-secret.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Create an OAuth client:

      ```bash
      yc iam oauth-client create \
        --name website-oauth-client \
        --scopes openid,email,profile
      ```

      Where:

      * `--name`: OAuth client name.
      * `--scopes`: User attributes that will be provided to `OAuth2 Proxy`. The specified attributes are:
          * `openid`: User ID. Required attribute.
          * `email`: User email address.
          * `profile`: Additional user details, such as first name, last name, and avatar.

      Result:

      ```text
      id: ajeiu3otac08********
      name: website-oauth-client
      scopes:
        - email
        - openid
        - profile
      folder_id: b1gkd6dks6i1********
      status: ACTIVE
      ```

      Save the app ClientID (the `id` field value): you will need it to create a secret and configure `OAuth2 Proxy`.

  1. Create a secret for your OAuth client using the ID you obtained in the previous step:

      ```bash
      yc iam oauth-client-secret create \
        --oauth-client-id <OAuth_client_ID>
      ```

      Result:

      ```text
      oauth_client_secret:
        id: ajeohit7l3t6********
        oauth_client_id: ajeiu3otac08********
        masked_secret: yccs__460c4ca204****
        created_at: "2026-01-22T08:51:27.263668671Z"
      secret_value: yccs__4d2243a25b501220ee2a6f********************************e76e64e797_07911bfb
      ```

      Save the `secret_value` field value: you will need it to configure `OAuth2 Proxy`.

  1. Create an OIDC app:

      ```bash
      yc organization-manager idp application oauth application create \
        --organization-id <organization_ID> \
        --name website-oidc-app \
        --description "OIDC app to configure {{ org-name }} user access to the website" \
        --client-id <OAuth_client_ID> \
        --authorized-scopes openid,email,profile \
        --group-distribution-type none
      ```

      Where:

      * `--organization-id`: [ID of the organization](../../../organization/operations/organization-get-id.md) you want to create your OIDC app in. This is a required parameter.
      * `--name`: OIDC app name. This is a required parameter.
      * `--description`: OIDC app description. This is an optional parameter.
      * `--client-id`: OAuth client ID you got in Step 2. This is a required parameter.
      * `--authorized-scopes`: Specify the same attributes as when creating the OAuth client.
      * `--group-distribution-type`: Set to `none` as user groups are not provided to `OAuth2 Proxy`.

      Result:

      ```text
      done (2s)
      id: ek0odpetc1o4********
      name: website-oidc-app
      organization_id: bpf2c65rqcl8********
      description: OIDC app to configure {{ org-name }} user access to the website
      group_claims_settings:
        group_distribution_type: NONE
      client_grant:
        client_id: ajeiu3otac08********
        authorized_scopes:
          - openid
          - email
          - profile
      status: ACTIVE
      created_at: "2026-01-22T08:53:26.873089Z"
      updated_at: "2026-01-22T08:53:27.439690Z"
      ```

{% endlist %}

### Configure the redirect URI {#setup-redirect}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the OIDC app.
  1. At the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:
      1. In the **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** field, specify the authentication endpoint for your test application:

         ```text
         https://<your_domain>/oauth2/callback
         ```

         Where `<your_domain>` is your test application domain, e.g., `example.com`.
      1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Update your OAuth client by providing the redirect URI:

  ```bash
  yc iam oauth-client update \
    --id <OAuth_client_ID> \
    --redirect-uris "https://<your_domain>/oauth2/callback"
  ```

  Where:
  
  * `<OAuth_client_ID>`: OAuth client ID you got when you created it.
  * `--redirect-uris`: Authentication endpoint for your test application. For example: `https://example.com/oauth2/callback`.

  Result:

  ```text
    id: ajeiu3otac08********
    name: website-oauth-client
    redirect_uris:
      - https://example.com/oauth2/callback
    scopes:
      - email
      - openid
      - profile
    folder_id: b1gkd6dks6i1********
    status: ACTIVE
  ```

{% endlist %}

### Add a user {#add-user}

For your {{ org-name }} users to be able to authenticate in the test application over the OIDC protocol, you need to explicitly add these users and/or [user groups to this OIDC application](../../../organization/concepts/groups.md).

{% note info %}

Users and groups added to an OIDC application can be managed by a user with the `organization-manager.oidcApplications.userAdmin` [role](../../../organization/security/index.md#organization-manager-oidcApplications-userAdmin) or higher.

{% endnote %}

Add a user to the application:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the required app.
    1. Navigate to the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}** tab.
    1. Click ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
    1. In the window that opens, select the required user or user group.
    1. Click **{{ ui-key.yacloud.common.add }}**.

- CLI {#cli}

  1. Get the [user ID](../../../organization/operations/users-get.md) or [user group ID](../../../organization/operations/group-get-id.md).
  1. To add a user or user group to the application, run this command:
   
      ```bash
      yc organization-manager idp application oauth application add-assignments \
        --id <app_ID> \
        --subject-id <user_or_group_ID>
      ```
  
      Where:
  
      * `--id`: OIDC app ID.
      * `--subject-id`: User or user group ID.
  
      Result:
  
      ```text
      done (2s)
      assignment_deltas:
        - action: ADD
          assignment:
            subject_id: aje0j5mts02t********
      ```

{% endlist %}

## Configure the test application VM {#setup-server}

In this guide, you will deploy the test application and configure `nginx` and `OAuth2 Proxy` on a VM instance running [Ubuntu 24.04](/marketplace/products/yc/ubuntu-2404-lts-oslogin).

{% note warning %}

To configure access to your existing application, repeat the setup on the server handling requests from your application's users. This way, you do not need to create a separate VM instance and can proceed directly to [configuring](#setup-nginx) `nginx` and `OAuth2 Proxy`.

{% endnote %}

### Set up your {{ yandex-cloud }} environment {#prepare-env}

Before creating the VM, ensure that your folder contains a [cloud network](../../../vpc/concepts/network.md) and a [subnet](../../../vpc/concepts/network.md#subnet). If needed, follow the guides below to create them:

* [{#T}](../../../vpc/operations/network-create.md)
* [{#T}](../../../vpc/operations/subnet-create.md)

Also, in your cloud network, [create](../../../vpc/operations/security-group-create.md) a security group that allows inbound TCP traffic on ports `22`, `80`, and `443` as well as any outbound traffic.

### Create a VM {#create-vm}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. In the list of services, [select](../../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}** and click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, in the **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** field, type `Ubuntu 24.04 LTS` and select a public [Ubuntu 24.04 LTS](/marketplace/products/yc/ubuntu-24-04-lts) image.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the same [availability zone](../../../overview/concepts/geo-scope.md) as that of your subnet.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, select the `2 {{ ui-key.yacloud.component.compute.resources.field_cores }} 4 {{ ui-key.yacloud.common.units.label_gigabyte }} {{ ui-key.yacloud.component.compute.resources.field_memory }}` configuration.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select your network and subnet in your new VM's availability zone.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, leave the `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` value to assign the VM a random public IP address from the {{ yandex-cloud }} pool.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** field, select the security group you created [earlier](#prepare-env).
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

      * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter a username, e.g., `yc-user`. Do not use `root` or other reserved usernames. To perform operations requiring root privileges, use the `sudo` command.
      * {% include [access-ssh-key](../../../_includes/compute/create/access-ssh-key.md) %}
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `my-nginx-vm`.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- CLI {#cli}

  To create a VM instance, run this command:

  ```bash
    yc compute instance create \
      --name my-nginx-vm \
      --zone <VM_availability_zone> \
      --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2404-lts,auto-delete=true \
      --ssh-key <path_to_public_SSH_key> \
      --network-interface subnet-name=<subnet_name>,nat-ip-version=ipv4,security-group-ids=<security_group_ID>
  ```

  Where:
  * `--name`: VM name. Follow these naming requirements:

    {% include [name-format](../../../_includes/name-format.md) %}

  * `--zone`: [Availability zone](../../../overview/concepts/geo-scope.md) you are creating the VM in.
  * `--ssh-key`: Path to the [public SSH key](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file, e.g., `~/.ssh/id_ed25519.pub`. The VM will automatically create a user named `yc-user` for this key.
  * `subnet-name`: ID of the subnet in the same folder and availability zone as the new VM.
  * `<security_group_ID>`: ID of the security group you created [earlier](#prepare-env).

  {% cut "Result" %}

  ```text
  done (29s)
  id: epdvqa1rtvjj********
  folder_id: b1gt6g8ht345********
  created_at: "2026-01-22T12:03:52Z"
  name: my-nginx-vm
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
    device_name: epdbi403v2or********
    auto_delete: true
    disk_id: epdbi403v2or********
  network_interfaces:
    - index: "0"
      mac_address: d0:0d:1f:d2:83:be
      subnet_id: e2lqsms4cdl3********
      primary_v4_address:
        address: 192.168.2.31
        one_to_one_nat:
          address: 89.169.***.***
          ip_version: IPV4
      security_group_ids:
        - enp378h7n0cm********
  serial_port_settings:
    ssh_authorization: OS_LOGIN
  gpu_settings: {}
  fqdn: epdvqa1rtvjj********.auto.internal
  scheduling_policy: {}
  network_settings:
    type: STANDARD
  placement_policy: {}
  hardware_generation:
    legacy_features:
      pci_topology: PCI_TOPOLOGY_V2
  application: {}
  ```

  {% endcut %}

{% endlist %}

## Set up the integration {#setup-integration}

### Creating a test app and configuring nginx {#setup-nginx}

1. Ensure your domain has a resource [A record](../../../dns/concepts/resource-record.md#a) pointing to the [public IP address](../../../vpc/concepts/address.md#public-addresses) of your new VM. If no such record exists, create one.

    {% note info %}

    If management of your domain is delegated to [{{ dns-full-name }}](../../../dns/index.yaml), follow [this guide](../../../dns/operations/resource-record-create.md) to create the resource record. If your domain is managed by a third-party provider, refer to their documentation or contact their support team.

    {% endnote %}
1. [Connect over SSH](../../../compute/operations/vm-connect/ssh.md) to the new VM.
1. Install `nginx`:

    ```bash
    sudo apt update && sudo apt upgrade -y
    sudo apt install nginx -y
    ```
1. Create the test application files:

    1. Save your domain name to an environment variable:

        ```bash
        export MY_DOMAIN="<domain_name>"
        ```

        Where `<domain_name>` is your domain name with a resource record pointing to the public IP address of the current VM, e.g., `example.com`.
    1. Create a directory and the main HTML page for your test application:

        ```bash
        sudo mkdir /var/www/$MY_DOMAIN
        sudo touch /var/www/$MY_DOMAIN/index.html \
          && echo "<h1>Your Web application that is available to your {{ org-name }} users only</h1>" | sudo tee -a /var/www/$MY_DOMAIN/index.html
        ```
1. Generate a self-signed SSL certificate for your domain. To do this, run the command and enter values as prompted:

    ```bash
    sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/my-private.key -out /etc/ssl/certs/my-certificate.crt
    ```

    This will create a self-signed SSL certificate sufficient for testing the proposed solution.

    {% note tip %}

    To avoid browser security warnings when using the application, use an SSL certificate issued by a trusted certificate authority.
    
    For example, to obtain a certificate from Let's Encrypt and save both the certificate and private key to your computer, follow these guides: [{#T}](../../../certificate-manager/operations/managed/cert-create.md) and [{#T}](../../../certificate-manager/operations/managed/cert-get-content.md).

    {% endnote %}

1. Configure the `nginx` settings:

    1. In the `nano` text editor, open the `nginx` configuration file:

        ```bash
        sudo nano /etc/nginx/conf.d/default.conf
        ```

    1. Replace the opened file contents with this text:

        ```text
        server {
            listen 80;
            listen [::]:80;
            server_name <domain_name>;

            return 301 https://$server_name$request_uri;
        }

        server {
            listen 443 ssl;
            listen [::]:443 ssl;
            server_name <domain_name>;

            location /oauth2/ {
                proxy_pass       http://127.0.0.1:4180;
                proxy_set_header Host                    $host;
                proxy_set_header X-Real-IP               $remote_addr;
                proxy_set_header X-Auth-Request-Redirect $request_uri;
                # or, if you are handling multiple domains:
                # proxy_set_header X-Auth-Request-Redirect $scheme://$host$request_uri;
            }
          
            location = /oauth2/auth {
                proxy_pass       http://127.0.0.1:4180;
                proxy_set_header Host             $host;
                proxy_set_header X-Real-IP        $remote_addr;
                proxy_set_header X-Forwarded-Uri  $request_uri;
                # nginx auth_request includes headers but not body
                proxy_set_header Content-Length   "";
                proxy_pass_request_body           off;
            }

            # Paths to your certificate and key
            ssl_certificate /etc/ssl/certs/my-certificate.crt;
            ssl_certificate_key /etc/ssl/private/my-private.key;

            # Recommended security settings
            ssl_protocols TLSv1.2 TLSv1.3;
            ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384;
            ssl_prefer_server_ciphers on;

            access_log /var/log/nginx/$server_name.access.log;
            error_log /var/log/nginx/$server_name.error.log;

            location / {

                auth_request /oauth2/auth;
                error_page 401 =403 /oauth2/sign_in;

                # pass information via X-User and X-Email headers to backend,
                # requires running with --set-xauthrequest flag
                auth_request_set $user   $upstream_http_x_auth_request_user;
                auth_request_set $email  $upstream_http_x_auth_request_email;
                proxy_set_header X-User  $user;
                proxy_set_header X-Email $email;

                root /var/www/$server_name/;
                index index.html;

                try_files $uri $uri/ =404;
            }

        }
        ```

        Where `<domain_name>` is your domain name with a resource record pointing to the public IP address of the current VM, e.g., `example.com`.

        {% note warning %}

        If you are using a certificate issued by a certificate authority, copy the certificate and private key files to the VM and specify their local paths in the `ssl_certificate` and `ssl_certificate_key` fields of the configuration file, respectively.

        {% endnote %}
1. Apply the updated `nginx` settings:

    ```bash
    sudo nginx -s reload
    ```

### Configuring OAuth2 Proxy {#setup-oauth2-proxy}

1. [Connect over SSH](../../../compute/operations/vm-connect/ssh.md) to the new VM.
1. [Install](https://oauth2-proxy.github.io/oauth2-proxy/installation) the latest version of `OAuth2 Proxy` in any way you prefer.

    In the example below, we download an archive containing the executable. At the time of writing this guide, the latest version was `v7.14.2`.

    ```bash
    sudo wget https://github.com/oauth2-proxy/oauth2-proxy/releases/download/v7.14.2/oauth2-proxy-v7.14.2.linux-amd64.tar.gz
    sudo tar -xvf oauth2-proxy-v7.14.2.linux-amd64.tar.gz -C /usr/bin/
    sudo chmod +x /usr/bin/oauth2-proxy-v7.14.2.linux-amd64/oauth2-proxy
    sudo rm oauth2-proxy-v7.14.2.linux-amd64.tar.gz
    ```
1. Configure the `OAuth2 Proxy` settings:

    1. Generate a cookie secret required for configuring the utility:

        ```bash
        dd if=/dev/urandom bs=32 count=1 2>/dev/null | base64 | tr -d -- '\n' | tr -- '+/' '-_' ; echo
        ```

        Save the generated value, as you will need it later.
    1. In the `nano` text editor, open the `oauth2-proxy.cfg` configuration file:

        ```bash
        sudo nano /usr/bin/oauth2-proxy-v7.14.2.linux-amd64/oauth2-proxy.cfg
        ```
    1. Paste the following configuration into `oauth2-proxy.cfg`, substituting its values as required:

        ```text
        provider = "oidc"  # Provider type
        provider_display_name = "Yandex Identity Hub" # Provider name to use as button text
        reverse_proxy = true # Enable operation behind nginx
        client_id = "<ClientID_ID>" # OIDC app ClientID 
        client_secret = "<ClientID_app_secret>" # OIDC app secret
        oidc_issuer_url = "https://{{ auth-main-host }}"
        cookie_name = "_oauth2_proxy" # Cookie name
        cookie_secret = "<cookie_secret>"  # Cookie key generated previously
        email_domains = [ "<domain_1>","<domain_2>",...,"<domain_n>" ]  # Domains for which authentication is allowed
        upstreams = [ "<your_application_address>" ]  # Backend application address
        http_address = "127.0.0.1:4180"  # Address and port on which oauth2-proxy listens
        redirect_url = "<redirect_URI>"  # Callback URL
        ```

        Where:

        * `client_id`: `ClientID` value of the OAuth client obtained [earlier](#create-app) when creating the OIDC app.
        * `client_secret`: Secret value you generated in the OIDC app.
        * `cookie_secret`: Cookie secret you generated and saved earlier.
        * `email_domains`: List of email domains for which {{ org-name }} user authentication in the test app is allowed.

            `OAuth2 Proxy` checks the email domain specified in the `{{ ui-key.yacloud_org.page.user.field_user-email }}` field of the user's settings in {{ org-name }} (the `email` [attribute](../../../organization/concepts/applications.md#oidc-attributes)).

            In the `email_domains` field, specify the email domain of the user you previously added to your OIDC app. If you added a user group to the OIDC app, specify the email domain of a group user on whose behalf you will test authentication. You can specify multiple domains, comma-separated.

            {% note tip %}

            To allow users with [Yandex accounts](../../../iam/concepts/users/accounts.md#passport) to authenticate in your test application, add `yandex.ru` to the `email_domains` list.

            {% endnote %}

        * `upstreams`: Your application's address, e.g., `https://example.com/`.
        * `redirect_url`: `Redirect URI` value you specified when configuring the OIDC app.

1. Run `OAuth2 Proxy`:

    ```bash
    sudo /usr/bin/oauth2-proxy-v7.14.2.linux-amd64/oauth2-proxy \
      --config /usr/bin/oauth2-proxy-v7.14.2.linux-amd64/oauth2-proxy.cfg
    ```

    {% note tip %}

    You can also run `OAuth2 Proxy` in the background, e.g., using [nohup](https://en.wikipedia.org/wiki/Nohup).

    {% endnote %}

## Making sure authentication works correctly {#validate}

To check that OIDC app-based authentication works correctly in your test application, follow these steps:

1. In your browser, enter the address of your test application (e.g., `https://example.com`).

    If everything is configured correctly, you will see the `OAuth2 Proxy` authentication window in the browser.
1. Click **Sign in with {{ org-full-name }}**.
1. Authenticate as the user you previously added to the OIDC app. If you added a user group to the OIDC app, authenticate as a user belonging to that group.

    If everything is configured correctly, your test application page will open in the browser.
1. When attempting to authenticate as a user not added to the OIDC app, or as a user whose email domain is not included in the allowed email domains list configured in `OAuth2 Proxy`, your application will display an access error message.