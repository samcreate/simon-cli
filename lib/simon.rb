#!/usr/bin/env ruby

require 'rubygems'
require 'commander/import'

program :version, '0.0.1'
program :description, 'CLI tool for Simon, a simple MVC boilerplate'
 
command :create, do |c|
  c.syntax = 'my-simon create, [options]'
  c.summary = ''
  c.description = ''
  c.example 'description', 'command example'
  c.option '--some-switch', 'Some switch that does something'
  c.action do |args, options|
    # Do something or c.when_called My-simon::Commands::Create,
    notify 'Create was called'
    puts 'Create was called'
  end
end

command :add, do |c|
  c.syntax = 'my-simon add, [options]'
  c.summary = ''
  c.description = ''
  c.example 'description', 'command example'
  c.option '--some-switch', 'Some switch that does something'
  c.action do |args, options|
    # Do something or c.when_called My-simon::Commands::Add,
  end
end

command :setup, do |c|
  c.syntax = 'my-simon setup, [options]'
  c.summary = ''
  c.description = ''
  c.example 'description', 'command example'
  c.option '--some-switch', 'Some switch that does something'
  c.action do |args, options|
    # Do something or c.when_called My-simon::Commands::Setup,
  end
end

command :help do |c|
  c.syntax = 'my-simon help [options]'
  c.summary = ''
  c.description = ''
  c.example 'description', 'command example'
  c.option '--some-switch', 'Some switch that does something'
  c.action do |args, options|
    # Do something or c.when_called My-simon::Commands::Help
  end
end

