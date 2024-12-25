```json
{
  "modelUri": "gpt://<folder_ID>/yandexgpt-lite",
  "completionOptions": {
    "stream": false,
    "temperature": 0.6,
    "maxTokens": "2000"
  },
  "messages": [
    {
      "role": "system",
      "text": "You are a smart assistant"
    },
    {
      "role": "user", 
      "text": "Hi! What fields of science did Albert Einstein study?"
    },
    {
      "role": "assistant", 
      "text": "Albert Einstein was an outstanding physicist, whose works in theoretical physics, theoretical mechanics, and philosophy of science became fundamental. He dedicated his career to studying the fundamentals of the universe, including the theory of relativity, both special and general. Additionally, Albert Einstein studied:\n\n* thermodynamics,\n* statistical mechanics,\n* electromagnetism,\n* quantum theory,\n* special relativity, and more.\n\nHis general relativity works found wide recognition and had a profound influence on the development of modern physics."
    },
    {
      "role": "user", 
      "text": "What important discoveries did he make?"
    },
    {
      "role": "assistant",
      "text": Here are some discoveries commonly associated with the name of Albert Einstein:\n1. **Special theory of relativity (STR)**: Theory describing motion, laws of mechanics, and spatiotemporal relationships at random velocities less than the speed of light in a vacuum.\n1. **General theory of relativity (GTR)**: Geometric theory of gravitation based on the prediction of the interrelation between the spacetime, matter, and energy coordinates.\n1. **Quantum theory of the photoelectric effect**: Explanation of the photoelectric effect, a phenomenon of electron emission from matter under the influence of electromagnetic radiation.\n1. **Brownian motion**: Phenomenon of chaotic, random movement of microscopic particles suspended in a liquid or gas, caused by the thermal motion of molecules in the surrounding medium.\n1. **Equivalence principle**: Idea that gravitational and inertial mass are different aspects of the same physical quantity.\n1. **Cosmological solutions of the GTR equations**: Contribution to the theory of the structure and dynamics of the universe.\n1. **Nuclear model of the atom**: Description of the atom structure based on protons, neutrons, and electrons.\nThese are just some of the discoveries made by Albert Einstein. His contributions to science and philosophy are immense, and his research continues to shape our ideas of nature and the universe."
    },
    {
      "role": "user",
      "text": "Give me a shorter response"
    }
  ]
}
```

{% cut "Result:" %}

```json
{
  "result": {
    "alternatives": [
      {
        "message": {
          "role": "assistant",
          "text": "Albert Einstein was an outstanding physicist who studied the fundamentals of the universe, including the theory of relativity, thermodynamics, and electromagnetism.\n\nSome of his well-known discoveries include the following: special and general theories of relativity, quantum theory of the photoelectric effect, and others."
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