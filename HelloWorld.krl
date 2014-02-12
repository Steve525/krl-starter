ruleset HelloWorldApp {
  meta {
    name "Hello World"
    description <<
      Hello World
    >>
    author ""
    logging off
    use module a169x701 alias CloudRain
    use module a41x186  alias SquareTag
  }
  dispatch {
  }
  global {
  }
  rule hello_world {
    select when pageview ".*" setting ()
    // Display notification that will not fade.
    notify("Hello World", "This is a sample rule. I JUST CHANGED IT.") with sticky = true;
  }
}
