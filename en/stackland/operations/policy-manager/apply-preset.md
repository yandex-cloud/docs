# Activating policy preset

{{ stackland-name }} allows you to activate policy presets and apply them to cluster resources. To activate a preset, create the `ClusterPolicySet` resource.

{% note info %}

By default, the [baseline](https://kubernetes.io/docs/concepts/security/pod-security-standards/#baseline) preset is applied to the cluster.

{% endnote %}


## Using the CLI {#cli}

1. Create a file of the `ClusterPolicySet` resource, e.g., using the `touch clusterpolicyset.yaml` command.
1. Open the file and paste the configuration below into it:

    {% list tabs %}

    - Baseline

        {% include notitle [YAML-file](../../_includes/yamls/operations/policy-manager/apply-preset-baseline.md) %}

    - Restricted

        {% include notitle [YAML-file](../../_includes/yamls/operations/policy-manager/apply-preset-restricted.md) %}

    - Restricted and Baseline

        {% include notitle [YAML-file](../../_includes/yamls/operations/policy-manager/apply-preset-both.md) %}

    {% endlist %}

1. Apply the manifest: `kubectl apply -f clusterpolicyset.yaml`.

## Using the management console {#console}

1. In the left-hand menu, select **Security policies**.
1. Go to the **Settings** tab.
1. Toggle **Policy check** on.
1. Under **Kyverno**, select the policy presets:

    * **Baseline**: Basic protection against misconfiguration.
    * **Restricted**: Strict adherence to the principle of least privilege.

    You can select one or both presets at the same time.

Click **Open YAML editor** to view or edit the `ClusterPolicySet` resource configuration.

This is it. Now Policy Manager will start sending notifications about policy violations.
