#!/bin/sh
cd ~/.config/remind && \
remind -z1 '-knotify-send -u critical "-------- 事件提醒 --------" %s &' \
  ~/.config/remind/remind.conf &
