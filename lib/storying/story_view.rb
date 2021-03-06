module Storying
  module Views
    class StoryView < Mustache
      include Delegation
      include StoryElements

      def story
        @story ||= Storying::Story.new
      end

      def templates
        StoryingWebApp::TEMPLATES
      end

      delegate :hero, :villain, :support, :to => :story

      STORY_ELEMENTS_PATH = ROOT + "/story_elements"
      self.raise_on_context_miss = true

      Dir.open(STORY_ELEMENTS_PATH) do |dir|
        dir.each do |filename|
          next unless filename =~ /\.yml$/
          element_name = filename.gsub('.yml', '').to_sym
          elements = YAML.load_file(File.join(STORY_ELEMENTS_PATH, filename))
          define_method element_name do
            unless instance_variable_defined? "@#{element_name}"
              instance_variable_set "@#{element_name}", elements
            else
              instance_variable_get "@#{element_name}"
            end
          end
        end
      end

    end
  end
end