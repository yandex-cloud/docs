# System requirements

To install {{ sk-hybrid-name }}, you need a Linux server with Docker Engine support. For a list of supported operating systems, see [Docker's official documentation](https://docs.docker.com/engine/install/#server).

{% note warning %}

The CPU must support the [AVX2]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/AVX){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Advanced_Vector_Extensions#CPUs_with_AVX2){% endif %} (Advanced Vector Support) instruction set.

{% endnote %}

On Linux, to check whether your host supports AVX2, run:

```bash
grep -q avx2 /proc/cpuinfo && echo AVX2 || echo No AVX2
```

## Server configuration {#hardware}

Recommended system requirements for running {{sk-hybrid-name }} containers:

{% list tabs %}

- Containers with CPU

   | Container | CPU | RAM | HDD |
   | --- | --- | --- | --- |
   | Speech recognition (40 channels) | 2 [Intel Gold 6230R]{% if lang == "ru" %}(https://ark.intel.com/content/www/ru/ru/ark/products/199346/intel-xeon-gold-6230r-processor-35-75m-cache-2-10-ghz.html){% endif %}{% if lang == "en" %}(https://ark.intel.com/content/www/us/en/ark/products/199346/intel-xeon-gold-6230r-processor-35-75m-cache-2-10-ghz.html){% endif %}) CPUs | 128 GB | 300 GB |
   | Speech synthesis (10-16 SPS^1^) | 1 Intel Gold 6230R CPU | 64 GB | 300 GB |

- Containers with GPU

   | Container | CPU | GPU | RAM | HDD |
   | --- | --- | --- | --- | --- |
   | Speech recognition (80-100 channels) | 1 [Intel Gold 6230R]{% if lang == "ru" %}(https://ark.intel.com/content/www/ru/ru/ark/products/199346/intel-xeon-gold-6230r-processor-35-75m-cache-2-10-ghz.html){% endif %}{% if lang == "en" %}(https://ark.intel.com/content/www/us/en/ark/products/199346/intel-xeon-gold-6230r-processor-35-75m-cache-2-10-ghz.html){% endif %} CPU | Nvidia Tesla V100 (16 GB or 32 GB) | 128 GB | 300 GB |
   | Speech synthesis (200 SPS^1^) | 1 Intel Gold 6230R CPU | Nvidia Tesla V100 (16 GB or 32 GB) | 128 GB | 300 GB |

{% endlist %}

^1^ Seconds per second (SPS): The number of seconds of synthesized text generated per runtime second.

## Before you start {#software}

1. {% include [cli-install](../../_includes/cli-install.md) %}

1. [Create a registry](../../container-registry/operations/registry/registry-create.md) in {{ container-registry-full-name }}.

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   ```
   yc container registry create --name speechkit-hybrid
   ```

   ```
   id: crpc9qeoft236r8tfalm
   folder_id: b1g0itj57rbjk9thrinv
   name: speechkit-hybrid
   status: ACTIVE
   created_at: "2021-08-25T12:24:56.286Z"
   ```

1. Notify the SpeechKit team of the created registry `id`. All the required containers will appear in your registry, and you will be provided `docker-compose.yaml`.

