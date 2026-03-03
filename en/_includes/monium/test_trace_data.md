```json
{
  "resourceSpans": [
    {
      "resource": {
        "attributes": [
          {
            "key": "service.name",
            "value": {
              "stringValue": "frontend"
            }
          },
          {
            "key": "service.version",
            "value": {
              "stringValue": "1.0.0"
            }
          },
          {
            "key": "telemetry.sdk.name",
            "value": {
              "stringValue": "opentelemetry"
            }
          },
          {
            "key": "telemetry.sdk.language",
            "value": {
              "stringValue": "nodejs"
            }
          },
          {
            "key": "telemetry.sdk.version",
            "value": {
              "stringValue": "1.17.0"
            }
          }
        ]
      },
      "scopeSpans": [
        {
          "scope": {
            "name": "frontend-tracer",
            "version": "1.0.0"
          },
          "spans": [
            {
              "traceId": "not_var{{TRACE_ID}}",
              "spanId": "M8kLx3vN9Qw=",
              "name": "HTTP GET /api/checkout",
              "kind": 2,
              "startTimeUnixNano": "not_var{{START_TIME_1}}",
              "endTimeUnixNano": "not_var{{END_TIME_1}}",
              "attributes": [
                {
                  "key": "http.method",
                  "value": {
                    "stringValue": "GET"
                  }
                },
                {
                  "key": "http.url",
                  "value": {
                    "stringValue": "/api/checkout"
                  }
                },
                {
                  "key": "http.status_code",
                  "value": {
                    "intValue": "200"
                  }
                },
                {
                  "key": "http.user_agent",
                  "value": {
                    "stringValue": "Mozilla/5.0"
                  }
                }
              ],
              "status": {
                "code": 1
              }
            },
            {
              "traceId": "not_var{{TRACE_ID}}",
              "spanId": "P2nRg8kLmHs=",
              "parentSpanId": "M8kLx3vN9Qw=",
              "name": "getCart",
              "kind": 3,
              "startTimeUnixNano": "not_var{{START_TIME_2}}",
              "endTimeUnixNano": "not_var{{END_TIME_2}}",
              "attributes": [
                {
                  "key": "rpc.system",
                  "value": {
                    "stringValue": "grpc"
                  }
                },
                {
                  "key": "rpc.service",
                  "value": {
                    "stringValue": "oteldemo.CartService"
                  }
                },
                {
                  "key": "rpc.method",
                  "value": {
                    "stringValue": "GetCart"
                  }
                }
              ],
              "status": {
                "code": 1
              }
            },
            {
              "traceId": "not_var{{TRACE_ID}}",
              "spanId": "T9wVh2mKpLx=",
              "parentSpanId": "M8kLx3vN9Qw=",
              "name": "placeOrder",
              "kind": 3,
              "startTimeUnixNano": "not_var{{START_TIME_3}}",
              "endTimeUnixNano": "not_var{{END_TIME_3}}",
              "attributes": [
                {
                  "key": "rpc.system",
                  "value": {
                    "stringValue": "grpc"
                  }
                },
                {
                  "key": "rpc.service",
                  "value": {
                    "stringValue": "oteldemo.CheckoutService"
                  }
                },
                {
                  "key": "rpc.method",
                  "value": {
                    "stringValue": "PlaceOrder"
                  }
                }
              ],
              "status": {
                "code": 1
              }
            }
          ]
        }
      ]
    },
    {
      "resource": {
        "attributes": [
          {
            "key": "service.name",
            "value": {
              "stringValue": "cartservice"
            }
          },
          {
            "key": "service.version",
            "value": {
              "stringValue": "1.0.0"
            }
          },
          {
            "key": "telemetry.sdk.name",
            "value": {
              "stringValue": "opentelemetry"
            }
          },
          {
            "key": "telemetry.sdk.language",
            "value": {
              "stringValue": "dotnet"
            }
          }
        ]
      },
      "scopeSpans": [
        {
          "scope": {
            "name": "cartservice-tracer",
            "version": "1.0.0"
          },
          "spans": [
            {
              "traceId": "not_var{{TRACE_ID}}",
              "spanId": "R5bNj7xMqWt=",
              "parentSpanId": "P2nRg8kLmHs=",
              "name": "oteldemo.CartService/GetCart",
              "kind": 2,
              "startTimeUnixNano": "not_var{{START_TIME_4}}",
              "endTimeUnixNano": "not_var{{END_TIME_4}}",
              "attributes": [
                {
                  "key": "rpc.system",
                  "value": {
                    "stringValue": "grpc"
                  }
                },
                {
                  "key": "rpc.service",
                  "value": {
                    "stringValue": "oteldemo.CartService"
                  }
                },
                {
                  "key": "rpc.method",
                  "value": {
                    "stringValue": "GetCart"
                  }
                },
                {
                  "key": "rpc.grpc.status_code",
                  "value": {
                    "intValue": "0"
                  }
                }
              ],
              "status": {
                "code": 1
              }
            },
            {
              "traceId": "not_var{{TRACE_ID}}",
              "spanId": "V8dKm4pLzNr=",
              "parentSpanId": "R5bNj7xMqWt=",
              "name": "redis.get",
              "kind": 3,
              "startTimeUnixNano": "not_var{{START_TIME_5}}",
              "endTimeUnixNano": "not_var{{END_TIME_5}}",
              "attributes": [
                {
                  "key": "db.system",
                  "value": {
                    "stringValue": "redis"
                  }
                },
                {
                  "key": "db.operation",
                  "value": {
                    "stringValue": "GET"
                  }
                },
                {
                  "key": "db.redis.database_index",
                  "value": {
                    "intValue": "0"
                  }
                }
              ],
              "status": {
                "code": 1
              }
            }
          ]
        }
      ]
    },
    {
      "resource": {
        "attributes": [
          {
            "key": "service.name",
            "value": {
              "stringValue": "checkoutservice"
            }
          },
          {
            "key": "service.version",
            "value": {
              "stringValue": "1.0.0"
            }
          },
          {
            "key": "telemetry.sdk.name",
            "value": {
              "stringValue": "opentelemetry"
            }
          },
          {
            "key": "telemetry.sdk.language",
            "value": {
              "stringValue": "go"
            }
          }
        ]
      },
      "scopeSpans": [
        {
          "scope": {
            "name": "checkoutservice-tracer",
            "version": "1.0.0"
          },
          "spans": [
            {
              "traceId": "not_var{{TRACE_ID}}",
              "spanId": "Q3mTk9wPvBz=",
              "parentSpanId": "T9wVh2mKpLx=",
              "name": "oteldemo.CheckoutService/PlaceOrder",
              "kind": 2,
              "startTimeUnixNano": "not_var{{START_TIME_6}}",
              "endTimeUnixNano": "not_var{{END_TIME_6}}",
              "attributes": [
                {
                  "key": "rpc.system",
                  "value": {
                    "stringValue": "grpc"
                  }
                },
                {
                  "key": "rpc.service",
                  "value": {
                    "stringValue": "oteldemo.CheckoutService"
                  }
                },
                {
                  "key": "rpc.method",
                  "value": {
                    "stringValue": "PlaceOrder"
                  }
                }
              ],
              "status": {
                "code": 1
              }
            },
            {
              "traceId": "not_var{{TRACE_ID}}",
              "spanId": "L6hFr2sKxMv=",
              "parentSpanId": "Q3mTk9wPvBz=",
              "name": "getProduct",
              "kind": 3,
              "startTimeUnixNano": "not_var{{START_TIME_7}}",
              "endTimeUnixNano": "not_var{{END_TIME_7}}",
              "attributes": [
                {
                  "key": "rpc.system",
                  "value": {
                    "stringValue": "grpc"
                  }
                },
                {
                  "key": "rpc.service",
                  "value": {
                    "stringValue": "oteldemo.ProductCatalogService"
                  }
                },
                {
                  "key": "rpc.method",
                  "value": {
                    "stringValue": "GetProduct"
                  }
                }
              ],
              "status": {
                "code": 1
              }
            },
            {
              "traceId": "not_var{{TRACE_ID}}",
              "spanId": "N4tYw8jRpKd=",
              "parentSpanId": "Q3mTk9wPvBz=",
              "name": "convertCurrency",
              "kind": 3,
              "startTimeUnixNano": "not_var{{START_TIME_8}}",
              "endTimeUnixNano": "not_var{{END_TIME_8}}",
              "attributes": [
                {
                  "key": "rpc.system",
                  "value": {
                    "stringValue": "grpc"
                  }
                },
                {
                  "key": "rpc.service",
                  "value": {
                    "stringValue": "oteldemo.CurrencyService"
                  }
                },
                {
                  "key": "rpc.method",
                  "value": {
                    "stringValue": "Convert"
                  }
                }
              ],
              "status": {
                "code": 1
              }
            },
            {
              "traceId": "not_var{{TRACE_ID}}",
              "spanId": "Z7kPm5vQxLw=",
              "parentSpanId": "Q3mTk9wPvBz=",
              "name": "chargeCard",
              "kind": 3,
              "startTimeUnixNano": "not_var{{START_TIME_9}}",
              "endTimeUnixNano": "not_var{{END_TIME_9}}",
              "attributes": [
                {
                  "key": "rpc.system",
                  "value": {
                    "stringValue": "grpc"
                  }
                },
                {
                  "key": "rpc.service",
                  "value": {
                    "stringValue": "oteldemo.PaymentService"
                  }
                },
                {
                  "key": "rpc.method",
                  "value": {
                    "stringValue": "Charge"
                  }
                }
              ],
              "status": {
                "code": 1
              }
            },
            {
              "traceId": "not_var{{TRACE_ID}}",
              "spanId": "H8rBn3kMtQs=",
              "parentSpanId": "Q3mTk9wPvBz=",
              "name": "shipOrder",
              "kind": 3,
              "startTimeUnixNano": "not_var{{START_TIME_10}}",
              "endTimeUnixNano": "not_var{{END_TIME_10}}",
              "attributes": [
                {
                  "key": "rpc.system",
                  "value": {
                    "stringValue": "grpc"
                  }
                },
                {
                  "key": "rpc.service",
                  "value": {
                    "stringValue": "oteldemo.ShippingService"
                  }
                },
                {
                  "key": "rpc.method",
                  "value": {
                    "stringValue": "ShipOrder"
                  }
                }
              ],
              "status": {
                "code": 1
              }
            },
            {
              "traceId": "not_var{{TRACE_ID}}",
              "spanId": "K2wCp6nLvRx=",
              "parentSpanId": "Q3mTk9wPvBz=",
              "name": "sendOrderConfirmation",
              "kind": 3,
              "startTimeUnixNano": "not_var{{START_TIME_11}}",
              "endTimeUnixNano": "not_var{{END_TIME_11}}",
              "attributes": [
                {
                  "key": "rpc.system",
                  "value": {
                    "stringValue": "grpc"
                  }
                },
                {
                  "key": "rpc.service",
                  "value": {
                    "stringValue": "oteldemo.EmailService"
                  }
                },
                {
                  "key": "rpc.method",
                  "value": {
                    "stringValue": "SendOrderConfirmation"
                  }
                }
              ],
              "status": {
                "code": 1
              }
            }
          ]
        }
      ]
    },
    {
      "resource": {
        "attributes": [
          {
            "key": "service.name",
            "value": {
              "stringValue": "productcatalogservice"
            }
          },
          {
            "key": "service.version",
            "value": {
              "stringValue": "1.0.0"
            }
          },
          {
            "key": "telemetry.sdk.name",
            "value": {
              "stringValue": "opentelemetry"
            }
          },
          {
            "key": "telemetry.sdk.language",
            "value": {
              "stringValue": "go"
            }
          }
        ]
      },
      "scopeSpans": [
        {
          "scope": {
            "name": "productcatalog-tracer",
            "version": "1.0.0"
          },
          "spans": [
            {
              "traceId": "not_var{{TRACE_ID}}",
              "spanId": "F9vTj4mNqBk=",
              "parentSpanId": "L6hFr2sKxMv=",
              "name": "oteldemo.ProductCatalogService/GetProduct",
              "kind": 2,
              "startTimeUnixNano": "not_var{{START_TIME_12}}",
              "endTimeUnixNano": "not_var{{END_TIME_12}}",
              "attributes": [
                {
                  "key": "rpc.system",
                  "value": {
                    "stringValue": "grpc"
                  }
                },
                {
                  "key": "rpc.service",
                  "value": {
                    "stringValue": "oteldemo.ProductCatalogService"
                  }
                },
                {
                  "key": "rpc.method",
                  "value": {
                    "stringValue": "GetProduct"
                  }
                },
                {
                  "key": "app.product.id",
                  "value": {
                    "stringValue": "OLJCESPC7Z"
                  }
                }
              ],
              "status": {
                "code": 1
              }
            }
          ]
        }
      ]
    },
    {
      "resource": {
        "attributes": [
          {
            "key": "service.name",
            "value": {
              "stringValue": "currencyservice"
            }
          },
          {
            "key": "service.version",
            "value": {
              "stringValue": "1.0.0"
            }
          },
          {
            "key": "telemetry.sdk.name",
            "value": {
              "stringValue": "opentelemetry"
            }
          },
          {
            "key": "telemetry.sdk.language",
            "value": {
              "stringValue": "cpp"
            }
          }
        ]
      },
      "scopeSpans": [
        {
          "scope": {
            "name": "currency-tracer",
            "version": "1.0.0"
          },
          "spans": [
            {
              "traceId": "not_var{{TRACE_ID}}",
              "spanId": "D1sGk7xPwMn=",
              "parentSpanId": "N4tYw8jRpKd=",
              "name": "oteldemo.CurrencyService/Convert",
              "kind": 2,
              "startTimeUnixNano": "not_var{{START_TIME_13}}",
              "endTimeUnixNano": "not_var{{END_TIME_13}}",
              "attributes": [
                {
                  "key": "rpc.system",
                  "value": {
                    "stringValue": "grpc"
                  }
                },
                {
                  "key": "rpc.service",
                  "value": {
                    "stringValue": "oteldemo.CurrencyService"
                  }
                },
                {
                  "key": "rpc.method",
                  "value": {
                    "stringValue": "Convert"
                  }
                },
                {
                  "key": "app.currency.conversion.from",
                  "value": {
                    "stringValue": "USD"
                  }
                },
                {
                  "key": "app.currency.conversion.to",
                  "value": {
                    "stringValue": "EUR"
                  }
                }
              ],
              "status": {
                "code": 1
              }
            }
          ]
        }
      ]
    },
    {
      "resource": {
        "attributes": [
          {
            "key": "service.name",
            "value": {
              "stringValue": "paymentservice"
            }
          },
          {
            "key": "service.version",
            "value": {
              "stringValue": "1.0.0"
            }
          },
          {
            "key": "telemetry.sdk.name",
            "value": {
              "stringValue": "opentelemetry"
            }
          },
          {
            "key": "telemetry.sdk.language",
            "value": {
              "stringValue": "nodejs"
            }
          }
        ]
      },
      "scopeSpans": [
        {
          "scope": {
            "name": "payment-tracer",
            "version": "1.0.0"
          },
          "spans": [
            {
              "traceId": "not_var{{TRACE_ID}}",
              "spanId": "B5qHm2tKzPr=",
              "parentSpanId": "Z7kPm5vQxLw=",
              "name": "oteldemo.PaymentService/Charge",
              "kind": 2,
              "startTimeUnixNano": "not_var{{START_TIME_14}}",
              "endTimeUnixNano": "not_var{{END_TIME_14}}",
              "attributes": [
                {
                  "key": "rpc.system",
                  "value": {
                    "stringValue": "grpc"
                  }
                },
                {
                  "key": "rpc.service",
                  "value": {
                    "stringValue": "oteldemo.PaymentService"
                  }
                },
                {
                  "key": "rpc.method",
                  "value": {
                    "stringValue": "Charge"
                  }
                },
                {
                  "key": "app.payment.amount",
                  "value": {
                    "stringValue": "99.99"
                  }
                },
                {
                  "key": "app.payment.card_type",
                  "value": {
                    "stringValue": "visa"
                  }
                }
              ],
              "status": {
                "code": 1
              }
            }
          ]
        }
      ]
    }
  ]
}
```