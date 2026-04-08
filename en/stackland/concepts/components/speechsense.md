# {{ speechsense-name }}

{{ speechsense-full-name }} is a speech analytics platform within {{ stackland-name }}. It transcribes and analyzes audio recordings of conversations, extracts text, classifies customer interactions, and generates analytical reports.

{{ speechsense-name }} does not come with the basic {{ stackland-name }} package and requires a separate license.

## Architecture {#architecture}

{{ speechsense-name }} comprises three components:

* **YaGPT**: Handles natural language processing and text generation. It is used to create conversation summaries and classify interactions. Requires GPU resources.
* **SpeechKit**: Performs speech recognition and synthesis, converts audio files to text. Requires GPU resources.
* **SpeechSense**: Provides speech analytics, data processing, and the web UI. SpeechSense orchestrates the YaGPT and SpeechKit workflows and features a UI for managing analysis results.

## Infrastructure requirements {#infrastructure}

### GPU {#gpu-requirements}

{{ speechsense-name }} requires the following {{ nvidia }} GPU nodes:

* YaGPT Pro: 2 × {{ nvidia }} H100
* SpeechKit STT Backend: 1 × {{ nvidia }} A100
* SpeechKit Embeddings: 1 × {{ nvidia }} H100

Before installing {{ speechsense-name }}, enable the [{{ gpu-operator }}](gpu.md) component.

### Resources {#resource-requirements}

TA services operate without a GPU but require significant CPU and RAM resources. We recommend allocating at least 32 vCPUs and 64 GB RAM for TA services.

## Dependencies {#dependencies}

{{ speechsense-name }} relies on the following {{ stackland-name }} components:

* [{{ mpg-name }}](postgresql.md): Metadata and state storage.
* [{{ mch-name }}](clickhouse.md): Analytical queries and storage of large-scale data.
* [{{ mkf-name }}](kafka.md): Streaming data processing.
* [{{ objstorage-name }}](storage.md): Storage of audio files and models.
* [{{ gpu-operator }}](gpu.md): GPU resource management.
* [{{ iam-name }}](iam.md): User authentication and authorization.

When {{ speechsense-name }} is enabled, the controller automatically checks for these dependencies and provisions the required database clusters, {{ KF }} topics, and certificates.

## Configuration {#configuration}

To manage {{ speechsense-name }}, use the `SpeechsenseConfig` custom resource.

Here is an example:

{% include notitle [YAML-file](../../_includes/yamls/components/speechsenseconfig.md) %}

Where:

* `enabled`: Enables and disables the component.
* `settings.s3.endpoint`: {{ objstorage-name }} address.
* `settings.s3.accessKeyID`: Storage access key ID.
* `settings.s3.secretAccessKey`: Storage secret access key.

## See also {#see-also}

* [{#T}](../../operations/speechsense/install-images.md): Pulling {{ speechsense-name }} images.
* [{#T}](../../operations/speechsense/configure.md): Configuring and activating {{ speechsense-name }}.
* [{#T}](../../operations/speechsense/disable.md): Disabling {{ speechsense-name }}.
* [{{ gpu-operator }}](gpu.md): GPU management in a cluster.
