# encoding: utf-8

require 'commander/import'
require 'open-uri'

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

      # Use different 'sed' syntax if on linux vs. osx.  On linux there is no space between -i and ''

      if RUBY_PLATFORM =~ /linux/
        # javascript
        cmd = "find . -type f -name '*.js' -exec sed -i'' s/CHANGE_ME/#{@nms}/g {} +"
          Kernel::system(cmd)
         # php
        cmd = "find . -type f -name '*.php' -exec sed -i'' s/CHANGE_ME/#{@nms}/g {} +"
          Kernel::system(cmd)
        # html
        cmd = "find . -type f -name '*.html' -exec sed -i'' s/CHANGE_ME/#{@nms}/g {} +"
          Kernel::system(cmd)
        # tpl
        cmd = "find . -type f -name '*.tpl' -exec sed -i'' s/CHANGE_ME/#{@nms}/g {} +"
          Kernel::system(cmd)
      else
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
      end

      # localhost setup
      choice = choose("Setup Localhost domain?", :yes, :no)

      if choice === :yes
         
        self.setup_localhost
          
      end

      # database setup
      choice = choose("Setup Local DB?", :yes, :no)

      if choice === :yes
         
        self.setup_db
          
      end

      # google analytics id
      choice = choose("Do you want to set the Google Analytics tracking id?", :yes, :no)

      if choice === :yes
         
        self.setup_analytics
          
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
    ctrl_endpoint = "./www/php/controller/#{@section}.php"
    cmd = "cp #{ctrl_startpoint} #{ctrl_endpoint}"
      Kernel::system(cmd);
      self.replace_once(ctrl_endpoint, "%name%", @section)
      self.msg "#{ctrl_endpoint} added"

    # view
    view_startpoint = "./scaffolding/simon/view.tpl";
    view_endpoint = "./www/php/view/#{@section}.php";
    cmd = "cp #{view_startpoint} #{view_endpoint}";
      Kernel::system(cmd);
      self.msg "#{view_endpoint} added"

    # javascript
    @js_section = name_space.gsub(/[^0-9A-Za-z]/, '')
    javascript_startpoint = "./scaffolding/standards/js_template.js";
    javascript_endpoint = "./www/js/#{@section}.js";
    cmd = "cp #{javascript_startpoint} #{javascript_endpoint}"
      Kernel::system( cmd );
      self.replace_once(javascript_endpoint, "CLASS_NAME", @js_section);
      self.replace_once("./www/php/template/footer.php", "<!-- END: app -->", "<script src=\"/js/#{@section}.js\" type=\"text/javascript\" charset=\"utf-8\"></script>\n\t\t<!-- END: app -->");
      self.replace_once("./www/js/master.js", "\*\/", "\* @depends #{@section}.js \n \*\/");
      self.msg "#{javascript_endpoint} added"

    # routes
    routes = "./www/php/system/config.routes.php";
    self.replace_once(routes, "?>", "Router::add('/#{@section}', DIR_CTRL.'/#{@section}.php');\n ?>");
    self.msg "#{routes} route added #{@section}"


    # model
    choice = choose("Add PHP Active Record Model?", :yes, :no)

      if choice === :yes
        model_startpoint = "./scaffolding/simon/model.tpl"
        model_endpoint = "./www/php/model/#{@section}.php"
        cmd = "cp  #{model_startpoint} #{model_endpoint}"
          Kernel::system( cmd );
          self.replace_once(model_endpoint, "%name%", @section)
          self.msg "#{model_endpoint} added"
      end
      self.complete 


  end


  def setup_localhost

    host = ask("What is the virtual host name? :  ") { |q| q.echo = true }
     
      config = "./app/www/php/system/Config.php"
      self.replace_once(config, "%l_vhost%", host)

    self.msg "#{config} modified"

  end


  def setup_db

    # self.check_hidden

    host = ask("What is the DB host? :  ") { |q| q.echo = true }
    username = ask("What is the DB Username? :  ") { |q| q.echo = true }
    password = ask("What is the DB password? :  ") { |q| q.echo = true }
    dbname = ask("What is the DB name? :  ") { |q| q.echo = true }

    config = "./app/www/php/system/Config.php"
    self.replace_once(config, "%l_host%", host)
    self.replace_once(config, "%l_user%", username)
    self.replace_once(config, "%l_pass%", password)
    self.replace_once(config, "%l_dbname%", dbname)

    self.msg "#{config} modified"
    
  end

  def setup_analytics
    tracking_id = ask("What is the GA tracking ID? :  ") { |q| q.echo = true }
    config = "./app/www/php/system/Config.php"
    self.replace_once(config, "%google_id%", tracking_id);
    self.msg "#{config} modified"
  end

  def replace_once(file_name, search_string, replace_string)
    text = File.read(file_name)
    new_text = text.gsub(search_string, replace_string)
    File.open(file_name, "w") {|file| file.puts new_text}
  end

  def add_js(js_path = nil)

    self.check_hidden
 
    if js_path.nil?
      js_path = ask("What's the URL to the javascript file? :  ") { |q| q.echo = true }
    end

    @js_file_name = js_path.split("/").last
  
    @choice = choose("Which directory do you want to download the file to?", :jquery, :plugins)

    @web_contents  = open(js_path) {|f| f.read }

    js_endpoint = "./www/js/#{@choice}/#{@js_file_name}"
    cmd = "touch #{js_endpoint}"
    self.msg "#{js_endpoint} added"

    Kernel::system( cmd );
    File.open(js_endpoint, 'w') { |file| file.write(@web_contents) }

    if @choice === :jquery
      self.replace_once("./www/php/template/footer.php", "<!-- END: jquery -->", "<script src=\"/js/jquery/#{@js_file_name}\" type=\"text/javascript\" charset=\"utf-8\"></script>\n\t\t<!-- END: jquery -->");
      self.replace_once("./www/js/master.js", "\*\/", "\* @depends jquery/#{@js_file_name} \n \*\/");
    else
      self.replace_once("./www/php/template/footer.php", "<!-- END: plugins -->", "<script src=\"/js/plugins/#{@js_file_name}\" type=\"text/javascript\" charset=\"utf-8\"></script>\n\t\t<!-- END: plugins -->");
      self.replace_once("./www/js/master.js", "\*\/", "\* @depends plugins/#{@js_file_name} \n \*\/");
    end


    self.complete
    
  end

  def check_4_update 

    
    @local_version = program :version
    @remote_version  = open("https://raw.github.com/samcreate/simon-cli/master/VERSION") {|f| f.read }

    if @local_version.strip !=  @remote_version.strip 
      puts "\n\n( ͡ʘ ʖ̲ ͡ʘ) - Out of Date! You're running #{@local_version}. Please update to the latest version #{@remote_version} \n\n ---> run: gem update my-simon\n\n"
    end

  end

  def add_backbone

    self.check_hidden

    # get backbone js included
    @bb_source  = open("http://backbonejs.org/backbone-min.js") {|f| f.read }
    js_endpoint = "./www/js/plugins/backbone-min.js"
    cmd = "touch #{js_endpoint}"
      Kernel::system( cmd );
    File.open(js_endpoint, 'w') { |file| file.write(@bb_source) }
    self.replace_once("./www/php/template/footer.php", "<!-- END: plugins -->", "<script src=\"/js/plugins/backbone-min.js\" type=\"text/javascript\" charset=\"utf-8\"></script>\n\t\t<!-- END: plugins -->");
    self.replace_once("./www/js/master.js", "\*\/", "\* @depends plugins/backbone-min.js \n \*\/");

    # setup director structure
    cmd = "mkdir ./www/js/app && mkdir ./www/js/app/views && mkdir ./www/js/app/models && mkdir ./www/js/app/collections"
      Kernel::system( cmd );

    # add application
    javascript_startpoint = "./scaffolding/standards/backbone/app.js";
    javascript_endpoint = "./www/js/app/app.js";
    cmd = "cp #{javascript_startpoint} #{javascript_endpoint}"
      Kernel::system( cmd );
    self.replace_once("./www/php/template/footer.php", "<!-- END: app -->", "<script src=\"/js/app/app.js\" type=\"text/javascript\" charset=\"utf-8\"></script>\n\t\t<!-- END: app -->");
    self.replace_once("./www/js/master.js", "\*\/", "\* @depends app/app.js \n \*\/");

    # message log to the user
    self.msg "./www/js/app/views added"
    self.msg "./www/js/app/models added"
    self.msg "./www/js/app/collections added"
    self.msg "./www/js/plugins/backbone-min.js added"
    self.msg "./www/js/app/app.js added"
    self.msg "./www/php/template/footer.php modified"
    self.msg "./www/js/master.js modified"
    self.complete
  end

  # TODO get beanstalk to fix their shit.
  # def setup_beanstalk
  #   subdomain = ask("What is the Beanstalk subdomain? :  ") { |q| q.echo = true }
  #   username = ask("What is your Beanstalk Username? :  ") { |q| q.echo = true }
  #   password = ask("What is your Beanstalk password? :  ") { |q| q.echo = true }
  #   repo_name = ask("What do you want to call this repo? :  ") { |q| q.echo = true }

  #   @repo_name = repo_name.gsub(/[^0-9A-Za-z-]/, '')

  #   choice = choose("What kind of repo?", :git, :subversion,:mercurial);

  #   if choice == :git
  #     choice = "git"
  #   elsif choice == :subversion
  #     choice = "subversion"
  #   elsif choice == :mercurial
  #     choice = "mercurial"
  #   end
      

  #   Beanstalk::API::Base.setup(
  #     :domain   => subdomain,
  #     :login    => username,
  #     :password => password
  #   )
  #   query = {'name' => @repo_name, 'type_id' => choice, 'title' => @repo_name, 'color_label' => 'label-blue'}

  #   response = Beanstalk::API::Repository::create(query)
  #   puts "(cd into the app directory) "
  #   puts "command line: $ git init ."
  #   puts "command line: $ git remote add origin #{response.repository_url}"

  #   self.complete 
    
  # end

end