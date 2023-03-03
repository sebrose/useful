#!/bin/bash

ROOT=`dirname $0`/repo-checkout

if [ -e $ROOT/"pom.xml" ]
then
  mvn -f $ROOT/pom.xml clean test > ansi
else
  pushd $ROOT
  ./cucumber > $TEXTTEST_SANDBOX/ansi
  popd
fi

# Need to have done: gem install bcat
cat ansi | a2h | $ROOT/../srjcuc/Book/script/h2p > pmlcolor

cp ansi $ROOT/texttest/ansi
cp pmlcolor $ROOT/texttest/pmlcolor

# This is where the book will pick up the output
# If it needs edited, then this should not be a staight copy
# cp $ROOT/texttest/pmlcolor $ROOT/checkout.pmlcolor

