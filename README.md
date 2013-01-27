Facebook HackerCup 2013
=======================

My solutions for the Facebook Hacker Cup, in ruby.

To run a particular problem, you can do:

    ./runner.rb 20

which will check to ensure that the samples cases are being solved correctly.
If so, it will load complex cases from a file named `loadtest.txt`, and run
them 20 times to ensure we are not late when the real cases are messy.
Finally, if a file named `realin.txt` exists (which should be the input file
you have downloaded from Facebook), it will solve those cases and open the
folder for you to quickly upload the files.

You can also do (in case you downloaded the input file somewhere else):
  
    ./runner.rb 35 ~/Downloads/balanced_parenthesistxt.txt

which will perform all the things above, still.


Finally, you can (obviously) do this:

    ./45/problem.rb ~/Downloads/find_the_mintxt.txt
