---
sourcePath: en/ydb/ydb-docs-core/en/core/reference/ydb-sdk/recipes/auth/_includes/env/go.md
---
```go
package main

import (
	"context"
	"os"
	
	environ "github.com/ydb-platform/ydb-go-sdk-auth-environ"
	"github.com/ydb-platform/ydb-go-sdk/v3"
)

func main() {
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()
	db, err := ydb.New(
		ctx,
		...
		environ.WithEnvironCredentials(ctx),
	)
	if err != nil {
		panic(err)
	}
	defer func() { 
		_ = db.Close(ctx) 
	}()
}
```
