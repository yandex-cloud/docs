# {{ ds-cli }}

You run {{ ds-jobs }} jobs using the {{ ds-cli }} utility.

To install {{ ds-cli }}, in a [Python virtual environment](https://docs.python.org/3.10/library/venv.html), run the following command:

```python
pip install datasphere
```

As soon as the installation is complete, you can view help by running the `-h` flag command:

```bash
datasphere -h
```

Command result:

```bash
usage: datasphere [-h] [-t TOKEN] [-l {ERROR,WARNING,INFO,DEBUG}] [--log-config LOG_CONFIG] {version,project} ...

positional arguments:
  {version,project}
    version             Show version

options:
  -h, --help            show this help message and exit
  -t TOKEN, --token TOKEN
                        YC OAuth token, see https://cloud.yandex.com/docs/iam/concepts/authorization/oauth-token
  -l {ERROR,WARNING,INFO,DEBUG}, --log-level {ERROR,WARNING,INFO,DEBUG}
                        Logging level
  --log-config LOG_CONFIG
                        Custom logging config
```

## {{ ds-cli }} commands {#commands}

You manage jobs using the `datasphere project job` section commands:
* [Running](#execute) and restoring a job session.
* [Viewing](#list) job information.
* [Canceling](#cancel) a job.

### Running jobs {#execute}

To run the job, run the following command:

```bash
datasphere project job execute -p <project_ID> -c <configuration_file>
```

Where:

* `<project_ID>`: ID of the {{ ml-platform-name }} project in which you are going to run the job.
* `<configuration_file>`: Path to the [job configuration file](index.md#config).

Running a job locks the shell session until the job completes. The job code operation logs will be output to the standard `stdout` and `stderr` error output streams. The job execution system logs will be written to a separate file in the user's working directory.

If the shell session is interrupted during job execution, the job will continue to run in {{ ml-platform-name }}, but the execution logs will not be saved. To resume logging, recover the session by running the following command:

```bash
datasphere project job attach --id <job_ID>
```

You can find out the job ID in the jobs widget of the {{ ml-platform-name }} UI on the project page.

Tracking and logging will resume after the job session is restored.

### Viewing job information {#list}

You can view all past and current project jobs by running the following command:

```bash
datasphere project job list -p <project_ID>
```

The response will return a table with the following fields:
* Job ID
* Name
* Description
* Status
* Job start and end date (if already completed)
* Name of the user who ran the job

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
