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
        @tweet = Twitter::Base.new(@config["email"], @config["pass"])
        @tweet.post(message)
      end
      
      def message
        "#{build_status} | #{project.name}, commit #{build.short_commit_identifier} - [committer: #{build.commit_author.name}]"
      end
      
      private
      
      def build_status
        build.successful? ? 'GREEN' : 'FAIL!'
      end
      
      def project
        @project ||= build.project
      end
    end
  end
end