# {{ sf-full-name }} release notes

## April 2024 {#april-2024}

### Updates {#updates}

* Added support for [allocating RAM for the `/tmp` directory](operations/function/allocate-memory-tmp.md) for the function version with at least 1 GB of memory.

### Fixes and improvements {#fixes-improvements}

* Fixed the `yandex_function_scaling_policy` import error in {{ TF }}.
* Removed the [user network](concepts/networking#user-network) requirement to have a subnet in the `ru-central1-c` availability zone as [this zone is discontinued](../overview/concepts/ru-central1-c-deprecation).

## March 2024 {#march-2024}

### Updates {#updates}

* Added support for editing all trigger parameters in {{ TF }}.
* Released [{{ objstorage-full-name }} bucket mounting](concepts/mounting.md) to a function for [general availability](../overview/concepts/launch-stages.md).

### Fixes and improvements {#fixes-improvements}

* Increased the maximum batch size in a [{{ message-queue-full-name }} trigger](concepts/trigger/ymq-trigger.md) to 1,000 messages.

## January–February 2024 {#jan-feb-2024}

### Updates {#updates}

* Added support for [mounting {{ objstorage-full-name }} buckets](concepts/mounting.md) to a function via the CLI and {{ TF }}.
* Added support for function logging settings in {{ TF }}.

### Fixes and improvements {#fixes-improvements}

* Fixed the error encountered when displaying the quota for the number of function tags.
