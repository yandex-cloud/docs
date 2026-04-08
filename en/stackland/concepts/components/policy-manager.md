# Policy Manager

Policy Manager consolidates tools that check Kubernetes resources for compliance with policies and generate reports in the [OpenReports](https://openreports.io/docs/api/) format. You can track Policy Manager notifications in the management console under **System > Events**. The current implementation of policy compliance verification is based on [Kyverno](https://kyverno.io/).

In Policy Manager, you can choose between these two types of policy presets:

* Baseline: Preset based on the [baseline](https://kubernetes.io/docs/concepts/security/pod-security-standards/) Kubernetes security standard for pods.
* Restricted: Preset based on the [restricted](https://kubernetes.io/docs/concepts/security/pod-security-standards/#restricted) Kubernetes security standard for pods.

You can select a default cluster policy preset using the `PolicyManagerConfig` custom resource. To activate an additional preset, use the `ClusterPolicySet` resource.

## How to choose a preset {#how-to-choose}

The baseline preset is applied by default. It works best for applications whose failures or unavailability do not cause major consequences. This preset prevents known privilege abuses in container environments. It is easy-to-use and suitable for cases that do not require setting up an extensive set of policies. For the list of available policies, see [this Kubernetes guide](https://kubernetes.io/docs/concepts/security/pod-security-standards/#baseline).

The restricted preset ensures compliance with the current pod protection recommendations. It is designed for applications that are critical for security and for users with a low trust level. For the list of available policies, see [this Kubernetes guide](https://kubernetes.io/docs/concepts/security/pod-security-standards/#restricted).

To add a new preset to your cluster, see the guide on [activating policy presets](../../operations/policy-manager/apply-preset.md). To change the default preset, change the `PolicyManagerConfig` settings.

## Configuration {#configuration}

Here is an example:

{% include notitle [YAML-file](../../_includes/yamls/components/policymanagerconfig.md) %}

Where:

* `enabled`: Enables the component. Selecting `enabled: false` will delete all Policy Manager components (Controller, Kyverno, Policy Reporter, and ClusterPolicySet).
* `settings.defaultPolicySet.engines`: Sets a list of policy presets and tools to verify them.
