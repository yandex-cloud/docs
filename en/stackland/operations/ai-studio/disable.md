# Disabling {{ ai-studio-name }}

To disable {{ ai-studio-name }}, disable {{ agent-atelier-name }} first, then disable {{ model-gallery-name }}.

{% note warning %}

Deactivating these components deletes {{ ai-studio-name }} component data including the contents of their buckets and persistent volumes. Re-enabling {{ ai-studio-name }} will not restore the deleted data. Make sure to save the required data and configurations outside of {{ ai-studio-name }} beforehand.

{% endnote %}

## Disabling {{ agent-atelier-name }}

1. Set `spec.enabled: false` in the existing resource:

   ```bash
   kubectl patch agentatelierconfig main --type=merge -p '{"spec":{"enabled":false}}'
   ```

1. Wait for the uninstallation to complete:

   ```bash
   kubectl wait --for=delete componentinstallation/agent-atelier-main --timeout=30m
   ```

   The deletion time depends, among other things, on the size of your data. If the command times out, check the installation status by running `kubectl get componentinstallation agent-atelier-main`. Do not disable {{ model-gallery-name }} until {{ agent-atelier-name }} is fully removed.

## Disabling {{ model-gallery-name }} {#disable-model-gallery}

1. Set `spec.enabled: false` in the existing resource:

   ```bash
   kubectl patch modelgalleryconfig main --type=merge -p '{"spec":{"enabled":false}}'
   ```

1. Wait for the uninstallation to complete:

   ```bash
   kubectl wait --for=delete componentinstallation/model-gallery-main --timeout=30m
   ```

   If required, check the installation status using the `kubectl get componentinstallation model-gallery-main` command.

Do not disable {{ objstorage-name }}, {{ iam-name }}, and {{ mpg-name }} until {{ ai-studio-name }} is fully removed. These components may still be in use by other cluster services.

## What's next {#whats-next}

* [{#T}](configure.md)
* [{{ ai-studio-name }}](../../concepts/components/ai-studio.md)
