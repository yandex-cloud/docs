# Проверка подписи собственных образов

Вы можете подписывать образы своих приложений и запретить кластеру запускать образы без действительной подписи. При создании пода подпись проверяет компонент [Policy Manager](../concepts/components/policy-manager.md), в основе которого лежит [Kyverno](https://kyverno.io/). Подписи создает утилита [Cosign](https://docs.sigstore.dev/).

В этом руководстве вы создадите пару ключей, подпишете свой образ, примените политику и убедитесь, что неподписанный образ не запускается.

{% note warning %}

Это руководство относится **только к вашим собственным образам**. У образов {{ stackland-name }} механизм другой: их целостность проверяет узел кластера при загрузке образа, отдельным ключом платформы. Ваш ключ, ваша политика и ваш секрет доступа к реестру никак не влияют на проверку образов платформы, а ключ платформы никогда не применяется к вашим образам.

Не добавляйте образы {{ stackland-name }} в свою политику: пространства имен платформы исключены из проверки, и такое правило не сработает.

{% endnote %}

## Перед началом работы {#before-begin}

1. Установите [Cosign](https://docs.sigstore.dev/cosign/system_config/installation/) версии 3 или новее и [crane](https://github.com/google/go-containerregistry/blob/main/cmd/crane/README.md).

    Команды в руководстве проверены на Cosign v3.1.3.

1. Убедитесь, что у вас есть права на запись в реестр с вашими образами: подпись сохраняется в тот же репозиторий, что и образ.

1. Убедитесь, что реестр доступен из кластера. Подпись проверяет Kyverno внутри кластера, поэтому он обращается в реестр сам, независимо от того, как образ загружает узел.

1. Убедитесь, что Policy Manager включен:

    ```bash
    kubectl get policymanagerconfig main -o jsonpath='{.spec.enabled}'
    ```

    Если команда вернула `false`, включите компонент — см. [Активировать пресет с политиками](../operations/policy-manager/apply-preset.md).

## Как это устроено {#how-it-works}

Cosign сохраняет подпись рядом с образом — отдельным тегом вида `sha256-<digest>.sig` в том же репозитории. Когда в кластере создается под, Kyverno перехватывает запрос, скачивает подпись из реестра и проверяет ее вашим публичным ключом. Если подписи нет или она не соответствует ключу, под не создается.

Проверка идет по цифровому отпечатку образа (digest), а не по тегу. Поэтому подписывать образ нужно тоже по digest: тег можно перезаписать, digest — нет.

## Шаг 1. Создайте пару ключей {#create-keys}

1. Задайте пароль для приватного ключа и создайте пару:

    ```bash
    export COSIGN_PASSWORD='<пароль приватного ключа>'
    cosign generate-key-pair
    ```

    Будут созданы два файла:

    * `cosign.key` — приватный ключ, которым вы подписываете образы;
    * `cosign.pub` — публичный ключ, которым Kyverno проверяет подписи.

{% note warning %}

`cosign.key` позволяет подписывать образы от вашего имени. Храните его в системе управления секретами или в секретах CI, не кладите в репозиторий с кодом и не создавайте из него `ConfigMap`. В политику Kyverno попадает только содержимое `cosign.pub`.

{% endnote %}

## Шаг 2. Подпишите образ {#sign-image}

1. Получите digest образа:

    ```bash
    IMAGE_REPOSITORY='<адрес реестра>/<путь к образу>'
    IMAGE_TAG='<тег>'
    DIGEST=$(crane digest "${IMAGE_REPOSITORY}:${IMAGE_TAG}")
    IMAGE="${IMAGE_REPOSITORY}@${DIGEST}"
    ```

1. Подпишите образ:

    ```bash
    cosign sign --yes \
      --key cosign.key \
      --use-signing-config=false \
      --new-bundle-format=false \
      --tlog-upload=false \
      "$IMAGE"
    ```

    Назначение флагов:

    * `--tlog-upload=false` — не отправлять запись во внешний журнал Rekor.
    * `--use-signing-config=false` — не использовать конфигурацию служб Sigstore. Без этого флага Cosign версии 3 запрещает `--tlog-upload=false`.
    * `--new-bundle-format=false` — сохранить подпись отдельным тегом `sha256-<digest>.sig`. По умолчанию Cosign версии 3 публикует подпись как артефакт OCI 1.1, который Kyverno этой версии не читает, а часть реестров отклоняет.

    Cosign выведет предупреждения о том, что `--new-bundle-format` и `--tlog-upload` объявлены устаревшими. Это ожидаемо: пока Kyverno работает с прежним форматом подписи, оба флага обязательны.

1. Убедитесь, что подпись появилась в реестре:

    ```bash
    crane ls "$IMAGE_REPOSITORY" | grep '^sha256-'
    ```

    В выводе должен быть тег `sha256-<digest>.sig`, где `<digest>` совпадает с digest подписанного образа.

## Шаг 3. Проверьте подпись локально {#verify-local}

Проверьте подпись прежде, чем настраивать политику, — так вы отделите ошибку подписи от ошибки в политике:

```bash
cosign verify --key cosign.pub --insecure-ignore-tlog "$IMAGE"
```

Для подписанного образа команда выведет результат проверки, для неподписанного — ошибку `no signatures found`.

## Шаг 4. Дайте Kyverno доступ к реестру {#registry-credentials}

Если ваш реестр требует аутентификации, создайте секрет с учетными данными:

{% include notitle [Команда](../_includes/yamls/tutorials/verify-own-image-signatures/registry-secret.md) %}

{% note info %}

Секрет должен находиться именно в пространстве имен `stackland-policy-manager` — Kyverno читает учетные данные только оттуда. Это не то же самое, что `imagePullSecrets` вашего пода: узел и Kyverno обращаются в реестр независимо друг от друга и используют разные учетные данные.

Если вы используете короткоживущие токены, обновляйте секрет до истечения их срока: с просроченным токеном Kyverno не сможет получить подпись.

{% endnote %}

## Шаг 5. Примените политику {#apply-policy}

Манифест ниже использует безопасный режим отчетов: `failureAction: Audit`, `mutateDigest: false` и `webhookConfiguration.failurePolicy: Ignore`. После применения политика регистрирует нарушения, но не блокирует создание подов. Блокировку вы включите постепенно после проверки политики и доступа к реестру.

1. Создайте файл ресурса `ClusterPolicy`. Например, с помощью команды `touch clusterpolicy.yaml`.
1. Откройте файл и вставьте конфигурацию ниже:

    {% include notitle [YAML-файл](../_includes/yamls/tutorials/verify-own-image-signatures/clusterpolicy.md) %}

1. Подставьте в параметр:

    * `spec.rules[0].verifyImages[0].imageReferences` — пути к вашим образам.
    * `spec.rules[0].verifyImages[0].imageRegistryCredentials.secrets` — имя секрета из шага 4. Если реестр не требует аутентификации, удалите блок `imageRegistryCredentials`.
    * `spec.rules[0].verifyImages[0].attestors[0].entries[0].keys.publicKeys` — содержимое файла `cosign.pub`.

    По умолчанию политика проверяет образы во всех пространствах имен всех проектов, кроме пространств имен платформы. Блок `exclude` с меткой `stackland.yandex.cloud/project-name: stackland` исключает пространства имен платформы независимо от их имени.

    Чтобы проверять образы только в пространствах имен одного проекта, раскомментируйте в `match` блок `namespaceSelector` и укажите название проекта:

    ```yaml
    match:
      any:
      - resources:
          kinds:
          - Pod
          namespaceSelector:
            matchLabels:
              stackland.yandex.cloud/project-name: <название проекта>
    ```

1. Примените политику в режиме отчетов:

    ```bash
    kubectl apply -f clusterpolicy.yaml
    ```

1. Убедитесь, что политика готова:

    ```bash
    kubectl get clusterpolicy verify-my-images -o jsonpath='{.status.conditions[?(@.type=="Ready")].status}'
    ```

    Ожидаемый результат — `True`.

{% note alert %}

Не указывайте `*` в `imageReferences`. С параметром `required: true` политика потребует подпись у всех образов, включая служебные и сторонние, и поды перестанут создаваться. Перечисляйте только те пути, образы по которым подписываете сами.

{% endnote %}

## Постепенное включение блокировки {#staged-rollout}

Политика уже работает в безопасном режиме отчетов. Перед включением блокировки убедитесь, что она охватывает только нужные образы и успешно обращается к реестру.

1. Убедитесь, что в консоли управления в разделе **Система > События** нет неожиданных нарушений, и одновременно включите блокировку неподписанных образов и замену тегов на digest. Ошибки обращения к реестру пока останутся неблокирующими:

    ```bash
    kubectl patch clusterpolicy verify-my-images --type=json --patch='[
      {
        "op": "replace",
        "path": "/spec/rules/0/verifyImages/0/failureAction",
        "value": "Enforce"
      },
      {
        "op": "replace",
        "path": "/spec/rules/0/verifyImages/0/mutateDigest",
        "value": true
      }
    ]'
    ```

1. Убедитесь, что обращения в реестр стабильны, и включите блокировку при ошибках проверки:

    ```bash
    kubectl patch clusterpolicy verify-my-images --type=json --patch='[
      {
        "op": "replace",
        "path": "/spec/webhookConfiguration/failurePolicy",
        "value": "Fail"
      }
    ]'
    ```

    Политика перейдет в финальный режим `Enforce` и `Fail`.

## Шаг 6. Проверьте работу политики {#check-policy}

В командах ниже `<имя пространства имен>` — имя конкретного пространства имен из области действия политики, например `team-alpha-backend`.

1. Запустите под с подписанным образом:

    ```bash
    kubectl run test-signed -n <имя пространства имен> --restart=Never \
      --image=<адрес реестра>/<путь к образу>:<тег>
    ```

    Под будет создан. Проверьте, что Kyverno заменил тег на digest и отметил проверку аннотацией:

    ```bash
    kubectl get pod test-signed -n <имя пространства имен> \
      -o jsonpath='{.spec.containers[0].image}{"\n"}{.metadata.annotations.kyverno\.io/verify-images}{"\n"}'
    ```

    Пример вывода:

    ```text
    registry.example.com/myteam/app:1.0.0@sha256:7c38f24774e3cbd906d2d33c38354ccf787635581c122965132c9bd309754d4a
    {"registry.example.com/myteam/app@sha256:7c38f24774e3cbd906d2d33c38354ccf787635581c122965132c9bd309754d4a":"pass"}
    ```

1. Запустите под с неподписанным образом:

    ```bash
    kubectl run test-unsigned -n <имя пространства имен> --restart=Never \
      --image=<адрес реестра>/<путь к образу>:<тег неподписанного образа>
    ```

    Под создан не будет:

    ```text
    Error from server: admission webhook "mutate.kyverno.svc-fail" denied the request:

    resource Pod/<имя пространства имен>/test-unsigned was blocked due to the following policies

    verify-my-images:
      verify-signature: 'failed to verify image registry.example.com/myteam/app:unsigned:
        .attestors[0].entries[0].keys: no signatures found'
    ```

1. Удалите тестовый под:

    ```bash
    kubectl delete pod test-signed -n <имя пространства имен>
    ```

## Ограничения {#limitations}

* **Реестр становится зависимостью при создании подов.** В режиме `failurePolicy: Fail` недоступность реестра или просроченные учетные данные останавливают создание подов с образами, попадающими под политику. Кеш проверок и узкий список `imageReferences` ограничивают последствия, но не устраняют их.
* **Политика удаляется вместе с компонентом.** Если отключить Policy Manager (`PolicyManagerConfig.spec.enabled: false`), политика и секрет с учетными данными реестра будут удалены. После повторного включения создайте их заново.
