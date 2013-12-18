 task :build do
   puts "Building CSS"
    sh 'juicer merge ../www/styles/master.css -o ../www/styles/evbmaster-min.css --force'
    puts "Building JS"
     sh 'juicer merge -i ../www/js/master.js -o ../www/js/evbmaster-min.js --force'
 end
 
 
