# Configuration

The section describes how to configure {{ unified-agent-full-name }}. Before getting started, explore the [basic concepts](index.md) used in agent configuration.

## Configuration files {#files}

Specify the required {{ unified-agent-short-name }} settings in the `config.yml` file. This file is provided as a parameter at agent startup. You can import [additional configuration files](#import) into `config.yml` using the `import` directive.

The configuration file may contain the following sections:

- `routes`: Description of [delivery routes](index.md#routes).
- `channels`: Description of [named channels](index.md#channels).
- `pipes`: Description of [named pipes](index.md#pipes).
- `storages`: Description of [storages](index.md#storages).
- `status`, `main_thread_pool`, `agent_log`, `system`: [Sections containing service information](services.md).

To provide the configuration file, specify its path in the `--config` parameter:

```bash
/usr/bin/unified_agent --config /etc/yandex/unified_agent/config.yml
```

When you install {{ unified-agent-short-name }} from the deb package, the basic configuration file, `/etc/yandex/unified_agent/config.yml`, is automatically set and provided to the `--config` parameter.

## Importing configuration files {#import}

1. Create additional YAML configuration files in the `/etc/yandex/unified_agent/conf.d` directory.
1. Import the additional YAML files using the main `config.yml` file:

    ```yml
    import:
    - /etc/yandex/unified_agent/conf.d/*.yml
    ```

    The files from the `/etc/yandex/unified_agent/conf.d` directory are imported in alphabetical order.

The `import` directive value is a string or array of strings; each string is expanded using the [glob](http://man7.org/linux/man-pages/man7/glob.7.html) function. Files are imported in the order of the `import` directives, and within each directive, in lexicographic order of file names.

When importing configuration files, the following rules apply:

- The `status` and `main_thread_pool` sections are pulled from the last imported file.
- The `channels`, `storages`, and `pipes` sections are specified as lists. New items are added to the end of the list or replaced if there is already an item with the same `name`.
- The `routes` section is specified as a list. New items are added to the end of the list.

You can also add the `import` directive to the files you are importing. To do so, specify only absolute paths under `import`. Relative paths start from the agent's startup directory.

{% note info %}

We do not recommend using `import` in nested files as this makes your configuration bulky.

{% endnote %}

If the configuration import loops, {{ unified-agent-short-name }} will terminate with an error. You can find the error details in the agent logs. The maximum recursion depth is 100. If the imported file contains errors, the full path to the original file containing the erroneous node will be output.

## Output and validation of the final configuration {#validation}

To validate the agent settings, run the command:

```bash
unified_agent --config /etc/yandex/unified_agent/config.yml check-config
```

If the validation is successful, once all imports are complete, the agent will output the final configuration version to `stdout` and the null return code.

If the validation fails, the agent will output configuration errors to `stderr` and a non-null return code:

```bash
unified_agent --config console_to_lb.yml check-config
yaml-cpp: error at line 10, column 3: unrecognized field [status_port]
```

## Configuration directives {#configuration_sections}

Below you can find the configuration sections and parameters of different {{ unified-agent-short-name }} components. For optional parameters, the values given in the examples are the default ones.

## Examples {#examples}

For configuration examples, see [{#T}](../../../operations/index.md#working-with-metrics).
