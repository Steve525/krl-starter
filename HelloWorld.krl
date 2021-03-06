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
    pre {
      findKeyName = function(s) {
                      f = s.extract(re/(&name=\w+&?|^name=\w+&?)/).head();
                      a = f.replace(re/name=/,"");
                      a.replace(re/&/g,"")
                    };
      keyName = findKeyName(page:url("query"));
    }
    if (keyName eq "") then {
      notify("Hello", "Monkey") with sticky = true; 
    }
    notfired {
      raise explicit event key_name_found with keyName = keyName;
    }
  }

  rule key_name_found {
    select when explicit key_name_found
    pre {
      keyName = event:param("keyName");
    }
    {
      notify("Hello", keyName) with sticky = true; 
    }
  }

  rule individual_page_view_counter {
    select when web pageview url re#ktest.heroku.com#
    pre {
      c = ent:page_count;
      c = c + 1;
    }
    if c <= 5 && not(page:url("query").match(re/clear/)) then {
      notify("Page View Count", c) with sticky = true;
    }
    fired {
      ent:page_count += 1 from 1;
    }
  }

  rule clear_page_view_counter {
    select when web pageview url re#ktest.heroku.com#
    if page:url("query").match(re/.*clear.*/) then {
      notify("Cleared Page Count", "") with sticky = true; 
    }
    fired {
      clear ent:page_count;
    }
  }
}
