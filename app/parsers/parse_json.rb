class ParseJson

  def parse_standard_payload
    base_dir = Dir.open(Rails.root.join('seed data'))
    base_dir.each do |current_dir|
      unless current_dir.to_s.eql? '.' or current_dir.to_s.eql? '..'
        temp_dir = Dir.open("#{base_dir.path}/#{current_dir.to_s}")
        app_file = File.open("#{temp_dir.path}/process_app.json")
        app_json = app_file.read
        app_file.close
        app_hash = ActiveSupport::JSON.decode(app_json)
        temp_app = parse_app(app_hash)
        temp_app.save
        parse_snapshots("#{temp_dir.path}/snapshots")
        parse_dependencies("#{temp_dir.path}/dependencies")
        parse_toolkits("#{temp_dir.path}/toolkits")
      end
    end
  end

  # Parses the app hash to a ProcessApp and saves
  # @param [Hash] data
  def parse_app(data)
    temp_app = ProcessApp.find_or_create_by_id(data['id'])
    temp_app.description=data['description']
    temp_app.guid=data['guid']
    temp_app.name=data['name']
    temp_app.short_name=data['short_name']
    temp_app
  end

  #Parses the snapshot directory
  #@param [String] snapshot_path path to the snapshot directory
  def parse_snapshots(snapshot_path)
    Dir.open(snapshot_path).each do |snap_file|
      unless snap_file.to_s.eql?('.') or snap_file.to_s.eql?('..')
        snap_file=File.open("#{snapshot_path}/#{snap_file}")
        snap_hash=ActiveSupport::JSON.decode(snap_file.read)
        snap_file.close
        temp_snap=Snapshot.find_or_create_by_id(snap_hash['id'])
        temp_snap.name=snap_hash['name']
        temp_snap.guid=snap_hash['guid']
        temp_snap.process_app_id=snap_hash['process_app_id']
        temp_snap.save
      end
    end
  end

  #Parses the dependency directory
  #@param [String] dependency_path the path to the dependency directory
  def parse_dependencies(dependency_path)
    Dir.open(dependency_path).each do |dependency_file_name|
      unless dependency_file_name.to_s.eql?('.') or dependency_file_name.to_s.eql?('..')
        dependency_file=File.open("#{dependency_path}/#{dependency_file_name}")
        dependency_array=ActiveSupport::JSON.decode(dependency_file.read)
        dependency_file.close
        dependency_array.each do |dependency_hash|
          temp_dependency = Dependency.find_or_create_by_id(dependency_hash['id'])
          temp_dependency.guid=dependency_hash['guid']
          temp_dependency.proc_app_snap_id=dependency_hash['proc_app_snap_id']
          temp_dependency.toolkit_snap_id=dependency_hash['toolkit_snap_id']
          temp_dependency.save
        end
      end
    end
  end

  #Parses the toolkit directory
  #@param [String] toolkit_path the path to the toolkit directory
  def parse_toolkits(toolkit_path)
    Dir.open(toolkit_path).each do |toolkit_file_name|
      unless toolkit_file_name.to_s.eql?('.') or toolkit_file_name.to_s.eql?('..')
        toolkit_file=File.open("#{toolkit_path}/#{toolkit_file_name}")
        toolkit_json = ActiveSupport::JSON.decode(toolkit_file.read)
        toolkit_file.close
        toolkit= Toolkit.find_or_create_by_id(toolkit_json['id'])
        toolkit.description=toolkit_json['description']
        toolkit.guid=toolkit_json['guid']
        toolkit.name=toolkit_json['name']
        toolkit.short_name=toolkit_json['short_name']
        toolkit.save
      end
    end
  end



end