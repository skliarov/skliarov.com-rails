["Padrone", "Sotto Padrone", "Caporegime", "Soldato", "Associato"].each do |role|
  Role.find_or_create_by_name(role)
end