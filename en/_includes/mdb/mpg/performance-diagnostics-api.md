1. Pass the `true` value in the `config.performanceDiagnostics.enabled` parameter.
1. Pass the sessions sampling interval in the `config.performanceDiagnostics.sessionsSamplingInterval` parameter.
1. Pass the statements sampling interval in the `config.performanceDiagnostics.statementsSamplingInterval` parameter.

Acceptable parameter values:

- `config.performanceDiagnostics.sessionsSamplingInterval`: From `1` to `86400` seconds.
- `config.performanceDiagnostics.statementsSamplingInterval`: From `60` to `86400` seconds.
