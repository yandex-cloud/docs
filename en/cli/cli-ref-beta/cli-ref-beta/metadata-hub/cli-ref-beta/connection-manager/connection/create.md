---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/metadata-hub/cli-ref-beta/connection-manager/connection/create.md
---

# yc beta metadata-hub connection-manager connection create

Creates connection.

#### Command Usage

Syntax:

`yc beta metadata-hub connection-manager connection create <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--description` | `string`

 ||
|| `--folder-id` | `string`

 ||
|| `--labels` | `stringToString`

 ||
|| `--name` | `string`

 ||
|| `--params` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  type = clickhouse={
    auth = {
      security = user-password={
        password = {
          password-generation-options = {
            cookie = str,
            password-generation-options = lockbox-password-generation-options={
              excluded-punctuation = str,
              include-digits = bool,
              include-lowercase = bool,
              include-punctuation = bool,
              include-uppercase = bool,
              included-punctuation = str,
              length = int
            }
          },
          raw = str,
          secret-key = lockbox-secret-key=str
        },
        user = str
      }
    },
    cluster = {
      hosts = [
        {
          health = HEALTH_UNKNOWN|ALIVE|DEAD|DEGRADED,
          host = str,
          http-port = int,
          shard-name = str,
          tcp-port = int
        }, ...
      ],
      shard-groups = [
        {
          name = str,
          shard-names = str,...
        }, ...
      ],
      tls-params = {
        tls-mode = disabled={} | tls={
          ca-certificate = str
        }
      }
    },
    databases = str,...,
    managed-cluster-id = str
  } | greenplum={
    auth = {
      security = user-password={
        password = {
          password-generation-options = {
            cookie = str,
            password-generation-options = lockbox-password-generation-options={
              excluded-punctuation = str,
              include-digits = bool,
              include-lowercase = bool,
              include-punctuation = bool,
              include-uppercase = bool,
              included-punctuation = str,
              length = int
            }
          },
          raw = str,
          secret-key = lockbox-secret-key=str
        },
        user = str
      }
    },
    cluster = {
      coordinator-hosts = [
        {
          health = ALIVE|DEAD|DEGRADED|UNBALANCED,
          host = str,
          port = int,
          role = MASTER|REPLICA
        }, ...
      ],
      tls-params = {
        tls-mode = disabled={} | tls={
          ca-certificate = str
        }
      }
    },
    databases = str,...,
    managed-cluster-id = str
  } | kafka={
    auth = {
      security = disabled={} | sasl={
        password = {
          password-generation-options = {
            cookie = str,
            password-generation-options = lockbox-password-generation-options={
              excluded-punctuation = str,
              include-digits = bool,
              include-lowercase = bool,
              include-punctuation = bool,
              include-uppercase = bool,
              included-punctuation = str,
              length = int
            }
          },
          raw = str,
          secret-key = lockbox-secret-key=str
        },
        supported-mechanisms = [
          PLAIN|SCRAM_SHA256|SCRAM_SHA512, ...
        ],
        user = str
      }
    },
    cluster = {
      hosts = [
        {
          health = ALIVE|DEAD|DEGRADED,
          host = str,
          port = int
        }, ...
      ],
      tls-params = {
        tls-mode = disabled={} | tls={
          ca-certificate = str
        }
      }
    },
    managed-cluster-id = str
  } | mongodb={
    auth = {
      auth-source = str,
      security = user-password={
        password = {
          password-generation-options = {
            cookie = str,
            password-generation-options = lockbox-password-generation-options={
              excluded-punctuation = str,
              include-digits = bool,
              include-lowercase = bool,
              include-punctuation = bool,
              include-uppercase = bool,
              included-punctuation = str,
              length = int
            }
          },
          raw = str,
          secret-key = lockbox-secret-key=str
        },
        user = str
      }
    },
    cluster = {
      hosts = [
        {
          health = ALIVE|DEAD|DEGRADED,
          host = str,
          port = int,
          role = PRIMARY|SECONDARY,
          type = MONGOD|MONGOS|MONGOINFRA
        }, ...
      ],
      tls-params = {
        tls-mode = disabled={} | tls={
          ca-certificate = str
        }
      }
    },
    databases = str,...,
    managed-cluster-id = str
  } | mysql={
    auth = {
      security = user-password={
        password = {
          password-generation-options = {
            cookie = str,
            password-generation-options = lockbox-password-generation-options={
              excluded-punctuation = str,
              include-digits = bool,
              include-lowercase = bool,
              include-punctuation = bool,
              include-uppercase = bool,
              included-punctuation = str,
              length = int
            }
          },
          raw = str,
          secret-key = lockbox-secret-key=str
        },
        user = str
      }
    },
    cluster = {
      hosts = [
        {
          health = ALIVE|DEAD|DEGRADED|READONLY,
          host = str,
          port = int,
          role = MASTER|REPLICA
        }, ...
      ],
      tls-params = {
        tls-mode = disabled={} | tls={
          ca-certificate = str
        }
      }
    },
    databases = str,...,
    managed-cluster-id = str
  } | opensearch={
    auth = {
      security = user-password={
        password = {
          password-generation-options = {
            cookie = str,
            password-generation-options = lockbox-password-generation-options={
              excluded-punctuation = str,
              include-digits = bool,
              include-lowercase = bool,
              include-punctuation = bool,
              include-uppercase = bool,
              included-punctuation = str,
              length = int
            }
          },
          raw = str,
          secret-key = lockbox-secret-key=str
        },
        user = str
      }
    },
    cluster = {
      hosts = [
        {
          health = ALIVE|DEAD|DEGRADED|READONLY,
          host = str,
          port = int,
          roles = [
            DATA|MANAGER, ...
          ]
        }, ...
      ],
      tls-params = {
        tls-mode = disabled={} | tls={
          ca-certificate = str
        }
      }
    },
    managed-cluster-id = str
  } | postgresql={
    auth = {
      security = user-password={
        password = {
          password-generation-options = {
            cookie = str,
            password-generation-options = lockbox-password-generation-options={
              excluded-punctuation = str,
              include-digits = bool,
              include-lowercase = bool,
              include-punctuation = bool,
              include-uppercase = bool,
              included-punctuation = str,
              length = int
            }
          },
          raw = str,
          secret-key = lockbox-secret-key=str
        },
        user = str
      }
    },
    cluster = {
      hosts = [
        {
          health = ALIVE|DEAD|DEGRADED|READONLY,
          host = str,
          port = int,
          replica-type = ASYNC|SYNC|QUORUM,
          role = MASTER|REPLICA
        }, ...
      ],
      tls-params = {
        tls-mode = disabled={} | tls={
          ca-certificate = str
        }
      }
    },
    databases = str,...,
    managed-cluster-id = str
  } | redis={
    auth = {
      security = user-password={
        password = {
          password-generation-options = {
            cookie = str,
            password-generation-options = lockbox-password-generation-options={
              excluded-punctuation = str,
              include-digits = bool,
              include-lowercase = bool,
              include-punctuation = bool,
              include-uppercase = bool,
              included-punctuation = str,
              length = int
            }
          },
          raw = str,
          secret-key = lockbox-secret-key=str
        },
        user = str
      }
    },
    cluster = {
      hosts = [
        {
          health = ALIVE|DEAD|DEGRADED,
          host = str,
          port = int,
          role = MASTER|REPLICA,
          shard-name = str
        }, ...
      ],
      sentinel-port = int,
      tls-params = {
        tls-mode = disabled={} | tls={
          ca-certificate = str
        }
      }
    },
    databases = int,...
  } | storedoc={
    auth = {
      auth-source = str,
      security = user-password={
        password = {
          password-generation-options = {
            cookie = str,
            password-generation-options = lockbox-password-generation-options={
              excluded-punctuation = str,
              include-digits = bool,
              include-lowercase = bool,
              include-punctuation = bool,
              include-uppercase = bool,
              included-punctuation = str,
              length = int
            }
          },
          raw = str,
          secret-key = lockbox-secret-key=str
        },
        user = str
      }
    },
    cluster = {
      hosts = [
        {
          health = ALIVE|DEAD|DEGRADED,
          host = str,
          port = int,
          role = PRIMARY|SECONDARY,
          type = MONGOD|MONGOS|MONGOINFRA
        }, ...
      ],
      tls-params = {
        tls-mode = disabled={} | tls={
          ca-certificate = str
        }
      }
    },
    databases = str,...,
    managed-cluster-id = str
  } | trino={
    auth = {
      security = user-password={
        password = {
          password-generation-options = {
            cookie = str,
            password-generation-options = lockbox-password-generation-options={
              excluded-punctuation = str,
              include-digits = bool,
              include-lowercase = bool,
              include-punctuation = bool,
              include-uppercase = bool,
              included-punctuation = str,
              length = int
            }
          },
          raw = str,
          secret-key = lockbox-secret-key=str
        },
        user = str
      }
    },
    cluster = {
      coordinator = {
        host = str,
        port = int
      },
      tls-params = {
        tls-mode = disabled={} | tls={
          ca-certificate = str
        }
      }
    }
  } | valkey={
    auth = {
      security = user-password={
        password = {
          password-generation-options = {
            cookie = str,
            password-generation-options = lockbox-password-generation-options={
              excluded-punctuation = str,
              include-digits = bool,
              include-lowercase = bool,
              include-punctuation = bool,
              include-uppercase = bool,
              included-punctuation = str,
              length = int
            }
          },
          raw = str,
          secret-key = lockbox-secret-key=str
        },
        user = str
      }
    },
    cluster = {
      hosts = [
        {
          health = ALIVE|DEAD|DEGRADED,
          host = str,
          port = int,
          role = MASTER|REPLICA,
          shard-name = str
        }, ...
      ],
      sentinel-port = int,
      tls-params = {
        tls-mode = disabled={} | tls={
          ca-certificate = str
        }
      }
    },
    databases = int,...,
    managed-cluster-id = str
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
                "cookie": "str",
                "password-generation-options": {
                  "lockbox-password-generation-options": {
                    "excluded-punctuation": "str",
                    "include-digits": "bool",
                    "include-lowercase": "bool",
                    "include-punctuation": "bool",
                    "include-uppercase": "bool",
                    "included-punctuation": "str",
                    "length": "int"
                  }
                }
              },
              "raw": "str",
              "secret-key": {
                "lockbox-secret-key": "str"
              }
            },
            "user": "str"
          }
        }
      },
      "cluster": {
        "hosts": [
          {
            "health": "HEALTH_UNKNOWN|ALIVE|DEAD|DEGRADED",
            "host": "str",
            "http-port": "int",
            "shard-name": "str",
            "tcp-port": "int"
          }, ...
        ],
        "shard-groups": [
          {
            "name": "str",
            "shard-names": [
              "str", ...
            ]
          }, ...
        ],
        "tls-params": {
          "tls-mode": {
            "disabled": {},
            "tls": {
              "ca-certificate": "str"
            }
          }
        }
      },
      "databases": [
        "str", ...
      ],
      "managed-cluster-id": "str"
    },
    "greenplum": {
      "auth": {
        "security": {
          "user-password": {
            "password": {
              "password-generation-options": {
                "cookie": "str",
                "password-generation-options": {
                  "lockbox-password-generation-options": {
                    "excluded-punctuation": "str",
                    "include-digits": "bool",
                    "include-lowercase": "bool",
                    "include-punctuation": "bool",
                    "include-uppercase": "bool",
                    "included-punctuation": "str",
                    "length": "int"
                  }
                }
              },
              "raw": "str",
              "secret-key": {
                "lockbox-secret-key": "str"
              }
            },
            "user": "str"
          }
        }
      },
      "cluster": {
        "coordinator-hosts": [
          {
            "health": "ALIVE|DEAD|DEGRADED|UNBALANCED",
            "host": "str",
            "port": "int",
            "role": "MASTER|REPLICA"
          }, ...
        ],
        "tls-params": {
          "tls-mode": {
            "disabled": {},
            "tls": {
              "ca-certificate": "str"
            }
          }
        }
      },
      "databases": [
        "str", ...
      ],
      "managed-cluster-id": "str"
    },
    "kafka": {
      "auth": {
        "security": {
          "disabled": {},
          "sasl": {
            "password": {
              "password-generation-options": {
                "cookie": "str",
                "password-generation-options": {
                  "lockbox-password-generation-options": {
                    "excluded-punctuation": "str",
                    "include-digits": "bool",
                    "include-lowercase": "bool",
                    "include-punctuation": "bool",
                    "include-uppercase": "bool",
                    "included-punctuation": "str",
                    "length": "int"
                  }
                }
              },
              "raw": "str",
              "secret-key": {
                "lockbox-secret-key": "str"
              }
            },
            "supported-mechanisms": [
              "PLAIN|SCRAM_SHA256|SCRAM_SHA512", ...
            ],
            "user": "str"
          }
        }
      },
      "cluster": {
        "hosts": [
          {
            "health": "ALIVE|DEAD|DEGRADED",
            "host": "str",
            "port": "int"
          }, ...
        ],
        "tls-params": {
          "tls-mode": {
            "disabled": {},
            "tls": {
              "ca-certificate": "str"
            }
          }
        }
      },
      "managed-cluster-id": "str"
    },
    "mongodb": {
      "auth": {
        "auth-source": "str",
        "security": {
          "user-password": {
            "password": {
              "password-generation-options": {
                "cookie": "str",
                "password-generation-options": {
                  "lockbox-password-generation-options": {
                    "excluded-punctuation": "str",
                    "include-digits": "bool",
                    "include-lowercase": "bool",
                    "include-punctuation": "bool",
                    "include-uppercase": "bool",
                    "included-punctuation": "str",
                    "length": "int"
                  }
                }
              },
              "raw": "str",
              "secret-key": {
                "lockbox-secret-key": "str"
              }
            },
            "user": "str"
          }
        }
      },
      "cluster": {
        "hosts": [
          {
            "health": "ALIVE|DEAD|DEGRADED",
            "host": "str",
            "port": "int",
            "role": "PRIMARY|SECONDARY",
            "type": "MONGOD|MONGOS|MONGOINFRA"
          }, ...
        ],
        "tls-params": {
          "tls-mode": {
            "disabled": {},
            "tls": {
              "ca-certificate": "str"
            }
          }
        }
      },
      "databases": [
        "str", ...
      ],
      "managed-cluster-id": "str"
    },
    "mysql": {
      "auth": {
        "security": {
          "user-password": {
            "password": {
              "password-generation-options": {
                "cookie": "str",
                "password-generation-options": {
                  "lockbox-password-generation-options": {
                    "excluded-punctuation": "str",
                    "include-digits": "bool",
                    "include-lowercase": "bool",
                    "include-punctuation": "bool",
                    "include-uppercase": "bool",
                    "included-punctuation": "str",
                    "length": "int"
                  }
                }
              },
              "raw": "str",
              "secret-key": {
                "lockbox-secret-key": "str"
              }
            },
            "user": "str"
          }
        }
      },
      "cluster": {
        "hosts": [
          {
            "health": "ALIVE|DEAD|DEGRADED|READONLY",
            "host": "str",
            "port": "int",
            "role": "MASTER|REPLICA"
          }, ...
        ],
        "tls-params": {
          "tls-mode": {
            "disabled": {},
            "tls": {
              "ca-certificate": "str"
            }
          }
        }
      },
      "databases": [
        "str", ...
      ],
      "managed-cluster-id": "str"
    },
    "opensearch": {
      "auth": {
        "security": {
          "user-password": {
            "password": {
              "password-generation-options": {
                "cookie": "str",
                "password-generation-options": {
                  "lockbox-password-generation-options": {
                    "excluded-punctuation": "str",
                    "include-digits": "bool",
                    "include-lowercase": "bool",
                    "include-punctuation": "bool",
                    "include-uppercase": "bool",
                    "included-punctuation": "str",
                    "length": "int"
                  }
                }
              },
              "raw": "str",
              "secret-key": {
                "lockbox-secret-key": "str"
              }
            },
            "user": "str"
          }
        }
      },
      "cluster": {
        "hosts": [
          {
            "health": "ALIVE|DEAD|DEGRADED|READONLY",
            "host": "str",
            "port": "int",
            "roles": [
              "DATA|MANAGER", ...
            ]
          }, ...
        ],
        "tls-params": {
          "tls-mode": {
            "disabled": {},
            "tls": {
              "ca-certificate": "str"
            }
          }
        }
      },
      "managed-cluster-id": "str"
    },
    "postgresql": {
      "auth": {
        "security": {
          "user-password": {
            "password": {
              "password-generation-options": {
                "cookie": "str",
                "password-generation-options": {
                  "lockbox-password-generation-options": {
                    "excluded-punctuation": "str",
                    "include-digits": "bool",
                    "include-lowercase": "bool",
                    "include-punctuation": "bool",
                    "include-uppercase": "bool",
                    "included-punctuation": "str",
                    "length": "int"
                  }
                }
              },
              "raw": "str",
              "secret-key": {
                "lockbox-secret-key": "str"
              }
            },
            "user": "str"
          }
        }
      },
      "cluster": {
        "hosts": [
          {
            "health": "ALIVE|DEAD|DEGRADED|READONLY",
            "host": "str",
            "port": "int",
            "replica-type": "ASYNC|SYNC|QUORUM",
            "role": "MASTER|REPLICA"
          }, ...
        ],
        "tls-params": {
          "tls-mode": {
            "disabled": {},
            "tls": {
              "ca-certificate": "str"
            }
          }
        }
      },
      "databases": [
        "str", ...
      ],
      "managed-cluster-id": "str"
    },
    "redis": {
      "auth": {
        "security": {
          "user-password": {
            "password": {
              "password-generation-options": {
                "cookie": "str",
                "password-generation-options": {
                  "lockbox-password-generation-options": {
                    "excluded-punctuation": "str",
                    "include-digits": "bool",
                    "include-lowercase": "bool",
                    "include-punctuation": "bool",
                    "include-uppercase": "bool",
                    "included-punctuation": "str",
                    "length": "int"
                  }
                }
              },
              "raw": "str",
              "secret-key": {
                "lockbox-secret-key": "str"
              }
            },
            "user": "str"
          }
        }
      },
      "cluster": {
        "hosts": [
          {
            "health": "ALIVE|DEAD|DEGRADED",
            "host": "str",
            "port": "int",
            "role": "MASTER|REPLICA",
            "shard-name": "str"
          }, ...
        ],
        "sentinel-port": "int",
        "tls-params": {
          "tls-mode": {
            "disabled": {},
            "tls": {
              "ca-certificate": "str"
            }
          }
        }
      },
      "databases": [
        "int", ...
      ]
    },
    "storedoc": {
      "auth": {
        "auth-source": "str",
        "security": {
          "user-password": {
            "password": {
              "password-generation-options": {
                "cookie": "str",
                "password-generation-options": {
                  "lockbox-password-generation-options": {
                    "excluded-punctuation": "str",
                    "include-digits": "bool",
                    "include-lowercase": "bool",
                    "include-punctuation": "bool",
                    "include-uppercase": "bool",
                    "included-punctuation": "str",
                    "length": "int"
                  }
                }
              },
              "raw": "str",
              "secret-key": {
                "lockbox-secret-key": "str"
              }
            },
            "user": "str"
          }
        }
      },
      "cluster": {
        "hosts": [
          {
            "health": "ALIVE|DEAD|DEGRADED",
            "host": "str",
            "port": "int",
            "role": "PRIMARY|SECONDARY",
            "type": "MONGOD|MONGOS|MONGOINFRA"
          }, ...
        ],
        "tls-params": {
          "tls-mode": {
            "disabled": {},
            "tls": {
              "ca-certificate": "str"
            }
          }
        }
      },
      "databases": [
        "str", ...
      ],
      "managed-cluster-id": "str"
    },
    "trino": {
      "auth": {
        "security": {
          "user-password": {
            "password": {
              "password-generation-options": {
                "cookie": "str",
                "password-generation-options": {
                  "lockbox-password-generation-options": {
                    "excluded-punctuation": "str",
                    "include-digits": "bool",
                    "include-lowercase": "bool",
                    "include-punctuation": "bool",
                    "include-uppercase": "bool",
                    "included-punctuation": "str",
                    "length": "int"
                  }
                }
              },
              "raw": "str",
              "secret-key": {
                "lockbox-secret-key": "str"
              }
            },
            "user": "str"
          }
        }
      },
      "cluster": {
        "coordinator": {
          "host": "str",
          "port": "int"
        },
        "tls-params": {
          "tls-mode": {
            "disabled": {},
            "tls": {
              "ca-certificate": "str"
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
                "cookie": "str",
                "password-generation-options": {
                  "lockbox-password-generation-options": {
                    "excluded-punctuation": "str",
                    "include-digits": "bool",
                    "include-lowercase": "bool",
                    "include-punctuation": "bool",
                    "include-uppercase": "bool",
                    "included-punctuation": "str",
                    "length": "int"
                  }
                }
              },
              "raw": "str",
              "secret-key": {
                "lockbox-secret-key": "str"
              }
            },
            "user": "str"
          }
        }
      },
      "cluster": {
        "hosts": [
          {
            "health": "ALIVE|DEAD|DEGRADED",
            "host": "str",
            "port": "int",
            "role": "MASTER|REPLICA",
            "shard-name": "str"
          }, ...
        ],
        "sentinel-port": "int",
        "tls-params": {
          "tls-mode": {
            "disabled": {},
            "tls": {
              "ca-certificate": "str"
            }
          }
        }
      },
      "databases": [
        "int", ...
      ],
      "managed-cluster-id": "str"
    }
  }
}
```

Fields:

```
type -> (oneof<clickhouse|greenplum|kafka|mongodb|mysql|opensearch|postgresql|redis|storedoc|trino|valkey>)
  Oneof type field
  postgresql -> (struct)
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
                  include-digits -> (bool)
                    whether at least one 0..9 character is included in the password, true by default
                  include-lowercase -> (bool)
                    whether at least one a..z character is included in the password, true by default
                  include-punctuation -> (bool)
                    whether at least one punctuation character is included in the password, true by default punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_'{|}~ to customize the punctuation characters, see included_punctuation and excluded_punctuation below
                  include-uppercase -> (bool)
                    whether at least one A..Z character is included in the password, true by default
                  included-punctuation -> (string)
                    If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation: a string of specific punctuation characters to use
                  length -> (int)
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
        port -> (int)
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
                  include-digits -> (bool)
                    whether at least one 0..9 character is included in the password, true by default
                  include-lowercase -> (bool)
                    whether at least one a..z character is included in the password, true by default
                  include-punctuation -> (bool)
                    whether at least one punctuation character is included in the password, true by default punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_'{|}~ to customize the punctuation characters, see included_punctuation and excluded_punctuation below
                  include-uppercase -> (bool)
                    whether at least one A..Z character is included in the password, true by default
                  included-punctuation -> (string)
                    If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation: a string of specific punctuation characters to use
                  length -> (int)
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
        port -> (int)
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
                  include-digits -> (bool)
                    whether at least one 0..9 character is included in the password, true by default
                  include-lowercase -> (bool)
                    whether at least one a..z character is included in the password, true by default
                  include-punctuation -> (bool)
                    whether at least one punctuation character is included in the password, true by default punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_'{|}~ to customize the punctuation characters, see included_punctuation and excluded_punctuation below
                  include-uppercase -> (bool)
                    whether at least one A..Z character is included in the password, true by default
                  included-punctuation -> (string)
                    If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation: a string of specific punctuation characters to use
                  length -> (int)
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
        port -> (int)
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
                  include-digits -> (bool)
                    whether at least one 0..9 character is included in the password, true by default
                  include-lowercase -> (bool)
                    whether at least one a..z character is included in the password, true by default
                  include-punctuation -> (bool)
                    whether at least one punctuation character is included in the password, true by default punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_'{|}~ to customize the punctuation characters, see included_punctuation and excluded_punctuation below
                  include-uppercase -> (bool)
                    whether at least one A..Z character is included in the password, true by default
                  included-punctuation -> (string)
                    If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation: a string of specific punctuation characters to use
                  length -> (int)
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
        http-port -> (int)
          depends on tls params may vary as http or https
        shard-name -> (string)
        tcp-port -> (int)
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
                  include-digits -> (bool)
                    whether at least one 0..9 character is included in the password, true by default
                  include-lowercase -> (bool)
                    whether at least one a..z character is included in the password, true by default
                  include-punctuation -> (bool)
                    whether at least one punctuation character is included in the password, true by default punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_'{|}~ to customize the punctuation characters, see included_punctuation and excluded_punctuation below
                  include-uppercase -> (bool)
                    whether at least one A..Z character is included in the password, true by default
                  included-punctuation -> (string)
                    If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation: a string of specific punctuation characters to use
                  length -> (int)
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
        port -> (int)
      tls-params -> (struct)
        tls-mode -> (oneof<disabled|tls>)
          Oneof tls-mode field
          disabled -> (struct)
          tls -> (struct)
            ca-certificate -> (string)
    managed-cluster-id -> (string)
      When creating/updating Connection, the field "managed_cluster_id" is mutually exclusive with "cluster".
  redis -> (struct)
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
                  include-digits -> (bool)
                    whether at least one 0..9 character is included in the password, true by default
                  include-lowercase -> (bool)
                    whether at least one a..z character is included in the password, true by default
                  include-punctuation -> (bool)
                    whether at least one punctuation character is included in the password, true by default punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_'{|}~ to customize the punctuation characters, see included_punctuation and excluded_punctuation below
                  include-uppercase -> (bool)
                    whether at least one A..Z character is included in the password, true by default
                  included-punctuation -> (string)
                    If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation: a string of specific punctuation characters to use
                  length -> (int)
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
        port -> (int)
        role -> (struct)
        shard-name -> (string)
      sentinel-port -> (int)
      tls-params -> (struct)
        tls-mode -> (oneof<disabled|tls>)
          Oneof tls-mode field
          disabled -> (struct)
          tls -> (struct)
            ca-certificate -> (string)
    databases -> ([]int)
  opensearch -> (struct)
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
                  include-digits -> (bool)
                    whether at least one 0..9 character is included in the password, true by default
                  include-lowercase -> (bool)
                    whether at least one a..z character is included in the password, true by default
                  include-punctuation -> (bool)
                    whether at least one punctuation character is included in the password, true by default punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_'{|}~ to customize the punctuation characters, see included_punctuation and excluded_punctuation below
                  include-uppercase -> (bool)
                    whether at least one A..Z character is included in the password, true by default
                  included-punctuation -> (string)
                    If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation: a string of specific punctuation characters to use
                  length -> (int)
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
        port -> (int)
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
                  include-digits -> (bool)
                    whether at least one 0..9 character is included in the password, true by default
                  include-lowercase -> (bool)
                    whether at least one a..z character is included in the password, true by default
                  include-punctuation -> (bool)
                    whether at least one punctuation character is included in the password, true by default punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_'{|}~ to customize the punctuation characters, see included_punctuation and excluded_punctuation below
                  include-uppercase -> (bool)
                    whether at least one A..Z character is included in the password, true by default
                  included-punctuation -> (string)
                    If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation: a string of specific punctuation characters to use
                  length -> (int)
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
        port -> (int)
      tls-params -> (struct)
        tls-mode -> (oneof<disabled|tls>)
          Oneof tls-mode field
          disabled -> (struct)
          tls -> (struct)
            ca-certificate -> (string)
  valkey -> (struct)
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
                  include-digits -> (bool)
                    whether at least one 0..9 character is included in the password, true by default
                  include-lowercase -> (bool)
                    whether at least one a..z character is included in the password, true by default
                  include-punctuation -> (bool)
                    whether at least one punctuation character is included in the password, true by default punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_'{|}~ to customize the punctuation characters, see included_punctuation and excluded_punctuation below
                  include-uppercase -> (bool)
                    whether at least one A..Z character is included in the password, true by default
                  included-punctuation -> (string)
                    If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation: a string of specific punctuation characters to use
                  length -> (int)
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
        port -> (int)
        role -> (struct)
        shard-name -> (string)
      sentinel-port -> (int)
      tls-params -> (struct)
        tls-mode -> (oneof<disabled|tls>)
          Oneof tls-mode field
          disabled -> (struct)
          tls -> (struct)
            ca-certificate -> (string)
    databases -> ([]int)
    managed-cluster-id -> (string)
      When creating/updating Connection, the field "managed_cluster_id" is mutually exclusive with "cluster".
  greenplum -> (struct)
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
                  include-digits -> (bool)
                    whether at least one 0..9 character is included in the password, true by default
                  include-lowercase -> (bool)
                    whether at least one a..z character is included in the password, true by default
                  include-punctuation -> (bool)
                    whether at least one punctuation character is included in the password, true by default punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_'{|}~ to customize the punctuation characters, see included_punctuation and excluded_punctuation below
                  include-uppercase -> (bool)
                    whether at least one A..Z character is included in the password, true by default
                  included-punctuation -> (string)
                    If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation: a string of specific punctuation characters to use
                  length -> (int)
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
        port -> (int)
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
                  include-digits -> (bool)
                    whether at least one 0..9 character is included in the password, true by default
                  include-lowercase -> (bool)
                    whether at least one a..z character is included in the password, true by default
                  include-punctuation -> (bool)
                    whether at least one punctuation character is included in the password, true by default punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_'{|}~ to customize the punctuation characters, see included_punctuation and excluded_punctuation below
                  include-uppercase -> (bool)
                    whether at least one A..Z character is included in the password, true by default
                  included-punctuation -> (string)
                    If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation: a string of specific punctuation characters to use
                  length -> (int)
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
        port -> (int)
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

Set the output format: text, yaml, json, table, summary. ||
|| `--summary` | `strings`

Fields to include in summary output.
Each value is a dot-separated path to a field.
Examples:
  --summary instance.id                  # simple field
  --summary instance.type                # another simple field
  --summary instance.disks.size          # collect values from all list elements
  --summary instance.disks[0].size       # field from a specific list element ||
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