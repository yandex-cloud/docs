# Configuring authentication in OpenVPN Community Edition via {{ org-full-name }} over the OIDC protocol


[OpenVPN Community Edition](https://openvpn.net/community/) is a free, open-source version of OpenVPN for establishing secure VPN connections. Starting with version 2.6.2, OpenVPN Community Edition supports authentication through external providers via the [OpenID Connect](https://en.wikipedia.org/wiki/OpenID#OpenID_Connect_(OIDC)) (OIDC) protocol with the help of the [openvpn-auth-oauth2](https://github.com/jkroepke/openvpn-auth-oauth2) plugin.

For the users of your [organization](../../../organization/concepts/organization.md) to be able to authenticate to OpenVPN Community Edition via OpenID Connect SSO, create an [OIDC app](../../../organization/concepts/applications.md#oidc) and configure it both in {{ org-full-name }} and OpenVPN.

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

To set up authentication to OpenVPN Community Edition via {{ org-full-name }} for the users of your organization:

1. [Get your cloud ready](#before-begin).
1. [Create the infrastructure](#deploy).
1. [Install OpenVPN](#install-openvpn).
1. [Create a certificate authority](#create-ca).
1. [Configure an OpenVPN server](#configure-server).
1. [Create an OIDC app in {{ org-full-name }}](#create-app).
1. [Install and configure openvpn-auth-oauth2](#setup-plugin).
1. [Test the integration](#validate).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure support cost includes:

* Fee for a continuously running [VM](../../../compute/concepts/vm.md) (see [{{ compute-full-name }} pricing](../../../compute/pricing.md)).
* Fee for using an [OIDC app](../../../organization/concepts/applications.md#oidc) (see [{{ org-full-name }} pricing](../../../organization/pricing.md)).

## Create the infrastructure {#deploy}

1. [Create a VM](../../../compute/operations/vm-create/create-linux-vm.md) on Ubuntu 24.04 with a public IP address. This VM will act as an OpenVPN server.

1. Connect to the VM over SSH:

   ```bash
   ssh <username>@<VM_public_IP_address>
   ```

1. Make sure you have the following:

   * Domain name pointing to the VM's public IP address. You will need it to configure the `openvpn-auth-oauth2` plugin.
   * TLS certificate for this domain name. You can use a certificate from [{{ certificate-manager-full-name }}](../../../certificate-manager/operations/managed/cert-create.md).

## Install OpenVPN {#install-openvpn}

{% note info %}

The `openvpn-auth-oauth2` plugin is supported starting from OpenVPN 2.6.2.

{% endnote %}

1. Update your package list and install OpenVPN and Easy-RSA:

   ```bash
   sudo apt update && sudo apt install openvpn easy-rsa
   ```

1. Check the OpenVPN version:

   ```bash
   openvpn --version
   ```

   Result:

   ```text
   OpenVPN 2.6.19 x86_64-pc-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [PKCS11] [MH/PKTINFO] [AEAD] [DCO]
   library versions: OpenSSL 3.0.13 30 Jan 2024, LZO 2.10
   ...
   ```
   Make sure the version is not lower than 2.6.2.

## Create a certificate authority {#create-ca}

1. Create a folder for Easy-RSA and copy the required files into it:

   ```bash
   mkdir -p ~/openvpn-ca
   cd ~/openvpn-ca
   sudo mkdir /etc/openvpn/easy-rsa
   sudo cp -r /usr/share/easy-rsa/* /etc/openvpn/easy-rsa/
   cd /etc/openvpn/easy-rsa/
   ```

1. Initialize the public key infrastructure (PKI):

   ```bash
   sudo ./easyrsa init-pki
   ```

1. Create a root certificate authority (CA). This command will ask for a password (at least four characters) and a common name: any CA name, e.g., `YC-OpenVPN-CA`:

   ```bash
   sudo ./easyrsa build-ca
   ```

1. Generate a certificate and a server key:

   ```bash
   sudo ./easyrsa gen-req server nopass
   sudo ./easyrsa sign-req server server
   ```

   When signing the certificate, enter `yes` to confirm.

1. Generate the Diffie-Hellman parameters:

   ```bash
   sudo ./easyrsa gen-dh
   ```

## Configure an OpenVPN server {#configure-server}

### Copy the certificates and keys {#copy-certs}

Copy the necessary files to the OpenVPN working folder:

```bash
sudo cp pki/ca.crt pki/private/server.key pki/issued/server.crt /etc/openvpn/
sudo cp /etc/openvpn/easy-rsa/pki/dh.pem /etc/openvpn/
```

### Create a server configuration file {#server-config}

1. Create a file named `/etc/openvpn/server.conf`:

   ```bash
   sudo nano /etc/openvpn/server.conf
   ```

1. Add the following content to the file:

   ```text
   port 1194
   proto udp
   dev tun
   ca ca.crt
   cert server.crt
   key server.key
   dh dh.pem
   auth SHA256
   server 10.8.0.0 255.255.255.0
   ifconfig-pool-persist ipp.txt
   push "redirect-gateway def1 bypass-dhcp"
   push "dhcp-option DNS 8.8.8.8"
   push "dhcp-option DNS 8.8.4.4"
   keepalive 10 120
   cipher AES-256-GCM
   user nobody
   group nogroup
   persist-key
   persist-tun
   status openvpn-status.log
   log-append /var/log/openvpn.log
   verb 3
   ```

### Configure your network {#configure-network}

1. Enable IP forwarding:

   ```bash
   echo 'net.ipv4.ip_forward=1' | sudo tee -a /etc/sysctl.conf
   sudo sysctl -p
   ```

1. Open a port for OpenVPN in your firewall:

   ```bash
   sudo ufw allow 1194/udp
   sudo ufw allow OpenSSH
   ```

1. Configure NAT masquerading for the VPN subnet:

   ```bash
   sudo iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
   sudo iptables-save | sudo tee /etc/iptables/rules.v4
   ```

### Start the OpenVPN server {#start-server}

1. Start the OpenVPN server:

   ```bash
   sudo systemctl start openvpn@server
   sudo systemctl enable openvpn@server
   ```
1. Check the OpenVPN server status:

   ```bash
   systemctl status openvpn@server
   ```

### Create a client certificate {#client-cert}

1. Go to the Easy-RSA folder and generate a client certificate:

   ```bash
   cd /etc/openvpn/easy-rsa/
   sudo ./easyrsa gen-req client1 nopass
   sudo ./easyrsa sign-req client client1
   ```

1. Create a client configuration file named `~/client1.ovpn`:

   ```bash
   nano ~/client1.ovpn
   ```

1. Add the following content to the file by specifying the certificates and keys:

   ```text
   client
   dev tun
   proto udp
   remote <public_IP_address_or_server_domain> 1194
   resolv-retry infinite
   nobind
   persist-key
   persist-tun
   remote-cert-tls server
   auth SHA256
   cipher AES-256-GCM
   verb 3
   <ca>
   -----BEGIN CERTIFICATE-----
   # Paste the contents of /etc/openvpn/ca.crt
   -----END CERTIFICATE-----
   </ca>
   <cert>
   -----BEGIN CERTIFICATE-----
   # Paste the contents of /etc/openvpn/easy-rsa/pki/issued/client1.crt
   -----END CERTIFICATE-----
   </cert>
   <key>
   -----BEGIN PRIVATE KEY-----
   # Paste the contents of /etc/openvpn/easy-rsa/pki/private/client1.key
   -----END PRIVATE KEY-----
   </key>
   key-direction 1
   ```

## Create an OIDC app in {{ org-full-name }} {#create-app}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. In the center of the page, click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** and in the window that opens:
      1. Select the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.oauth-title_uUs4x }}** single sign-on method.
      1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify a name for the new app, e.g., `openvpn-oidc-app`.
      1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-folder_rANM4 }}** field, select the folder where you want to create an OAuth client for your app.
      1. Optionally, in the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** field, enter a description for the new app.
      1. Click **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.
  1. Click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** at the top right of the new app's page and in the window that opens:
      1. In the **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** field, enter the Redirect URI in the following format:

         ```text
         https://<domain_name>:9000/oauth2/callback
         ```

      1. In the **{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.field-scopes_hEuar }}** field, mark the `email` and `profile` attributes.
      1. Click **{{ ui-key.yacloud.common.save }}**.
  1. {% include [oidc-generate-secret](../../../_includes/organization/oidc-generate-secret.md) %}

     Save the secret value for later to configure the `openvpn-auth-oauth2` plugin.

  1. Under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, copy the **{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}** field value for later to configure the plugin.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Create an OAuth client:

     ```bash
     yc iam oauth-client create \
       --name openvpn-oauth-client \
       --scopes openid,email,profile \
       --redirect-uris "https://<domain_name>:9000/oauth2/callback"
     ```

     Where:

     * `--name`: OAuth client name.
     * `--scopes`: User attributes available to OpenVPN:
       * `openid`: User ID. Required attribute.
       * `email`: User email address.
       * `profile`: Additional user details.
     * `--redirect-uris`: Redirect URI after authentication.

     Result:

     ```text
     id: ajeqqip130i1********
     name: openvpn-oauth-client
     folder_id: b1g500m2195v********
     status: ACTIVE
     ```

     Save the `id` field value; you will need it later to create the app.

  1. Create a secret for your OAuth client:

     ```bash
     yc iam oauth-client-secret create \
       --oauth-client-id <OAuth_client_ID>
     ```

     Result:

     ```text
     oauth_client_secret:
       id: ajeq9jfrmc5t********
       oauth_client_id: ajeqqip130i1********
       masked_secret: yccs__939233b8ac****
       created_at: "2025-10-21T10:14:17.861652377Z"
     secret_value: yccs__939233b8ac********
     ```

     Save the `secret_value`; you will need it later to configure the `openvpn-auth-oauth2` plugin.

  1. Create an OIDC app:

     ```bash
     yc organization-manager idp application oauth application create \
       --organization-id <organization_ID> \
       --name openvpn-oidc-app \
       --description "OIDC application for integration with OpenVPN Community Edition" \
       --client-id <OAuth_client_ID> \
       --authorized-scopes openid,email,profile
     ```

     Where:

     * `--organization-id`: [Organization ID](../../../organization/operations/organization-get-id.md).
     * `--name`: OIDC app name.
     * `--description`: Application description. This is an optional setting.
     * `--client-id`: OAuth client ID you got in the previous step.
     * `--authorized-scopes`: Same attributes as when creating the OAuth client.

     Result:

     ```text
     id: ek0o663g4rs2********
     name: openvpn-oidc-app
     organization_id: bpf2c65rqcl8********
     client_grant:
       client_id: ajeqqip130i1********
       authorized_scopes:
         - openid
         - email
         - profile
     status: ACTIVE
     created_at: "2025-10-21T10:51:28.790866Z"
     ```

{% endlist %}

### Add users to the application {#add-users}

For the users of your organization to be able to authenticate to OpenVPN through the {{ org-full-name }} OIDC app, add the users and/or [user groups](../../../organization/concepts/groups.md) to the app.

{% note info %}

Users and groups added to an OIDC application can be managed by a user with the `organization-manager.oidcApplications.userAdmin` [role](../../../organization/security/index.md#organization-manager-oidcApplications-userAdmin) or higher.

{% endnote %}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the new app.
  1. Navigate to the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}** tab.
  1. Click ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
  1. In the window that opens, select the required user or user group.
  1. Click **{{ ui-key.yacloud.common.add }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Get the [user ID](../../../organization/operations/users-get.md) or [user group ID](../../../organization/operations/group-get-id.md).

  1. Add a user or group to the application:

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
     assignment_deltas:
       - action: ADD
         assignment:
           subject_id: ajetvnq2mil8********
     ```

{% endlist %}

## Install and configure openvpn-auth-oauth2 {#setup-plugin}

### Install the plugin {#install-plugin}

On the VM with OpenVPN, run the following commands:

```bash
curl -L https://raw.githubusercontent.com/jkroepke/openvpn-auth-oauth2/refs/heads/main/packaging/apt/openvpn-auth-oauth2.sources | sudo tee /etc/apt/sources.list.d/openvpn-auth-oauth2.sources
sudo apt update
sudo apt install openvpn-auth-oauth2
```

### Prepare a TLS certificate {#prepare-tls}

The `openvpn-auth-oauth2` plugin requires a TLS certificate to protect the connection on port `9000`.

{% note tip %}

The plugin developers [recommend](https://github.com/jkroepke/openvpn-auth-oauth2/blob/main/docs/Configuration.md#openvpn-auth-oauth2-config) not to terminate TLS connections directly in `openvpn-auth-oauth2`. Use a separate reverse proxy server instead. You can implement this approach using [{{ alb-full-name }}](../../../application-load-balancer/tutorials/tls-termination/index.md).

{% endnote %}

1. If you have a certificate in [{{ certificate-manager-full-name }}](../../../certificate-manager/), export it using the [{{ yandex-cloud }} CLI](../../../cli/):

   ```bash
   yc certificate-manager certificates content \
     --id <certificate_ID> \
     --chain tls.crt \
     --key tls.key
   ```

1. Create a folder for the plugin files and move the certificate and key into it:

   ```bash
   sudo mkdir -p /etc/openvpn-auth-oauth2
   sudo mv tls.crt tls.key /etc/openvpn-auth-oauth2/
   sudo chown root:openvpn-auth-oauth2 /etc/openvpn-auth-oauth2/tls.key
   sudo chown root:openvpn-auth-oauth2 /etc/openvpn-auth-oauth2/tls.crt
   ```

### Create a plugin configuration file {#plugin-config}

1. Create a file named `/etc/openvpn-auth-oauth2/config.yaml`:

   ```bash
   sudo nano /etc/openvpn-auth-oauth2/config.yaml
   ```

1. Add the following content to the file:

   ```yaml
   http:
     listen: :9000
     baseurl: https://<domain_name>:9000
     tls: true
     key: /etc/openvpn-auth-oauth2/tls.key
     cert: /etc/openvpn-auth-oauth2/tls.crt
     secret: <any_16_character_long_string>
   openvpn:
     addr: unix:///run/openvpn/server.sock
     password: <management_interface_password>
   oauth2:
     issuer: https://{{ auth-main-host }}
     client:
       id: <OAuth_client_ID>
       secret: <application_secret_value>
     endpoint:
       discovery: https://{{ auth-main-host }}/.well-known/openid-configuration
     scopes:
       - openid
       - profile
       - email
   ```

   Where:

   * `http.baseurl`: Plugin's public URL in `https://<domain_name>:9000` format.
   * `http.secret`: Any string of at least 16 characters for protection of sessions.
   * `openvpn.password`: Password for connecting the plugin to the OpenVPN management interface. Save this value; it must match the contents of the file named `/etc/openvpn/password.txt`.
   * `oauth2.client.id`: OAuth client ID you got when creating the OIDC app.
   * `oauth2.client.secret`: Application secret value saved when creating the OIDC app.

   For more on setup, see [this openvpn-auth-oauth2 guide](https://github.com/jkroepke/openvpn-auth-oauth2/blob/main/docs/Configuration.md).

### Configure the OpenVPN management interface {#configure-management}

1. Create a file with the management interface password:

   ```bash
   echo '<management_interface_password>' | sudo tee /etc/openvpn/password.txt
   sudo chmod 600 /etc/openvpn/password.txt
   ```

   {% note warning %}

   The password value in the `/etc/openvpn/password.txt` file must match the value of the `openvpn.password` parameter in the `/etc/openvpn-auth-oauth2/config.yaml` file.

   {% endnote %}

1. Open the `/etc/openvpn/server.conf` file and add the following lines to the end:

   ```text
   management /run/openvpn/server.sock unix /etc/openvpn/password.txt
   management-hold
   management-client-auth
   ```

1. Restart OpenVPN:

   ```bash
   sudo systemctl restart openvpn@server
   sudo systemctl status openvpn@server
   ```

1. Open port `9000` in the firewall:

   ```bash
   sudo ufw allow 9000/tcp
   ```

### Run the plugin as a system service {#start-plugin-service}

1. Create a systemd unit file:

   ```bash
   sudo nano /etc/systemd/system/openvpn-auth-oauth2.service
   ```

   Add the following content to the file:

   ```ini
   [Unit]
   Description=openvpn-auth-oauth2
   Requires=openvpn@server.service
   After=openvpn@server.service

   [Service]
   ExecStart=openvpn-auth-oauth2 --config /etc/openvpn-auth-oauth2/config.yaml
   Restart=on-failure
   User=root

   [Install]
   WantedBy=multi-user.target
   ```

1. Restart the systemd configuration, enable and start the service:

   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable openvpn-auth-oauth2.service
   sudo systemctl start openvpn-auth-oauth2.service
   sudo systemctl status openvpn-auth-oauth2.service
   ```

## Test the integration {#validate}

1. Install the [OpenVPN client](https://openvpn.net/community-downloads/) on the client device.

1. Import the `client1.ovpn` configuration file into the OpenVPN client.

1. Initiate a connection to the VPN server. The OpenVPN client will open your browser and redirect you to the {{ yandex-cloud }} authentication page.

1. Enter the credentials of the user added to the OIDC app.

1. After successful authentication, the VPN connection will be established.

1. Check your connection to the VPN server:

   ```bash
   ping 10.8.0.1
   ```

   The expected result is a successful zero packet loss ping.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete](../../../compute/operations/vm-control/vm-delete.md) the VM.
1. [Delete](../../../organization/operations/applications/oidc-deactivate-remove.md#delete) the OIDC app.