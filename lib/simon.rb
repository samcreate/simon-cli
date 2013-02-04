# encoding: utf-8
require 'commander/import'
class Simon

  def rename
    puts "rename called"
  end

  def msg(msg)
    puts "---> #{msg}"
  end

  def complete()
    puts "\n( ͡° ͜ʖ ͡°)﻿ --thank you"
  end

  def setup
    name_space = ask("Namespace [a-zA-Z0-9_] :  ") { |q| q.echo = true }

      @nms = Regexp.escape(name_space) # escape any special characters  
      # javascript
      cmd = "find . -type f -name '*.js' -exec sed -i '' s/CHANGE_ME/#{@nms}/ {} +"
        Kernel::system(cmd)
       # php
      cmd = "find . -type f -name '*.php' -exec sed -i '' s/CHANGE_ME/#{@nms}/ {} +"
        Kernel::system(cmd)
      # html
      cmd = "find . -type f -name '*.html' -exec sed -i '' s/CHANGE_ME/#{@nms}/ {} +"
        Kernel::system(cmd)
      # tpl
      cmd = "find . -type f -name '*.tpl' -exec sed -i '' s/CHANGE_ME/#{@nms}/ {} +"
        Kernel::system(cmd)

      # simon_controller.find_and_replace './app'ateasub01@


      choice = choose("Setup Local DB?", :yes, :now)

      if choice === :yes
         self.msg 'setting up Local DB'
      end

      self.msg 'Setup complete!'
      self.complete
  end

end