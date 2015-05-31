require 'sinatra'
require 'sinatra/contrib/all'
require 'pg'
require 'pry'

get '/' do 
    erb :index 
end

get '/videos' do 
     sql "SELECT * from videos"
     @videos = run_sel(sql)
     if request.xhr?
      json @videos.to_a
     else
      erb :index
     end
  end     

post '/videos'  do
    artist = params[:artist]
    title = params[:title]
    description = params[:description]
    category = params[:category]
    genre = params[:genre]
    url = params[:url]
    sql ="insert into (artist, title, description, category, genre, url, sql) values ('#{artist}', '#{title}', #{description}', '#{category}', '#{genre}', '#{url}')"
    @video = run_sql(sql).first
    if request .xhr?
       json@video
    else
       redirect_to '/videos'

    end  
end         


delete '/videos/:id' do
 sql = "delete from items where id=#{params[:id]}"   
 run_sql(sql) 
 if request.xhr?
    json[{status: :ok}]
 else
    redirect_to '/movies' 

 end

end







