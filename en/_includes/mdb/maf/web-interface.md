1. In the [management console]({{ link-console-main }}), open the cluster page.
1. In the **{{ ui-key.yacloud.airflow.cluster.overview.title_resource-webserver }}** field, click **{{ ui-key.yacloud.mdb.cluster.overview.label_web-server-url }}** ![start](../../../_assets/console-icons/arrow-up-right-from-square.svg).
1. Enter the authentication data in the [{{ maf-name }} web server's](../../../managed-airflow/concepts/index.md#components) web interface:

   * Login: `admin`.
   * Password: `admin` user password you set when creating the cluster.

For more information about how to use the web interface, see the [{{ AF }} documentation](https://airflow.apache.org/docs/apache-airflow/stable/ui.html).
