class Primo
  class Creator

    def initialize template_name
      @template_name = template_name
    end

    def create name
      system "rails new #{name} -m #{template_filename}"
    end

    private

    def template_filename
      Primo::Template.for(@template_name).expanded_filename
    end
  end
end