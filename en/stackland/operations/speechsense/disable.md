# Disabling {{ speechsense-name }}

You can disable the {{ speechsense-name }} component in a {{ stackland-name }} cluster. If you do so, the controller will automatically delete all the component's resources.

## Disabling a component {#disable}

1. Create the `speechsense-disable.yaml` manifest file:

    {% include notitle [YAML-file](../../_includes/yamls/operations/speechsense/disable-speechsense.md) %}

1. Apply the manifest:

    ```bash
    kubectl apply -f speechsense-disable.yaml
    ```

1. Make sure the resources were deleted:

    ```bash
    kubectl get pods -n stackland-speechsense
    ```

    The command should not be returning any pods.

The controller will automatically delete the following:

* Helm release named `stackland-speechsense`.
* Database clusters, if not used by other components.
* Secrets and certificates.

{% note warning %}

PVCs with the database data are retained to make recovery possible. For complete deletion, delete the PVCs manually:

```bash
kubectl delete pvc --all -n stackland-speechsense
```

{% endnote %}

## What's next {#whats-next}

* [{#T}](configure.md): Re-enabling {{ speechsense-name }}.
* [{{ speechsense-name }}](../../concepts/components/speechsense.md): Component description.
