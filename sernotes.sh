#!/usr/bin/env bash

# help shoouldn't be printed out twice even if you call it twice
# be able to concatenate multiple notes names

WORD_LENGTH=0
TITLE_SEPARATION=''

function show_help {
  echo "Usage: sernotes [Arguments]"
  echo ""
  echo "Arguments:"
  echo "   -h | --help            Print help"
  echo "   -n | --note notename   Create a new note"
}

function create_note {
  echo "$1" >> $1.md
  get_word_length $1
  print_equals
  echo $TITLE_SEPARATION >> $1.md
  # touch $1.md
}

function get_word_length {
  WORD_LENGTH=$(printf "$1" | wc -m)
}

function print_equals {
  TITLE_SEPARATION=$(printf '%*s' $WORD_LENGTH | tr ' ' '=')
}

while [[ $#  -gt 0 ]]
do
key="$1"
  case $key in
    -h | --help)
      show_help
      shift
      ;;
    -n | --note)
      create_note $2
      shift
      shift
      ;;
  esac
done

