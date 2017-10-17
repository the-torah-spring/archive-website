#!/bin/bash
echo Content-type: text/plain
echo

if [ -z "$HOME" ] ; then
HOME=/home2/thetorahspring
fi

GIT_REPO=$HOME/_repo/archive-website/
PUBLIC_WWW=$HOME/public_html

pushd $GIT_REPO
git pull

echo
echo "$HOME/.rvm/bin/ts_jekyll thumbs"
$HOME/.rvm/bin/ts_jekyll thumbs

echo
echo "$HOME/.rvm/bin/ts_jekyll build --source $GIT_REPO --destination $PUBLIC_WWW"
$HOME/.rvm/bin/ts_jekyll build --source $GIT_REPO --destination $PUBLIC_WWW

popd

echo DONE

