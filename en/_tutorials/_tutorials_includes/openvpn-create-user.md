OpenVPN Access Server provides two web interfaces:

1. **Client Web UI** at `https://<VM_public_IP_address>/`. This UI allows regular users to download client applications and configuration profiles.
1. **Admin Web UI** at `https://<VM_public_IP_address>/admin/`. This UI allows the administrator to configure the server.

{% note info %}

By default, the server has a self-signed certificate. If you need to replace this certificate, follow the steps [here](https://openvpn.net/vpn-server-resources/installing-a-valid-ssl-web-certificate-in-access-server/).

{% endnote %}

To create a user, log in to the admin panel:

1. In your browser, open the URL in `https://<VM_public_IP_address>/admin/` format.
1. Enter the `openvpn` username and password (see how to get the administrator password [here](#get-admin-password)).
1. Read the license agreement of click **Agree**. This will open the OpenVPN Admin Web UI home page.
1. Expand the **User management** tab and select **User permissions**.
1. In the user list, enter a username for the new user in the **New Username** field, e.g., `test-user`.
1. Click the pencil icon in the **More Settings** column and enter a password for the new user in the **Password** field.
1. Click **Save settings**.
1. Click **Update running server**.
