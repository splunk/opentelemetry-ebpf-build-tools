#!/bin/bash

# backwards compatibility pre-directory variables
if [ -z "$FLOWMILL_SRC" ]; then FLOWMILL_SRC="$HOME/flowmill/flowmill"; fi

alias benv="$FLOWMILL_SRC/dev/benv"
alias benv-debug="$FLOWMILL_SRC/dev/benv-debug"
