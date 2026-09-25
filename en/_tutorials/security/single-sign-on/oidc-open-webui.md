# Creating an OIDC application in {{ org-full-name }} for integration with Open WebUI


[Open WebUI](https://openwebui.com/) is a free open-source platform that provides an easy way to work with large language models and can be deployed in your own infrastructure. Open WebUI supports [OpenID Connect](https://en.wikipedia.org/wiki/OpenID#OpenID_Connect_(OIDC)) (OIDC) authentication to provide secure SSO for your organization's users.

For your [organization's](../../../organization/concepts/organization.md) users to be able to authenticate to Open WebUI via OpenID Connect SSO, create an [OIDC app](../../../organization/concepts/applications/oidc.md) in {{ org-full-name }} and configure it both in {{ org-full-name }} and Open WebUI.

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

{% note info %}

This guide deploys Open WebUI on a {{ compute-full-name }} [VM instance](../../../compute/concepts/vm.md) as an example scenario to demonstrate the integration.

{% endnote %}

To provide your organization's users with access to Open WebUI:

1. [Get your cloud ready](#before-you-begin).
1. [Create and configure an OIDC app](#create-app).
1. [Deploy your Open WebUI instance](#deploy-open-webui).
1. [Set up integration on the Open WebUI side](#setup-integration).
1. [Add a user](#add-user).
1. [Make sure the application works correctly](#validate).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}


### Set up your environment {#prepare}

1. [Create](../../../vpc/operations/network-create.md) a cloud network with a [subnet](../../../vpc/operations/subnet-create.md) in the same [availability zone](*availability_zone) where you want to deploy your Open WebUI instance.
1. [Reserve](../../../vpc/operations/get-static-ip.md) a static public IP address in the availability zone where you will deploy your Open WebUI instance.
1. In your cloud network, create a security group that allows the following traffic:

    | Traffic<br/>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} |
    | --- | --- | --- | --- | --- | --- |
    | Inbound | `80` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` | `http`           |
    | Inbound | `8080` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` | `8080`           |
    | Inbound | `443`   | `TCP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` | `https`            |
    | Inbound | `22`   | `TCP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` | `ssh`            |
    | Outbound | `All` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` | `any`           |
1. [Create](../../../compute/operations/vm-create/create-linux-vm.md) a VM from the [Ubuntu 24.04 LTS](/marketplace/products/yc/ubuntu-2404-lts-oslogin) public image.

    {% note info %}

    When creating the VM instance, select the availability zone where your subnet resides, and assign the previously reserved public IP address and security group you created.
    
    We recommend using a VM configuration with at least 8 GB of RAM.

    {% endnote %}


### Required paid resources {#paid-resources}

The cost of supporting the infrastructure created in the guide includes:
* Fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../../compute/pricing.md)).
* Fee for using a static public IP address (see [{{ vpc-full-name }} pricing](../../../vpc/pricing.md)).


## Create an app {#create-app}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Go to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. In the top-right corner, click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** and in the window that opens:
        1. Select the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.oauth-title_uUs4x }}** single sign-on method.
        1. {% include [org-oidc-app-select-web-type-step](../../../_tutorials/_tutorials_includes/org-oidc-app-select-web-type-step.md) %}
        1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify a name for your new app: `open-webui-oidc-app`.
        1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-folder_rANM4 }}** field, select the folder where you want to create an OAuth client for your app.
        1. Optionally, in the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** field, enter a description for the new app.
        1. Optionally, add [labels](../../../resource-manager/concepts/labels.md):

            1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Add a label in `key: value` format.
            1. Press **Enter**.
        1. Click **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

{% endlist %}

### Get the application’s credentials {#get-credentials}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the OIDC app.
  1. On the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, copy the parameter values you need to specify in Open WebUI:

        * `{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}`: Unique application ID.
        * `{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}`: URL with the configuration of all parameters required to set up the integration.

  1. {% include [oidc-generate-secret](../../../_includes/organization/oidc-generate-secret.md) %}

{% endlist %}


### Configure the redirect URI {#setup-redirect}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, navigate to ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select `open-webui-oidc-app`.
  1. At the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:
      1. In the **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** field, specify the authentication endpoint for your Open WebUI instance:

          ```text
          https://<server_address>/oauth/oidc/callback
          ```

          Where `<server_address>` is your previously reserved static public IP address.
          
          
          {% note info %}

          If there is a domain name reserved for the Open WebUI instance, use this domain name as the server address.

          {% endnote %}

      1. {% include [org-oidc-app-disable-pkce](../../../_tutorials/_tutorials_includes/org-oidc-app-disable-pkce.md) %}
      1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}


## Deploy your Open WebUI instance {#deploy-open-webui}

In this tutorial, you will deploy your Open WebUI instance on a {{ compute-name }} VM instance using a [Docker](https://www.docker.com/) container.

To deploy Open WebUI:

1. Connect to the VM instance you [created earlier](#prepare). Depending on your VM settings, you can connect to it via [SSH](../../../compute/operations/vm-connect/ssh.md) or [{{ oslogin }}](../../../compute/operations/vm-connect/os-login.md).
1. Install and configure Docker:

    ```bash
    sudo apt update && sudo apt install docker.io docker-compose
    ```
1. Add the current local user to the `docker` group and start a new shell process with the updated user group membership:

    ```bash
    sudo usermod -aG docker $USER
    newgrp docker
    ```
1. Create a directory for your Open WebUI project:

    ```bash
    mkdir -p ~/projects/open-webui/certs
    cd ~/projects/open-webui/certs
    ```
1. Create a self-signed TLS certificate for your Open WebUI instance:

    {% note info %}

    A TLS certificate is required to enable `https` access to Open WebUI. When configuring OIDC app settings in {{ org-full-name }}, you must use the `https://` schema in the `Redirect URI`.

    {% endnote %}

    1. Generate a private key:

        ```bash
        openssl genrsa -out server.key 2048
        ```
    1. Create a self-signed certificate valid for one year:

        ```bash
        openssl req \
          -new \
          -x509 \
          -key server.key \
          -out server.crt \
          -days 365
        ```

        Fill out the form that appears. In the `Common Name (e.g. server FQDN or YOUR name)` field, specify the [previously reserved](#prepare) static public IP address you assigned to the VM instance.
1. For convenience, rename the files you got:

    ```bash
    mv server.crt nginx-cert.crt
    mv server.key nginx-cert.key
    ```
1. Go to the Open WebUI project directory and create its configuration files:

    ```bash
    cd ~/projects/open-webui
    touch nginx.conf
    touch docker-compose.yml
    ```
1. Configure the Docker container environment for the initial launch of Open WebUI:

    {% note info %}

    You must perform the initial launch with SSO authentication disabled. This is required to create the project administrator account.

    {% endnote %}

    1. In a text editor, open the `docker-compose.yml` file:

        ```bash
        nano docker-compose.yml
        ```
    1. Add the following configuration to the `docker-compose.yml` file:

        ```yml
        version: '3.8'

        services:
          open-webui:
            image: ghcr.io/open-webui/open-webui:main
            container_name: open-webui
            environment:
              - WEBUI_BASE_URL=http://<VM_IP_address>
            ports:
              - "8080:8080"
            volumes:
              - open-webui-data:/app/backend/data
            restart: unless-stopped

        volumes:
          open-webui-data:
        ```

        Where `WEBUI_BASE_URL` is the static public IP address of your VM instance with the `http://` schema.
1. In the `~/projects/open-webui` directory, run this command:

    ```bash
    docker-compose up -d
    ```

    Wait for all components and dependencies to download, unpack, and for the container to start:

    ```text
    Creating network "open-webui_default" with the default driver
    Creating volume "open-webui_open-webui-data" with default driver
    Pulling open-webui (ghcr.io/open-webui/open-webui:main)...
    main: Pulling from open-webui/open-webui
    4f4f********: Pull complete
    a8ac********: Pull complete
    ...
    Digest: sha256:5c0d8f6d58ea276204b927205e43850689799f25420a67079cb988df********
    Status: Downloaded newer image for ghcr.io/open-webui/open-webui:main
    Creating open-webui ... done
    ```
1. Make sure the container is running:

    ```bash
    docker ps
    ```

    If everything is configured correctly, the command output should show the `open-webui` container with the `Up (healthy)` status.

    {% note info %}

    Depending on your VM instance configuration, starting the container may take a few minutes.

    {% endnote %}

1. Create an Open WebUI administrator account:

    1. In your browser, open the address of your Open WebUI instance:

        ```text
        http://<VM_IP_address>:8080
        ```
    1. On the Open WebUI page that opens, click **Get started →**.
    1. In the form that appears, enter the administrator’s full name, email address (login), and password.
    1. Click **Create Admin Account**.
    1. Close the browser window.
1. In the VM terminal, stop the Open WebUI container:

    ```bash
    docker-compose down
    ```
1. Set up your [nginx](https://nginx.org) configuration that will run inside the container:

    1. In a text editor, open the `nginx.conf` configuration file:

        ```bash
        nano nginx.conf
        ```
    1. Add the following configuration to the `nginx.conf` file:

        ```json
        server {
            listen 80;
            server_name <server_address>;
            return 301 https://$host$request_uri;
        }

        server {
            listen 443 ssl;
            server_name <server_address>;

            ssl_certificate     /etc/nginx/ssl/cert.crt;
            ssl_certificate_key /etc/nginx/ssl/key.key;

            location / {
                proxy_pass http://open-webui:8080;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto $scheme;
                proxy_set_header X-Forwarded-Port $server_port;

                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "upgrade";
                proxy_buffering off;
            }
        }
        ```

        Where `server_name` (in both sections) is the static public IP address of your VM instance. If there is a domain name reserved for the Open WebUI instance, use this domain name as the server address.
1. Update the Docker container configuration:

    1. In a text editor, open the `docker-compose.yml` file:

        ```bash
        nano docker-compose.yml
        ```
    1. Replace the `docker-compose.yml` contents with the following configuration, specifying your {{ org-full-name }} OIDC application settings:

        ```yml
        version: '3.8'

        services:
          open-webui:
            image: ghcr.io/open-webui/open-webui:main
            container_name: open-webui
            environment:
              - WEBUI_BASE_URL=https://<server_address>
              - ENABLE_OAUTH_SIGNUP=true
              - ENABLE_LOGIN_FORM=true
              - ENABLE_PERSISTENT_CONFIG=true
              - ENABLE_OAUTH_PERSISTENT_CONFIG=true
              - OPENID_REDIRECT_URI=https://<server_address>/oauth/oidc/callback
              - OAUTH_CLIENT_ID=<client_ID_value>
              - OAUTH_CLIENT_SECRET=<client_secret_value>
              - OPENID_PROVIDER_URL=<OpenID_Configuration_value>
              - OAUTH_PROVIDER_NAME={{ org-full-name }}
              - OAUTH_SCOPES=openid email profile

            ports:
              - "8080:8080"
            volumes:
              - open-webui-data:/app/backend/data
            networks:
              - webui-net
            restart: unless-stopped

          nginx:
            image: nginx:alpine
            container_name: nginx-webui
            volumes:
              - ./certs/nginx-cert.crt:/etc/nginx/ssl/cert.crt:ro
              - ./certs/nginx-cert.key:/etc/nginx/ssl/key.key:ro
              - ./nginx.conf:/etc/nginx/conf.d/default.conf:ro
            ports:
              - "443:443"
              - "80:80"
            depends_on:
              - open-webui
            networks:
              - webui-net
            restart: unless-stopped

        volumes:
          open-webui-data:

        networks:
          webui-net:
            driver: bridge
        ```

        Where:
        
        * `WEBUI_BASE_URL`: Static public IP address of your VM instance with the `https://` schema.

            If there is a domain name reserved for the Open WebUI instance, use this domain name as the server address.
        * `OPENID_REDIRECT_URI`: `Redirect URI` for your Open WebUI instance. It also includes the static public IP address of your VM instance or the domain name, if one is reserved for the Open WebUI instance.
        * `OAUTH_CLIENT_ID`: `{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}` of your {{ org-full-name }} OIDC application.
        * `OAUTH_CLIENT_SECRET`: {{ org-full-name }} OIDC app secret.
        * `OPENID_PROVIDER_URL`: `{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}` of your {{ org-full-name }} OIDC application.
1. In the `~/projects/open-webui` directory, restart the configuration:

    ```bash
    docker-compose up -d
    ```

    Wait for all components and dependencies to download, unpack, and for the containers to start.
1. Make sure the containers are running:

    ```bash
    docker ps
    ```

    If everything is configured correctly, the command output should show both the `nginx` and `open-webui` containers with an `Up` or `Healthy` status.

    {% note info %}

    Depending on your VM instance configuration, starting the containers may take a few minutes.

    {% endnote %}

## Set up the integration on the Open WebUI side {#setup-integration}.

Complete the Open WebUI setup in the user interface:

1. In a browser window, open the address of your Open WebUI instance:

    ```text
    https://<server_address>
    ```
1. On the login page, enter the administrator's email address and password, then click **Sign in**.
1. In the bottom-left corner, click your profile icon, select **Settings**, and navigate to **Authentication**.
1. In the **Default User Role** field, select `user`.
1. Make sure the **OAuth / OIDC** option is enabled and the following fields contain the correct data:

    * **Provider Name**: `{{ org-full-name }}`.
    * **Provider URL**: `{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}` value from your {{ org-full-name }} OIDC application.
    * **Client ID**: `{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}` value from your {{ org-full-name }} OIDC application.
    * **Client Secret**: {{ org-full-name }} OIDC app secret.
    * **Redirect URI**: `Redirect URI` value from your Open WebUI instance.

    If needed, populate these fields with the values you previously specified for the environment variables in `docker-compose.yml`.
1. Configure the additional fields as follows:

    * **Scopes**: `openid email profile`.
    * **Email Claim**: `email`.
    * **Username Claim**: `preferred_username`.
    * **Sub Claim**: `sub`.
1. Enable the **OAuth Signup** and **Merge Accounts by Email** options.
1. Leave all other settings unchanged and click **Save**.


## Add a user {#add-user}

For your organization's users to be able to authenticate in Open WebUI with {{ org-full-name }}'s OIDC app, you need to explicitly add these users and/or [user groups](../../../organization/concepts/groups.md) to the OIDC application.

{% note info %}

Users and groups added to an OIDC application can be managed by any user with the `organization-manager.oidcApplications.userAdmin` [role](../../../organization/security/index.md#organization-manager-oidcApplications-userAdmin) or higher.

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

{% endlist %}

{% include [auth-policy-applications-tip](../../../_includes/organization/auth-policy-applications-tip.md) %}

## Make sure your application works correctly {#validate}

To make sure both your OIDC app and Open WebUI integration work correctly, authenticate to Open WebUI as one of the users you added to the app.

Follow these steps:

1. In your browser, navigate to your Open WebUI instance address:

    ```text
    https://<server_address>
    ```
1. If you were logged in to Open WebUI, log out.
1. On the Open WebUI login page, click **Continue with {{ org-full-name }}**.
1. On the {{ yandex-cloud }} authentication page, enter the {{ org-full-name }} user's email and password. The user or group they belong to must be added to the application.
1. Make sure you have successfully authenticated in Open WebUI.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete](../../../compute/operations/vm-control/vm-delete.md) the VM.
1. [Delete](../../../vpc/operations/address-delete.md) the static public IP address.
1. If required, delete your other {{ vpc-name }} resources:

    1. [Security group](../../../vpc/operations/security-group-delete.md).
    1. [Subnet](../../../vpc/operations/subnet-delete.md).
    1. [Cloud network](../../../vpc/operations/network-delete.md).

[*availability_zone]: {% include [before-you-begin](../../../_popups/availability-zone.md) %}
