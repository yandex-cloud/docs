The instructions below describe how to configure an external DNS service using {% if region == "int" %}[reg.com](https://www.reg.com/){% else %}[reg.ru](https://www.reg.ru/){% endif %} for the `www.example.com` and `example.com` domain names:

  * An A record allows you to map the `example.com` domain name to its IP address.
  * A CNAME (Canonical Name) record  for `www` allows you to access your website via `www.example.com`.

To configure the external DNS service, do the following:

1. You can learn the IP address of the VM under **Network** on the VM page in the [management console]({{ link-console-main }}).
1. Log in to the control panel of the external DNS service. Go to the {% if region == "int" %}[list of your domains](https://www.reg.com/user/domain_list){% else %}[list of your domains](https://www.reg.ru/user/domain_list){% endif %} and click on the required domain name.
1. Follow the **Zone management** link in the **Domain management** section.
1. Create or edit an A record:
   * **IP Address**: your VM's public IP address.
   * **Subdomain**: `@` (points to the main domain).
1. Create a CNAME record with the following field values:
   * **Subdomain**: `www`.
   * **Canonical name**: `@` or the `example.com.` domain with a dot at the end.
1. Wait 15-20 minutes for DNS record changes to take effect. The waiting time may differ for your DNS service.

