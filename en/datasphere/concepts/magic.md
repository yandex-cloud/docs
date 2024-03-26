# Available commands

{{ ds-nb }} allows using IPython magic commands. You can use them to measure program runtime, run bash commands in separate cells, identify variable types, etc. The majority of standard commands from the [IPython documentation](https://ipython.readthedocs.io/en/stable/interactive/magics.html) is available in notebooks. For the restrictions and additions, see below.

## Running bash commands {#bash}

To run bash commands, put `bash` explicitly at the beginning of the cell:

```python
#!:bash
```

**Restrictions**

The following restrictions apply to using bash commands:
* Background jobs, such as `sshd`, are not supported.
* Launching `pip` is not supported; use the `%pip` format instead.

## Disabled regular commands {#block}

Regular commands that are not available in a notebook:

* `%%bash`
* `%%perl`
* `%%python`
* `%%python2`
* `%%python3`
* `%%ruby`
* `%%script`
* `%%sh`

#### See also {#see-also}

* [{#T}](../operations/projects/install-dependencies.md)
* [{#T}](configurations.md)
* [{#T}](limits.md)
* [{#T}](../operations/index.md)