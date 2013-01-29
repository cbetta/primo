class Primo
  class Collection
    def list
      Primo::Config.instance.config[:collections]
    end

    def add name, url
      Primo::Config.instance.config[:collections][name] = url
      Primo::Config.instance.save_config
    end

    def delete name
      Primo::Config.instance.config[:collections].delete(name)
      Primo::Config.instance.save_config
    end
  end
end