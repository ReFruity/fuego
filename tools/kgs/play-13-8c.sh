#!/bin/bash
# Script for playing Fuego on 13x13 KGS on a machine with 8 cores / 12 GB

FUEGO="../../build/opt/fuegomain/fuego"
NAME=Fuego13
DESCRIPTION="Fuego Go program, 13x13 board"

usage() {
  cat >&2 <<EOF
Usage: $0 [options]
Options:
  -n maxgames: Limit number games to maxgames
  -h Print help and exit
EOF
}

MAXGAMES_OPTION=""
while getopts "n:h" O; do
case "$O" in
  n)   MAXGAMES_OPTION="-maxgames $OPTARG";;
  h)   usage; exit 0;;
  [?]) usage; exit 1;;
esac
done

shift $(($OPTIND - 1))
if [ $# -gt 0 ]; then
  usage
  exit 1
fi


echo "Enter KGS password for $NAME:"
read PASSWORD

GAMES_DIR="games-13/$NAME"
mkdir -p "$GAMES_DIR"

cat <<EOF >config-13-8c.gtp
# This file is auto-generated by play-13-8c.sh. Do not edit.

go_param debug_to_comment 1
go_param auto_save $GAMES_DIR/$NAME-
go_sentinel_file stop-13-8c

# Use 11.3 GB for both trees (search and the init tree used for reuse_subtree)
uct_max_memory 11300000000
uct_param_player reuse_subtree 1
uct_param_player ponder 1

# Set KGS rules (Chinese, positional superko)
go_rules kgs

sg_param time_mode real
uct_param_search number_threads 8
uct_param_search lock_free 1
EOF

cat >tmp.cfg <<EOF
name=$NAME
password=$PASSWORD
room=Computer Go
mode=custom
gameNotes=$DESCRIPTION
rules=chinese
rules.boardSize=13
rules.time=0:00+25/5:00
verbose=t
engine=$FUEGO --size 13 --config config-13-8c.gtp $MAXGAMES_OPTION
reconnect=t
EOF
java -jar kgsGtp.jar tmp.cfg && rm -f tmp.cfg

#-----------------------------------------------------------------------------
