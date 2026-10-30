# Activate {{ ai-studio-name }}

To use [{{ ai-studio-name }}](../../concepts/components/ai-studio.md), enable {{ objstorage-name }}, {{ model-gallery-name }}, and {{ agent-atelier-name }}.

## Getting started {#before-you-begin}

1. Make sure the {{ model-gallery-name }} and {{ agent-atelier-name }} images are available in the registry used by the cluster. If the required images are not in the local registry, [upload them](install-images.md).
1. Make sure the cluster meets the [infrastructure requirements](../../concepts/components/ai-studio.md#infrastructure) for the selected models.
1. Make sure [{{ nvidia }} GPU support is enabled](../../concepts/components/gpu.md#enable) for the GPU worker nodes when deploying the cluster. Wait until {{ gpu-operator }} is ready.
1. Make sure [{{ ai-studio-name }} dependencies](../../concepts/components/ai-studio.md#dependencies) are enabled. If {{ objstorage-name }} is disabled, enable it in the existing `StorageConfig` resource:

   ```bash
   kubectl patch storageconfig main --type=merge -p '{"spec":{"enabled":true}}'
   ```

   Wait for the storage to get ready. Check the installation status using the `kubectl get componentinstallation storage-main` command: the `PHASE` field should turn `Ready`.

## Enabling {{ model-gallery-name }} {#enable-model-gallery}

{% note info %}

{{ model-gallery-name }} installation may take more than an hour due to the large size of the model images. Consider this when planning the installation and wait until {{ model-gallery-name }} is ready before enabling {{ agent-atelier-name }}:

{% endnote %}

1. Save [this configuration example](../../concepts/components/ai-studio.md#model-gallery-configuration) to the `modelgalleryconfig.yaml` file.
1. Configure the models and resources. The example includes Embeddings, Ethics, and YandexGPT 5 Lite, which require one A100 80 GB and two H100 80 GB GPUs. Before enabling other models, make sure additional GPUs, CPUs, RAM, and disk space are available.
1. Compare the `nodeSelector` values with the cluster node labels:

   ```bash
   kubectl get nodes -L nvidia.com/gpu.product
   ```

1. Apply the manifest:

   ```bash
   kubectl apply -f modelgalleryconfig.yaml
   ```

1. Check the installation status:

   ```bash
   kubectl get componentinstallation model-gallery-main
   ```

   Wait for the `PHASE` field to turn `Ready`. If an error occurs, check the `MESSAGE` field in the command output.

## Enabling {{ agent-atelier-name }} {#enable-agent-atelier}

1. Save [this configuration example](../../concepts/components/ai-studio.md#agent-atelier-configuration) to the `agentatelierconfig.yaml` file.
1. If you do not need Code Interpreter, set `spec.settings.codeInterpreter.enabled: false`. To use it, make sure {{ certificate-manager-name }} is on and allocate [resources for sessions](../../concepts/components/ai-studio.md#code-interpreter-resources).
1. Apply the manifest:

   ```bash
   kubectl apply -f agentatelierconfig.yaml
   ```

1. Check the installation status:

   ```bash
   kubectl get componentinstallation agent-atelier-main
   ```

   Wait for the `PHASE` installation field to turn `Ready`.

## Opening the web UI {#open-ui}

Once the installation is complete, the {{ ai-studio-name }} web UI will be available at `https://aistudio.sys.<cluster_domain>`. Use the {{ iam-name }} credentials to log in.

## Updating settings {#configure}

To change the models, resources, or Code Interpreter settings, edit the relevant resource:

```bash
kubectl edit modelgalleryconfig main
kubectl edit agentatelierconfig main
```

For descriptions of settings, see [Configuration](../../concepts/components/ai-studio.md#configuration).

## What's next {#whats-next}

* [{#T}](disable.md)
* [{{ ai-studio-name }}](../../concepts/components/ai-studio.md)
