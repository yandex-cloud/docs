# Sending notifications to mailboxes in your domain

{% note warning %}

Only the company admin can configure sending notifications to external email addresses.

{% endnote %}

By default, {{ tracker-name }} sends notifications to user addresses in Yandex 360. You can configure Yandex 360 so that all email addressed to your organization&apos;s mailboxes in Yandex 360 are forwarded to mailboxes in your own domain. However, it doesn&apos;t matter which mail service you use — after configuring, you can continue using it.

To configure email forwarding for mailboxes hosted on your domain, connect the domain to your company. To do this:

1. Log in to [Yandex 360]({{ link-connect }}) with an administrator account.

1. Go to the [Yandex 360 main page]({{ link-connect-main }}), find the Webmaster card, and click **Add domain**.

1. Enter the name of your domain (such as `example.org`) and click **Add**.

1. [Confirm]({{ support-connect-domains }}) domain ownership, but do not delegate it to Yandex servers.

1. Wait for your domain to be verified and click **Make this the primary domain**. Now all emails sent to your organization's mailbox in Yandex 360 will be forwarded to the mailbox hosted on your domain.

1. Make sure that your domain&apos;s MX records continue to point to the mail servers you are using.

    {% cut "How to view the MX-record" %}

    1. Go to the dig utility website [http://www.ip-ping.ru/dig/?host=&rt=3&server=](http://www.ip-ping.ru/dig/?host=&rt=3&server=) or [http://www.digwebinterface.com/?hostnames=&type=MX&ns=resolver&useresolver=8.8.4.4&nameservers=](http://www.digwebinterface.com/?hostnames=&type=CNAME&ns=resolver&useresolver=8.8.4.4&nameservers=).

    1. Enter the name of your domain (such as `yourdomain.tld`) in the **Site address:** or **Hostnames or IP addresses:** field.

    1. Select **MX** in the drop-down list and click **Request** or **Dig**.

    {% endcut %}

1. [Create]({{ support-connect-account }}) user accounts in Yandex 360 so that user logins in Yandex 360 match the names of the mailboxes on your mail service.

    {% note tip %}

    Set up [Lost email collection]({{ support-connect-services }}) in case you make a mistake when creating employee accounts. Then create a mailbox with the same name on your mail service.

    {% endnote %}

1. If you aren't planning to use the Yandex mail service for your company, disable it:
    - Go to the [Yandex 360 main page]({{ link-connect-main }}) and on the Mail card click ![](../../_assets/tracker/icon-settings.png).
    - Click **Disable** in the upper-right corner of the Mail settings page.

