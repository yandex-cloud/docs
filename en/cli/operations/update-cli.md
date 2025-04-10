# CLI update

## Viewing your CLI version {#see-version}

To learn your current CLI version, run this command in the terminal:
    
```bash
yc version
```

Result:

```text
Yandex Cloud CLI 0.144.0 darwin/arm64
```

For information about the CLI versions, see [{#T}](../release-notes.md).

## Updating your CLI {#update}

The CLI checks for updates automatically. If an update is available, the following message is displayed when you invoke any CLI command in the terminal:

```text
There is a new yc version '0.145.0' available. Current version: '0.144.0'.
See release notes at https://yandex.cloud/ru/docs/cli/release-notes
You can install it by running the following command in your shell:
    $ yc components update
```

To update your CLI to a new version, run this command:

```bash
yc components update
```

Result:

```text
Installing yc 0.145.0 ...
Update is complete!
Please reload your shell for changes to take place.
Now we have zsh completion. Type "echo 'source /Users/vnkiryushkin/yandex-cloud/completion.zsh.inc' >>  ~/.zshrc" to install it
```

## Rolling back your CLI version {#rollback}

To roll back to the previous CLI version, run this command:

```bash
yc components restore
```

Result:

```text
Restoring backup...
Restoration done!
```