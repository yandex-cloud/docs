# {{ ai-studio-name }}

{{ ai-studio-full-name }} is a platform for working with generative models and creating AI agents as part of {{ stackland-name }}. With {{ ai-studio-name }}, you can execute requests to language models, get embeddings, create assistants, and hook up tools to them.

{{ ai-studio-name }} modules do not form part of the standard {{ stackland-name }} package and are licensed separately.

## Composition {#architecture}

{{ ai-studio-name }} consists of two components:

* **{{ model-gallery-name }}**: Launching language models, getting embeddings, and running safety checks on queries and responses (Ethics).
* **{{ agent-atelier-name }}**: Creating and launching AI agents and assistants based on models from {{ model-gallery-name }}. Allows you to connect tools and prepare datasets. Additionally, you can enable Code Interpreter to execute code.

## Infrastructure requirements {#infrastructure}

The benchmarks listed below apply to {{ ai-studio-name }} in {{ stackland-name }} 26.3. The amount of resources depends on what models are on at the same time and the number of active sessions.

During the cluster deployment stage, [enable {{ nvidia }} GPU support](gpu.md#enable) for each worker node with a GPU.

### Minimum cluster configuration {#cluster-configuration}

The minimum cluster configuration for {{ ai-studio-name }} is designed to support simultaneous operation of one YandexGPT 5 Lite model, Embeddings, and Ethics. The table lists the resources per node.

| Node function | Quantity | CPU | RAM | Disks | GPU |
| --- | --- | --- | --- | --- | --- |
| Control plane | 3 | 8 vCPU | 16 GB | 200 GB | — |
| Worker nodes without GPU | 3 | 16 vCPU | 64 GB | 200 GB for the system and 500 GB for data | — |
| Worker node with A100 | 1 | 28 vCPU | 120 GB | 279 GB for the system and 465 GB for data | 1 × {{ nvidia }} A100 80 GB |
| Worker node with H100 | 1 | 36 vCPU | 288 GB | 279 GB for the system and 465 GB for data | 2 × {{ nvidia }} H100 80 GB |

Total: 136 vCPUs, 648 GB RAM, approximately 4.1 TB of disk space, one A100, and two H100s.

To run other models at the same time with this set, increase the cluster resources. For example, to additionally run a YandexGPT 5.1 Pro, add another node with two H100s.

### Resources not related to models {#base-services}

When planning your {{ ai-studio-name }} resources without models, aim for 24 vCPUs, 54 GB RAM, and 93 GB of persistent disk space. You need additional space in {{ objstorage-name }} for model weights and user data.

These resources are accounted for separately from model resources, Code Interpreter sessions, and other {{ stackland-name }} components. When planning, leave a margin for system processes and peak loads.

### Model resources {#model-resources}

The resources of each included model are added to the [{{ ai-studio-name }} resources not related to models](#base-services).

| Model | CPU request | RAM request | Disk space | GPU |
| --- | --- | --- | --- | --- |
| Embeddings | 8 vCPU | 12 GB | — | 1 × A100 80 GB |
| Ethics | 4 vCPU | 4 GB | — | 1 × H100 80 GB |
| YandexGPT 5 Lite | 3 vCPU | 6 GB | 100 GB | 1 × H100 80 GB |
| YandexGPT 5.1 Pro | To be determined | To be determined | 200 GB | 2 × H100 80 GB per node |
| Alice 30B | 3 vCPU | To be determined | 100 GB | 1 × H100 80 GB |
| Alice Flash | 3 vCPU | To be determined | 100 GB | 2 × H100 80 GB per node |

The CPU and RAM values ​​are provided as a [configuration example](#model-gallery-configuration). A dash means the example does not give the individual disk size. Finalize the requirements marked with _To be determined_ prior to activating the model based on your workload.

For models that require two GPUs, both of them must be on the same node.

### Examples of additional models {#additional-model-resources}

Examples of resources for Vision-Language Models (VLMs) and Optical Character Recognition (OCR) models are provided below. Their availability depends on {{ ai-studio-name }} version. The following table serves as a resource planning guide.

| Model | CPU request | RAM request | Data storage | GPU |
| --- | --- | --- | --- | --- |
| Gemma VLM | To be determined | To be determined | 100 GB disk | 1 × H100 80 GB |
| Qwen VLM | To be determined | To be determined | 100 GB disk | 2 × H100 80 GB per node |
| OCR | To be determined | 40 GB | {{ objstorage-name }} | 1 × {{ nvidia }} GPU |

Clarify the missing resource requirements prior to deployment.

### Code Interpreter {#code-interpreter-resources}

Each active Code Interpreter session additionally requires approximately 2.1 vCPUs, 4.1 GB RAM, and 5–10 GB of temporary disk space. No GPU is required. Consider the resources of all simultaneously active sessions.

## Dependencies {#dependencies}

To use {{ ai-studio-name }}, you also need the following {{ stackland-name }} components:

* [{{ objstorage-name }}](storage.md): Storage of model weights, datasets, and other files.
* [{{ mpg-name }}](postgresql.md): Metadata and service status storage.
* [{{ iam-name }}](iam.md): User authentication, service accounts, and storage access.
* [{{ gpu-operator }}](gpu.md): GPU provisioning for models.
* [{{ certificate-manager-name }}](certificate-manager.md): Issue of TLS certificates, including for Code Interpreter.
* [Disk subsystem](disk-storage.md): Creation of persistent volumes.

First, enable {{ objstorage-name }} and the other dependencies, then {{ model-gallery-name }} and {{ agent-atelier-name }}.

## Configuration {#configuration}

The components are managed via the custom `ModelGalleryConfig` and `AgentAtelierConfig` resources named `main`. Both resources operate at the cluster level; you do not need to specify a namespace. The `spec.enabled` parameter enables or disables the relevant component.

### {{ model-gallery-name }} {#model-gallery-configuration}

The example includes Embeddings, Ethics, and YandexGPT 5 Lite. The remaining language models are described but disabled. Before you enable them, add resources according to the [table](#model-resources) or disable unnecessary models.

{% include notitle [YAML-file](../../_includes/yamls/components/modelgalleryconfig.md) %}

Where:

* `settings.storageClass`: Storage class for persistent volumes. If not specified, the default storage class is used, selected during [cluster deployment](../../quickstart.md#configuration) in the `spec.cluster.storage.defaultStorageClass` field of the `StacklandClusterConfig` resource.
* `settings.embeddings.enabled`: Includes getting embeddings.
* `settings.ethics.enabled`: Includes security checks for requests and responses.
* `settings.models`: List of language models. To enable the model, set `enabled: true`; to disable, set `enabled: false`.
* `nodeSelector`: Labels of nodes you can place a pod on. The `nvidia.com/gpu.product` label values ​​must match the GPUs in your cluster.
* `affinity`: Additional pod placement rules. For example, you can [set a preferred node](#model-affinity-example) for the model.
* `resources.requests`: CPU, RAM, and GPU requests Kubernetes consults when placing a container. `resources.limits` stands for resource limits. For `nvidia.com/gpu`, specify the same values ​​in `requests` and `limits`.

For language models, use the `name` and `modelType` values from the following table:

| Model | `name` | `modelType` |
| --- | --- | --- |
| YandexGPT 5 Lite | `lite` | `yandexgpt-lite` |
| YandexGPT 5.1 Pro | `pro-5-1` | `yandexgpt-pro` |
| Alice 30B | `alice` | `yandexgpt-lite` |
| Alice Flash | `alice-flash` | `yandexgpt-lite` |

#### Affinity configuration example {#model-affinity-example}

To specify a preferred node for YandexGPT 5 Lite, replace `affinity: {}` of the `lite` model in `spec.settings.models` with the following section:

```yaml
affinity:
  nodeAffinity:
    preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 100
        preference:
          matchExpressions:
            - key: kubernetes.io/hostname
              operator: In
              values:
                - gpu1.stackland.internal
```

Replace `gpu1.stackland.internal` with the `kubernetes.io/hostname` label value of the required node. You can find out the label values ​​using the `kubectl get nodes -L kubernetes.io/hostname` command.

The rule increases the priority of the specified node during pod placement. Kubernetes can select another node that matches `nodeSelector` and has free resources. For more details on placement rules, see [this Kubernetes guide](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#node-affinity).

### {{ agent-atelier-name }} {#agent-atelier-configuration}

Configuration example with Code Interpreter enabled:

{% include notitle [YAML-file](../../_includes/yamls/components/agentatelierconfig.md) %}

Where:

* `settings.storageClass`: Storage class for persistent volumes. The default value is `stackland-other`.
* `settings.codeInterpreter.enabled`: Enables Code Interpreter. The default value is `false`.
* `settings.codeInterpreter.sessionIdleTTL`: Inactive session retention time before deletion. The default value is `2h`.
* `settings.codeInterpreter.sessionHardTTL`: Maximum session lifetime regardless of activity. The default value is `24h`.

## Useful links {#see-also}

* [{#T}](../../operations/ai-studio/install-images.md)
* [{#T}](../../operations/ai-studio/configure.md)
* [{#T}](../../operations/ai-studio/disable.md)
