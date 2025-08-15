## Release as of 11/01/2022 {#110122}

1. Added new computing resource configurations:
   * g2.mig (1 MIG NVIDIA Ampere A100)
   * g2.2 (2 GPU NVIDIA Ampere A100)
   * g2.4 (4 GPU NVIDIA Ampere A100)
1. Updated the introductory <q>Welcome</q> notebooks in Russian and English.
1. Fixed bugs and added minor improvements.

## Release as of 18/11/2021 {#181121}

1. You can now resize project storage.
1. You can now set usage limits on individual folders and projects to manage your costs.
1. Projects now take less time to open.
1. Fixed bugs and added minor improvements.

## Release as of 24/09/2021 {#240921}

1. You can now connect to an S3 object storage from the interface.
1. Added rapid model deployment from Python code cells.

## Release as of 16/02/2021 {#160221}

Added a new state save mode: **Autosave Commit Mode**.

## Release as of 10/02/2021 {#100221}

1. Revised the state serialization approach. The old mode has changed to become a bit more intuitive. You can now enable the **autosave** mode.
1. Added GPU usage indicator.
1. Added the option to contact support directly from the service interface.

## Release as of 24/12/2020 {#241220}

1. Introduced Early Access Version, a new operating mode for {{ ml-platform-name }}.

    **Early Access Version** is a pre-release version of the system designed to showcase key upcoming features.

    {% note info %}

    **How to use**

    **Early Access Version** applies to the entire project. To enable this mode, select **File** in the project menu and then select **Enable Early Access Version**.
    You can revert to regular mode anytime by clicking **File** in your project menu and selecting **Disable Early Access Version**.

    **Where to view**

    See our new notebook for details on what's new in the release and how you can best use it: **What's new in Early Access?**.

    {% endnote %}

1. Added memory and CPU usage indicators in {{ ml-platform-name }}: the notebook interface now shows CPU core and memory usage.
1. Added TensorBoard support.
1. Implemented asynchronous background execution of operations in specially designated cells.

## Release as of 08/12/2020 {#081220}

Added the introductory **Welcome** notebook (in Russian). It explains how the service works and how you can quickly get started.

## Release as of 23/11/2020 {#231120}

1. Fixed code completion.
1. Added `widgets` support.

## Release as of 11/11/2020 {#111120}

1. Implemented support for TensorFlow 2.x.
1. Implemented support for updating pre-installed libraries, such as TensorFlow.
1. Improved the algorithm for detecting changed variables: now only the actually changed variables are included in commits, which decreases the time needed to save the state.
1. Added a snippet to work with the SPARK cluster.

## Release as of 01/10/2020 {#011020}

1. {{ ml-platform-full-name }} has become a paid generally available (GA) feature.

    Per-second billing applies, so you pay only for compute time. Using notebooks is free of charge.
    Pricing is based on a billing unit. One billing unit equals the cost of using one CPU core for one second.

    The number of units and the cost depend on the computing resource configuration.

1. Added bash command support.

    The `%%bash` command is still not available directly, but you can use its functionality as follows:
    * Specify `#!S:bash` in the cell headers (`S` indicates the type of VM to run bash on).

    Limitations:
    * Background jobs, such as `sshd`, are not supported.
    * `pip` is not supported. As before, this command is only available via `magic`.

1. Full-featured integration with Apache Spark™ is now available. You can run compute operations on the existing {{ dataproc-name }} clusters or even create temporary {{ dataproc-name }} clusters directly from {{ ml-platform-name }}.
1. Added support for versioning and checkpoints.
1. Added new configuration types: `M` (8 cores, 0 GPU) and `XL` (32 cores, 4 NVIDIA V100 GPUs).
