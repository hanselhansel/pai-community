# Physical AI Outreach

Public communication for the Physical AI Portfolio: publishable posts, generic networking targets, reusable messages, talks, events, and public feedback.

## Status

- Workflow status: Parked
- Existing material: Generic [target categories](networking/target-list.md) and [message templates](networking/message-templates.md)
- Restart condition: A validated portfolio case is approved for external communication
- Current action: Maintain the public/private boundary. Do not send outreach from this project.

See the [changelog](CHANGELOG.md) for release history.

## Public boundary

This public repository may contain:

- Organization and role categories based on public information.
- Publishable posts and talks.
- Reusable outreach templates.
- Public event plans and public feedback.

It must not contain personal names, contact history, direct messages, email addresses, meeting notes, contact exports, response tracking, or non-public feedback. Those records stay outside this public Git repository. This repository does not name or inspect the private system.

### Validate the public boundary

Run both checks before committing public outreach content:

```bash
./scripts/check-public-boundary.sh
./scripts/tests/test-public-boundary.sh
```

The checker rejects tracked private-path patterns and removed relationship-tracking instructions in `README.md` or `networking/`. The regression script covers clean content, private filenames, and private tracking instructions.

## Portfolio relationship

The portfolio entry point is [physical-ai-portfolio](https://github.com/hanselhansel/physical-ai-portfolio).

This repository is the public `pai-outreach` track.
