# Managing Python function dependencies

{{ sf-name }} can automatically install dependencies required for a Python function to run. To do this, when creating a new [function version](../../operations/function/version-manage.md), {{ sf-name }} will run the `pip install` command in the project root (folder containing the function). 

To specify the required function libraries, list them in the `requirements.txt` file. For more information about the `requirements.txt` file format, see the [pip documentation](https://pip.pypa.io/en/stable/user_guide/#requirements-files).

Example of the `requirements.txt` file:

```text
boto3==1.13.15
attrs==19.3.0
```

The dependency installation process has some restrictions. For more information, see [{#T}](../../concepts/limits.md). You can view the dependency installation log using the link that appears in the list of operations.
