1. Enable the **DNS server** option.
1. In the **Domain name server** field, select the inbound DNS connection from the list or enter the IPv4 address of your own DNS server and add it to the list.
1. Optionally, to specify another DNS server, click **Add server** and select an inbound DNS connection or enter an IPv4 address. You can specify up to three DNS servers.
1. Optionally, in the **Domain name** field, specify the search domain without leading or trailing dots, e.g., `example.internal`. When resolving short names, the OS will automatically append this domain: `app` → `app.example.internal`. Make sure all specified DNS servers can resolve names within this domain.
