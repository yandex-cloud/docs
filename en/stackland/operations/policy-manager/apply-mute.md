# Deactivating a policy

{{ stackland-name }} allows you to disable notifications for a policy you select for a specified period of time or forever using a `ClusterPolicyMute` resource. To get the list of cluster policies, run this command: `kubectl get ClusterPolicy`.

## Using the CLI {#cli}

To deactivate a policy:

1. Create a file of the `ClusterPolicyMute` resource, e.g., using the `touch clusterpolicymute.yaml` command.
1. Open the file and paste the configuration below:

    {% cut "Temporarily deactivating a policy for a pod" %}

    The `stackland-disallow-host-path` policy will be deactivated until `"2026-01-20T12:00:00Z"` for `debug-pod` in the `prod` project. Reason for deactivation: "Access to host paths is required to diagnose an issue in a production environment. This restriction must be temporarily disabled for debugging." Deactivation was initiated by the user with the `devops@example.com` email address.

    {% include notitle [YAML-file](../../_includes/yamls/operations/policy-manager/apply-mute-pod.md) %}

    {% endcut %}

    {% cut "Deactivating a policy using a regular expression" %}

    The `stackland-disallow-capabilities` policy will be deactivated until `"2026-02-01T00:00:00Z"` for all pods in the `stage` project whose names match the `temp-.*` regular expression. Reason for deactivation: "Deactivating a policy for testing on stage." Deactivation was initiated by the user with the `qa-team@example.com` email address.

    {% include notitle [YAML-file](../../_includes/yamls/operations/policy-manager/apply-mute-regexp.md) %}

    {% endcut %}

    {% cut "Deactivating a policy forever" %}

    The `stackland-disallow-host-path` policy will be dectivated forever for the deployment object named `legacy-storage-deployment` in the `data-storage` project. Reason for deactivation: "To work properly, the legacy storage system requires access to host paths. The policy must be disabled to ensure compatibility and proper operation of the application." Deactivation was initiated by the user with the `security@example.com` email address.

    {% include notitle [YAML-file](../../_includes/yamls/operations/policy-manager/apply-mute-known.md) %}

    {% endcut %}

1. Apply the manifest: `kubectl apply -f clusterpolicymute.yaml`.

## Using the management console {#console}

1. In the left-hand menu, select **Security policies**.
1. Go to the **Mutes** tab.
1. Click **Create mute**.
1. Fill out the fields as follows:

    * **Name**: Mute name. Only use lowercase letters, numbers, and hyphens.
    * **Engine**: Select one from the list of available engines.
    * **Policy**: Select a policy to deactivate notifications for.
    * **Resource type**: Select a Kubernetes resource type, e.g., Pod or Deployment.
    * **Resource name**: Specify a resource name or use a pattern to apply the mute to multiple resources.
    * **Project**: Select the project the resource resides in. You can use a pattern to apply the mute to multiple projects.
    * **Reason**: Reason for deactivation.
    * **Expires**: Select the mute duration:
        * **Day**: Mute notifications for one day.
        * **Week**: Mute notifications for one week.
        * **Month**: Mute notifications for one month.
        * **Custom date**: Specify a date and time to end the mute.
        * **No expiration**: Check this flag to permanently deactivate the policy.

1. Click **Create**.

This is it. The policy breach notifications have been disabled, temporarily or forever.
