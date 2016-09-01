require "nessus_console/version"

module NessusConsole
  attr_accessor :N

  def load
	  optyaml = YAML::load_file($nessusconsoleyaml)
	  if optyaml != nil then
		  $options.merge!(optyaml)
	  end
  end

  def save
    File.open($nessusconsoleyaml, 'w') {|f| f.write $options.to_yaml }
  end

  def connect
    N=NessusREST::Client.new($options)
  end

  def rscans
    N.list_scans['scans']
  end

  def scans(*args)
    tp rscans, args
  end

  def rscansmy
    ret=N.list_scans['scans']
    selscans=ret.select do |scan|
      scan['folder_id']=='2'
    end
    return selscans
  end

  def scansmy(*args)
    tp rscansmy, args
  end

  def rfamilies
    tp N.list_families['families']
  end

  def families(*args)
    tp rfamilies, args
  end

  def rfolders
    tp N.list_scans['folders']
  end

  def folders(*args)
    tp rfolders, args
  end

  def rusers
    N.list_users['users']
  end

  def users(*args)
    tp rusers, args
  end

  def rhosts(id)
    N.scan_details(id)["hosts"]
  end

  def hosts(id,*args)
    tp rhosts(id), args
  end

  def hostsbrief(id)
    tp rhosts(id), :host_id, :hostname, :critical, :high, :medium, :low, :progress
  end

  def rvulns(id)
    N.scan_details(id)["vulnerabilities"]
  end

  def vulns (id, *args)
    tp rvulns(id), args
  end

  def tpn(x, *args)
    tp x.values[0], args
  end

  def tph(x, *args)
    x.each do |k,v|
      tp v, args
    end
    return x
  end

end
