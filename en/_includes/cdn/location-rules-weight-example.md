> For example, let’s assume you set the following location rules:
>
> | Rule | Weight | Regular expression | Cache lifetime |
> | --- | --- | --- | --- |
> | A | `1` | `^/path/.+` | `1 hour` |
> | B | `2` | `\.txt$` | `4 hours` |
>
> With this configuration, the `/path/file.txt` request will match rule A, which has a lower weight and a higher priority than rule B, so the file will be cached for one hour.
>
> To cache the `/path/file.txt` file for four hours, rule B must have a lower weight than rule A.