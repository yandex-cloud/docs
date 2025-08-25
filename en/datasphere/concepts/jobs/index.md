# {{ ml-platform-name }} Jobs

In {{ ml-platform-name }}, you can run jobs, i.e., computations on {{ ml-platform-name }} VMs outside {{ jlab }}Lab, remotely. These can be Python scripts and projects, Bash scripts, and executable binary files compiled for Linux x86_64.

Jobs are created and run in [projects](../project.md). However, they do not depend on project notebooks and running VMs.

To use {{ ml-platform-name }} Jobs, [authenticate](../../operations/projects/authentication.md) as a user account.

Before [running a job](../../operations/projects/work-with-jobs.md), set up a Python virtual environment, install [{{ ds-cli }}](cli.md) using the `pip install datasphere` command, and prepare a configuration file describing all the parameters for running the job. You can also [install](../../../cli/quickstart.md) and configure the [{{ yandex-cloud }} CLI](../../../cli/) to use it for authentication in {{ yandex-cloud }}.

{% include [vscode-extension-info](../../../_includes/datasphere/vscode-extension-info.md) %}

You can find jobs in the **{{ ml-platform-name }} Jobs** tab of a project. Their [progress](../../operations/projects/work-with-jobs.md#progress) and results will be available under **Run history** and locally.

{% note tip %}

For long-running jobs, we recommend saving intermediate results in an S3 object storage.

{% endnote %}

## Storing job data {#data}

{{ ml-platform-name }} Jobs stores input data cache, environments, logs, job execution results, and monitoring schedules. You can reuse the data and share it across jobs in a single project. This means repeated runs of the same job will not load input data into {{ ml-platform-name }} each time but will reuse the data loaded on the first run.

The size of stored data is limited. For more information about {{ ml-platform-name }} limits, see [{#T}](../limits.md).

The default job data lifetime is 14 days. After that, all stored info will be deleted, including any logs and monitoring schedules. You can change this value using {{ ds-cli }}:

```bash
datasphere project job set-data-ttl --id <job_ID> --days <lifetime_in_days>
```

Also, you can clear stored data by clicking **{{ ui-key.yc-ui-datasphere.common.clear-cache }}** in the project jobs tab.

## Job configuration file {#config}

When creating a job, specify its parameters in the `config.yaml` file, such as the [configuration of computing resources](../configurations.md) to run the job on and required files with input data. Depending on the settings specified in the configuration file, {{ ml-platform-name }} analyzes the job, identifies dependencies, [deploys the environment](environment.md) on the VM, and runs the job code. Job execution results are saved in the {{ ml-platform-name }} project files listed in the job configuration.

```yaml
# Job name
name: simple-python-script
# Job description
desc: Program description

# Entry point parameters to run computations
cmd: >  # Multi-line YAML string
  python3 src/main.py
    --params ${PARAMS}
    --features ${<connector_ID>}/features.tsv
    --validate ${CIFAR}/val.json
    --normalizer ${DS_PROJECT_HOME}/misc/norm.bin
    --model ${MODEL}
    --epochs 5

# Files with input data
inputs:
  - misc/logging.yaml  # File path relative to the job run directory on the local computer.
  - /usr/share/params.json: # Absolute path to the file on the local computer is saved to the PARAMS variable.
      var: PARAMS

# Files with results.
outputs:
  - data/model.bin: MODEL  # Relative path to the file is saved to the MODEL variable.
  - other/metrics.png  # Relative path to the file.

# Resources required to run a job must be available in the project.
s3-mounts: # S3 connectors
  - <connector_ID>   # S3 connector ID
                           # Connector name is not set, therefore, the connector can be accessed by its ID.
datasets:
  - <dataset_ID>:  # ID of the dataset available in the project.
      var: CIFAR   # CIFAR: Variable for accessing the dataset.

# Environment parameters.
env:
  vars:  # Environment variables.
    - DEVICE_COUNT: 8    # You can specify the value of the environment variable explicitly.
    - PYTHONBUFFERED     # If the parameter is not specified, its value will be taken from the current environment.
  docker: <Docker_image_ID>  # Docker image available in the {{ ml-platform-name }} project.
  # You can also specify a Docker image in the image registry.
  # docker:
  #   image: <path_to_image_in_registry>:<tag>  # For example, <{{ registry }}/crtabcdef12345678900/myenv:0.1>.
                                              # For Docker Hub, you only need to specify `<name>:<tag>`, e.g., `ubuntu:focal`.
  #   username: <login>
  #   password: 
  #     secret-id: PASSWORD  # {{ ml-platform-name }} secret name.

  # Environment dependency build method.
  python: auto # Full environment build automation.

  # python: # Environment parameters are set manually. If no parameters are set, their values will be automatically taken from the current environment.
  # type: manual
  # version: 3.10.13 # Python version
  # pip:
  #   index-url: https://pypi.org/simple # Address of the main repository for package installation.
  #   extra-index-urls: # Addresses of additional repositories.
  #     - https://pypi.ngc.nvidia.com
  #   trusted-hosts: # List of trusted hosts.
  #     - nvidia.com
  #   no-deps: true  # The default value is `false`
  # requirements-file: requirements.txt  # File with environment parameters.
  # root-path:   # Explicit specification of additional entry points.
  #   - other.py
  # local-paths: # List of local Python files to transfer. Cannot be used together with `root-paths`.
  #  - foo.py
  #  - lib/ 

# Flags for running jobs.
flags:
  - attach-project-disk # Mount project storage.

# Computing resource configurations to run a job.
cloud-instance-types:
  - g2.1 # Priority configuration.
  - g1.1 # Second priority configuration.

# Extended working directory configuration.
working-storage:
  type: SSD    # Disk type in use. Optional, the default type is SSD. The possible values are: SSD
  size: 150Gb  # Working directory size from 100 GB to 10 TB.

# Configuring graceful shutdown.
graceful-shutdown:
  signal: SIGTERM  # Signal to be sent to the job process on pressing Ctrl + C (cancel); SIGTERM by default.
                   # The possible values are: SIGTERM, SIGINT, SIGHUP, SIGUSR1, SIGUSR2
  timeout: 15s     # Timeout after which the job process gets SIGKILL if it has not finished yet.

# List of datasets to create upon a successful job completion.
output-datasets:
  - name: job-test-dataset-1  # Dataset name.
    var: OUT_DS               # Variable containing the path to the dataset. The contents of the specified directory will be structured as a dataset.
    description: "Description"
    size: 100Gb               # Maximum dataset size.
    labels:                   # Random list of labels to assign to the dataset.
      a: b
      c: d

# Setting up a connection to a DataProc cluster via Spark Connector
spark:
  connector: <connector_ID> # Spark Connector ID
```

The `config.yaml` file has multiple sections.

1. The `name` and `description` sections specify the job name and description. The job name must be unique within the project. A description is optional and helps find the required job in the project.

1. The `cmd` section specifies the job entry point. Specify how to run your code and set all the run parameters to be provided to the executable file or script. You can use variables and IDs that will be specified in the sections below to set paths to the required files.

1. The `input` section specifies files with input data and other information you need to provide to run the job from your local computer. You can set a file path relative to the job directory or save the relative or absolute file path to a variable to use it in other sections of the configuration file.

1. The `output` section specifies files to save the computation results to. Once the job is executed, these files will appear on your PC. The file paths are specified in the same way as in `input`.

1. {{ ml-platform-name }} resources used in jobs are specified in the `s3-mounts` ([S3 connectors](../s3-connector.md)) and `datasets`([datasets](../dataset.md)) sections. To use an S3 connector or a dataset in a job, specify the ID of an available project resource and, optionally, define a variable for it. If no variable is set, resources in the `cmd` section can be accessed by their ID.

   You can also use project storage in your job. To do this, set the `attach-project-disk` flag in the `flags` section. The project storage will be mounted to the VM the job is running on as an external disk for data reads. The storage path will be available in the `DS_PROJECT_HOME` environment variable.

1. The `env` section defines environment parameters for running the job: the VM environment build method, environment variables, and, optionally, a Docker image built in {{ ml-platform-name }} or stored in a different image registry. You can specify the registry authorization credentials if required.

   There are two ways to set up the environment for your Python projects:

   * Allow {{ ml-platform-name }} to automatically identify all required dependencies, analyze the current environment on your local computer, and build and migrate the environment. To do this, specify `python: auto` in the `env` section.
   * You can specify the Python interpreter version, the relevant libraries, and other parameters yourself either directly in the configuration file or in a separate `requirements.txt` file. If you explicitly set at least one parameter, the missing ones will be fetched from the current environment automatically.

   {% note warning %}

   If you set up the environment in auto mode or specify only some of the dependencies, run your job from the Python virtual environment with all the current packages and local modules installed. This will enable the `datasphere` library to automatically identify the job runtime environment parameters.

   {% endnote %}

   You can set environment variables under `vars` in the `env` section. Project [secrets](../secrets.md) will also be added to the environment variables when running the job.

   {% include [jobs-info](../../../_includes/datasphere/jobs-environment.md) %}

   For a detailed description of the Python environment parameters, see [Job runtime environment](environment.md).

1. The `cloud-instance-types` section defines the valid [computing resource configuration](../configurations.md) types the job can run on. Configurations are specified in order of priority, i.e., if resources are available, the job will use the first configuration to run. If there are no VMs with the first configuration available, the job will try to run on the second one, then the third, and so on.

   If you only have a single configuration, you may also use the old `cloud-instance-type` field, e.g., `cloud-instance-type: g1.1`; however, it is preferable to use the new one.

1. The `working-storage` section specifies the extended working directory parameters. By default, the working directory is created on the system disk. The directory's size is not guaranteed and is usually about 20 GB. If you need more space to complete the job, you can specify this explicitly. The extended working directory can range in size from 100 GB to 10 TB.

   You pay for the extended working directory specified in the `working-storage` section according to the [data storage pricing policy](../../pricing.md#prices-jobs).

1. The `graceful-shutdown` section defines the graceful shutdown parameters. If the section is not specified, then the `SIGKILL` signal is sent to the job when the user presses **Ctrl** + **C**. In this section, you can redefine the signal itself as well as the wait time for graceful shutdown.

1. `output-dataset` describes the [datasets](../dataset.md) to create upon a successful job completion. Each dataset has a name, description, size, and a list of labels.

   Once a job is completed, a dataset creation message will appear in the `cli` [log](cli.md#logs). Here is an example:

   ```text
   2024-09-13 16:22:28,894 - [INFO] - Created datasets:
   2024-09-13 16:22:28,894 - [INFO] -   * <dataset-id> (dataset name) size: <size> Gb
   ```

1. The `spark` section describes the configuration for [operations](work-with-spark.md) with [{{ dataproc-full-name }}](../../../data-proc/) clusters through [Spark Connector](../spark-connector.md). When specifying a Spark connector, first make sure it is [available](../../operations/data/spark-connectors.md#share) in your project.

#### See also {#see-also}

* [{#T}](../../operations/projects/work-with-jobs.md)
* [GitHub repository](https://github.com/yandex-cloud-examples/yc-datasphere-jobs-examples) with job run examples
