---
sourcePath: ru/ydb/ydb-docs-core/ru/core/reference/ydb-sdk/recipes/auth/_includes/metadata/go.md
---
```go
package main

import (
	"context"
	"os"

	"github.com/ydb-platform/ydb-go-sdk/v3"
	yc "github.com/ydb-platform/ydb-go-yc"
)

func main() {
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()
	db, err := ydb.New(
		ctx,
		...
		yc.WithMetadataCredentials(ctx),
		yc.WithInternalCA(), // append Yandex Cloud certificates
	)
	if err != nil {
		panic(err)
	}
	defer func() { 
		_ = db.Close(ctx) 
	}()
}
```
