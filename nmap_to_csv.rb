#!/usr/bin/ruby

def check_file(file)
   if file == "nofilename"
      puts 
      puts "syntax:  ruby nmap_to_csv.rb <nmapfile.nmap>"
      puts 
      puts "This program takes nmap \"grepable\" files and converts them"
      puts "to a CSV file.  i.e nmap -oG nmapfile.nmap 10.1.1.1"
      puts
   elsif
      File.exists? file
      return true
   else 
      puts "File does not exist."
   end
end

def split_up_file(file)		
    entirefile = []
    ports = []
    if File.exists?("output.csv") 
	puts "File output.csv exists.  Press RETURN to overwrite it"
	puts "Press CTRL-C to abort"
	STDIN.gets
    end
    target = File.open("output.csv", 'w')
    File.open(file).each_line do |line|  
	temp = line.gsub!(/[\/\,]/, " ")
	unless temp.nil?
	   entirefile.push(temp)
	end
    end

    entirefile.each do |x|
    	ports = x.split(" ")
	print "#{ports[1]}"
	host = "#{ports[1]}"
	target.write(host)
	z = 0
	while z < 10000	
	    countera = z
	    counterb = z + 1
	    counterc = z + 2
	    counterd = z + 3
    	    if ports[counterb] == "open"
		print ", #{ports[countera]}, #{ports[counterc]}, #{ports[counterd]}"
		tarports = ", #{ports[countera]}, #{ports[counterc]}, #{ports[counterd]}"
	        target.write(tarports)
	    end
	z += 4
	end
    puts
    target.write("\n")
    end
    puts
    puts "Contents placed in output.csv"
    puts
    target.close()
end


filename = "nofilename" if (filename = ARGV.shift).nil?

if check_file(filename) == true
    split_up_file(filename)
end

