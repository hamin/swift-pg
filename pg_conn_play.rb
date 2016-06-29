require 'socket'
require 'postgres-pr/message'
include PostgresPR


user = "metabase-dev"
db = "metabase-pager-copy"

msg = StartupMessage.new(196608, "user" => user, "database" => db)
puts "OK HERE IS THE DUMP: #{msg.dump}"
puts msg.dump

# s = UNIXSocket.new(ARGV.shift || "/tmp/.s.PGSQL.5432")
s = TCPSocket.open("localhost", 5432)

s << msg.dump

Thread.start(s) { |s|
  sleep 2
  s << Query.new("select * from core_user;").dump

  while not (line = gets.chomp).empty?
    s << Query.new(line).dump
  end
  exit
}


loop do
  msg = Message.read(s)
  p msg

  case msg
  when AuthentificationOk
    p "OK"
  when ErrorResponse
    p "FAILED"
  end
end