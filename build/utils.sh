function output_redirect() {
  cat -
}

function echo_title() {
  echo $'\e[1G----->' $* | output_redirect
}

function echo_normal() {
  echo $'\e[1G      ' $* | output_redirect
}

function ensure_indent() {
  while read line; do
    if [[ "$line" == --* ]] || [[ "$line" == ==* ]]; then
      echo $'\e[1G'$line | output_redirect
    else
      echo $'\e[1G      ' "$line" | output_redirect
    fi
  done
}

function try() {
  if ! $@; then
    echo "$@ failed" | ensure_indent
    exit 1
  fi
}
