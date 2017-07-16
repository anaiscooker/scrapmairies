require 'open-uri'
require 'nokogiri'
require 'rubygems'



def get_all_the_urls_of_val_doise_townhalls
    
    
    #ON APPELLE NOKOGIRI
    
    #ON LUI DEMANDE DE CHOPER TOUS LES ELEMENTS QUI ONT L ATTRIBUT CSS ".LIENTXT
    
    #ILS SONT CONSERVES DANS LA VARIABLE LIST, ET VU QU'ILS SONT PLUSIEURS C'EST
    #UNE LISTE
    
    #ON EXTRAIT LES HREF
    
    #SUR CHAQUE ELEMENT DE (.EACH) ON RETRAVAILLE L URL POUR QU'ELLE PUISSE ETRE
    #TRAITEE PAR NOKOGIRI
    
    #ON OUVRE L URL
    
    #ON RECUPERE LES ELEMENTS DE STYLE .STYLE22 QUI SONT STOCKES DANS UNE LISTE
    
    #POUR CHAQUE ELEMENT, ON VERIFIE S ILS CONTIENNENT UN EMAIL AVEC LE REGEX
    
    #ET ON LES AFFICHE SI LE RESULTAT N EST PAS NUL
    
    #ON VA DEVOIR METTRE TOUT CA DANS UN HASH ET L ASSOCIER AU NOM DES VILLES
    
    #TADAM
    
    doc = Nokogiri::HTML(open("http://www.annuaire-des-mairies.com/val-d-oise.html"))
    
    list = doc.css('.lientxt')
      
#    ville = doc.xpath('//table/tr[2]/td/table/tr/td/p/a')
    
#    ville_nom = ville.text.split.each do |ville_nom|
#        puts ville_nom
#    end
    
        
    url = list.map { |list| list['href'] }
    
    communes = Hash.new
    
    url.each do |url|    
        
        urlc = "http://www.annuaire-des-mairies.com/#{url}"
     
        page = Nokogiri::HTML(open(urlc))
        
        commune = page.css('strong > a.lientxt4').text
        
        tr = page.css('body > table td > table td > table td > table tr')
     
        email = ""
        
        tr.each do |tr|
           if tr.css('td > p > font > b').text == 'Adresse Email:'
                email = tr.css('td > p > font')[1].text.gsub("/&nbsp;/", "")

                break
           end
        end
        
        communes[commune] = email
        
        #mairie = page.css('.Style22')
        
        
    #    mairie.each do |mairie|
            
     #       stl22= mairie.text
      #      valid_email = /[a-zA-Z.\d-_x\w]+@[a-zA-Z.\d-_]+.[a-zA-Z.\d-_\w]{2,}/
#
 #           email = stl22.match valid_email


  #          unless email == nil
   #             puts email
                #puts :email => "#{email}" 
                # puts :ville => "#{@ville}"  appel de url.text :ville => "#{ville}"
    #        end

     #   end
        break
    end
    
    return communes
    
end

#chaque url => méthode get the email 

#def get_the_email_of_a_townhal_from_its_webpage 
   # doc = Nokogiri::HTML(open("#{urlc}"))
   # mairie = doc.css('.Style22')
   # mairie.each do |mairie|
   # stl22= mairie.text
   # valid_email = /[a-zA-Z.\d-_x\w]+@[a-zA-Z.\d-_]+.[a-zA-Z.\d-_\w]{2,}/
   #     email = stl22.match valid_email
   # unless email == nil
   #     puts :email => "#{email}"
   #     end
   # end
#end

#créer un hash vide
#je crée un autre hash(key list.text / value : email)

#@mairies = Hash.new ()
 #           h [:key ] = array_ville
  #          h [:value] = array_email
   #         puts @mairies
    #        end

communes = get_all_the_urls_of_val_doise_townhalls

communes.each do |commune, email|
    puts "#{commune} => #{email}"
end