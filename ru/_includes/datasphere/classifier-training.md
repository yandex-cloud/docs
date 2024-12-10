При дообучении модели классификатора на базе {{ yagpt-name }} действуют следующие ограничения:

| Вид ограничения | Минимальное значение | Максимальное значение |
|---|---|---|
| Количество примеров в датасете | 100 | 50 000 |
| Количество классов | 2 | 100 |
| Количество примеров для одного класса в датасете| 1 | — |
| Длина имени класса в символах | — | 100 |
| Количество [токенов](../../foundation-models/concepts/yandexgpt/tokens.md) в тексте классифицируемого запроса | — | 8 000 |

Рекомендуется дообучать модели на датасетах, содержащих не менее 1 000 примеров и не менее 100 примеров для каждого класса.

**Пример наполнения файла для обучения бинарной классификации:**

```json
{"text":"у меня все в порядке","нейтральный":1}
{"text":"у меня все классно получилось ","нейтральный":0}
{"text":"вам не понять как тяжело бывает каждый день вставать на работу в шесть утра и два часа тащиться в общественном транспорте","нейтральный":0}
{"text":"все как всегда работа дом семья","нейтральный":1}
```

Где:
* `text` — текстовое содержимое сообщения.
* `нейтральный` — класс для бинарной классификации.


**Пример наполнения файла для обучения многоклассовой классификации:**

```json
{"text":"ну ничего себе и как это произошло","гнев":0,"страх":0,"радость":0,"грусть":0,"удивление":1}
{"text":"как мне быть что если об этом узнают","гнев":0,"страх":1,"радость":0,"грусть":0,"удивление":0}
{"text":"сегодня пятница и вечером мы пойдем с друзьями в клуб","гнев":0,"страх":0,"радость":1,"грусть":0,"удивление":0}
{"text":"не обманывай меня ты просто опять проспал и поэтому опоздал в школу","гнев":1,"страх":0,"радость":0,"грусть":0,"удивление":0}
```

Где:
* `text` — текстовое содержимое сообщения.
* `гнев`, `страх`, `радость`, `грусть` и `удивление` — классы.

**Пример наполнения файла для обучения классификации с несколькими метками:**

```json
{"computer_science":0,"physics":0,"mathematics":1,"statistics":1,"quantitative_biology":0,"quantitative_finance":0,"text":"Title: Bias Reduction in Instrumental Variable Estimation through First-Stage Shrinkage\nAbstract:   The two-stage least-squares (2SLS) estimator is known to be biased when its\nfirst-stage fit is poor. I show that better first-stage prediction can\nalleviate this bias. In a two-stage linear regression model with Normal noise,\nI consider shrinkage in the estimation of the first-stage instrumental variable\ncoefficients. For at least four instrumental variables and a single endogenous\nregressor, I establish that the standard 2SLS estimator is dominated with\nrespect to bias. The dominating IV estimator applies James-Stein type shrinkage\nin a first-stage high-dimensional Normal-means problem followed by a\ncontrol-function approach in the second stage. It preserves invariances of the\nstructural instrumental variable equations.\n"}
{"computer_science":0,"physics":0,"mathematics":1,"statistics":0,"quantitative_biology":0,"quantitative_finance":0,"text":"Title: Essentially Finite Vector Bundles on Normal Pseudo-proper Algebraic Stacks\nAbstract:   Let $X$ be a normal, connected and projective variety over an algebraically\nclosed field $k$. It is known that a vector bundle $V$ on $X$ is essentially\nfinite if and only if it is trivialized by a proper surjective morphism $f:Y\\to\nX$. In this paper we introduce a different approach to this problem which\nallows to extend the results to normal, connected and strongly pseudo-proper\nalgebraic stack of finite type over an arbitrary field $k$.\n"}
{"computer_science":1,"physics":0,"mathematics":0,"statistics":1,"quantitative_biology":0,"quantitative_finance":0,"text":"Title: MOLIERE: Automatic Biomedical Hypothesis Generation System\nAbstract:   Hypothesis generation is becoming a crucial time-saving technique which\nallows biomedical researchers to quickly discover implicit connections between\nimportant concepts. Typically, these systems operate on domain-specific\nfractions of public medical data. MOLIERE, in contrast, utilizes information\nfrom over 24.5 million documents. At the heart of our approach lies a\nmulti-modal and multi-relational network of biomedical objects extracted from\nseveral heterogeneous datasets from the National Center for Biotechnology\nInformation (NCBI). These objects include but are not limited to scientific\npapers, keywords, genes, proteins, diseases, and diagnoses. We model hypotheses\nusing Latent Dirichlet Allocation applied on abstracts found near shortest\npaths discovered within this network, and demonstrate the effectiveness of\nMOLIERE by performing hypothesis generation on historical data. Our network,\nimplementation, and resulting data are all publicly available for the broad\nscientific community.\n"}
```

Где:
* `computer_science`, `physics`, `mathematics`, `statistics`, `quantitative_biology` и `quantitative_finance` — классы.
* `text` — текстовое содержимое сообщения:

    * `Title` — заголовок сообщения.
    * `Abstract` — основной текст сообщения.
