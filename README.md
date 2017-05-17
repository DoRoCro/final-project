# final-project

Final project at CodeClan, to a self selected brief.  This was to reproduce my first project, but in Rails with user 
authentication, and, dependent on progress, additional features learned during the interim.

This uses a Rails backend to serve up data through a RESTful API, with a front end in React.  The intent to make this 
multi-user was included from the start, however the difficulties encountered in implementing this using the 'devise' gem
slowed progress in the 
time available.  The primary multi-user feature developed was a ratings/comments object, which belong to individual users, and which are
'polymorphic' in that they can be applied to Restaurants, Burgers or Deals equivalently, although yet to appear in the front 
end.  The original project only allowed a single rating to be applied to burgers.

The back-end rails server can be reproduced from scratch by running the 'setup.sh' script (at least in the CodeClan build 
environment - YMMV).


