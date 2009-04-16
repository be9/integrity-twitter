require 'rubygems'
require 'integrity'
require 'twitter'

module Integrity
  class Notifier
    class IntegrityTwitter < Notifier::Base
      
      def self.to_haml
        File.read File.dirname(__FILE__) / "config.haml"
      end

      def deliver!
        httpauth = Twitter::HTTPAuth.new(@config['email'], @config['pass'])
        @tweet = Twitter::Base.new(httpauth)

        @tweet.update(message)
      end
      
      def message
        "#{build_status} | #{commit.project.name}, commit #{commit.short_identifier} - [committer: #{commit.author.name}]"
      end
      
      private
      
      def build_status
        commit.successful? ? 'GREEN' : 'FAIL!'
      end
    end
  end
end
