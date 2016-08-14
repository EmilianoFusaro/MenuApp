#debug (byebug) source pippo.rb
a="if (1==1) ;"
a= a + "b=\"cazzo\";"
a= a + "puts \"ciao \" + b ;"
#a= a + "puts 'ciao #{b}' + b ;"
a= a + "else ;"
a= a + "puts 'fancul' ;"
a= a + "end ;"
a= a + "puts params ;"



a= "params[:medium].each do |key, array| ;"
#a= a + "puts key + ' k ' ;"
a= a + "puts array ;"
a= a + "end"


eval(a)
