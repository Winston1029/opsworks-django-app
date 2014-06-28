package "supervisor"

service "supervisor" do
  reload_command "supervisorctl update"
end
