# Rerunning jobs in {{ ds-jobs }}

In {{ ml-platform-full-name }}, you can rerun a job with the required parameters redefined. A rerun creates a job fork and the original job becomes the parent one. A job fork can also be rerun, in which case the job will become both the fork of one and the parent of the other.

To [regularly run](airflow.md) the same job with some of its parameters redefined, you can use {{ ds-jobs }} along with [{{ maf-full-name }}](../../../managed-airflow/).

To rerun a job with new parameters, there is the `fork` command in [{{ ds-cli }}](cli.md) and in {{ ds-jobs }} SDK, which can be used to redefine the following parameters:

* `name`: Job name.
* `desc`: Job description.
* `args`: Job arguments.
* `vars`: Input and output data files.
* `env_vars`: Environment variables.
* `working_storage`: Extended working directory configuration.
* `cloud_instance_types`: [Computing resource configuration](../configurations.md).

#### Example {#example-fork}

Let's take a look at the `config.yaml` [job configuration file](index.md#config) for the code that runs a substring search (`grep`) in the input file:

```yaml
name: simple-bash-script
desc: Find text pattern in input file with grep
cmd: grep -C ${RANGE} ${OPTIONS} -f ${PATTERN} ${INPUT} > ${OUTPUT}
args:
  RANGE: 0
  OPTIONS: "-h -r"
inputs:
  - pattern.txt: PATTERN
  - input.txt: INPUT
outputs:
  - output.txt: OUTPUT
```

Where:

* `RANGE`: Search output interval.
* `OPTIONS`: Additional flags of the `grep` command.
* `PATTERN`: Substring pattern file.
* `INPUT`: Input data file.
* `OUTPUT`: Output data file.

After you run a job, you can get its ID from [CLI logs](cli.md#logs) using the `execute` command or under the {{ ds-jobs }} tab on the project page in your browser. To rerun this job using the SDK `fork` command, specify its ID and redefine its parameters as you need. For example, specify a new search output interval and a new input data file:

```python
from datasphere import SDK

sdk = SDK()

sdk.fork_job(
  '<job_ID>',
  args={'RANGE': '1'},
  vars={'INPUT': 'new_input.txt'},
)
```

#### See also {#see-also}

* [{#T}](./index.md)
* [{#T}](./airflow.md)