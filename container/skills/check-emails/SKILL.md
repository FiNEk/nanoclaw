---
name: check-emails
description: Check and manage emails via IMAP using himalaya CLI. Supports multiple accounts. Use when the user asks about emails, inbox, or runs /check-emails.
---

# /check-emails — Email Access via Himalaya

Check and manage emails using the `himalaya` CLI (IMAP/SMTP).

## Pre-flight

Always run the pre-flight script first:

```bash
bash /home/node/.claude/skills/check-emails/preflight.sh
```

If the output starts with `ERROR:`, relay the error message to the user and stop. Otherwise, the output contains the available accounts — use them to answer the user's request.

## Common Operations

### List inbox (default account)

```bash
himalaya envelope list
```

### List inbox (specific account)

```bash
himalaya --account work envelope list
```

### List a specific folder

```bash
himalaya envelope list --folder "Sent"
himalaya folder list  # see all folders
```

### Read an email

```bash
himalaya message read <id>
```

### Search emails

```bash
himalaya envelope list from john@example.com subject meeting
```

### Reply to an email

```bash
cat << 'EOF' | himalaya template send
From: you@example.com
To: recipient@example.com
Subject: Re: Original Subject
In-Reply-To: <original-message-id>

Reply body here.
EOF
```

### Forward an email

```bash
himalaya message forward <id>
```

### Download attachments

```bash
himalaya attachment download <id>
```

## Output Formatting

Use `--output json` when you need to parse results programmatically:

```bash
himalaya envelope list --output json
```

When presenting emails to the user, summarize concisely:
- Show sender, subject, and date
- For email bodies, summarize the key points rather than pasting raw content
- Only show full content if the user asks for it

## Safety Rules

- **Default to read-only operations** (list, read, search)
- **Ask for explicit confirmation** before sending, replying, forwarding, moving, or deleting emails
- Never expose raw email headers or full MIME content unless the user asks
- Summarize long email threads instead of pasting full content
- When replying or sending, show the user the composed message before sending

## Multiple Accounts

The pre-flight output lists available accounts. If the user doesn't specify an account, use the default. If multiple accounts exist, ask which one they mean when the context is ambiguous.

Switch accounts with `--account <name>`:

```bash
himalaya --account personal envelope list
himalaya --account work envelope list
```
