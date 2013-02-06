class Primo
  class Creator

    def initialize template_name
      @template_name = template_name
    end

    def create name
      template.remote.ensure_cloned
      system "rails new #{name} -m #{template.expanded_filename}"
    end

    def template
      raise ArgumentError, "No such template found (#{@template_name})" unless Primo::Template.exists? @template_name
      @template ||= Primo::Template.for(@template_name)
    end
  end
end