---
editable: false
noIndex: true
---

# yc beta metadata-hub connection-manager connection update

Updates the specified connection.

#### Command Usage

Syntax:

`yc beta metadata-hub connection-manager connection update <CONNECTION-ID>`

#### Flags

#|
||Flag | Description ||
|| `--connection-id` | `string`

ID of the connection to update. ||
|| `--description` | `string`

New description for the connection. ||
|| `--labels` | `map<string><string>`

New connection labels as 'key:value' pairs. ||
|| `--name` | `string`

New name for the connection. ||
|| `--params` | `shorthand/json`

New connection parameters specific to the database or service type.

Shorthand Syntax:

```hcl
{
  type = clickhouse={
    auth = {
      security = user-password={
        password = {
          password-generation-options = {
            cookie = string,
            password-generation-options = lockbox-password-generation-options={
              excluded-punctuation = string,
              include-digits = boolean,
              include-lowercase = boolean,
              include-punctuation = boolean,
              include-uppercase = boolean,
              included-punctuation = string,
              length = integer
            }
          },
          raw = string,
          secret-key = lockbox-secret-key=string
        },
        user = string
      }
    },
    cluster = {
      hosts = [
        {
          health = HEALTH_UNKNOWN|ALIVE|DEAD|DEGRADED,
          host = string,
          http-port = integer,
          shard-name = string,
          tcp-port = integer
        }, ...
      ],
      shard-groups = [
        {
          name = string,
          shard-names = string,...
        }, ...
      ],
      tls-params = {
        tls-mode = disabled={} | tls={
          ca-certificate = string
        }
      }
    },
    databases = string,...,
    managed-cluster-id = string
  } | greenplum={
    auth = {
      security = user-password={
        password = {
          password-generation-options = {
            cookie = string,
            password-generation-options = lockbox-password-generation-options={
              excluded-punctuation = string,
              include-digits = boolean,
              include-lowercase = boolean,
              include-punctuation = boolean,
              include-uppercase = boolean,
              included-punctuation = string,
              length = integer
            }
          },
          raw = string,
          secret-key = lockbox-secret-key=string
        },
        user = string
      }
    },
    cluster = {
      coordinator-hosts = [
        {
          health = ALIVE|DEAD|DEGRADED|UNBALANCED,
          host = string,
          port = integer,
          role = MASTER|REPLICA
        }, ...
      ],
      tls-params = {
        tls-mode = disabled={} | tls={
          ca-certificate = string
        }
      }
    },
    databases = string,...,
    managed-cluster-id = string
  } | kafka={
    auth = {
      security = disabled={} | sasl={
        password = {
          password-generation-options = {
            cookie = string,
            password-generation-options = lockbox-password-generation-options={
              excluded-punctuation = string,
              include-digits = boolean,
              include-lowercase = boolean,
              include-punctuation = boolean,
              include-uppercase = boolean,
              included-punctuation = string,
              length = integer
            }
          },
          raw = string,
          secret-key = lockbox-secret-key=string
        },
        supported-mechanisms = [
          PLAIN|SCRAM_SHA256|SCRAM_SHA512, ...
        ],
        user = string
      }
    },
    cluster = {
      hosts = [
        {
          health = ALIVE|DEAD|DEGRADED,
          host = string,
          port = integer
        }, ...
      ],
      tls-params = {
        tls-mode = disabled={} | tls={
          ca-certificate = string
        }
      }
    },
    managed-cluster-id = string
  } | mongodb={
    auth = {
      auth-source = string,
      security = user-password={
        password = {
          password-generation-options = {
            cookie = string,
            password-generation-options = lockbox-password-generation-options={
              excluded-punctuation = string,
              include-digits = boolean,
              include-lowercase = boolean,
              include-punctuation = boolean,
              include-uppercase = boolean,
              included-punctuation = string,
              length = integer
            }
          },
          raw = string,
          secret-key = lockbox-secret-key=string
        },
        user = string
      }
    },
    cluster = {
      hosts = [
        {
          health = ALIVE|DEAD|DEGRADED,
          host = string,
          port = integer,
          role = PRIMARY|SECONDARY,
          type = MONGOD|MONGOS|MONGOINFRA
        }, ...
      ],
      tls-params = {
        tls-mode = disabled={} | tls={
          ca-certificate = string
        }
      }
    },
    databases = string,...,
    managed-cluster-id = string
  } | mysql={
    auth = {
      security = user-password={
        password = {
          password-generation-options = {
            cookie = string,
            password-generation-options = lockbox-password-generation-options={
              excluded-punctuation = string,
              include-digits = boolean,
              include-lowercase = boolean,
              include-punctuation = boolean,
              include-uppercase = boolean,
              included-punctuation = string,
              length = integer
            }
          },
          raw = string,
          secret-key = lockbox-secret-key=string
        },
        user = string
      }
    },
    cluster = {
      hosts = [
        {
          health = ALIVE|DEAD|DEGRADED|READONLY,
          host = string,
          port = integer,
          role = MASTER|REPLICA
        }, ...
      ],
      tls-params = {
        tls-mode = disabled={} | tls={
          ca-certificate = string
        }
      }
    },
    databases = string,...,
    managed-cluster-id = string
  } | opensearch={
    auth = {
      security = user-password={
        password = {
          password-generation-options = {
            cookie = string,
            password-generation-options = lockbox-password-generation-options={
              excluded-punctuation = string,
              include-digits = boolean,
              include-lowercase = boolean,
              include-punctuation = boolean,
              include-uppercase = boolean,
              included-punctuation = string,
              length = integer
            }
          },
          raw = string,
          secret-key = lockbox-secret-key=string
        },
        user = string
      }
    },
    cluster = {
      hosts = [
        {
          health = ALIVE|DEAD|DEGRADED|READONLY,
          host = string,
          port = integer,
          roles = [
            DATA|MANAGER, ...
          ]
        }, ...
      ],
      tls-params = {
        tls-mode = disabled={} | tls={
          ca-certificate = string
        }
      }
    },
    managed-cluster-id = string
  } | postgresql={
    auth = {
      security = user-password={
        password = {
          password-generation-options = {
            cookie = string,
            password-generation-options = lockbox-password-generation-options={
              excluded-punctuation = string,
              include-digits = boolean,
              include-lowercase = boolean,
              include-punctuation = boolean,
              include-uppercase = boolean,
              included-punctuation = string,
              length = integer
            }
          },
          raw = string,
          secret-key = lockbox-secret-key=string
        },
        user = string
      }
    },
    cluster = {
      hosts = [
        {
          health = ALIVE|DEAD|DEGRADED|READONLY,
          host = string,
          port = integer,
          replica-type = ASYNC|SYNC|QUORUM,
          role = MASTER|REPLICA
        }, ...
      ],
      tls-params = {
        tls-mode = disabled={} | tls={
          ca-certificate = string
        }
      }
    },
    databases = string,...,
    managed-cluster-id = string
  } | redis={
    auth = {
      security = user-password={
        password = {
          password-generation-options = {
            cookie = string,
            password-generation-options = lockbox-password-generation-options={
              excluded-punctuation = string,
              include-digits = boolean,
              include-lowercase = boolean,
              include-punctuation = boolean,
              include-uppercase = boolean,
              included-punctuation = string,
              length = integer
            }
          },
          raw = string,
          secret-key = lockbox-secret-key=string
        },
        user = string
      }
    },
    cluster = {
      hosts = [
        {
          health = ALIVE|DEAD|DEGRADED,
          host = string,
          port = integer,
          role = MASTER|REPLICA,
          shard-name = string
        }, ...
      ],
      sentinel-port = integer,
      tls-params = {
        tls-mode = disabled={} | tls={
          ca-certificate = string
        }
      }
    },
    databases = integer,...
  } | storedoc={
    auth = {
      auth-source = string,
      security = user-password={
        password = {
          password-generation-options = {
            cookie = string,
            password-generation-options = lockbox-password-generation-options={
              excluded-punctuation = string,
              include-digits = boolean,
              include-lowercase = boolean,
              include-punctuation = boolean,
              include-uppercase = boolean,
              included-punctuation = string,
              length = integer
            }
          },
          raw = string,
          secret-key = lockbox-secret-key=string
        },
        user = string
      }
    },
    cluster = {
      hosts = [
        {
          health = ALIVE|DEAD|DEGRADED,
          host = string,
          port = integer,
          role = PRIMARY|SECONDARY,
          type = MONGOD|MONGOS|MONGOINFRA
        }, ...
      ],
      tls-params = {
        tls-mode = disabled={} | tls={
          ca-certificate = string
        }
      }
    },
    databases = string,...,
    managed-cluster-id = string
  } | trino={
    auth = {
      security = user-password={
        password = {
          password-generation-options = {
            cookie = string,
            password-generation-options = lockbox-password-generation-options={
              excluded-punctuation = string,
              include-digits = boolean,
              include-lowercase = boolean,
              include-punctuation = boolean,
              include-uppercase = boolean,
              included-punctuation = string,
              length = integer
            }
          },
          raw = string,
          secret-key = lockbox-secret-key=string
        },
        user = string
      }
    },
    cluster = {
      coordinator = {
        host = string,
        port = integer
      },
      tls-params = {
        tls-mode = disabled={} | tls={
          ca-certificate = string
        }
      }
    }
  } | valkey={
    auth = {
      security = user-password={
        password = {
          password-generation-options = {
            cookie = string,
            password-generation-options = lockbox-password-generation-options={
              excluded-punctuation = string,
              include-digits = boolean,
              include-lowercase = boolean,
              include-punctuation = boolean,
              include-uppercase = boolean,
              included-punctuation = string,
              length = integer
            }
          },
          raw = string,
          secret-key = lockbox-secret-key=string
        },
        user = string
      }
    },
    cluster = {
      hosts = [
        {
          health = ALIVE|DEAD|DEGRADED,
          host = string,
          port = integer,
          role = MASTER|REPLICA,
          shard-name = string
        }, ...
      ],
      sentinel-port = integer,
      tls-params = {
        tls-mode = disabled={} | tls={
          ca-certificate = string
        }
      }
    },
    databases = integer,...,
    managed-cluster-id = string
  }
}
```

