require 'open-uri'
require 'nokogiri'
require 'rubygems'



def get_all_the_urls_of_val_doise_townhalls
    
    
    doc = Nokogiri::HTML(open("http://www.annuaire-des-mairies.com/val-d-oise.html"))
    
    list = doc.css('.lientxt')
    
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
        
    end
    
    return communes
    
end

communes = get_all_the_urls_of_val_doise_townhalls

communes.each do |commune, email|
    puts "#{commune} => #{email}"
end
