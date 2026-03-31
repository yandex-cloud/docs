# cli completion zsh

Generate the autocompletion script for zsh

## Synopsis

Generate the autocompletion script for the zsh shell.

If shell completion is not already enabled in your environment you will need
to enable it.  You can execute the following once:

	echo "autoload -U compinit; compinit" >> ~/.zshrc

To load completions in your current shell session:

	source <(cli completion zsh)

To load completions for every new session, execute once:

## Linux:

	cli completion zsh > "${fpath[1]}/_cli"

## macOS:

	cli completion zsh > $(brew --prefix)/share/zsh/site-functions/_cli

You will need to start a new shell for this setup to take effect.


```
cli completion zsh [flags]
```

## Options

```
  -h, --help   help for zsh
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

