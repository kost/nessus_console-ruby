module NessusConsole
  class Help
    def self.neshelp
puts <<END
load	load nessus configuration from configuration file
save	save nessus configuration from configuration file
connect	connect to the server with provided credentials
scans	list all scans
folders	list all scan folders
END
    end
  end
end
