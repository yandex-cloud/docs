## Release 11.01.2022 {#110122}

1. Added new computing resource configurations:
   * g2.mig (1 MIG NVIDIA Ampere A100)
   * g2.2 (2 GPU NVIDIA Ampere A100)
   * g2.4 (4 GPU NVIDIA Ampere A100)
1. Updated the introductory <q>Welcome</q> notebooks in Russian and English.
1. Fixed bugs, added minor improvements.

## Release 18.11.2021 {#181121}

1. Added the ability for the user to resize project storage.
1. Added the ability to set usage limits on individual folders and projects to manage costs.
1. Projects take less time to open.
1. Fixed bugs, added minor improvements.

## Release 24.09.2021{#240921}

1. Added the ability to connect to S3 object storage from the interface.
1. Added rapid model deployment from Python code cells.

## Release 16.02.2021 {#160221}

* Added a new state saving mode: **Autosave Commit Mode**.

## Release 10.02.2021 {#100221}

* Changed our approach to state serialization. The old mode has changed and become a bit more intuitive, also now you can enable **autosave** mode.
* Added GPU usage indicator.
* Added the option to contact support from the service.

## Release 24.12.2020 {#241220}

* Introduced Early Access Version: a new mode of running {{ ml-platform-name }}.

   **Early Access Version** is a pre-release version of the system where all the key new features will be announced.

   {% note info %}

   **How do I use it?**

   You can select the **Early Access Version** operating mode for your project in its entirety. To activate this mode, from the project menu, select **File** and then **Enable Early Access Version**.
   You can revert to the regular mode anytime: click **File** in your project menu and select **Disable Early Access Version**.

   **Where to view it:**

   To find out what's new in the release and how you can use it, see our new notebook: **What's new in Early Access?**.

   {% endnote %}

* Memory and CPU usage indicators added in {{ ml-platform-name }}: the CPU core and memory usage is shown directly in the notebook interface.
* TensorBoard support added.
* Implemented asynchronous background execution of operations in specially designated cells.

## Release 08.12.2020 {#081220}

* An introductory **Welcome** notebook has been released (in Russian). It explains how the service works and how you can quickly start using it.

## Release 23.11.2020 {#231120}

* Code completion fixed.
* Added support for `widgets`.

## Release 11.11.2020 {#111120}

* Implemented support for TensorFlow version 2.x.
* Implemented support for updating pre-installed libraries, such as TensorFlow.
* Improved the algorithm for detecting changed variables: now only the actually changed variables are included in commits, which decreases the time needed to save the state.
* Added a snippet to work with the SPARK cluster.

## Release 01.10.2020 {#011020}

* {{ ml-platform-full-name }} has become a paid generally available (GA) feature.

   Per-second billing is used, so you pay only for the computing time (working in the notebooks is not charged).
   A pricing unit is one billing unit. The cost of one billing unit is the cost of using 1 CPU core for 1 second.

   The number of units and cost depend on computing resource configurations.

* Added the option to use the bash command.

   The `%%bash` command is still available directly, but you can use its functionality as follows:
   * Specify `#!S:bash` in the cell headers (`S` indicates the type of VM instance to run bash on).

   Restrictions:
   * Background jobs are not supported, for example, `sshd`.
   * Launching `pip` is not supported. Continue to use `magic` for pip.

* Full-featured integration with Apache Spark™ is now available. You can compute on the existing {{ dataproc-name }} clusters or even create temporary {{ dataproc-name }} clusters from {{ ml-platform-name }} directly.
* Added versioning and support of checkpoints.
* Added new configuration types: `M` (8 cores, 0 gpu) and `XL` (32 cores, 4 gpu Nvidia v100).
