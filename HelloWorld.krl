ruleset HelloWorldApp {
  meta {
    name "Hello World"
    description <<
        Lab 3 for CS 462 @ BYU
    >>
    author "Steve Clarkson"
    logging off
  }
  dispatch {
  }
  global {
  }
  rule hello_world {
    select when pageview
    if event:attr("url").match(#ktest.heroku.com#) then every {
      notify("Hello World", "Notification 1") with sticky = true;
      notify("Hello World", "Notification 2") with sticky = true;
    }
  }
  rule query_string_checker {
    select when web pageview url re#ktest.heroku.com#
    pre {
      queryString = page:url("query");
    }
    if (queryString eq "") then {
      notify("Hello", "Monkey") with sticky = true;
    }
    notfired {
      raise explicit event query_found
    }
  }

  rule query_found {
    select when explicit query_found
    {
      notify("Hello", "Monkey") with sticky = true; 
    }
  }
}
