# Recovery policy

When creating an instance group, you can choose how instances that fail a [health](../../instance-groups/autohealing.md#auto-healthcheck) check or an [application health](../../instance-groups/autohealing.md#functional-healthcheck) check will be recovered.

You can set the recovery policy in the `auto_healing_policy` key in the YAML file.

You can manage recovery policies using the [CLI](../../../../cli/quickstart.md).

Here is how a YAML file entry may look like:

```yaml
...
auto_healing_policy:
  auto_healing_action: RESTART
...
```

Where:

| Key | Value |
--- | ---
| `auto_healing_action` | Action to perform for an instance's recovery. Three types of actions are available:<ul><li>`RESTART`: Restart a failed instance.</li><li>`RECREATE`: In the event of a failure, the original instance is deleted and a new one is deployed instead.<br/>Recreating VM instances may be helpful if the data they store is not critical and the software needs to be deployed again.</li><li>`NONE`: Disable recovery for group instances.<br/>Select this option if you need to recover an instance manually or retrieve data from it to perform diagnostics.</li></ul> The default value is `RESTART`. |

If you do not set the recovery policy, the VM instances will be [auto-healed](../../instance-groups/autohealing.md#healthcheck-cases) depending on the [deployment policy](deploy-policy.md) settings.

#### See also {#see-also}

* [{#T}](scale-policy.md)
* [{#T}](allocation-policy.md)
* [{#T}](deploy-policy.md)
