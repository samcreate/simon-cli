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

  def check_hidden
    
    if File.exist?("./.simon")
      true
    else
      self.msg "Error: Simon needs to be in the root of the project"
      exit
    end
  end

  def make_hidden
    outFile = File.new("./app/.simon", "w")
    outFile.puts("Simon Added on #{Time.now.getutc}")
    outFile.close
  end

  def setup
      name_space = ask("Namespace [a-zA-Z0-9_] :  ") { |q| q.echo = true }

      @nms = Regexp.escape(name_space) # escape any special characters  
      # javascript
      cmd = "find . -type f -name '*.js' -exec sed -i '' s/CHANGE_ME/#{@nms}/g {} +"
        Kernel::system(cmd)
       # php
      cmd = "find . -type f -name '*.php' -exec sed -i '' s/CHANGE_ME/#{@nms}/g {} +"
        Kernel::system(cmd)
      # html
      cmd = "find . -type f -name '*.html' -exec sed -i '' s/CHANGE_ME/#{@nms}/g {} +"
        Kernel::system(cmd)
      # tpl
      cmd = "find . -type f -name '*.tpl' -exec sed -i '' s/CHANGE_ME/#{@nms}/g {} +"
        Kernel::system(cmd)

       # Kernel::system(cmd)
      choice = choose("Setup Local DB?", :yes, :no)

      if choice === :yes
         self.msg 'setting up Local DB'
      end

      self.msg 'Setup complete!'
      self.make_hidden
      self.complete
  end

  def add_section
    self.check_hidden
    name_space = ask("Namespace [a-zA-Z0-9_] :  ") { |q| q.echo = true }

    @section = name_space.gsub(/[^0-9A-Za-z-]/, '')

    # controller
    self.msg "#Adding section: #{@section}"
    ctrl_startpoint = "./scaffolding/simon/controller.tpl"
    ctrl_endpoint = "./www/lib/php/controller/#{@section}.php"
    cmd = "cp #{ctrl_startpoint} #{ctrl_endpoint}"
      Kernel::system(cmd);
      self.replace_once(ctrl_endpoint, "%name%", @section)
      self.msg "#{ctrl_endpoint} added"

    # view
    view_startpoint = "./scaffolding/simon/view.tpl";
    view_endpoint = "./www/lib/php/view/#{@section}.php";
    cmd = "cp #{view_startpoint} #{view_endpoint}";
      Kernel::system(cmd);
      self.msg "#{view_endpoint} added"

    # javascript
    @js_section = name_space.gsub(/[^0-9A-Za-z]/, '')
    javascript_startpoint = "./scaffolding/standards/js_template.js";
    javascript_endpoint = "./www/lib/js/#{@section}.js";
    cmd = "cp #{javascript_startpoint} #{javascript_endpoint}"
      Kernel::system( cmd );
      self.replace_once(javascript_endpoint, "CLASS_NAME", @js_section);
      self.replace_once("./www/lib/php/template/footer.php", "<!-- END: DEV javascript -->", "<script src=\"/lib/js/#{@section}.js\" type=\"text/javascript\" charset=\"utf-8\"></script>\n\t\t<!-- END: DEV javascript -->");
      self.replace_once("./www/lib/js/master.js", "\*\/", "\* @depends #{@section}.js \n \*\/");
      self.msg "#{javascript_endpoint} added"

    # routes
    routes = "./www/lib/php/system/config.routes.php";
    self.replace_once(routes, "?>", "Router::add('/#{@section}', DIR_CTRL.'/#{@section}.php');\n ?>");
    self.msg "#{routes} route added #{@section}"


    # model
    choice = choose("Add PHP Active Record Model?", :yes, :no)

      if choice === :yes
        model_startpoint = "./scaffolding/simon/model.tpl"
        model_endpoint = "./www/lib/php/model/#{@section}.php"
        cmd = "cp  #{model_startpoint} #{model_endpoint}"
          Kernel::system( cmd );
          self.replace_once(model_endpoint, "%name%", @section)
          self.msg "#{model_endpoint} added"
      end
      self.complete 


  end

  def replace_once(file_name, search_string, replace_string)
    text = File.read(file_name)
    new_text = text.gsub(search_string, replace_string)
    File.open(file_name, "w") {|file| file.puts new_text}
  end

end