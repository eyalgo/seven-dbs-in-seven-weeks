def put_many( table_name, row, column_values )
  import 'org.apache.hadoop.hbase.client.HTable'
  import 'org.apache.hadoop.hbase.client.Put'
  import 'org.apache.hadoop.hbase.HBaseConfiguration'

  def jbytes( *args )
    args.map { |arg| arg.to_s.to_java_bytes }
  end

  puts( @hbase )
  conf = HBaseConfiguration.new
  table = HTable.new( conf, table_name )
  p = Put.new( *jbytes( row ) )
  
  column_values.each do |key, value|
    (key_family, key_name) = key.split(':')
    key_name ||= ""
    p.add( *jbytes( key_family, key_name, value ))
  end
  
  table.put( p )
end
