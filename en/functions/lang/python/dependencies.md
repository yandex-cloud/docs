# Managing Python function dependencies

{{ sf-name }} can automatically install dependencies required for a Python function to run. To do this, when creating a new [function version](../../operations/function/version-manage.md#func-version-create), it executes the `pip install` command in the project root (folder with the function).

To specify the necessary function libraries, list them in the `requirements.txt` file. For more information about the `requirements.txt` file format, see the [pip documentation](https://pip.pypa.io/en/stable/user_guide/#requirements-files).

Sample `requirements.txt` file:

```
boto3==1.13.15
attrs==19.3.0
```

The dependency installation process has some restrictions. For more information, see [{#T}](../../concepts/limits.md). You can view the dependency installation log using the link that appears in the list of operations.

