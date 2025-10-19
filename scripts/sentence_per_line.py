#!/usr/bin/env python3
import sys, re

text = sys.stdin.read()

# Split on paragraph boundaries (blank lines), preserve blank line between paras.
paras = re.split(r'\n\s*\n', text.strip())

# Common abbreviations you *don't* want to split on. Extend as needed.
# Convert to a set for faster lookup
abbrevs = {
    'Mr', 'Mrs', 'Ms', 'Dr', 'Prof', 'St', 'Jr', 'Sr', 'vs', 'etc',
    'e.g', 'i.e', 'Fig', 'Eq', 'No', 'cf', 'al'
}

# Split at . ! ? possibly followed by close quotes/brackets,
# when the next char looks like the start of a new sentence.
sent_re = re.compile(
    r'([.!?])'                 # sentence-final punctuation
    r'(["\')\]]*)'             # optional closing quotes/brackets
    r'(\s+)'                   # whitespace between sentences
    r'(?=[A-Z0-9"(\[]|\n|$)'   # next token looks like sentence start
)

def should_split_sentence(match, text):
    """Check if we should split at this position by looking for abbreviations."""
    start_pos = match.start()

    # Look backwards to find the word that ends with the punctuation
    # Find the start of the word before the punctuation
    word_start = start_pos
    while word_start > 0 and text[word_start - 1].isalnum():
        word_start -= 1

    # Extract the word (without the punctuation)
    word = text[word_start:start_pos]

    # If this word is an abbreviation, don't split
    if word in abbrevs:
        return False

    # Also check for pattern like "e.g" where the period is part of the abbreviation
    if start_pos > 0 and text[start_pos - 1] == '.':
        # Look for pattern like "e.g."
        abbrev_start = start_pos - 1
        while abbrev_start > 0 and (text[abbrev_start - 1].isalnum() or text[abbrev_start - 1] == '.'):
            abbrev_start -= 1
        potential_abbrev = text[abbrev_start:start_pos]
        if potential_abbrev in abbrevs:
            return False

    return True

out = []
for p in paras:
    # Collapse intra-paragraph newlines to spaces
    p = ' '.join(p.split())

    # Split into one sentence per line
    result = []
    last_end = 0

    for match in sent_re.finditer(p):
        if should_split_sentence(match, p):
            # Add text up to and including the punctuation and quotes
            result.append(p[last_end:match.start() + len(match.group(1)) + len(match.group(2))])
            last_end = match.start() + len(match.group(1)) + len(match.group(2)) + len(match.group(3))

    # Add any remaining text
    if last_end < len(p):
        result.append(p[last_end:])

    # Join the sentences with newlines and strip
    p = '\n'.join(result).strip()
    out.append(p)

sys.stdout.write('\n\n'.join(out) + '\n')
