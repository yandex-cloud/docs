# cli completion bash

Generate the autocompletion script for bash

## Synopsis

Generate the autocompletion script for the bash shell.

This script depends on the 'bash-completion' package.
If it is not installed already, you can install it via your OS's package manager.

To load completions in your current shell session:

	source <(cli completion bash)

To load completions for every new session, execute once:

## Linux:

	cli completion bash > /etc/bash_completion.d/cli

## macOS:

	cli completion bash > $(brew --prefix)/etc/bash_completion.d/cli

You will need to start a new shell for this setup to take effect.


```
cli completion bash
```

## Options

```
  -h, --help   help for bash
```

## Options inherited from parent commands

```
  -c, --config-dir string   path to configuration directory
      --debug               enable debug mode
      --insecure            use if console has self-signed certificate
  -p, --profile string      configuration profile
```

## See also

* [cli completion](cli_completion.md)	 — Generate the autocompletion script for the specified shell

