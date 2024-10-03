OpenVPN Access Server provides two web interfaces:

1. **Client Web UI** at `https://<VM_public_IP_address>/`. This interface is used by regular users to download client applications and configuration profiles.
1. **Admin Web UI** at `https://<VM_public_IP_address>/admin/`. This interface is used to configure the server.

{% note info %}

By default, the server has a self-signed certificate installed. If you need to replace this certificate, follow the steps described [here](https://openvpn.net/vpn-server-resources/installing-a-valid-ssl-web-certificate-in-access-server/).

{% endnote %}

To create a user, log in to the admin panel:

1. In the browser, open a URL, such as `https://<VM_public_IP_address>/admin/`.
1. Enter the `openvpn` username and password (to learn how to get the admin password, see [this section](#get-admin-password)).
1. Read the license agreement of click **Agree**. This will open the home screen of the OpenVPN admin panel.
1. Go to the **User management** tab and select **User permissions**.
1. In the user list, enter a username for the new user in the **New Username** field, e.g., `test-user`.
1. Click the pencil icon in the **More Settings** column and enter a password for the new user in the **Password** field.
1. Click **Save settings**.
1. Click **Update running server**.