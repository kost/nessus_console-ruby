require "nessus_console/version"
require "nessus_console/help"

module NessusConsole
  def load
	  optyaml = YAML::load_file($nessusconsoleyaml)
	  if optyaml != nil then
		  $options.merge!(optyaml)
	  end
  end

  def neshelp
    NessusConsole::Help::neshelp()
  end

  def save
    File.open($nessusconsoleyaml, 'w') {|f| f.write $options.to_yaml }
  end

  def connect
    $n=NessusREST::Client.new($options)
  end

  def rscans
    $n.list_scans['scans']
  end

  def scans(*args)
    tp rscans, args
  end

  def rscansmy
    ret=$n.list_scans['scans']
    selscans=ret.select do |scan|
      scan['folder_id']=='2'
    end
    return selscans
  end

  def scansmy(*args)
    tp rscansmy, args
  end

  def rfamilies
    tp $n.list_families['families']
  end

  def families(*args)
    tp rfamilies, args
  end

  def rfolders
    tp $n.list_scans['folders']
  end

  def folders(*args)
    tp rfolders, args
  end

  def rusers
    $n.list_users['users']
  end

  def users(*args)
    tp rusers, args
  end

  def rhosts(id)
    $n.scan_details(id)['hosts']
  end

  def hosts(id,*args)
    tp rhosts(id), args
  end

  def rhostsvulns(id)
    filtered=Array.new
    rhosts(id).each do |h|
      if h[:critical]>0 then
        filtered.push h
      end
    end
    return filtered
  end

  def hostsvulns(id)
    tp rhostsvulns(id)
  end

  def hostsbrief(id)
    tp rhosts(id), :host_id, :hostname, :critical, :high, :medium, :low, :progress
  end

  def rvulns(id)
    $n.scan_details(id)['vulnerabilities']
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
