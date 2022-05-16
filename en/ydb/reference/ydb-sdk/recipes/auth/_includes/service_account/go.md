---
sourcePath: en/ydb/ydb-docs-core/en/core/reference/ydb-sdk/recipes/auth/_includes/service_account/go.md
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
		yc.WithServiceAccountKeyFileCredentials(
			os.Getenv("YDB_SERVICE_ACCOUNT_KEY_FILE_CREDENTIALS"),
		),
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
