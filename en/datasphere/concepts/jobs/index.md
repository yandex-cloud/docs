# {{ ml-platform-name }} Jobs

In {{ ml-platform-name }}, you can run jobs, i.e., computations on {{ ml-platform-name }} VMs outside {{ jlab }}Lab, remotely. These can be Python scripts and projects, Bash scripts, and executable binary files compiled for Linux x86_64.

Jobs are created and run in [projects](../project.md). However, they do not depend on project notebooks and running VMs.

To [run a job](../../operations/projects/work-with-jobs.md), set up a Python virtual environment, install [{{ ds-cli }}](cli.md) using the `pip install datasphere` command and prepare a configuration file describing all the parameters for running the job. You can also [install](../../../cli/quickstart.md) and configure the [{{ yandex-cloud }} CLI](../../../cli/) to use it for authentication in {{ yandex-cloud }}.

{{ ml-platform-name }} Jobs stores input data cache, environments, logs, and job execution results. You can reuse the data and share it across jobs in a single project. The size of stored data is limited. For more information about {{ ml-platform-name }} limits, see [{#T}](../limits.md).

You can find jobs in the **{{ ml-platform-name }} Jobs** tab of a project. Their progress and results will be available under **Run history**.

## Job configuration file {#config}

When creating a job, specify its parameters in the `config.yaml` file: a [configuration of computing resources](../configurations.md) that will be used for job execution and required files with input data. Depending on the settings specified in the configuration file, {{ ml-platform-name }} analyzes the job, identifies dependencies, deploys the environment on the VM, and runs the job code. Job execution results are saved in the {{ ml-platform-name }} project files listed in the job configuration.

```yaml
# Job name
name: simple-python-script
# Job description
desc: Program description

# Entry point parameters for running computations
cmd: >  # Multiline YAML string
  python src/main.py
    --params ${PARAMS}
    --features ${<connector_ID>}/features.tsv
    --validate ${CIFAR}/val.json
    --normalizer ${DS_PROJECT_HOME}/misc/norm.bin
    --model ${MODEL}
    --epochs 5

# Files with input data
inputs:
  - misc/logging.yaml  # Path to the file relative to the job run directory on your local computer
  - /usr/share/params.json: # Absolute file path on the local computer is saved to the PARAMS variable
      var: PARAMS

# Files with results
outputs:
  - data/model.bin: MODEL  # Relative file path is saved to the MODEL variable
  - other/metrics.png  # Relative file path

# Resources required for running the job must be available in the project
s3-mounts: # S3 connectors
  - <connector_ID>   # S3 connector ID
                           # Since no connector name is set, the connector can be accessed by ID
datasets:
  - <dataset_ID>:  # ID of the available project dataset
      var: CIFAR   # CIFAR is a variable to access the dataset

# Environment parameters       
env:
  vars:  # Environment variables
    PYTHONBUFFERED: Yes
    DEVICE_COUNT: 8
  docker: <Docker_image_ID>  # Docker image available in the project {{ ml-platform-name }}
  # You can also specify a Docker image in an image registry
  # docker:
  #   image: <path_to_image_in_registry>:<tag>  # E.g., <cr.yandex/crtabcdef12345678900/myenv:0.1>
                                              # For Docker Hub, you can just specify `<name>:<tag>`, such as `ubuntu:focal`
  #   username: <login>
  #   password: <password> # in text format or a {{ ml-platform-name }} secret name
  #   # password:
  #   #   secret-id: PASSWORD

  # Environmet dependency build method
  python: auto # Fully automated environment build

  # python: # Environment parameters are set manually. If no parameters are specified, their values will be identified from the current environment automatically
  #   type: manual
  #   version: 3.10.5  # Python version
  #   requirements-file: requirements.txt  # File with environment parameters

# Job run flags
flags:
  - attach-project-disk # Mount project storage

# Computing resource configuration for running the job
cloud-instance-type: g2.1
```

The job `config.yaml` file contains multiple sections.

1. The `name` and `description` sections specify the job name and description. The job name must be unique within the project. A description is optional and helps find the required job in the project.

1. The `cmd` section specifies the job entry point. Specify how to run your code and set all the run parameters to be provided to the executable file or script. You can use variables and IDs that will be specified in the sections below to set paths to the required files.

1. The `input` section specifies files with input data and other information to be provided for running the job from your local computer. You can set a file path relative to the job directory or save the relative or absolute file path to a variable to use it in other sections of the configuration file.

1. The `output` section specifies files to save the computation results to. Once the job is executed, these files will appear on your PC. The rules for setting file paths are the same as in the `input` section.

1. {{ ml-platform-name }} resources used in jobs are specified in the `s3-mounts` (for [S3 connectors](../s3-connector.md)) and `datasets`(for [datasets](../dataset.md)) sections. To use an S3 connector or a dataset in a job, specify the ID of an available project resource and, optionally, define a variable for it. If no variable is set, resources in the `cmd` section can be accessed by their ID.

   You can also use project storage in your job. To do this, set the `attach-project-disk` flag in the `flags` section. The project storage will be mounted to the VM the job is running on as an external disk for data reads. The storage path will be available in the `DS_PROJECT_HOME` environment variable.

1. The `env` section defines environment parameters for running the job: the VM environment build method, environment variables and, optionally, a Docker image that is built in {{ ml-platform-name }} or stored in a different image registry. You can specify the registry authorization credentials if needed.

   There are two ways to set an environment for Python projects:

   * Allow {{ ml-platform-name }} to automatically identify any required dependencies, analyze the current environment on your local computer, and build and transfer the environment on its own. To enable this, set `python: auto` in the `env` section.
   * You can specify the Python interpreter version and used libraries yourself right in the configuration file or in a separate `requirements.txt` file. If you explicitly set at least one parameter, missing parameter values will be fetched from the current environment automatically.

   {% note warning %}

   If you use auto mode for setting the environment or only specify some dependencies, run your job from the Python virtual environment where all the relevant packages and local modules are installed. This will enable the `datasphere` library to automatically identify the job runtime environment parameters.

   {% endnote %}

   The environment variables are specified in the `vars` section under `env`. Project secrets will also be added to the environment variables when running the job.

   {% include [jobs-info](../../../_includes/datasphere/jobs-environment.md) %}

1. The `cloud-instance-type` section defines the type of the [computing resource configuration](../configurations.md) to run the job on.


#### See also {#see-also}

* [{#T}](../../operations/projects/work-with-jobs.md)
* [GitHub repository](https://github.com/yandex-cloud-examples/yc-datasphere-jobs-examples) with job run examples