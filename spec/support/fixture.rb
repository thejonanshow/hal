class Fixture
  def self.load(file)
    contents = File.read Rails.root.join("spec", "fixtures", "#{file}.json")
    JSON.parse contents
  end
end
