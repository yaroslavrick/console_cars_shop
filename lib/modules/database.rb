module Database
  def load_db(filename)
    YAML.load_file(filename)
  end
end
