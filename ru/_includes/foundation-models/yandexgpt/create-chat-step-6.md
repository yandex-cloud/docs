```json
{
  "modelUri": "gpt://<идентификатор_каталога>/yandexgpt",
  "completionOptions": {
    "stream": false,
    "temperature": 0.6,
    "maxTokens": "2000",
    "reasoningOptions": {
      "mode": "DISABLED"
    }
  },
  "messages": [
    {
      "role": "system",
      "text": "Ты умный ассистент"
    },
    {
      "role": "user", 
      "text": "Привет! Какими науками занимался Альберт Эйнштейн?"
    },
    {
      "role": "assistant", 
      "text": "Альберт Эйнштейн был выдающимся физиком, труды которого в области теоретической физики, теоретической механики и философии науки стали фундаментальными. Он посвятил свою карьеру изучению основ Вселенной, включая теорию относительности, специальную и общую теорию относительности. Кроме того, Альберт Эйнштейн изучал:\n\n* термодинамику,\n* статистическую механику,\n* электромагнетизм,\n* квантовую теорию,\n* специальную теорию относительности и др.\n\nЕго работы по общей теории относительности получили широкое признание и оказали глубокое влияние на развитие современной физики."
    },
    {
      "role": "user", 
      "text": "Какие важные открытия он совершил?"
    },
    {
      "role": "assistant",
      "text": "Вот некоторые открытия, которые обычно связывают с именем Альберта Эйнштейна:\n1. **Специальная теория относительности (СТО)** — теория, описывающая движение, законы механики и пространственно-временные отношения при произвольных скоростях, меньших скорости света в вакууме.\n1. **Общая теория относительности (ОТО)** — геометрическая теория тяготения, основанная на предсказании взаимосвязи между координатами пространства-времени, материи и энергии.\n1. **Квантовая теория фотоэффекта** — объяснение фотоэффекта, явления выбивания электронов из вещества под действием электромагнитного излучения.\n1. **Броуновское движение** — явление беспорядочного, случайного движения микроскопических частиц, взвешенных в жидкости или газе, происходящее из-за теплового движения молекул окружающей среды.\n1. **Эквивалентность гравитационной и инерционной массы** — идея о том, что гравитационная и инертная масса являются разными аспектами одной и той же величины.\n1. **Космологические решения уравнений ОТО** — вклад в теорию строения и динамики Вселенной.\n1. **Ядерная модель атома** — описание структуры атома на основе протонов, нейтронов и электронов.\nЭто лишь некоторые из открытий Альберта Эйнштейна. Его вклад в науку и философию огромен, и его исследования продолжают оказывать влияние на наши представления о природе и Вселенной."
    },
    {
      "role": "user",
      "text": "Сократи свой ответ"
    }
  ]
}
```

{% cut "Результат:" %}

```json
{
  "result": {
    "alternatives": [
      {
        "message": {
          "role": "assistant",
          "text": "Альберт Эйнштейн — выдающийся физик, изучавший основы Вселенной, в частности, теорию относительности, термодинамику и электромагнетизм.\n\nИзвестные открытия учёного: специальная и общая теория относительности, квантовая теория фотоэффекта и др."
        },
        "status": "ALTERNATIVE_STATUS_FINAL"
      }
    ],
    "usage": {
      "inputTextTokens": "452",
      "completionTokens": "54",
      "totalTokens": "506"
    },
    "modelVersion": "18.01.2024"
  }
}
```

{% endcut %}