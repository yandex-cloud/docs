---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# PRAGMA

Redefines settings of various kinds. Affects the expressions that follow. If necessary and logically possible, you can change the value of this setting several times within a given query to make it different at different execution steps.

**Syntax**

`PRAGMA x.y = "z";` or `PRAGMA x.y("z", "z2", "z3");`:

* `x`: (optional) The category of the setting.
* `y`: The name of the setting.
* `z`: (optional for flags) The value of the setting. The following suffixes are acceptable:
    * `Kb`, `Mb`, `Gb`:  For the data amounts.
    * `sec`, `min`, `h`, `d`: For the time values.

With some exceptions, you can return the settings values to their default states using `PRAGMA my_pragma = default;`.

**Example**

```sql
PRAGMA AutoCommit;
```

## PRAGMA supported in YQL {#list-of-available-pragma-in-yql}

### Global {#global}

| Name | Value type | Default | Description |
| --- | --- | --- | --- |
| `AutoCommit` | Flag | false | Automatically run `COMMIT` after every query. |
| `TablePathPrefix` | String | — | Add the specified prefix to the cluster table paths. It uses standard file system path concatenation: it supports parent folder referencing `..` and requires no `/` at the right. <br><br>**Example** <br>`PRAGMA TablePathPrefix = "home/yql"; SELECT * FROM test;`<br><br>The prefix is not added, if the table name is an absolute path (starts with /). |
| `Warning` | 1. Action<br>2. Warning code or `*` | — | Action: <ul><li>`disable`: disable.</li><li>`error`: treat as an error.</li><li>`default`: go back to the default behavior.</li></ul> The warning code is returned with the text itself (it's displayed in the console on the right).<br><br>**Example**<br>`PRAGMA Warning("error", "*");`<br> `PRAGMA Warning("disable", "1101");`<br> `PRAGMA Warning("default", "4503");`<br> In this case, all the warnings are treated as errors, except for the warning `1101` (that will be disabled) and `4503` (that will be processed by default and remain a warning). |

