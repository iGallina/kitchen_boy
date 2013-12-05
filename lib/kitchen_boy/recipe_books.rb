require 'kitchen_boy/config'
require 'kitchen_boy/logger'
require 'kitchen_boy/recipe_book'
require 'uri'

module KitchenBoy
  class RecipeBooks
    include KitchenBoy::Logger
    attr_accessor :config
    
    def initialize config
      @config = config
    end

    def load_recipe_books
      self.instance_eval(IO.read(@config.recipe_books_file_path))
    end


    def git repo, message = nil
      uri = URI.parse(repo)
      raise URI::InvalidURIError if uri.scheme.nil?

      include_in_sources(repo)

    rescue URI::Error
      message ||= "When reading recipe_books, is this git repo correct? #{repo}"
      log_warning message
    end

    def github shorthand
      repo = "https://github.com/#{shorthand}.git"
      git(repo, "When reading recipe_books, is this github shorthand correct? #{shorthand}")
    end

    def directory path
      case
      when !Dir.exist?(path)
        log_warning "When reading recipe_books, this directory is inexistent: #{path}"
      when !File.readable?(path)
        log_warning "When reading recipe_books, this directory is not readable: #{path}"
      else
        include_in_sources(path)
      end
    end

    private

    def include_in_sources source
      @config.sources << source unless @config.sources.include?(source)
    end
  end
end
