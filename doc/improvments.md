## UX improvements

### Clear primary action
Make “Start” the primary CTA and separate it from secondary actions (“New”, “Day off”). Disable “Start” if an entry is ongoing.

### Inline “Stop” affordance
Surface “Stop” as a floating action on the ongoing row; also put a matching “Stop” next to the global “Start” when running.

### Week navigation
Add explicit previous/next week controls and a “Today” shortcut. Allow collapsing past weeks.

### Filtering and findability
Add tag filter chips (multi-select) and a free-text filter (matches tag names or note/description if you add one later).

### Batch actions
Enable multi-select to delete or retag multiple entries quickly.

### Empty and end states
Show helpful empty-state on a new install and a gentle “No entries match your filters.”

### Inline tag editing
Click-to-add/remove tags on a row without leaving the page.

### Keyboard shortcuts
S to Start/Stop, N for New, Backspace to delete selected row, J/K to move focus.

### Safer delete
Use a non-destructive “Archive” first, or require holding a key to confirm delete.
Timezone clarity: Display timezone in the header and allow switching if relevant (e.g., remote teams).


## UI refinements

### Top summary card
Convert the balance banner into a proper card with clear delta “+2h 15m week balance”.

### Visual hierarchy
Make weekly headers sticky and slightly elevated; give day rows a subtle background to chunk content.

### Readable grid
Switch the grid to a simple table on wide screens and a two-line stacked card on mobile for better scanability.

### Ongoing state
Use a gentle animated dot/badge “Recording…” instead of a red chip. Keep red for destructive/error only.

### Density control
Add per-row hover states, reduce border noise, and increase whitespace between groups.

### Color/accessibility
Ensure contrast on chips and buttons; don’t rely on color alone—use icons + labels.


## Real-time polish

### Live duration ticking
Use a Stimulus controller to increment the visible duration every second for ongoing entries and the weekly/day totals.

### Live balance
Turbo-stream the balance and totals when Start/Stop occurs; or tick it client-side too.


## Information architecture

### Totals everywhere
Add totals per week and per day as right-aligned, bold numbers; show a small progress bar toward 8.2h/day and 4d/week targets.

### Notes/description
Optional short note field per entry improves recall and search, even if you keep tags.
