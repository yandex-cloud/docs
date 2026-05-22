1. In your browser, open the main website address: `https://<website_domain>`, where `<website_domain>` is the main website subdomain or the DNS zone domain, if no subdomain has been provided.
1. In your browser, open the admin dashboard address: `https://<website_domain>/wp-admin`.
1. Log in to the admin dashboard using:
   * **Username**: Admin username you provided when installing the application.
   * **Password**: Admin password. If you did not specify a secret containing the admin password in the application settings, you can find the password value in the secret that was generated automatically during the installation. The secret name is `wp-admin-password-secret`.

      {% note info %}

      If you forget the password, you can recover it via the standard WordPress password reset form using the admin email address specified during installation.

      {% endnote %}

Once you log in, you will be redirected to the WordPress admin dashboard page where you can start managing your website.