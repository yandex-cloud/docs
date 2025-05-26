{% list tabs %}

- Form

  1. Select a [load generator](../../load-testing/concepts/load-generator.md).
  1. In the **Target address** and **Target port** fields, enter the address and port of the service to test.
  1. Optionally, enable **Secure connection**.
  1. In the **Testing threads** field, specify the number of testing threads.
  1. Under **Load type**:
      * Select a type.
      * Click ![image](../../_assets/plus-sign.svg) **Load profile** and add one or more server [load profiles](../../load-testing/concepts/load-profile.md).
  1. In the **{{ ui-key.yacloud.load-testing.field_settings-type }}** field, select **Attached file** as the [payload](../../load-testing/concepts/payload.md) type.
  1. Optionally, if you want to reduce the test time, set the condition to stop the test automatically in the **Autostop** menu. Click ![image](../../_assets/plus-sign.svg) **Autostop** and specify:
      * **Autostop type**: Setting that stops the test when it reaches a specified value.
      * Autostop settings.

          Each autostop type has its own settings to specify.
  1. Under **Forced test termination time**, specify the time after which the test will autostop, unless it is stopped for other reasons. Set it to be slightly greater than the expected test duration.
  1. Optionally, enable **Agent monitoring**. For more information, see [{#T}](../../load-testing/concepts/monitoring.md).
  1. Under **{{ ui-key.yacloud.load-testing.meta-section }}**, specify a test name, description, version number, and labels.

- Configuration file

  Click **Attach file** and open the configuration file on your computer. If you do not have a configuration file, run the test again or generate a configuration file based on [this config article](https://yandextank.readthedocs.io/en/latest/config_reference.html#phantom).

  {% note warning %}

  Make sure to specify the time limit for the test under `autostop` in the configuration file:

  ```yaml
  autostop:
    enabled: true
    package: yandextank.plugins.Autostop
    autostop:
      - limit (5m)
  ```

  {% endnote %}

  {% note info %}
  
  During testing, the agent automatically cleans up disk space. You can manage the size of space to release by specifying `disk_limit` under `rcheck`:

  ```yaml
  rcheck:
    enabled: true
    package: yandextank.plugins.ResourceCheck
    disk_limit: 2048
    interval: 10s
    mem_limit: 512
  ```
  
  {% endnote %}

{% endlist %}
