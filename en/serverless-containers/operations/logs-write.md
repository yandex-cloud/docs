# Logging data to the container execution log

Apart from text, you can write [structured logs](../concepts/logs.md#structured-logs) to the standard output stream (`stdout`) and standard error output stream (`stderr`).

## Applications and Dockerfile examples

{% list tabs %}

- Node.js

   **index.js**
   ```
   const winston = require('winston');
   const express = require('express');

   const logger = winston.createLogger({
       level: 'debug',
       format: winston.format.json(),
       transports: [new winston.transports.Console()],
   });

   const app = express();
   app.use(express.urlencoded({ extended: true }));
   app.use(express.json());

   app.get("/", (req, res) => {
       logger.info({"message": "My log message", "my-key": "my-value"})
       return res.send("Hello, world!");
   });

   app.listen(process.env.PORT);
   ```

   **Dockerfile**
   ```
   FROM node:16-slim

   WORKDIR /app
   RUN npm install winston express
   COPY ./index.js .

   CMD [ "node", "index.js" ]
   ```

- Python

   **requirements.txt**
   ```
   python-json-logger==2.0.4
   sanic==22.12.0
   ```

   **index.py**
  
     
   ```
   import logging
   import os

   from pythonjsonlogger import jsonlogger
   from sanic import Sanic
   from sanic.response import text


   class YcLoggingFormatter(jsonlogger.JsonFormatter):
       def add_fields(self, log_record, record, message_dict):
           super(YcLoggingFormatter, self).add_fields(log_record, record, message_dict)
           log_record['logger'] = record.name
           log_record['level'] = str.replace(str.replace(record.levelname, "WARNING", "WARN"), "CRITICAL", "FATAL")


   app = Sanic(__name__)

   logHandler = logging.StreamHandler()
   logHandler.setFormatter(YcLoggingFormatter('%(message)s %(level)s %(logger)s'))

   logger = logging.getLogger('MyLogger')
   logger.propagate = False
   logger.addHandler(logHandler)
   logger.setLevel(logging.DEBUG)


   @app.route("/")
   async def hello(request):
       logger.info("My log message", extra={"my-key": "my-value"})
       return text("Hello, world!", status=200)


   if __name__ == "__main__":
       app.run(host='0.0.0.0', port=int(os.environ['PORT']), motd=False, access_log=False)
   ```
  

   **Dockerfile**
   ```
   FROM python:3.10-slim

   WORKDIR /app
   COPY ./index.py .
   COPY ./requirements.txt .
   RUN pip install --no-cache-dir --prefer-binary --requirement=./requirements.txt

   CMD [ "python", "index.py" ]
   ```

- Go

   **index.go**
   ```
   package main

   import (
       "go.uber.org/zap"
       "net/http"
       "os"
   )

   func main() {
       zapConfig := zap.NewProductionConfig()
       zapConfig.DisableCaller = true
       zapConfig.Level.SetLevel(zap.DebugLevel)
       logger, _ := zapConfig.Build()

       portStr := os.Getenv("PORT")
       http.Handle("/", handler{logger})
       http.ListenAndServe(":"+portStr, nil)
   }

   type handler struct {
       logger *zap.Logger
   }

   func (h handler) ServeHTTP(writer http.ResponseWriter, _ *http.Request) {
       h.logger.Info(
           "My log message",
           zap.String("my-key", "my-value"),
       )

       writer.WriteHeader(200)
       _, _ = writer.Write([]byte("Hello, world!"))
   }
   ```

   **Dockerfile**
   ```
   FROM golang:latest AS build

   WORKDIR /app
   ADD index.go .
   ADD go.mod .
   ADD go.sum .
   RUN go build -a -tags netgo -ldflags '-w -extldflags "-static"' -o server-app *.go

   FROM scratch
   COPY --from=build /app/server-app /server-app

   ENTRYPOINT ["/server-app"]
   ```

{% endlist %}