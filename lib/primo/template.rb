class Primo
  class Template

    attr_accessor :filename, :collection

    def self.for template_name
      collection_name, name = template_name.split("-")
      collection = Primo::Collection.new(collection_name)
      filename = "#{name}.rb"
      Primo::Template.new filename, collection
    end

    def initialize filename, collection
      @filename = filename
      @collection = collection
    end

    def full_name
      "#{collection.name}-#{name}"
    end

    def name
      filename[0..-4]
    end

    def full_filename
      "#{COLLECTIONS_DIRECTORY}/#{collection.name}/#{filename}"
    end

    def self.list
      Primo::Collection.list.inject([]) do |results, (name, url)|
        Primo::Collection.new(name).templates.each do |template|
          results.push [template.full_name, template.collection.name, template.full_filename]
        end
        results
      end
    end

    def read
      File.read(full_filename)
    end

    private

    COLLECTIONS_DIRECTORY = File.expand_path('~/.primo_collections').freeze

  end
end