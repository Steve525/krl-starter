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
    select when pageview ".*" setting ()
    // Display notification that will not fade.
    notify("Hello World", "This is a sample rule.") with sticky = true;
  }
}
