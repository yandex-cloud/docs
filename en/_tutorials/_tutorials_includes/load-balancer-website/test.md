1. [Get](../../../compute/operations/vm-info/get-info.md) the public IP address of any VM from the group you created.
1. [Connect](../../../compute/operations/vm-connect/ssh.md) to the VM via SSH.
1. Stop the web service to simulate a failure on the web server:

    {% list tabs %}

    - LAMP

      ```bash
      sudo service apache2 stop
      ```

    - LEMP

      ```bash
      sudo service nginx stop
      ```

    {% endlist %}

1. [Get](../../../compute/operations/vm-info/get-info.md) the listener IP address.
1. Open the website in the browser using the listener address.

    The connection should be successful, even though one of the web servers has failed.

1. When the check is complete, start the web service again:

    {% list tabs %}

    - LAMP

        ```bash
        sudo service apache2 start
        ```

    - LEMP

        ```bash
        sudo service nginx start
        ```

    {% endlist %}