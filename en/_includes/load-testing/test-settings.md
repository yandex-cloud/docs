{% list tabs %}

- Form

   1. Select a [load generator](../../load-testing/concepts/load-generator.md).
   1. In the **Target address** and **Target port** fields, enter the address and port of the service to test.
   1. (Optional) Enable **Secure connection**.
   1. In the **Testing threads** field, specify the number of testing threads.
   1. Under **Load type**:
      * Select a type.
      * Click ![image](../../_assets/plus-sign.svg) **Load profile** and add one or more server [load profiles](../../load-testing/concepts/load-profile.md).
   1. In the **{{ ui-key.yacloud.load-testing.field_settings-type }}** field, select [test data](../../load-testing/concepts/payload.md) as the **Attached file** type.
   1. (Optional) If you want to reduce the test time, set the condition to stop the test automatically in the **Autostop** menu. Click ![image](../../_assets/plus-sign.svg) **Autostop** and specify:
      * **Autostop type**: Parameter whose value defines when a test is interrupted.
      * Autostop parameter values.

         Specify different sets of parameters for different autostop types.
   1. (Optional) Enable the **Agent monitoring** option. For more information, see [{#T}](../../load-testing/concepts/monitoring.md).
   1. Under **{{ ui-key.yacloud.load-testing.meta-section }}**, specify the test name, description, version number, and label.

- Configuration file

   Click **Attach file** and open the configuration file on your computer. If you do not have a configuration file, run the test again or generate a configuration file based on the [documentation](https://yandextank.readthedocs.io/en/latest/config_reference.html#phantom).

{% endlist %}