JSON Syntax:

```json
{
  "type": {
    "clickhouse": {
      "auth": {
        "security": {
          "user-password": {
            "password": {
              "password-generation-options": {
                "cookie": "string",
                "password-generation-options": {
                  "lockbox-password-generation-options": {
                    "excluded-punctuation": "string",
                    "include-digits": "boolean",
                    "include-lowercase": "boolean",
                    "include-punctuation": "boolean",
                    "include-uppercase": "boolean",
                    "included-punctuation": "string",
                    "length": "integer"
                  }
                }
              },
              "raw": "string",
              "secret-key": {
                "lockbox-secret-key": "string"
              }
            },
            "user": "string"
          }
        }
      },
      "cluster": {
        "hosts": [
          {
            "health": "HEALTH_UNKNOWN|ALIVE|DEAD|DEGRADED",
            "host": "string",
            "http-port": "integer",
            "shard-name": "string",
            "tcp-port": "integer"
          }, ...
        ],
        "shard-groups": [
          {
            "name": "string",
            "shard-names": [
              "string", ...
            ]
          }, ...
        ],
        "tls-params": {
          "tls-mode": {
            "disabled": {},
            "tls": {
              "ca-certificate": "string"
            }
          }
        }
      },
      "databases": [
        "string", ...
      ],
      "managed-cluster-id": "string"
    },
    "greenplum": {
      "auth": {
        "security": {
          "user-password": {
            "password": {
              "password-generation-options": {
                "cookie": "string",
                "password-generation-options": {
                  "lockbox-password-generation-options": {
                    "excluded-punctuation": "string",
                    "include-digits": "boolean",
                    "include-lowercase": "boolean",
                    "include-punctuation": "boolean",
                    "include-uppercase": "boolean",
                    "included-punctuation": "string",
                    "length": "integer"
                  }
                }
              },
              "raw": "string",
              "secret-key": {
                "lockbox-secret-key": "string"
              }
            },
            "user": "string"
          }
        }
      },
      "cluster": {
        "coordinator-hosts": [
          {
            "health": "ALIVE|DEAD|DEGRADED|UNBALANCED",
            "host": "string",
            "port": "integer",
            "role": "MASTER|REPLICA"
          }, ...
        ],
        "tls-params": {
          "tls-mode": {
            "disabled": {},
            "tls": {
              "ca-certificate": "string"
            }
          }
        }
      },
      "databases": [
        "string", ...
      ],
      "managed-cluster-id": "string"
    },
    "kafka": {
      "auth": {
        "security": {
          "disabled": {},
          "sasl": {
            "password": {
              "password-generation-options": {
                "cookie": "string",
                "password-generation-options": {
                  "lockbox-password-generation-options": {
                    "excluded-punctuation": "string",
                    "include-digits": "boolean",
                    "include-lowercase": "boolean",
                    "include-punctuation": "boolean",
                    "include-uppercase": "boolean",
                    "included-punctuation": "string",
                    "length": "integer"
                  }
                }
              },
              "raw": "string",
              "secret-key": {
                "lockbox-secret-key": "string"
              }
            },
            "supported-mechanisms": [
              "PLAIN|SCRAM_SHA256|SCRAM_SHA512", ...
            ],
            "user": "string"
          }
        }
      },
      "cluster": {
        "hosts": [
          {
            "health": "ALIVE|DEAD|DEGRADED",
            "host": "string",
            "port": "integer"
          }, ...
        ],
        "tls-params": {
          "tls-mode": {
            "disabled": {},
            "tls": {
              "ca-certificate": "string"
            }
          }
        }
      },
      "managed-cluster-id": "string"
    },
    "mongodb": {
      "auth": {
        "auth-source": "string",
        "security": {
          "user-password": {
            "password": {
              "password-generation-options": {
                "cookie": "string",
                "password-generation-options": {
                  "lockbox-password-generation-options": {
                    "excluded-punctuation": "string",
                    "include-digits": "boolean",
                    "include-lowercase": "boolean",
                    "include-punctuation": "boolean",
                    "include-uppercase": "boolean",
                    "included-punctuation": "string",
                    "length": "integer"
                  }
                }
              },
              "raw": "string",
              "secret-key": {
                "lockbox-secret-key": "string"
              }
            },
            "user": "string"
          }
        }
      },
      "cluster": {
        "hosts": [
          {
            "health": "ALIVE|DEAD|DEGRADED",
            "host": "string",
            "port": "integer",
            "role": "PRIMARY|SECONDARY",
            "type": "MONGOD|MONGOS|MONGOINFRA"
          }, ...
        ],
        "tls-params": {
          "tls-mode": {
            "disabled": {},
            "tls": {
              "ca-certificate": "string"
            }
          }
        }
      },
      "databases": [
        "string", ...
      ],
      "managed-cluster-id": "string"
    },
    "mysql": {
      "auth": {
        "security": {
          "user-password": {
            "password": {
              "password-generation-options": {
                "cookie": "string",
                "password-generation-options": {
                  "lockbox-password-generation-options": {
                    "excluded-punctuation": "string",
                    "include-digits": "boolean",
                    "include-lowercase": "boolean",
                    "include-punctuation": "boolean",
                    "include-uppercase": "boolean",
                    "included-punctuation": "string",
                    "length": "integer"
                  }
                }
              },
              "raw": "string",
              "secret-key": {
                "lockbox-secret-key": "string"
              }
            },
            "user": "string"
          }
        }
      },
      "cluster": {
        "hosts": [
          {
            "health": "ALIVE|DEAD|DEGRADED|READONLY",
            "host": "string",
            "port": "integer",
            "role": "MASTER|REPLICA"
          }, ...
        ],
        "tls-params": {
          "tls-mode": {
            "disabled": {},
            "tls": {
              "ca-certificate": "string"
            }
          }
        }
      },
      "databases": [
        "string", ...
      ],
      "managed-cluster-id": "string"
    },
    "opensearch": {
      "auth": {
        "security": {
          "user-password": {
            "password": {
              "password-generation-options": {
                "cookie": "string",
                "password-generation-options": {
                  "lockbox-password-generation-options": {
                    "excluded-punctuation": "string",
                    "include-digits": "boolean",
                    "include-lowercase": "boolean",
                    "include-punctuation": "boolean",
                    "include-uppercase": "boolean",
                    "included-punctuation": "string",
                    "length": "integer"
                  }
                }
              },
              "raw": "string",
              "secret-key": {
                "lockbox-secret-key": "string"
              }
            },
            "user": "string"
          }
        }
      },
      "cluster": {
        "hosts": [
          {
            "health": "ALIVE|DEAD|DEGRADED|READONLY",
            "host": "string",
            "port": "integer",
            "roles": [
              "DATA|MANAGER", ...
            ]
          }, ...
        ],
        "tls-params": {
          "tls-mode": {
            "disabled": {},
            "tls": {
              "ca-certificate": "string"
            }
          }
        }
      },
      "managed-cluster-id": "string"
    },
    "postgresql": {
      "auth": {
        "security": {
          "user-password": {
            "password": {
              "password-generation-options": {
                "cookie": "string",
                "password-generation-options": {
                  "lockbox-password-generation-options": {
                    "excluded-punctuation": "string",
                    "include-digits": "boolean",
                    "include-lowercase": "boolean",
                    "include-punctuation": "boolean",
                    "include-uppercase": "boolean",
                    "included-punctuation": "string",
                    "length": "integer"
                  }
                }
              },
              "raw": "string",
              "secret-key": {
                "lockbox-secret-key": "string"
              }
            },
            "user": "string"
          }
        }
      },
      "cluster": {
        "hosts": [
          {
            "health": "ALIVE|DEAD|DEGRADED|READONLY",
            "host": "string",
            "port": "integer",
            "replica-type": "ASYNC|SYNC|QUORUM",
            "role": "MASTER|REPLICA"
          }, ...
        ],
        "tls-params": {
          "tls-mode": {
            "disabled": {},
            "tls": {
              "ca-certificate": "string"
            }
          }
        }
      },
      "databases": [
        "string", ...
      ],
      "managed-cluster-id": "string"
    },
    "redis": {
      "auth": {
        "security": {
          "user-password": {
            "password": {
              "password-generation-options": {
                "cookie": "string",
                "password-generation-options": {
                  "lockbox-password-generation-options": {
                    "excluded-punctuation": "string",
                    "include-digits": "boolean",
                    "include-lowercase": "boolean",
                    "include-punctuation": "boolean",
                    "include-uppercase": "boolean",
                    "included-punctuation": "string",
                    "length": "integer"
                  }
                }
              },
              "raw": "string",
              "secret-key": {
                "lockbox-secret-key": "string"
              }
            },
            "user": "string"
          }
        }
      },
      "cluster": {
        "hosts": [
          {
            "health": "ALIVE|DEAD|DEGRADED",
            "host": "string",
            "port": "integer",
            "role": "MASTER|REPLICA",
            "shard-name": "string"
          }, ...
        ],
        "sentinel-port": "integer",
        "tls-params": {
          "tls-mode": {
            "disabled": {},
            "tls": {
              "ca-certificate": "string"
            }
          }
        }
      },
      "databases": [
        "integer", ...
      ]
    },
    "storedoc": {
      "auth": {
        "auth-source": "string",
        "security": {
          "user-password": {
            "password": {
              "password-generation-options": {
                "cookie": "string",
                "password-generation-options": {
                  "lockbox-password-generation-options": {
                    "excluded-punctuation": "string",
                    "include-digits": "boolean",
                    "include-lowercase": "boolean",
                    "include-punctuation": "boolean",
                    "include-uppercase": "boolean",
                    "included-punctuation": "string",
                    "length": "integer"
                  }
                }
              },
              "raw": "string",
              "secret-key": {
                "lockbox-secret-key": "string"
              }
            },
            "user": "string"
          }
        }
      },
      "cluster": {
        "hosts": [
          {
            "health": "ALIVE|DEAD|DEGRADED",
            "host": "string",
            "port": "integer",
            "role": "PRIMARY|SECONDARY",
            "type": "MONGOD|MONGOS|MONGOINFRA"
          }, ...
        ],
        "tls-params": {
          "tls-mode": {
            "disabled": {},
            "tls": {
              "ca-certificate": "string"
            }
          }
        }
      },
      "databases": [
        "string", ...
      ],
      "managed-cluster-id": "string"
    },
    "trino": {
      "auth": {
        "security": {
          "user-password": {
            "password": {
              "password-generation-options": {
                "cookie": "string",
                "password-generation-options": {
                  "lockbox-password-generation-options": {
                    "excluded-punctuation": "string",
                    "include-digits": "boolean",
                    "include-lowercase": "boolean",
                    "include-punctuation": "boolean",
                    "include-uppercase": "boolean",
                    "included-punctuation": "string",
                    "length": "integer"
                  }
                }
              },
              "raw": "string",
              "secret-key": {
                "lockbox-secret-key": "string"
              }
            },
            "user": "string"
          }
        }
      },
      "cluster": {
        "coordinator": {
          "host": "string",
          "port": "integer"
        },
        "tls-params": {
          "tls-mode": {
            "disabled": {},
            "tls": {
              "ca-certificate": "string"
            }
          }
        }
      }
    },
    "valkey": {
      "auth": {
        "security": {
          "user-password": {
            "password": {
              "password-generation-options": {
                "cookie": "string",
                "password-generation-options": {
                  "lockbox-password-generation-options": {
                    "excluded-punctuation": "string",
                    "include-digits": "boolean",
                    "include-lowercase": "boolean",
                    "include-punctuation": "boolean",
                    "include-uppercase": "boolean",
                    "included-punctuation": "string",
                    "length": "integer"
                  }
                }
              },
              "raw": "string",
              "secret-key": {
                "lockbox-secret-key": "string"
              }
            },
            "user": "string"
          }
        }
      },
      "cluster": {
        "hosts": [
          {
            "health": "ALIVE|DEAD|DEGRADED",
            "host": "string",
            "port": "integer",
            "role": "MASTER|REPLICA",
            "shard-name": "string"
          }, ...
        ],
        "sentinel-port": "integer",
        "tls-params": {
          "tls-mode": {
            "disabled": {},
            "tls": {
              "ca-certificate": "string"
            }
          }
        }
      },
      "databases": [
        "integer", ...
      ],
      "managed-cluster-id": "string"
    }
  }
}
```

