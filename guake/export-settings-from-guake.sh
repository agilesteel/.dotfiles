#!/bin/bash

dconf dump /apps/guake/ > .guakerc
dconf dump /org/gnome/desktop/notifications/application/guake/ > .guake-notifications
