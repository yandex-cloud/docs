# Deleting policy presets

{{ stackland-name }} administrators can delete Policy Manager presets.

If you have added any policy presets with `ClusterPolicySet`, delete them by running this command: `kubectl delete ClusterPolicySet <resource name>`.

## How to delete default policy presets {#how-to-delete}

1. In the top-left corner, select the **System** interface. This interface is only available to administrators.
1. In the left-hand menu, select **Components**.
1. Select **Policy Manager**.
1. Go to the **YAML** tab.
1. Delete the preset list in `spec.settings.defaultPolicySet.engines.kyverno.presets`, and replace it with `[]`.
1. Click **Save**.
