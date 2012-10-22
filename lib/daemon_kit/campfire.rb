require 'tinder'

module DaemonKit
  # Thin wrapper around the blather DSL
  class Campfire

    class << self

      def run( &block )
        DaemonKit.trap('INT') { ::EM.stop }
        DaemonKit.trap('TERM') { ::EM.stop }

        DaemonKit::EM.run {
          campfire = new
          campfire.instance_eval( &block )
          campfire.run
        }
      end
    end

    def initialize
      @config = DaemonKit::Config.load('campfire')

      api_token = @config.api_token
      domain = @config.domain
      chat_rooms = @config.chat_rooms

      connect_campfire
      join_chat_rooms
      listen_to_rooms
    end

    def connect_campfire
      campfire = Tinder::Campfire.new(domain, :token => token)
    end

    def join_chat_rooms
      chat_rooms.each { |room| campfire.find_room_by_name(room) }
    end

    def listen_to_rooms
      chat_rooms.each do
        room.listen do |m|
          if m[:body] =~ /^\/pt_deploy/i
            args = m[:body].split(" ")
#            if args[1] == 'status' and args[2] == Settings[:deployed_environment]
#              room.paste()
#            end
            room.paste("Cabesahuevo!")
          end
        end
      end
    end

    def run
      client.run
    end

  end
end
