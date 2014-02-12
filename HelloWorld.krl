ruleset HelloWorldApp {
  meta {
    name "Hello World"
    description <<
      Hello World
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
}
