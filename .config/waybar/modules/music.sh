#!/bin/bash

## Get song
artist=`cmus-remote -C 'format_print '%a''`
song=`cmus-remote -C 'format_print '%t''`

echo "$artist - $song"