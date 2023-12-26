# Resolving version conflicts during the installation of Python SDK

When you [install](install.md) the `yandex-speechkit` package, the `grpcio-tools` version {{ grpcio-tools-version }} is installed along with it. If you installed `grpcio-tools` before (e.g., when going through [examples of working with the {{ speechkit-name }} API](../../tutorials/index.md)), a conflict between the package versions may occur.

Check which version of `grpcio-tools` you have installed:

```bash
pip list | grep grpcio-tools
```

If the command output contains the `grpcio-tools` package and its version is higher than {{ grpcio-tools-version }}, create a virtual environment to avoid a version conflict. Or else, install the `yandex-speechkit` package with no virtual environment.

To deploy a virtual environment and install the package in it:

1. Create a directory for your Python SDK project and open it.
1. Create a virtual environment in this directory:

   ```bash
   python3 -m venv <environment_name>
   ```

   If you need to create an environment using a specific Python version, specify `python<version>` instead of `python3`, e.g., `python3.9`.

1. Activate the environment.

   ```bash
   source <environment_name>/bin/activate
   ```

   You will see the environment name before the input line in the terminal.

1. Install the `yandex-speechkit` package using the pip package manager:

   ```bash
   pip install yandex-speechkit
   ```

Continue working with the Python SDK in the deployed environment. When you are finished, exit the environment by running the `deactivate` command.
