1. Get the {{ mpg-name }} cluster host names (you will need them when installing Joomla):

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder with the cluster. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
      1. Select the `joomla-pg-cluster` cluster and open the **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}** tab.
      1. Hover over the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** field in the row with each host and click ![Copy](../../../_assets/console-icons/copy.svg) to copy the host FQDN. Save the values you copied, as you will need them later.

    {% endlist %}

1. Install and configure Joomla:

    1. Open the Joomla setup wizard in your browser. At this step, you can access it using any of these addresses:

        * `http://<VM_public_IP_address>`
        * `http://<your_domain_name>`
        * `https://<your_domain_name>`
    1. When configuring database parameters, fill in the following fields:

        * **Database type**: `{{ PG }} (PDO)`.
        * **Host name**:

            ```text
            <host_1_name>,<host_2_name>,<host_3_name>
            ```

            Where `<host_1_name>`, `<host_2_name>`, and `<host_3_name>` are the {{ mpg-name }} cluster host FQDNs you copied at the previous step.
        * **Database username**: `joomla`.
        * **Database user password**: DB user password set when creating the {{ PG }} cluster.
        * **Database name**: `joomla_db`.
        * **Connection encryption**: Keep the default value.
    1. Joomla may prompt you to create or delete a specific test file in the product installation directory on the VM for security purposes. Navigate to the `/var/www/html/installation/` directory and create or delete the specified file there:

        ```text
        You are trying to connect to a database host that is not available on 
        your local server. You need to verify ownership of the hosting 
        account. Read the information provided on the **Secure 
        installation procedure** page.

        To verify your ownership of the website, delete 
        `_JoomlazUZKusLnD2jXi********.txt` from the `installation` directory and click 
        **Install Joomla** to continue.
        ```
1. After installation is complete, delete the `installation` directory from the VM. This is a Joomla security requirement:

    ```bash
    sudo rm -rf /var/www/html/installation
    ```

If you encounter any issues while installing Joomla, use [this guide](https://docs.joomla.org/J4.x:Installing_Joomla) on the project website.