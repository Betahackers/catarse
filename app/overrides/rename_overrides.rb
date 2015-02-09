Deface::Override.new(:virtual_path => "devise/sessions/new", 
                     :name => "devise.registrations.new", 
                     :remove => "erb[loud]:contains(':newsletter')")