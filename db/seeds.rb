["Padrone", "Sotto Padrone", "Caporegime", "Soldato", "Associato"].each do |role|
  Role.find_or_create_by(name: role)
end

["Tutorials", "About", "Contacts"].each do |page_title|
  StaticPage.find_or_create_by(:title => page_title, :body => "Here will be content soon.")
end