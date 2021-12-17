require "./template.rb"
file_data = loadlines(16)

binary = file_data.pack('H*').unpack("B*").first

def parsePacket(input)
    version = input[0,3].to_i(2)
    type = input[3,3]
    case type
    when "100" # Literal Value
        pos = 6
        bits = ""
        while input[pos] != "0"
            bits << input[pos+1,4]
            pos += 5
        end
        bits << input[pos+1,4]
        value = bits.to_i(2)
        puts "Literal - version #{version}, value #{value}"
        return {"version" => version, "type" => type, "value" => value, "excess" => input[pos+5..-1]}
    else # Operator
        lengthid = input[6]
        sublength = 0
        packets = []
        excess = ""
        if lengthid == "0"
            sublength = input[7,15].to_i(2)
            subinput = input[7+15, sublength]
            while subinput.length > 6
                newpacket = parsePacket(subinput)
                packets << newpacket
                subinput = newpacket["excess"]
            end
            excess = input[7+15+sublength..-1]
        else
            sublength = input[7,11].to_i(2)
            subinput = input[7+11..-1]
            sublength.times {
                newpacket = parsePacket(subinput)
                packets << newpacket
                subinput = newpacket["excess"]
            }
            excess = subinput
        end
        puts "Operator - version #{version}, length id #{lengthid}, " + (lengthid == "0" ? "bit length = #{sublength}" : "sub-packets = #{sublength}")
        return {"version" => version, "type" => type, "packets" => packets, "excess" => excess}
    end
end

def sumVersions(packet)
    if packet["type"] == "100"
        return packet["version"]
    else
        total = packet["version"]
        packet["packets"].each {
            |inpacket|
            total += sumVersions(inpacket)
        }
        return total
    end
end

packet = parsePacket(binary)
puts packet
puts sumVersions(packet)