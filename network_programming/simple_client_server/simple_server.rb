require 'socket'
require 'json'

def parse(http_request)
  if http_request.match /\AGET[ ]{1}\/\S+[ ]{1}HTTP\/1.0\\r\\n\\r\\n\z/
    header,body = http_request.split("\r\n\r\n",2)
    header_parts = header.split(" ")
    req = { type: header_parts[0], file_requested: header_parts[1] }
  elsif http_request.match /\APOST[ ]{1}\/\S+[ ]{1}HTTP\/1.0/
    header,body = http_request.split("\\r\\n\\r\\n",2)
    header_parts = header.split(" ")
    params = JSON.parse(body)
    req = { type: header_parts[0], file_requested: header_parts[1], params: params }
  else 
    req = {}
  end
  req
end

def get_reply(file)
  file_requested = file.insert(0,'.')
    if !File.exists?(file_requested)
      response = "HTTP/1.0 404 File Not Found\r\n\r\n"
    else 
      file = File.open(file_requested, "rb").read
      length = file.length 
      response = "HTTP/1.0 200 OK\r\n" \
        "Content-Type: text/html\r\n" \
        "Content-Length: #{length}\r\n" \
        "\r\n" \
        "#{file}"
    end
  response
end

def post_reply(file,params)
  file_requested = file.insert(0,'.')
  if !File.exists?(file_requested)
    response = "HTTP/1.0 404 File Not Found\r\n\r\n"
  else 
    params = params["viking"]
    viking_info = "<ul>"
    params.each do |k,v|
      viking_info << "<li>#{k.capitalize}: #{v}</li>\n"
    end
    viking_info << "</ul>"
    file = File.open(file_requested).read.gsub(/<%= yield %>/, viking_info)
    length = file.length
    response = "HTTP/1.0 200 OK\r\n" \
      "Content-Type: text/html\r\n" \
      "Content-Length: #{length}\r\n" \
      "\r\n" \
      "#{file}"
  end
  response
end



server = TCPServer.open(2000)

loop {
  client = server.accept
  request = parse(client.recv(1000))
  if request[:type] == 'GET'
    response = get_reply(request[:file_requested])
  elsif request[:type] == 'POST'
    response = post_reply(request[:file_requested], request[:params])
  else
    response = "Invalid request" 
  end
  client.puts(response)
  client.close 
}