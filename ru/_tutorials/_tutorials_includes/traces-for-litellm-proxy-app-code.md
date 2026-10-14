```python
"""Customer support agent that talks to a local LiteLLM proxy only.

No client-side telemetry: tracing is handled by the proxy (OTEL v2 → {{ monium-name }}).
"""

from __future__ import annotations

import argparse
import json
import os
import random
import sys

from openai import OpenAI

DEFAULT_PROXY_BASE = "http://127.0.0.1:4000/v1"
DEFAULT_PROXY_KEY = "sk-local-litellm"
DEFAULT_MODEL = "deepseek-v4-flash"


class KnowledgeBase:
    """Simple knowledge base for customer support."""

    def __init__(self) -> None:
        self.knowledge = {
            "shipping": {
                "standard": "Standard shipping takes 5-7 business days and costs $5.99",
                "express": "Express shipping takes 2-3 business days and costs $12.99",
                "overnight": "Overnight shipping delivers next business day and costs $24.99",
            },
            "returns": {
                "policy": "You can return items within 30 days of purchase for a full refund",
                "process": "To return an item, go to your account, find the order, and click 'Return Item'",
                "condition": "Items must be in original condition with tags attached",
            },
            "account": {
                "password_reset": "Click 'Forgot Password' on the login page and follow the email instructions",
                "update_info": "You can update your account information in the 'My Account' section",
                "delete_account": "Contact customer service to delete your account permanently",
            },
            "products": {
                "warranty": "All products come with a 1-year manufacturer warranty",
                "availability": "Check product availability on the product page",
                "specifications": "Product specifications are listed in the product description",
            },
        }

    def search(self, query: str) -> str:
        query_lower = query.lower()

        if any(
            word in query_lower for word in ["ship", "delivery", "shipping", "deliver"]
        ):
            if "express" in query_lower or "fast" in query_lower:
                return self.knowledge["shipping"]["express"]
            if "overnight" in query_lower or "next day" in query_lower:
                return self.knowledge["shipping"]["overnight"]
            return self.knowledge["shipping"]["standard"]

        if any(word in query_lower for word in ["return", "refund", "exchange"]):
            if "how" in query_lower or "process" in query_lower:
                return self.knowledge["returns"]["process"]
            if "condition" in query_lower:
                return self.knowledge["returns"]["condition"]
            return self.knowledge["returns"]["policy"]

        if any(
            word in query_lower for word in ["account", "password", "login", "profile"]
        ):
            if "password" in query_lower or "reset" in query_lower:
                return self.knowledge["account"]["password_reset"]
            if "update" in query_lower or "change" in query_lower:
                return self.knowledge["account"]["update_info"]
            if "delete" in query_lower:
                return self.knowledge["account"]["delete_account"]

        if any(
            word in query_lower for word in ["product", "warranty", "available", "spec"]
        ):
            if "warranty" in query_lower:
                return self.knowledge["products"]["warranty"]
            if "available" in query_lower or "stock" in query_lower:
                return self.knowledge["products"]["availability"]
            return self.knowledge["products"]["specifications"]

        return (
            "I couldn't find specific information about that. "
            "Let me help you with a general response."
        )


class CustomerSupportAgent:
    """Customer support agent using an OpenAI-compatible LiteLLM proxy."""

    def __init__(
        self,
        *,
        base_url: str,
        api_key: str,
        model: str,
    ) -> None:
        self.client = OpenAI(base_url=base_url, api_key=api_key)
        self.model = model
        self.knowledge_base = KnowledgeBase()
        self.conversation_history: list[dict] = []
        self.system_prompt = """
You are a helpful and friendly customer support agent. Your role is to:
1. Assist customers with their questions and concerns
2. Use the available tools whenever they help answer the question
3. Be polite, professional, and empathetic
4. If you don't know something, admit it and offer to escalate to a human agent
5. Keep responses concise but helpful

Always maintain a positive and solution-oriented attitude.
Prefer calling tools for shipping, returns, order status, refunds, accounts, and products
instead of inventing details.
""".strip()

    def search_knowledge_base(self, query: str) -> str:
        return self.knowledge_base.search(query)

    def get_order_status(self, order_id: str) -> str:
        statuses = ["Processing", "Shipped", "Out for Delivery", "Delivered"]
        return f"Order {order_id} status: {random.choice(statuses)}"

    def process_refund(self, order_id: str, reason: str) -> str:
        return (
            f"Refund request for order {order_id} has been submitted. "
            f"Reason: {reason}. You'll receive confirmation within 24 hours."
        )

    def get_available_tools(self) -> list[dict]:
        return [
            {
                "type": "function",
                "function": {
                    "name": "search_knowledge_base",
                    "description": (
                        "Search the knowledge base for shipping, returns, "
                        "accounts, and products"
                    ),
                    "parameters": {
                        "type": "object",
                        "properties": {
                            "query": {
                                "type": "string",
                                "description": "The customer's question or topic",
                            }
                        },
                        "required": ["query"],
                    },
                },
            },
            {
                "type": "function",
                "function": {
                    "name": "get_order_status",
                    "description": "Get the current status of a customer's order",
                    "parameters": {
                        "type": "object",
                        "properties": {
                            "order_id": {
                                "type": "string",
                                "description": "The order ID to check",
                            }
                        },
                        "required": ["order_id"],
                    },
                },
            },
            {
                "type": "function",
                "function": {
                    "name": "process_refund",
                    "description": "Process a refund request for a customer",
                    "parameters": {
                        "type": "object",
                        "properties": {
                            "order_id": {
                                "type": "string",
                                "description": "The order ID to refund",
                            },
                            "reason": {
                                "type": "string",
                                "description": "Reason for the refund",
                            },
                        },
                        "required": ["order_id", "reason"],
                    },
                },
            },
        ]

    def execute_tool_call(self, tool_call) -> str:
        function_name = tool_call.function.name
        arguments = json.loads(tool_call.function.arguments)

        if function_name == "search_knowledge_base":
            return self.search_knowledge_base(arguments["query"])
        if function_name == "get_order_status":
            return self.get_order_status(arguments["order_id"])
        if function_name == "process_refund":
            return self.process_refund(arguments["order_id"], arguments["reason"])
        return f"Unknown tool: {function_name}"

    def chat(self, user_message: str) -> str:
        self.conversation_history.append({"role": "user", "content": user_message})
        messages = [
            {"role": "system", "content": self.system_prompt}
        ] + self.conversation_history

        try:
            response = self.client.chat.completions.create(
                model=self.model,
                messages=messages,
                tools=self.get_available_tools(),
                tool_choice="auto",
                temperature=0.4,
                max_tokens=700,
            )
            assistant_message = response.choices[0].message

            # Allow a few tool rounds so one user turn can expand into several LLM calls.
            for _ in range(4):
                if not assistant_message.tool_calls:
                    break

                self.conversation_history.append(
                    {
                        "role": "assistant",
                        "content": assistant_message.content,
                        "tool_calls": [
                            {
                                "id": tool_call.id,
                                "type": "function",
                                "function": {
                                    "name": tool_call.function.name,
                                    "arguments": tool_call.function.arguments,
                                },
                            }
                            for tool_call in assistant_message.tool_calls
                        ],
                    }
                )

                for tool_call in assistant_message.tool_calls:
                    tool_result = self.execute_tool_call(tool_call)
                    print(f"  [tool] {tool_call.function.name} -> {tool_result}")
                    self.conversation_history.append(
                        {
                            "role": "tool",
                            "tool_call_id": tool_call.id,
                            "content": tool_result,
                        }
                    )

                messages = [
                    {"role": "system", "content": self.system_prompt}
                ] + self.conversation_history
                response = self.client.chat.completions.create(
                    model=self.model,
                    messages=messages,
                    tools=self.get_available_tools(),
                    tool_choice="auto",
                    temperature=0.4,
                    max_tokens=700,
                )
                assistant_message = response.choices[0].message

            response_content = assistant_message.content or ""
            self.conversation_history.append(
                {"role": "assistant", "content": response_content}
            )
            return response_content

        except Exception as exc:  # noqa: BLE001 - surface proxy/LLM errors to the chat
            return f"I apologize, but I'm experiencing technical difficulties. Error: {exc}"

    def reset_conversation(self) -> None:
        self.conversation_history = []


DEMO_TURNS = [
    "Hi! I need express shipping info for an order I'm about to place.",
    "Also, what is the status of my existing order ORD-10482?",
    "The item arrived damaged. What is your return policy and how do I start a return?",
    "Please process a refund for order ORD-10482 because the item arrived damaged.",
    "One last thing: how long is the product warranty, and how do I reset my account password?",
]


def run_demo(agent: CustomerSupportAgent) -> int:
    print("Customer Support Agent (LiteLLM proxy demo)")
    print("=" * 60)
    print(f"Proxy model: {agent.model}")
    print(f"Turns: {len(DEMO_TURNS)}\n")

    for idx, user_input in enumerate(DEMO_TURNS, start=1):
        print(f"[{idx}/{len(DEMO_TURNS)}] You: {user_input}")
        response = agent.chat(user_input)
        print(f"Agent: {response}\n")

    print("Demo finished.")
    return 0


def run_interactive(agent: CustomerSupportAgent) -> int:
    print("Customer Support Agent")
    print("=" * 50)
    print("Type 'quit' to exit or 'reset' to start a new conversation.\n")

    while True:
        try:
            user_input = input("\nYou: ").strip()
        except (EOFError, KeyboardInterrupt):
            print(
                "\nAgent: Thank you for contacting customer support. Have a great day!"
            )
            return 0

        if user_input.lower() in {"quit", "exit", "bye"}:
            print(
                "\nAgent: Thank you for contacting customer support. Have a great day!"
            )
            return 0
        if user_input.lower() == "reset":
            agent.reset_conversation()
            print("\nAgent: Conversation reset. How can I help you today?")
            continue
        if not user_input:
            continue

        print(f"\nAgent: {agent.chat(user_input)}")


def build_agent_from_env() -> CustomerSupportAgent:
    return CustomerSupportAgent(
        base_url=os.getenv("LITELLM_PROXY_BASE", DEFAULT_PROXY_BASE),
        api_key=os.getenv("LITELLM_PROXY_KEY", DEFAULT_PROXY_KEY),
        model=os.getenv("LITELLM_MODEL", DEFAULT_MODEL),
    )


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--interactive",
        action="store_true",
        help="Run an interactive REPL instead of the multi-step demo",
    )
    args = parser.parse_args(argv)

    agent = build_agent_from_env()
    if args.interactive:
        return run_interactive(agent)
    return run_demo(agent)


if __name__ == "__main__":
    sys.exit(main())
```