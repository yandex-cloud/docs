1. Open the terminal on the device whose IP address you specified in the allow rule.
1. Send a request to the test application backend:

    ```bash
    curl --verbose <public_IP_address_of_L7_load_balancer>
    ```

    This command should list the contents of the directory with your test web server.

1. Repeat the request from a different IP address. As a result, you should see a message about a failure to establish a connection to the server.

{% note info %}

Smart protection rules are usually not tested. Such tests would add the properties of suspicious requests, e.g., IP addresses, to a blacklist.

{% endnote %}