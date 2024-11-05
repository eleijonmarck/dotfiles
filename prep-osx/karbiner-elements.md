# download karainber for the extension of keyboard shortcuts

### Rule

add this as a rule, to get the j, k to act as up and down arrows. it will change your life.

```
{
    "description": "Change ^(jikl) to ^(←↑↓→) keys",
    "manipulators": [
        {
            "from": {
                "key_code": "j",
                "modifiers": { "mandatory": ["left_control"] }
            },
            "to": [{ "key_code": "down_arrow" }],
            "type": "basic"
        },
        {
            "from": {
                "key_code": "k",
                "modifiers": { "mandatory": ["left_control"] }
            },
            "to": [{ "key_code": "up_arrow" }],
            "type": "basic"
        }
    ]
}
```
