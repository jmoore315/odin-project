require 'socket'
require 'json'

def get_request_type
  valid = false 
  type = ""
  until valid do  
    print "Enter request type (GET or POST): "
    type = gets.chomp.upcase 
    if type == 'GET' || type == 'POST'
      valid = true 
    else 
      puts "Invalid request type. Options are GET or POST."
    end
  end
  type
end 

def parse_response(response)
  header,body = response.split("\r\n\r\n")
  if header =~ /200/
    print body 
  elsif header =~ /\d\d\d/
    print header[(header =~ (/\d\d\d/))..-1]
  else 
    print header
  end
end

def get_post_params
  required_fields = [:name, :email, :age, :weapon]
  params = { viking: {} }
  puts "Enter some information for your new viking:"
  required_fields.each do |field|
    print "#{field.to_s}: "
    params[:viking][field] = gets.chomp
  end
  params
end

hostname = 'localhost'
port = 2000

loop do 
  s = TCPSocket.open(hostname, port)
  type = get_request_type
  case type 
    when 'GET'
      s.print "#{type} #{file} HTTP/1.0\\r\\n\\r\\n"
      parse_response s.read 
    when 'POST'
      print "Enter filename (e.g., 'index.html'): "
      file = gets.chomp.insert(0,'/')
      params = get_post_params.to_json
      s.print "#{type} #{file} HTTP/1.0\\r\\nContent-Length: #{params.length}\\r\\n#\\r\\n{params}"
      parse_response s.read 
      # puts "Post request"
      # puts params
    end
    s.close
    puts
end



