include Java
import 'org.apache.hadoop.hbase.client.HTable'
import 'org.apache.hadoop.hbase.client.Put'
import 'org.apache.hadoop.hbase.HBaseConfiguration'
import 'javax.xml.stream.XMLStreamConstants'

def jbytes( *args )
  args.map { |arg| arg.to_s.to_java_bytes }
end

factory = javax.xml.stream.XMLInputFactory.newInstance
reader = factory.createXMLStreamReader(java.lang.System.in)

document = nil
buffer = nil
count = 0

puts( @hbase )
conf = HBaseConfiguration.new
table = HTable.new( conf, "foods" )
table.setAutoFlush( false )

while reader.has_next
  type = reader.next
  
  if type == XMLStreamConstants::START_ELEMENT # (3)
  
    case reader.local_name
    when 'Food_Display_Row' then document = {}
    when /Display_Name|Portion_Default|Portion_Amount|Portion_Display_Name|Factor/ then buffer = []
    when /Increment|Multiplier|Grains|Whole_Grains|Vegetables|Orange_Vegetables/ then buffer = []
    when /Drkgreen_Vegetables|Starchy_vegetables|Other_Vegetables|Fruits|Milk|Meats/ then buffer = []
    when /Drybeans_Peas|Soy|Oils|Solid_Fats|Added_Sugars|Alcohol|Calories|Saturated_Fats/ then buffer = []
    end
    
  elsif type == XMLStreamConstants::CHARACTERS
    buffer << reader.text unless buffer.nil?
    
  elsif type == XMLStreamConstants::END_ELEMENT
    
    case reader.local_name
    when /Display_Name|Portion_Default|Portion_Amount|Portion_Display_Name|Factor/
      document[reader.local_name] = buffer.join
    when /Increment|Multiplier|Grains|Whole_Grains|Vegetables|Orange_Vegetables/
      document[reader.local_name] = buffer.join
    when /Drkgreen_Vegetables|Starchy_vegetables|Other_Vegetables|Fruits|Milk|Meats/
      document[reader.local_name] = buffer.join
    when /Drybeans_Peas|Soy|Oils|Solid_Fats|Added_Sugars|Alcohol|Calories|Saturated_Fats/
      document[reader.local_name] = buffer.join

    when 'Food_Display_Row'
      key = document['Display_Name'].to_java_bytes
      
      p = Put.new( key )
      p.add( *jbytes( "facts", "Display_Name", document['Display_Name'] ) )
      p.add( *jbytes( "facts", "Portion_Default", document['Portion_Default'] ) )
      p.add( *jbytes( "facts", "Portion_Amount", document['Portion_Amount'] ) )
      p.add( *jbytes( "facts", "Portion_Display_Name", document['Portion_Display_Name'] ) )
      p.add( *jbytes( "facts", "Factor", document['Factor'] ) )
      p.add( *jbytes( "facts", "Increment", document['Increment'] ) )
      p.add( *jbytes( "facts", "Multiplier", document['Multiplier'] ) )
      p.add( *jbytes( "facts", "Grains", document['Grains'] ) )
      p.add( *jbytes( "facts", "Whole_Grains", document['Whole_Grains'] ) )
      p.add( *jbytes( "facts", "Vegetables", document['Vegetables'] ) )
      p.add( *jbytes( "facts", "Orange_Vegetables", document['Orange_Vegetables'] ) )
      p.add( *jbytes( "facts", "Drkgreen_Vegetables", document['Drkgreen_Vegetables'] ) )
      p.add( *jbytes( "facts", "Starchy_vegetables", document['Starchy_vegetables'] ) )
      p.add( *jbytes( "facts", "Other_Vegetables", document['Other_Vegetables'] ) )
      p.add( *jbytes( "facts", "Fruits", document['Fruits'] ) )
      p.add( *jbytes( "facts", "Milk", document['Milk'] ) )
      p.add( *jbytes( "facts", "Meats", document['Meats'] ) )
      p.add( *jbytes( "facts", "Drybeans_Peas", document['Drybeans_Peas'] ) )
      p.add( *jbytes( "facts", "Soy", document['Soy'] ) )
      p.add( *jbytes( "facts", "Oils", document['Oils'] ) )
      p.add( *jbytes( "facts", "Solid_Fats", document['Solid_Fats'] ) )
      p.add( *jbytes( "facts", "Added_Sugars", document['Added_Sugars'] ) )
      p.add( *jbytes( "facts", "Alcohol", document['Alcohol'] ) )
      p.add( *jbytes( "facts", "Calories", document['Calories'] ) )
      p.add( *jbytes( "facts", "Saturated_Fats", document['Saturated_Fats'] ) )

      table.put( p )
      
      count += 1
      table.flushCommits() if count % 10 == 0
      if count % 500 == 0
        puts "#{count} records inserted (#{document['Display_Name']})"
      end
    end
  end
end

table.flushCommits()
exit
