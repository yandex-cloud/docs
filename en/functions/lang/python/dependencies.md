# Managing Python function dependencies

{{ sf-name }} can automatically install dependencies required for a Python function. To do this, when creating a new [function version](../../operations/function/version-manage.md), {{ sf-name }} will run the `pip install` command in the project root (the directory with the function).

To specify the required function libraries, list them in the `requirements.txt` file. For more information about the `requirements.txt` file format, see [this pip guide](https://pip.pypa.io/en/stable/user_guide/#requirements-files).

Here is an example of the `requirements.txt` file:

```text
boto3==1.13.15
attrs==19.3.0
```

The dependency installation process has some limitations. For more information, see [{#T}](../../concepts/limits.md). You can view the dependency installation log via the link displayed in the list of operations.
