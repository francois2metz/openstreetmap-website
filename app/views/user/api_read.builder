xml.instruct! :xml, :version => "1.0"
xml.osm("version" => API_VERSION, "generator" => GENERATOR) do
  xml.tag! "user", :id => @this_user.id,
                   :display_name => @this_user.display_name,
                   :account_created => @this_user.creation_time.xmlschema do
    if @this_user.description
      xml.tag! "description", @this_user.description
    end
    xml.tag! "contributor-terms",
        :agreed => !!@this_user.terms_agreed,
        :pd => !!@this_user.consider_pd
    if @this_user.image.file?
      xml.tag! "img", :href => "http://#{SERVER_URL}#{@this_user.image.url}"
    end
    if @user && @user == @this_user
      if @this_user.home_lat and @this_user.home_lon
        xml.tag! "home", :lat => @this_user.home_lat,
                         :lon => @this_user.home_lon,
                         :zoom => @this_user.home_zoom
      end    
      if @this_user.languages
        xml.tag! "languages" do
          @this_user.languages.split(",") { |lang| xml.tag! "lang", lang }
        end
      end
    end
  end
end
