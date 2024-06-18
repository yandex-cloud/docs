---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/USER_INFO.md
---

# USER_INFO



#### Syntax {#syntax}


```
USER_INFO( user_id, user_info_type )
```

#### Description {#description}
Returns the marked up text by `user_id` to display username or email depending on the `user_info_type` value:

* `email`: Returns email.
* `name`: Returns name.

If the user has not been found, the function will return the original string from the source.

**Argument types:**
- `user_id` — `String`
- `user_info_type` — `String`


**Return type**: `Markup`

#### Examples {#examples}

```
USER_INFO('b1ggmp8es27t********', 'name') = 'test_user'
```

```
USER_INFO([UserId], 'email') = 'test_user@example.com'
```


#### Data source support {#data-source-support}

`DataLens Usage Analytics`.
