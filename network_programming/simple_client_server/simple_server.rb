require 'socket'
require 'json'

def parse(http_request)
  if http_request.match /\AGET[ ]{1}\/\S+[ ]{1}HTTP\/1.0\\r\\n\\r\\n\z/
    request_parts = http_request.split(" ")
    req = { type: request_parts[0], file_requested: request_parts[1] }
  elsif http_request.match /\APOST[ ]{1}\/\S+[ ]{1}HTTP\/1.0/
    request_parts = http_request.split(" ")
    req = { type: request_parts[0], file_requested: request_parts[1] }
  else 
    req = {}
  end
  req
end

def generate_reply(file)
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



server = TCPServer.open(2000)

loop {
  client = server.accept
  request = parse(client.recv(256))
  if request[:type] == 'GET'
    response = generate_reply(request[:file_requested])
  elsif request[:type] == 'POST'
    response = "HTTP/1.0 200 got post request"
    puts response
  else
    response = "Invalid request" 
  end
  client.puts(response)
  client.close 
}