#!/bin/bash
#
# Factory Hook: post-theme-deploy
#
#
# Usage: SCRIPTNAME sitegroup env theme_scope theme_event domain
# Map the script inputs to convenient names.
# Acquia hosting site / environment names
site="$1"
env="$2"

# The public domain name of the website.
domain="$5"

# The websites' document root can be derived from the site/env:
docroot="/var/www/html/$site.$env/docroot"

# Acquia recommends the following two practices:
# 1. Hardcode the drush version.
# 2. When running drush, provide the application + url, rather than relying
#    on aliases. This can prevent some hard to trace problems.
DRUSH_CMD="drush8 --root=$docroot --uri=https://$domain"

# Purge all Acquia and Fastly caches.
if [ $(hostname) == "web-3352.enterprise-g1.hosting.acquia.com" ] || [ $(hostname) == "staging-997.enterprise-g1.hosting.acquia.com" ] ; then
    $DRUSH_CMD cr -y
    $DRUSH_CMD p:invalidate everything -y
fi
