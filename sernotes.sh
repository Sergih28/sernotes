#!/usr/bin/env bash

# help shoouldn't be printed out twice even if you call it twice
# be able to concatenate multiple notes names
# multiple words in note name doesn't work

WORD_LENGTH=0
TITLE_SEPARATION=''
BREAK=false
HELP_PRINTED=false

function show_help {
  echo "Usage: sernotes [Arguments]"
  echo ""
  echo "Arguments:"
  echo "   -h | --help            Print help"
  echo "   -n | --note notename   Create a new note"
}

function create_note {
  echo "$1" >> "$1".md
  get_word_length "$1"
  print_equals
  echo $TITLE_SEPARATION >> "$1".md
}

function get_word_length {
  WORD_LENGTH=$(printf "$1" | wc -m)
}

function print_equals {
  TITLE_SEPARATION=$(printf '%*s' $WORD_LENGTH | tr ' ' '=')
}

function options {
  case "$1" in
    -h | --help)
      if [ $HELP_PRINTED = true ]; then
        BREAK=true
      else
        show_help
        HELP_PRINTED=true
      fi
      BREAK=true
      ;;
    -n | --note)
      create_note "$2"
      shift
      BREAK=true
      ;;
  esac
}

while [ $#  -gt 0 ]
do
  key="$1"
  shift
  BREAK=false
  for arg in "$@"
  do
    options "$key" "$arg"
    if [ $BREAK = true ]; then
      break
    fi
  done
done
options "$key"
