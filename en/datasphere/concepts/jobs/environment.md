# Job runtime environment

{{ ds-jobs }} jobs run on dedicated VMs that are not connected to {{ jlab }}Lab or a launched project. The runtime environment of these VMs is deployed based on a [Docker image](docker.md) and additional parameters that you define in the job configuration file.

Jobs allow running on a VM Python scripts, Bash scripts, and any binary files compiled for Linux x86_64.

## Python environment {#python-env}

{% note tip %}

We recommend running jobs in a [virtual Python environment](https://docs.python.org/3.10/library/venv.html) to have precise control over job run parameters.

{% endnote %}

### Automated build of a Python environment {#auto}

{% include [jobs-info](../../../_includes/datasphere/jobs-environment.md) %}

If you are running Python scripts, {{ ml-platform-name }} can automatically set up the environment for your job. To enable this, specify the `python: auto` parameter under `env`:

```yaml
cmd: python main.py <call_arguments>
env:
  python: auto
```

In the auto mode, {{ ml-platform-name }} will analyze the job script dependencies, identify pip packages and local modules, transfer everything to the VM, install and prepare the runtime environment for the job.

You can modify an automated environment build:

```yaml
cmd: python main.py <call_arguments>
env:
  python:
    type: auto # specify automated environment build
    root-path:
      - other.py
    pip:
      extra-index-urls:
        - https://pypi.ngc.nvidia.com
      trusted-hosts:
        - nvidia.com
      no-deps: true  # The default value is false
```

Where:

* `root-path`: Explicitly points to [additional entry points](#entry-points).
* `extra-index-urls`: Specifies [additional repository addresses](https://pip.pypa.io/en/stable/cli/pip_install/#install-extra-index-url) the pip package manager can use to install the required environment packages.
* `trusted-hosts`: [List of trusted hosts](https://pip.pypa.io/en/stable/cli/pip/#cmdoption-trusted-host) which allows addressing the hosts specified as `<host>:<port>`, even if they do not support HTTPS.
* `no-deps`: `pip install` command [argument](https://pip.pypa.io/en/stable/cli/pip_install/#cmdoption-no-deps) which prevents installing package dependencies.

### Configuring a Python environment manually {#manual}

When setting up a Python environment manually, you can explicitly specify the Python version, define dependencies and pip operation parameters through the `requirements.txt` file, and provide local modules. When configuring an environment manually, you must specify at least one parameter. If you do not specify a parameter in the configuration file, its value will be set automatically.

```yaml
env:
 python:
   type: manual     # specify manual environment configuration
   version: 3.10.13 # optional
   requirements-file: requirements.txt  # optional
   local-paths:     # optional, cannot be used together with root-paths
     - foo.py
     - lib/
```

Where:

* `version`: Python version. If omitted, the job's runtime environment version will be used.
* `requirements-file`: Path to the `requirements.txt` file listing all the packages and pip flags required for the job. If omitted, the list of dependencies will be formed automatically.
* `local-paths`: List of local Python files to transfer. You can specify both individual files and whole directories. If omitted, the list of files will be formed automatically.
   If the job consists of only one main Python script, specify `local-paths: []` in the `env` section.

If the configuration file contains all three parameters (`version`, `requirements-file`, and `local-paths`), {{ ml-platform-name }} will not check the environment to identify missing dependencies. This can be of use if you cannot or do not want to reproduce the environment to run the job locally, as required by [automated environment build](#auto).

### Specifying entry points explicitly {#entry-points}

{% note warning %}

You can use the `if __name__ == "__main__":` [standard statement](https://docs.python.org/3/library/__main__.html) in your programs for **all** entry points.

{% endnote %}

To run Python scripts in jobs, you can use one of the following methods:
* Run a script explicitly via `python main.py <arguments>`.
* Utilize pre-configured third-party launchers such as [deepspeed](https://pypi.org/project/deepspeed/): `deepspeed main.py --num_gpus=1 --deepspeed_stage 2 --apply_lora True`.
* Provide programs as arguments when running other programs: `python main.py other.py`.

To build the environment and launch the job, {{ ml-platform-name }} will need to identify all the program's entry points. If {{ ml-platform-name }} is unable to do this in the auto mode, specify them in the `config.yaml` configuration file:

```yaml
env:
  python:
    type: auto | manual   # both options are possible
    root-paths:           # optional, cannot be used together with local-paths
      - main.py
      - other.py
```

## Plain environment {#plain-env}

By default, jobs use the plain environment to execute binary files and Bash scripts. In this case, all the files specified in the job configuration file under `inputs` will be transferred to the VM.

### Example {#bash-example}

Running the following job will output the Linux kernel version, the list of all installed packages, and the list of files and folders in the VM home directory.

The `config.yaml` configuration file specifies the entry point and lists all the modules you need to provide to the VM:

```yaml
cmd: ./run.sh
inputs:
  - run.sh  # explicitly list all the required modules
```

The `run.sh` file with the job code lists the commands to run on the VM:

```bash
#!/bin/bash
uname -a
dpkg -l
ls -la
```


#### See also {#see-also}

* [{#T}](index.md)
* [{#T}](cli.md)
* [{#T}](docker.md)
* [{#T}](../../operations/projects/work-with-jobs.md)
* [GitHub repository](https://github.com/yandex-cloud-examples/yc-datasphere-jobs-examples) with job run examples