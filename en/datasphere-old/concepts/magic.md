# Available commands

{% include [link-on-new-ui-datasphere-in-old-ui](../../_includes/datasphere/datasphere-old-note.md) %}

The list of commands available in the notebook is made up of standard commands with some restrictions and additions. View the list of standard commands in the [IPython documentation](https://ipython.readthedocs.io/en/stable/interactive/magics.html). Restrictions and additions are given below.

## Disabled standard commands {#block}

Standard commands that aren't available in the notebook:
* `%%bash`
* `%%perl`
* `%%python`
* `%%python2`
* `%%python3`
* `%%ruby`
* `%%script`
* `%%sh`

### Alternative use of blocked commands {#restriction}

#### %%bash {#bash}

To run bash commands, put 'bash' explicitly at the beginning of the cell:

* With no configuration specified. The default configuration is used in this case.

   ```
   #!:bash
   ```
* With a configuration specified:

   ```
   #!<configuration name>:bash
   ```

   > For example, to run commands in the c1.4 configuration, enter `#!c1.4:bash`

The available configurations are described in [{#T}](configurations.md)

**Restrictions**

The following restrictions apply to using bash commands:
* Background jobs are not supported, for example, `sshd`.
* Launching `pip` is not supported. Use the `%pip` format for `pip`.

## Additional commands {#extension}

Additional commands available in the notebook.

### Managing state saving {#state}

Commands to exclude and add variables when saving a state:
* `%state_exclude [variable names]`: Excludes the specified variables when saving a state.
* `%state_include [variable names]`: Adds the specified variables when saving a state.
* `%state_include_all`: Returns all variables when saving a state.
* `%state_exclude_ls`: Returns a list of all variables that were excluded when saving a state.

### Adding read-only variables {#readonly}

The state of cells is saved after they're run and the variable values are overwritten. Saving large variables may take some time. If a variable is intended to store a constant value, it can be declared as a read-only variable. Such variables aren't overwritten when saving and serializing data, which speeds up these operations.

To specify that a cell's variable is read-only, use the command:

```
#pragma readonly/ro <variable 1>, <variable 2>
```

This command should be placed in the first lines of the cell before the code, but you may also put it after the configuration update (`#!c1.4`,&nbsp;`#!g1.1`).

Possible options for writing the command using `x` and `y` variables as an example:
* `#pragma readonly x, y`
* `#pragma readonly x y`
* `#pragma readonly x`
* `#pragma readonly y`
* `#pragma ro x, y`


#### See also {#see-also}

* [{#T}](../operations/projects/install-dependencies.md)
* [{#T}](configurations.md)
* [{#T}](limits.md)
* [{#T}](../operations/index.md)