---
sourcePath: core/reference/ydb-sdk/_includes/example/step-tcl-usage-intro.md
---
## Явное использование вызовов TCL Begin/Commit {#tcl-usage}

В большинстве случаев вместо явного использования [TCL](../../../../concepts/transactions.md) вызовов Begin и Commit лучше использовать параметры контроля транзакций в вызовах execute. Это позволит избежать лишних обращений к YDB и эффективней выполнять запросы.
