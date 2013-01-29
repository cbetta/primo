class Primo
  class Creator

    def initialize template_name
      @template_name = template_name
    end

    def create name
      system "rails new #{name} -m #{template_path}"
    end

    def template_path
      Primo::Template.new(template_name).path
    end
  end
end