module DaemonKit
  module Generators
    class CampfireGenerator < Base

      def update_gemfile
        append_file 'Gemfile', "gem 'tinder'\n"
      end

      def create_config
        directory 'config'
      end

      def create_daemon
        directory 'libexec'
      end

      protected

      def self.source_root
        File.expand_path( File.join( File.dirname(__FILE__), 'templates') )
      end
    end
  end
end
