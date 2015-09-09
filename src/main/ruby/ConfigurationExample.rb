#!/usr/bin/env ruby
#
# This file provides an example of creating a command line application with a
# wide variety of command line options, parsing and the like as well as global
# configuration singleton that can be relied on throughout a program.
#
# This entire setup lives within the "Example" module. These are really common
# names and it would be a shame to override required functionality in other code
# that wasn't properly namespaced.
#
# @author Sam Stelfox
# @see https://stelfox.net/blog/2012/12/rubys-option-parser-a-more-complete-example/
#
require 'optparse'
require 'singleton'
require 'yaml'

module Example
  # Defines the available configuration options for the configuration
  ConfigurationStruct = Struct.new(:enum, :list, :required, :optional, :verbose, :float)

  class Configuration
    include Singleton

    # Initialize the configuration and set defaults:
    @@config = ConfigurationStruct.new

    # This is where the defaults are being set
    @@config.enum = :one
    @@config.list = []
    @@config.optional = nil
    @@config.verbose = false

    def self.config
      yield(@@config) if block_given?
      @@config
    end

    # Loads a YAML configuration file and sets each of the configuration values to
    # whats in the file.
    def self.load(file)
      YAML::load_file(file).each do |key, value|
        self.send("#{key}=", value)
      end
    end

    # This provides an easy way to dump the configuration as a hash
    def self.to_hash
      Hash[@@config.each_pair.to_a]
    end

    # Pass any other calls (most likely attribute setters/getters on to the
    # configuration as a way to easily set/get attribute values 
    def self.method_missing(method, *args, &block)
      if @@config.respond_to?(method)
        @@config.send(method, *args, &block)
      else
        raise NoMethodError
      end
    end

    # Handles validating the configuration that has been loaded/configured
    def self.validate!
      valid = true

      valid = false if Configuration.required.nil?

      raise ArgumentError unless valid
    end
  end

  class ConfigurationParser
    def self.parse(args)
      opts = OptionParser.new do |parser|

        parser.separator ""
        parser.separator "Specific options:"

        parser.on("-e", "--enum ENUM", [:one, :two, :three], "This field requires one of a set of predefined values be", "set. If wrapped in brackets this option can be set to nil.") do |setting|
          Configuration.enum = setting
        end

        parser.on("-l", "--list x,y", Array, "This command flag takes a comma separated list (without", "spaces) of values and turns it into an array. This requires", "at least one argument.") do |setting|
          Configuration.list = setting
        end

        parser.on("--[no-]verbose", "This is a common boolean flag, setting verbosity to either", "true or false.") do |setting|
          Configuration.verbose = setting
        end

        parser.on("--optional [STR]", "This command doesn't require a string to be passed to it, if", "nothing is passed it will be nil. No error will be raised if", "nothing is passed to it that logic needs to be handled", "yourself.") do |setting|
          Configuration.optional = setting
        end

        parser.on("-r", "--required STR", "This command requires a string to be passed to it.") do |setting|
          Configuration.required = setting
        end

        parser.on("-f","--float NUM", Float, "This command will only accept an integer or a float.") do |setting|
          Configuration.float = setting
        end

        parser.on_tail("-h", "--help", "--usage", "Show this usage message and quit.") do |setting|
          puts parser.help
          exit
        end

        parser.on_tail("-v", "--version", "Show version information about this program and quit.") do
          puts "Option Parser Example v1.0.0"
          exit
        end
      end

      opts.parse!(args)
    end
  end
end

if File.exists?("config.yml")
  Example::Configuration.load("config.yml")
end

Example::ConfigurationParser.parse(ARGV)
Example::Configuration.validate!

require "json"
puts JSON.pretty_generate(Example::Configuration.to_hash)


