module CoffeeShop
  class Template
    class << self
      include CoffeeShop::PathHelper

      def load(view, binding = nil)
        template  = get_path(view)
        content   = File.open(template, 'r') { |file| file.read }

        ERB.new(content).result(binding)
      end

      def load_404(binding = nil)
        load("page/404.html", binding)
      end

      def get_path(view)
        File.join(path(:views), "#{view}.erb")
      end

      def exists?(view)
        File.exist?( get_path(view) )
      end
    end
  end
end
