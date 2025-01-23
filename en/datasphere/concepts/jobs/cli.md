# {{ ds-cli }}

You run {{ ds-jobs }} jobs using the {{ ds-cli }} utility.

To install {{ ds-cli }}, in a [Python virtual environment](https://docs.python.org/3.10/library/venv.html), run the following command:

```python
pip install datasphere
```

As soon as the installation is complete, you can view help by running this command with the `-h` flag:

```bash
datasphere -h
```

The result will be as follows:

```bash
usage: datasphere [-h] [-t TOKEN] [-l {ERROR,WARNING,INFO,DEBUG}] [--log-config LOG_CONFIG] [--log-dir LOG_DIR] [--profile PROFILE] {version,changelog,project,generate-requirements} ...

positional arguments:
  {version,changelog,project,generate-requirements}
    version             Show version
    changelog           Show changelog
    generate-requirements
                        Generate requirements for specified root module(s)

options:
  -h, --help            show this help message and exit
  -t TOKEN, --token TOKEN
                        YC OAuth token, see https://yandex.cloud/en/docs/iam/concepts/authorization/oauth-token
  -l {ERROR,WARNING,INFO,DEBUG}, --log-level {ERROR,WARNING,INFO,DEBUG}
                        Logging level
  --log-config LOG_CONFIG
                        Custom logging config
  --log-dir LOG_DIR     Logs directory (temporary directory by default)
  --profile PROFILE     `yc` utility profile
```

## {{ ds-cli }} commands {#commands}

Use the following commands to manage jobs and the utility:

* [Running](#execute) and restoring a job session.
* [Viewing](#list) job information.
* [Canceling](#cancel) a job.
* [Setting](#set-data-ttl) job data lifetime.
* [Generating](#generate-requirements) job environment parameters.
* [Getting](#projects-list) a list of community projects.
* [Getting](#project-get) information about a project.
* [Viewing](#version) {{ ds-cli }} version.
* [Viewing](#changelog) {{ ds-cli }} changelogs.

### Running jobs {#execute}

To run the job, run the following command:

```bash
datasphere project job execute -p <project_ID> -c <configuration_file>
```

Where:

* `<project_ID>`: ID of the {{ ml-platform-name }} project in which you are going to run the job.
* `<configuration_file>`: Path to the [job configuration file](index.md#config).

To run jobs under a service account, [authenticate](../../../cli/operations/authentication/service-account.md) in the {{ yandex-cloud }} CLI as this service account and [add](../../operations/projects/update.md) it to the {{ ml-platform-name }} project's member list with the `{{ roles-datasphere-project-developer }}` [role](../../security/index.md). If you run a job with the [{{ compute-full-name }}](../../../compute/) VM, [link](../../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) the service account to it.

Running a job locks the shell session until the job completes. The job code operation [logs](#logs) will be output to the standard `stdout` output and `stderr` error streams. The job execution system logs will be written to a separate file in the user's working directory.

If the shell session is interrupted during job execution, the job will continue to run in {{ ml-platform-name }}, but the execution logs will not be saved. To resume logging, recover the session by running the following command:

```bash
datasphere project job attach --id <job_ID>
```

You can find out the job ID in the {{ ml-platform-name }} UI under the {{ ds-jobs }} tab on the project page.

Tracking and logging will resume after the job session is restored.

To [rerun](fork.md) the job, run the following command:

```bash
datasphere project job fork
```

### Viewing job information {#list}

You can view all past and current project jobs by running the following command:

```bash
datasphere project job list -p <project_ID>
```

The response will return a table with the following fields:

* Job ID.
* Name.
* Description.
* Status.
* Job start and end date (if already completed).
* Name of the user who ran the job.

To view information about a specific job, run the following command:

```bash
datasphere project job get --id <job_ID>
```

### Canceling a job {#cancel}

You can stop and cancel a job in two ways:

1. If you have a shell session running with a job in progress, click **Ctrl** + **C**.
1. If you want to stop a job that is not related with an active shell session, run the following command:

   ```bash
   datasphere project job cancel --id <job_ID>
   ```

The running job will be stopped.

### Setting job data lifetime {#set-data-ttl}

You can set the job data lifetime by running the command below:

```bash
datasphere project job set-data-ttl --id <job_ID> --days <number_of_days>
```

Where `--days` is the number of days after which the job data will be deleted (14 days by default).

### Generating job environment parameters {#generate-requirements}

To generate the environment parameters for your job, run the following command:

```bash
datasphere generate-requirements <root_module>
```

Where `<root_module>` is the job root module.

The response will return a file named `requirements.txt` with a list of environment parameters for the specified module. You can use the list in the job [configuration file](index.md#config) to explicitly specify dependencies.

### Getting a list of community projects {#project-list}

To view all the community projects, run this command:

```bash
datasphere project list -c <community_ID>
```

The response will return a table with the following fields:

* Project ID
* Project name
* Community ID

### Getting information about a project {#project-get}

To view information about a specific project, run the following command:

```bash
datasphere project get --id <project_ID>
```

The response will return a table with the following fields:

* Project ID
* Project name
* Community ID

### Viewing {{ ds-cli }} version {#version}

To view the current {{ ds-cli }} version, run this command:

```bash
datasphere version
```

{% note info %}

Each time you use {{ ds-cli }}, a version check is performed. If a new version is out, the utility will notify you accordingly. To avoid compatibility issues, upgrade {{ ds-cli }} as new versions become available.

{% endnote %}

### Viewing the {{ ds-cli }} changelog {#changelog}

To view the changes in the current {{ ds-cli }} version, run this command:

```bash
datasphere changelog
```

## Job logs {#logs}

When running a job through {{ ds-cli }}, the shell first notifies the user to save the logs in the user's working directory. For example:

```bash
2024-05-16 12:42:35,447 - [INFO] - logs file path: C:\Temp\datasphere\job_2024-05-16T12-42-35.427056
```

After running the job, you can find the following files in the user's working directory:

* `stdout.txt`: Standard output stream of the user program.
* `stderr.txt`: Standard error message stream.
* `system.log`: System log of the VM configuration and environment package installation.
* `log.txt`: General {{ ds-cli }} log which records the progress of the job.
* `docker_stats.tsv`: Log of the resources consumed by the [Docker image](../docker.md), such as utilized CPU power, read and write speeds, used RAM, and boot speed. You can also get this information by running the `docker stats` [command](https://docs.docker.com/reference/cli/docker/container/stats/).
* `gpu_stats.tsv`: Log of GPU utilization, which includes the number of cores, utilized power, and video memory.

To change the directory for storing logs, use the following command:

```bash
datasphere --log-dir <new_directory>
```

You can upload your job [results](../../operations/projects/use-job-results.md) by running this command:

```bash
datasphere project job download-files --id <job_ID>
```

#### See also {#see-also}

* [{#T}](../../operations/projects/work-with-jobs.md)
* [{#T}](../../operations/projects/use-job-results.md)