Fields:

```
type -> (oneof<clickhouse|greenplum|kafka|mongodb|mysql|opensearch|postgresql|redis|storedoc|trino|valkey>)
  Oneof type field
  postgresql -> (struct)
    PostgreSQL database connection parameters.
    auth -> (struct)
      security -> (oneof<user-password>)
        Oneof security field
        user-password -> (struct)
          password -> (struct)
            password-generation-options -> (struct)
              When creating/updating Password, the field "password_generation_options" is mutually exclusive with "raw". In order to switch to the "password_generation_options" you have to explicitly clear the "raw" field.
              cookie -> (string)
                Cookie is an arbitrary non-sensitive string that is saved with the password. When updating PasswordGenerationOptions, if the cookie passed in the update request differs from the cookie in the current PasswordGenerationOptions, the password will be re-generated. If the same cookie is passed, the password will not change.
              password-generation-options -> (oneof<lockbox-password-generation-options>)
                Oneof password-generation-options field
                lockbox-password-generation-options -> (struct)
                  excluded-punctuation -> (string)
                    a string of punctuation characters to exclude from the default
                  include-digits -> (boolean)
                    whether at least one 0..9 character is included in the password, true by default
                  include-lowercase -> (boolean)
                    whether at least one a..z character is included in the password, true by default
                  include-punctuation -> (boolean)
                    whether at least one punctuation character is included in the password, true by default punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_'{|}~ to customize the punctuation characters, see included_punctuation and excluded_punctuation below
                  include-uppercase -> (boolean)
                    whether at least one A..Z character is included in the password, true by default
                  included-punctuation -> (string)
                    If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation: a string of specific punctuation characters to use
                  length -> (integer)
                    password length; by default, a reasonable length will be decided
            raw -> (string)
              When creating/updating Password, the field "raw" is mutually exclusive with "password_generation_options". In order to switch to the "raw" password you have to explicitly clear the "password_generation_options" field.
            secret-key -> (oneof<lockbox-secret-key>)
              Oneof secret-key field
              lockbox-secret-key -> (string)
                Read-only. Do not fill this field in create/update requests.
          user -> (string)
    cluster -> (struct)
      When creating/updating Connection, the field "cluster" is mutually exclusive with "managed_cluster_id".
      hosts -> ([]struct)
        health -> (struct)
        host -> (string)
        port -> (integer)
        replica-type -> (struct)
        role -> (struct)
      tls-params -> (struct)
        tls-mode -> (oneof<disabled|tls>)
          Oneof tls-mode field
          disabled -> (struct)
          tls -> (struct)
            ca-certificate -> (string)
    databases -> ([]string)
    managed-cluster-id -> (string)
      When creating/updating Connection, the field "managed_cluster_id" is mutually exclusive with "cluster".
  mysql -> (struct)
    MySQL database connection parameters.
    auth -> (struct)
      security -> (oneof<user-password>)
        Oneof security field
        user-password -> (struct)
          password -> (struct)
            password-generation-options -> (struct)
              When creating/updating Password, the field "password_generation_options" is mutually exclusive with "raw". In order to switch to the "password_generation_options" you have to explicitly clear the "raw" field.
              cookie -> (string)
                Cookie is an arbitrary non-sensitive string that is saved with the password. When updating PasswordGenerationOptions, if the cookie passed in the update request differs from the cookie in the current PasswordGenerationOptions, the password will be re-generated. If the same cookie is passed, the password will not change.
              password-generation-options -> (oneof<lockbox-password-generation-options>)
                Oneof password-generation-options field
                lockbox-password-generation-options -> (struct)
                  excluded-punctuation -> (string)
                    a string of punctuation characters to exclude from the default
                  include-digits -> (boolean)
                    whether at least one 0..9 character is included in the password, true by default
                  include-lowercase -> (boolean)
                    whether at least one a..z character is included in the password, true by default
                  include-punctuation -> (boolean)
                    whether at least one punctuation character is included in the password, true by default punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_'{|}~ to customize the punctuation characters, see included_punctuation and excluded_punctuation below
                  include-uppercase -> (boolean)
                    whether at least one A..Z character is included in the password, true by default
                  included-punctuation -> (string)
                    If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation: a string of specific punctuation characters to use
                  length -> (integer)
                    password length; by default, a reasonable length will be decided
            raw -> (string)
              When creating/updating Password, the field "raw" is mutually exclusive with "password_generation_options". In order to switch to the "raw" password you have to explicitly clear the "password_generation_options" field.
            secret-key -> (oneof<lockbox-secret-key>)
              Oneof secret-key field
              lockbox-secret-key -> (string)
                Read-only. Do not fill this field in create/update requests.
          user -> (string)
    cluster -> (struct)
      When creating/updating Connection, the field "cluster" is mutually exclusive with "managed_cluster_id".
      hosts -> ([]struct)
        health -> (struct)
        host -> (string)
        port -> (integer)
        role -> (struct)
      tls-params -> (struct)
        tls-mode -> (oneof<disabled|tls>)
          Oneof tls-mode field
          disabled -> (struct)
          tls -> (struct)
            ca-certificate -> (string)
    databases -> ([]string)
    managed-cluster-id -> (string)
      When creating/updating Connection, the field "managed_cluster_id" is mutually exclusive with "cluster".
  mongodb -> (struct)
    MongoDB database connection parameters.
    auth -> (struct)
      auth-source -> (string)
      security -> (oneof<user-password>)
        Oneof security field
        user-password -> (struct)
          password -> (struct)
            password-generation-options -> (struct)
              When creating/updating Password, the field "password_generation_options" is mutually exclusive with "raw". In order to switch to the "password_generation_options" you have to explicitly clear the "raw" field.
              cookie -> (string)
                Cookie is an arbitrary non-sensitive string that is saved with the password. When updating PasswordGenerationOptions, if the cookie passed in the update request differs from the cookie in the current PasswordGenerationOptions, the password will be re-generated. If the same cookie is passed, the password will not change.
              password-generation-options -> (oneof<lockbox-password-generation-options>)
                Oneof password-generation-options field
                lockbox-password-generation-options -> (struct)
                  excluded-punctuation -> (string)
                    a string of punctuation characters to exclude from the default
                  include-digits -> (boolean)
                    whether at least one 0..9 character is included in the password, true by default
                  include-lowercase -> (boolean)
                    whether at least one a..z character is included in the password, true by default
                  include-punctuation -> (boolean)
                    whether at least one punctuation character is included in the password, true by default punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_'{|}~ to customize the punctuation characters, see included_punctuation and excluded_punctuation below
                  include-uppercase -> (boolean)
                    whether at least one A..Z character is included in the password, true by default
                  included-punctuation -> (string)
                    If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation: a string of specific punctuation characters to use
                  length -> (integer)
                    password length; by default, a reasonable length will be decided
            raw -> (string)
              When creating/updating Password, the field "raw" is mutually exclusive with "password_generation_options". In order to switch to the "raw" password you have to explicitly clear the "password_generation_options" field.
            secret-key -> (oneof<lockbox-secret-key>)
              Oneof secret-key field
              lockbox-secret-key -> (string)
                Read-only. Do not fill this field in create/update requests.
          user -> (string)
    cluster -> (struct)
      When creating/updating Connection, the field "cluster" is mutually exclusive with "managed_cluster_id".
      hosts -> ([]struct)
        health -> (struct)
        host -> (string)
        port -> (integer)
        role -> (struct)
        type -> (struct)
      tls-params -> (struct)
        tls-mode -> (oneof<disabled|tls>)
          Oneof tls-mode field
          disabled -> (struct)
          tls -> (struct)
            ca-certificate -> (string)
    databases -> ([]string)
    managed-cluster-id -> (string)
      When creating/updating Connection, the field "managed_cluster_id" is mutually exclusive with "cluster".
  clickhouse -> (struct)
    ClickHouse database connection parameters.
    auth -> (struct)
      security -> (oneof<user-password>)
        Oneof security field
        user-password -> (struct)
          password -> (struct)
            password-generation-options -> (struct)
              When creating/updating Password, the field "password_generation_options" is mutually exclusive with "raw". In order to switch to the "password_generation_options" you have to explicitly clear the "raw" field.
              cookie -> (string)
                Cookie is an arbitrary non-sensitive string that is saved with the password. When updating PasswordGenerationOptions, if the cookie passed in the update request differs from the cookie in the current PasswordGenerationOptions, the password will be re-generated. If the same cookie is passed, the password will not change.
              password-generation-options -> (oneof<lockbox-password-generation-options>)
                Oneof password-generation-options field
                lockbox-password-generation-options -> (struct)
                  excluded-punctuation -> (string)
                    a string of punctuation characters to exclude from the default
                  include-digits -> (boolean)
                    whether at least one 0..9 character is included in the password, true by default
                  include-lowercase -> (boolean)
                    whether at least one a..z character is included in the password, true by default
                  include-punctuation -> (boolean)
                    whether at least one punctuation character is included in the password, true by default punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_'{|}~ to customize the punctuation characters, see included_punctuation and excluded_punctuation below
                  include-uppercase -> (boolean)
                    whether at least one A..Z character is included in the password, true by default
                  included-punctuation -> (string)
                    If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation: a string of specific punctuation characters to use
                  length -> (integer)
                    password length; by default, a reasonable length will be decided
            raw -> (string)
              When creating/updating Password, the field "raw" is mutually exclusive with "password_generation_options". In order to switch to the "raw" password you have to explicitly clear the "password_generation_options" field.
            secret-key -> (oneof<lockbox-secret-key>)
              Oneof secret-key field
              lockbox-secret-key -> (string)
                Read-only. Do not fill this field in create/update requests.
          user -> (string)
    cluster -> (struct)
      When creating/updating Connection, the field "cluster" is mutually exclusive with "managed_cluster_id".
      hosts -> ([]struct)
        health -> (struct)
        host -> (string)
        http-port -> (integer)
          depends on tls params may vary as http or https
        shard-name -> (string)
        tcp-port -> (integer)
      shard-groups -> ([]struct)
        name -> (string)
        shard-names -> ([]string)
      tls-params -> (struct)
        tls-mode -> (oneof<disabled|tls>)
          Oneof tls-mode field
          disabled -> (struct)
          tls -> (struct)
            ca-certificate -> (string)
    databases -> ([]string)
    managed-cluster-id -> (string)
      When creating/updating Connection, the field "managed_cluster_id" is mutually exclusive with "cluster".
  kafka -> (struct)
    Apache Kafka message broker connection parameters.
    auth -> (struct)
      security -> (oneof<disabled|sasl>)
        Oneof security field
        sasl -> (struct)
          password -> (struct)
            password-generation-options -> (struct)
              When creating/updating Password, the field "password_generation_options" is mutually exclusive with "raw". In order to switch to the "password_generation_options" you have to explicitly clear the "raw" field.
              cookie -> (string)
                Cookie is an arbitrary non-sensitive string that is saved with the password. When updating PasswordGenerationOptions, if the cookie passed in the update request differs from the cookie in the current PasswordGenerationOptions, the password will be re-generated. If the same cookie is passed, the password will not change.
              password-generation-options -> (oneof<lockbox-password-generation-options>)
                Oneof password-generation-options field
                lockbox-password-generation-options -> (struct)
                  excluded-punctuation -> (string)
                    a string of punctuation characters to exclude from the default
                  include-digits -> (boolean)
                    whether at least one 0..9 character is included in the password, true by default
                  include-lowercase -> (boolean)
                    whether at least one a..z character is included in the password, true by default
                  include-punctuation -> (boolean)
                    whether at least one punctuation character is included in the password, true by default punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_'{|}~ to customize the punctuation characters, see included_punctuation and excluded_punctuation below
                  include-uppercase -> (boolean)
                    whether at least one A..Z character is included in the password, true by default
                  included-punctuation -> (string)
                    If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation: a string of specific punctuation characters to use
                  length -> (integer)
                    password length; by default, a reasonable length will be decided
            raw -> (string)
              When creating/updating Password, the field "raw" is mutually exclusive with "password_generation_options". In order to switch to the "raw" password you have to explicitly clear the "password_generation_options" field.
            secret-key -> (oneof<lockbox-secret-key>)
              Oneof secret-key field
              lockbox-secret-key -> (string)
                Read-only. Do not fill this field in create/update requests.
          supported-mechanisms -> ([]struct)
          user -> (string)
        disabled -> (struct)
    cluster -> (struct)
      When creating/updating Connection, the field "cluster" is mutually exclusive with "managed_cluster_id".
      hosts -> ([]struct)
        health -> (struct)
        host -> (string)
        port -> (integer)
      tls-params -> (struct)
        tls-mode -> (oneof<disabled|tls>)
          Oneof tls-mode field
          disabled -> (struct)
          tls -> (struct)
            ca-certificate -> (string)
    managed-cluster-id -> (string)
      When creating/updating Connection, the field "managed_cluster_id" is mutually exclusive with "cluster".
  redis -> (struct)
    Redis in-memory data store connection parameters.
    auth -> (struct)
      security -> (oneof<user-password>)
        Oneof security field
        user-password -> (struct)
          password -> (struct)
            password-generation-options -> (struct)
              When creating/updating Password, the field "password_generation_options" is mutually exclusive with "raw". In order to switch to the "password_generation_options" you have to explicitly clear the "raw" field.
              cookie -> (string)
                Cookie is an arbitrary non-sensitive string that is saved with the password. When updating PasswordGenerationOptions, if the cookie passed in the update request differs from the cookie in the current PasswordGenerationOptions, the password will be re-generated. If the same cookie is passed, the password will not change.
              password-generation-options -> (oneof<lockbox-password-generation-options>)
                Oneof password-generation-options field
                lockbox-password-generation-options -> (struct)
                  excluded-punctuation -> (string)
                    a string of punctuation characters to exclude from the default
                  include-digits -> (boolean)
                    whether at least one 0..9 character is included in the password, true by default
                  include-lowercase -> (boolean)
                    whether at least one a..z character is included in the password, true by default
                  include-punctuation -> (boolean)
                    whether at least one punctuation character is included in the password, true by default punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_'{|}~ to customize the punctuation characters, see included_punctuation and excluded_punctuation below
                  include-uppercase -> (boolean)
                    whether at least one A..Z character is included in the password, true by default
                  included-punctuation -> (string)
                    If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation: a string of specific punctuation characters to use
                  length -> (integer)
                    password length; by default, a reasonable length will be decided
            raw -> (string)
              When creating/updating Password, the field "raw" is mutually exclusive with "password_generation_options". In order to switch to the "raw" password you have to explicitly clear the "password_generation_options" field.
            secret-key -> (oneof<lockbox-secret-key>)
              Oneof secret-key field
              lockbox-secret-key -> (string)
                Read-only. Do not fill this field in create/update requests.
          user -> (string)
    cluster -> (struct)
      hosts -> ([]struct)
        health -> (struct)
        host -> (string)
        port -> (integer)
        role -> (struct)
        shard-name -> (string)
      sentinel-port -> (integer)
      tls-params -> (struct)
        tls-mode -> (oneof<disabled|tls>)
          Oneof tls-mode field
          disabled -> (struct)
          tls -> (struct)
            ca-certificate -> (string)
    databases -> ([]integer)
  opensearch -> (struct)
    OpenSearch search engine connection parameters.
    auth -> (struct)
      security -> (oneof<user-password>)
        Oneof security field
        user-password -> (struct)
          password -> (struct)
            password-generation-options -> (struct)
              When creating/updating Password, the field "password_generation_options" is mutually exclusive with "raw". In order to switch to the "password_generation_options" you have to explicitly clear the "raw" field.
              cookie -> (string)
                Cookie is an arbitrary non-sensitive string that is saved with the password. When updating PasswordGenerationOptions, if the cookie passed in the update request differs from the cookie in the current PasswordGenerationOptions, the password will be re-generated. If the same cookie is passed, the password will not change.
              password-generation-options -> (oneof<lockbox-password-generation-options>)
                Oneof password-generation-options field
                lockbox-password-generation-options -> (struct)
                  excluded-punctuation -> (string)
                    a string of punctuation characters to exclude from the default
                  include-digits -> (boolean)
                    whether at least one 0..9 character is included in the password, true by default
                  include-lowercase -> (boolean)
                    whether at least one a..z character is included in the password, true by default
                  include-punctuation -> (boolean)
                    whether at least one punctuation character is included in the password, true by default punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_'{|}~ to customize the punctuation characters, see included_punctuation and excluded_punctuation below
                  include-uppercase -> (boolean)
                    whether at least one A..Z character is included in the password, true by default
                  included-punctuation -> (string)
                    If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation: a string of specific punctuation characters to use
                  length -> (integer)
                    password length; by default, a reasonable length will be decided
            raw -> (string)
              When creating/updating Password, the field "raw" is mutually exclusive with "password_generation_options". In order to switch to the "raw" password you have to explicitly clear the "password_generation_options" field.
            secret-key -> (oneof<lockbox-secret-key>)
              Oneof secret-key field
              lockbox-secret-key -> (string)
                Read-only. Do not fill this field in create/update requests.
          user -> (string)
    cluster -> (struct)
      When creating/updating Connection, the field "cluster" is mutually exclusive with "managed_cluster_id".
      hosts -> ([]struct)
        health -> (struct)
        host -> (string)
        port -> (integer)
        roles -> ([]struct)
      tls-params -> (struct)
        tls-mode -> (oneof<disabled|tls>)
          Oneof tls-mode field
          disabled -> (struct)
          tls -> (struct)
            ca-certificate -> (string)
    managed-cluster-id -> (string)
      When creating/updating Connection, the field "managed_cluster_id" is mutually exclusive with "cluster".
  trino -> (struct)
    Trino distributed SQL query engine connection parameters.
    auth -> (struct)
      security -> (oneof<user-password>)
        Oneof security field
        user-password -> (struct)
          password -> (struct)
            password-generation-options -> (struct)
              When creating/updating Password, the field "password_generation_options" is mutually exclusive with "raw". In order to switch to the "password_generation_options" you have to explicitly clear the "raw" field.
              cookie -> (string)
                Cookie is an arbitrary non-sensitive string that is saved with the password. When updating PasswordGenerationOptions, if the cookie passed in the update request differs from the cookie in the current PasswordGenerationOptions, the password will be re-generated. If the same cookie is passed, the password will not change.
              password-generation-options -> (oneof<lockbox-password-generation-options>)
                Oneof password-generation-options field
                lockbox-password-generation-options -> (struct)
                  excluded-punctuation -> (string)
                    a string of punctuation characters to exclude from the default
                  include-digits -> (boolean)
                    whether at least one 0..9 character is included in the password, true by default
                  include-lowercase -> (boolean)
                    whether at least one a..z character is included in the password, true by default
                  include-punctuation -> (boolean)
                    whether at least one punctuation character is included in the password, true by default punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_'{|}~ to customize the punctuation characters, see included_punctuation and excluded_punctuation below
                  include-uppercase -> (boolean)
                    whether at least one A..Z character is included in the password, true by default
                  included-punctuation -> (string)
                    If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation: a string of specific punctuation characters to use
                  length -> (integer)
                    password length; by default, a reasonable length will be decided
            raw -> (string)
              When creating/updating Password, the field "raw" is mutually exclusive with "password_generation_options". In order to switch to the "raw" password you have to explicitly clear the "password_generation_options" field.
            secret-key -> (oneof<lockbox-secret-key>)
              Oneof secret-key field
              lockbox-secret-key -> (string)
                Read-only. Do not fill this field in create/update requests.
          user -> (string)
    cluster -> (struct)
      coordinator -> (struct)
        host -> (string)
        port -> (integer)
      tls-params -> (struct)
        tls-mode -> (oneof<disabled|tls>)
          Oneof tls-mode field
          disabled -> (struct)
          tls -> (struct)
            ca-certificate -> (string)
  valkey -> (struct)
    Valkey in-memory data store connection parameters.
    auth -> (struct)
      security -> (oneof<user-password>)
        Oneof security field
        user-password -> (struct)
          password -> (struct)
            password-generation-options -> (struct)
              When creating/updating Password, the field "password_generation_options" is mutually exclusive with "raw". In order to switch to the "password_generation_options" you have to explicitly clear the "raw" field.
              cookie -> (string)
                Cookie is an arbitrary non-sensitive string that is saved with the password. When updating PasswordGenerationOptions, if the cookie passed in the update request differs from the cookie in the current PasswordGenerationOptions, the password will be re-generated. If the same cookie is passed, the password will not change.
              password-generation-options -> (oneof<lockbox-password-generation-options>)
                Oneof password-generation-options field
                lockbox-password-generation-options -> (struct)
                  excluded-punctuation -> (string)
                    a string of punctuation characters to exclude from the default
                  include-digits -> (boolean)
                    whether at least one 0..9 character is included in the password, true by default
                  include-lowercase -> (boolean)
                    whether at least one a..z character is included in the password, true by default
                  include-punctuation -> (boolean)
                    whether at least one punctuation character is included in the password, true by default punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_'{|}~ to customize the punctuation characters, see included_punctuation and excluded_punctuation below
                  include-uppercase -> (boolean)
                    whether at least one A..Z character is included in the password, true by default
                  included-punctuation -> (string)
                    If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation: a string of specific punctuation characters to use
                  length -> (integer)
                    password length; by default, a reasonable length will be decided
            raw -> (string)
              When creating/updating Password, the field "raw" is mutually exclusive with "password_generation_options". In order to switch to the "raw" password you have to explicitly clear the "password_generation_options" field.
            secret-key -> (oneof<lockbox-secret-key>)
              Oneof secret-key field
              lockbox-secret-key -> (string)
                Read-only. Do not fill this field in create/update requests.
          user -> (string)
    cluster -> (struct)
      When creating/updating Connection, the field "cluster" is mutually exclusive with "managed_cluster_id".
      hosts -> ([]struct)
        health -> (struct)
        host -> (string)
        port -> (integer)
        role -> (struct)
        shard-name -> (string)
      sentinel-port -> (integer)
      tls-params -> (struct)
        tls-mode -> (oneof<disabled|tls>)
          Oneof tls-mode field
          disabled -> (struct)
          tls -> (struct)
            ca-certificate -> (string)
    databases -> ([]integer)
    managed-cluster-id -> (string)
      When creating/updating Connection, the field "managed_cluster_id" is mutually exclusive with "cluster".
  greenplum -> (struct)
    Greenplum data warehouse connection parameters.
    auth -> (struct)
      security -> (oneof<user-password>)
        Oneof security field
        user-password -> (struct)
          password -> (struct)
            password-generation-options -> (struct)
              When creating/updating Password, the field "password_generation_options" is mutually exclusive with "raw". In order to switch to the "password_generation_options" you have to explicitly clear the "raw" field.
              cookie -> (string)
                Cookie is an arbitrary non-sensitive string that is saved with the password. When updating PasswordGenerationOptions, if the cookie passed in the update request differs from the cookie in the current PasswordGenerationOptions, the password will be re-generated. If the same cookie is passed, the password will not change.
              password-generation-options -> (oneof<lockbox-password-generation-options>)
                Oneof password-generation-options field
                lockbox-password-generation-options -> (struct)
                  excluded-punctuation -> (string)
                    a string of punctuation characters to exclude from the default
                  include-digits -> (boolean)
                    whether at least one 0..9 character is included in the password, true by default
                  include-lowercase -> (boolean)
                    whether at least one a..z character is included in the password, true by default
                  include-punctuation -> (boolean)
                    whether at least one punctuation character is included in the password, true by default punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_'{|}~ to customize the punctuation characters, see included_punctuation and excluded_punctuation below
                  include-uppercase -> (boolean)
                    whether at least one A..Z character is included in the password, true by default
                  included-punctuation -> (string)
                    If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation: a string of specific punctuation characters to use
                  length -> (integer)
                    password length; by default, a reasonable length will be decided
            raw -> (string)
              When creating/updating Password, the field "raw" is mutually exclusive with "password_generation_options". In order to switch to the "raw" password you have to explicitly clear the "password_generation_options" field.
            secret-key -> (oneof<lockbox-secret-key>)
              Oneof secret-key field
              lockbox-secret-key -> (string)
                Read-only. Do not fill this field in create/update requests.
          user -> (string)
    cluster -> (struct)
      When creating/updating Connection, the field "cluster" is mutually exclusive with "managed_cluster_id".
      coordinator-hosts -> ([]struct)
        health -> (struct)
        host -> (string)
        port -> (integer)
        role -> (struct)
      tls-params -> (struct)
        tls-mode -> (oneof<disabled|tls>)
          Oneof tls-mode field
          disabled -> (struct)
          tls -> (struct)
            ca-certificate -> (string)
    databases -> ([]string)
    managed-cluster-id -> (string)
      When creating/updating Connection, the field "managed_cluster_id" is mutually exclusive with "cluster".
  storedoc -> (struct)
    StoreDoc document store connection parameters.
    auth -> (struct)
      auth-source -> (string)
      security -> (oneof<user-password>)
        Oneof security field
        user-password -> (struct)
          password -> (struct)
            password-generation-options -> (struct)
              When creating/updating Password, the field "password_generation_options" is mutually exclusive with "raw". In order to switch to the "password_generation_options" you have to explicitly clear the "raw" field.
              cookie -> (string)
                Cookie is an arbitrary non-sensitive string that is saved with the password. When updating PasswordGenerationOptions, if the cookie passed in the update request differs from the cookie in the current PasswordGenerationOptions, the password will be re-generated. If the same cookie is passed, the password will not change.
              password-generation-options -> (oneof<lockbox-password-generation-options>)
                Oneof password-generation-options field
                lockbox-password-generation-options -> (struct)
                  excluded-punctuation -> (string)
                    a string of punctuation characters to exclude from the default
                  include-digits -> (boolean)
                    whether at least one 0..9 character is included in the password, true by default
                  include-lowercase -> (boolean)
                    whether at least one a..z character is included in the password, true by default
                  include-punctuation -> (boolean)
                    whether at least one punctuation character is included in the password, true by default punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_'{|}~ to customize the punctuation characters, see included_punctuation and excluded_punctuation below
                  include-uppercase -> (boolean)
                    whether at least one A..Z character is included in the password, true by default
                  included-punctuation -> (string)
                    If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation: a string of specific punctuation characters to use
                  length -> (integer)
                    password length; by default, a reasonable length will be decided
            raw -> (string)
              When creating/updating Password, the field "raw" is mutually exclusive with "password_generation_options". In order to switch to the "raw" password you have to explicitly clear the "password_generation_options" field.
            secret-key -> (oneof<lockbox-secret-key>)
              Oneof secret-key field
              lockbox-secret-key -> (string)
                Read-only. Do not fill this field in create/update requests.
          user -> (string)
    cluster -> (struct)
      When creating/updating Connection, the field "cluster" is mutually exclusive with "managed_cluster_id".
      hosts -> ([]struct)
        health -> (struct)
        host -> (string)
        port -> (integer)
        role -> (struct)
        type -> (struct)
      tls-params -> (struct)
        tls-mode -> (oneof<disabled|tls>)
          Oneof tls-mode field
          disabled -> (struct)
          tls -> (struct)
            ca-certificate -> (string)
    databases -> ([]string)
    managed-cluster-id -> (string)
      When creating/updating Connection, the field "managed_cluster_id" is mutually exclusive with "cluster".
``` ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#