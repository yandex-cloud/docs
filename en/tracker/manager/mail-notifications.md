# Sending notifications to mailboxes in your domain

{% note warning %}

Only an [administrator](../role-model.md) can set up notifications to external mailboxes.

{% endnote %}

By default, {{ tracker-name }} sends notifications to the mailbox from which the user logs in the service. If before connecting {{ tracker-name }} you set up an email domain and mailboxes for employees, now you can set up email forwarding using [{{ ya-360 }}]({{ support-business-link }}). In this case, your employees will be able to log into {{ tracker-name }} using their email addresses on your domain, as well as get notifications from {{ tracker-name }} at these addresses. No matter which email service you are running, after the setup, you will be able to continue using it.

{% note info %}

You can [set up federation](../../organization/add-federation.md) in {{ org-full-name }}. In this case, your employees will also be able to log in to {{ tracker-name }} using their email addresses on your domain, as well as get notifications from {{ tracker-name }} at these addresses.

{% endnote %}

To set up email forwarding to mailboxes on your domain, add the domain to the organization. To do this:

1. Log in to [{{ ya-360 }}]({{ link-ya-360 }}) with an administrator account.

1. Go to the [**Domains** page]({{ link-ya-360-domains }}).

1. [Add the domain and confirm it]({{ support-business-domain-main }}).

1. Wait until the domain is confirmed. If you have multiple domains added, select your default domain: click ![](../../_assets/tracker/menu.png) and select **Set as default**.

1. Make sure that the MX records of your domain are still pointing at the mail servers that you use.

    {% cut "How to view an MX record?" %}

    1. Go to the dig utility website [http://www.ip-ping.ru/dig/?host=&rt=3&server=](http://www.ip-ping.ru/dig/?host=&rt=3&server=) or [http://www.digwebinterface.com/?hostnames=&type=MX&ns=resolver&useresolver=8.8.4.4&nameservers=](http://www.digwebinterface.com/?hostnames=&amp;type=CNAME&amp;ns=resolver&amp;useresolver=8.8.4.4&amp;nameservers=).

    1. Specify your domain name (such as `yourdomain.tld`) in the **Site address:** or **Hostnames or IP addresses:** field.

    1. Select **MX** from the drop-down list and click **Query** or **Dig**.

    {% endcut %}

1. [Create]({{ support-connect-account }}) your user accounts in {{ ya-360 }} so that the usernames in {{ ya-360 }} are the same as the mailbox names on your mail server. You can also [import]({{ support-business-import }}) user mailboxes from other services.

    {% note alert %}

    You pay for using {{ ya-360 }} according to the [pricing]({{ link-ya-360-tariffs }}).

    {% endnote %}

    Now all the emails received in the user mailboxes will be forwarded to the mailboxes on your domain.

    {% note tip %}

    Set up [Collecting lost mail]({{ support-connect-services }}) in case you made an error when creating employee accounts. Then create a mailbox with the same name in your mail service.

    {% endnote %}
