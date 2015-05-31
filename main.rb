require 'sinatra'
require 'sinatra/contrib/all'
require 'pg'
require 'pry'

get "/" do 
    redirect to("/videos")
end
# adding and deleting videos

# getting videos
get "/videos" do 
   sql = "SELECT * FROM videos ORDER BY artist"
     @videos = run_sql(sql)
     if request.xhr?
      json @videos.to_a
     else
      erb :index
     end
  end     


get "/videos/new" do
  erb :new
end   

# adding a new video
post "/videos"  do
    artist = params[:artist]
    title = params[:title]
    description = params[:description]
    category = params[:category]
    genre = params[:genre]
    url = params[:url]
    sql = "INSERT INTO videos (artist, title, description, category, genre, url) VALUES (#{sql_string(artist)}, #{sql_string(title)}, #{sql_string(description)}, '#{category}','#{genre}', '#{url}');"

    @videos = run_sql(sql).first
    if request .xhr?
       json@videos
    else
       redirect to ("/videos")
    end  
end         

#  playing a video
get "/videos/:id" do
  sql = "SELECT * FROM videos WHERE id=#{params[:id]}"
  @video = run_sql(sql).first
  erb :show
end

# editing a video
get "/videos/:id/edit" do
  sql = "SELECT * FROM videos WHERE id=#{params[:id]}"
  @video = run_sql(sql).first
  erb :edit
end

# updating an edited video
post "/videos/:id" do
  artist = params[:artist]
  title = params[:title]
  description = params[:description]
  category = params[:category]
  genre = params[:genre]
  url = params[:url]

  sql = "UPDATE videos SET artist=#{sql_string(artist)}, title=#{sql_string(title)}, description=#{sql_string(description)}, url='#{url}', category='#{category}', genre='#{genre}' WHERE id='#{params[:id]}';"
  run_sql(sql)
  redirect to("/videos")
end

# deleting a video

delete "/videos/:id" do
 sql = "delete from items where id=#{params[:id]}"   
 run_sql(sql) 
 if request.xhr?
    json[{status: :ok}]
 else
    redirect to ("/videos") 

 end

end
 
 # end of playing, adding and editing videos

 # using the nav bar













def run_sql(sql)
    conn = PG.connect(dbname: "me_videodb", host: "localhost")
     begin
       result = conn.exec(sql)
     ensure
       conn.close
     end
     result
end         
 
def sql_string(value)
  "'#{value.gsub("'", "''")}'"  
end 



