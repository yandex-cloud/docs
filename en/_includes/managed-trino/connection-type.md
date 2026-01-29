Select the connection type: [{{ connection-manager-name }}](../../metadata-hub/concepts/connection-manager.md) or **Manual setup** (custom installation), and configure it as needed.

With {{ connection-manager-name }}, you can create connections to a cluster with a managed database or to a custom database installation.

When connecting via {{ connection-manager-name }}, {{ TR }} automatically detects and applies any changes to the connection parameters. For connections of the **Manual setup** type, {{ TR }} does not track connection parameter changes. You need to track and apply them manually.