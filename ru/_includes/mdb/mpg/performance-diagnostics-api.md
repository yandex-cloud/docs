1. Передайте значение `true` в параметре `config.performanceDiagnostics.enabled`.
1. Передайте значение интервала сбора сессий в параметре `config.performanceDiagnostics.sessionsSamplingInterval`.
1. Передайте значение интервала сбора запросов в параметре `config.performanceDiagnostics.statementsSamplingInterval`.

Допустимые значения параметров:

- `config.performanceDiagnostics.sessionsSamplingInterval` — от `1` до `86400` секунд.
- `config.performanceDiagnostics.statementsSamplingInterval` — от `60` до `86400` секунд.
