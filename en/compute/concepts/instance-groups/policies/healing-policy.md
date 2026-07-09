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

Key | Value
--- | ---
`auto_healing_action` | Instance recovery action. There are three types of actions:<ul><li>`RESTART`: On failure, the instance will be restarted.</li><li>`RECREATE`: On failure, the original instance will be deleted with a new one deployed in its place.<br/>Recreation may be helpful if the data is irrelevant, and the software needs to be redeployed.</li><li>`NONE`: Disables recovery for the group's instances.<br/>Use if you need to recover the instance manually or retrieve its data for diagnostics.</li></ul> The default value is `RESTART`.

If you do not set the recovery policy, the VM instances will be [auto-healed](../../instance-groups/autohealing.md#healthcheck-cases) depending on the [deployment policy](deploy-policy.md) settings.

#### Useful links {#see-also}

* [{#T}](scale-policy.md)
* [{#T}](allocation-policy.md)
* [{#T}](deploy-policy.md)
