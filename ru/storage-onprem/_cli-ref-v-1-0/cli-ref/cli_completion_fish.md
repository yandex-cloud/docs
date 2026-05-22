# cli completion fish

Generate the autocompletion script for fish

## Synopsis

Generate the autocompletion script for the fish shell.

To load completions in your current shell session:

	cli completion fish | source

To load completions for every new session, execute once:

	cli completion fish > ~/.config/fish/completions/cli.fish

You will need to start a new shell for this setup to take effect.


```
cli completion fish [flags]
```

## Options

```
  -h, --help   help for fish
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

