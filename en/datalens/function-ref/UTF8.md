---
editable: false

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# UTF8



#### Syntax {#syntax}


```
UTF8( string, old_encoding )
```

#### Description {#description}
Converts the `string` string encoding to `UTF8`.

**Argument types:**
- `string` — `String`
- `old_encoding` — `String`


**Return type**: `String`

#### Examples {#examples}

```
UTF8([Name], "CP-1251")
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`.
