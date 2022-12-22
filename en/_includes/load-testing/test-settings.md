{% list tabs %}

- Form

   1. Select a [load generator](../../load-testing/concepts/load-generator.md).
   1. Enter the address and port of the service to test.
   1. (Optional) Enable **Secure connection**.
   1. Specify the number of testing threads.
   1. Expand the **Load schedule** menu:
      * Select a type.
      * In the **Load profile** menu, enter the server load description.
   1. In the **Request type** field, specify the type of [payloads](../../load-testing/concepts/payload.md).
   1. (Optional) If you want to reduce the test time, set the condition to stop the test automatically in the **Autostop** menu. Click ![image](../../_assets/plus-sign.svg) **Autostop** and specify:
      * **Autostop type**: A parameter whose value defines when a test is interrupted.
      * **Autostop criteria**: A parameter value.
   1. (Optional) Enable the option **Agent monitoring**. For more information, see [{#T}](../../load-testing/concepts/monitoring.md).
   1. Under **Test information**, specify the name, description, and number of the test version.

- Configuration file

   Click **Select file** and open the configuration file on your computer. If you don't have a configuration file, repeat the test or generate a configuration file based on the [documentation](https://yandextank.readthedocs.io/en/latest/config_reference.html#phantom).

{% endlist %}
