{% cut "If a `grpcio-tools` package version conflict occurs" %}

When installing `yandex-speechkit`, the `grpcio-tools` package of version {{ grpcio-tools-version }} is installed. If you installed `grpcio-tools` before (for example, when going through [examples of working with the {{ speechkit-name }} API](../../speechkit/tutorials/index.md)), a conflict between the package versions may occur.

Check which version you have installed:

```bash
pip list | grep grpcio-tools
```

If the command output contains the `grpcio-tools` package and its version is higher than {{ grpcio-tools-version }}, create a virtual environment to avoid a version conflict. Or else, install the `yandex-speechkit` package with no virtual environment.

To deploy a virtual environment and install the package in it:

1. Create a directory for your Python SDK project and open it.
1. Create a virtual environment in this directory:

   ```bash
   python3 -m venv <environment name>
   ```

   If you need to create an environment with a specific Python version, specify `python<version>` instead of `python3`. E.g., `python3.9`.

1. Activate the environment:

   ```bash
   source <environment name>/bin/activate
   ```

   You will see the environment name before the input line in the terminal.

1. Install the `yandex-speechkit` package using the pip package manager:

   ```bash
   pip install yandex-speechkit
   ```

After you finish working with the Python SDK, exit the environment by running the `deactivate` command.

{% endcut %}
