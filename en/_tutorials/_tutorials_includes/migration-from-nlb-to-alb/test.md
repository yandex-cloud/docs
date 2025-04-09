Run a test request to the service through the L7 load balancer, for example, using one of these methods:

* Add this record to the `hosts` file on your workstation: `<L7_load_balancer_public_IP_address> <service_domain_name>`. Delete the record after the test.
* Execute the request using {{ api-examples.rest.tool }} depending on the protocol type:

    ```bash
    curl http://<service_domain_name> \
        --resolve <service_domain_name>:<service_port>:<public_IP_address_of_L7_load_balancer>
    ```

    ```bash
    curl https://<service_domain_name> \
        --resolve <service_domain_name>:<service_port>:<public_IP_address_of_L7_load_balancer>
    ```
