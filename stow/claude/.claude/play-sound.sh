#!/usr/bin/env bash
case "$(uname)" in
  Darwin) afplay "$@" ;;
  *)      paplay "$@" ;;
esac
