# {{ ml-platform-name }} Jobs

In {{ ml-platform-name }}, you can run jobs remotely. These are Python and bash scripts and executable binary files to run on a {{ ml-platform-name }} VM.

Jobs are created and run in [projects](project.md). However, they do not depend on notebooks and VMs running in a project.

Before running a job, [install](../../cli/quickstart.md) and configure the [{{ yandex-cloud }} CLI](../../cli/) to use it for authentication in {{ yandex-cloud }}. You should also install the `datasphere` library in your Python environment. To do this, use the `pip install datasphere` command.

When creating a job, specify its parameters in the `config.yaml` file: a [configuration of computing resources](configurations.md) that will be used for job execution and required files with input data. {{ ml-platform-name }} analyzes the job code, identifies dependencies, deploys the environment on the VM, and runs the job code. Sample configuration file:

```yaml
name: simple-python-script # job name
desc: Program description # job description
cmd: python main.py --data ${DATA} --result ${OUTPUT}
env:
  python:
    auto: true # enables delivery of code and pip dependencies to DataSphere
inputs:
  - numbers.txt: DATA
outputs:
  - result.txt: OUTPUT
cloud-instance-type: c1.4
```

{{ ml-platform-name }} Jobs stores input data cache, environments, logs, and job execution results. You can reuse the data and share it across jobs in a single project. The size of stored data is limited. For more information about {{ ml-platform-name }} limits, see [{#T}](limits.md).

{% include [jobs-info](../../_includes/datasphere/jobs-environment.md) %}

You can find jobs in the **{{ ml-platform-name }} Jobs** tab of a project. Their progress and results will be available under **Run history**.
